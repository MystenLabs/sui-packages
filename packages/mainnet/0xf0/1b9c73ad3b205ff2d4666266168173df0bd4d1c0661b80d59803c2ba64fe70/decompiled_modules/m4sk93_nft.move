module 0xf01b9c73ad3b205ff2d4666266168173df0bd4d1c0661b80d59803c2ba64fe70::m4sk93_nft {
    struct M4SK93_NFT has drop {
        dummy_field: bool,
    }

    struct M4SK93NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    fun init(arg0: M4SK93_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/162651341?v=4"));
        let v4 = 0x2::package::claim<M4SK93_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<M4SK93NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<M4SK93NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<M4SK93NFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_and_transfer(arg0: 0x1::string::String, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = M4SK93NFT{
            id   : 0x2::object::new(arg2),
            name : arg0,
        };
        0x2::transfer::public_transfer<M4SK93NFT>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

