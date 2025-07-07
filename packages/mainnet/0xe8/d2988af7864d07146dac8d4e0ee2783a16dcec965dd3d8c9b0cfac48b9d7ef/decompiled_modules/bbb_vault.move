module 0xe8d2988af7864d07146dac8d4e0ee2783a16dcec965dd3d8c9b0cfac48b9d7ef::bbb_vault {
    struct BBBVault has key {
        id: 0x2::object::UID,
        balances: 0x2::bag::Bag,
    }

    struct BBB_VAULT has drop {
        dummy_field: bool,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : BBBVault {
        BBBVault{
            id       : 0x2::object::new(arg0),
            balances : 0x2::bag::new(arg0),
        }
    }

    public fun balances(arg0: &BBBVault) : &0x2::bag::Bag {
        &arg0.balances
    }

    public fun deposit<T0>(arg0: &mut BBBVault, arg1: 0x2::coin::Coin<T0>) {
        let v0 = &mut arg0.balances;
        let v1 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(v0, v1)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v0, v1, 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v0, v1), 0x2::coin::into_balance<T0>(arg1));
        };
    }

    public fun id(arg0: &BBBVault) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: BBB_VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<BBBVault>(new(arg1));
    }

    public(friend) fun withdraw<T0>(arg0: &mut BBBVault) : 0x2::balance::Balance<T0> {
        let v0 = &mut arg0.balances;
        let v1 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(v0, v1)) {
            0x2::balance::zero<T0>()
        } else {
            0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v0, v1))
        }
    }

    // decompiled from Move bytecode v6
}

