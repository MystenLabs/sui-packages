module 0xf2bcf3b10db2adf42b6e09a45e29aee96b5f135de588d013188dfd893a9c6a99::flashloan {
    public fun current_flash_loan<T0, T1>(arg0: &0xf2bcf3b10db2adf42b6e09a45e29aee96b5f135de588d013188dfd893a9c6a99::liquidator::Liquidator, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg2: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg3: u8, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::FlashLoan<T0, T1>) {
        0xf2bcf3b10db2adf42b6e09a45e29aee96b5f135de588d013188dfd893a9c6a99::liquidator::ensure_caller_whitelisted(arg0, 0x2::tx_context::sender(arg5));
        0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::flash_loan::borrow_flash_loan<T0, T1>(arg1, 0xf2bcf3b10db2adf42b6e09a45e29aee96b5f135de588d013188dfd893a9c6a99::liquidator::borrow_package_caller_cap(arg0), arg2, arg3, arg4, arg5)
    }

    public fun repay_flash_loan<T0, T1>(arg0: &0xf2bcf3b10db2adf42b6e09a45e29aee96b5f135de588d013188dfd893a9c6a99::liquidator::Liquidator, arg1: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg2: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::FlashLoan<T0, T1>, arg5: &mut 0x2::tx_context::TxContext) {
        0xf2bcf3b10db2adf42b6e09a45e29aee96b5f135de588d013188dfd893a9c6a99::liquidator::ensure_caller_whitelisted(arg0, 0x2::tx_context::sender(arg5));
        0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::flash_loan::repay_flash_loan<T0, T1>(arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

