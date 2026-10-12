module 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::timelock {
    struct Timelock<T0: store> has store {
        wish: T0,
        target_object_id: 0x2::object::ID,
        activation_time: u64,
        expiration_time: u64,
        is_super_admin: bool,
    }

    public(friend) fun cancel<T0: copy + drop + store>(arg0: &mut 0x2::bag::Bag, arg1: 0x2::object::ID, arg2: bool, arg3: &0x2::clock::Clock) : T0 {
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(arg0, 0x1::type_name::with_defining_ids<T0>()), 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::error::no_pending_wish());
        let Timelock {
            wish             : v0,
            target_object_id : v1,
            activation_time  : _,
            expiration_time  : _,
            is_super_admin   : v4,
        } = 0x2::bag::remove<0x1::type_name::TypeName, Timelock<T0>>(arg0, 0x1::type_name::with_defining_ids<T0>());
        assert!(v1 == arg1, 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::error::wrong_target_wish_object());
        assert!(v4 == arg2, 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::error::not_allowed());
        0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::event::emit_wish_cancelled<T0>(arg1, v0, v4, 0x2::clock::timestamp_ms(arg3));
        v0
    }

    public(friend) fun execute<T0: copy + drop + store>(arg0: &mut 0x2::bag::Bag, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : T0 {
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(arg0, 0x1::type_name::with_defining_ids<T0>()), 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::error::no_pending_wish());
        let v0 = 0x2::bag::remove<0x1::type_name::TypeName, Timelock<T0>>(arg0, 0x1::type_name::with_defining_ids<T0>());
        assert!(v0.target_object_id == arg1, 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::error::wrong_target_wish_object());
        0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::event::emit_wish_executed<T0>(arg1, v0.wish, v0.is_super_admin, 0x2::clock::timestamp_ms(arg2));
        extract_wish<T0>(v0, arg2)
    }

    public(friend) fun extract_wish<T0: store>(arg0: Timelock<T0>, arg1: &0x2::clock::Clock) : T0 {
        let Timelock {
            wish             : v0,
            target_object_id : _,
            activation_time  : v2,
            expiration_time  : v3,
            is_super_admin   : _,
        } = arg0;
        let v5 = 0x2::clock::timestamp_ms(arg1);
        assert!(v5 >= v2, 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::error::timelock_not_matured());
        assert!(v5 <= v3, 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::error::timelock_expired());
        v0
    }

    public(friend) fun lock_wish<T0: store>(arg0: 0x2::object::ID, arg1: u64, arg2: T0, arg3: bool, arg4: &0x2::clock::Clock) : Timelock<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg4) + arg1;
        Timelock<T0>{
            wish             : arg2,
            target_object_id : arg0,
            activation_time  : v0,
            expiration_time  : v0 + arg1,
            is_super_admin   : arg3,
        }
    }

    public(friend) fun submit<T0: copy + drop + store>(arg0: &mut 0x2::bag::Bag, arg1: 0x2::object::ID, arg2: u64, arg3: T0, arg4: bool, arg5: &0x2::clock::Clock) {
        assert!(!0x2::bag::contains<0x1::type_name::TypeName>(arg0, 0x1::type_name::with_defining_ids<T0>()), 0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::error::wish_already_pending());
        let v0 = lock_wish<T0>(arg1, arg2, arg3, arg4, arg5);
        0x55eb01b43f40795fd99e394f5662cc87bcc15337979fce5dc62149835259695::event::emit_wish_submitted<T0>(arg1, v0.wish, arg4, v0.activation_time, v0.expiration_time, 0x2::clock::timestamp_ms(arg5));
        0x2::bag::add<0x1::type_name::TypeName, Timelock<T0>>(arg0, 0x1::type_name::with_defining_ids<T0>(), v0);
    }

    // decompiled from Move bytecode v7
}

