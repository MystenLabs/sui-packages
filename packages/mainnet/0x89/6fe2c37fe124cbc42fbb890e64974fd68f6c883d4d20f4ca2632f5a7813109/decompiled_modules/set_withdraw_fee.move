module 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::set_withdraw_fee {
    public fun run<T0>(arg0: &0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::state::Config, arg1: &mut 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::Vault<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::state::assert_admin(arg0, 0x2::tx_context::sender(arg3));
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::validate_fee(arg2);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::set_withdraw_fee_internal<T0>(arg1, arg2);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::events::emit_withdraw_fee_updated(0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::id<T0>(arg1), 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::withdraw_fee<T0>(arg1), arg2);
    }

    // decompiled from Move bytecode v7
}

