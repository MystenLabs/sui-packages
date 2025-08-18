module 0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::n {
    struct O has drop, store {
        id: u8,
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

    public fun os(arg0: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State) : vector<O> {
        let v0 = 0x1::vector::empty<O>();
        let v1 = 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::get_vec_feeds(arg0);
        while (!0x1::vector::is_empty<address>(&v1)) {
            let v2 = 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::get_price_feed(arg0, 0x1::vector::pop_back<address>(&mut v1));
            let v3 = 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_provider::pyth_provider();
            assert!(0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::get_primary_oracle_provider(v2) == &v3, 6004001);
            let v4 = 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::get_pair_id_from_feed(v2, 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_provider::pyth_provider());
            let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_price_info_object_id(arg1, v4);
            let v6 = O{
                id  : 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::get_oracle_id_from_feed(v2),
                fid : 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::get_price_feed_id_from_feed(v2),
                ct  : 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::get_coin_type_from_feed(v2),
                pfi : 0x2::address::from_bytes(v4),
                pio : 0x2::object::id_to_address(&v5),
            };
            0x1::vector::push_back<O>(&mut v0, v6);
        };
        v0
    }

    public fun osp(arg0: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: u64, arg3: u64) : (vector<O>, bool) {
        let v0 = false;
        let v1 = v0;
        let v2 = 0x1::vector::empty<O>();
        let v3 = 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::get_vec_feeds(arg0);
        if (arg2 >= 0x1::vector::length<address>(&v3)) {
            return (v2, v0)
        };
        let v4 = arg2 + arg3;
        let v5 = v4;
        if (v4 > 0x1::vector::length<address>(&v3)) {
            v5 = 0x1::vector::length<address>(&v3);
        };
        while (arg2 < v5) {
            let v6 = 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::get_price_feed(arg0, *0x1::vector::borrow<address>(&v3, arg2));
            let v7 = 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_provider::pyth_provider();
            assert!(0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::get_primary_oracle_provider(v6) == &v7, 6004002);
            let v8 = 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::get_pair_id_from_feed(v6, 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_provider::pyth_provider());
            let v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::get_price_info_object_id(arg1, v8);
            let v10 = O{
                id  : 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::get_oracle_id_from_feed(v6),
                fid : 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::get_price_feed_id_from_feed(v6),
                ct  : 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::get_coin_type_from_feed(v6),
                pfi : 0x2::address::from_bytes(v8),
                pio : 0x2::object::id_to_address(&v9),
            };
            0x1::vector::push_back<O>(&mut v2, v10);
            arg2 = arg2 + 1;
        };
        if (arg2 + arg3 < 0x1::vector::length<address>(&v3)) {
            v1 = true;
        };
        (v2, v1)
    }

    public fun us(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: address, arg2: u64, arg3: u64) : (vector<U>, bool) {
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
        };
        if (arg2 + arg3 < (v3 as u64)) {
            v1 = true;
        };
        (v2, v1)
    }

    // decompiled from Move bytecode v6
}

