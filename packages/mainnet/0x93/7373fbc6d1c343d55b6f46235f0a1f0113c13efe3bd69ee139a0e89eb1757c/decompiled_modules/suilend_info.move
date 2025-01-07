module 0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::suilend_info {
    public fun info<T0, T1, T2, T3>(arg0: &0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::vault::Vault<T0, T1, T2, 0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::suilend_config::SuilendConfig<T0, T1, T3>>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T3>) : (u64, u64, u64) {
        (0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::suilend_config::deposited<T0, T1, T3>(0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::vault::protocol_config<T0, T1, T2, 0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::suilend_config::SuilendConfig<T0, T1, T3>>(arg0), arg1), 0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::suilend_config::borrowed<T0, T1, T3>(0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::vault::protocol_config<T0, T1, T2, 0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::suilend_config::SuilendConfig<T0, T1, T3>>(arg0), arg1), 0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::config::total_vt_supply<T0, T1, T2>(0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::vault::config<T0, T1, T2, 0x937373fbc6d1c343d55b6f46235f0a1f0113c13efe3bd69ee139a0e89eb1757c::suilend_config::SuilendConfig<T0, T1, T3>>(arg0)))
    }

    // decompiled from Move bytecode v6
}

