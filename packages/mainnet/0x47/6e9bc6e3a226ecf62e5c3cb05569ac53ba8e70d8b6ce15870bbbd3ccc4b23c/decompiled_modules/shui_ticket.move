module 0x476e9bc6e3a226ecf62e5c3cb05569ac53ba8e70d8b6ce15870bbbd3ccc4b23c::shui_ticket {
    struct SHUI_TICKET has drop {
        dummy_field: bool,
    }

    struct ShuiTicket50 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        amount: u64,
    }

    struct ShuiTicket100 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        amount: u64,
    }

    struct ShuiTicket500 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        amount: u64,
    }

    struct ShuiTicket1000 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        amount: u64,
    }

    struct ShuiTicket5000 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        amount: u64,
    }

    fun init(arg0: SHUI_TICKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"metagame shui ticket, it can be used to swap shui token"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://shui.game"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://bafybeicis764zsykvopcqtcqytsfz74ai3mwna33xi7qqh74z2f2osyyba.ipfs.nftstorage.link/st50.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://shui.game/game/#/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"metaGame"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"metagame shui ticket, it can be used to swap shui token"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://shui.game"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://bafybeicis764zsykvopcqtcqytsfz74ai3mwna33xi7qqh74z2f2osyyba.ipfs.nftstorage.link/st100.png"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://shui.game/game/#/"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"metaGame"));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"metagame shui ticket, it can be used to swap shui token"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://shui.game"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://bafybeicis764zsykvopcqtcqytsfz74ai3mwna33xi7qqh74z2f2osyyba.ipfs.nftstorage.link/st500.png"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://shui.game/game/#/"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"metaGame"));
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"metagame shui ticket, it can be used to swap shui token"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"https://shui.game"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"https://bafybeicis764zsykvopcqtcqytsfz74ai3mwna33xi7qqh74z2f2osyyba.ipfs.nftstorage.link/st1000.png"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"https://shui.game/game/#/"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"metaGame"));
        let v10 = 0x1::vector::empty<0x1::string::String>();
        let v11 = &mut v10;
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"metagame shui ticket, it can be used to swap shui token"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"https://shui.game"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"https://bafybeicis764zsykvopcqtcqytsfz74ai3mwna33xi7qqh74z2f2osyyba.ipfs.nftstorage.link/st5000.png"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"https://shui.game/game/#/"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"metaGame"));
        let v12 = 0x2::package::claim<SHUI_TICKET>(arg0, arg1);
        let v13 = 0x2::display::new_with_fields<ShuiTicket50>(&v12, v0, v2, arg1);
        0x2::display::update_version<ShuiTicket50>(&mut v13);
        0x2::transfer::public_transfer<0x2::display::Display<ShuiTicket50>>(v13, 0x2::tx_context::sender(arg1));
        let v14 = 0x2::display::new_with_fields<ShuiTicket100>(&v12, v0, v4, arg1);
        0x2::display::update_version<ShuiTicket100>(&mut v14);
        0x2::transfer::public_transfer<0x2::display::Display<ShuiTicket100>>(v14, 0x2::tx_context::sender(arg1));
        let v15 = 0x2::display::new_with_fields<ShuiTicket500>(&v12, v0, v6, arg1);
        0x2::display::update_version<ShuiTicket500>(&mut v15);
        0x2::transfer::public_transfer<0x2::display::Display<ShuiTicket500>>(v15, 0x2::tx_context::sender(arg1));
        let v16 = 0x2::display::new_with_fields<ShuiTicket1000>(&v12, v0, v8, arg1);
        0x2::display::update_version<ShuiTicket1000>(&mut v16);
        0x2::transfer::public_transfer<0x2::display::Display<ShuiTicket1000>>(v16, 0x2::tx_context::sender(arg1));
        let v17 = 0x2::display::new_with_fields<ShuiTicket5000>(&v12, v0, v10, arg1);
        0x2::display::update_version<ShuiTicket5000>(&mut v17);
        0x2::transfer::public_transfer<0x2::display::Display<ShuiTicket5000>>(v17, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v12, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        if (arg0 == 50) {
            let v0 = ShuiTicket50{
                id     : 0x2::object::new(arg1),
                name   : 0x1::string::utf8(b"SHUI50"),
                amount : arg0,
            };
            0x2::transfer::public_transfer<ShuiTicket50>(v0, 0x2::tx_context::sender(arg1));
        } else if (arg0 == 100) {
            let v1 = ShuiTicket100{
                id     : 0x2::object::new(arg1),
                name   : 0x1::string::utf8(b"SHUI100"),
                amount : arg0,
            };
            0x2::transfer::public_transfer<ShuiTicket100>(v1, 0x2::tx_context::sender(arg1));
        } else if (arg0 == 500) {
            let v2 = ShuiTicket500{
                id     : 0x2::object::new(arg1),
                name   : 0x1::string::utf8(b"SHUI500"),
                amount : arg0,
            };
            0x2::transfer::public_transfer<ShuiTicket500>(v2, 0x2::tx_context::sender(arg1));
        } else if (arg0 == 1000) {
            let v3 = ShuiTicket1000{
                id     : 0x2::object::new(arg1),
                name   : 0x1::string::utf8(b"SHUI1000"),
                amount : arg0,
            };
            0x2::transfer::public_transfer<ShuiTicket1000>(v3, 0x2::tx_context::sender(arg1));
        } else if (arg0 == 5000) {
            let v4 = ShuiTicket5000{
                id     : 0x2::object::new(arg1),
                name   : 0x1::string::utf8(b"SHUI5000"),
                amount : arg0,
            };
            0x2::transfer::public_transfer<ShuiTicket5000>(v4, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

