module 0x10ab2a6b138ae496bc18e1668ba030202b65ab1104e374ebcac24dcab1f2ad64::YJSHI2015NFT {
    struct MintEvent has copy, drop {
        nft_id: 0x2::object::ID,
        minter: address,
        name: 0x1::string::String,
    }

    struct YJSHI2015 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        img_url: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct YJSHI2015NFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: YJSHI2015NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"this is YJSHI2015NFT!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"yjshi2015"));
        let v4 = 0x2::package::claim<YJSHI2015NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<YJSHI2015>(&v4, v0, v2, arg1);
        0x2::display::update_version<YJSHI2015>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<YJSHI2015>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = YJSHI2015{
            id          : 0x2::object::new(arg2),
            name        : arg0,
            img_url     : arg1,
            description : 0x1::string::utf8(b"MY NFT"),
        };
        let v1 = MintEvent{
            nft_id : 0x2::object::id<YJSHI2015>(&v0),
            minter : 0x2::tx_context::sender(arg2),
            name   : arg0,
        };
        0x2::event::emit<MintEvent>(v1);
        0x2::transfer::public_transfer<YJSHI2015>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

