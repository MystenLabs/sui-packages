module 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::create_pool {
    struct PoolCreatedEvent has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        type_x: 0x1::type_name::TypeName,
        type_y: 0x1::type_name::TypeName,
        fee_rate: u64,
        tick_spacing: u32,
    }

    fun create_pool_internal<T0, T1>(arg0: &0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::global_config::GlobalConfig, arg1: u64, arg2: &0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::version::Version, arg3: &mut 0x2::tx_context::TxContext) : 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::pool::Pool<T0, T1> {
        0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::version::assert_supported_version(arg2);
        let v0 = 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::global_config::get_tick_spacing(arg0, arg1);
        let v1 = 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::pool::create<T0, T1>(arg1, v0, arg3);
        let v2 = PoolCreatedEvent{
            sender       : 0x2::tx_context::sender(arg3),
            pool_id      : 0x2::object::id<0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::pool::Pool<T0, T1>>(&v1),
            type_x       : 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::pool::type_x<T0, T1>(&v1),
            type_y       : 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::pool::type_y<T0, T1>(&v1),
            fee_rate     : arg1,
            tick_spacing : v0,
        };
        0x2::event::emit<PoolCreatedEvent>(v2);
        v1
    }

    public fun new<T0, T1>(arg0: &mut 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::global_config::GlobalConfig, arg1: u64, arg2: &0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::version::Version, arg3: &mut 0x2::tx_context::TxContext) : 0x72065b15c1c33aa725acc8aab0aa79cf80fb60afb0b7094c1b521f6b375edfa8::pool::Pool<T0, T1> {
        create_pool_internal<T0, T1>(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

