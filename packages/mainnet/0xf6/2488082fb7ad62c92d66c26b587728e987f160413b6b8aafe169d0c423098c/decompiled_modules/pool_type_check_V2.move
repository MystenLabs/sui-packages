module 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool_type_check_V2 {
    struct PoolTypeCheck has drop {
        dummy_field: bool,
    }

    public fun check_stake_response<T0, T1>(arg0: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::PointCenter<T0>, arg1: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::DegenPool<T0, T1>, arg2: &mut 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::StakeResponse<T0>) {
        let (v0, _, _, v3) = 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::stake_res_data<T0>(arg2);
        let v4 = v0;
        let v5 = if (0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::asset_type(0x2::vec_map::get<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::PoolState>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::pool_states<T0>(arg0), &v4)) != 0x1::type_name::into_string(v3)) {
            true
        } else if (0x2::object::id<0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::DegenPool<T0, T1>>(arg1) != v4) {
            true
        } else {
            0x1::type_name::get<T1>() != v3
        };
        if (v5) {
            err_wrong_pool();
        };
        let v6 = PoolTypeCheck{dummy_field: false};
        0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::stake_res_add_witness<T0, PoolTypeCheck>(arg2, v6);
    }

    public fun check_unstake_response<T0, T1>(arg0: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::PointCenter<T0>, arg1: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::DegenPool<T0, T1>, arg2: &mut 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::UnstakeResponse<T0>) {
        let (v0, _, _, v3) = 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::unstake_res_data<T0>(arg2);
        let v4 = v0;
        let v5 = if (0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::asset_type(0x2::vec_map::get<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::PoolState>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::pool_states<T0>(arg0), &v4)) != 0x1::type_name::into_string(v3)) {
            true
        } else if (0x2::object::id<0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::DegenPool<T0, T1>>(arg1) != v4) {
            true
        } else {
            0x1::type_name::get<T1>() != v3
        };
        if (v5) {
            err_wrong_pool();
        };
        let v6 = PoolTypeCheck{dummy_field: false};
        0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::unstake_res_add_witness<T0, PoolTypeCheck>(arg2, v6);
    }

    fun err_wrong_pool() {
        abort 0
    }

    // decompiled from Move bytecode v6
}

