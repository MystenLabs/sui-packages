module 0xdceb45ef40eb558e108d77c50f47ea908a2ce1a9b516dde86d0b0da464bb3c80::bucket_okx_poap {
    struct BUCKET_OKX_POAP has drop {
        dummy_field: bool,
    }

    struct BucketOkxPOAP has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: BUCKET_OKX_POAP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"POAP - Bucket x OKX"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs.io/ipfs/QmTUeoEg4gPVBoG7Nwr9fBDfQLxARCaHAMW87DnBuNjJpd"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A special gift for those who used OKX wallet to interact with Bucket Protocol"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://app.bucketprotocol.io/okx-campaign"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Bucket Protocol"));
        let v4 = 0x2::package::claim<BUCKET_OKX_POAP>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<BucketOkxPOAP>(&v4, v0, v2, arg1);
        0x2::display::update_version<BucketOkxPOAP>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v6);
        0x2::transfer::public_transfer<0x2::display::Display<BucketOkxPOAP>>(v5, v6);
    }

    public fun mint(arg0: 0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        assert!(0x2::coin::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&arg0) == 628, 0);
        0x2::dynamic_object_field::add<0x1::string::String, 0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(&mut v0, 0x1::string::utf8(b"Commemorative BUCK"), arg0);
        let v1 = BucketOkxPOAP{id: v0};
        0x2::transfer::transfer<BucketOkxPOAP>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

