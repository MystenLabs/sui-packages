module 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::lend {
    public fun borrow<T0>(arg0: &0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config::FeeConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::fee::pay_fee_1<T0, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_lend::BorrowEvent>(arg0, arg1, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::constant::lending_fee_type(), arg2);
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_lend::emit_borrow_event(0x2::tx_context::sender(arg2), 0x1::type_name::get<T0>(), 0x2::coin::value<T0>(arg1));
    }

    public fun lend<T0>(arg0: &0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config::FeeConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::fee::pay_fee_1<T0, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_lend::LendEvent>(arg0, arg1, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::constant::lending_fee_type(), arg2);
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_lend::emit_lend_event(0x2::tx_context::sender(arg2), 0x1::type_name::get<T0>(), 0x2::coin::value<T0>(arg1));
    }

    public fun repay<T0>(arg0: &0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config::FeeConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_lend::emit_repay_event(0x2::tx_context::sender(arg2), 0x1::type_name::get<T0>(), 0x2::coin::value<T0>(arg1));
    }

    public fun withdraw<T0>(arg0: &0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config::FeeConfig, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::fee::pay_fee_1<T0, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_lend::WithdrawEvent>(arg0, arg1, 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::constant::lending_fee_type(), arg2);
        0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::events_lend::emit_withdraw_event(0x2::tx_context::sender(arg2), 0x1::type_name::get<T0>(), 0x2::coin::value<T0>(arg1));
    }

    // decompiled from Move bytecode v6
}

