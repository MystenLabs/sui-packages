module 0xc8034e530e029c017d940b5af37b88451f02dd83af9d59308466da562d6fe502::cetus {
    public fun confirm_swap<T0>(arg0: &mut 0xc8034e530e029c017d940b5af37b88451f02dd83af9d59308466da562d6fe502::config::GlobalConfig, arg1: 0xc8034e530e029c017d940b5af37b88451f02dd83af9d59308466da562d6fe502::config::WrapContext, arg2: 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::SwapContext, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xc8034e530e029c017d940b5af37b88451f02dd83af9d59308466da562d6fe502::config::checked_package_version(arg0);
        0xc8034e530e029c017d940b5af37b88451f02dd83af9d59308466da562d6fe502::config::checked_pause(arg0);
        let (_, v1, v2, v3, v4, v5) = 0xc8034e530e029c017d940b5af37b88451f02dd83af9d59308466da562d6fe502::config::destroy_wrap_context(arg1);
        let v6 = 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::confirm_swap<T0>(arg2, arg3);
        let (v7, v8) = 0xc8034e530e029c017d940b5af37b88451f02dd83af9d59308466da562d6fe502::config::deduct_fee<T0>(arg0, v6, arg3);
        let v9 = v7;
        assert!(0x2::coin::value<T0>(&v9) >= v4, 2);
        0xc8034e530e029c017d940b5af37b88451f02dd83af9d59308466da562d6fe502::config::emit_confirm_swap_event(0x2::tx_context::sender(arg3), v1, v2, v3, 0x2::coin::value<T0>(&v6), v4, v8, v5);
        v9
    }

    public fun new_context<T0, T1>(arg0: &mut 0xc8034e530e029c017d940b5af37b88451f02dd83af9d59308466da562d6fe502::config::GlobalConfig, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) : (0xc8034e530e029c017d940b5af37b88451f02dd83af9d59308466da562d6fe502::config::WrapContext, 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::SwapContext) {
        0xc8034e530e029c017d940b5af37b88451f02dd83af9d59308466da562d6fe502::config::checked_package_version(arg0);
        0xc8034e530e029c017d940b5af37b88451f02dd83af9d59308466da562d6fe502::config::checked_pause(arg0);
        let v0 = 0x2::coin::value<T0>(&arg4);
        assert!(v0 > 0, 1);
        (0xc8034e530e029c017d940b5af37b88451f02dd83af9d59308466da562d6fe502::config::new_wrap_context(0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), v0, arg2, b"CETUS", arg5), 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::new_swap_context<T0, T1>(arg1, arg2, arg3, arg4, 0, @0x0, arg5))
    }

    // decompiled from Move bytecode v6
}

