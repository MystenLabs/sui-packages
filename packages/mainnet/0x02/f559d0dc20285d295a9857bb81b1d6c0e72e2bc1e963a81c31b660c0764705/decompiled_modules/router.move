module 0x2f559d0dc20285d295a9857bb81b1d6c0e72e2bc1e963a81c31b660c0764705::router {
    struct TurbosRouterWrapper has store, key {
        id: 0x2::object::UID,
    }

    public fun authorize(arg0: &0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::admin::AdminCap, arg1: &mut TurbosRouterWrapper) {
        0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::admin::authorize(arg0, &mut arg1.id);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TurbosRouterWrapper{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<TurbosRouterWrapper>(v0);
    }

    public fun revoke_auth(arg0: &0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::admin::AdminCap, arg1: &mut TurbosRouterWrapper) {
        0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::admin::revoke_auth(arg0, &mut arg1.id);
    }

    public fun swap_a_b<T0, T1, T2, T3>(arg0: &mut TurbosRouterWrapper, arg1: &mut 0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::swap_cap::RouterSwapCap<T0>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T2, T3>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x5bd8f5f248b7a97b78fcc21aa5338a07130aeb05fc58af7b739e86f3d09bec18::vault::ProtocolFeeVault, arg9: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg10: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg11: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg12: &mut 0x2::tx_context::TxContext) {
        0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::swap_cap::assert_valid_swap<T0, T1>(arg1, &arg3);
        0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::swap_cap::pay_protocol_and_router_fee<T0, T1, T2>(&arg0.id, arg1, &mut arg3, arg8, arg9, arg10, arg11, arg12);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v0, arg3);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b<T1, T2, T3>(arg2, v0, 0x2::coin::value<T1>(&arg3), arg4, arg5, true, 0x2::tx_context::sender(arg12), 18446744073709551615, arg6, arg7, arg12);
    }

    public fun swap_b_a<T0, T1, T2, T3>(arg0: &mut TurbosRouterWrapper, arg1: &mut 0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::swap_cap::RouterSwapCap<T0>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T1, T2, T3>, arg3: 0x2::coin::Coin<T2>, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &0x5bd8f5f248b7a97b78fcc21aa5338a07130aeb05fc58af7b739e86f3d09bec18::vault::ProtocolFeeVault, arg9: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg10: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg11: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg12: &mut 0x2::tx_context::TxContext) {
        0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::swap_cap::assert_valid_swap<T0, T2>(arg1, &arg3);
        0xcdb83d0bf2fae50890a1ab873bd0a74bc21712b2b3b3ee132ec06cb18cd9823a::swap_cap::pay_protocol_and_router_fee<T0, T2, T1>(&arg0.id, arg1, &mut arg3, arg8, arg9, arg10, arg11, arg12);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T2>>();
        0x1::vector::push_back<0x2::coin::Coin<T2>>(&mut v0, arg3);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a<T1, T2, T3>(arg2, v0, 0x2::coin::value<T2>(&arg3), arg4, arg5, true, 0x2::tx_context::sender(arg12), 18446744073709551615, arg6, arg7, arg12);
    }

    // decompiled from Move bytecode v6
}

