module 0x87b3cb09fdfb6547dc0a1c90972bf65d569503f201d902dbb6ec3d29816f762::arb {
    struct USDC has drop {
        dummy_field: bool,
    }

    struct ArbConfig has key {
        id: 0x2::object::UID,
    }

    struct ProfitEvent has copy, drop {
        swap_amount: u64,
        profit: u64,
    }

    public fun create_config(arg0: &mut 0x2::tx_context::TxContext) : ArbConfig {
        ArbConfig{id: 0x2::object::new(arg0)}
    }

    public fun extract_profit<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun record_profit(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ProfitEvent{
            swap_amount : arg0,
            profit      : arg1,
        };
        0x2::event::emit<ProfitEvent>(v0);
    }

    public fun split_and_destroy<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(arg0, arg1)
    }

    // decompiled from Move bytecode v7
}

