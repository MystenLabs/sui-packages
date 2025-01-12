module 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool_type_check {
    struct PoolTypeCheck has drop {
        dummy_field: bool,
    }

    public fun check_stake_response<T0>(arg0: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::PointCenter<T0>, arg1: &mut 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::StakeResponse<T0>) {
        let (v0, _, _, v3) = 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::stake_res_data<T0>(arg1);
        let v4 = v0;
        if (0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::asset_type(0x2::vec_map::get<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::PoolState>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::pool_states<T0>(arg0), &v4)) != 0x1::type_name::into_string(v3)) {
            err_wrong_pool();
        };
        let v5 = PoolTypeCheck{dummy_field: false};
        0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::stake_res_add_witness<T0, PoolTypeCheck>(arg1, v5);
    }

    public fun check_unstake_response<T0>(arg0: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::PointCenter<T0>, arg1: &mut 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::UnstakeResponse<T0>) {
        let (v0, _, _, v3) = 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::unstake_res_data<T0>(arg1);
        let v4 = v0;
        if (0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::asset_type(0x2::vec_map::get<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::PoolState>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::pool_states<T0>(arg0), &v4)) != 0x1::type_name::into_string(v3)) {
            err_wrong_pool();
        };
        let v5 = PoolTypeCheck{dummy_field: false};
        0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::unstake_res_add_witness<T0, PoolTypeCheck>(arg1, v5);
    }

    fun err_wrong_pool() {
        abort 0
    }

    // decompiled from Move bytecode v6
}

