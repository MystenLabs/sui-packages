module 0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::getters {
    public fun blob_funds_value(arg0: &0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::MemeNFT) : u64 {
        0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::blob_funds_value(arg0)
    }

    public fun created_at(arg0: &0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::MemeNFT) : u64 {
        0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::created_at(arg0)
    }

    public fun description(arg0: &0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::MemeNFT) : 0x1::string::String {
        0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::description(arg0)
    }

    public fun get_hierarchy_info(arg0: &0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::MemeNFT) : (&vector<0x2::object::ID>, u64) {
        let v0 = 0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::parent_hierarchy(arg0);
        (v0, 0x1::vector::length<0x2::object::ID>(v0) + 1)
    }

    public fun get_meme_info(arg0: &0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::MemeNFT) : (0x1::string::String, 0x1::string::String, 0x1::string::String, u64, u64) {
        (0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::title(arg0), 0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::description(arg0), 0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::image_url(arg0), 0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::likes(arg0), 0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::created_at(arg0))
    }

    public fun get_walrus_info(arg0: &0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::MemeNFT) : (0x1::string::String, 0x1::string::String, u64) {
        (0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::walrus_file_id(arg0), 0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::walrus_blob_id(arg0), 0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::blob_funds_value(arg0))
    }

    public fun hierarchy_depth(arg0: &0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::MemeNFT) : u64 {
        0x1::vector::length<0x2::object::ID>(0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::parent_hierarchy(arg0)) + 1
    }

    public fun image_url(arg0: &0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::MemeNFT) : 0x1::string::String {
        0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::image_url(arg0)
    }

    public fun is_liked_by(arg0: &0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::MemeNFT, arg1: address) : bool {
        0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::is_liked_by(arg0, arg1)
    }

    public fun likes(arg0: &0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::MemeNFT) : u64 {
        0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::likes(arg0)
    }

    public fun parent_hierarchy(arg0: &0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::MemeNFT) : &vector<0x2::object::ID> {
        0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::parent_hierarchy(arg0)
    }

    public fun title(arg0: &0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::MemeNFT) : 0x1::string::String {
        0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::title(arg0)
    }

    public fun walrus_blob_id(arg0: &0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::MemeNFT) : 0x1::string::String {
        0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::walrus_blob_id(arg0)
    }

    public fun walrus_file_id(arg0: &0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::MemeNFT) : 0x1::string::String {
        0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::walrus_file_id(arg0)
    }

    // decompiled from Move bytecode v6
}

