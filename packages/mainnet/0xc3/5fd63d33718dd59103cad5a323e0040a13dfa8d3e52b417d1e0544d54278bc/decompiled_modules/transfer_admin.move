module 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::transfer_admin {
    public fun accept(arg0: &mut 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::state::Config, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::events::emit_admin_transferred(0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::state::accept_admin_internal(arg0, v0), v0);
    }

    public fun cancel(arg0: &mut 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::state::Config, arg1: &0x2::tx_context::TxContext) {
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::state::assert_admin(arg0, 0x2::tx_context::sender(arg1));
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::state::cancel_pending_admin_internal(arg0);
    }

    public fun propose(arg0: &mut 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::state::Config, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::state::assert_admin(arg0, 0x2::tx_context::sender(arg2));
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::state::assert_nonzero_address(arg1);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::state::propose_admin_internal(arg0, arg1);
        0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::events::emit_admin_transfer_proposed(0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::state::admin(arg0), arg1);
    }

    // decompiled from Move bytecode v7
}

