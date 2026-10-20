module 0x96be43d00847c97a7dd2ec7dbd3063497c4308a2fcd0dd27e2ead24ab612b145::ip {
    public fun ab<T0, T1>(arg0: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        own(arg3);
        0x2::coin::into_balance<T1>(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::swap_token_x<0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::curve::Volatile, T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(arg1, arg3), 0, arg3))
    }

    public fun ac<T0, T1>(arg0: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        own(arg3);
        0x2::coin::into_balance<T1>(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::swap_token_x<0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::curve::Stable, T0, T1>(arg0, arg2, 0x2::coin::from_balance<T0>(arg1, arg3), 0, arg3))
    }

    public fun ba<T0, T1>(arg0: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        own(arg3);
        0x2::coin::into_balance<T0>(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::swap_token_y<0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::curve::Volatile, T0, T1>(arg0, arg2, 0x2::coin::from_balance<T1>(arg1, arg3), 0, arg3))
    }

    public fun ca<T0, T1>(arg0: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        own(arg3);
        0x2::coin::into_balance<T0>(0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::swap_token_y<0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::curve::Stable, T0, T1>(arg0, arg2, 0x2::coin::from_balance<T1>(arg1, arg3), 0, arg3))
    }

    fun own(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x57f118d56fe158c8bd5966fd87eb106545fd5628528af42f6a05eebdf9aa3380, 0);
    }

    public fun sx<T0>(arg0: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        ab<0x2::sui::SUI, T0>(arg0, arg1, arg2, arg3)
    }

    public fun sy<T0>(arg0: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        ac<0x2::sui::SUI, T0>(arg0, arg1, arg2, arg3)
    }

    public fun xs<T0>(arg0: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        ba<0x2::sui::SUI, T0>(arg0, arg1, arg2, arg3)
    }

    public fun ys<T0>(arg0: &mut 0x5c45d10c26c5fb53bfaff819666da6bc7053d2190dfa29fec311cc666ff1f4b0::core::DEXStorage, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        ca<0x2::sui::SUI, T0>(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

