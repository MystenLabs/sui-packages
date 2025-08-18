module 0xb7a6a9d7fb3a97842a85e8fd39e397b144183029508c018d1aa043592a4cee19::create_pool {
    struct PoolCreatedEvent has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        type_x: 0x1::type_name::TypeName,
        type_y: 0x1::type_name::TypeName,
        fee_rate: u64,
        tick_spacing: u32,
    }

    fun create_pool_internal<T0, T1>(arg0: &0xb7a6a9d7fb3a97842a85e8fd39e397b144183029508c018d1aa043592a4cee19::global_config::GlobalConfig, arg1: u64, arg2: &0xb7a6a9d7fb3a97842a85e8fd39e397b144183029508c018d1aa043592a4cee19::version::Version, arg3: &mut 0x2::tx_context::TxContext) : 0xb7a6a9d7fb3a97842a85e8fd39e397b144183029508c018d1aa043592a4cee19::pool::Pool<T0, T1> {
        0xb7a6a9d7fb3a97842a85e8fd39e397b144183029508c018d1aa043592a4cee19::version::assert_supported_version(arg2);
        assert!(0x1::type_name::get<T0>() != 0x1::type_name::get<T1>(), 0xb7a6a9d7fb3a97842a85e8fd39e397b144183029508c018d1aa043592a4cee19::error::invalid_pool_coin_types());
        let v0 = 0xb7a6a9d7fb3a97842a85e8fd39e397b144183029508c018d1aa043592a4cee19::global_config::get_tick_spacing(arg0, arg1);
        let v1 = 0xb7a6a9d7fb3a97842a85e8fd39e397b144183029508c018d1aa043592a4cee19::pool::create<T0, T1>(v0, arg1, 0, 200000, 200000, arg3);
        let v2 = PoolCreatedEvent{
            sender       : 0x2::tx_context::sender(arg3),
            pool_id      : 0x2::object::id<0xb7a6a9d7fb3a97842a85e8fd39e397b144183029508c018d1aa043592a4cee19::pool::Pool<T0, T1>>(&v1),
            type_x       : 0xb7a6a9d7fb3a97842a85e8fd39e397b144183029508c018d1aa043592a4cee19::pool::type_x<T0, T1>(&v1),
            type_y       : 0xb7a6a9d7fb3a97842a85e8fd39e397b144183029508c018d1aa043592a4cee19::pool::type_y<T0, T1>(&v1),
            fee_rate     : arg1,
            tick_spacing : v0,
        };
        0x2::event::emit<PoolCreatedEvent>(v2);
        v1
    }

    public fun new<T0, T1>(arg0: &mut 0xb7a6a9d7fb3a97842a85e8fd39e397b144183029508c018d1aa043592a4cee19::global_config::GlobalConfig, arg1: u64, arg2: &0xb7a6a9d7fb3a97842a85e8fd39e397b144183029508c018d1aa043592a4cee19::version::Version, arg3: &mut 0x2::tx_context::TxContext) : 0xb7a6a9d7fb3a97842a85e8fd39e397b144183029508c018d1aa043592a4cee19::pool::Pool<T0, T1> {
        create_pool_internal<T0, T1>(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

