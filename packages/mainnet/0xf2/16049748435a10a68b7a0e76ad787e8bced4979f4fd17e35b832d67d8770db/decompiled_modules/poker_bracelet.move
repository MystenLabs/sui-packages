module 0xf216049748435a10a68b7a0e76ad787e8bced4979f4fd17e35b832d67d8770db::poker_bracelet {
    struct POKER_BRACELET has drop {
        dummy_field: bool,
    }

    struct PokerBracelet has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        creator: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: POKER_BRACELET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<POKER_BRACELET>(arg0, arg1);
        let v1 = 0x2::display::new<PokerBracelet>(&v0, arg1);
        0x2::display::add<PokerBracelet>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<PokerBracelet>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<PokerBracelet>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<PokerBracelet>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"{creator}"));
        0x2::display::add<PokerBracelet>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"Sui Lords Poker Bracelet"));
        0x2::display::add<PokerBracelet>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://suilords.com"));
        0x2::display::update_version<PokerBracelet>(&mut v1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v2);
        0x2::transfer::public_transfer<0x2::display::Display<PokerBracelet>>(v1, v2);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, v2);
    }

    public fun mint_to(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<u8>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = PokerBracelet{
            id          : 0x2::object::new(arg5),
            name        : arg1,
            description : arg2,
            image_url   : 0x2::url::new_unsafe_from_bytes(arg3),
            creator     : 0x2::tx_context::sender(arg5),
        };
        0x2::transfer::public_transfer<PokerBracelet>(v0, arg4);
    }

    // decompiled from Move bytecode v6
}

