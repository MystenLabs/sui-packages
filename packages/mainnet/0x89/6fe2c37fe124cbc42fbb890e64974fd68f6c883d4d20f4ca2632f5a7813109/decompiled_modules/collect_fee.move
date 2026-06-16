module 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::collect_fee {
    public fun run<T0>(arg0: &0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::state::Config, arg1: &mut 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(take<T0>(arg0, arg1, arg2), v0);
    }

    public fun take<T0>(arg0: &0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::state::Config, arg1: &mut 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::state::assert_admin(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::take_accumulated_fee<T0>(arg1);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::events::emit_fee_collected(0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::vault::id<T0>(arg1), 0x2::balance::value<T0>(&v0), 0x2::tx_context::sender(arg2));
        0x2::coin::from_balance<T0>(v0, arg2)
    }

    // decompiled from Move bytecode v7
}

