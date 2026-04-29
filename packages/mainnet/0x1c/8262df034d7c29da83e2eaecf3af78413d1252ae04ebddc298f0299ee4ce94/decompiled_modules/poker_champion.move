module 0x1c8262df034d7c29da83e2eaecf3af78413d1252ae04ebddc298f0299ee4ce94::poker_champion {
    struct POKER_CHAMPION has drop {
        dummy_field: bool,
    }

    struct PokerChampion has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        creator: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: POKER_CHAMPION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<POKER_CHAMPION>(arg0, arg1);
        let v1 = 0x2::display::new<PokerChampion>(&v0, arg1);
        0x2::display::add<PokerChampion>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<PokerChampion>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<PokerChampion>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<PokerChampion>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"{creator}"));
        0x2::display::add<PokerChampion>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"Sui Lords Poker Champions Ring"));
        0x2::display::add<PokerChampion>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://suilords.com"));
        0x2::display::update_version<PokerChampion>(&mut v1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v2);
        0x2::transfer::public_transfer<0x2::display::Display<PokerChampion>>(v1, v2);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, v2);
    }

    public fun mint_to(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<u8>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = PokerChampion{
            id          : 0x2::object::new(arg5),
            name        : arg1,
            description : arg2,
            image_url   : 0x2::url::new_unsafe_from_bytes(arg3),
            creator     : 0x2::tx_context::sender(arg5),
        };
        0x2::transfer::public_transfer<PokerChampion>(v0, arg4);
    }

    // decompiled from Move bytecode v6
}

