module 0x59ecd46b5952edb73a4472d289c6fcc84d1c4a0033322d38ca6a39004d6e7eeb::liquidation_guard {
    struct LiquidationReceipt {
        principal: u64,
        min_profit: u64,
        recipient: address,
    }

    public fun begin_liquidation<T0>(arg0: u64, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : LiquidationReceipt {
        assert!(arg0 > 0, 203);
        checked_add(arg0, arg1);
        LiquidationReceipt{
            principal  : arg0,
            min_profit : arg1,
            recipient  : arg2,
        }
    }

    fun checked_add(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) + (arg1 as u128);
        assert!(v0 <= 18446744073709551615, 202);
        (v0 as u64)
    }

    public fun confirm_liquidation<T0>(arg0: LiquidationReceipt, arg1: &0x2::coin::Coin<T0>) {
        let LiquidationReceipt {
            principal  : v0,
            min_profit : v1,
            recipient  : _,
        } = arg0;
        let v3 = 0x2::coin::value<T0>(arg1);
        assert!(v3 >= v0, 201);
        assert!(v3 >= checked_add(v0, v1), 200);
    }

    public fun confirm_liquidation_and_return<T0>(arg0: LiquidationReceipt, arg1: 0x2::coin::Coin<T0>) : 0x2::coin::Coin<T0> {
        confirm_liquidation<T0>(arg0, &arg1);
        arg1
    }

    public fun is_profitable(arg0: u64, arg1: u64, arg2: u64) : bool {
        if (arg0 < arg1) {
            return false
        };
        arg0 - arg1 >= arg2
    }

    public fun min_out_required(arg0: &LiquidationReceipt) : u64 {
        checked_add(arg0.principal, arg0.min_profit)
    }

    public fun min_profit(arg0: &LiquidationReceipt) : u64 {
        arg0.min_profit
    }

    public fun principal(arg0: &LiquidationReceipt) : u64 {
        arg0.principal
    }

    public fun recipient(arg0: &LiquidationReceipt) : address {
        arg0.recipient
    }

    public fun repay_required(arg0: &LiquidationReceipt) : u64 {
        arg0.principal
    }

    // decompiled from Move bytecode v7
}

