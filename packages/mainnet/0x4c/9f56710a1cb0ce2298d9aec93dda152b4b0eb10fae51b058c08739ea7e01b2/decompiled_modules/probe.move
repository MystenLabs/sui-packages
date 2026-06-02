module 0x4c9f56710a1cb0ce2298d9aec93dda152b4b0eb10fae51b058c08739ea7e01b2::probe {
    struct CoinVault<phantom T0> has key {
        id: 0x2::object::UID,
        coin: 0x2::coin::Coin<T0>,
    }

    struct BalanceVault<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct DepositLikeEvent has copy, drop {
        recipient: address,
        amount: u64,
    }

    public fun abort_after_receiving_coin<T0>(arg0: 0x2::coin::Coin<T0>) {
        abort 0
    }

    public fun balance_value<T0>(arg0: &BalanceVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun coin_value<T0>(arg0: &CoinVault<T0>) : u64 {
        0x2::coin::value<T0>(&arg0.coin)
    }

    public fun emit_deposit_like(arg0: address, arg1: u64) {
        let v0 = DepositLikeEvent{
            recipient : arg0,
            amount    : arg1,
        };
        0x2::event::emit<DepositLikeEvent>(v0);
    }

    public fun unwrap_balance<T0>(arg0: BalanceVault<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let BalanceVault {
            id      : v0,
            balance : v1,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg2), arg1);
    }

    public fun unwrap_coin<T0>(arg0: CoinVault<T0>, arg1: address) {
        let CoinVault {
            id   : v0,
            coin : v1,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, arg1);
    }

    public fun wrap_balance<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = BalanceVault<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::coin::into_balance<T0>(arg0),
        };
        0x2::transfer::transfer<BalanceVault<T0>>(v0, arg1);
    }

    public fun wrap_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinVault<T0>{
            id   : 0x2::object::new(arg2),
            coin : arg0,
        };
        0x2::transfer::transfer<CoinVault<T0>>(v0, arg1);
    }

    // decompiled from Move bytecode v7
}

