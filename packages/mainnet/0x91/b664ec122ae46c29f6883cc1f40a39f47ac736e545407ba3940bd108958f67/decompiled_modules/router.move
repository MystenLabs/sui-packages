module 0x91b664ec122ae46c29f6883cc1f40a39f47ac736e545407ba3940bd108958f67::router {
    public entry fun add_liquidity<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x91b664ec122ae46c29f6883cc1f40a39f47ac736e545407ba3940bd108958f67::factory::Container, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: address, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun add_liquidity_direct<T0, T1>(arg0: &mut 0x91b664ec122ae46c29f6883cc1f40a39f47ac736e545407ba3940bd108958f67::pair::PairMetadata<T0, T1>, arg1: &0x91b664ec122ae46c29f6883cc1f40a39f47ac736e545407ba3940bd108958f67::treasury::Treasury, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x91b664ec122ae46c29f6883cc1f40a39f47ac736e545407ba3940bd108958f67::pair::LP<T0, T1>> {
        abort 0
    }

    fun ensure(arg0: &0x2::clock::Clock, arg1: u64) {
        abort 0
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x91b664ec122ae46c29f6883cc1f40a39f47ac736e545407ba3940bd108958f67::factory::Container, arg2: 0x2::coin::Coin<0x91b664ec122ae46c29f6883cc1f40a39f47ac736e545407ba3940bd108958f67::pair::LP<T0, T1>>, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun swap_exact_double_input<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x91b664ec122ae46c29f6883cc1f40a39f47ac736e545407ba3940bd108958f67::factory::Container, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: address, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun swap_exact_input<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x91b664ec122ae46c29f6883cc1f40a39f47ac736e545407ba3940bd108958f67::factory::Container, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun swap_exact_input_direct<T0, T1>(arg0: &mut 0x91b664ec122ae46c29f6883cc1f40a39f47ac736e545407ba3940bd108958f67::factory::Container, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        abort 0
    }

    public entry fun swap_exact_input_double_output<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x91b664ec122ae46c29f6883cc1f40a39f47ac736e545407ba3940bd108958f67::factory::Container, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: address, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun swap_exact_input_doublehop<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x91b664ec122ae46c29f6883cc1f40a39f47ac736e545407ba3940bd108958f67::factory::Container, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun swap_exact_input_quadruple_output<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut 0x91b664ec122ae46c29f6883cc1f40a39f47ac736e545407ba3940bd108958f67::factory::Container, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: address, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun swap_exact_input_quintuple_output<T0, T1, T2, T3, T4, T5>(arg0: &0x2::clock::Clock, arg1: &mut 0x91b664ec122ae46c29f6883cc1f40a39f47ac736e545407ba3940bd108958f67::factory::Container, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: address, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun swap_exact_input_triple_output<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x91b664ec122ae46c29f6883cc1f40a39f47ac736e545407ba3940bd108958f67::factory::Container, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: address, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun swap_exact_input_triplehop<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x91b664ec122ae46c29f6883cc1f40a39f47ac736e545407ba3940bd108958f67::factory::Container, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun swap_exact_output<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x91b664ec122ae46c29f6883cc1f40a39f47ac736e545407ba3940bd108958f67::factory::Container, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun swap_exact_output_direct<T0, T1>(arg0: &mut 0x91b664ec122ae46c29f6883cc1f40a39f47ac736e545407ba3940bd108958f67::factory::Container, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        abort 0
    }

    public entry fun swap_exact_output_doublehop<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x91b664ec122ae46c29f6883cc1f40a39f47ac736e545407ba3940bd108958f67::factory::Container, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun swap_exact_output_triplehop<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x91b664ec122ae46c29f6883cc1f40a39f47ac736e545407ba3940bd108958f67::factory::Container, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun swap_exact_quadruple_input<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut 0x91b664ec122ae46c29f6883cc1f40a39f47ac736e545407ba3940bd108958f67::factory::Container, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: 0x2::coin::Coin<T3>, arg6: u64, arg7: address, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun swap_exact_quintuple_input<T0, T1, T2, T3, T4, T5>(arg0: &0x2::clock::Clock, arg1: &mut 0x91b664ec122ae46c29f6883cc1f40a39f47ac736e545407ba3940bd108958f67::factory::Container, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: 0x2::coin::Coin<T3>, arg6: 0x2::coin::Coin<T4>, arg7: u64, arg8: address, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun swap_exact_triple_input<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut 0x91b664ec122ae46c29f6883cc1f40a39f47ac736e545407ba3940bd108958f67::factory::Container, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: u64, arg6: address, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun swap_exact_x_to_y_direct<T0, T1>(arg0: &mut 0x91b664ec122ae46c29f6883cc1f40a39f47ac736e545407ba3940bd108958f67::pair::PairMetadata<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        abort 0
    }

    public fun swap_exact_y_to_x_direct<T0, T1>(arg0: &mut 0x91b664ec122ae46c29f6883cc1f40a39f47ac736e545407ba3940bd108958f67::pair::PairMetadata<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 0
    }

    public fun swap_x_to_exact_y_direct<T0, T1>(arg0: &mut 0x91b664ec122ae46c29f6883cc1f40a39f47ac736e545407ba3940bd108958f67::pair::PairMetadata<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        abort 0
    }

    public fun swap_y_to_exact_x_direct<T0, T1>(arg0: &mut 0x91b664ec122ae46c29f6883cc1f40a39f47ac736e545407ba3940bd108958f67::pair::PairMetadata<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        abort 0
    }

    // decompiled from Move bytecode v6
}

