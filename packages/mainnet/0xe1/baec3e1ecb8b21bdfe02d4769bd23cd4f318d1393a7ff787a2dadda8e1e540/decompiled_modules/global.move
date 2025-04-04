module 0xe1baec3e1ecb8b21bdfe02d4769bd23cd4f318d1393a7ff787a2dadda8e1e540::global {
    struct Global has key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
    }

    public(friend) fun add_pool_flag<T0, T1>(arg0: &mut Global, arg1: 0x2::object::ID) {
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.pools, get_pool_name<T0, T1>(), arg1);
    }

    public fun exist_pool<T0, T1>(arg0: &Global) : bool {
        0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.pools, get_pool_name<T0, T1>())
    }

    public fun get_pool_name<T0, T1>() : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x1::string::append_utf8(&mut v0, b"-");
        0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Global{
            id    : 0x2::object::new(arg0),
            pools : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<Global>(v0);
    }

    // decompiled from Move bytecode v6
}

