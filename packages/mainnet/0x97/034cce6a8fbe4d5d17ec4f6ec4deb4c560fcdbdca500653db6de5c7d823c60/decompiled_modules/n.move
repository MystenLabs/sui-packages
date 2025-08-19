module 0x97034cce6a8fbe4d5d17ec4f6ec4deb4c560fcdbdca500653db6de5c7d823c60::n {
    struct NC has store {
        vp: 0x2::vec_map::VecMap<address, P>,
        o: 0x2::bag::Bag,
    }

    struct P has drop, store {
        id: address,
        ct: 0x1::ascii::String,
        d: u8,
    }

    struct O has drop, store {
        id: u8,
        d: u8,
        fid: address,
        ct: 0x1::ascii::String,
        pfi: address,
        pio: address,
    }

    struct U has copy, drop {
        id: u8,
        s: u256,
        b: u256,
    }

    struct R has copy, drop {
        id: u8,
        oid: u8,
        ct: 0x1::ascii::String,
        ts: u256,
        sc: u256,
        sr: u256,
        si: u256,
        tb: u256,
        bc: u256,
        br: u256,
        bi: u256,
        tbe: u256,
        tf: u256,
        ltv: u256,
        bre: u256,
        m: u256,
        jm: u256,
        rf: u256,
        ou: u256,
        lr: u256,
        lb: u256,
        lt: u256,
        u: u64,
    }

    public(friend) fun cnc(arg0: &mut 0x2::tx_context::TxContext) : NC {
        NC{
            vp : 0x2::vec_map::empty<address, P>(),
            o  : 0x2::bag::new(arg0),
        }
    }

    public(friend) fun cnp<T0>(arg0: &mut NC, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>) {
        let v0 = 0x2::object::uid_to_address(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::uid<T0>(arg1));
        assert!(!0x2::vec_map::contains<address, P>(&arg0.vp, &v0), 6004000);
        let v1 = P{
            id : 0x2::object::uid_to_address(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::uid<T0>(arg1)),
            ct : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            d  : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::get_coin_decimal<T0>(arg1),
        };
        0x2::vec_map::insert<address, P>(&mut arg0.vp, 0x2::object::uid_to_address(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::uid<T0>(arg1)), v1);
    }

    public fun osp(arg0: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: u64, arg4: u64) : (vector<O>, bool) {
        let v0 = false;
        let v1 = v0;
        let v2 = 0x1::vector::empty<O>();
        let v3 = 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::get_vec_feeds(arg0);
        if (arg3 >= 0x1::vector::length<address>(&v3)) {
            return (v2, v0)
        };
        let v4 = arg3 + arg4;
        let v5 = v4;
        if (v4 > 0x1::vector::length<address>(&v3)) {
            v5 = 0x1::vector::length<address>(&v3);
        };
        while (arg3 < v5) {
            let v6 = 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::get_price_feed(arg0, *0x1::vector::borrow<address>(&v3, arg3));
            let v7 = 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_provider::pyth_provider();
            assert!(0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::get_primary_oracle_provider(v6) == &v7, 6004001);
            let v8 = 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::get_pair_id_from_feed(v6, 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_provider::pyth_provider());
            let v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_price_info_object_id(arg2, v8);
            let v10 = O{
                id  : 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::get_oracle_id_from_feed(v6),
                d   : 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::safe_decimal(arg1, 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::get_oracle_id_from_feed(v6)),
                fid : 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::get_price_feed_id_from_feed(v6),
                ct  : 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::get_coin_type_from_feed(v6),
                pfi : 0x2::address::from_bytes(v8),
                pio : 0x2::object::id_to_address(&v9),
            };
            0x1::vector::push_back<O>(&mut v2, v10);
            arg3 = arg3 + 1;
        };
        if (arg3 + arg4 < 0x1::vector::length<address>(&v3)) {
            v1 = true;
        };
        (v2, v1)
    }

    public fun psp(arg0: &NC, arg1: u64, arg2: u64) : (vector<P>, bool) {
        let v0 = false;
        let v1 = v0;
        let v2 = 0x1::vector::empty<P>();
        let v3 = 0x2::vec_map::keys<address, P>(&arg0.vp);
        if (arg1 >= 0x1::vector::length<address>(&v3)) {
            return (v2, v0)
        };
        let v4 = arg1 + arg2;
        let v5 = v4;
        if (v4 > 0x1::vector::length<address>(&v3)) {
            v5 = 0x1::vector::length<address>(&v3);
        };
        while (arg1 < v5) {
            let v6 = 0x2::vec_map::get<address, P>(&arg0.vp, 0x1::vector::borrow<address>(&v3, arg1));
            let v7 = P{
                id : v6.id,
                ct : v6.ct,
                d  : v6.d,
            };
            0x1::vector::push_back<P>(&mut v2, v7);
            arg1 = arg1 + 1;
        };
        if (arg1 + arg2 < 0x1::vector::length<address>(&v3)) {
            v1 = true;
        };
        (v2, v1)
    }

    public fun rsp(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u64, arg2: u64) : (vector<R>, bool) {
        let v0 = false;
        let v1 = v0;
        let v2 = 0x1::vector::empty<R>();
        let v3 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_reserves_count(arg0);
        if (arg1 >= (v3 as u64)) {
            return (v2, v0)
        };
        let v4 = arg1 + arg2;
        let v5 = v4;
        if (v4 > (v3 as u64)) {
            v5 = (v3 as u64);
        };
        while (arg1 < v5) {
            let v6 = (arg1 as u8);
            let (v7, v8) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_current_rate(arg0, v6);
            let (v9, v10) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg0, v6);
            let (v11, v12) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_total_supply(arg0, v6);
            let (v13, v14, v15, v16, v17) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_borrow_rate_factors(arg0, v6);
            let (v18, v19, v20) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_liquidation_factors(arg0, v6);
            let v21 = R{
                id  : v6,
                oid : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_oracle_id(arg0, v6),
                ct  : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg0, v6),
                ts  : v11,
                sc  : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_supply_cap_ceiling(arg0, v6),
                sr  : v7,
                si  : v9,
                tb  : v12,
                bc  : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_borrow_cap_ceiling_ratio(arg0, v6),
                br  : v8,
                bi  : v10,
                tbe : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_treasury_balance(arg0, v6),
                tf  : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_treasury_factor(arg0, v6),
                ltv : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_asset_ltv(arg0, v6),
                bre : v13,
                m   : v14,
                jm  : v15,
                rf  : v16,
                ou  : v17,
                lr  : v18,
                lb  : v19,
                lt  : v20,
                u   : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_last_update_timestamp(arg0, v6),
            };
            0x1::vector::push_back<R>(&mut v2, v21);
            arg1 = arg1 + 1;
        };
        if (arg1 + arg2 < (v3 as u64)) {
            v1 = true;
        };
        (v2, v1)
    }

    public fun usp(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: address, arg2: u64, arg3: u64) : (vector<U>, bool) {
        let v0 = false;
        let v1 = v0;
        let v2 = 0x1::vector::empty<U>();
        let v3 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_reserves_count(arg0);
        if (arg2 >= (v3 as u64)) {
            return (v2, v0)
        };
        let v4 = arg2 + arg3;
        let v5 = v4;
        if (v4 > (v3 as u64)) {
            v5 = (v3 as u64);
        };
        while (arg2 < v5) {
            let v6 = (arg2 as u8);
            let (v7, v8) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, v6, arg1);
            let v9 = U{
                id : v6,
                s  : v7,
                b  : v8,
            };
            0x1::vector::push_back<U>(&mut v2, v9);
            arg2 = arg2 + 1;
        };
        if (arg2 + arg3 < (v3 as u64)) {
            v1 = true;
        };
        (v2, v1)
    }

    // decompiled from Move bytecode v6
}

