module 0x85a8c04f6555ef9919c352d016654031d7920b5faa3238183b25203a6dd7979f::kk {
    public entry fun mint<T0, T1>(arg0: &0x2::clock::Clock, arg1: u64, arg2: u64, arg3: &mut 0xed816e3db20f15607286c413ae32898e5ad096e1029937e03a3b088464b35ad8::launchpad::LaunchPadInfo, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0xed816e3db20f15607286c413ae32898e5ad096e1029937e03a3b088464b35ad8::launchpad::take_amount<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

