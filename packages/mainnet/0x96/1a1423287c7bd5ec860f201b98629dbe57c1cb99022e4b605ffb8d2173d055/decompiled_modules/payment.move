module 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::payment {
    struct PaymentConfig has copy, drop, store {
        ticket_cost: u64,
        pot_ratio: 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::float::Float,
        jackpot_ratio: 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::float::Float,
    }

    public fun check_and_split<T0>(arg0: &PaymentConfig, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg1) != arg0.ticket_cost) {
            err_not_enough_payment();
        };
        let v0 = 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::float::from(0x2::coin::value<T0>(&arg1));
        (0x2::coin::split<T0>(&mut arg1, 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::float::floor(0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::float::mul(v0, arg0.pot_ratio)), arg2), 0x2::coin::split<T0>(&mut arg1, 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::float::floor(0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::float::mul(v0, arg0.jackpot_ratio)), arg2), arg1)
    }

    fun err_invalid_ratio_settings() {
        abort 0
    }

    fun err_not_enough_payment() {
        abort 1
    }

    public fun new(arg0: u64, arg1: 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::float::Float, arg2: 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::float::Float) : PaymentConfig {
        if (0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::float::gt(0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::float::add(arg2, arg1), 0x961a1423287c7bd5ec860f201b98629dbe57c1cb99022e4b605ffb8d2173d055::float::one())) {
            err_invalid_ratio_settings();
        };
        PaymentConfig{
            ticket_cost   : arg0,
            pot_ratio     : arg1,
            jackpot_ratio : arg2,
        }
    }

    public fun ticket_cost(arg0: &PaymentConfig) : u64 {
        arg0.ticket_cost
    }

    // decompiled from Move bytecode v6
}

