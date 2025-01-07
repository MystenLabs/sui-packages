module 0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::fetcher {
    struct LpTokenValueEvent has copy, drop {
        lp_amount: u64,
        amount_a: u64,
        amount_b: u64,
        clmm_pool: 0x2::object::ID,
        vault_id: 0x2::object::ID,
    }

    public entry fun get_position_amounts<T0, T1, T2>(arg0: &0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::Vault<T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64) {
        let (v0, v1) = 0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::get_position_amounts<T0, T1, T2>(arg0, arg1, arg2);
        let v2 = LpTokenValueEvent{
            lp_amount : arg2,
            amount_a  : v0,
            amount_b  : v1,
            clmm_pool : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            vault_id  : 0x2::object::id<0x2e3923dd25823c84cd29ad9b7a62d718dd3451826e8fe87aac360f24dfa51d0a::vaults::Vault<T2>>(arg0),
        };
        0x2::event::emit<LpTokenValueEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

