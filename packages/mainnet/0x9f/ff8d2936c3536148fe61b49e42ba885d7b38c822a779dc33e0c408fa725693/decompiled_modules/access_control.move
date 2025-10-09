module 0x9fff8d2936c3536148fe61b49e42ba885d7b38c822a779dc33e0c408fa725693::access_control {
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
        0x2::bag::add<PausableKey, 0x9fff8d2936c3536148fe61b49e42ba885d7b38c822a779dc33e0c408fa725693::pausable::Pausable<T0>>(&mut v0, v1, 0x9fff8d2936c3536148fe61b49e42ba885d7b38c822a779dc33e0c408fa725693::pausable::new<T0>());
        let v2 = RolesKey{dummy_field: false};
        0x2::bag::add<RolesKey, 0x9fff8d2936c3536148fe61b49e42ba885d7b38c822a779dc33e0c408fa725693::roles::Roles<T0>>(&mut v0, v2, 0x9fff8d2936c3536148fe61b49e42ba885d7b38c822a779dc33e0c408fa725693::roles::new<T0>(arg0, arg1, arg2));
        AccessControl<T0>{modules: v0}
    }

    public fun assert_not_paused<T0>(arg0: &AccessControl<T0>) {
        0x9fff8d2936c3536148fe61b49e42ba885d7b38c822a779dc33e0c408fa725693::pausable::assert_not_paused<T0>(pausable<T0>(arg0));
    }

    public fun is_paused<T0>(arg0: &AccessControl<T0>) : bool {
        0x9fff8d2936c3536148fe61b49e42ba885d7b38c822a779dc33e0c408fa725693::pausable::is_paused<T0>(pausable<T0>(arg0))
    }

    public fun pausable<T0>(arg0: &AccessControl<T0>) : &0x9fff8d2936c3536148fe61b49e42ba885d7b38c822a779dc33e0c408fa725693::pausable::Pausable<T0> {
        let v0 = PausableKey{dummy_field: false};
        0x2::bag::borrow<PausableKey, 0x9fff8d2936c3536148fe61b49e42ba885d7b38c822a779dc33e0c408fa725693::pausable::Pausable<T0>>(&arg0.modules, v0)
    }

    public(friend) fun pausable_mut<T0>(arg0: &mut AccessControl<T0>) : &mut 0x9fff8d2936c3536148fe61b49e42ba885d7b38c822a779dc33e0c408fa725693::pausable::Pausable<T0> {
        let v0 = PausableKey{dummy_field: false};
        0x2::bag::borrow_mut<PausableKey, 0x9fff8d2936c3536148fe61b49e42ba885d7b38c822a779dc33e0c408fa725693::pausable::Pausable<T0>>(&mut arg0.modules, v0)
    }

    public fun pause<T0>(arg0: &mut AccessControl<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x9fff8d2936c3536148fe61b49e42ba885d7b38c822a779dc33e0c408fa725693::roles::is_pauser<T0>(roles<T0>(arg0), 0x2::tx_context::sender(arg1)), 1);
        0x9fff8d2936c3536148fe61b49e42ba885d7b38c822a779dc33e0c408fa725693::pausable::pause<T0>(pausable_mut<T0>(arg0), arg1);
    }

    public fun roles<T0>(arg0: &AccessControl<T0>) : &0x9fff8d2936c3536148fe61b49e42ba885d7b38c822a779dc33e0c408fa725693::roles::Roles<T0> {
        let v0 = RolesKey{dummy_field: false};
        0x2::bag::borrow<RolesKey, 0x9fff8d2936c3536148fe61b49e42ba885d7b38c822a779dc33e0c408fa725693::roles::Roles<T0>>(&arg0.modules, v0)
    }

    public(friend) fun roles_mut<T0>(arg0: &mut AccessControl<T0>) : &mut 0x9fff8d2936c3536148fe61b49e42ba885d7b38c822a779dc33e0c408fa725693::roles::Roles<T0> {
        let v0 = RolesKey{dummy_field: false};
        0x2::bag::borrow_mut<RolesKey, 0x9fff8d2936c3536148fe61b49e42ba885d7b38c822a779dc33e0c408fa725693::roles::Roles<T0>>(&mut arg0.modules, v0)
    }

    public fun unpause<T0>(arg0: &mut AccessControl<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x9fff8d2936c3536148fe61b49e42ba885d7b38c822a779dc33e0c408fa725693::roles::is_pauser<T0>(roles<T0>(arg0), 0x2::tx_context::sender(arg1)), 1);
        0x9fff8d2936c3536148fe61b49e42ba885d7b38c822a779dc33e0c408fa725693::pausable::unpause<T0>(pausable_mut<T0>(arg0), arg1);
    }

    public fun update_owner<T0>(arg0: &mut AccessControl<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x9fff8d2936c3536148fe61b49e42ba885d7b38c822a779dc33e0c408fa725693::roles::is_owner<T0>(roles<T0>(arg0), 0x2::tx_context::sender(arg2)), 1);
        0x9fff8d2936c3536148fe61b49e42ba885d7b38c822a779dc33e0c408fa725693::roles::update_owner<T0>(roles_mut<T0>(arg0), arg1, arg2);
    }

    public fun update_pauser<T0>(arg0: &mut AccessControl<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x9fff8d2936c3536148fe61b49e42ba885d7b38c822a779dc33e0c408fa725693::roles::is_owner<T0>(roles<T0>(arg0), 0x2::tx_context::sender(arg2)), 1);
        0x9fff8d2936c3536148fe61b49e42ba885d7b38c822a779dc33e0c408fa725693::roles::update_pauser<T0>(roles_mut<T0>(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

