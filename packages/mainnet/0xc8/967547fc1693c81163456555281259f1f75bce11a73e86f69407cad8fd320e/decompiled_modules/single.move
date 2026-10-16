module 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::single {
    struct QuoterKey has copy, drop, store {
        dummy_field: bool,
    }

    struct NoncesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CapsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct TotalKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Window has copy, drop, store {
        start_ms: u64,
        start_supply: u64,
        minted: u64,
    }

    struct QuoterSet has copy, drop {
        index: 0x2::object::ID,
        public_key: vector<u8>,
    }

    struct SingleMinted has copy, drop {
        index: 0x2::object::ID,
        coin: 0x1::type_name::TypeName,
        user: address,
        amount_in: u64,
        value_mist: u64,
        nav_per_sti: u64,
        weight_after_bps: u64,
        over_bps: u64,
        premium_bps: u64,
        sti_out: u64,
        nonce: u64,
    }

    fun bump_nonce<T0>(arg0: &mut 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: address, arg2: u64) {
        let v0 = NoncesKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<NoncesKey, 0x2::table::Table<address, u64>>(0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::uid_mut<T0>(arg0), v0);
        if (0x2::table::contains<address, u64>(v1, arg1)) {
            *0x2::table::borrow_mut<address, u64>(v1, arg1) = arg2 + 1;
        } else {
            0x2::table::add<address, u64>(v1, arg1, arg2 + 1);
        };
    }

    public fun cap_used<T0>(arg0: &0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: 0x1::type_name::TypeName, arg2: u64) : (u64, u64) {
        let v0 = 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::uid<T0>(arg0);
        let v1 = CapsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<CapsKey>(v0, v1)) {
            return (0, mul_div(0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::supply<T0>(arg0), 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::rule<T0>(arg0, 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::rules::single_daily_cap_bps()), 10000))
        };
        let v2 = CapsKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow<CapsKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, Window>>(v0, v2);
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, Window>(v3, &arg1)) {
            return (0, mul_div(0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::supply<T0>(arg0), 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::rule<T0>(arg0, 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::rules::single_daily_cap_bps()), 10000))
        };
        let v4 = 0x2::vec_map::get<0x1::type_name::TypeName, Window>(v3, &arg1);
        if (arg2 >= v4.start_ms + 86400000) {
            (0, mul_div(0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::supply<T0>(arg0), 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::rule<T0>(arg0, 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::rules::single_daily_cap_bps()), 10000))
        } else {
            (v4.minted, mul_div(v4.start_supply, 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::rule<T0>(arg0, 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::rules::single_daily_cap_bps()), 10000))
        }
    }

    public fun message(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: u64, arg8: u64) : vector<u8> {
        let v0 = b"STI_SINGLE_MINT_V1";
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::type_name::TypeName>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg6));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg7));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg8));
        v0
    }

    public fun mint<T0, T1>(arg0: &mut 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::assert_live<T0>(arg0);
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::assert_mintable<T0>(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = 0x2::tx_context::sender(arg8);
        let v3 = 0x2::coin::value<T1>(&arg1);
        let v4 = if (v3 > 0) {
            if (arg2 > 0) {
                arg3 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, 407);
        let v5 = 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::rule<T0>(arg0, 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::rules::single_daily_cap_bps());
        assert!(v5 > 0, 408);
        let v6 = quoter<T0>(arg0);
        assert!(!0x1::vector::is_empty<u8>(&v6), 400);
        assert!(v0 <= arg5, 402);
        assert!(arg5 <= v0 + 120000, 403);
        let v7 = next_nonce<T0>(arg0, v2);
        let v8 = message(0x2::object::id<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>>(arg0), v1, v3, arg2, arg3, arg4, v2, v7, arg5);
        assert!(0x2::ed25519::ed25519_verify(&arg6, &v6, &v8), 401);
        let v9 = 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::target_bps<T0>(arg0, &v1);
        assert!(v9 > 0 && !0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::is_retiring<T0>(arg0, &v1), 404);
        let v10 = if (arg4 > v9) {
            arg4 - v9
        } else {
            0
        };
        assert!(v10 <= 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::rule<T0>(arg0, 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::rules::single_max_over_bps()), 405);
        let v11 = (((arg2 as u128) * 1000000000 / (arg3 as u128)) as u64);
        assert!(v11 > 0, 407);
        let v12 = 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::take_mint_window<T0>(arg0, v11, v0) + mul_div(v10, 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::rule<T0>(arg0, 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::rules::single_over_slope_bps()), 100);
        let v13 = mul_div(v11, 10000, 10000 + v12);
        assert!(v13 > 0, 407);
        take_cap<T0>(arg0, v1, v13, v5, v0);
        let v14 = 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::rule<T0>(arg0, 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::rules::single_total_cap_bps());
        take_total<T0>(arg0, v13, v14, v0);
        bump_nonce<T0>(arg0, v2, v7);
        let v15 = 0x2::coin::into_balance<T1>(arg1);
        let v16 = mul_div(v3 - mul_div(v3, 10000, 10000 + v12), 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::pol_share_bps<T0>(arg0), 10000);
        if (v16 > 0) {
            0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::pol_join<T0, T1>(arg0, 0x2::balance::split<T1>(&mut v15, v16), arg8);
        };
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::vault_join<T0, T1>(arg0, v15);
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::emit_minted<T0>(arg0, v13, v12);
        let v17 = SingleMinted{
            index            : 0x2::object::id<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>>(arg0),
            coin             : v1,
            user             : v2,
            amount_in        : v3,
            value_mist       : arg2,
            nav_per_sti      : arg3,
            weight_after_bps : arg4,
            over_bps         : v10,
            premium_bps      : v12,
            sti_out          : v13,
            nonce            : v7,
        };
        0x2::event::emit<SingleMinted>(v17);
        0x2::coin::from_balance<T0>(0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::vault_mint<T0>(arg0, v13), arg8)
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun next_nonce<T0>(arg0: &0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: address) : u64 {
        let v0 = 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::uid<T0>(arg0);
        let v1 = NoncesKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<NoncesKey>(v0, v1)) {
            return 0
        };
        let v2 = NoncesKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow<NoncesKey, 0x2::table::Table<address, u64>>(v0, v2);
        if (0x2::table::contains<address, u64>(v3, arg1)) {
            *0x2::table::borrow<address, u64>(v3, arg1)
        } else {
            0
        }
    }

    public fun quoter<T0>(arg0: &0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>) : vector<u8> {
        let v0 = 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::uid<T0>(arg0);
        let v1 = QuoterKey{dummy_field: false};
        if (0x2::dynamic_field::exists<QuoterKey>(v0, v1)) {
            let v3 = QuoterKey{dummy_field: false};
            *0x2::dynamic_field::borrow<QuoterKey, vector<u8>>(v0, v3)
        } else {
            b""
        }
    }

    public fun set_quoter<T0>(arg0: &mut 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: &0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::GuardianCap, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::version_ok<T0>(arg0);
        0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::assert_guardian<T0>(arg0, arg1);
        assert!(0x1::vector::is_empty<u8>(&arg2) || 0x1::vector::length<u8>(&arg2) == 32, 409);
        let v0 = 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::uid_mut<T0>(arg0);
        let v1 = QuoterKey{dummy_field: false};
        if (0x2::dynamic_field::exists<QuoterKey>(v0, v1)) {
            let v2 = QuoterKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<QuoterKey, vector<u8>>(v0, v2) = arg2;
        } else {
            let v3 = QuoterKey{dummy_field: false};
            0x2::dynamic_field::add<QuoterKey, vector<u8>>(v0, v3, arg2);
        };
        let v4 = NoncesKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<NoncesKey>(v0, v4)) {
            let v5 = NoncesKey{dummy_field: false};
            0x2::dynamic_field::add<NoncesKey, 0x2::table::Table<address, u64>>(v0, v5, 0x2::table::new<address, u64>(arg3));
        };
        let v6 = CapsKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<CapsKey>(v0, v6)) {
            let v7 = CapsKey{dummy_field: false};
            0x2::dynamic_field::add<CapsKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, Window>>(v0, v7, 0x2::vec_map::empty<0x1::type_name::TypeName, Window>());
        };
        let v8 = QuoterSet{
            index      : 0x2::object::id<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>>(arg0),
            public_key : arg2,
        };
        0x2::event::emit<QuoterSet>(v8);
    }

    fun take_cap<T0>(arg0: &mut 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::supply<T0>(arg0);
        let v1 = CapsKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<CapsKey, 0x2::vec_map::VecMap<0x1::type_name::TypeName, Window>>(0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::uid_mut<T0>(arg0), v1);
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, Window>(v2, &arg1)) {
            let v3 = Window{
                start_ms     : arg4,
                start_supply : v0,
                minted       : 0,
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, Window>(v2, arg1, v3);
        };
        let v4 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, Window>(v2, &arg1);
        if (arg4 >= v4.start_ms + 86400000) {
            let v5 = Window{
                start_ms     : arg4,
                start_supply : v0,
                minted       : 0,
            };
            *v4 = v5;
        };
        assert!(v4.minted + arg2 <= mul_div(v4.start_supply, arg3, 10000), 406);
        v4.minted = v4.minted + arg2;
    }

    fun take_total<T0>(arg0: &mut 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::supply<T0>(arg0);
        let v1 = 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::uid_mut<T0>(arg0);
        let v2 = TotalKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<TotalKey>(v1, v2)) {
            let v3 = TotalKey{dummy_field: false};
            let v4 = Window{
                start_ms     : arg3,
                start_supply : v0,
                minted       : 0,
            };
            0x2::dynamic_field::add<TotalKey, Window>(v1, v3, v4);
        };
        let v5 = TotalKey{dummy_field: false};
        let v6 = 0x2::dynamic_field::borrow_mut<TotalKey, Window>(v1, v5);
        if (arg3 >= v6.start_ms + 86400000) {
            let v7 = Window{
                start_ms     : arg3,
                start_supply : v0,
                minted       : 0,
            };
            *v6 = v7;
        };
        assert!(v6.minted + arg1 <= mul_div(v6.start_supply, arg2, 10000), 410);
        v6.minted = v6.minted + arg1;
    }

    public fun total_used<T0>(arg0: &0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::Index<T0>, arg1: u64) : (u64, u64) {
        let v0 = 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::uid<T0>(arg0);
        let v1 = TotalKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<TotalKey>(v0, v1)) {
            return (0, mul_div(0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::supply<T0>(arg0), 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::rule<T0>(arg0, 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::rules::single_total_cap_bps()), 10000))
        };
        let v2 = TotalKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow<TotalKey, Window>(v0, v2);
        if (arg1 >= v3.start_ms + 86400000) {
            (0, mul_div(0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::supply<T0>(arg0), 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::rule<T0>(arg0, 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::rules::single_total_cap_bps()), 10000))
        } else {
            (v3.minted, mul_div(v3.start_supply, 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::rule<T0>(arg0, 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::rules::single_total_cap_bps()), 10000))
        }
    }

    // decompiled from Move bytecode v7
}

