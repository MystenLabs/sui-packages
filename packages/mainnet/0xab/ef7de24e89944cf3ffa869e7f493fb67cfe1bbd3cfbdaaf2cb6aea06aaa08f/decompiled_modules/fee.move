module 0xabef7de24e89944cf3ffa869e7f493fb67cfe1bbd3cfbdaaf2cb6aea06aaa08f::fee {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Fee has store, key {
        id: 0x2::object::UID,
        fee_type: u16,
        active: bool,
        fee: u64,
        user: 0x1::option::Option<address>,
        recipient: address,
    }

    public fun check_fee(arg0: u16, arg1: address, arg2: &Fee) {
        assert!(arg2.active, 2);
        assert!(arg2.fee_type == arg0, 3);
        let v0 = arg2.user;
        if (0x1::option::is_some<address>(&v0)) {
            assert!(0x1::option::borrow<address>(&v0) == &arg1, 4);
        };
    }

    public fun get_fee(arg0: &Fee) : u64 {
        arg0.fee
    }

    public fun get_recipient(arg0: &Fee) : address {
        arg0.recipient
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun new_admin(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun new_fee(arg0: &AdminCap, arg1: u16, arg2: bool, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : Fee {
        assert!(arg3 > 128, 1);
        Fee{
            id        : 0x2::object::new(arg5),
            fee_type  : arg1,
            active    : arg2,
            fee       : arg3,
            user      : 0x1::option::none<address>(),
            recipient : arg4,
        }
    }

    public fun new_fee_with_address(arg0: &AdminCap, arg1: u16, arg2: bool, arg3: u64, arg4: address, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : Fee {
        assert!(arg3 > 128, 1);
        Fee{
            id        : 0x2::object::new(arg6),
            fee_type  : arg1,
            active    : arg2,
            fee       : arg3,
            user      : 0x1::option::some<address>(arg4),
            recipient : arg5,
        }
    }

    public fun set_values(arg0: &AdminCap, arg1: u16, arg2: u64, arg3: bool, arg4: &mut Fee) {
        assert!(arg2 > 128, 1);
        arg4.active = arg3;
        arg4.fee_type = arg1;
        arg4.fee = arg2;
    }

    // decompiled from Move bytecode v6
}

