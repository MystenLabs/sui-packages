module 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::admin {
    public fun set_slippage<T0, T1, T2>(arg0: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::AdminCap, arg1: &mut 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::config::Uncorrelated>, arg2: u128, arg3: u128) {
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::set_slippage<T0, T1, T2, 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::config::Uncorrelated>(arg1, arg2, arg3);
    }

    public fun set_trigger_scalling<T0, T1, T2>(arg0: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::AdminCap, arg1: &mut 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::config::Uncorrelated>, arg2: u128, arg3: u128) {
        assert!(arg3 > arg2, 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::error::upper_lower_trigger_price_incompatible());
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::config::set_trigger_price_scalling(0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::borrow_mut_config<T0, T1, T2, 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::config::Uncorrelated>(arg1), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

