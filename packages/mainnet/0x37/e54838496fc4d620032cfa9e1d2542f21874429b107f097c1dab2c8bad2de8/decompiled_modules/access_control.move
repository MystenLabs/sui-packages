module 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::access_control {
    struct PausableKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RolesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AccessControl<phantom T0> has store {
        modules: 0x2::bag::Bag,
    }

    public fun new<T0>(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : AccessControl<T0> {
        let v0 = 0x2::bag::new(arg2);
        let v1 = PausableKey{dummy_field: false};
        0x2::bag::add<PausableKey, 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::pausable::Pausable<T0>>(&mut v0, v1, 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::pausable::new<T0>());
        let v2 = RolesKey{dummy_field: false};
        0x2::bag::add<RolesKey, 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::roles::Roles<T0>>(&mut v0, v2, 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::roles::new<T0>(arg0, arg1, arg2));
        AccessControl<T0>{modules: v0}
    }

    public fun accept_ownership<T0>(arg0: &mut AccessControl<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::roles::accept_ownership<T0>(roles_mut<T0>(arg0), arg1);
    }

    public fun assert_not_paused<T0>(arg0: &AccessControl<T0>) {
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::pausable::assert_not_paused<T0>(pausable<T0>(arg0));
    }

    public fun is_owner<T0>(arg0: &AccessControl<T0>, arg1: address) : bool {
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::roles::is_owner<T0>(roles<T0>(arg0), arg1)
    }

    public fun is_paused<T0>(arg0: &AccessControl<T0>) : bool {
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::pausable::is_paused<T0>(pausable<T0>(arg0))
    }

    public fun migrate_owner_to_two_step<T0>(arg0: &mut AccessControl<T0>, arg1: &0x2::tx_context::TxContext) {
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::roles::migrate_owner_to_two_step<T0>(roles_mut<T0>(arg0), arg1);
    }

    public fun pausable<T0>(arg0: &AccessControl<T0>) : &0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::pausable::Pausable<T0> {
        let v0 = PausableKey{dummy_field: false};
        0x2::bag::borrow<PausableKey, 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::pausable::Pausable<T0>>(&arg0.modules, v0)
    }

    public(friend) fun pausable_mut<T0>(arg0: &mut AccessControl<T0>) : &mut 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::pausable::Pausable<T0> {
        let v0 = PausableKey{dummy_field: false};
        0x2::bag::borrow_mut<PausableKey, 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::pausable::Pausable<T0>>(&mut arg0.modules, v0)
    }

    public fun pause<T0>(arg0: &mut AccessControl<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::roles::is_pauser<T0>(roles<T0>(arg0), 0x2::tx_context::sender(arg1)), 1);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::pausable::pause<T0>(pausable_mut<T0>(arg0), arg1);
    }

    public fun roles<T0>(arg0: &AccessControl<T0>) : &0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::roles::Roles<T0> {
        let v0 = RolesKey{dummy_field: false};
        0x2::bag::borrow<RolesKey, 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::roles::Roles<T0>>(&arg0.modules, v0)
    }

    public(friend) fun roles_mut<T0>(arg0: &mut AccessControl<T0>) : &mut 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::roles::Roles<T0> {
        let v0 = RolesKey{dummy_field: false};
        0x2::bag::borrow_mut<RolesKey, 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::roles::Roles<T0>>(&mut arg0.modules, v0)
    }

    public fun transfer_ownership<T0>(arg0: &mut AccessControl<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::roles::transfer_ownership<T0>(roles_mut<T0>(arg0), arg1, arg2);
    }

    public fun unpause<T0>(arg0: &mut AccessControl<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::roles::is_pauser<T0>(roles<T0>(arg0), 0x2::tx_context::sender(arg1)), 1);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::pausable::unpause<T0>(pausable_mut<T0>(arg0), arg1);
    }

    public fun update_owner<T0>(arg0: &mut AccessControl<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::roles::is_owner<T0>(roles<T0>(arg0), 0x2::tx_context::sender(arg2)), 1);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::roles::update_owner<T0>(roles_mut<T0>(arg0), arg1, arg2);
    }

    public fun update_pauser<T0>(arg0: &mut AccessControl<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::roles::is_owner<T0>(roles<T0>(arg0), 0x2::tx_context::sender(arg2)), 1);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::roles::update_pauser<T0>(roles_mut<T0>(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

