module 0xaf59474bc45c7712f35148aa429c52f3f07ca4e35286878cd807b336a9c6d48b::display {
    struct DISPLAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DISPLAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<DISPLAY>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"media_type"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"file_hash"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"walrus_blob_id"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/{quilt_patch_id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://walrus-nft-media-vault.vercel.app/nft/{id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://walrus-nft-media-vault.vercel.app"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{media_type}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{file_hash}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_blob_id}"));
        let v5 = 0x2::display::new_with_fields<0xaf59474bc45c7712f35148aa429c52f3f07ca4e35286878cd807b336a9c6d48b::nft::NFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<0xaf59474bc45c7712f35148aa429c52f3f07ca4e35286878cd807b336a9c6d48b::nft::NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0xaf59474bc45c7712f35148aa429c52f3f07ca4e35286878cd807b336a9c6d48b::nft::NFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

