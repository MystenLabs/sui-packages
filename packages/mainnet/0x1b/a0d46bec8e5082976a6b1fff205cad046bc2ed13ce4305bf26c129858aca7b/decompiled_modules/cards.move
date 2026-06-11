module 0x1ba0d46bec8e5082976a6b1fff205cad046bc2ed13ce4305bf26c129858aca7b::cards {
    struct CARDS has drop {
        dummy_field: bool,
    }

    struct Card has store, key {
        id: 0x2::object::UID,
        match_id: u64,
        player: 0x1::string::String,
        team: 0x1::string::String,
        home_team: 0x1::string::String,
        away_team: 0x1::string::String,
        kickoff_at: u64,
        match_label: 0x1::string::String,
        score_home: u64,
        score_away: u64,
        elapsed_minute: u64,
        moment: 0x1::string::String,
        rarity: 0x1::string::String,
        league_code: 0x1::string::String,
        image_url: 0x2::url::Url,
        alt_image_urls: vector<0x2::url::Url>,
        jersey: u64,
        mint_number: u64,
        minted_at: u64,
        extra: 0x1::string::String,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintCounter has key {
        id: 0x2::object::UID,
        counts: 0x2::table::Table<vector<u8>, u64>,
    }

    struct CardMintedEvent has copy, drop {
        card_id: 0x2::object::ID,
        recipient: address,
        match_id: u64,
        player: 0x1::string::String,
        moment: 0x1::string::String,
        rarity: 0x1::string::String,
        mint_number: u64,
        image_url: 0x2::url::Url,
    }

    struct CardBurnedEvent has copy, drop {
        card_id: 0x2::object::ID,
        burner: address,
        player: 0x1::string::String,
        moment: 0x1::string::String,
        rarity: 0x1::string::String,
        mint_number: u64,
        burned_at: u64,
    }

    struct CardFusedEvent has copy, drop {
        new_card_id: 0x2::object::ID,
        burned_card_ids: vector<0x2::object::ID>,
        recipient: address,
        player: 0x1::string::String,
        league_code: 0x1::string::String,
        moment: 0x1::string::String,
        from_rarity: 0x1::string::String,
        to_rarity: 0x1::string::String,
        new_mint_number: u64,
        fused_at: u64,
    }

    public fun alt_image_urls(arg0: &Card) : &vector<0x2::url::Url> {
        &arg0.alt_image_urls
    }

    public fun away_team(arg0: &Card) : &0x1::string::String {
        &arg0.away_team
    }

    fun counter_key(arg0: &0x1::string::String, arg1: &0x1::string::String) : vector<u8> {
        let v0 = *0x1::string::as_bytes(arg0);
        0x1::vector::push_back<u8>(&mut v0, 124);
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(arg1));
        v0
    }

    public fun elapsed_minute(arg0: &Card) : u64 {
        arg0.elapsed_minute
    }

    public fun extra(arg0: &Card) : &0x1::string::String {
        &arg0.extra
    }

    public fun fuse_cards(arg0: &mut MintCounter, arg1: Card, arg2: Card, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(&arg1.player == &arg2.player, 2);
        assert!(&arg1.league_code == &arg2.league_code, 3);
        assert!(&arg1.rarity == &arg2.rarity, 4);
        if (moment_rank(&arg1.moment) >= moment_rank(&arg2.moment)) {
            fuse_cards_inner(arg0, arg1, arg2, arg3, arg4);
        } else {
            fuse_cards_inner(arg0, arg2, arg1, arg3, arg4);
        };
    }

    fun fuse_cards_inner(arg0: &mut MintCounter, arg1: Card, arg2: Card, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::object::uid_to_inner(&arg1.id);
        let v2 = 0x2::object::uid_to_inner(&arg2.id);
        let v3 = next_rarity(&arg1.rarity);
        let Card {
            id             : v4,
            match_id       : v5,
            player         : v6,
            team           : v7,
            home_team      : v8,
            away_team      : v9,
            kickoff_at     : v10,
            match_label    : v11,
            score_home     : v12,
            score_away     : v13,
            elapsed_minute : v14,
            moment         : v15,
            rarity         : v16,
            league_code    : v17,
            image_url      : v18,
            alt_image_urls : v19,
            jersey         : v20,
            mint_number    : v21,
            minted_at      : _,
            extra          : v23,
        } = arg1;
        let v24 = v15;
        let v25 = v6;
        let v26 = CardBurnedEvent{
            card_id     : v1,
            burner      : v0,
            player      : v25,
            moment      : v24,
            rarity      : v16,
            mint_number : v21,
            burned_at   : arg3,
        };
        0x2::event::emit<CardBurnedEvent>(v26);
        0x2::object::delete(v4);
        let Card {
            id             : v27,
            match_id       : _,
            player         : _,
            team           : _,
            home_team      : _,
            away_team      : _,
            kickoff_at     : _,
            match_label    : _,
            score_home     : _,
            score_away     : _,
            elapsed_minute : _,
            moment         : v38,
            rarity         : v39,
            league_code    : _,
            image_url      : _,
            alt_image_urls : _,
            jersey         : v43,
            mint_number    : v44,
            minted_at      : _,
            extra          : _,
        } = arg2;
        let v47 = if (v20 != 0) {
            v20
        } else {
            v43
        };
        let v48 = CardBurnedEvent{
            card_id     : v2,
            burner      : v0,
            player      : v25,
            moment      : v38,
            rarity      : v39,
            mint_number : v44,
            burned_at   : arg3,
        };
        0x2::event::emit<CardBurnedEvent>(v48);
        0x2::object::delete(v27);
        let v49 = next_serial(arg0, &v25, &v24);
        let v50 = Card{
            id             : 0x2::object::new(arg4),
            match_id       : v5,
            player         : v25,
            team           : v7,
            home_team      : v8,
            away_team      : v9,
            kickoff_at     : v10,
            match_label    : v11,
            score_home     : v12,
            score_away     : v13,
            elapsed_minute : v14,
            moment         : v24,
            rarity         : v3,
            league_code    : v17,
            image_url      : v18,
            alt_image_urls : v19,
            jersey         : v47,
            mint_number    : v49,
            minted_at      : arg3,
            extra          : v23,
        };
        let v51 = 0x1::vector::empty<0x2::object::ID>();
        let v52 = &mut v51;
        0x1::vector::push_back<0x2::object::ID>(v52, v1);
        0x1::vector::push_back<0x2::object::ID>(v52, v2);
        let v53 = CardFusedEvent{
            new_card_id     : 0x2::object::uid_to_inner(&v50.id),
            burned_card_ids : v51,
            recipient       : v0,
            player          : v25,
            league_code     : v17,
            moment          : v24,
            from_rarity     : rarity_predecessor(&v3),
            to_rarity       : v3,
            new_mint_number : v49,
            fused_at        : arg3,
        };
        0x2::event::emit<CardFusedEvent>(v53);
        0x2::transfer::public_transfer<Card>(v50, v0);
    }

    public fun home_team(arg0: &Card) : &0x1::string::String {
        &arg0.home_team
    }

    public fun image_url(arg0: &Card) : &0x2::url::Url {
        &arg0.image_url
    }

    fun init(arg0: CARDS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CARDS>(arg0, arg1);
        let v1 = 0x2::display::new<Card>(&v0, arg1);
        0x2::display::add<Card>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{player} - {home_team} vs {away_team} ({match_label}) - {moment} #{mint_number}"));
        0x2::display::add<Card>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(x"46494c203230323620636f6c6c65637469626c6520e28094207b706c617965727d20287b7465616d7d29207b6d6f6d656e747d206174207b656c61707365645f6d696e7574657d2720696e207b686f6d655f7465616d7d207b73636f72655f686f6d657d2d7b73636f72655f617761797d207b617761795f7465616d7d206f6e207b6d617463685f6c6162656c7d20287b6c65616775655f636f64657d292e"));
        0x2::display::add<Card>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Card>(&mut v1, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://fil2026.com/cards/{id}"));
        0x2::display::add<Card>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://fil2026.com"));
        0x2::display::add<Card>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"FIL 2026"));
        0x2::display::update_version<Card>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Card>>(v1, 0x2::tx_context::sender(arg1));
        let v2 = MintCounter{
            id     : 0x2::object::new(arg1),
            counts : 0x2::table::new<vector<u8>, u64>(arg1),
        };
        0x2::transfer::share_object<MintCounter>(v2);
        let v3 = MintCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<MintCap>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun jersey(arg0: &Card) : u64 {
        arg0.jersey
    }

    public fun kickoff_at(arg0: &Card) : u64 {
        arg0.kickoff_at
    }

    public fun league_code(arg0: &Card) : &0x1::string::String {
        &arg0.league_code
    }

    public fun match_id(arg0: &Card) : u64 {
        arg0.match_id
    }

    public fun match_label(arg0: &Card) : &0x1::string::String {
        &arg0.match_label
    }

    public fun mint_card(arg0: &MintCap, arg1: &mut MintCounter, arg2: address, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u64, arg9: 0x1::string::String, arg10: u64, arg11: u64, arg12: u64, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: vector<u8>, arg17: vector<vector<u8>>, arg18: u64, arg19: u64, arg20: 0x1::string::String, arg21: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::url::Url>();
        while (!0x1::vector::is_empty<vector<u8>>(&arg17)) {
            0x1::vector::push_back<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(0x1::vector::pop_back<vector<u8>>(&mut arg17)));
        };
        0x1::vector::destroy_empty<vector<u8>>(arg17);
        0x1::vector::reverse<0x2::url::Url>(&mut v0);
        let v1 = next_serial(arg1, &arg4, &arg13);
        let v2 = Card{
            id             : 0x2::object::new(arg21),
            match_id       : arg3,
            player         : arg4,
            team           : arg5,
            home_team      : arg6,
            away_team      : arg7,
            kickoff_at     : arg8,
            match_label    : arg9,
            score_home     : arg10,
            score_away     : arg11,
            elapsed_minute : arg12,
            moment         : arg13,
            rarity         : arg14,
            league_code    : arg15,
            image_url      : 0x2::url::new_unsafe_from_bytes(arg16),
            alt_image_urls : v0,
            jersey         : arg18,
            mint_number    : v1,
            minted_at      : arg19,
            extra          : arg20,
        };
        let v3 = CardMintedEvent{
            card_id     : 0x2::object::uid_to_inner(&v2.id),
            recipient   : arg2,
            match_id    : arg3,
            player      : v2.player,
            moment      : v2.moment,
            rarity      : v2.rarity,
            mint_number : v1,
            image_url   : v2.image_url,
        };
        0x2::event::emit<CardMintedEvent>(v3);
        0x2::transfer::public_transfer<Card>(v2, arg2);
    }

    public fun mint_card_batch(arg0: &MintCap, arg1: &mut MintCounter, arg2: vector<address>, arg3: vector<u64>, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: vector<0x1::string::String>, arg8: vector<u64>, arg9: vector<0x1::string::String>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: vector<0x1::string::String>, arg14: vector<0x1::string::String>, arg15: vector<0x1::string::String>, arg16: vector<vector<u8>>, arg17: vector<vector<vector<u8>>>, arg18: vector<u64>, arg19: vector<u64>, arg20: vector<0x1::string::String>, arg21: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 > 0, 1);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 0);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg4), 0);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg5), 0);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg6), 0);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg7), 0);
        assert!(v0 == 0x1::vector::length<u64>(&arg8), 0);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg9), 0);
        assert!(v0 == 0x1::vector::length<u64>(&arg10), 0);
        assert!(v0 == 0x1::vector::length<u64>(&arg11), 0);
        assert!(v0 == 0x1::vector::length<u64>(&arg12), 0);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg13), 0);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg14), 0);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg15), 0);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg16), 0);
        assert!(v0 == 0x1::vector::length<vector<vector<u8>>>(&arg17), 0);
        assert!(v0 == 0x1::vector::length<u64>(&arg18), 0);
        assert!(v0 == 0x1::vector::length<u64>(&arg19), 0);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg20), 0);
        while (!0x1::vector::is_empty<address>(&arg2)) {
            mint_card(arg0, arg1, 0x1::vector::pop_back<address>(&mut arg2), 0x1::vector::pop_back<u64>(&mut arg3), 0x1::vector::pop_back<0x1::string::String>(&mut arg4), 0x1::vector::pop_back<0x1::string::String>(&mut arg5), 0x1::vector::pop_back<0x1::string::String>(&mut arg6), 0x1::vector::pop_back<0x1::string::String>(&mut arg7), 0x1::vector::pop_back<u64>(&mut arg8), 0x1::vector::pop_back<0x1::string::String>(&mut arg9), 0x1::vector::pop_back<u64>(&mut arg10), 0x1::vector::pop_back<u64>(&mut arg11), 0x1::vector::pop_back<u64>(&mut arg12), 0x1::vector::pop_back<0x1::string::String>(&mut arg13), 0x1::vector::pop_back<0x1::string::String>(&mut arg14), 0x1::vector::pop_back<0x1::string::String>(&mut arg15), 0x1::vector::pop_back<vector<u8>>(&mut arg16), 0x1::vector::pop_back<vector<vector<u8>>>(&mut arg17), 0x1::vector::pop_back<u64>(&mut arg18), 0x1::vector::pop_back<u64>(&mut arg19), 0x1::vector::pop_back<0x1::string::String>(&mut arg20), arg21);
        };
        0x1::vector::destroy_empty<address>(arg2);
        0x1::vector::destroy_empty<u64>(arg3);
        0x1::vector::destroy_empty<0x1::string::String>(arg4);
        0x1::vector::destroy_empty<0x1::string::String>(arg5);
        0x1::vector::destroy_empty<0x1::string::String>(arg6);
        0x1::vector::destroy_empty<0x1::string::String>(arg7);
        0x1::vector::destroy_empty<u64>(arg8);
        0x1::vector::destroy_empty<0x1::string::String>(arg9);
        0x1::vector::destroy_empty<u64>(arg10);
        0x1::vector::destroy_empty<u64>(arg11);
        0x1::vector::destroy_empty<u64>(arg12);
        0x1::vector::destroy_empty<0x1::string::String>(arg13);
        0x1::vector::destroy_empty<0x1::string::String>(arg14);
        0x1::vector::destroy_empty<0x1::string::String>(arg15);
        0x1::vector::destroy_empty<vector<u8>>(arg16);
        0x1::vector::destroy_empty<vector<vector<u8>>>(arg17);
        0x1::vector::destroy_empty<u64>(arg18);
        0x1::vector::destroy_empty<u64>(arg19);
        0x1::vector::destroy_empty<0x1::string::String>(arg20);
    }

    public fun mint_number(arg0: &Card) : u64 {
        arg0.mint_number
    }

    public fun minted_at(arg0: &Card) : u64 {
        arg0.minted_at
    }

    public fun moment(arg0: &Card) : &0x1::string::String {
        &arg0.moment
    }

    fun moment_rank(arg0: &0x1::string::String) : u64 {
        let v0 = *0x1::string::as_bytes(arg0);
        if (v0 == b"lineup") {
            1
        } else if (v0 == b"goal") {
            2
        } else if (v0 == b"motm") {
            3
        } else if (v0 == b"red_card") {
            4
        } else if (v0 == b"penalty") {
            5
        } else if (v0 == b"save") {
            6
        } else if (v0 == b"streak") {
            7
        } else if (v0 == b"upset") {
            8
        } else if (v0 == b"qf_exact") {
            9
        } else if (v0 == b"squad_complete") {
            10
        } else if (v0 == b"pow") {
            11
        } else {
            0
        }
    }

    fun next_rarity(arg0: &0x1::string::String) : 0x1::string::String {
        let v0 = *0x1::string::as_bytes(arg0);
        if (v0 == b"common") {
            return 0x1::string::utf8(b"rare")
        };
        if (v0 == b"rare") {
            return 0x1::string::utf8(b"legendary")
        } else {
            assert!(v0 == b"legendary", 6);
            abort 5
        };
    }

    fun next_serial(arg0: &mut MintCounter, arg1: &0x1::string::String, arg2: &0x1::string::String) : u64 {
        let v0 = counter_key(arg1, arg2);
        if (0x2::table::contains<vector<u8>, u64>(&arg0.counts, v0)) {
            let v2 = 0x2::table::borrow_mut<vector<u8>, u64>(&mut arg0.counts, v0);
            *v2 = *v2 + 1;
            *v2
        } else {
            0x2::table::add<vector<u8>, u64>(&mut arg0.counts, v0, 1);
            1
        }
    }

    public fun player(arg0: &Card) : &0x1::string::String {
        &arg0.player
    }

    public fun rarity(arg0: &Card) : &0x1::string::String {
        &arg0.rarity
    }

    fun rarity_predecessor(arg0: &0x1::string::String) : 0x1::string::String {
        let v0 = *0x1::string::as_bytes(arg0);
        if (v0 == b"rare") {
            0x1::string::utf8(b"common")
        } else {
            assert!(v0 == b"legendary", 6);
            0x1::string::utf8(b"rare")
        }
    }

    public fun score_away(arg0: &Card) : u64 {
        arg0.score_away
    }

    public fun score_home(arg0: &Card) : u64 {
        arg0.score_home
    }

    public fun team(arg0: &Card) : &0x1::string::String {
        &arg0.team
    }

    public fun total_minted(arg0: &MintCounter, arg1: 0x1::string::String, arg2: 0x1::string::String) : u64 {
        let v0 = counter_key(&arg1, &arg2);
        if (0x2::table::contains<vector<u8>, u64>(&arg0.counts, v0)) {
            *0x2::table::borrow<vector<u8>, u64>(&arg0.counts, v0)
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}

