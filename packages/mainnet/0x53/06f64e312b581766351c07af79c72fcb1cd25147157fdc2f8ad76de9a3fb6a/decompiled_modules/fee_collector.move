module 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::fee_collector {
    struct FeeCollector has store {
        fee_amount: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun balance_value(arg0: &FeeCollector) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun change_fee(arg0: &mut FeeCollector, arg1: u64) {
        arg0.fee_amount = arg1;
    }

    public fun deposit(arg0: &mut FeeCollector, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        deposit_balance(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun deposit_balance(arg0: &mut FeeCollector, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1) == arg0.fee_amount, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, arg1);
    }

    public fun fee_amount(arg0: &FeeCollector) : u64 {
        arg0.fee_amount
    }

    public fun new(arg0: u64) : FeeCollector {
        FeeCollector{
            fee_amount : arg0,
            balance    : 0x2::balance::zero<0x2::sui::SUI>(),
        }
    }

    public fun withdraw(arg0: &mut FeeCollector, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(withdraw_balance(arg0, arg1), arg2)
    }

    public fun withdraw_balance(arg0: &mut FeeCollector, arg1: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1)
    }

    // decompiled from Move bytecode v6
}

