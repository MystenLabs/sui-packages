module 0x30452ce56c29a5c3006654b9c7b8e3d84f2efc0af1ea80dad30d5c86e947e410::coral {
    struct CORAL has drop {
        dummy_field: bool,
    }

    struct CoralWitness has drop {
        dummy_field: bool,
    }

    struct CoralManagerCap has key {
        id: 0x2::object::UID,
    }

    public fun create_market_with_custom_topic<T0, T1>(arg0: &0x2::coin_registry::Currency<T0>, arg1: &0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::config::ProtocolConfig, arg2: &mut 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::protocol::Protocol, arg3: &0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::resolver::Resolver, arg4: vector<u8>, arg5: vector<u8>, arg6: 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::schema::DataType, arg7: vector<vector<u8>>, arg8: 0x1::option::Option<u64>, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market::Market<T0>, 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market::CreatorCap) {
        let v0 = CoralWitness{dummy_field: false};
        let (v1, v2) = 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market::create_market<T0, CoralWitness>(arg0, arg1, v0, 0x1::option::none<0x2::object::ID>(), arg8, 0x1::option::some<u64>(arg9), arg5, arg7, arg10, arg11);
        let v3 = v1;
        let v4 = CoralWitness{dummy_field: false};
        let v5 = 0x1::vector::empty<0x2::object::ID>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x2::object::ID>(v6, 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market::id<T0>(&mut v3));
        0x1::vector::push_back<0x2::object::ID>(v6, 0x2::object::id<0x2::clock::Clock>(arg10));
        let v7 = 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query::create_with_schema<T1, CoralWitness>(v4, arg2, arg3, 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query::new_custom_schema(0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::schema::new_options_schema(arg6, arg7)), arg4, arg5, 0x1::option::none<u64>(), 0x1::option::none<u64>(), v5, arg10, arg11);
        let v8 = CoralWitness{dummy_field: false};
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market::set_oracle_id<T0, CoralWitness>(&mut v3, v8, 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query::id<T1>(&v7));
        0x2::transfer::public_share_object<0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query::Query<T1>>(v7);
        (v3, v2)
    }

    public fun create_market_with_standard_topic<T0, T1>(arg0: &0x2::coin_registry::Currency<T0>, arg1: &0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::config::ProtocolConfig, arg2: &mut 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::protocol::Protocol, arg3: &0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::resolver::Resolver, arg4: vector<u8>, arg5: u64, arg6: vector<u8>, arg7: 0x1::option::Option<u64>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market::Market<T0>, 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market::CreatorCap) {
        let v0 = CoralWitness{dummy_field: false};
        let (v1, v2) = 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market::create_market<T0, CoralWitness>(arg0, arg1, v0, 0x1::option::none<0x2::object::ID>(), arg7, 0x1::option::some<u64>(arg8), arg6, 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::schema::options(0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::protocol::topic_schema(arg2, arg4, arg5)), arg9, arg10);
        let v3 = v1;
        let v4 = CoralWitness{dummy_field: false};
        let v5 = 0x1::vector::empty<0x2::object::ID>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x2::object::ID>(v6, 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market::id<T0>(&mut v3));
        0x1::vector::push_back<0x2::object::ID>(v6, 0x2::object::id<0x2::clock::Clock>(arg9));
        let v7 = 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query::create<T1, CoralWitness>(v4, arg2, arg3, arg4, arg5, arg6, 0x1::option::none<u64>(), 0x1::option::none<u64>(), v5, arg9, arg10);
        let v8 = CoralWitness{dummy_field: false};
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market::set_oracle_id<T0, CoralWitness>(&mut v3, v8, 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query::id<T1>(&v7));
        0x2::transfer::public_share_object<0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query::Query<T1>>(v7);
        (v3, v2)
    }

    public fun expire_market<T0>(arg0: &mut 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market::Market<T0>, arg1: &CoralManagerCap, arg2: &0x2::clock::Clock) {
        let v0 = CoralWitness{dummy_field: false};
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market::expire_market<T0, CoralWitness>(arg0, v0, arg2);
    }

    public fun force_resolve_market<T0>(arg0: &mut 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market::Market<T0>, arg1: &CoralManagerCap, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = CoralWitness{dummy_field: false};
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market::resolve_market<T0, CoralWitness>(arg0, arg2, v0, arg3);
    }

    fun init(arg0: CORAL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<CORAL>(arg0, arg1);
        let v0 = CoralManagerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<CoralManagerCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun resolve_market<T0, T1>(arg0: &mut 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market::Market<T0>, arg1: &mut 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query::Query<T1>, arg2: &0x2::clock::Clock) {
        assert!(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market::oracle_id<T0>(arg0) == 0x1::option::some<0x2::object::ID>(0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query::id<T1>(arg1)), 1);
        let v0 = 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::query::resolved_data<T1>(arg1);
        assert!(0x1::option::is_some<vector<u8>>(&v0), 2);
        let v1 = *0x1::option::borrow<vector<u8>>(&v0);
        if (v1 == x"fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd") {
            let v2 = CoralWitness{dummy_field: false};
            0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market::void_market<T0, CoralWitness>(arg0, v2, arg2);
        } else {
            resolve_market_<T0>(arg0, v1, arg2);
        };
    }

    public(friend) fun resolve_market_<T0>(arg0: &mut 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market::Market<T0>, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::vec_set::keys<vector<u8>>(0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market::outcome_values<T0>(arg0));
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<vector<u8>>(v0)) {
            if (0x1::vector::borrow<vector<u8>>(v0, v1) == &arg1) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                assert!(0x1::option::is_some<u64>(&v2), 0);
                let v3 = CoralWitness{dummy_field: false};
                0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market::resolve_market<T0, CoralWitness>(arg0, 0x1::option::destroy_some<u64>(v2), v3, arg2);
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun void_market<T0>(arg0: &mut 0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market::Market<T0>, arg1: &CoralManagerCap, arg2: &0x2::clock::Clock) {
        let v0 = CoralWitness{dummy_field: false};
        0xf4f3a2c682491e88fc06789851396db16fc59420c71749530f5c228b9f9b0ccd::market::void_market<T0, CoralWitness>(arg0, v0, arg2);
    }

    public(friend) fun witness() : CoralWitness {
        CoralWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

