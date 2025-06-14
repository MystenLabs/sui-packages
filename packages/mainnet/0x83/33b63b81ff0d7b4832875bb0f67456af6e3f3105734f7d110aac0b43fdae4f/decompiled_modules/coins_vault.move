module 0x8333b63b81ff0d7b4832875bb0f67456af6e3f3105734f7d110aac0b43fdae4f::coins_vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        balance: 0x2::bag::Bag,
        authorized_withdrawers: 0x2::table::Table<address, bool>,
    }

    struct BalanceEvent has copy, drop {
        amount: u64,
    }

    struct AuthorizationEvent has copy, drop {
        admin: address,
        authorized_withdrawer: address,
    }

    struct RevocationEvent has copy, drop {
        admin: address,
        unauthorized_withdrawer: address,
    }

    struct DepositEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        depositor: address,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        withdrawer: address,
        amount: u64,
    }

    public fun deposit<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balance, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balance, v0, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balance, v0), 0x2::coin::into_balance<T0>(arg1));
        let v1 = DepositEvent{
            coin_type : v0,
            depositor : 0x2::tx_context::sender(arg2),
            amount    : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    public fun get_balance<T0>(arg0: &Vault) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balance, v0)) {
            0
        } else {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balance, v0))
        };
        let v2 = BalanceEvent{amount: v1};
        0x2::event::emit<BalanceEvent>(v2);
    }

    public fun grant_withdrawal_permission(arg0: &AdminCap, arg1: &mut Vault, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::table::add<address, bool>(&mut arg1.authorized_withdrawers, arg2, true);
        let v0 = AuthorizationEvent{
            admin                 : 0x2::tx_context::sender(arg3),
            authorized_withdrawer : arg2,
        };
        0x2::event::emit<AuthorizationEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Vault{
            id                     : 0x2::object::new(arg0),
            balance                : 0x2::bag::new(arg0),
            authorized_withdrawers : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Vault>(v1);
    }

    public fun is_authorized(arg0: &Vault, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.authorized_withdrawers, arg1)
    }

    public fun revoke_withdrawal_permission(arg0: &AdminCap, arg1: &mut Vault, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::table::remove<address, bool>(&mut arg1.authorized_withdrawers, arg2);
        let v0 = RevocationEvent{
            admin                   : 0x2::tx_context::sender(arg3),
            unauthorized_withdrawer : arg2,
        };
        0x2::event::emit<RevocationEvent>(v0);
    }

    public fun withdraw_coin<T0>(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_authorized(arg0, v0), 1);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balance, v1), 2);
        let v2 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balance, v1);
        assert!(0x2::balance::value<T0>(v2) >= arg1, 2);
        let v3 = WithdrawEvent{
            coin_type  : v1,
            withdrawer : v0,
            amount     : arg1,
        };
        0x2::event::emit<WithdrawEvent>(v3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v2, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

