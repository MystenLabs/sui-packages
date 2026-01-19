module 0xd62867a9635fc23cff43eb22c7c4256198524169c1ebc36d4f182e58fa75fe7e::memorial {
    struct MEMORIAL has drop {
        dummy_field: bool,
    }

    struct Counter has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct Memorial has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        date: u64,
        message: 0x1::string::String,
        creator: address,
    }

    struct MemorialMinted has copy, drop {
        object_id: 0x2::object::ID,
        recipient: address,
    }

    fun init(arg0: MEMORIAL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<MEMORIAL>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"date"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"message"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{date}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{message}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator}"));
        let v5 = 0x2::display::new_with_fields<Memorial>(&v0, v1, v3, arg1);
        0x2::display::update_version<Memorial>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Memorial>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = Counter{
            id    : 0x2::object::new(arg1),
            value : 0,
        };
        0x2::transfer::share_object<Counter>(v6);
    }

    public entry fun mint(arg0: &mut Counter, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.value < 100000, 0);
        arg0.value = arg0.value + 1;
        let v1 = 0x1::string::utf8(b"Sui 1000-day #");
        0x1::string::append(&mut v1, u64_to_string(arg0.value));
        let v2 = Memorial{
            id          : 0x2::object::new(arg1),
            name        : v1,
            description : 0x1::string::utf8(b"Sui 1000-day anniversary"),
            image_url   : 0x1::string::utf8(b"https://raw.githubusercontent.com/hoh-zone/Sui-NFT-1000/refs/heads/main/frontend/public/sui-1000-days.svg"),
            date        : 0,
            message     : 0x1::string::utf8(b"In loving memory."),
            creator     : v0,
        };
        let v3 = MemorialMinted{
            object_id : 0x2::object::id<Memorial>(&v2),
            recipient : v0,
        };
        0x2::event::emit<MemorialMinted>(v3);
        0x2::transfer::transfer<Memorial>(v2, v0);
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = b"";
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

