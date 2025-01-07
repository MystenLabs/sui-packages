module 0x593419f45e62aa920a25805ae1fb38e062d2c9c34384c6588a19330159b2aad5::vault {
    struct Vault has store, key {
        id: 0x2::object::UID,
        balances: 0x2::bag::Bag,
    }

    struct DepositEvent has copy, drop, store {
        coin_type: 0x1::ascii::String,
        deposit_amount: u64,
        after_amount: u64,
    }

    struct WithdrawEvent has copy, drop, store {
        coin_type: 0x1::ascii::String,
        withdraw_amount: u64,
        after_amount: u64,
    }

    struct VaultInitEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
    }

    public fun balances(arg0: &Vault) : &0x2::bag::Bag {
        &arg0.balances
    }

    public fun deposite_balance<T0>(arg0: &0x593419f45e62aa920a25805ae1fb38e062d2c9c34384c6588a19330159b2aad5::config::GlobalConfig, arg1: &mut Vault, arg2: 0x2::balance::Balance<T0>) : u64 {
        0x593419f45e62aa920a25805ae1fb38e062d2c9c34384c6588a19330159b2aad5::config::checked_package_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg1.balances, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.balances, v0, 0x2::balance::zero<T0>());
        };
        let v1 = 0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.balances, 0x1::type_name::get<T0>()), arg2);
        let v2 = DepositEvent{
            coin_type      : 0x1::type_name::into_string(v0),
            deposit_amount : 0x2::balance::value<T0>(&arg2),
            after_amount   : v1,
        };
        0x2::event::emit<DepositEvent>(v2);
        v1
    }

    public fun deposite_coin<T0>(arg0: &0x593419f45e62aa920a25805ae1fb38e062d2c9c34384c6588a19330159b2aad5::config::GlobalConfig, arg1: &mut Vault, arg2: 0x2::coin::Coin<T0>) : u64 {
        deposite_balance<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2))
    }

    public fun get_balance<T0>(arg0: &Vault) : u64 {
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, 0x1::type_name::get<T0>()))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id       : 0x2::object::new(arg0),
            balances : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<Vault>(v0);
        let v1 = VaultInitEvent{vault_id: 0x2::object::id<Vault>(&v0)};
        0x2::event::emit<VaultInitEvent>(v1);
    }

    public fun withdraw_balance<T0>(arg0: &0x593419f45e62aa920a25805ae1fb38e062d2c9c34384c6588a19330159b2aad5::config::GlobalConfig, arg1: &mut Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x593419f45e62aa920a25805ae1fb38e062d2c9c34384c6588a19330159b2aad5::config::checked_package_version(arg0);
        0x593419f45e62aa920a25805ae1fb38e062d2c9c34384c6588a19330159b2aad5::config::checked_vault_role(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.balances, 0x1::type_name::get<T0>());
        let v1 = WithdrawEvent{
            coin_type       : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            withdraw_amount : arg2,
            after_amount    : 0x2::balance::value<T0>(v0),
        };
        0x2::event::emit<WithdrawEvent>(v1);
        0x2::balance::split<T0>(v0, arg2)
    }

    public fun withdraw_coin<T0>(arg0: &0x593419f45e62aa920a25805ae1fb38e062d2c9c34384c6588a19330159b2aad5::config::GlobalConfig, arg1: &mut Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = withdraw_balance<T0>(arg0, arg1, arg2, arg3);
        0x2::coin::from_balance<T0>(v0, arg3)
    }

    // decompiled from Move bytecode v6
}

