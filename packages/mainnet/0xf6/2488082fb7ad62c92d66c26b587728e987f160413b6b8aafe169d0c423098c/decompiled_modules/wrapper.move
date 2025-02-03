module 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::wrapper {
    struct WrapperRule has drop {
        dummy_field: bool,
    }

    struct StakeRequestWrapper<phantom T0, phantom T1> {
        req: 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::StakeRequest<T0>,
    }

    struct UnstakeRequestWrapper<phantom T0, phantom T1> {
        req: 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::UnstakeRequest<T0>,
    }

    public fun fulfill_stake<T0, T1>(arg0: &mut 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::DegenPool<T0, T1>, arg1: StakeRequestWrapper<T0, T1>, arg2: 0x2::coin::Coin<T1>) : 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::StakeResponse<T0> {
        let StakeRequestWrapper { req: v0 } = arg1;
        let v1 = 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::fulfill_stake<T0, T1>(arg0, v0, arg2);
        let v2 = WrapperRule{dummy_field: false};
        0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::stake_res_add_witness<T0, WrapperRule>(&mut v1, v2);
        v1
    }

    public fun fulfill_unstake<T0, T1>(arg0: &mut 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::DegenPool<T0, T1>, arg1: UnstakeRequestWrapper<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::UnstakeResponse<T0>) {
        let UnstakeRequestWrapper { req: v0 } = arg1;
        let (v1, v2) = 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::fulfill_unstake<T0, T1>(arg0, v0, arg2);
        let v3 = v2;
        let v4 = WrapperRule{dummy_field: false};
        0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::unstake_res_add_witness<T0, WrapperRule>(&mut v3, v4);
        (v1, v3)
    }

    fun err_wrong_pool_type() {
        abort 0
    }

    public fun wrap_stake_request<T0, T1>(arg0: 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::StakeRequest<T0>) : StakeRequestWrapper<T0, T1> {
        let (_, _, _, v3) = 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::stake_req_data<T0>(&arg0);
        if (0x1::type_name::get<T1>() != v3) {
            err_wrong_pool_type();
        };
        StakeRequestWrapper<T0, T1>{req: arg0}
    }

    public fun wrap_unstake_request<T0, T1>(arg0: 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::UnstakeRequest<T0>) : UnstakeRequestWrapper<T0, T1> {
        let (_, _, _, v3) = 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::unstake_req_data<T0>(&arg0);
        if (0x1::type_name::get<T1>() != v3) {
            err_wrong_pool_type();
        };
        UnstakeRequestWrapper<T0, T1>{req: arg0}
    }

    // decompiled from Move bytecode v6
}

