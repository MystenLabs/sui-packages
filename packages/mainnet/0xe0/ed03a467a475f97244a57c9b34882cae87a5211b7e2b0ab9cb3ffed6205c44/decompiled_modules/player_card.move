module 0xe0ed03a467a475f97244a57c9b34882cae87a5211b7e2b0ab9cb3ffed6205c44::player_card {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintRegistry has key {
        id: 0x2::object::UID,
        minted_per_player: 0x2::table::Table<u64, u64>,
        total_minted: u64,
    }

    struct PlayerCard has store, key {
        id: 0x2::object::UID,
        player_id: u64,
        name: 0x1::string::String,
        team: 0x1::string::String,
        nation: 0x1::string::String,
        position: 0x1::string::String,
        image_url: 0x1::string::String,
        goals: u64,
        assists: u64,
        flops: u64,
        clean_sheets: u64,
        yellow_cards: u64,
        red_cards: u64,
        score: u64,
        stage_reached: u8,
        is_alive: bool,
        mint_price: u64,
        current_value: u64,
        rarity: u8,
        minted_at: u64,
    }

    struct CardMinted has copy, drop {
        card_id: 0x2::object::ID,
        player_id: u64,
        recipient: address,
        price: u64,
        rarity: u8,
    }

    struct StatsUpdated has copy, drop {
        card_id: 0x2::object::ID,
        score: u64,
        rarity: u8,
    }

    struct CardFrozen has copy, drop {
        card_id: 0x2::object::ID,
    }

    public fun calculate_price(arg0: u64, arg1: u64, arg2: u64, arg3: u8) : u64 {
        let v0 = if (arg0 >= 1500) {
            5000
        } else if (arg0 >= 1300) {
            3000
        } else if (arg0 >= 1100) {
            2000
        } else if (arg0 >= 1000) {
            1000
        } else {
            500
        };
        let v1 = if (arg2 > 0) {
            1000 + arg1 * 2000 / arg2
        } else {
            1000
        };
        let v2 = if (arg3 == 5) {
            10000
        } else if (arg3 == 4) {
            6000
        } else if (arg3 == 3) {
            4000
        } else if (arg3 == 2) {
            2500
        } else if (arg3 == 1) {
            1500
        } else {
            1000
        };
        5000000 * v0 / 1000 * v1 / 1000 * v2 / 1000
    }

    public fun calculate_rarity(arg0: u64) : u8 {
        if (arg0 > 1500) {
            3
        } else if (arg0 >= 1300) {
            2
        } else if (arg0 >= 1100) {
            1
        } else {
            0
        }
    }

    public fun calculate_score(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let v0 = 1000 + arg0 * 100 + arg1 * 60 + arg3 * 50;
        let v1 = arg2 * 30 + arg5 * 80 + arg4 * 10;
        if (v0 > v1) {
            v0 - v1
        } else {
            0
        }
    }

    public(friend) fun create_card(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u8, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : PlayerCard {
        let v0 = calculate_score(arg6, arg7, arg8, arg9, arg10, arg11);
        PlayerCard{
            id            : 0x2::object::new(arg15),
            player_id     : arg0,
            name          : arg1,
            team          : arg2,
            nation        : arg3,
            position      : arg4,
            image_url     : arg5,
            goals         : arg6,
            assists       : arg7,
            flops         : arg8,
            clean_sheets  : arg9,
            yellow_cards  : arg10,
            red_cards     : arg11,
            score         : v0,
            stage_reached : arg12,
            is_alive      : true,
            mint_price    : arg13,
            current_value : arg13,
            rarity        : calculate_rarity(v0),
            minted_at     : 0x2::clock::timestamp_ms(arg14),
        }
    }

    public fun current_value(arg0: &PlayerCard) : u64 {
        arg0.current_value
    }

    public fun freeze_card(arg0: &AdminCap, arg1: &mut PlayerCard) {
        assert!(arg1.is_alive, 2);
        arg1.is_alive = false;
        let v0 = CardFrozen{card_id: 0x2::object::id<PlayerCard>(arg1)};
        0x2::event::emit<CardFrozen>(v0);
    }

    public fun goals(arg0: &PlayerCard) : u64 {
        arg0.goals
    }

    public(friend) fun increment_registry(arg0: &mut MintRegistry, arg1: u64) {
        assert!(minted_count(arg0, arg1) < 40, 3);
        if (0x2::table::contains<u64, u64>(&arg0.minted_per_player, arg1)) {
            *0x2::table::borrow_mut<u64, u64>(&mut arg0.minted_per_player, arg1) = *0x2::table::borrow<u64, u64>(&arg0.minted_per_player, arg1) + 1;
        } else {
            0x2::table::add<u64, u64>(&mut arg0.minted_per_player, arg1, 1);
        };
        arg0.total_minted = arg0.total_minted + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = MintRegistry{
            id                : 0x2::object::new(arg0),
            minted_per_player : 0x2::table::new<u64, u64>(arg0),
            total_minted      : 0,
        };
        0x2::transfer::share_object<MintRegistry>(v1);
    }

    public fun is_alive(arg0: &PlayerCard) : bool {
        arg0.is_alive
    }

    public fun mint(arg0: &AdminCap, arg1: &mut MintRegistry, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u8, arg15: u64, arg16: address, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        increment_registry(arg1, arg2);
        let v0 = create_card(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg17, arg18);
        let v1 = CardMinted{
            card_id   : 0x2::object::id<PlayerCard>(&v0),
            player_id : arg2,
            recipient : arg16,
            price     : arg15,
            rarity    : v0.rarity,
        };
        0x2::event::emit<CardMinted>(v1);
        0x2::transfer::public_transfer<PlayerCard>(v0, arg16);
    }

    public fun mint_price(arg0: &PlayerCard) : u64 {
        arg0.mint_price
    }

    public fun minted_at(arg0: &PlayerCard) : u64 {
        arg0.minted_at
    }

    public fun minted_count(arg0: &MintRegistry, arg1: u64) : u64 {
        if (0x2::table::contains<u64, u64>(&arg0.minted_per_player, arg1)) {
            *0x2::table::borrow<u64, u64>(&arg0.minted_per_player, arg1)
        } else {
            0
        }
    }

    public fun player_id(arg0: &PlayerCard) : u64 {
        arg0.player_id
    }

    public fun rarity(arg0: &PlayerCard) : u8 {
        arg0.rarity
    }

    public fun render_svg(arg0: &PlayerCard) : 0x1::string::String {
        let v0 = if (arg0.rarity == 3) {
            b"#FFD700"
        } else if (arg0.rarity == 2) {
            b"#9B59B6"
        } else if (arg0.rarity == 1) {
            b"#3498DB"
        } else {
            b"#95A5A6"
        };
        let v1 = if (arg0.stage_reached == 5) {
            b"CHAMPION"
        } else if (arg0.stage_reached == 4) {
            b"FINAL"
        } else if (arg0.stage_reached == 3) {
            b"SEMI-FINAL"
        } else if (arg0.stage_reached == 2) {
            b"QUARTER-FINAL"
        } else if (arg0.stage_reached == 1) {
            b"ROUND OF 16"
        } else {
            b"GROUP STAGE"
        };
        let v2 = if (arg0.rarity == 3) {
            b"LEGEND"
        } else if (arg0.rarity == 2) {
            b"ELITE"
        } else if (arg0.rarity == 1) {
            b"RARE"
        } else {
            b"COMMON"
        };
        let v3 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v3, b"<svg xmlns='http://www.w3.org/2000/svg' width='300' height='440'>");
        0x1::vector::append<u8>(&mut v3, b"<rect width='300' height='440' rx='16' fill='#0d0d1a'/>");
        0x1::vector::append<u8>(&mut v3, b"<rect x='3' y='3' width='294' height='434' rx='14' fill='none' stroke='");
        0x1::vector::append<u8>(&mut v3, v0);
        0x1::vector::append<u8>(&mut v3, b"' stroke-width='5'/>");
        0x1::vector::append<u8>(&mut v3, b"<image href='");
        0x1::vector::append<u8>(&mut v3, *0x1::string::bytes(&arg0.image_url));
        0x1::vector::append<u8>(&mut v3, b"' x='75' y='20' width='150' height='160' style='clip-path:circle(75px at 75px 80px)'/>");
        0x1::vector::append<u8>(&mut v3, b"<text x='150' y='196' text-anchor='middle' fill='");
        0x1::vector::append<u8>(&mut v3, v0);
        0x1::vector::append<u8>(&mut v3, b"' font-size='10' font-family='monospace' letter-spacing='3'>");
        0x1::vector::append<u8>(&mut v3, v2);
        0x1::vector::append<u8>(&mut v3, b"</text>");
        0x1::vector::append<u8>(&mut v3, b"<text x='150' y='216' text-anchor='middle' fill='white' font-size='17' font-weight='bold' font-family='Arial'>");
        0x1::vector::append<u8>(&mut v3, *0x1::string::bytes(&arg0.name));
        0x1::vector::append<u8>(&mut v3, b"</text>");
        0x1::vector::append<u8>(&mut v3, b"<text x='150' y='232' text-anchor='middle' fill='#9ca3af' font-size='11' font-family='Arial'>");
        0x1::vector::append<u8>(&mut v3, *0x1::string::bytes(&arg0.team));
        0x1::vector::append<u8>(&mut v3, x"20c2b720");
        0x1::vector::append<u8>(&mut v3, *0x1::string::bytes(&arg0.nation));
        0x1::vector::append<u8>(&mut v3, x"20c2b720");
        0x1::vector::append<u8>(&mut v3, *0x1::string::bytes(&arg0.position));
        0x1::vector::append<u8>(&mut v3, b"</text>");
        0x1::vector::append<u8>(&mut v3, b"<rect x='80' y='240' width='140' height='20' rx='10' fill='");
        0x1::vector::append<u8>(&mut v3, v0);
        0x1::vector::append<u8>(&mut v3, b"'/><text x='150' y='255' text-anchor='middle' fill='#0d0d1a' font-size='10' font-weight='bold' font-family='Arial'>");
        0x1::vector::append<u8>(&mut v3, v1);
        0x1::vector::append<u8>(&mut v3, b"</text>");
        0x1::vector::append<u8>(&mut v3, b"<rect x='10' y='270' width='280' height='110' rx='8' fill='#1a1a2e'/>");
        0x1::vector::append<u8>(&mut v3, b"<text x='28' y='289' fill='#9ca3af' font-size='9' font-family='monospace'>G</text>");
        0x1::vector::append<u8>(&mut v3, b"<text x='72' y='289' fill='#9ca3af' font-size='9' font-family='monospace'>A</text>");
        0x1::vector::append<u8>(&mut v3, b"<text x='108' y='289' fill='#9ca3af' font-size='9' font-family='monospace'>FLOP</text>");
        0x1::vector::append<u8>(&mut v3, b"<text x='158' y='289' fill='#9ca3af' font-size='9' font-family='monospace'>CS</text>");
        0x1::vector::append<u8>(&mut v3, b"<text x='198' y='289' fill='#9ca3af' font-size='9' font-family='monospace'>YC</text>");
        0x1::vector::append<u8>(&mut v3, b"<text x='240' y='289' fill='#9ca3af' font-size='9' font-family='monospace'>RC</text>");
        0x1::vector::append<u8>(&mut v3, b"<text x='28' y='308' fill='white' font-size='14' font-weight='bold' font-family='monospace'>");
        0x1::vector::append<u8>(&mut v3, u64_to_bytes(arg0.goals));
        0x1::vector::append<u8>(&mut v3, b"</text><text x='72' y='308' fill='white' font-size='14' font-weight='bold' font-family='monospace'>");
        0x1::vector::append<u8>(&mut v3, u64_to_bytes(arg0.assists));
        0x1::vector::append<u8>(&mut v3, b"</text><text x='108' y='308' fill='#ef4444' font-size='14' font-weight='bold' font-family='monospace'>");
        0x1::vector::append<u8>(&mut v3, u64_to_bytes(arg0.flops));
        0x1::vector::append<u8>(&mut v3, b"</text><text x='158' y='308' fill='white' font-size='14' font-weight='bold' font-family='monospace'>");
        0x1::vector::append<u8>(&mut v3, u64_to_bytes(arg0.clean_sheets));
        0x1::vector::append<u8>(&mut v3, b"</text><text x='198' y='308' fill='#fbbf24' font-size='14' font-weight='bold' font-family='monospace'>");
        0x1::vector::append<u8>(&mut v3, u64_to_bytes(arg0.yellow_cards));
        0x1::vector::append<u8>(&mut v3, b"</text><text x='240' y='308' fill='#ef4444' font-size='14' font-weight='bold' font-family='monospace'>");
        0x1::vector::append<u8>(&mut v3, u64_to_bytes(arg0.red_cards));
        0x1::vector::append<u8>(&mut v3, b"</text>");
        0x1::vector::append<u8>(&mut v3, b"<text x='150' y='342' text-anchor='middle' fill='#9ca3af' font-size='9' font-family='monospace' letter-spacing='2'>SCORE</text>");
        0x1::vector::append<u8>(&mut v3, b"<text x='150' y='368' text-anchor='middle' fill='");
        0x1::vector::append<u8>(&mut v3, v0);
        0x1::vector::append<u8>(&mut v3, b"' font-size='26' font-weight='bold' font-family='monospace'>");
        0x1::vector::append<u8>(&mut v3, u64_to_bytes(arg0.score));
        0x1::vector::append<u8>(&mut v3, b"</text>");
        if (!arg0.is_alive) {
            0x1::vector::append<u8>(&mut v3, b"<rect width='300' height='440' rx='16' fill='rgba(0,0,0,0.65)'/>");
            0x1::vector::append<u8>(&mut v3, b"<text x='150' y='240' text-anchor='middle' fill='#60a5fa' font-size='42' font-weight='bold' font-family='monospace' opacity='0.9' transform='rotate(-25,150,240)'>FROZEN</text>");
        };
        0x1::vector::append<u8>(&mut v3, b"</svg>");
        0x1::string::utf8(v3)
    }

    public fun score(arg0: &PlayerCard) : u64 {
        arg0.score
    }

    public fun set_current_value(arg0: &AdminCap, arg1: &mut PlayerCard, arg2: u64) {
        arg1.current_value = arg2;
    }

    public fun stage_reached(arg0: &PlayerCard) : u8 {
        arg0.stage_reached
    }

    public fun total_minted(arg0: &MintRegistry) : u64 {
        arg0.total_minted
    }

    fun u64_to_bytes(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public fun update_stats(arg0: &AdminCap, arg1: &mut PlayerCard, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u8) {
        assert!(arg1.is_alive, 1);
        arg1.goals = arg2;
        arg1.assists = arg3;
        arg1.flops = arg4;
        arg1.clean_sheets = arg5;
        arg1.yellow_cards = arg6;
        arg1.red_cards = arg7;
        arg1.stage_reached = arg8;
        arg1.score = calculate_score(arg2, arg3, arg4, arg5, arg6, arg7);
        arg1.rarity = calculate_rarity(arg1.score);
        let v0 = StatsUpdated{
            card_id : 0x2::object::id<PlayerCard>(arg1),
            score   : arg1.score,
            rarity  : arg1.rarity,
        };
        0x2::event::emit<StatsUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

