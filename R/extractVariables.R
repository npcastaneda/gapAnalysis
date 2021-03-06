##################################################
## Extract bioclim variables and save as tif    ##
## Author: N. Castaneda                         ##
## Date: 2012-07-09                             ##
##################################################

maskVariables <- function(crop_dir, env_dir, eco_dir){
  
  out_dir <- paste(crop_dir,"/biomod_modeling/current-clim",sep="")
  if (!file.exists(out_dir)) {dir.create(out_dir)}
  
  msk <- raster(paste(crop_dir,"/masks/mask.tif",sep=""))
  e <- extent(msk)
  
  for(i in 1:19){
    cat("Reading environmental layer", i, "\n")
    rs <- raster(paste(env_dir, "/bio_", i, ".tif",sep=""))
    rs <- crop(rs,e)
    writeRaster(rs, paste(out_dir,"/bio_",i,".tif",sep=""), overwrite=T)    
  }
  # crop pca_reclass files
  for(i in 1:2){
    cat("Reading pca reclass",i,"\n")
    rs <- raster(paste(env_dir,"/pca_result_raw/pc_",i,".tif",sep=""))
    rs <- crop(rs,e)
    
    out_dir_pca <- paste(out_dir,"/pca_result_raw",sep="")
    if (!file.exists(out_dir_pca)) {dir.create(out_dir_pca)}
    
    writeRaster(rs,paste(out_dir_pca, "/pc_",i,".tif",sep=""), overwrite=T)
  }
  # wwf terrestrial ecosystems
  rs <- raster(paste(eco_dir,"/wwf_eco_terr.tif", sep=""))
  
  msk <- raster(paste(crop_dir,"/masks/mask.tif",sep=""))
  e <- extent(msk)
  
  rs <- crop(rs,e)
  
  out_dir_wwf <- paste(out_dir,"/wwf_eco",sep="")
  if (!file.exists(out_dir_wwf)) {dir.create(out_dir_wwf)}
  
  writeRaster (rs,paste(out_dir_wwf, "/wwf_eco_terr.tif", sep=""), overwrite=T)
}
