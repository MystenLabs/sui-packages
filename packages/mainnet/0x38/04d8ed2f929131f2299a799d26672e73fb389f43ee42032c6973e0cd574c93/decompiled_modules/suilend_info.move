module 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::suilend_info {
    public fun info<T0, T1, T2, T3>(arg0: &0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::vault::Vault<T0, T1, T2, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::suilend_config::SuilendConfig<T0, T1, T3>>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T3>) : (u64, u64, u64) {
        (0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::suilend_config::deposited<T0, T1, T3>(0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::vault::protocol_config<T0, T1, T2, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::suilend_config::SuilendConfig<T0, T1, T3>>(arg0), arg1), 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::suilend_config::borrowed<T0, T1, T3>(0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::vault::protocol_config<T0, T1, T2, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::suilend_config::SuilendConfig<T0, T1, T3>>(arg0), arg1), 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::config::total_vt_supply<T0, T1, T2>(0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::vault::config<T0, T1, T2, 0x3804d8ed2f929131f2299a799d26672e73fb389f43ee42032c6973e0cd574c93::suilend_config::SuilendConfig<T0, T1, T3>>(arg0)))
    }

    // decompiled from Move bytecode v6
}

