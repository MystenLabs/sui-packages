module 0x9cf4dd321a1db40886be126c0201b28598b0a5182ef79f84e10daafdc5e4a729::TuYv_NFT {
    struct TuYv has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    struct TUYV_NFT has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: TuYv, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<TuYv>(arg0, arg1);
    }

    fun init(arg0: TUYV_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/22782479"));
        let v4 = 0x2::package::claim<TUYV_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<TuYv>(&v4, v0, v2, arg1);
        0x2::display::update_version<TuYv>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TuYv>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_to_sender(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TuYv{
            id   : 0x2::object::new(arg1),
            name : arg0,
        };
        0x2::transfer::public_transfer<TuYv>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

