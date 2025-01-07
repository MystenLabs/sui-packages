module 0x64c7df7f8f7285736514839025c2d6ce2d2c31f62670c69c7b51031176332fa8::my_hero {
    struct Hero has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    struct MY_HERO has drop {
        dummy_field: bool,
    }

    public fun admin(arg0: &mut 0x2::tx_context::TxContext, arg1: u64, arg2: u64) {
        assert!(@0xfab5b29ad356b38284ef90663493d9bf689150c079a06f0a21088eaa22cd362b == 0x2::tx_context::sender(arg0), 0);
        while (arg1 < arg2 + arg1) {
            let v0 = Hero{
                id   : 0x2::object::new(arg0),
                name : to_string(arg1),
            };
            0x2::transfer::public_transfer<Hero>(v0, 0x2::tx_context::sender(arg0));
            arg1 = arg1 + 1;
        };
    }

    public entry fun admin1(arg0: &mut 0x2::tx_context::TxContext) {
        admin(arg0, 0, 10);
    }

    fun init(arg0: MY_HERO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"#{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs.io/ipfs/QmUNLLsPACCz1vLxQVkXqqLX5R1X345qqfHbsf67hvA3Nn/{name}.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ipfs.io/ipfs/QmUNLLsPACCz1vLxQVkXqqLX5R1X345qqfHbsf67hvA3Nn/{name}.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A true Hero of the Sui ecosystem!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Unknown Sui Fan"));
        let v4 = 0x2::package::claim<MY_HERO>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Hero>(&v4, v0, v2, arg1);
        0x2::display::update_version<Hero>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Hero>>(v5, 0x2::tx_context::sender(arg1));
    }

    fun to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 != 0) {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

