module 0x4a3b6754e0b962f63063bf0aa56feb905a20ddc0bdb38cfb0ee59f9225ad16bd::vault {
    struct Vault has store, key {
        id: 0x2::object::UID,
        users: vector<address>,
        money_bag: 0x2::bag::Bag,
    }

    public fun add_user(arg0: &mut Vault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        0x1::vector::push_back<address>(&mut arg0.users, arg1);
    }

    public fun balance_of<T0>(arg0: &Vault) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.money_bag, v0)) {
            0
        } else {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.money_bag, v0))
        }
    }

    fun check_sender(arg0: &Vault, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.users, &v0), 1);
    }

    public fun create_vault(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id        : 0x2::object::new(arg1),
            users     : arg0,
            money_bag : 0x2::bag::new(arg1),
        };
        0x2::transfer::share_object<Vault>(v0);
    }

    public fun deposit_balance<T0>(arg0: &mut Vault, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.money_bag, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.money_bag, v0, arg1);
        } else {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.money_bag, v0), arg1);
        };
    }

    public fun deposit_coin<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>) {
        deposit_balance<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun take_all_balance<T0>(arg0: &mut Vault, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        check_sender(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.money_bag, v0)) {
            0x2::balance::zero<T0>()
        } else {
            0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.money_bag, v0)
        }
    }

    public fun take_balance<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        check_sender(arg0, arg2);
        0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.money_bag, 0x1::type_name::with_defining_ids<T0>()), arg1)
    }

    // decompiled from Move bytecode v6
}

