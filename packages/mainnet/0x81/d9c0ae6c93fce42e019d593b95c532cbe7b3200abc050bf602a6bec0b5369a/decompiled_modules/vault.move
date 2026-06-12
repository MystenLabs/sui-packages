module 0x97755fb8fc0c33be95c8411de5efd6e8e0d6f151b917f70b8fdcac45dac70c70::vault {
    struct Vault has store, key {
        id: 0x2::object::UID,
        users: vector<address>,
        money_bag: 0x2::bag::Bag,
    }

    public fun add_user(arg0: &mut Vault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        check_sender(arg0, arg2);
        if (!0x1::vector::contains<address>(&arg0.users, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.users, arg1);
        };
    }

    fun balance_key<T0>() : 0x1::type_name::TypeName {
        type_key<T0>()
    }

    public fun balance_of<T0>(arg0: &Vault) : u64 {
        let v0 = balance_key<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.money_bag, v0)) {
            return 0
        };
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.money_bag, v0))
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
        let v0 = &mut arg0.money_bag;
        0x2::balance::join<T0>(ensure_balance<T0>(v0), arg1);
    }

    public fun deposit_coin<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>) {
        deposit_balance<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
    }

    fun ensure_balance<T0>(arg0: &mut 0x2::bag::Bag) : &mut 0x2::balance::Balance<T0> {
        let v0 = balance_key<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(arg0, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, v0, 0x2::balance::zero<T0>());
        };
        0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, v0)
    }

    public fun take_all_balance<T0>(arg0: &mut Vault, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        check_sender(arg0, arg1);
        let v0 = balance_key<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.money_bag, v0)) {
            return 0x2::balance::zero<T0>()
        };
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.money_bag, v0);
        0x2::balance::split<T0>(v1, 0x2::balance::value<T0>(v1))
    }

    public fun take_balance<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        check_sender(arg0, arg2);
        let v0 = &mut arg0.money_bag;
        0x2::balance::split<T0>(ensure_balance<T0>(v0), arg1)
    }

    fun type_key<T0>() : 0x1::type_name::TypeName {
        0x1::type_name::with_defining_ids<T0>()
    }

    // decompiled from Move bytecode v7
}

