module 0xdfbee49d7a160da68034d7a0e85fe181bab07a20184d916b75a3a19c233497b1::live_match {
    struct RoundLog has copy, drop, store {
        round: u8,
        challenger_move: u8,
        opponent_move: u8,
        challenger_dealt: u64,
        opponent_dealt: u64,
        challenger_self_damage: u64,
        opponent_self_damage: u64,
        challenger_hp: u64,
        opponent_hp: u64,
        challenger_stamina: u64,
        opponent_stamina: u64,
    }

    struct LiveMatch has key {
        id: 0x2::object::UID,
        status: u8,
        challenger: address,
        opponent: address,
        challenger_session: address,
        opponent_session: address,
        challenger_miner: 0x1::option::Option<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>,
        opponent_miner: 0x1::option::Option<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>,
        pot: 0x2::balance::Balance<0x2::sui::SUI>,
        challenger_hp: u64,
        opponent_hp: u64,
        challenger_stamina: u64,
        opponent_stamina: u64,
        round: u8,
        challenger_pending_move: 0x1::option::Option<u8>,
        opponent_pending_move: 0x1::option::Option<u8>,
        last_move_ms: u64,
        challenger_gem_uses: u8,
        challenger_shield_uses: u8,
        opponent_gem_uses: u8,
        opponent_shield_uses: u8,
        history: vector<RoundLog>,
    }

    struct MatchCreated has copy, drop {
        match_id: 0x2::object::ID,
        challenger: address,
        opponent: address,
        challenger_session: address,
        extra_wager_mist: u64,
    }

    struct MatchAccepted has copy, drop {
        match_id: 0x2::object::ID,
        opponent_session: address,
    }

    struct MatchWithdrawn has copy, drop {
        match_id: 0x2::object::ID,
    }

    struct MoveCommitted has copy, drop {
        match_id: 0x2::object::ID,
        mover: address,
        move_kind: u8,
    }

    struct RoundResolved has copy, drop {
        match_id: 0x2::object::ID,
        round: u8,
        challenger_move: u8,
        opponent_move: u8,
        challenger_dealt: u64,
        opponent_dealt: u64,
        challenger_self_damage: u64,
        opponent_self_damage: u64,
        challenger_hp: u64,
        opponent_hp: u64,
        challenger_stamina: u64,
        opponent_stamina: u64,
    }

    struct MatchResolved has copy, drop {
        match_id: 0x2::object::ID,
        winner: address,
        jackpot: bool,
        forfeited: bool,
    }

    struct MatchFled has copy, drop {
        match_id: 0x2::object::ID,
        fleeing_player: address,
        stayed_player: address,
        flee_fee_mist: u64,
    }

    public fun accept_match(arg0: &mut LiveMatch, arg1: &mut 0xdfbee49d7a160da68034d7a0e85fe181bab07a20184d916b75a3a19c233497b1::house_battle::Treasury, arg2: 0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner, arg3: address, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 5);
        assert!(0x2::tx_context::sender(arg7) == arg0.opponent, 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) == 1000000000, 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) == 0x2::balance::value<0x2::sui::SUI>(&arg0.pot), 1);
        0xdfbee49d7a160da68034d7a0e85fe181bab07a20184d916b75a3a19c233497b1::house_battle::fund_treasury(arg1, arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot, 0x2::coin::into_balance<0x2::sui::SUI>(arg5));
        0x1::option::fill<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>(&mut arg0.opponent_miner, arg2);
        arg0.opponent_session = arg3;
        arg0.challenger_hp = 100;
        arg0.opponent_hp = 100;
        arg0.challenger_stamina = 100;
        arg0.opponent_stamina = 100;
        arg0.round = 0;
        arg0.last_move_ms = 0x2::clock::timestamp_ms(arg6);
        arg0.status = 1;
        let v0 = MatchAccepted{
            match_id         : 0x2::object::id<LiveMatch>(arg0),
            opponent_session : arg3,
        };
        0x2::event::emit<MatchAccepted>(v0);
    }

    fun apply_stamina_cost(arg0: u8, arg1: u64) : (u64, u64) {
        let v0 = saturating_add_capped(arg1, 2, 100);
        if (arg0 != 0 && arg0 != 1) {
            return (v0, 0)
        };
        let v1 = if (arg0 == 0) {
            10
        } else {
            45
        };
        if (v1 <= v0) {
            (v0 - v1, 0)
        } else {
            let v4 = (v1 - v0) / 2;
            let v5 = if (v4 > damage_for(arg0)) {
                damage_for(arg0)
            } else {
                v4
            };
            (0, v5)
        }
    }

    public fun claim_forfeit(arg0: &mut LiveMatch, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 6);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.challenger || v0 == arg0.opponent, 10);
        assert!(v0 == arg0.challenger && 0x1::option::is_some<u8>(&arg0.challenger_pending_move) || 0x1::option::is_some<u8>(&arg0.opponent_pending_move), 11);
        assert!(0x2::clock::timestamp_ms(arg1) - arg0.last_move_ms >= 120000, 12);
        resolve_to_winner(arg0, v0, true, arg2);
    }

    public fun create_match(arg0: &mut 0xdfbee49d7a160da68034d7a0e85fe181bab07a20184d916b75a3a19c233497b1::house_battle::Treasury, arg1: address, arg2: 0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner, arg3: address, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(arg1 != v0, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) == 1000000000, 0);
        0xdfbee49d7a160da68034d7a0e85fe181bab07a20184d916b75a3a19c233497b1::house_battle::fund_treasury(arg0, arg4);
        let v1 = LiveMatch{
            id                      : 0x2::object::new(arg6),
            status                  : 0,
            challenger              : v0,
            opponent                : arg1,
            challenger_session      : arg3,
            opponent_session        : @0x0,
            challenger_miner        : 0x1::option::some<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>(arg2),
            opponent_miner          : 0x1::option::none<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>(),
            pot                     : 0x2::coin::into_balance<0x2::sui::SUI>(arg5),
            challenger_hp           : 0,
            opponent_hp             : 0,
            challenger_stamina      : 0,
            opponent_stamina        : 0,
            round                   : 0,
            challenger_pending_move : 0x1::option::none<u8>(),
            opponent_pending_move   : 0x1::option::none<u8>(),
            last_move_ms            : 0,
            challenger_gem_uses     : 0,
            challenger_shield_uses  : 0,
            opponent_gem_uses       : 0,
            opponent_shield_uses    : 0,
            history                 : 0x1::vector::empty<RoundLog>(),
        };
        let v2 = MatchCreated{
            match_id           : 0x2::object::id<LiveMatch>(&v1),
            challenger         : v0,
            opponent           : arg1,
            challenger_session : arg3,
            extra_wager_mist   : 0x2::coin::value<0x2::sui::SUI>(&arg5),
        };
        0x2::event::emit<MatchCreated>(v2);
        0x2::transfer::share_object<LiveMatch>(v1);
    }

    fun damage_for(arg0: u8) : u64 {
        if (arg0 == 0) {
            10
        } else if (arg0 == 1) {
            20
        } else if (arg0 == 5) {
            20
        } else {
            0
        }
    }

    public fun flee(arg0: &mut LiveMatch, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 6);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.challenger || v0 == arg0.opponent, 10);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == 1000000000, 13);
        let v1 = if (v0 == arg0.challenger) {
            arg0.opponent
        } else {
            arg0.challenger
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v1);
        arg0.status = 2;
        0x2::transfer::public_transfer<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>(0x1::option::extract<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>(&mut arg0.challenger_miner), arg0.challenger);
        0x2::transfer::public_transfer<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>(0x1::option::extract<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>(&mut arg0.opponent_miner), arg0.opponent);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.pot);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v2 / 2), arg2), arg0.challenger);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, 0x2::balance::value<0x2::sui::SUI>(&arg0.pot)), arg2), arg0.opponent);
        };
        let v3 = MatchFled{
            match_id       : 0x2::object::id<LiveMatch>(arg0),
            fleeing_player : v0,
            stayed_player  : v1,
            flee_fee_mist  : 1000000000,
        };
        0x2::event::emit<MatchFled>(v3);
    }

    public fun rebind_session(arg0: &mut LiveMatch, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 6);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.challenger || v0 == arg0.opponent, 10);
        if (v0 == arg0.challenger) {
            arg0.challenger_session = arg1;
        } else {
            arg0.opponent_session = arg1;
        };
    }

    fun resolve_to_treasury(arg0: &mut LiveMatch, arg1: &mut 0xdfbee49d7a160da68034d7a0e85fe181bab07a20184d916b75a3a19c233497b1::house_battle::Treasury, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.status = 2;
        0xdfbee49d7a160da68034d7a0e85fe181bab07a20184d916b75a3a19c233497b1::house_battle::deposit_nft(arg1, 0x1::option::extract<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>(&mut arg0.challenger_miner));
        0xdfbee49d7a160da68034d7a0e85fe181bab07a20184d916b75a3a19c233497b1::house_battle::deposit_nft(arg1, 0x1::option::extract<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>(&mut arg0.opponent_miner));
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.pot);
        if (v0 > 0) {
            0xdfbee49d7a160da68034d7a0e85fe181bab07a20184d916b75a3a19c233497b1::house_battle::fund_treasury(arg1, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v0), arg2));
        };
        let v1 = MatchResolved{
            match_id  : 0x2::object::id<LiveMatch>(arg0),
            winner    : @0x0,
            jackpot   : true,
            forfeited : false,
        };
        0x2::event::emit<MatchResolved>(v1);
    }

    fun resolve_to_winner(arg0: &mut LiveMatch, arg1: address, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.status = 2;
        0x2::transfer::public_transfer<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>(0x1::option::extract<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>(&mut arg0.challenger_miner), arg1);
        0x2::transfer::public_transfer<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>(0x1::option::extract<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>(&mut arg0.opponent_miner), arg1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.pot);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v0), arg3), arg1);
        };
        let v1 = MatchResolved{
            match_id  : 0x2::object::id<LiveMatch>(arg0),
            winner    : arg1,
            jackpot   : false,
            forfeited : arg2,
        };
        0x2::event::emit<MatchResolved>(v1);
    }

    fun saturating_add_capped(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = arg0 + arg1;
        if (v0 > arg2) {
            arg2
        } else {
            v0
        }
    }

    fun saturating_sub(arg0: u64, arg1: u64) : u64 {
        if (arg1 >= arg0) {
            0
        } else {
            arg0 - arg1
        }
    }

    public fun submit_move(arg0: &mut LiveMatch, arg1: &mut 0xdfbee49d7a160da68034d7a0e85fe181bab07a20184d916b75a3a19c233497b1::house_battle::Treasury, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 6);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.challenger_session || v0 == arg0.opponent_session, 7);
        let v1 = if (arg2 == 0) {
            true
        } else if (arg2 == 1) {
            true
        } else if (arg2 == 2) {
            true
        } else if (arg2 == 3) {
            true
        } else if (arg2 == 4) {
            true
        } else {
            arg2 == 5
        };
        assert!(v1, 9);
        let v2 = v0 == arg0.challenger_session;
        if (arg2 == 3) {
            if (v2) {
                assert!(arg0.challenger_gem_uses < 2, 14);
                arg0.challenger_gem_uses = arg0.challenger_gem_uses + 1;
            } else {
                assert!(arg0.opponent_gem_uses < 2, 14);
                arg0.opponent_gem_uses = arg0.opponent_gem_uses + 1;
            };
        } else if (arg2 == 4) {
            if (v2) {
                assert!(arg0.challenger_shield_uses < 3, 15);
                arg0.challenger_shield_uses = arg0.challenger_shield_uses + 1;
            } else {
                assert!(arg0.opponent_shield_uses < 3, 15);
                arg0.opponent_shield_uses = arg0.opponent_shield_uses + 1;
            };
        };
        if (v2) {
            assert!(0x1::option::is_none<u8>(&arg0.challenger_pending_move), 8);
            0x1::option::fill<u8>(&mut arg0.challenger_pending_move, arg2);
        } else {
            assert!(0x1::option::is_none<u8>(&arg0.opponent_pending_move), 8);
            0x1::option::fill<u8>(&mut arg0.opponent_pending_move, arg2);
        };
        arg0.last_move_ms = 0x2::clock::timestamp_ms(arg3);
        let v3 = MoveCommitted{
            match_id  : 0x2::object::id<LiveMatch>(arg0),
            mover     : v0,
            move_kind : arg2,
        };
        0x2::event::emit<MoveCommitted>(v3);
        if (0x1::option::is_none<u8>(&arg0.challenger_pending_move) || 0x1::option::is_none<u8>(&arg0.opponent_pending_move)) {
            return
        };
        let v4 = 0x1::option::extract<u8>(&mut arg0.challenger_pending_move);
        let v5 = 0x1::option::extract<u8>(&mut arg0.opponent_pending_move);
        let (v6, v7) = apply_stamina_cost(v4, arg0.challenger_stamina);
        let (v8, v9) = apply_stamina_cost(v5, arg0.opponent_stamina);
        arg0.challenger_stamina = v6;
        arg0.opponent_stamina = v8;
        let v10 = damage_for(v4);
        let v11 = v10;
        let v12 = damage_for(v5);
        let v13 = v12;
        if (v5 == 2) {
            v11 = v10 / 2;
        };
        if (v4 == 2) {
            v13 = v12 / 2;
        };
        if (v5 == 4) {
            v11 = 0;
            v13 = v13 + 6;
        };
        if (v4 == 4) {
            v13 = 0;
            v11 = v11 + 6;
        };
        arg0.opponent_hp = saturating_sub(arg0.opponent_hp, v11);
        arg0.challenger_hp = saturating_sub(arg0.challenger_hp, v13);
        arg0.challenger_hp = saturating_sub(arg0.challenger_hp, v7);
        arg0.opponent_hp = saturating_sub(arg0.opponent_hp, v9);
        if (v4 == 3) {
            arg0.challenger_hp = saturating_add_capped(arg0.challenger_hp, 18, 100);
        };
        if (v5 == 3) {
            arg0.opponent_hp = saturating_add_capped(arg0.opponent_hp, 18, 100);
        };
        arg0.round = arg0.round + 1;
        let v14 = RoundResolved{
            match_id               : 0x2::object::id<LiveMatch>(arg0),
            round                  : arg0.round,
            challenger_move        : v4,
            opponent_move          : v5,
            challenger_dealt       : v11,
            opponent_dealt         : v13,
            challenger_self_damage : v7,
            opponent_self_damage   : v9,
            challenger_hp          : arg0.challenger_hp,
            opponent_hp            : arg0.opponent_hp,
            challenger_stamina     : arg0.challenger_stamina,
            opponent_stamina       : arg0.opponent_stamina,
        };
        0x2::event::emit<RoundResolved>(v14);
        let v15 = RoundLog{
            round                  : arg0.round,
            challenger_move        : v4,
            opponent_move          : v5,
            challenger_dealt       : v11,
            opponent_dealt         : v13,
            challenger_self_damage : v7,
            opponent_self_damage   : v9,
            challenger_hp          : arg0.challenger_hp,
            opponent_hp            : arg0.opponent_hp,
            challenger_stamina     : arg0.challenger_stamina,
            opponent_stamina       : arg0.opponent_stamina,
        };
        0x1::vector::push_back<RoundLog>(&mut arg0.history, v15);
        let v16 = arg0.challenger_hp == 0;
        let v17 = arg0.opponent_hp == 0;
        if (v16 && v17) {
            resolve_to_treasury(arg0, arg1, arg4);
        } else if (v16) {
            let v18 = arg0.opponent;
            resolve_to_winner(arg0, v18, false, arg4);
        } else if (v17) {
            let v19 = arg0.challenger;
            resolve_to_winner(arg0, v19, false, arg4);
        } else if (arg0.round >= 50) {
            if (arg0.challenger_hp == arg0.opponent_hp) {
                resolve_to_treasury(arg0, arg1, arg4);
            } else if (arg0.challenger_hp > arg0.opponent_hp) {
                let v20 = arg0.challenger;
                resolve_to_winner(arg0, v20, false, arg4);
            } else {
                let v21 = arg0.opponent;
                resolve_to_winner(arg0, v21, false, arg4);
            };
        };
    }

    public fun withdraw_open_match(arg0: LiveMatch, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 5);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.challenger || v0 == arg0.opponent, 4);
        let LiveMatch {
            id                      : v1,
            status                  : _,
            challenger              : v3,
            opponent                : _,
            challenger_session      : _,
            opponent_session        : _,
            challenger_miner        : v7,
            opponent_miner          : v8,
            pot                     : v9,
            challenger_hp           : _,
            opponent_hp             : _,
            challenger_stamina      : _,
            opponent_stamina        : _,
            round                   : _,
            challenger_pending_move : _,
            opponent_pending_move   : _,
            last_move_ms            : _,
            challenger_gem_uses     : _,
            challenger_shield_uses  : _,
            opponent_gem_uses       : _,
            opponent_shield_uses    : _,
            history                 : _,
        } = arg0;
        let v23 = v9;
        let v24 = v7;
        let v25 = v1;
        0x2::object::delete(v25);
        0x2::transfer::public_transfer<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>(0x1::option::extract<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>(&mut v24), v3);
        0x1::option::destroy_none<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>(v24);
        0x1::option::destroy_none<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>(v8);
        if (0x2::balance::value<0x2::sui::SUI>(&v23) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v23, arg1), v3);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v23);
        };
        let v26 = MatchWithdrawn{match_id: 0x2::object::uid_to_inner(&v25)};
        0x2::event::emit<MatchWithdrawn>(v26);
    }

    // decompiled from Move bytecode v7
}

