module 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_info {
    public fun info<T0, T1, T2, T3>(arg0: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T3>) : (u64, u64, u64) {
        (0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::deposited<T0, T1, T3>(0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::protocol_config<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg0), arg1), 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::borrowed<T0, T1, T3>(0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::protocol_config<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg0), arg1), 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::config::total_vt_supply<T0, T1, T2>(0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::config<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg0)))
    }

    // decompiled from Move bytecode v6
}

