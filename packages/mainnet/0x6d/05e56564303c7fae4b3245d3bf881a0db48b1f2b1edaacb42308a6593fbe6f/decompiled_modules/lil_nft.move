module 0x6d05e56564303c7fae4b3245d3bf881a0db48b1f2b1edaacb42308a6593fbe6f::lil_nft {
    struct LIL_NFT has drop {
        dummy_field: bool,
    }

    struct LilNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun burn(arg0: LilNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let LilNFT {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: LIL_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<LIL_NFT>(arg0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"creator"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://lilnft.com"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Lil Creator"));
        let v6 = 0x2::display::new_with_fields<LilNFT>(&v1, v2, v4, arg1);
        0x2::display::update_version<LilNFT>(&mut v6);
        let (v7, v8) = 0x2::transfer_policy::new<LilNFT>(&v1, arg1);
        let v9 = v8;
        let v10 = v7;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<LilNFT>(&mut v10, &v9, 500, 0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<LilNFT>(&mut v10, &v9);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<LilNFT>>(v10);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<LilNFT>>(v9, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_transfer<0x2::display::Display<LilNFT>>(v6, v0);
        let v11 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v11, v0);
    }

    public entry fun mint(arg0: &AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = LilNFT{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg3),
        };
        0x2::transfer::public_transfer<LilNFT>(v0, arg4);
    }

    // decompiled from Move bytecode v6
}

