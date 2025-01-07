module 0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::receipt {
    struct Receipt has key {
        id: 0x2::object::UID,
        master_id: 0x2::object::ID,
        user_profile: address,
    }

    public fun new<T0>(arg0: &0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core::AdminCap, arg1: &mut 0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::master::Master<T0>, arg2: address, arg3: &0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core::Registry, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core::is_valid_version(arg3), 1);
        assert!(0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::master::sale_status<T0>(arg1) == 2, 2);
        0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::master::claim<T0>(arg1);
        let v0 = Receipt{
            id           : 0x2::object::new(arg4),
            master_id    : 0x2::object::id<0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::master::Master<T0>>(arg1),
            user_profile : arg2,
        };
        0x2::transfer::transfer<Receipt>(v0, arg2);
    }

    public(friend) fun receive(arg0: &mut 0x2::object::UID, arg1: 0x2::transfer::Receiving<Receipt>) : Receipt {
        0x2::transfer::receive<Receipt>(arg0, arg1)
    }

    public(friend) fun burn(arg0: Receipt) : (0x2::object::ID, address) {
        let Receipt {
            id           : v0,
            master_id    : v1,
            user_profile : v2,
        } = arg0;
        0x2::object::delete(v0);
        (v1, v2)
    }

    // decompiled from Move bytecode v6
}

