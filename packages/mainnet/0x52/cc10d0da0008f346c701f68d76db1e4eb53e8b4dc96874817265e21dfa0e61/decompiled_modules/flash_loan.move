module 0x52cc10d0da0008f346c701f68d76db1e4eb53e8b4dc96874817265e21dfa0e61::flash_loan {
    public fun borrow_flash_loan<T0>(arg0: &0x52cc10d0da0008f346c701f68d76db1e4eb53e8b4dc96874817265e21dfa0e61::version::Version, arg1: &mut 0x52cc10d0da0008f346c701f68d76db1e4eb53e8b4dc96874817265e21dfa0e61::market::Market, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x52cc10d0da0008f346c701f68d76db1e4eb53e8b4dc96874817265e21dfa0e61::reserve::FlashLoan<T0>) {
        abort 0
    }

    public fun repay_flash_loan<T0>(arg0: &0x52cc10d0da0008f346c701f68d76db1e4eb53e8b4dc96874817265e21dfa0e61::version::Version, arg1: &mut 0x52cc10d0da0008f346c701f68d76db1e4eb53e8b4dc96874817265e21dfa0e61::market::Market, arg2: 0x2::coin::Coin<T0>, arg3: 0x52cc10d0da0008f346c701f68d76db1e4eb53e8b4dc96874817265e21dfa0e61::reserve::FlashLoan<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

