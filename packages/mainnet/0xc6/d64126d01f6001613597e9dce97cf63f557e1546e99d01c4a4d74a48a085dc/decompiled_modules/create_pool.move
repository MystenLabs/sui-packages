module 0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::create_pool {
    struct PoolCreatedEvent has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        type_x: 0x1::type_name::TypeName,
        type_y: 0x1::type_name::TypeName,
        fee_rate: u64,
        tick_spacing: u32,
    }

    fun create_pool_internal<T0, T1>(arg0: &0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::global_config::GlobalConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::pool::Pool<T0, T1> {
        let v0 = 0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::global_config::get_tick_spacing(arg0, arg1);
        let v1 = 0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::pool::create<T0, T1>(arg1, v0, arg2);
        let v2 = PoolCreatedEvent{
            sender       : 0x2::tx_context::sender(arg2),
            pool_id      : 0x2::object::id<0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::pool::Pool<T0, T1>>(&v1),
            type_x       : 0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::pool::type_x<T0, T1>(&v1),
            type_y       : 0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::pool::type_y<T0, T1>(&v1),
            fee_rate     : arg1,
            tick_spacing : v0,
        };
        0x2::event::emit<PoolCreatedEvent>(v2);
        v1
    }

    public fun new<T0, T1>(arg0: &mut 0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::global_config::GlobalConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0xc6d64126d01f6001613597e9dce97cf63f557e1546e99d01c4a4d74a48a085dc::pool::Pool<T0, T1> {
        create_pool_internal<T0, T1>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

