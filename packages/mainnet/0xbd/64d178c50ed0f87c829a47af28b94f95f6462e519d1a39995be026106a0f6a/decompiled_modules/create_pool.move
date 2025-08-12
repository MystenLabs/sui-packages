module 0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::create_pool {
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
        let v2 = 0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::comparator::compare_u8_vector(0x1::bcs::to_bytes<0x1::type_name::TypeName>(&v0), 0x1::bcs::to_bytes<0x1::type_name::TypeName>(&v1));
        0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::comparator::is_smaller_than(&v2)
    }

    fun create_pool_internal<T0, T1>(arg0: &0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::global_config::GlobalConfig, arg1: u64, arg2: &0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::version::Version, arg3: &mut 0x2::tx_context::TxContext) : 0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::pool::Pool<T0, T1> {
        0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::version::assert_supported_version(arg2);
        assert!(0x1::type_name::get<T0>() != 0x1::type_name::get<T1>(), 0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::error::invalid_pool_coin_types());
        assert!(check_coin_order<T0, T1>(), 0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::error::invalid_pool_coin_types_sorted());
        let v0 = 0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::global_config::get_tick_spacing(arg0, arg1);
        let v1 = 0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::pool::create<T0, T1>(v0, arg1, arg1, 0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::constants::protocol_swap_fee_share(), 0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::constants::protocol_flash_loan_fee_share(), arg3);
        let v2 = PoolCreatedEvent{
            sender       : 0x2::tx_context::sender(arg3),
            pool_id      : 0x2::object::id<0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::pool::Pool<T0, T1>>(&v1),
            type_x       : 0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::pool::type_x<T0, T1>(&v1),
            type_y       : 0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::pool::type_y<T0, T1>(&v1),
            fee_rate     : arg1,
            tick_spacing : v0,
        };
        0x2::event::emit<PoolCreatedEvent>(v2);
        v1
    }

    public fun new<T0, T1>(arg0: &mut 0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::global_config::GlobalConfig, arg1: u64, arg2: &0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::version::Version, arg3: &mut 0x2::tx_context::TxContext) : 0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::pool::Pool<T0, T1> {
        create_pool_internal<T0, T1>(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

