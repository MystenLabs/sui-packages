module 0x7dd2554ce9cfdc933e070ae78c7774fd6e3f5b2b0468df642c804111fb3cf1c1::suiwin {
    struct GameData has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        fee: u8,
        countdown: u64,
        min: u64,
        max: u64,
        gamenumber: u64,
    }

    struct WLock has key {
        id: 0x2::object::UID,
        data: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PokerData has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        player1: address,
        player2: address,
        sigcards1: vector<u8>,
        sigcards2: vector<u8>,
        revealcards1: vector<u8>,
        revealcards2: vector<u8>,
        stage: u8,
        bet: u64,
        time: u64,
        action: bool,
    }

    struct GnumberOpen has copy, drop {
        result: u64,
        vol: u64,
    }

    struct GnumberCont has copy, drop {
        result: u64,
        vol: u64,
    }

    struct GnumberClose has copy, drop {
        result: u64,
    }

    struct Gvol has copy, drop {
        vol: u64,
        player: address,
        expendORincome: bool,
    }

    struct Testout has copy, drop {
        result: u8,
    }

    entry fun OpenCards(arg0: u64, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut GameData, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, PokerData>(&mut arg3.id, arg0);
        assert!(v0.stage == 4, 7);
        assert!(0x2::tx_context::sender(arg4) == v0.player1 || 0x2::tx_context::sender(arg4) == v0.player2, 15);
        assert!(0x1::vector::length<u8>(&arg1) == 55, 11);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0.balance);
        let v2 = v1 / 1000 * (arg3.fee as u64);
        0x2::coin::put<0x2::sui::SUI>(&mut arg3.balance, 0x2::coin::take<0x2::sui::SUI>(&mut v0.balance, v2, arg4));
        let v3 = v1 - v2;
        if (0x2::tx_context::sender(arg4) == v0.player1) {
            let v4 = &mut v0.stage;
            let v5 = &mut v0.time;
            OpenCards_(1, true, v0.revealcards2, v0.sigcards1, arg2, arg1, 0x2::coin::take<0x2::sui::SUI>(&mut v0.balance, v3, arg4), v0.revealcards1, v0.player2, 0x2::tx_context::sender(arg4), v3, v4, v5, v0.action);
        } else if (0x2::tx_context::sender(arg4) == v0.player2) {
            let v6 = &mut v0.stage;
            let v7 = &mut v0.time;
            OpenCards_(2, false, v0.revealcards1, v0.sigcards2, arg2, arg1, 0x2::coin::take<0x2::sui::SUI>(&mut v0.balance, v3, arg4), v0.revealcards2, v0.player1, 0x2::tx_context::sender(arg4), v3, v6, v7, v0.action);
        } else {
            0x2::coin::put<0x2::sui::SUI>(&mut v0.balance, 0x2::coin::take<0x2::sui::SUI>(&mut v0.balance, v3, arg4));
        };
    }

    fun OpenCards_(arg0: u8, arg1: bool, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: vector<u8>, arg8: address, arg9: address, arg10: u64, arg11: &mut u8, arg12: &mut u64, arg13: bool) {
        assert!(arg13 != arg1, 5);
        assert!(0x1::vector::length<u8>(&arg2) == 55, 6);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg3, &arg4, &arg5), 8);
        let v0 = sub_vector(&arg5, 52, 55);
        if (0x1::vector::length<u8>(&arg7) == 3) {
            assert!(verification_reveal(&arg7, &v0), 14);
        } else {
            assert!(verification_cards3(&v0), 9);
        };
        let v1 = sub_vector(&arg5, 0, 52);
        assert!(verification_cards52(&v1), 10);
        let v2 = result_cards(arg13, arg5, arg2);
        if (v2 == 0 || v2 == arg0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, arg9);
            if (arg0 == 1) {
                *arg11 = 11;
                *arg12 = 0;
            } else {
                *arg11 = 12;
                *arg12 = 0;
            };
            let v3 = Gvol{
                vol            : arg10,
                player         : arg9,
                expendORincome : true,
            };
            0x2::event::emit<Gvol>(v3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, arg8);
            if (arg0 == 1) {
                *arg11 = 12;
                *arg12 = 0;
            } else {
                *arg11 = 11;
                *arg12 = 0;
            };
            let v4 = Gvol{
                vol            : arg10,
                player         : arg8,
                expendORincome : true,
            };
            0x2::event::emit<Gvol>(v4);
        };
    }

    entry fun applyOpenCards(arg0: u64, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut GameData, arg6: &0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, PokerData>(&mut arg5.id, arg0);
        assert!(v0.stage < 4, 7);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        0x2::coin::put<0x2::sui::SUI>(&mut v0.balance, arg3);
        assert!(0x1::vector::length<u8>(&arg1) == 55, 11);
        if (0x2::tx_context::sender(arg6) == v0.player1) {
            let v2 = &mut v0.revealcards1;
            let v3 = &mut v0.stage;
            let v4 = &mut v0.time;
            let v5 = &mut v0.action;
            applyOpenCards_(true, v0.revealcards2, v0.sigcards1, arg2, arg1, v1, 0x2::clock::timestamp_ms(arg4), v0.bet, v2, v3, v4, v5);
        } else if (0x2::tx_context::sender(arg6) == v0.player2) {
            let v6 = &mut v0.revealcards2;
            let v7 = &mut v0.stage;
            let v8 = &mut v0.time;
            let v9 = &mut v0.action;
            applyOpenCards_(false, v0.revealcards1, v0.sigcards2, arg2, arg1, v1, 0x2::clock::timestamp_ms(arg4), v0.bet, v6, v7, v8, v9);
        };
        let v10 = Gvol{
            vol            : v1,
            player         : 0x2::tx_context::sender(arg6),
            expendORincome : false,
        };
        0x2::event::emit<Gvol>(v10);
    }

    fun applyOpenCards_(arg0: bool, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: &mut vector<u8>, arg9: &mut u8, arg10: &mut u64, arg11: &mut bool) {
        assert!(arg11 != &arg0, 5);
        if (0x1::vector::length<u8>(&arg1) < 1) {
            assert!(arg5 == arg7, 2);
        } else {
            assert!(arg5 == arg7 * 2, 2);
        };
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg2, &arg3, &arg4), 8);
        let v0 = sub_vector(&arg4, 52, 55);
        if (0x1::vector::length<u8>(arg8) == 3) {
            assert!(verification_reveal(arg8, &v0), 14);
        } else {
            assert!(verification_cards3(&v0), 9);
        };
        let v1 = sub_vector(&arg4, 0, 52);
        assert!(verification_cards52(&v1), 10);
        *arg8 = arg4;
        *arg10 = arg6;
        *arg11 = arg0;
        *arg9 = 4;
    }

    entry fun apply_look_cards(arg0: u64, arg1: &0x2::clock::Clock, arg2: &mut GameData, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, PokerData>(&mut arg2.id, arg0);
        assert!(v0.stage < 4, 7);
        if (0x2::tx_context::sender(arg3) == v0.player1) {
            let v1 = &mut v0.stage;
            let v2 = &mut v0.time;
            let v3 = &mut v0.action;
            apply_look_cards_(true, v0.revealcards2, 0x2::clock::timestamp_ms(arg1), v1, v2, v3);
        } else if (0x2::tx_context::sender(arg3) == v0.player2) {
            let v4 = &mut v0.stage;
            let v5 = &mut v0.time;
            let v6 = &mut v0.action;
            apply_look_cards_(false, v0.revealcards1, 0x2::clock::timestamp_ms(arg1), v4, v5, v6);
        };
    }

    fun apply_look_cards_(arg0: bool, arg1: vector<u8>, arg2: u64, arg3: &mut u8, arg4: &mut u64, arg5: &mut bool) {
        assert!(arg5 != &arg0, 5);
        assert!(0x1::vector::length<u8>(&arg1) < 1, 6);
        *arg3 = 6;
        *arg4 = arg2;
        *arg5 = arg0;
    }

    entry fun call(arg0: u64, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut GameData, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, PokerData>(&mut arg3.id, arg0);
        assert!(0x2::tx_context::sender(arg4) == v0.player1 || 0x2::tx_context::sender(arg4) == v0.player2, 15);
        assert!(v0.stage < 4, 7);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::coin::put<0x2::sui::SUI>(&mut v0.balance, arg1);
        if (0x2::tx_context::sender(arg4) == v0.player1) {
            let v2 = &mut v0.time;
            let v3 = &mut v0.action;
            call_(true, v0.revealcards2, v1, v0.bet, 0x2::clock::timestamp_ms(arg2), v2, v3);
        } else {
            let v4 = &mut v0.time;
            let v5 = &mut v0.action;
            call_(false, v0.revealcards1, v1, v0.bet, 0x2::clock::timestamp_ms(arg2), v4, v5);
        };
        let v6 = Gvol{
            vol            : v1,
            player         : 0x2::tx_context::sender(arg4),
            expendORincome : false,
        };
        0x2::event::emit<Gvol>(v6);
    }

    fun call_(arg0: bool, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: &mut u64, arg6: &mut bool) {
        assert!(arg6 != &arg0, 5);
        if (0x1::vector::length<u8>(&arg1) < 1) {
            assert!(arg2 == arg3 / 2, 2);
        } else {
            assert!(arg2 == arg3, 2);
        };
        *arg5 = arg4;
        *arg6 = arg0;
    }

    public entry fun change_WL(arg0: &AdminCap, arg1: &mut WLock, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.data = 0x2::tx_context::epoch(arg2);
    }

    public entry fun change_data_countdown_down(arg0: &AdminCap, arg1: &mut GameData, arg2: &mut WLock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg3) > arg2.data, 0);
        arg1.countdown = arg1.countdown - 10000;
        assert!(arg1.countdown > 20000, 1);
        arg2.data = 9999999;
    }

    public entry fun change_data_countdown_up(arg0: &AdminCap, arg1: &mut GameData, arg2: &mut WLock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg3) > arg2.data, 0);
        arg1.countdown = arg1.countdown + 10000;
        assert!(arg1.countdown < 120000, 1);
        arg2.data = 9999999;
    }

    public entry fun change_data_fee(arg0: &AdminCap, arg1: u8, arg2: &mut GameData, arg3: &mut WLock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg4) > arg3.data, 0);
        assert!(arg1 < 51, 1);
        arg2.fee = arg1;
        arg3.data = 9999999;
    }

    public entry fun change_data_max_down(arg0: &AdminCap, arg1: &mut GameData, arg2: &mut WLock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg3) > arg2.data, 0);
        arg1.max = arg1.max / 2;
        assert!(arg1.max > 100000000000, 1);
        arg2.data = 9999999;
    }

    public entry fun change_data_max_up(arg0: &AdminCap, arg1: &mut GameData, arg2: &mut WLock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg3) > arg2.data, 0);
        arg1.max = arg1.max * 2;
        assert!(arg1.max < 1000000000000000, 1);
        arg2.data = 9999999;
    }

    public entry fun change_data_min_down(arg0: &AdminCap, arg1: &mut GameData, arg2: &mut WLock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg3) > arg2.data, 0);
        arg1.min = arg1.min / 2;
        assert!(arg1.min > 100000000, 1);
        arg2.data = 9999999;
    }

    public entry fun change_data_min_up(arg0: &AdminCap, arg1: &mut GameData, arg2: &mut WLock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg3) > arg2.data, 0);
        arg1.min = arg1.min * 2;
        assert!(arg1.min < 55000000000, 1);
        arg2.data = 9999999;
    }

    fun compare_cards(arg0: vector<u8>, arg1: vector<u8>) : u8 {
        let v0 = get_cards_type(arg0);
        let v1 = get_cards_type(arg1);
        if (v0 > v1) {
            1
        } else if (v0 < v1) {
            2
        } else if (v0 == 2) {
            let v3 = get_pair_value(arg0);
            let v4 = get_pair_value(arg1);
            if (v3 > v4) {
                1
            } else if (v3 < v4) {
                2
            } else {
                get_high_cards(arg0, arg1)
            }
        } else {
            get_high_cards(arg0, arg1)
        }
    }

    entry fun create_game(arg0: vector<u8>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut GameData, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= arg2.min && v0 <= arg2.max, 2);
        arg2.gamenumber = arg2.gamenumber + 1;
        let v1 = PokerData{
            id           : 0x2::object::new(arg3),
            balance      : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            player1      : 0x2::tx_context::sender(arg3),
            player2      : @0x0,
            sigcards1    : arg0,
            sigcards2    : 0x1::vector::empty<u8>(),
            revealcards1 : 0x1::vector::empty<u8>(),
            revealcards2 : 0x1::vector::empty<u8>(),
            stage        : 10,
            bet          : v0,
            time         : 0,
            action       : false,
        };
        0x2::dynamic_object_field::add<u64, PokerData>(&mut arg2.id, arg2.gamenumber, v1);
        let v2 = GnumberOpen{
            result : arg2.gamenumber,
            vol    : v0,
        };
        0x2::event::emit<GnumberOpen>(v2);
    }

    entry fun fold(arg0: u64, arg1: &0x2::clock::Clock, arg2: &mut GameData, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, PokerData>(&mut arg2.id, arg0);
        assert!(v0.stage < 5, 7);
        if (0x2::tx_context::sender(arg3) == v0.player1) {
            let v1 = &mut v0.stage;
            let v2 = &mut v0.time;
            let v3 = &mut v0.action;
            fold_(true, 0x2::clock::timestamp_ms(arg1), v1, v2, v3);
        } else if (0x2::tx_context::sender(arg3) == v0.player2) {
            let v4 = &mut v0.stage;
            let v5 = &mut v0.time;
            let v6 = &mut v0.action;
            fold_(false, 0x2::clock::timestamp_ms(arg1), v4, v5, v6);
        };
    }

    fun fold_(arg0: bool, arg1: u64, arg2: &mut u8, arg3: &mut u64, arg4: &mut bool) {
        assert!(arg4 != &arg0, 5);
        *arg3 = arg1;
        *arg4 = arg0;
        *arg2 = 5;
    }

    fun get_cards_type(arg0: vector<u8>) : u8 {
        let v0 = get_suits(arg0);
        let v1 = get_values(arg0);
        if (*0x1::vector::borrow<u8>(&v1, 0) == *0x1::vector::borrow<u8>(&v1, 1) && *0x1::vector::borrow<u8>(&v1, 1) == *0x1::vector::borrow<u8>(&v1, 2)) {
            6
        } else {
            let v3 = &mut v1;
            sort3(v3);
            let v4 = *0x1::vector::borrow<u8>(&v0, 0) == *0x1::vector::borrow<u8>(&v0, 1) && *0x1::vector::borrow<u8>(&v0, 1) == *0x1::vector::borrow<u8>(&v0, 2);
            let v5 = *0x1::vector::borrow<u8>(&v1, 2) - *0x1::vector::borrow<u8>(&v1, 0) == 2 && *0x1::vector::borrow<u8>(&v1, 2) - *0x1::vector::borrow<u8>(&v1, 1) == 1 || *0x1::vector::borrow<u8>(&v1, 0) == 1 && *0x1::vector::borrow<u8>(&v1, 1) == 12 && *0x1::vector::borrow<u8>(&v1, 2) == 13;
            if (v4 && v5) {
                5
            } else if (v5) {
                4
            } else if (v4) {
                3
            } else if (*0x1::vector::borrow<u8>(&v1, 0) == *0x1::vector::borrow<u8>(&v1, 1) || *0x1::vector::borrow<u8>(&v1, 1) == *0x1::vector::borrow<u8>(&v1, 2) || *0x1::vector::borrow<u8>(&v1, 0) == *0x1::vector::borrow<u8>(&v1, 2)) {
                2
            } else {
                1
            }
        }
    }

    public entry fun get_fee(arg0: u64, arg1: &mut GameData, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, arg0, arg2), @0x82242fabebc3e6e331c3d5c6de3d34ff965671b75154ec1cb9e00aa437bbfa44);
    }

    entry fun get_fold_bets(arg0: u64, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut GameData, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, PokerData>(&mut arg3.id, arg0);
        assert!(0x2::tx_context::sender(arg4) == v0.player1 || 0x2::tx_context::sender(arg4) == v0.player2, 15);
        assert!(v0.stage == 5, 7);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0.balance);
        let v2 = v1 / 1000 * (arg3.fee as u64);
        0x2::coin::put<0x2::sui::SUI>(&mut arg3.balance, 0x2::coin::take<0x2::sui::SUI>(&mut v0.balance, v2, arg4));
        let v3 = v1 - v2;
        if (0x2::tx_context::sender(arg4) == v0.player1) {
            let v4 = &mut v0.stage;
            let v5 = &mut v0.time;
            get_fold_bets_(true, v0.action, v0.sigcards1, arg2, arg1, 0x2::coin::take<0x2::sui::SUI>(&mut v0.balance, v3, arg4), v0.revealcards1, v3, v4, v5, 0x2::tx_context::sender(arg4));
        } else if (0x2::tx_context::sender(arg4) == v0.player2) {
            let v6 = &mut v0.stage;
            let v7 = &mut v0.time;
            get_fold_bets_(false, v0.action, v0.sigcards2, arg2, arg1, 0x2::coin::take<0x2::sui::SUI>(&mut v0.balance, v3, arg4), v0.revealcards2, v3, v6, v7, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::put<0x2::sui::SUI>(&mut v0.balance, 0x2::coin::take<0x2::sui::SUI>(&mut v0.balance, v3, arg4));
        };
    }

    fun get_fold_bets_(arg0: bool, arg1: bool, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: vector<u8>, arg7: u64, arg8: &mut u8, arg9: &mut u64, arg10: address) {
        assert!(arg1 != arg0, 5);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg2, &arg3, &arg4), 8);
        if (0x1::vector::length<u8>(&arg6) == 3) {
            let v0 = sub_vector(&arg4, 52, 55);
            assert!(verification_reveal(&arg6, &v0), 14);
        };
        let v1 = sub_vector(&arg4, 0, 52);
        assert!(verification_cards52(&v1), 10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, arg10);
        if (arg0) {
            *arg8 = 11;
            *arg9 = 0;
        } else {
            *arg8 = 12;
            *arg9 = 0;
        };
        let v2 = Gvol{
            vol            : arg7,
            player         : arg10,
            expendORincome : true,
        };
        0x2::event::emit<Gvol>(v2);
    }

    fun get_high_cards(arg0: vector<u8>, arg1: vector<u8>) : u8 {
        let v0 = handle_special_case(get_values(arg0));
        let v1 = handle_special_case(get_values(arg1));
        let v2 = &mut v0;
        sort3(v2);
        let v3 = &mut v1;
        sort3(v3);
        let v4 = 2;
        while (v4 >= 0) {
            if (*0x1::vector::borrow<u8>(&v0, v4) > *0x1::vector::borrow<u8>(&v1, v4)) {
                return 1
            };
            if (*0x1::vector::borrow<u8>(&v0, v4) < *0x1::vector::borrow<u8>(&v1, v4)) {
                return 2
            };
            if (v4 == 0) {
                break
            };
            v4 = v4 - 1;
        };
        0
    }

    fun get_pair_value(arg0: vector<u8>) : u8 {
        let v0 = handle_special_case(get_values(arg0));
        if (*0x1::vector::borrow<u8>(&v0, 0) == *0x1::vector::borrow<u8>(&v0, 1) || *0x1::vector::borrow<u8>(&v0, 0) == *0x1::vector::borrow<u8>(&v0, 2)) {
            *0x1::vector::borrow<u8>(&v0, 0)
        } else {
            *0x1::vector::borrow<u8>(&v0, 1)
        }
    }

    fun get_suits(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 3) {
            0x1::vector::push_back<u8>(&mut v0, (*0x1::vector::borrow<u8>(&arg0, v1) - 1) % 4);
            v1 = v1 + 1;
        };
        v0
    }

    entry fun get_timeout_bets(arg0: u64, arg1: &0x2::clock::Clock, arg2: &mut GameData, arg3: &mut 0x2::tx_context::TxContext) {
        let PokerData {
            id           : v0,
            balance      : v1,
            player1      : v2,
            player2      : v3,
            sigcards1    : _,
            sigcards2    : _,
            revealcards1 : _,
            revealcards2 : _,
            stage        : _,
            bet          : _,
            time         : v10,
            action       : v11,
        } = 0x2::dynamic_object_field::remove<u64, PokerData>(&mut arg2.id, arg0);
        let v12 = v1;
        assert!(v10 > 0 && 0x2::clock::timestamp_ms(arg1) - arg2.countdown > v10, 12);
        let v13 = 0x2::balance::value<0x2::sui::SUI>(&v12);
        let v14 = v13 / 1000 * (arg2.fee as u64);
        0x2::coin::put<0x2::sui::SUI>(&mut arg2.balance, 0x2::coin::take<0x2::sui::SUI>(&mut v12, v14, arg3));
        let v15 = v13 - v14;
        if (v11) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v12, v15, arg3), v2);
            let v16 = Gvol{
                vol            : v15,
                player         : v2,
                expendORincome : true,
            };
            0x2::event::emit<Gvol>(v16);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v12, v15, arg3), v3);
            let v17 = Gvol{
                vol            : v15,
                player         : v3,
                expendORincome : true,
            };
            0x2::event::emit<Gvol>(v17);
        };
        0x2::balance::destroy_zero<0x2::sui::SUI>(v12);
        0x2::object::delete(v0);
        let v18 = GnumberClose{result: arg0};
        0x2::event::emit<GnumberClose>(v18);
    }

    fun get_values(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 3) {
            0x1::vector::push_back<u8>(&mut v0, (*0x1::vector::borrow<u8>(&arg0, v1) - 1) / 4 + 1);
            v1 = v1 + 1;
        };
        v0
    }

    entry fun go_on_playing(arg0: u64, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut GameData, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, PokerData>(&mut arg3.id, arg0);
        assert!(0x2::tx_context::sender(arg4) == v0.player1 || 0x2::tx_context::sender(arg4) == v0.player2, 13);
        assert!(v0.stage == 11 || v0.stage == 12, 7);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v1 >= arg3.min && v1 <= arg3.max, 2);
        0x2::coin::put<0x2::sui::SUI>(&mut v0.balance, arg2);
        if (v0.stage == 11) {
            if (0x2::tx_context::sender(arg4) == v0.player1) {
                v0.player2 = 0x2::tx_context::sender(arg4);
                v0.player1 = @0x0;
                v0.sigcards2 = arg1;
                v0.sigcards1 = 0x1::vector::empty<u8>();
            } else {
                v0.player1 = 0x2::tx_context::sender(arg4);
                v0.player2 = @0x0;
                v0.sigcards1 = arg1;
                v0.sigcards2 = 0x1::vector::empty<u8>();
            };
        } else if (0x2::tx_context::sender(arg4) == v0.player1) {
            v0.player2 = @0x0;
            v0.sigcards1 = arg1;
            v0.sigcards2 = 0x1::vector::empty<u8>();
        } else {
            v0.player1 = @0x0;
            v0.sigcards2 = arg1;
            v0.sigcards1 = 0x1::vector::empty<u8>();
        };
        v0.revealcards1 = 0x1::vector::empty<u8>();
        v0.revealcards2 = 0x1::vector::empty<u8>();
        v0.bet = v1;
        v0.action = false;
        v0.stage = 10;
        let v2 = GnumberCont{
            result : arg0,
            vol    : v1,
        };
        0x2::event::emit<GnumberCont>(v2);
    }

    fun handle_special_case(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0)) {
            let v2 = *0x1::vector::borrow<u8>(&arg0, v1);
            if (v2 == 1) {
                0x1::vector::push_back<u8>(&mut v0, 14);
            } else {
                0x1::vector::push_back<u8>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GameData{
            id         : 0x2::object::new(arg0),
            balance    : 0x2::balance::zero<0x2::sui::SUI>(),
            fee        : 10,
            countdown  : 60000,
            min        : 1000000000,
            max        : 100000000000,
            gamenumber : 0,
        };
        0x2::transfer::share_object<GameData>(v1);
        let v2 = WLock{
            id   : 0x2::object::new(arg0),
            data : 9999999,
        };
        0x2::transfer::share_object<WLock>(v2);
    }

    entry fun join_game(arg0: u64, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut GameData, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, PokerData>(&mut arg4.id, arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == v0.bet, 2);
        assert!(v0.player2 == @0x0, 4);
        v0.player2 = 0x2::tx_context::sender(arg5);
        v0.sigcards2 = arg1;
        v0.stage = 0;
        v0.time = 0x2::clock::timestamp_ms(arg3);
        0x2::coin::put<0x2::sui::SUI>(&mut v0.balance, arg2);
        let v1 = GnumberClose{result: arg0};
        0x2::event::emit<GnumberClose>(v1);
    }

    entry fun join_playing(arg0: u64, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut GameData, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, PokerData>(&mut arg4.id, arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == v0.bet, 2);
        assert!(v0.player2 == @0x0 || v0.player1 == @0x0, 4);
        if (v0.player2 == @0x0) {
            v0.player2 = 0x2::tx_context::sender(arg5);
            v0.sigcards2 = arg1;
        } else {
            v0.player1 = 0x2::tx_context::sender(arg5);
            v0.sigcards1 = arg1;
        };
        v0.stage = 0;
        v0.time = 0x2::clock::timestamp_ms(arg3);
        0x2::coin::put<0x2::sui::SUI>(&mut v0.balance, arg2);
        let v1 = GnumberClose{result: arg0};
        0x2::event::emit<GnumberClose>(v1);
    }

    entry fun leave_game(arg0: u64, arg1: &mut GameData, arg2: &mut 0x2::tx_context::TxContext) {
        let PokerData {
            id           : v0,
            balance      : v1,
            player1      : v2,
            player2      : v3,
            sigcards1    : _,
            sigcards2    : _,
            revealcards1 : _,
            revealcards2 : _,
            stage        : v8,
            bet          : _,
            time         : _,
            action       : _,
        } = 0x2::dynamic_object_field::remove<u64, PokerData>(&mut arg1.id, arg0);
        let v12 = v1;
        assert!(0x2::tx_context::sender(arg2) == v2 || 0x2::tx_context::sender(arg2) == v3 || 0x2::tx_context::sender(arg2) == @0x82242fabebc3e6e331c3d5c6de3d34ff965671b75154ec1cb9e00aa437bbfa44, 13);
        assert!(v8 == 10 || v8 == 11 || v8 == 12, 7);
        if (v8 == 10) {
            if (v2 != @0x0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v12, 0x2::balance::value<0x2::sui::SUI>(&v12), arg2), v2);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v12, 0x2::balance::value<0x2::sui::SUI>(&v12), arg2), v3);
            };
        };
        0x2::balance::destroy_zero<0x2::sui::SUI>(v12);
        0x2::object::delete(v0);
        let v13 = GnumberClose{result: arg0};
        0x2::event::emit<GnumberClose>(v13);
    }

    entry fun rasie(arg0: u64, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut GameData, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, PokerData>(&mut arg3.id, arg0);
        assert!(0x2::tx_context::sender(arg4) == v0.player1 || 0x2::tx_context::sender(arg4) == v0.player2, 15);
        assert!(v0.stage < 4, 7);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::coin::put<0x2::sui::SUI>(&mut v0.balance, arg1);
        if (0x2::tx_context::sender(arg4) == v0.player1) {
            let v2 = &mut v0.bet;
            let v3 = &mut v0.time;
            let v4 = &mut v0.action;
            rasie_(true, v0.revealcards2, v1, arg3.max, 0x2::clock::timestamp_ms(arg2), v2, v3, v4);
        } else {
            let v5 = &mut v0.bet;
            let v6 = &mut v0.time;
            let v7 = &mut v0.action;
            rasie_(false, v0.revealcards1, v1, arg3.max, 0x2::clock::timestamp_ms(arg2), v5, v6, v7);
        };
        let v8 = Gvol{
            vol            : v1,
            player         : 0x2::tx_context::sender(arg4),
            expendORincome : false,
        };
        0x2::event::emit<Gvol>(v8);
    }

    fun rasie_(arg0: bool, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: &mut u64, arg6: &mut u64, arg7: &mut bool) {
        assert!(arg7 != &arg0, 5);
        if (0x1::vector::length<u8>(&arg1) < 1) {
            assert!(arg2 > *arg5 / 2, 2);
            assert!(arg2 <= arg3, 2);
            *arg5 = arg2 * 2;
        } else {
            assert!(arg2 > *arg5, 3);
            assert!(arg2 <= arg3 * 2, 3);
            *arg5 = arg2;
        };
        *arg6 = arg4;
        *arg7 = arg0;
    }

    fun result_cards(arg0: bool, arg1: vector<u8>, arg2: vector<u8>) : u8 {
        if (arg0) {
            compare_cards(show_cards(arg2, arg1), show_cards(arg1, arg2))
        } else {
            compare_cards(show_cards(arg1, arg2), show_cards(arg2, arg1))
        }
    }

    entry fun reveal_look_cards(arg0: u64, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut GameData, arg4: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) == 3, 6);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, PokerData>(&mut arg3.id, arg0);
        if (0x2::tx_context::sender(arg4) == v0.player1) {
            let v1 = &mut v0.revealcards1;
            let v2 = &mut v0.stage;
            let v3 = &mut v0.time;
            let v4 = &mut v0.action;
            reveal_look_cards_(true, arg1, 0x2::clock::timestamp_ms(arg2), v1, v2, v3, v4);
        } else if (0x2::tx_context::sender(arg4) == v0.player2) {
            let v5 = &mut v0.revealcards2;
            let v6 = &mut v0.stage;
            let v7 = &mut v0.time;
            let v8 = &mut v0.action;
            reveal_look_cards_(false, arg1, 0x2::clock::timestamp_ms(arg2), v5, v6, v7, v8);
        };
    }

    fun reveal_look_cards_(arg0: bool, arg1: vector<u8>, arg2: u64, arg3: &mut vector<u8>, arg4: &mut u8, arg5: &mut u64, arg6: &mut bool) {
        assert!(arg6 != &arg0, 5);
        let v0 = 6;
        assert!(arg4 == &v0, 7);
        assert!(verification_cards3(&arg1), 9);
        *arg3 = arg1;
        *arg5 = arg2;
        *arg6 = arg0;
        *arg4 = 2;
    }

    fun show_cards(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0, (*0x1::vector::borrow<u8>(&arg1, 52) as u64)));
        0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0, (*0x1::vector::borrow<u8>(&arg1, 53) as u64)));
        0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0, (*0x1::vector::borrow<u8>(&arg1, 54) as u64)));
        v0
    }

    fun sort3(arg0: &mut vector<u8>) {
        if (*0x1::vector::borrow<u8>(arg0, 0) > *0x1::vector::borrow<u8>(arg0, 1)) {
            0x1::vector::swap<u8>(arg0, 0, 1);
        };
        if (*0x1::vector::borrow<u8>(arg0, 1) > *0x1::vector::borrow<u8>(arg0, 2)) {
            0x1::vector::swap<u8>(arg0, 1, 2);
        };
        if (*0x1::vector::borrow<u8>(arg0, 0) > *0x1::vector::borrow<u8>(arg0, 1)) {
            0x1::vector::swap<u8>(arg0, 0, 1);
        };
    }

    fun sub_vector(arg0: &vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        while (arg1 < arg2) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    public fun test(arg0: vector<u8>, arg1: vector<u8>) {
        let v0 = Testout{result: result_cards(true, arg0, arg1)};
        0x2::event::emit<Testout>(v0);
    }

    fun verification_cards3(arg0: &vector<u8>) : bool {
        let v0 = *0x1::vector::borrow<u8>(arg0, 0);
        let v1 = *0x1::vector::borrow<u8>(arg0, 1);
        let v2 = *0x1::vector::borrow<u8>(arg0, 2);
        if (v0 == v1 || v0 == v2 || v1 == v2) {
            return false
        };
        if (v0 > 51 || v1 > 51 || v2 > 51) {
            return false
        };
        true
    }

    fun verification_cards52(arg0: &vector<u8>) : bool {
        let v0 = 1;
        while (v0 < 53) {
            if (!0x1::vector::contains<u8>(arg0, &v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    fun verification_reveal(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 3) {
            if (*0x1::vector::borrow<u8>(arg0, v0) != *0x1::vector::borrow<u8>(arg1, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    // decompiled from Move bytecode v6
}

