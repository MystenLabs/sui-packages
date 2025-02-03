module 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::lp_residual {
    public fun lp_residual<T0, T1, T2, T3: copy + drop + store>(arg0: &mut 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::Version, arg3: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (_, _) = 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::utils::lp_residual_amount<T0, T1, T2, T3>(arg0, arg1, arg4, true, 0, arg2, arg3, arg5);
        let (_, _) = 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::utils::lp_residual_amount<T0, T1, T2, T3>(arg0, arg1, arg4, false, 0, arg2, arg3, arg5);
    }

    // decompiled from Move bytecode v6
}

