module 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::getters {
    public fun blob_funds_value(arg0: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT) : u64 {
        0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob_funds_value(arg0)
    }

    public fun created_at(arg0: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT) : u64 {
        0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::created_at(arg0)
    }

    public fun description(arg0: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT) : 0x1::string::String {
        0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::description(arg0)
    }

    public fun get_hierarchy_info(arg0: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT) : (&vector<0x2::object::ID>, u64) {
        let v0 = 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::parent_hierarchy(arg0);
        (v0, 0x1::vector::length<0x2::object::ID>(v0) + 1)
    }

    public fun get_meme_info(arg0: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT) : (0x1::string::String, 0x1::string::String, 0x1::string::String, u64, u64) {
        (0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::title(arg0), 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::description(arg0), 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::image_url(arg0), 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::likes(arg0), 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::created_at(arg0))
    }

    public fun get_walrus_info(arg0: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT) : (0x1::string::String, 0x1::string::String, u64) {
        (0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::walrus_file_id(arg0), 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::walrus_blob_id(arg0), 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob_funds_value(arg0))
    }

    public fun hierarchy_depth(arg0: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT) : u64 {
        0x1::vector::length<0x2::object::ID>(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::parent_hierarchy(arg0)) + 1
    }

    public fun image_url(arg0: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT) : 0x1::string::String {
        0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::image_url(arg0)
    }

    public fun is_liked_by(arg0: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg1: address) : bool {
        0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::is_liked_by(arg0, arg1)
    }

    public fun likes(arg0: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT) : u64 {
        0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::likes(arg0)
    }

    public fun parent_hierarchy(arg0: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT) : &vector<0x2::object::ID> {
        0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::parent_hierarchy(arg0)
    }

    public fun title(arg0: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT) : 0x1::string::String {
        0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::title(arg0)
    }

    public fun walrus_blob_id(arg0: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT) : 0x1::string::String {
        0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::walrus_blob_id(arg0)
    }

    public fun walrus_file_id(arg0: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT) : 0x1::string::String {
        0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::walrus_file_id(arg0)
    }

    // decompiled from Move bytecode v6
}

