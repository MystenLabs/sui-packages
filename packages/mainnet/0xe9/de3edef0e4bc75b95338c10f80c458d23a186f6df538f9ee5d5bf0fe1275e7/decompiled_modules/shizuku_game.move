module 0xdf1b630408686cd52af72b23a331930066f87e86509e70f6193caa77424f74e8::shizuku_game {
    struct SHIZUKU_GAME has drop {
        dummy_field: bool,
    }

    struct ShizukuNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PublishedNFTData has key {
        id: 0x2::object::UID,
        nft_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    fun init(arg0: SHIZUKU_GAME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        let v4 = 0x2::package::claim<SHIZUKU_GAME>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<ShizukuNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<ShizukuNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<ShizukuNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
        let v7 = PublishedNFTData{
            id      : 0x2::object::new(arg1),
            nft_ids : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<PublishedNFTData>(v7);
    }

    public fun purchase_nft(arg0: &mut PublishedNFTData, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 1000000000, 1);
        let v0 = ShizukuNFT{
            id          : 0x2::object::new(arg5),
            name        : arg2,
            description : arg3,
            image_url   : arg4,
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.nft_ids, 0x2::object::id<ShizukuNFT>(&v0));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, @0xea44812465a6e45cdb6b8fcbdf1da2a7cca545912bbc7d196c8db2b92bd8a66);
        0x2::transfer::transfer<ShizukuNFT>(v0, 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

