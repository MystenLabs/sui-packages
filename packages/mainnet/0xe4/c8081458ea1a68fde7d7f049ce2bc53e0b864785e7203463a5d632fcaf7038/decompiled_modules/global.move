module 0xe4c8081458ea1a68fde7d7f049ce2bc53e0b864785e7203463a5d632fcaf7038::global {
    struct Global has key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
        withdraw_address: address,
        manager_address_1: address,
        manager_address_2: address,
    }

    public(friend) fun add_pool_flag<T0, T1>(arg0: &mut Global, arg1: 0x2::object::ID) {
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.pools, get_pool_name<T0, T1>(), arg1);
    }

    public fun exist_pool<T0, T1>(arg0: &Global) : bool {
        0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.pools, get_pool_name<T0, T1>())
    }

    public fun get_manager_address(arg0: &Global) : (address, address) {
        (arg0.manager_address_1, arg0.manager_address_2)
    }

    public fun get_pool_name<T0, T1>() : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x1::string::append_utf8(&mut v0, b"-");
        0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        v0
    }

    public fun get_withdraw_address(arg0: &Global) : address {
        arg0.withdraw_address
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Global{
            id                : 0x2::object::new(arg0),
            pools             : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg0),
            withdraw_address  : v0,
            manager_address_1 : v0,
            manager_address_2 : v0,
        };
        0x2::transfer::share_object<Global>(v1);
    }

    public entry fun set_manager_address_1(arg0: &mut Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x51f51183c5af25ef0ec430e0a94bbbb0ec0d25f78c9b11161e59abaf0d524159, 1);
        arg0.manager_address_1 = arg1;
    }

    public entry fun set_manager_address_2(arg0: &mut Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x51f51183c5af25ef0ec430e0a94bbbb0ec0d25f78c9b11161e59abaf0d524159, 1);
        arg0.manager_address_2 = arg1;
    }

    public entry fun set_withdraw_address(arg0: &mut Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x51f51183c5af25ef0ec430e0a94bbbb0ec0d25f78c9b11161e59abaf0d524159, 1);
        arg0.withdraw_address = arg1;
    }

    // decompiled from Move bytecode v6
}

