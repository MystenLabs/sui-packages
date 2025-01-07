module 0x2523d831d40010dc5d5a4e7a8ba6ab97a064e525430d7eb8a9fa374683368fb2::suilend_info {
    public fun info<T0, T1, T2, T3>(arg0: &0x2523d831d40010dc5d5a4e7a8ba6ab97a064e525430d7eb8a9fa374683368fb2::vault::Vault<T0, T1, T2, 0x2523d831d40010dc5d5a4e7a8ba6ab97a064e525430d7eb8a9fa374683368fb2::suilend_config::SuilendConfig<T0, T1, T3>>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T3>) : (u64, u64, u64) {
        (0x2523d831d40010dc5d5a4e7a8ba6ab97a064e525430d7eb8a9fa374683368fb2::suilend_config::deposited<T0, T1, T3>(0x2523d831d40010dc5d5a4e7a8ba6ab97a064e525430d7eb8a9fa374683368fb2::vault::protocol_config<T0, T1, T2, 0x2523d831d40010dc5d5a4e7a8ba6ab97a064e525430d7eb8a9fa374683368fb2::suilend_config::SuilendConfig<T0, T1, T3>>(arg0), arg1), 0x2523d831d40010dc5d5a4e7a8ba6ab97a064e525430d7eb8a9fa374683368fb2::suilend_config::borrowed<T0, T1, T3>(0x2523d831d40010dc5d5a4e7a8ba6ab97a064e525430d7eb8a9fa374683368fb2::vault::protocol_config<T0, T1, T2, 0x2523d831d40010dc5d5a4e7a8ba6ab97a064e525430d7eb8a9fa374683368fb2::suilend_config::SuilendConfig<T0, T1, T3>>(arg0), arg1), 0x2523d831d40010dc5d5a4e7a8ba6ab97a064e525430d7eb8a9fa374683368fb2::config::total_vt_supply<T0, T1, T2>(0x2523d831d40010dc5d5a4e7a8ba6ab97a064e525430d7eb8a9fa374683368fb2::vault::config<T0, T1, T2, 0x2523d831d40010dc5d5a4e7a8ba6ab97a064e525430d7eb8a9fa374683368fb2::suilend_config::SuilendConfig<T0, T1, T3>>(arg0)))
    }

    // decompiled from Move bytecode v6
}

