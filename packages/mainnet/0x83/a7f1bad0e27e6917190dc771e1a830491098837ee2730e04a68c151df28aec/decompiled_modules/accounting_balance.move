module 0xde4b329ebc554bd9e057070dc9c67012c5d9469b3fb24d75f706cb7da6845338::accounting_balance {
    struct AccountingBalance has drop, store {
        value: u64,
    }

    public fun add(arg0: &mut AccountingBalance, arg1: u64) : u64 {
        arg0.value = arg0.value + arg1;
        arg0.value
    }

    fun err_not_enough_to_sub() {
        abort 100
    }

    public fun sub(arg0: &mut AccountingBalance, arg1: u64) : u64 {
        if (arg0.value < arg1) {
            err_not_enough_to_sub();
        };
        arg0.value = arg0.value - arg1;
        arg0.value
    }

    public fun value(arg0: &AccountingBalance) : u64 {
        arg0.value
    }

    public fun zero() : AccountingBalance {
        AccountingBalance{value: 0}
    }

    // decompiled from Move bytecode v6
}

