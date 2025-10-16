module 0x13b731a60955f83c9e592720327bf13a631daf90173adfcb02453a85289a67cc::act_airdrop_transponders {
    struct ACT_AIRDROP_TRANSPONDERS has drop {
        dummy_field: bool,
    }

    struct ACTAirdropTransponder has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        colourway: 0x1::string::String,
        rarity: 0x1::string::String,
    }

    struct ACTAirdropTransponderMintAuth has store, key {
        id: 0x2::object::UID,
        mint_count: u64,
    }

    struct ACTAirdropTransponderMintedEvent has copy, drop {
        transponder_id: 0x2::object::ID,
        transponder_owner: address,
        transponder_name: 0x1::string::String,
        transponder_colourway: 0x1::string::String,
        transponder_rarity: 0x1::string::String,
    }

    fun init(arg0: ACT_AIRDROP_TRANSPONDERS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<ACT_AIRDROP_TRANSPONDERS>(arg0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"creator"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"ACT Airdrop Transponder - {name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"ipfs://bafybeigbp4ce7czc6tub3cpwkj6fedllmfcagjineqxhcjzpddvz4n2ghq/{colourway}.png"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"A transponder for ACT Airdrops"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://actuniverse.com"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"ACT"));
        let v6 = 0x2::display::new_with_fields<ACTAirdropTransponder>(&v1, v2, v4, arg1);
        0x2::display::update_version<ACTAirdropTransponder>(&mut v6);
        0x2::transfer::public_transfer<0x2::display::Display<ACTAirdropTransponder>>(v6, v0);
        let v7 = ACTAirdropTransponderMintAuth{
            id         : 0x2::object::new(arg1),
            mint_count : 0,
        };
        0x2::transfer::public_transfer<ACTAirdropTransponderMintAuth>(v7, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
    }

    public fun mint_to_address(arg0: &mut ACTAirdropTransponderMintAuth, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ACTAirdropTransponder{
            id        : 0x2::object::new(arg5),
            name      : arg1,
            colourway : arg2,
            rarity    : arg3,
        };
        arg0.mint_count = arg0.mint_count + 1;
        let v1 = ACTAirdropTransponderMintedEvent{
            transponder_id        : 0x2::object::id<ACTAirdropTransponder>(&v0),
            transponder_owner     : arg4,
            transponder_name      : arg1,
            transponder_colourway : arg2,
            transponder_rarity    : arg3,
        };
        0x2::event::emit<ACTAirdropTransponderMintedEvent>(v1);
        0x2::transfer::public_transfer<ACTAirdropTransponder>(v0, arg4);
    }

    public fun mutate_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::display::Display<ACTAirdropTransponder>) {
        assert!(0x2::package::from_package<ACTAirdropTransponder>(arg0), 0);
        0x2::display::edit<ACTAirdropTransponder>(arg3, arg1, arg2);
        0x2::display::update_version<ACTAirdropTransponder>(arg3);
    }

    // decompiled from Move bytecode v6
}

