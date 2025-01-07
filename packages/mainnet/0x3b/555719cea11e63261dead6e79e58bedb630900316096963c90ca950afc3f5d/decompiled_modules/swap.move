module 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::swap {
    public fun add_swap_route<T0, T1, T2>(arg0: &0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::vault::VaultCap, arg1: &mut 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::vault::Vault<T0, T1, T2>, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>, arg3: &0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::version::Version) {
        0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::version::assert_current_version(arg3);
        0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::vault::check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::vault::add_swap_route<T0, T1, T2>(arg1, arg2);
    }

    public fun remove_swap_route<T0, T1, T2>(arg0: &0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::vault::VaultCap, arg1: &mut 0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::vault::Vault<T0, T1, T2>, arg2: &0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::version::Version) {
        0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::version::assert_current_version(arg2);
        0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::vault::check_vault_cap_compatibility<T0, T1, T2>(arg0, arg1);
        0x3847d51b6c655bd9464114f553a0b78002fd2e472bb5d919f08babb61afacdf::vault::remove_swap_route<T0, T1, T2>(arg1);
    }

    // decompiled from Move bytecode v6
}

