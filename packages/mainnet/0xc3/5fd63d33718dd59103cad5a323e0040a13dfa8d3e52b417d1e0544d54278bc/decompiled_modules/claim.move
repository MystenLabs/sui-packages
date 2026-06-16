module 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::claim {
    public fun run<T0>(arg0: &0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::state::Config, arg1: &mut 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::Vault<T0>, arg2: &mut 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::reward::Reward, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::id<T0>(arg1);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::reward::assert_vault(arg2, v1);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::reward::assert_revealed(arg2);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::reward::assert_unclaimed(arg2);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::reward::assert_claimer(arg2, v0);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::reward::mark_claimed(arg2);
        let v2 = 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::reward::amount(arg2);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::credit_shares<T0>(arg1, v0, v2);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::add_checkpointed_f_balance<T0>(arg1, v2);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::events::emit_claim(v1, 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::reward::id(arg2), 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::reward::round(arg2), v0, v2);
    }

    // decompiled from Move bytecode v7
}

