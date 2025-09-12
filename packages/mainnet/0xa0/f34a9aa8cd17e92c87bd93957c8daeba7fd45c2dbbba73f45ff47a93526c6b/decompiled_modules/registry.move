module 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        index: u64,
        pools: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, PoolInfo>,
    }

    struct PoolInfo has copy, drop, store {
        pool_id: 0x2::object::ID,
        pool_key: 0x2::object::ID,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        bin_step: u16,
    }

    struct CreatePoolReceipt {
        pool_id: 0x2::object::ID,
    }

    struct RegistryEvent has copy, drop {
        pools_id: 0x2::object::ID,
    }

    struct CreatePoolEvent has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type_a: 0x1::string::String,
        coin_type_b: 0x1::string::String,
        bin_step: u16,
    }

    public fun create_pool<T0, T1>(arg0: &mut Registry, arg1: &0x2::coin::CoinMetadata<T0>, arg2: &0x2::coin::CoinMetadata<T1>, arg3: u16, arg4: u16, arg5: u32, arg6: 0x1::string::String, arg7: &mut 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::GlobalConfig, arg8: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (CreatePoolReceipt, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::pool::Pool<T0, T1>) {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg8);
        assert!(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::is_allowed_coin<T0>(arg7, arg1), 13906834968912855049);
        assert!(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::is_allowed_coin<T1>(arg7, arg2), 13906834973207822345);
        let v0 = create_pool_internal<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg7, arg9, arg10);
        let v1 = CreatePoolReceipt{pool_id: 0x2::object::id<0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::pool::Pool<T0, T1>>(&v0)};
        (v1, v0)
    }

    fun create_pool_internal<T0, T1>(arg0: &mut Registry, arg1: u16, arg2: u16, arg3: u32, arg4: 0x1::string::String, arg5: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::GlobalConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::pool::Pool<T0, T1> {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::check_user_operation(arg5, 0x2::tx_context::sender(arg7), 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::restriction::create_pool_kind());
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v0, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::price_math::min_bin_id()) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v0, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::price_math::max_bin_id()), 13906835338279518209);
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::price_math::get_price_from_id(v0, arg1);
        let v1 = 0x1::type_name::with_original_ids<T0>();
        let v2 = 0x1::type_name::with_original_ids<T1>();
        assert!(v1 != v2, 13906835359754485763);
        let v3 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::get_bin_step_config(arg5, arg1, arg2);
        let v4 = new_pool_key<T0, T1>(arg1, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::base_factor(&v3));
        assert!(!0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, PoolInfo>(&arg0.pools, v4), 13906835385524420613);
        let v5 = if (0x1::string::length(&arg4) == 0) {
            0x1::string::utf8(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::pool_default_uri())
        } else {
            arg4
        };
        let v6 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::pool::new_pool<T0, T1>(v0, arg0.index, v5, v3, arg6, arg7);
        arg0.index = arg0.index + 1;
        let v7 = 0x2::object::id<0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::pool::Pool<T0, T1>>(&v6);
        let v8 = PoolInfo{
            pool_id     : v7,
            pool_key    : v4,
            coin_type_a : v1,
            coin_type_b : v2,
            bin_step    : arg1,
        };
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<0x2::object::ID, PoolInfo>(&mut arg0.pools, v4, v8);
        let v9 = CreatePoolEvent{
            pool_id     : v7,
            coin_type_a : 0x1::string::from_ascii(0x1::type_name::into_string(v1)),
            coin_type_b : 0x1::string::from_ascii(0x1::type_name::into_string(v2)),
            bin_step    : arg1,
        };
        0x2::event::emit<CreatePoolEvent>(v9);
        v6
    }

    public fun destroy_receipt<T0, T1>(arg0: CreatePoolReceipt, arg1: 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::pool::Pool<T0, T1>, arg2: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned) {
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::check_version(arg2);
        let CreatePoolReceipt { pool_id: v0 } = arg0;
        assert!(v0 == 0x2::object::id<0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::pool::Pool<T0, T1>>(&arg1), 13906835136416448519);
        0x2::transfer::public_share_object<0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::pool::Pool<T0, T1>>(arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id    : 0x2::object::new(arg0),
            index : 0,
            pools : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::new<0x2::object::ID, PoolInfo>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
        let v1 = RegistryEvent{pools_id: 0x2::object::id<Registry>(&v0)};
        0x2::event::emit<RegistryEvent>(v1);
    }

    public fun is_right_order<T0, T1>() : bool {
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()));
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>()));
        let v2 = 0x1::vector::length<u8>(&v0);
        let v3 = 0x1::vector::length<u8>(&v1);
        let v4 = 0;
        let v5 = false;
        while (v4 < v3) {
            let v6 = *0x1::vector::borrow<u8>(&v1, v4);
            if (!v5 && v4 < v2) {
                let v7 = *0x1::vector::borrow<u8>(&v0, v4);
                if (v7 < v6) {
                    return false
                };
                if (v7 > v6) {
                    v5 = true;
                };
            };
            v4 = v4 + 1;
        };
        if (!v5) {
            if (v2 < v3) {
                return false
            };
            if (v2 == v3) {
                abort 13906835892330430467
            };
        };
        true
    }

    public fun new_pool_key<T0, T1>(arg0: u16, arg1: u16) : 0x2::object::ID {
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()));
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>()));
        let v2 = 0x1::vector::length<u8>(&v0);
        let v3 = 0x1::vector::length<u8>(&v1);
        let v4 = 0;
        let v5 = false;
        while (v4 < v3) {
            let v6 = *0x1::vector::borrow<u8>(&v1, v4);
            if (!v5 && v4 < v2) {
                let v7 = *0x1::vector::borrow<u8>(&v0, v4);
                if (v7 < v6) {
                    abort 13906835677582589963
                };
                if (v7 > v6) {
                    v5 = true;
                };
            };
            0x1::vector::push_back<u8>(&mut v0, v6);
            v4 = v4 + 1;
        };
        if (!v5) {
            assert!(v2 != v3, 13906835720531738627);
            assert!(v2 > v3, 13906835724827230219);
        };
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u16>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u16>(&arg1));
        0x2::object::id_from_bytes(0x2::hash::blake2b256(&v0))
    }

    // decompiled from Move bytecode v6
}

