module 0x34a6c8a3c37a54adf3635519faaea875e47ac8255ef695c82c863c31fb752760::nfts {
    struct Suiwin has store, key {
        id: 0x2::object::UID,
    }

    struct NFTS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: Suiwin) {
        let Suiwin { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: NFTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Welcome to SuiWin"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.suiwin.online"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://QmVBhp7vh9nLZjsPN6eJC2VBQQUAWrZEkwrGhjhWfjvbkK"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.suiwin.online"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"SUIWIN"));
        let v4 = 0x2::package::claim<NFTS>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Suiwin>(&v4, v0, v2, arg1);
        0x2::display::update_version<Suiwin>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Suiwin>>(v5, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Suiwin{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<Suiwin>(v0, arg0);
    }

    // decompiled from Move bytecode v6
}

