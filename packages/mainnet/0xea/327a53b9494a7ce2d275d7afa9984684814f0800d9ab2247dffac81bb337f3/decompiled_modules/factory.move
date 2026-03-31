module 0xea327a53b9494a7ce2d275d7afa9984684814f0800d9ab2247dffac81bb337f3::factory {
    struct Factory has key {
        id: 0x2::object::UID,
    }

    struct LaunchCompleted has copy, drop {
        pool_id: 0x2::object::ID,
        anchor_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
        peg_sui: u64,
        k: u128,
        creator: address,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Factory{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Factory>(v0);
    }

    public fun launch<T0>(arg0: &Factory, arg1: &mut 0xea327a53b9494a7ce2d275d7afa9984684814f0800d9ab2247dffac81bb337f3::registry::Registry, arg2: 0x2::coin::Coin<T0>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= 500000000, 1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = arg5 * 1000000000;
        let v2 = (v0 as u128) * (v1 as u128);
        let v3 = 0x2::clock::timestamp_ms(arg7);
        let v4 = 0x2::tx_context::sender(arg8);
        let v5 = 0x1::type_name::with_original_ids<T0>();
        let v6 = 0xea327a53b9494a7ce2d275d7afa9984684814f0800d9ab2247dffac81bb337f3::pool::create_and_share<T0>(0x2::coin::into_balance<T0>(arg2), v1, v2, v3, 1000, 100, 300000, 0x2::object::id_from_address(@0x0), v4, arg8);
        let v7 = 0xea327a53b9494a7ce2d275d7afa9984684814f0800d9ab2247dffac81bb337f3::launch_anchor::mint(v5, arg3, arg4, v0, arg5 * 1000000000, v1, v2, v4, v6, v3, arg8);
        let v8 = 0x2::object::id<0xea327a53b9494a7ce2d275d7afa9984684814f0800d9ab2247dffac81bb337f3::launch_anchor::LaunchAnchor>(&v7);
        0xea327a53b9494a7ce2d275d7afa9984684814f0800d9ab2247dffac81bb337f3::registry::register(arg1, v8, v5, v4, arg5, v2, v3);
        0xea327a53b9494a7ce2d275d7afa9984684814f0800d9ab2247dffac81bb337f3::registry::deposit_fee(arg1, arg6);
        0xea327a53b9494a7ce2d275d7afa9984684814f0800d9ab2247dffac81bb337f3::launch_anchor::freeze_anchor(v7);
        let v9 = LaunchCompleted{
            pool_id    : v6,
            anchor_id  : v8,
            token_type : v5,
            peg_sui    : arg5,
            k          : v2,
            creator    : v4,
        };
        0x2::event::emit<LaunchCompleted>(v9);
    }

    public fun mint_supply<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::total_supply<T0>(&arg0) == 0, 0);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T0>>(arg0);
        0x2::coin::mint<T0>(&mut arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

