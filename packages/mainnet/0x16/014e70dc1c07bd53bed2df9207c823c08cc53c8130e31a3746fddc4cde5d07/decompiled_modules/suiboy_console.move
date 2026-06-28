module 0x16014e70dc1c07bd53bed2df9207c823c08cc53c8130e31a3746fddc4cde5d07::suiboy_console {
    struct SUIBOY_CONSOLE has drop {
        dummy_field: bool,
    }

    struct SuiBoyConsole has store, key {
        id: 0x2::object::UID,
        skin: 0x1::string::String,
    }

    fun init(arg0: SUIBOY_CONSOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"SuiBoy Console"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suiboy.fun/arcade"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suiboy.fun/assets/consoles/shell.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"An empty on-chain handheld console. Insert cartridge NFTs to play."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suiboy.fun"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"SuiBoy Labs"));
        let v4 = 0x2::package::claim<SUIBOY_CONSOLE>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SuiBoyConsole>(&v4, v0, v2, arg1);
        0x2::display::update_version<SuiBoyConsole>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SuiBoyConsole>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_console(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 1000000000;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= v0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v0, arg1), @0xe1089d77e25643ea64ea003106ee093f9d066ad1579027ac8f5f2e0779e190a8);
        let v1 = 0x2::tx_context::epoch(arg1);
        let v2 = 0x2::object::new(arg1);
        0x2::object::delete(v2);
        let v3 = b"";
        0x1::vector::append<u8>(&mut v3, 0x2::address::to_bytes(0x2::tx_context::sender(arg1)));
        0x1::vector::append<u8>(&mut v3, b"epoch");
        0x1::vector::append<u8>(&mut v3, 0x1::bcs::to_bytes<u64>(&v1));
        0x1::vector::append<u8>(&mut v3, 0x2::object::uid_to_bytes(&v2));
        let v4 = 0x2::hash::keccak256(&v3);
        let v5 = vector[b"classic", b"neon", b"wojak", b"wood", b"ice"];
        let v6 = SuiBoyConsole{
            id   : 0x2::object::new(arg1),
            skin : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&v5, (*0x1::vector::borrow<u8>(&v4, 0) as u64) % 0x1::vector::length<vector<u8>>(&v5))),
        };
        0x2::transfer::public_transfer<SuiBoyConsole>(v6, 0x2::tx_context::sender(arg1));
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        };
    }

    // decompiled from Move bytecode v7
}

