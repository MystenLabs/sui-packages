module 0x90cfbe3f5ac2706d44175d12925d890073c7c1812a1cc82dee24f5389b2dc2bc::pact_game_nft {
    struct PACT_GAME_NFT has drop {
        dummy_field: bool,
    }

    struct GameNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        rarity: 0x1::string::String,
        level: 0x1::string::String,
        class: 0x1::string::String,
        faction: 0x1::string::String,
        power: 0x1::string::String,
        speed: 0x1::string::String,
        element: 0x1::string::String,
        weapon: 0x1::string::String,
        season: 0x1::string::String,
        edition: 0x1::string::String,
    }

    struct GameNFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        name: 0x1::string::String,
        rarity: 0x1::string::String,
    }

    fun init(arg0: PACT_GAME_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<PACT_GAME_NFT>(arg0, arg1);
        let v1 = 0x2::display::new<GameNFT>(&v0, arg1);
        0x2::display::add<GameNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<GameNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<GameNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<GameNFT>(&mut v1, 0x1::string::utf8(b"thumbnail_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<GameNFT>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://arweave.net"));
        0x2::display::add<GameNFT>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Pactify"));
        0x2::display::add<GameNFT>(&mut v1, 0x1::string::utf8(b"Rarity"), 0x1::string::utf8(b"{rarity}"));
        0x2::display::add<GameNFT>(&mut v1, 0x1::string::utf8(b"Level"), 0x1::string::utf8(b"{level}"));
        0x2::display::add<GameNFT>(&mut v1, 0x1::string::utf8(b"Class"), 0x1::string::utf8(b"{class}"));
        0x2::display::add<GameNFT>(&mut v1, 0x1::string::utf8(b"Faction"), 0x1::string::utf8(b"{faction}"));
        0x2::display::add<GameNFT>(&mut v1, 0x1::string::utf8(b"Power"), 0x1::string::utf8(b"{power}"));
        0x2::display::add<GameNFT>(&mut v1, 0x1::string::utf8(b"Speed"), 0x1::string::utf8(b"{speed}"));
        0x2::display::add<GameNFT>(&mut v1, 0x1::string::utf8(b"Element"), 0x1::string::utf8(b"{element}"));
        0x2::display::add<GameNFT>(&mut v1, 0x1::string::utf8(b"Weapon"), 0x1::string::utf8(b"{weapon}"));
        0x2::display::add<GameNFT>(&mut v1, 0x1::string::utf8(b"Season"), 0x1::string::utf8(b"{season}"));
        0x2::display::add<GameNFT>(&mut v1, 0x1::string::utf8(b"Edition"), 0x1::string::utf8(b"{edition}"));
        0x2::display::update_version<GameNFT>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<GameNFT>(&v0, arg1);
        let v4 = v3;
        let v5 = v2;
        0x90cfbe3f5ac2706d44175d12925d890073c7c1812a1cc82dee24f5389b2dc2bc::royalty_rule::add<GameNFT>(&mut v5, &v4, 200);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<GameNFT>>(v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v6);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<GameNFT>>(v4, v6);
        0x2::transfer::public_transfer<0x2::display::Display<GameNFT>>(v1, v6);
    }

    public fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<u8>, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = GameNFT{
            id          : 0x2::object::new(arg13),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            rarity      : 0x1::string::utf8(arg3),
            level       : 0x1::string::utf8(arg4),
            class       : 0x1::string::utf8(arg5),
            faction     : 0x1::string::utf8(arg6),
            power       : 0x1::string::utf8(arg7),
            speed       : 0x1::string::utf8(arg8),
            element     : 0x1::string::utf8(arg9),
            weapon      : 0x1::string::utf8(arg10),
            season      : 0x1::string::utf8(arg11),
            edition     : 0x1::string::utf8(arg12),
        };
        let v1 = GameNFTMinted{
            object_id : 0x2::object::id<GameNFT>(&v0),
            name      : v0.name,
            rarity    : v0.rarity,
        };
        0x2::event::emit<GameNFTMinted>(v1);
        0x2::transfer::public_transfer<GameNFT>(v0, 0x2::tx_context::sender(arg13));
    }

    // decompiled from Move bytecode v7
}

