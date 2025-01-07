module 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_settler {
    struct BetKeyEvent<phantom T0, phantom T1> has copy, drop {
        key_bytes: vector<u8>,
    }

    struct Settlement has copy, drop {
        win_condition: 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges,
        bet_size: u64,
        payout_amount: u64,
        player_won: bool,
    }

    struct SettlementEvent<phantom T0, phantom T1> has copy, drop {
        bet_id: 0x2::object::ID,
        player: address,
        outcome: u64,
        settlements: vector<Settlement>,
    }

    struct BlsSettler has key {
        id: 0x2::object::UID,
        pub_key: vector<u8>,
    }

    struct BetKey<phantom T0, phantom T1: copy + drop + store> has copy, drop, store {
        key_bytes: vector<u8>,
    }

    struct Bet<phantom T0> has store {
        player_bet: 0x2::coin::Coin<T0>,
        house_bet: 0x2::coin::Coin<T0>,
        win_condition: 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges,
    }

    struct BetWithDraw<phantom T0> has store {
        player_bet: 0x2::coin::Coin<T0>,
        house_bet: 0x2::coin::Coin<T0>,
        win_condition: 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges,
        draw_condition: 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges,
    }

    struct BetData<phantom T0, T1: copy + drop + store> has store, key {
        id: 0x2::object::UID,
        outcome_only: bool,
        game_name: T1,
        player: address,
        space: u64,
        bets: vector<Bet<T0>>,
        start_epoch: u64,
    }

    struct BetDataWithDraw<phantom T0, T1: copy + drop + store> has store, key {
        id: 0x2::object::UID,
        outcome_only: bool,
        game_name: T1,
        player: address,
        space: u64,
        bets: vector<BetWithDraw<T0>>,
        start_epoch: u64,
    }

    struct BetOutcome<phantom T0, phantom T1: copy + drop + store> {
        player: address,
        outcome: u64,
        bets: vector<Bet<T0>>,
    }

    struct BetOutcomeWithID<phantom T0, phantom T1: copy + drop + store> {
        game_id: 0x2::object::ID,
        player: address,
        outcome: u64,
        bets: vector<Bet<T0>>,
    }

    struct BetOutcomeWithDraw<phantom T0, phantom T1: copy + drop + store> {
        game_id: 0x2::object::ID,
        player: address,
        outcome: u64,
        bets: vector<BetWithDraw<T0>>,
    }

    public fun add_bet_data<T0, T1: copy + drop + store>(arg0: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg1: &mut BlsSettler, arg2: T1, arg3: bool, arg4: address, arg5: u64, arg6: vector<0x2::coin::Coin<T0>>, arg7: vector<u64>, arg8: vector<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges>, arg9: vector<u8>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x2::coin::Coin<T0>>(&arg6);
        assert!(v0 == 0x1::vector::length<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges>(&arg8) && v0 == 0x1::vector::length<u64>(&arg7), 0);
        let v1 = 0x2::object::new(arg10);
        let v2 = 0x2::object::uid_to_bytes(&v1);
        let v3 = 0x1::vector::empty<Bet<T0>>();
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        while (v4 < v0) {
            let v7 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg6);
            v6 = v6 + 0x2::coin::value<T0>(&v7);
            let v8 = 0x1::vector::pop_back<u64>(&mut arg7);
            v5 = v5 + v8;
            let v9 = Bet<T0>{
                player_bet    : v7,
                house_bet     : 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::take<T0, T1>(arg2, arg0, v8, arg10),
                win_condition : 0x1::vector::pop_back<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges>(&mut arg8),
            };
            0x1::vector::push_back<Bet<T0>>(&mut v3, v9);
            v4 = v4 + 1;
        };
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::assert_valid_bet_size<T0, T1>(arg0, v6);
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::assert_within_risk<T0, T1>(arg0, v5);
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg6);
        let v10 = BetData<T0, T1>{
            id           : v1,
            outcome_only : arg3,
            game_name    : arg2,
            player       : arg4,
            space        : arg5,
            bets         : v3,
            start_epoch  : 0x2::tx_context::epoch(arg10),
        };
        0x1::vector::append<u8>(&mut v2, arg9);
        let v11 = BetKey<T0, T1>{key_bytes: v2};
        0x2::dynamic_object_field::add<BetKey<T0, T1>, BetData<T0, T1>>(&mut arg1.id, v11, v10);
        let v12 = BetKeyEvent<T0, T1>{key_bytes: v2};
        0x2::event::emit<BetKeyEvent<T0, T1>>(v12);
    }

    public fun add_bet_data_with_draw<T0, T1: copy + drop + store>(arg0: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg1: &mut BlsSettler, arg2: T1, arg3: bool, arg4: address, arg5: u64, arg6: vector<0x2::coin::Coin<T0>>, arg7: vector<u64>, arg8: vector<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges>, arg9: vector<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges>, arg10: vector<u8>, arg11: &mut 0x2::tx_context::TxContext) : BetKey<T0, T1> {
        let v0 = 0x1::vector::length<0x2::coin::Coin<T0>>(&arg6);
        assert!(v0 == 0x1::vector::length<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges>(&arg8) && v0 == 0x1::vector::length<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges>(&arg9) && v0 == 0x1::vector::length<u64>(&arg7), 0);
        let v1 = 0x2::object::new(arg11);
        let v2 = 0x2::object::uid_to_bytes(&v1);
        let v3 = 0x1::vector::empty<BetWithDraw<T0>>();
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        while (v4 < v0) {
            let v7 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg6);
            v6 = v6 + 0x2::coin::value<T0>(&v7);
            let v8 = 0x1::vector::pop_back<u64>(&mut arg7);
            v5 = v5 + v8;
            let v9 = BetWithDraw<T0>{
                player_bet     : v7,
                house_bet      : 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::take<T0, T1>(arg2, arg0, v8, arg11),
                win_condition  : 0x1::vector::pop_back<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges>(&mut arg8),
                draw_condition : 0x1::vector::pop_back<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges>(&mut arg9),
            };
            0x1::vector::push_back<BetWithDraw<T0>>(&mut v3, v9);
            v4 = v4 + 1;
        };
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::assert_valid_bet_size<T0, T1>(arg0, v6);
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::assert_within_risk<T0, T1>(arg0, v5);
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg6);
        let v10 = BetDataWithDraw<T0, T1>{
            id           : v1,
            outcome_only : arg3,
            game_name    : arg2,
            player       : arg4,
            space        : arg5,
            bets         : v3,
            start_epoch  : 0x2::tx_context::epoch(arg11),
        };
        0x1::vector::append<u8>(&mut v2, arg10);
        let v11 = BetKey<T0, T1>{key_bytes: v2};
        0x2::dynamic_object_field::add<BetKey<T0, T1>, BetDataWithDraw<T0, T1>>(&mut arg1.id, v11, v10);
        let v12 = BetKeyEvent<T0, T1>{key_bytes: v2};
        0x2::event::emit<BetKeyEvent<T0, T1>>(v12);
        v11
    }

    public fun challenge<T0, T1: copy + drop + store>(arg0: &mut BlsSettler, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        let v0 = BetKey<T0, T1>{key_bytes: arg1};
        if (!0x2::dynamic_object_field::exists_<BetKey<T0, T1>>(&arg0.id, v0)) {
            return
        };
        let BetData {
            id           : v1,
            outcome_only : _,
            game_name    : _,
            player       : v4,
            space        : _,
            bets         : v6,
            start_epoch  : v7,
        } = 0x2::dynamic_object_field::remove<BetKey<T0, T1>, BetData<T0, T1>>(&mut arg0.id, v0);
        let v8 = v6;
        0x2::object::delete(v1);
        assert!(0x2::tx_context::epoch(arg2) > v7 + 3, 1);
        while (!0x1::vector::is_empty<Bet<T0>>(&v8)) {
            let Bet {
                player_bet    : v9,
                house_bet     : v10,
                win_condition : _,
            } = 0x1::vector::pop_back<Bet<T0>>(&mut v8);
            let v12 = v9;
            0x2::coin::join<T0>(&mut v12, v10);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v12, v4);
        };
        0x1::vector::destroy_empty<Bet<T0>>(v8);
    }

    public fun create(arg0: &0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::AdminCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = BlsSettler{
            id      : 0x2::object::new(arg2),
            pub_key : arg1,
        };
        0x2::transfer::share_object<BlsSettler>(v0);
    }

    public fun destroy_bet<T0>(arg0: Bet<T0>) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>, 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges) {
        let Bet {
            player_bet    : v0,
            house_bet     : v1,
            win_condition : v2,
        } = arg0;
        (v0, v1, v2)
    }

    public fun destroy_bet_outcome<T0, T1: copy + drop + store>(arg0: BetOutcome<T0, T1>, arg1: T1) : (address, u64, vector<Bet<T0>>) {
        let BetOutcome {
            player  : v0,
            outcome : v1,
            bets    : v2,
        } = arg0;
        (v0, v1, v2)
    }

    public fun destroy_bet_outcome_with_draw<T0, T1: copy + drop + store>(arg0: BetOutcomeWithDraw<T0, T1>) : (0x2::object::ID, address, u64, vector<BetWithDraw<T0>>) {
        let BetOutcomeWithDraw {
            game_id : v0,
            player  : v1,
            outcome : v2,
            bets    : v3,
        } = arg0;
        (v0, v1, v2, v3)
    }

    public fun destroy_bet_outcome_with_id<T0, T1: copy + drop + store>(arg0: BetOutcomeWithID<T0, T1>, arg1: T1) : (0x2::object::ID, address, u64, vector<Bet<T0>>) {
        let BetOutcomeWithID {
            game_id : v0,
            player  : v1,
            outcome : v2,
            bets    : v3,
        } = arg0;
        (v0, v1, v2, v3)
    }

    public fun destroy_bet_with_draw<T0>(arg0: BetWithDraw<T0>) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>, 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges, 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges) {
        let BetWithDraw {
            player_bet     : v0,
            house_bet      : v1,
            win_condition  : v2,
            draw_condition : v3,
        } = arg0;
        (v0, v1, v2, v3)
    }

    public fun settle<T0, T1: copy + drop + store>(arg0: &mut BlsSettler, arg1: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg2: vector<u8>, arg3: vector<u8>) : 0x1::option::Option<BetOutcome<T0, T1>> {
        let v0 = BetKey<T0, T1>{key_bytes: arg2};
        if (!0x2::dynamic_object_field::exists_<BetKey<T0, T1>>(&arg0.id, v0)) {
            return 0x1::option::none<BetOutcome<T0, T1>>()
        };
        settle_outcome<T0, T1>(arg0, arg1, arg2, arg3, v0)
    }

    fun settle_outcome<T0, T1: copy + drop + store>(arg0: &mut BlsSettler, arg1: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg2: vector<u8>, arg3: vector<u8>, arg4: BetKey<T0, T1>) : 0x1::option::Option<BetOutcome<T0, T1>> {
        let BetData {
            id           : v0,
            outcome_only : v1,
            game_name    : v2,
            player       : v3,
            space        : v4,
            bets         : v5,
            start_epoch  : _,
        } = 0x2::dynamic_object_field::remove<BetKey<T0, T1>, BetData<T0, T1>>(&mut arg0.id, arg4);
        let v7 = v5;
        let v8 = v0;
        0x2::object::delete(v8);
        let v9 = arg0.pub_key;
        let v10 = 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_lib::verify_bls_sig_and_get_outcome(&arg3, &v9, &arg2, v4);
        if (v1) {
            let v12 = BetOutcome<T0, T1>{
                player  : v3,
                outcome : v10,
                bets    : v7,
            };
            0x1::option::some<BetOutcome<T0, T1>>(v12)
        } else {
            let v13 = 0x1::vector::empty<Settlement>();
            while (!0x1::vector::is_empty<Bet<T0>>(&v7)) {
                let Bet {
                    player_bet    : v14,
                    house_bet     : v15,
                    win_condition : v16,
                } = 0x1::vector::pop_back<Bet<T0>>(&mut v7);
                let v17 = v16;
                let v18 = v15;
                let v19 = v14;
                0x2::coin::join<T0>(&mut v19, v18);
                let v20 = if (0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::contains(&v17, v10)) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v19, v3);
                    true
                } else {
                    0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::put<T0, T1>(v2, arg1, v19);
                    false
                };
                let v21 = Settlement{
                    win_condition : v17,
                    bet_size      : 0x2::coin::value<T0>(&v19),
                    payout_amount : 0x2::coin::value<T0>(&v18),
                    player_won    : v20,
                };
                0x1::vector::push_back<Settlement>(&mut v13, v21);
            };
            0x1::vector::destroy_empty<Bet<T0>>(v7);
            let v22 = SettlementEvent<T0, T1>{
                bet_id      : 0x2::object::uid_to_inner(&v8),
                player      : v3,
                outcome     : v10,
                settlements : v13,
            };
            0x2::event::emit<SettlementEvent<T0, T1>>(v22);
            0x1::option::none<BetOutcome<T0, T1>>()
        }
    }

    fun settle_outcome_v2<T0, T1: copy + drop + store>(arg0: &mut BlsSettler, arg1: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg2: vector<u8>, arg3: vector<u8>, arg4: BetKey<T0, T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<BetOutcome<T0, T1>> {
        let BetData {
            id           : v0,
            outcome_only : v1,
            game_name    : v2,
            player       : v3,
            space        : v4,
            bets         : v5,
            start_epoch  : _,
        } = 0x2::dynamic_object_field::remove<BetKey<T0, T1>, BetData<T0, T1>>(&mut arg0.id, arg4);
        let v7 = v5;
        let v8 = v0;
        0x2::object::delete(v8);
        let v9 = arg0.pub_key;
        let v10 = 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_lib::verify_bls_sig_and_get_outcome_entropy(&mut arg3, &v9, &arg2, v4, arg5);
        if (v1) {
            let v12 = BetOutcome<T0, T1>{
                player  : v3,
                outcome : v10,
                bets    : v7,
            };
            0x1::option::some<BetOutcome<T0, T1>>(v12)
        } else {
            let v13 = 0x1::vector::empty<Settlement>();
            while (!0x1::vector::is_empty<Bet<T0>>(&v7)) {
                let Bet {
                    player_bet    : v14,
                    house_bet     : v15,
                    win_condition : v16,
                } = 0x1::vector::pop_back<Bet<T0>>(&mut v7);
                let v17 = v16;
                let v18 = v15;
                let v19 = v14;
                0x2::coin::join<T0>(&mut v19, v18);
                let v20 = if (0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::contains(&v17, v10)) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v19, v3);
                    true
                } else {
                    0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::put<T0, T1>(v2, arg1, v19);
                    false
                };
                let v21 = Settlement{
                    win_condition : v17,
                    bet_size      : 0x2::coin::value<T0>(&v19),
                    payout_amount : 0x2::coin::value<T0>(&v18),
                    player_won    : v20,
                };
                0x1::vector::push_back<Settlement>(&mut v13, v21);
            };
            0x1::vector::destroy_empty<Bet<T0>>(v7);
            let v22 = SettlementEvent<T0, T1>{
                bet_id      : 0x2::object::uid_to_inner(&v8),
                player      : v3,
                outcome     : v10,
                settlements : v13,
            };
            0x2::event::emit<SettlementEvent<T0, T1>>(v22);
            0x1::option::none<BetOutcome<T0, T1>>()
        }
    }

    fun settle_outcome_with_draw<T0, T1: copy + drop + store>(arg0: &mut BlsSettler, arg1: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg2: vector<u8>, arg3: vector<u8>, arg4: BetKey<T0, T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<BetOutcomeWithDraw<T0, T1>> {
        let BetDataWithDraw {
            id           : v0,
            outcome_only : v1,
            game_name    : v2,
            player       : v3,
            space        : v4,
            bets         : v5,
            start_epoch  : _,
        } = 0x2::dynamic_object_field::remove<BetKey<T0, T1>, BetDataWithDraw<T0, T1>>(&mut arg0.id, arg4);
        let v7 = v5;
        let v8 = v0;
        0x2::object::delete(v8);
        let v9 = arg0.pub_key;
        let v10 = 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_lib::verify_bls_sig_and_get_outcome_entropy(&mut arg3, &v9, &arg2, v4, arg5);
        if (v1) {
            let v12 = BetOutcomeWithDraw<T0, T1>{
                game_id : 0x2::object::uid_to_inner(&v8),
                player  : v3,
                outcome : v10,
                bets    : v7,
            };
            0x1::option::some<BetOutcomeWithDraw<T0, T1>>(v12)
        } else {
            let v13 = 0x1::vector::empty<Settlement>();
            while (!0x1::vector::is_empty<BetWithDraw<T0>>(&v7)) {
                let BetWithDraw {
                    player_bet     : v14,
                    house_bet      : v15,
                    win_condition  : v16,
                    draw_condition : v17,
                } = 0x1::vector::pop_back<BetWithDraw<T0>>(&mut v7);
                let v18 = v17;
                let v19 = v16;
                let v20 = v15;
                let v21 = v14;
                let v22 = if (0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::contains(&v19, v10)) {
                    0x2::coin::join<T0>(&mut v21, v20);
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v21, v3);
                    true
                } else if (0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::contains(&v18, v10)) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v21, v3);
                    0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::put<T0, T1>(v2, arg1, v20);
                    false
                } else {
                    0x2::coin::join<T0>(&mut v21, v20);
                    0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::put<T0, T1>(v2, arg1, v21);
                    false
                };
                let v23 = Settlement{
                    win_condition : v19,
                    bet_size      : 0x2::coin::value<T0>(&v21),
                    payout_amount : 0x2::coin::value<T0>(&v20),
                    player_won    : v22,
                };
                0x1::vector::push_back<Settlement>(&mut v13, v23);
            };
            0x1::vector::destroy_empty<BetWithDraw<T0>>(v7);
            let v24 = SettlementEvent<T0, T1>{
                bet_id      : 0x2::object::uid_to_inner(&v8),
                player      : v3,
                outcome     : v10,
                settlements : v13,
            };
            0x2::event::emit<SettlementEvent<T0, T1>>(v24);
            0x1::option::none<BetOutcomeWithDraw<T0, T1>>()
        }
    }

    public fun settle_v2<T0, T1: copy + drop + store>(arg0: &mut BlsSettler, arg1: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg2: vector<u8>, arg3: vector<u8>) : 0x1::option::Option<BetOutcomeWithID<T0, T1>> {
        let v0 = BetKey<T0, T1>{key_bytes: arg2};
        if (!0x2::dynamic_object_field::exists_<BetKey<T0, T1>>(&arg0.id, v0)) {
            return 0x1::option::none<BetOutcomeWithID<T0, T1>>()
        };
        let BetData {
            id           : v1,
            outcome_only : v2,
            game_name    : v3,
            player       : v4,
            space        : v5,
            bets         : v6,
            start_epoch  : _,
        } = 0x2::dynamic_object_field::remove<BetKey<T0, T1>, BetData<T0, T1>>(&mut arg0.id, v0);
        let v8 = v6;
        let v9 = v1;
        0x2::object::delete(v9);
        let v10 = arg0.pub_key;
        let v11 = 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_lib::verify_bls_sig_and_get_outcome(&arg3, &v10, &arg2, v5);
        if (v2) {
            let v13 = BetOutcomeWithID<T0, T1>{
                game_id : 0x2::object::uid_to_inner(&v9),
                player  : v4,
                outcome : v11,
                bets    : v8,
            };
            0x1::option::some<BetOutcomeWithID<T0, T1>>(v13)
        } else {
            let v14 = 0x1::vector::empty<Settlement>();
            while (!0x1::vector::is_empty<Bet<T0>>(&v8)) {
                let Bet {
                    player_bet    : v15,
                    house_bet     : v16,
                    win_condition : v17,
                } = 0x1::vector::pop_back<Bet<T0>>(&mut v8);
                let v18 = v17;
                let v19 = v16;
                let v20 = v15;
                0x2::coin::join<T0>(&mut v20, v19);
                let v21 = if (0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::contains(&v18, v11)) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v20, v4);
                    true
                } else {
                    0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::put<T0, T1>(v3, arg1, v20);
                    false
                };
                let v22 = Settlement{
                    win_condition : v18,
                    bet_size      : 0x2::coin::value<T0>(&v20),
                    payout_amount : 0x2::coin::value<T0>(&v19),
                    player_won    : v21,
                };
                0x1::vector::push_back<Settlement>(&mut v14, v22);
            };
            0x1::vector::destroy_empty<Bet<T0>>(v8);
            let v23 = SettlementEvent<T0, T1>{
                bet_id      : 0x2::object::uid_to_inner(&v9),
                player      : v4,
                outcome     : v11,
                settlements : v14,
            };
            0x2::event::emit<SettlementEvent<T0, T1>>(v23);
            0x1::option::none<BetOutcomeWithID<T0, T1>>()
        }
    }

    public fun settle_v3<T0, T1: copy + drop + store>(arg0: &mut BlsSettler, arg1: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<BetOutcome<T0, T1>>, 0x1::option::Option<BetOutcomeWithDraw<T0, T1>>) {
        let v0 = BetKey<T0, T1>{key_bytes: arg2};
        if (0x2::dynamic_object_field::exists_with_type<BetKey<T0, T1>, BetData<T0, T1>>(&arg0.id, v0)) {
            (settle_outcome_v2<T0, T1>(arg0, arg1, arg2, arg3, v0, arg4), 0x1::option::none<BetOutcomeWithDraw<T0, T1>>())
        } else if (0x2::dynamic_object_field::exists_with_type<BetKey<T0, T1>, BetDataWithDraw<T0, T1>>(&arg0.id, v0)) {
            (0x1::option::none<BetOutcome<T0, T1>>(), settle_outcome_with_draw<T0, T1>(arg0, arg1, arg2, arg3, v0, arg4))
        } else {
            (0x1::option::none<BetOutcome<T0, T1>>(), 0x1::option::none<BetOutcomeWithDraw<T0, T1>>())
        }
    }

    public fun update_pub_key(arg0: &0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::AdminCap, arg1: &mut BlsSettler, arg2: vector<u8>) {
        arg1.pub_key = arg2;
    }

    // decompiled from Move bytecode v6
}

