module 0x3bf4b99ed82b9a2b5c84ed4b4bd8b8d308fd0f54937d6612f5f2a5a556c0adce::kyrincode_nft {
    struct KYRINCODE_NFT has drop {
        dummy_field: bool,
    }

    struct KyrinCodeNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    struct Minted has copy, drop {
        object_id: 0x2::object::ID,
        minter: address,
        name: 0x1::string::String,
    }

    struct Transferred has copy, drop {
        object_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    public fun transfer(arg0: KyrinCodeNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Transferred{
            object_id : 0x2::object::id<KyrinCodeNFT>(&arg0),
            from      : 0x2::tx_context::sender(arg2),
            to        : arg1,
        };
        0x2::event::emit<Transferred>(v0);
        0x2::transfer::public_transfer<KyrinCodeNFT>(arg0, arg1);
    }

    fun init(arg0: KYRINCODE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"KyrinCode NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/30864546?s=40&v=4"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"KyrinCode NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{tx_context::sender(ctx)}"));
        let v4 = 0x2::package::claim<KYRINCODE_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<KyrinCodeNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<KyrinCodeNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<KyrinCodeNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = KyrinCodeNFT{
            id   : 0x2::object::new(arg1),
            name : arg0,
        };
        let v1 = Minted{
            object_id : 0x2::object::id<KyrinCodeNFT>(&v0),
            minter    : 0x2::tx_context::sender(arg1),
            name      : v0.name,
        };
        0x2::event::emit<Minted>(v1);
        0x2::transfer::public_transfer<KyrinCodeNFT>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

