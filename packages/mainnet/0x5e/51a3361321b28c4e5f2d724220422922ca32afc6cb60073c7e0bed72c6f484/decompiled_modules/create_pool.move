module 0x5e51a3361321b28c4e5f2d724220422922ca32afc6cb60073c7e0bed72c6f484::create_pool {
    struct PoolCreatedEvent has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        type_x: 0x1::type_name::TypeName,
        type_y: 0x1::type_name::TypeName,
        fee_rate: u64,
        tick_spacing: u32,
    }

    public fun check_coin_order<T0, T1>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0x5e51a3361321b28c4e5f2d724220422922ca32afc6cb60073c7e0bed72c6f484::comparator::compare_u8_vector(0x1::bcs::to_bytes<0x1::type_name::TypeName>(&v0), 0x1::bcs::to_bytes<0x1::type_name::TypeName>(&v1));
        0x5e51a3361321b28c4e5f2d724220422922ca32afc6cb60073c7e0bed72c6f484::comparator::is_smaller_than(&v2)
    }

    fun create_pool_internal<T0, T1>(arg0: &0x5e51a3361321b28c4e5f2d724220422922ca32afc6cb60073c7e0bed72c6f484::global_config::GlobalConfig, arg1: u64, arg2: &0x5e51a3361321b28c4e5f2d724220422922ca32afc6cb60073c7e0bed72c6f484::version::Version, arg3: &mut 0x2::tx_context::TxContext) : 0x5e51a3361321b28c4e5f2d724220422922ca32afc6cb60073c7e0bed72c6f484::pool::Pool<T0, T1> {
        0x5e51a3361321b28c4e5f2d724220422922ca32afc6cb60073c7e0bed72c6f484::version::assert_supported_version(arg2);
        assert!(0x1::type_name::get<T0>() != 0x1::type_name::get<T1>(), 0x5e51a3361321b28c4e5f2d724220422922ca32afc6cb60073c7e0bed72c6f484::error::invalid_pool_coin_types());
        assert!(check_coin_order<T0, T1>(), 0x5e51a3361321b28c4e5f2d724220422922ca32afc6cb60073c7e0bed72c6f484::error::invalid_pool_coin_types_sorted());
        let v0 = 0x5e51a3361321b28c4e5f2d724220422922ca32afc6cb60073c7e0bed72c6f484::global_config::get_tick_spacing(arg0, arg1);
        let v1 = 0x5e51a3361321b28c4e5f2d724220422922ca32afc6cb60073c7e0bed72c6f484::pool::create<T0, T1>(v0, arg1, arg1, 0x5e51a3361321b28c4e5f2d724220422922ca32afc6cb60073c7e0bed72c6f484::constants::protocol_swap_fee_share(), 0x5e51a3361321b28c4e5f2d724220422922ca32afc6cb60073c7e0bed72c6f484::constants::protocol_flash_loan_fee_share(), arg3);
        let v2 = PoolCreatedEvent{
            sender       : 0x2::tx_context::sender(arg3),
            pool_id      : 0x2::object::id<0x5e51a3361321b28c4e5f2d724220422922ca32afc6cb60073c7e0bed72c6f484::pool::Pool<T0, T1>>(&v1),
            type_x       : 0x5e51a3361321b28c4e5f2d724220422922ca32afc6cb60073c7e0bed72c6f484::pool::type_x<T0, T1>(&v1),
            type_y       : 0x5e51a3361321b28c4e5f2d724220422922ca32afc6cb60073c7e0bed72c6f484::pool::type_y<T0, T1>(&v1),
            fee_rate     : arg1,
            tick_spacing : v0,
        };
        0x2::event::emit<PoolCreatedEvent>(v2);
        v1
    }

    public fun new<T0, T1>(arg0: &mut 0x5e51a3361321b28c4e5f2d724220422922ca32afc6cb60073c7e0bed72c6f484::global_config::GlobalConfig, arg1: u64, arg2: &0x5e51a3361321b28c4e5f2d724220422922ca32afc6cb60073c7e0bed72c6f484::version::Version, arg3: &mut 0x2::tx_context::TxContext) : 0x5e51a3361321b28c4e5f2d724220422922ca32afc6cb60073c7e0bed72c6f484::pool::Pool<T0, T1> {
        create_pool_internal<T0, T1>(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

