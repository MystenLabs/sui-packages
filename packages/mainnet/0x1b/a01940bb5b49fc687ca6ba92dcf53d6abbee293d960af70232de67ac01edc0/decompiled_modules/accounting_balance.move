module 0x1ba01940bb5b49fc687ca6ba92dcf53d6abbee293d960af70232de67ac01edc0::accounting_balance {
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

