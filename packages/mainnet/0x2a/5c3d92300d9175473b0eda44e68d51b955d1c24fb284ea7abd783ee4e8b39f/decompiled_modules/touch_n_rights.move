module 0x2a5c3d92300d9175473b0eda44e68d51b955d1c24fb284ea7abd783ee4e8b39f::touch_n_rights {
    struct TouchLevelTransferred has copy, drop {
        to: address,
    }

    struct TOUCH_N_RIGHTS has drop {
        dummy_field: bool,
    }

    struct TouchLevel has store, key {
        id: 0x2::object::UID,
        personality: 0x1::string::String,
        level: u64,
        imid: u64,
    }

    entry fun delete(arg0: TouchLevel) {
        let TouchLevel {
            id          : v0,
            personality : _,
            level       : _,
            imid        : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: TOUCH_N_RIGHTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TOUCH_N_RIGHTS>(arg0, arg1);
        let v1 = 0x2::display::new<TouchLevel>(&v0, arg1);
        0x2::display::add<TouchLevel>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{personality} (lvl. {level})"));
        0x2::display::add<TouchLevel>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Show your honor level and enjoy more rights"));
        0x2::display::add<TouchLevel>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://ipfs.io/ipfs/QmQRLBgxxNaPhTzExFFqgPc7wJNRbRprfu8pJC1XG4NEGd/{imid}.gif"));
        0x2::display::update_version<TouchLevel>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TouchLevel>>(v1, 0x2::tx_context::sender(arg1));
    }

    entry fun mint_to(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<TOUCH_N_RIGHTS>(arg0), 0);
        let v0 = TouchLevel{
            id          : 0x2::object::new(arg5),
            personality : arg1,
            level       : arg2,
            imid        : arg3,
        };
        0x2::transfer::public_transfer<TouchLevel>(v0, arg4);
        let v1 = TouchLevelTransferred{to: arg4};
        0x2::event::emit<TouchLevelTransferred>(v1);
    }

    // decompiled from Move bytecode v6
}

