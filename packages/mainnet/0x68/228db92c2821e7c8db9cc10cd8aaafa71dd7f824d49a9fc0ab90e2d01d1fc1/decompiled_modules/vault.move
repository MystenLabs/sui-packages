module 0x68228db92c2821e7c8db9cc10cd8aaafa71dd7f824d49a9fc0ab90e2d01d1fc1::vault {
    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        coin_type: 0x1::type_name::TypeName,
        available_amount: u64,
        available_balance: 0x2::balance::Balance<T0>,
    }

    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        deposit_amount: u64,
        sender: address,
    }

    struct WithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        withdraw_amount: u64,
        sender: address,
    }

    public fun coin_type<T0>(arg0: &Vault<T0>) : 0x1::type_name::TypeName {
        arg0.coin_type
    }

    public fun create_vault<T0>(arg0: &0x68228db92c2821e7c8db9cc10cd8aaafa71dd7f824d49a9fc0ab90e2d01d1fc1::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id                : 0x2::object::new(arg1),
            coin_type         : 0x1::type_name::with_defining_ids<T0>(),
            available_amount  : 0,
            available_balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &0x68228db92c2821e7c8db9cc10cd8aaafa71dd7f824d49a9fc0ab90e2d01d1fc1::admin::AdminCap, arg1: &mut Vault<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        assert!(coin_type<T0>(arg1) == 0x1::type_name::with_defining_ids<T0>(), 1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        arg1.available_amount = arg1.available_amount + v0;
        0x2::balance::join<T0>(&mut arg1.available_balance, 0x2::coin::into_balance<T0>(arg2));
        let v1 = DepositEvent{
            vault_id       : 0x2::object::id<Vault<T0>>(arg1),
            coin_type      : 0x1::type_name::with_defining_ids<T0>(),
            deposit_amount : v0,
            sender         : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    public fun withdraw<T0>(arg0: &0x68228db92c2821e7c8db9cc10cd8aaafa71dd7f824d49a9fc0ab90e2d01d1fc1::admin::AdminCap, arg1: &mut Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(coin_type<T0>(arg1) == 0x1::type_name::with_defining_ids<T0>(), 1);
        let v0 = 0x2::tx_context::sender(arg3);
        arg1.available_amount = arg1.available_amount - arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.available_balance, arg2), arg3), v0);
        let v1 = WithdrawEvent{
            vault_id        : 0x2::object::id<Vault<T0>>(arg1),
            coin_type       : 0x1::type_name::with_defining_ids<T0>(),
            withdraw_amount : arg2,
            sender          : v0,
        };
        0x2::event::emit<WithdrawEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

