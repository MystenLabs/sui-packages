module 0xd0e06b360a35bf50532f1947c8f131b724c2cff11db847bc3a04bcf3242b0f1c::flashloan {
    public fun current_flash_loan<T0, T1>(arg0: &0xd0e06b360a35bf50532f1947c8f131b724c2cff11db847bc3a04bcf3242b0f1c::liquidator::Liquidator, arg1: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ProtocolApp, arg2: &mut 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>, arg3: u8, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::FlashLoan<T0, T1>) {
        0xd0e06b360a35bf50532f1947c8f131b724c2cff11db847bc3a04bcf3242b0f1c::liquidator::ensure_caller_whitelisted(arg0, 0x2::tx_context::sender(arg5));
        0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::flash_loan::borrow_flash_loan<T0, T1>(arg1, 0xd0e06b360a35bf50532f1947c8f131b724c2cff11db847bc3a04bcf3242b0f1c::liquidator::borrow_package_caller_cap(arg0), arg2, arg3, arg4, arg5)
    }

    public fun repay_flash_loan<T0, T1>(arg0: &0xd0e06b360a35bf50532f1947c8f131b724c2cff11db847bc3a04bcf3242b0f1c::liquidator::Liquidator, arg1: &mut 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::app::ProtocolApp, arg2: &mut 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::FlashLoan<T0, T1>, arg5: &mut 0x2::tx_context::TxContext) {
        0xd0e06b360a35bf50532f1947c8f131b724c2cff11db847bc3a04bcf3242b0f1c::liquidator::ensure_caller_whitelisted(arg0, 0x2::tx_context::sender(arg5));
        0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::flash_loan::repay_flash_loan<T0, T1>(arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

