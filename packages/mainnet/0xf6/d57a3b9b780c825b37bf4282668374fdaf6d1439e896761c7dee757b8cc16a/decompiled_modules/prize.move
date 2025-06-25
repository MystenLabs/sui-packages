module 0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::prize {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct RankPrize has store {
        start_rank: u64,
        end_rank: u64,
        prize_amount: u64,
    }

    struct Prize<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        claimed: 0x2::table::Table<address, u64>,
        rank_prize: vector<RankPrize>,
        amount: u64,
    }

    entry fun add_prize_event<T0>(arg0: &mut 0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::PlayManager, arg1: &0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::AdminCap, arg2: vector<u8>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg8) > 0, 13906834393386844163);
        assert!(0x1::vector::length<u64>(&arg8) == 0x1::vector::length<u64>(&arg9), 13906834397681811459);
        assert!(0x1::vector::length<u64>(&arg8) == 0x1::vector::length<u64>(&arg10), 13906834401976778755);
        let v0 = 0x1::vector::empty<RankPrize>();
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg8)) {
            let v4 = *0x1::vector::borrow<u64>(&arg8, v1);
            assert!(v4 == v2 + 1, 13906834444926451715);
            let v5 = *0x1::vector::borrow<u64>(&arg9, v1);
            assert!(v5 >= v4, 13906834457811353603);
            v2 = v5;
            let v6 = *0x1::vector::borrow<u64>(&arg10, v1);
            v3 = v3 + v6 * (v5 - v4 + 1);
            let v7 = RankPrize{
                start_rank   : v4,
                end_rank     : v5,
                prize_amount : v6,
            };
            0x1::vector::push_back<RankPrize>(&mut v0, v7);
            v1 = v1 + 1;
        };
        let v8 = 0x2::coin::into_balance<T0>(arg3);
        assert!(v3 == 0x2::balance::value<T0>(&v8), 13906834517940895747);
        assert!(arg7 >= v2, 13906834522235863043);
        0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::add_event<Witness>(arg0, arg2, arg4, arg5, arg6, arg7, arg1, arg11, arg12);
        let v9 = Witness{dummy_field: false};
        let v10 = Prize<T0>{
            id         : 0x2::object::new(arg12),
            balance    : v8,
            claimed    : 0x2::table::new<address, u64>(arg12),
            rank_prize : v0,
            amount     : v3,
        };
        let v11 = Witness{dummy_field: false};
        0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::add_event_dynamic_field<vector<u8>, Prize<T0>, Witness>(arg0, arg2, 0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::current_event_key(0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::borrow_event_group<Witness>(arg0, arg2, v9)), b"prize", v10, v11);
    }

    entry fun claim_prize<T0>(arg0: &mut 0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::PlayManager, arg1: vector<u8>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        let v1 = Witness{dummy_field: false};
        let v2 = 0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::borrow_event<Witness>(0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::borrow_event_group<Witness>(arg0, arg1, v0), arg2, v1);
        assert!(0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::is_ended(v2, arg3), 13906834698329784327);
        let v3 = 0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::get_user_rank(v2, 0x2::tx_context::sender(arg4));
        assert!(0x1::option::is_some<u64>(&v3), 13906834715509522437);
        let v4 = Witness{dummy_field: false};
        let v5 = 0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::borrow_mut_event_dynamic_field<vector<u8>, Prize<T0>, Witness>(arg0, arg1, arg2, b"prize", v4);
        assert!(!0x2::table::contains<address, u64>(&v5.claimed, 0x2::tx_context::sender(arg4)), 13906834754163965953);
        let v6 = get_prize_amount(*0x1::option::borrow<u64>(&v3), &v5.rank_prize);
        assert!(v6 > 0, 13906834771344097285);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v5.balance, v6), arg4), 0x2::tx_context::sender(arg4));
        0x2::table::add<address, u64>(&mut v5.claimed, 0x2::tx_context::sender(arg4), v6);
    }

    fun get_prize_amount(arg0: u64, arg1: &vector<RankPrize>) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<RankPrize>(arg1)) {
            let v1 = 0x1::vector::borrow<RankPrize>(arg1, v0);
            if (arg0 >= v1.start_rank && arg0 <= v1.end_rank) {
                return v1.prize_amount
            };
            v0 = v0 + 1;
        };
        0
    }

    fun get_unallocated_prize_amount(arg0: u64, arg1: &vector<RankPrize>) : u64 {
        let v0 = 0x1::vector::length<RankPrize>(arg1);
        let v1 = 0;
        while (v0 > 0) {
            v0 = v0 - 1;
            let v2 = 0x1::vector::borrow<RankPrize>(arg1, v0);
            if (arg0 >= v2.end_rank) {
                break
            };
            let v3 = if (arg0 >= v2.start_rank) {
                v2.end_rank - arg0
            } else {
                v2.end_rank - v2.start_rank + 1
            };
            v1 = v1 + v3 * v2.prize_amount;
        };
        v1
    }

    entry fun reclaim_unallocated_prize<T0>(arg0: &mut 0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::PlayManager, arg1: &0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::AdminCap, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        let v1 = Witness{dummy_field: false};
        let v2 = 0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::borrow_event<Witness>(0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::borrow_event_group<Witness>(arg0, arg2, v0), arg3, v1);
        assert!(0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::is_ended(v2, arg4), 13906834861538541575);
        let v3 = 0x1::vector::length<0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::UserRank>(0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::ranks(v2));
        let v4 = Witness{dummy_field: false};
        let v5 = 0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager::borrow_mut_event_dynamic_field<vector<u8>, Prize<T0>, Witness>(arg0, arg2, arg3, b"prize", v4);
        let v6 = get_unallocated_prize_amount(v3, &v5.rank_prize);
        assert!(v6 > 0, 13906834917373247497);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v5.balance, v6), arg5), 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

