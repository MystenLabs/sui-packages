module 0xf8ee6671c195bb61ee5effbccb2c4fdf6492c7395d16f498c142468d38ad9e54::prize {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct RankPrize has store {
        start_rank: u64,
        end_rank: u64,
        prize_amount: u64,
    }

    struct Prize has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        claimed: 0x2::table::Table<address, u64>,
        rank_prize: vector<RankPrize>,
        amount: u64,
    }

    entry fun add_prize_event(arg0: &mut 0x15f9a9074a801634490cd688f66b2235d0eca971556d1e43a7ffa48c3ded2df8::play_manager::PlayManager, arg1: &0x15f9a9074a801634490cd688f66b2235d0eca971556d1e43a7ffa48c3ded2df8::play_manager::AdminCap, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg7) > 0, 9223372247308304387);
        assert!(0x1::vector::length<u64>(&arg7) == 0x1::vector::length<u64>(&arg8), 9223372251603271683);
        assert!(0x1::vector::length<u64>(&arg7) == 0x1::vector::length<u64>(&arg9), 9223372255898238979);
        let v0 = 0x1::vector::empty<RankPrize>();
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg7)) {
            let v4 = *0x1::vector::borrow<u64>(&arg7, v1);
            assert!(v4 == v2 + 1, 9223372298847911939);
            let v5 = *0x1::vector::borrow<u64>(&arg8, v1);
            assert!(v5 >= v4, 9223372311732813827);
            v2 = v5;
            let v6 = *0x1::vector::borrow<u64>(&arg9, v1);
            v3 = v3 + v6 * (v5 - v4 + 1);
            let v7 = RankPrize{
                start_rank   : v4,
                end_rank     : v5,
                prize_amount : v6,
            };
            0x1::vector::push_back<RankPrize>(&mut v0, v7);
            v1 = v1 + 1;
        };
        let v8 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        assert!(v3 == 0x2::balance::value<0x2::sui::SUI>(&v8), 9223372371862355971);
        assert!(arg6 >= v2, 9223372376157323267);
        0x15f9a9074a801634490cd688f66b2235d0eca971556d1e43a7ffa48c3ded2df8::play_manager::add_play_event<Witness>(arg0, arg3, arg4, arg5, arg6, arg1, arg10, arg11);
        let v9 = 0x15f9a9074a801634490cd688f66b2235d0eca971556d1e43a7ffa48c3ded2df8::play_manager::current_event_key<Witness>(arg0);
        let v10 = Prize{
            id         : 0x2::object::new(arg11),
            balance    : v8,
            claimed    : 0x2::table::new<address, u64>(arg11),
            rank_prize : v0,
            amount     : v3,
        };
        let v11 = Witness{dummy_field: false};
        0x15f9a9074a801634490cd688f66b2235d0eca971556d1e43a7ffa48c3ded2df8::play_manager::add_play_event_dynamic_field<vector<u8>, Prize, Witness>(arg0, 0x1::option::extract<u64>(&mut v9), b"prize", v10, v11);
    }

    entry fun claim_prize(arg0: &mut 0x15f9a9074a801634490cd688f66b2235d0eca971556d1e43a7ffa48c3ded2df8::play_manager::PlayManager, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x15f9a9074a801634490cd688f66b2235d0eca971556d1e43a7ffa48c3ded2df8::play_manager::borrow_play_event<Witness>(arg0, arg1);
        assert!(0x15f9a9074a801634490cd688f66b2235d0eca971556d1e43a7ffa48c3ded2df8::play_manager::is_ended(v0, arg2), 9223372526481440775);
        let v1 = 0x15f9a9074a801634490cd688f66b2235d0eca971556d1e43a7ffa48c3ded2df8::play_manager::get_user_rank(v0, 0x2::tx_context::sender(arg3));
        assert!(0x1::option::is_some<u64>(&v1), 9223372543661178885);
        let v2 = Witness{dummy_field: false};
        let v3 = 0x15f9a9074a801634490cd688f66b2235d0eca971556d1e43a7ffa48c3ded2df8::play_manager::borrow_mut_play_event_dynamic_field<vector<u8>, Prize, Witness>(arg0, arg1, b"prize", v2);
        assert!(!0x2::table::contains<address, u64>(&v3.claimed, 0x2::tx_context::sender(arg3)), 9223372578020655105);
        let v4 = get_prize_amount(*0x1::option::borrow<u64>(&v1), &v3.rank_prize);
        assert!(v4 > 0, 9223372595200786437);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3.balance, v4), arg3), 0x2::tx_context::sender(arg3));
        0x2::table::add<address, u64>(&mut v3.claimed, 0x2::tx_context::sender(arg3), v4);
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

    // decompiled from Move bytecode v6
}

