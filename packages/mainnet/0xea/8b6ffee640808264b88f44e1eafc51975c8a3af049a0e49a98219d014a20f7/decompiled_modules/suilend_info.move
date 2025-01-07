module 0xd61f40358e2c7843e37c42b7c58f75b161df6f08c96e75e310ed2d3b4b82c775::suilend_info {
    public fun info<T0, T1, T2, T3>(arg0: &0xd61f40358e2c7843e37c42b7c58f75b161df6f08c96e75e310ed2d3b4b82c775::vault::Vault<T0, T1, T2, 0xd61f40358e2c7843e37c42b7c58f75b161df6f08c96e75e310ed2d3b4b82c775::suilend_config::SuilendConfig<T0, T1, T3>>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T3>) : (u64, u64, u64) {
        (0xd61f40358e2c7843e37c42b7c58f75b161df6f08c96e75e310ed2d3b4b82c775::suilend_config::deposited<T0, T1, T3>(0xd61f40358e2c7843e37c42b7c58f75b161df6f08c96e75e310ed2d3b4b82c775::vault::protocol_config<T0, T1, T2, 0xd61f40358e2c7843e37c42b7c58f75b161df6f08c96e75e310ed2d3b4b82c775::suilend_config::SuilendConfig<T0, T1, T3>>(arg0), arg1), 0xd61f40358e2c7843e37c42b7c58f75b161df6f08c96e75e310ed2d3b4b82c775::suilend_config::borrowed<T0, T1, T3>(0xd61f40358e2c7843e37c42b7c58f75b161df6f08c96e75e310ed2d3b4b82c775::vault::protocol_config<T0, T1, T2, 0xd61f40358e2c7843e37c42b7c58f75b161df6f08c96e75e310ed2d3b4b82c775::suilend_config::SuilendConfig<T0, T1, T3>>(arg0), arg1), 0xd61f40358e2c7843e37c42b7c58f75b161df6f08c96e75e310ed2d3b4b82c775::config::total_vt_supply<T0, T1, T2>(0xd61f40358e2c7843e37c42b7c58f75b161df6f08c96e75e310ed2d3b4b82c775::vault::config<T0, T1, T2, 0xd61f40358e2c7843e37c42b7c58f75b161df6f08c96e75e310ed2d3b4b82c775::suilend_config::SuilendConfig<T0, T1, T3>>(arg0)))
    }

    // decompiled from Move bytecode v6
}

