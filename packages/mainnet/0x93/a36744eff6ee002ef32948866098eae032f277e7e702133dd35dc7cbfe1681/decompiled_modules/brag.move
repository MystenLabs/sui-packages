module 0x93a36744eff6ee002ef32948866098eae032f277e7e702133dd35dc7cbfe1681::brag {
    struct GameData<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        fee: u8,
        vip_fee: u8,
        countdown: u64,
        gamenumber: u64,
    }

    struct WLock has key {
        id: 0x2::object::UID,
        data: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PokerData<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        player1: address,
        player2: address,
        sigcards1: vector<u8>,
        sigcards2: vector<u8>,
        revealcards1: vector<u8>,
        revealcards2: vector<u8>,
        stage: u8,
        bet: u64,
        min_bet: u64,
        max_bet: u64,
        time: u64,
        vip_p1: bool,
        vip_p2: bool,
        action: bool,
    }

    struct GnumberOpen<phantom T0> has copy, drop {
        result: u64,
        vol: u64,
        maxvol: u64,
    }

    struct GnumberCont<phantom T0> has copy, drop {
        result: u64,
        vol: u64,
        maxvol: u64,
    }

    struct GnumberClose<phantom T0> has copy, drop {
        result: u64,
    }

    struct Gvol<phantom T0> has copy, drop {
        vol: u64,
        player: address,
        expendORincome: bool,
    }

    public entry fun OpenCards<T0, T1>(arg0: u64, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut GameData<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, PokerData<T0>>(&mut arg3.id, arg0);
        assert!(v0.stage == 4, 7);
        assert!(0x2::tx_context::sender(arg4) == v0.player1 || 0x2::tx_context::sender(arg4) == v0.player2, 15);
        assert!(0x1::vector::length<u8>(&arg1) == 55, 11);
        let v1 = 0x2::balance::value<T0>(&v0.balance);
        let v2 = 0x2::coin::take<T0>(&mut v0.balance, v1, arg4);
        if (0x2::tx_context::sender(arg4) == v0.player1) {
            let v3 = 0x2::tx_context::sender(arg4);
            let v4 = &mut v0.stage;
            let v5 = &mut v0.time;
            0x2::coin::put<T0>(&mut arg3.balance, OpenCards_<T0>(1, true, v0.revealcards2, v0.sigcards1, arg2, arg1, v2, v1, v0.revealcards1, v0.player2, v3, v4, v5, arg3.fee, arg3.vip_fee, v0.vip_p2, v0.vip_p1, v0.action, arg4));
        } else {
            let v6 = 0x2::tx_context::sender(arg4);
            let v7 = &mut v0.stage;
            let v8 = &mut v0.time;
            0x2::coin::put<T0>(&mut arg3.balance, OpenCards_<T0>(2, false, v0.revealcards1, v0.sigcards2, arg2, arg1, v2, v1, v0.revealcards2, v0.player1, v6, v7, v8, arg3.fee, arg3.vip_fee, v0.vip_p1, v0.vip_p2, v0.action, arg4));
        };
    }

    fun OpenCards_<T0>(arg0: u8, arg1: bool, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x2::coin::Coin<T0>, arg7: u64, arg8: vector<u8>, arg9: address, arg10: address, arg11: &mut u8, arg12: &mut u64, arg13: u8, arg14: u8, arg15: bool, arg16: bool, arg17: bool, arg18: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg17 != arg1, 5);
        assert!(0x1::vector::length<u8>(&arg2) == 55, 6);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg3, &arg4, &arg5), 8);
        let v0 = sub_vector(&arg5, 52, 55);
        if (0x1::vector::length<u8>(&arg8) == 3) {
            assert!(verification_reveal(&arg8, &v0), 14);
        } else {
            assert!(verification_cards3(&v0), 9);
        };
        let v1 = sub_vector(&arg5, 0, 52);
        assert!(verification_cards52(&v1), 10);
        let v2 = result_cards(arg17, arg5, arg2);
        if (v2 == 0 || v2 == arg0) {
            let v3 = if (arg16) {
                arg7 / 10000 * (arg14 as u64)
            } else {
                arg7 / 10000 * (arg13 as u64)
            };
            let v4 = arg7 - v3;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg6, v4, arg18), arg10);
            if (arg0 == 1) {
                *arg11 = 11;
                *arg12 = 0;
            } else {
                *arg11 = 12;
                *arg12 = 0;
            };
            let v5 = Gvol<T0>{
                vol            : v4,
                player         : arg10,
                expendORincome : true,
            };
            0x2::event::emit<Gvol<T0>>(v5);
        } else {
            let v6 = if (arg15) {
                arg7 / 10000 * (arg14 as u64)
            } else {
                arg7 / 10000 * (arg13 as u64)
            };
            let v7 = arg7 - v6;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg6, v7, arg18), arg9);
            if (arg0 == 1) {
                *arg11 = 12;
                *arg12 = 0;
            } else {
                *arg11 = 11;
                *arg12 = 0;
            };
            let v8 = Gvol<T0>{
                vol            : v7,
                player         : arg9,
                expendORincome : true,
            };
            0x2::event::emit<Gvol<T0>>(v8);
        };
        0x2::coin::destroy_zero<T0>(arg6);
        0x2::coin::split<T0>(&mut arg6, 0x2::coin::value<T0>(&arg6), arg18)
    }

    public entry fun applyOpenCards<T0, T1>(arg0: u64, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut GameData<T0, T1>, arg6: &0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, PokerData<T0>>(&mut arg5.id, arg0);
        assert!(v0.stage < 4, 7);
        let v1 = 0x2::coin::value<T0>(&arg3);
        0x2::coin::put<T0>(&mut v0.balance, arg3);
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
        let v10 = Gvol<T0>{
            vol            : v1,
            player         : 0x2::tx_context::sender(arg6),
            expendORincome : false,
        };
        0x2::event::emit<Gvol<T0>>(v10);
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

    public entry fun apply_look_cards<T0, T1>(arg0: u64, arg1: &0x2::clock::Clock, arg2: &mut GameData<T0, T1>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, PokerData<T0>>(&mut arg2.id, arg0);
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

    public entry fun call<T0, T1>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut GameData<T0, T1>, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, PokerData<T0>>(&mut arg3.id, arg0);
        assert!(0x2::tx_context::sender(arg4) == v0.player1 || 0x2::tx_context::sender(arg4) == v0.player2, 15);
        assert!(v0.stage < 4, 7);
        let v1 = 0x2::coin::value<T0>(&arg1);
        0x2::coin::put<T0>(&mut v0.balance, arg1);
        if (0x2::tx_context::sender(arg4) == v0.player1) {
            let v2 = &mut v0.time;
            let v3 = &mut v0.action;
            call_(true, v0.revealcards2, v1, v0.bet, 0x2::clock::timestamp_ms(arg2), v2, v3);
        } else {
            let v4 = &mut v0.time;
            let v5 = &mut v0.action;
            call_(false, v0.revealcards1, v1, v0.bet, 0x2::clock::timestamp_ms(arg2), v4, v5);
        };
        let v6 = Gvol<T0>{
            vol            : v1,
            player         : 0x2::tx_context::sender(arg4),
            expendORincome : false,
        };
        0x2::event::emit<Gvol<T0>>(v6);
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

    public entry fun change_data_countdown_down<T0, T1>(arg0: &AdminCap, arg1: &mut GameData<T0, T1>, arg2: &mut WLock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg3) > arg2.data, 0);
        arg1.countdown = arg1.countdown - 10000;
        assert!(arg1.countdown > 20000, 1);
        arg2.data = 9999999;
    }

    public entry fun change_data_countdown_up<T0, T1>(arg0: &AdminCap, arg1: &mut GameData<T0, T1>, arg2: &mut WLock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg3) > arg2.data, 0);
        arg1.countdown = arg1.countdown + 10000;
        assert!(arg1.countdown < 120000, 1);
        arg2.data = 9999999;
    }

    public entry fun change_data_fee<T0, T1>(arg0: &AdminCap, arg1: u8, arg2: &mut GameData<T0, T1>, arg3: &mut WLock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg4) > arg3.data, 0);
        assert!(arg1 < 51, 1);
        arg2.fee = arg1;
        if (arg1 < 50) {
            arg2.vip_fee = 10;
        } else if (arg1 < 20) {
            arg2.vip_fee = 5;
        } else if (arg1 < 10) {
            arg2.vip_fee = 0;
        };
        arg3.data = 9999999;
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

    public entry fun create_game<T0, T1: store + key>(arg0: vector<u8>, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &mut GameData<T0, T1>, arg4: &0x2::kiosk::Kiosk, arg5: 0x2::object::ID, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 <= arg1, 2);
        arg3.gamenumber = arg3.gamenumber + 1;
        let v1 = false;
        if (0x2::kiosk::has_item_with_type<T1>(arg4, arg5) && 0x2::kiosk::owner(arg4) == 0x2::tx_context::sender(arg6)) {
            v1 = true;
        };
        let v2 = PokerData<T0>{
            id           : 0x2::object::new(arg6),
            balance      : 0x2::coin::into_balance<T0>(arg2),
            player1      : 0x2::tx_context::sender(arg6),
            player2      : @0x0,
            sigcards1    : arg0,
            sigcards2    : 0x1::vector::empty<u8>(),
            revealcards1 : 0x1::vector::empty<u8>(),
            revealcards2 : 0x1::vector::empty<u8>(),
            stage        : 10,
            bet          : v0,
            min_bet      : v0,
            max_bet      : arg1,
            time         : 0,
            vip_p1       : v1,
            vip_p2       : false,
            action       : false,
        };
        0x2::dynamic_object_field::add<u64, PokerData<T0>>(&mut arg3.id, arg3.gamenumber, v2);
        let v3 = GnumberOpen<T0>{
            result : arg3.gamenumber,
            vol    : v0,
            maxvol : arg1,
        };
        0x2::event::emit<GnumberOpen<T0>>(v3);
    }

    public entry fun fold<T0, T1>(arg0: u64, arg1: &0x2::clock::Clock, arg2: &mut GameData<T0, T1>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, PokerData<T0>>(&mut arg2.id, arg0);
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
            let v5 = if (*0x1::vector::borrow<u8>(&v1, 2) - *0x1::vector::borrow<u8>(&v1, 0) == 2 && *0x1::vector::borrow<u8>(&v1, 2) - *0x1::vector::borrow<u8>(&v1, 1) == 1) {
                true
            } else if (*0x1::vector::borrow<u8>(&v1, 0) == 1) {
                if (*0x1::vector::borrow<u8>(&v1, 1) == 12) {
                    *0x1::vector::borrow<u8>(&v1, 2) == 13
                } else {
                    false
                }
            } else {
                false
            };
            if (v4 && v5) {
                5
            } else if (v5) {
                4
            } else if (v4) {
                3
            } else {
                let v6 = if (*0x1::vector::borrow<u8>(&v1, 0) == *0x1::vector::borrow<u8>(&v1, 1)) {
                    true
                } else if (*0x1::vector::borrow<u8>(&v1, 1) == *0x1::vector::borrow<u8>(&v1, 2)) {
                    true
                } else {
                    *0x1::vector::borrow<u8>(&v1, 0) == *0x1::vector::borrow<u8>(&v1, 2)
                };
                if (v6) {
                    2
                } else {
                    1
                }
            }
        }
    }

    public entry fun get_fee<T0, T1>(arg0: &AdminCap, arg1: address, arg2: u64, arg3: &mut GameData<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg3.balance, arg2, arg4), arg1);
    }

    public entry fun get_fold_bets<T0, T1>(arg0: u64, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut GameData<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, PokerData<T0>>(&mut arg3.id, arg0);
        assert!(0x2::tx_context::sender(arg4) == v0.player1 || 0x2::tx_context::sender(arg4) == v0.player2, 15);
        assert!(v0.stage == 5, 7);
        let v1 = 0x2::balance::value<T0>(&v0.balance);
        if (0x2::tx_context::sender(arg4) == v0.player1) {
            let v2 = if (v0.vip_p1) {
                v1 / 10000 * (arg3.vip_fee as u64)
            } else {
                v1 / 10000 * (arg3.fee as u64)
            };
            0x2::coin::put<T0>(&mut arg3.balance, 0x2::coin::take<T0>(&mut v0.balance, v2, arg4));
            let v3 = v1 - v2;
            let v4 = &mut v0.stage;
            let v5 = &mut v0.time;
            get_fold_bets_<T0>(true, v0.action, v0.sigcards1, arg2, arg1, 0x2::coin::take<T0>(&mut v0.balance, v3, arg4), v0.revealcards1, v3, v4, v5, 0x2::tx_context::sender(arg4));
        } else {
            let v2 = if (v0.vip_p2) {
                v1 / 10000 * (arg3.vip_fee as u64)
            } else {
                v1 / 10000 * (arg3.fee as u64)
            };
            0x2::coin::put<T0>(&mut arg3.balance, 0x2::coin::take<T0>(&mut v0.balance, v2, arg4));
            let v6 = v1 - v2;
            let v7 = &mut v0.stage;
            let v8 = &mut v0.time;
            get_fold_bets_<T0>(false, v0.action, v0.sigcards2, arg2, arg1, 0x2::coin::take<T0>(&mut v0.balance, v6, arg4), v0.revealcards2, v6, v7, v8, 0x2::tx_context::sender(arg4));
        };
    }

    fun get_fold_bets_<T0>(arg0: bool, arg1: bool, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x2::coin::Coin<T0>, arg6: vector<u8>, arg7: u64, arg8: &mut u8, arg9: &mut u64, arg10: address) {
        assert!(arg1 != arg0, 5);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg2, &arg3, &arg4), 8);
        if (0x1::vector::length<u8>(&arg6) == 3) {
            let v0 = sub_vector(&arg4, 52, 55);
            assert!(verification_reveal(&arg6, &v0), 14);
        };
        let v1 = sub_vector(&arg4, 0, 52);
        assert!(verification_cards52(&v1), 10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg5, arg10);
        if (arg0) {
            *arg8 = 11;
            *arg9 = 0;
        } else {
            *arg8 = 12;
            *arg9 = 0;
        };
        let v2 = Gvol<T0>{
            vol            : arg7,
            player         : arg10,
            expendORincome : true,
        };
        0x2::event::emit<Gvol<T0>>(v2);
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

    public entry fun get_timeout_bets<T0, T1>(arg0: u64, arg1: &0x2::clock::Clock, arg2: &mut GameData<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
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
            min_bet      : _,
            max_bet      : _,
            time         : v12,
            vip_p1       : v13,
            vip_p2       : v14,
            action       : v15,
        } = 0x2::dynamic_object_field::remove<u64, PokerData<T0>>(&mut arg2.id, arg0);
        let v16 = v1;
        assert!(v12 > 0 && 0x2::clock::timestamp_ms(arg1) - arg2.countdown > v12, 12);
        let v17 = 0x2::balance::value<T0>(&v16);
        if (v15) {
            let v18 = if (v13) {
                v17 / 10000 * (arg2.vip_fee as u64)
            } else {
                v17 / 10000 * (arg2.fee as u64)
            };
            0x2::coin::put<T0>(&mut arg2.balance, 0x2::coin::take<T0>(&mut v16, v18, arg3));
            let v19 = v17 - v18;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v16, v19, arg3), v2);
            let v20 = Gvol<T0>{
                vol            : v19,
                player         : v2,
                expendORincome : true,
            };
            0x2::event::emit<Gvol<T0>>(v20);
        } else {
            let v18 = if (v14) {
                v17 / 10000 * (arg2.vip_fee as u64)
            } else {
                v17 / 10000 * (arg2.fee as u64)
            };
            0x2::coin::put<T0>(&mut arg2.balance, 0x2::coin::take<T0>(&mut v16, v18, arg3));
            let v21 = v17 - v18;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v16, v21, arg3), v3);
            let v22 = Gvol<T0>{
                vol            : v21,
                player         : v3,
                expendORincome : true,
            };
            0x2::event::emit<Gvol<T0>>(v22);
        };
        0x2::balance::destroy_zero<T0>(v16);
        0x2::object::delete(v0);
        let v23 = GnumberClose<T0>{result: arg0};
        0x2::event::emit<GnumberClose<T0>>(v23);
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

    public entry fun go_on_playing<T0, T1>(arg0: u64, arg1: vector<u8>, arg2: 0x2::coin::Coin<T0>, arg3: &mut GameData<T0, T1>, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, PokerData<T0>>(&mut arg3.id, arg0);
        assert!(0x2::tx_context::sender(arg4) == v0.player1 || 0x2::tx_context::sender(arg4) == v0.player2, 13);
        assert!(v0.stage == 11 || v0.stage == 12, 7);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 >= v0.min_bet && v1 <= v0.max_bet, 2);
        0x2::coin::put<T0>(&mut v0.balance, arg2);
        if (v0.stage == 11) {
            if (0x2::tx_context::sender(arg4) == v0.player1) {
                v0.player2 = 0x2::tx_context::sender(arg4);
                v0.player1 = @0x0;
                v0.sigcards2 = arg1;
                v0.sigcards1 = 0x1::vector::empty<u8>();
                if (v0.vip_p2 != v0.vip_p1) {
                    v0.vip_p2 = v0.vip_p1;
                };
            } else {
                v0.player1 = 0x2::tx_context::sender(arg4);
                v0.player2 = @0x0;
                v0.sigcards1 = arg1;
                v0.sigcards2 = 0x1::vector::empty<u8>();
                if (v0.vip_p2 != v0.vip_p1) {
                    v0.vip_p1 = v0.vip_p2;
                };
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
        let v2 = GnumberCont<T0>{
            result : arg0,
            vol    : v1,
            maxvol : v0.max_bet,
        };
        0x2::event::emit<GnumberCont<T0>>(v2);
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
        let v1 = WLock{
            id   : 0x2::object::new(arg0),
            data : 99999999,
        };
        0x2::transfer::share_object<WLock>(v1);
    }

    public entry fun initgamedata<T0, T1>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GameData<T0, T1>{
            id         : 0x2::object::new(arg1),
            balance    : 0x2::balance::zero<T0>(),
            fee        : 50,
            vip_fee    : 10,
            countdown  : 60000,
            gamenumber : 0,
        };
        0x2::transfer::share_object<GameData<T0, T1>>(v0);
    }

    public entry fun join_game<T0, T1: store + key>(arg0: u64, arg1: vector<u8>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut GameData<T0, T1>, arg5: &0x2::kiosk::Kiosk, arg6: 0x2::object::ID, arg7: &0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, PokerData<T0>>(&mut arg4.id, arg0);
        assert!(0x2::coin::value<T0>(&arg2) == v0.bet, 2);
        assert!(v0.player2 == @0x0, 4);
        v0.player2 = 0x2::tx_context::sender(arg7);
        v0.sigcards2 = arg1;
        v0.stage = 0;
        v0.time = 0x2::clock::timestamp_ms(arg3);
        if (0x2::kiosk::has_item_with_type<T1>(arg5, arg6) && 0x2::kiosk::owner(arg5) == 0x2::tx_context::sender(arg7)) {
            v0.vip_p2 = true;
        };
        0x2::coin::put<T0>(&mut v0.balance, arg2);
        let v1 = GnumberClose<T0>{result: arg0};
        0x2::event::emit<GnumberClose<T0>>(v1);
    }

    public entry fun join_playing<T0, T1: store + key>(arg0: u64, arg1: vector<u8>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut GameData<T0, T1>, arg5: &0x2::kiosk::Kiosk, arg6: 0x2::object::ID, arg7: &0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, PokerData<T0>>(&mut arg4.id, arg0);
        assert!(0x2::coin::value<T0>(&arg2) == v0.bet, 2);
        assert!(v0.player2 == @0x0 || v0.player1 == @0x0, 4);
        let v1 = false;
        if (0x2::kiosk::has_item_with_type<T1>(arg5, arg6) && 0x2::kiosk::owner(arg5) == 0x2::tx_context::sender(arg7)) {
            v1 = true;
        };
        if (v0.player2 == @0x0) {
            v0.player2 = 0x2::tx_context::sender(arg7);
            v0.sigcards2 = arg1;
            if (v0.vip_p2 != v1) {
                v0.vip_p2 = v1;
            };
        } else {
            v0.player1 = 0x2::tx_context::sender(arg7);
            v0.sigcards1 = arg1;
            if (v0.vip_p1 != v1) {
                v0.vip_p1 = v1;
            };
        };
        v0.stage = 0;
        v0.time = 0x2::clock::timestamp_ms(arg3);
        0x2::coin::put<T0>(&mut v0.balance, arg2);
        let v2 = GnumberClose<T0>{result: arg0};
        0x2::event::emit<GnumberClose<T0>>(v2);
    }

    public entry fun leave_game<T0, T1>(arg0: u64, arg1: &mut GameData<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
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
            min_bet      : _,
            max_bet      : _,
            time         : _,
            vip_p1       : _,
            vip_p2       : _,
            action       : _,
        } = 0x2::dynamic_object_field::remove<u64, PokerData<T0>>(&mut arg1.id, arg0);
        let v16 = v1;
        let v17 = if (0x2::tx_context::sender(arg2) == v2) {
            true
        } else if (0x2::tx_context::sender(arg2) == v3) {
            true
        } else {
            0x2::tx_context::sender(arg2) == @0x82242fabebc3e6e331c3d5c6de3d34ff965671b75154ec1cb9e00aa437bbfa44
        };
        assert!(v17, 13);
        let v18 = if (v8 == 10) {
            true
        } else if (v8 == 11) {
            true
        } else {
            v8 == 12
        };
        assert!(v18, 7);
        if (v8 == 10) {
            if (v2 != @0x0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v16, 0x2::balance::value<T0>(&v16), arg2), v2);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v16, 0x2::balance::value<T0>(&v16), arg2), v3);
            };
        };
        0x2::balance::destroy_zero<T0>(v16);
        0x2::object::delete(v0);
        let v19 = GnumberClose<T0>{result: arg0};
        0x2::event::emit<GnumberClose<T0>>(v19);
    }

    public entry fun rasie<T0, T1>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut GameData<T0, T1>, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, PokerData<T0>>(&mut arg3.id, arg0);
        assert!(0x2::tx_context::sender(arg4) == v0.player1 || 0x2::tx_context::sender(arg4) == v0.player2, 15);
        assert!(v0.stage < 4, 7);
        let v1 = 0x2::coin::value<T0>(&arg1);
        0x2::coin::put<T0>(&mut v0.balance, arg1);
        if (0x2::tx_context::sender(arg4) == v0.player1) {
            let v2 = &mut v0.bet;
            let v3 = &mut v0.time;
            let v4 = &mut v0.action;
            rasie_(true, v0.revealcards2, v1, v0.max_bet, 0x2::clock::timestamp_ms(arg2), v2, v3, v4);
        } else {
            let v5 = &mut v0.bet;
            let v6 = &mut v0.time;
            let v7 = &mut v0.action;
            rasie_(false, v0.revealcards1, v1, v0.max_bet, 0x2::clock::timestamp_ms(arg2), v5, v6, v7);
        };
        let v8 = Gvol<T0>{
            vol            : v1,
            player         : 0x2::tx_context::sender(arg4),
            expendORincome : false,
        };
        0x2::event::emit<Gvol<T0>>(v8);
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

    public entry fun reveal_look_cards<T0, T1>(arg0: u64, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut GameData<T0, T1>, arg4: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) == 3, 6);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, PokerData<T0>>(&mut arg3.id, arg0);
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

    public entry fun test(arg0: vector<u8>, arg1: vector<u8>) : u8 {
        result_cards(true, arg0, arg1)
    }

    fun verification_cards3(arg0: &vector<u8>) : bool {
        let v0 = *0x1::vector::borrow<u8>(arg0, 0);
        let v1 = *0x1::vector::borrow<u8>(arg0, 1);
        let v2 = *0x1::vector::borrow<u8>(arg0, 2);
        let v3 = if (v0 == v1) {
            true
        } else if (v0 == v2) {
            true
        } else {
            v1 == v2
        };
        if (v3) {
            return false
        };
        let v4 = if (v0 > 51) {
            true
        } else if (v1 > 51) {
            true
        } else {
            v2 > 51
        };
        if (v4) {
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

