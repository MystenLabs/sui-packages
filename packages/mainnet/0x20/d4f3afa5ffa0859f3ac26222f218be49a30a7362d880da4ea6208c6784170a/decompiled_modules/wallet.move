module 0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::wallet {
    struct Wallet<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct WalletCreateEvent has copy, drop {
        wallet_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
    }

    struct WalletDepositEvent has copy, drop {
        wallet_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        deposit_amount: u64,
        wallet_balance: u64,
    }

    struct WalletWithdrawEvent has copy, drop {
        wallet_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        withdraw_amount: u64,
    }

    public(friend) fun take<T0>(arg0: &mut Wallet<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::take<T0>(&mut arg0.balance, arg1, arg2)
    }

    public entry fun create_wallet<T0>(arg0: &0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Wallet<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<T0>(),
        };
        let v1 = WalletCreateEvent{
            wallet_id : 0x2::object::id<Wallet<T0>>(&v0),
            coin_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<WalletCreateEvent>(v1);
        0x2::transfer::public_share_object<Wallet<T0>>(v0);
    }

    public entry fun deposit_wallet<T0>(arg0: &0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::admin::AdminCap, arg1: &mut Wallet<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::put<T0>(&mut arg1.balance, 0x2::coin::split<T0>(&mut arg2, arg3, arg4));
        let v0 = WalletDepositEvent{
            wallet_id      : 0x2::object::id<Wallet<T0>>(arg1),
            coin_type      : 0x1::type_name::get<T0>(),
            deposit_amount : arg3,
            wallet_balance : 0x2::balance::value<T0>(&arg1.balance),
        };
        0x2::event::emit<WalletDepositEvent>(v0);
        if (0x2::coin::value<T0>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::destroy_zero<T0>(arg2);
        };
    }

    public fun get_balance<T0>(arg0: &Wallet<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public entry fun withdraw_wallet<T0>(arg0: &0x20d4f3afa5ffa0859f3ac26222f218be49a30a7362d880da4ea6208c6784170a::admin::AdminCap, arg1: &mut Wallet<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg1.balance);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, v0, arg2), 0x2::tx_context::sender(arg2));
        let v1 = WalletWithdrawEvent{
            wallet_id       : 0x2::object::id<Wallet<T0>>(arg1),
            coin_type       : 0x1::type_name::get<T0>(),
            withdraw_amount : v0,
        };
        0x2::event::emit<WalletWithdrawEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

