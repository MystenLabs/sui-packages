module 0x536a29e1ffe898ad5cf16d58722503c356087a3185d434a841874764544f058b::n {
    struct O has drop, store {
        id: u8,
        fid: address,
        ct: 0x1::ascii::String,
        pfi: address,
        pio: address,
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

    // decompiled from Move bytecode v6
}

