module 0x5b340df606f1c48f60d32e8a26dcfde443d619f3d8e0980f7bbf553cc24e1b83::commission {
    struct COMMISSION has drop {
        dummy_field: bool,
    }

    struct Manager has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
    }

    struct BalanceKey has copy, drop, store {
        coin: 0x1::ascii::String,
    }

    struct CommissionEvent has copy, drop {
        reason: 0x1::ascii::String,
        coin: 0x1::ascii::String,
        amount: u64,
    }

    entry fun pay<T0>(arg0: &mut Manager, arg1: 0x1::ascii::String, arg2: 0x2::coin::Coin<T0>) {
        verify_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = CommissionEvent{
            reason : arg1,
            coin   : *0x1::type_name::borrow_string(&v0),
            amount : 0x2::balance::join<T0>(get_balance<T0>(arg0), 0x2::coin::into_balance<T0>(arg2)),
        };
        0x2::event::emit<CommissionEvent>(v1);
    }

    fun get_balance<T0>(arg0: &mut Manager) : &mut 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = BalanceKey{coin: *0x1::type_name::borrow_string(&v0)};
        if (!0x2::dynamic_field::exists_<BalanceKey>(&arg0.id, v1)) {
            0x2::dynamic_field::add<BalanceKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v1, 0x2::balance::zero<T0>());
        };
        0x2::dynamic_field::borrow_mut<BalanceKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v1)
    }

    fun init(arg0: COMMISSION, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<COMMISSION>(arg0, arg1);
        let v0 = Manager{
            id      : 0x2::object::new(arg1),
            version : 0,
            admin   : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<Manager>(v0);
    }

    entry fun set_admin(arg0: &mut Manager, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify_admin(arg0, arg2);
        verify_version(arg0);
        arg0.admin = arg1;
    }

    entry fun set_version(arg0: &mut Manager, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_admin(arg0, arg2);
        arg0.version = arg1;
    }

    fun verify_admin(arg0: &Manager, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 1);
    }

    fun verify_version(arg0: &Manager) {
        assert!(arg0.version == 0, 2);
    }

    entry fun withdraw<T0>(arg0: &mut Manager, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        verify_admin(arg0, arg3);
        verify_version(arg0);
        let v0 = if (arg1 == 0) {
            0x2::balance::withdraw_all<T0>(get_balance<T0>(arg0))
        } else {
            0x2::balance::split<T0>(get_balance<T0>(arg0), arg1)
        };
        if (0x2::tx_context::sender(arg3) == arg2) {
            0x2::pay::keep<T0>(0x2::coin::from_balance<T0>(v0, arg3), arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg3), arg2);
        };
    }

    // decompiled from Move bytecode v6
}

