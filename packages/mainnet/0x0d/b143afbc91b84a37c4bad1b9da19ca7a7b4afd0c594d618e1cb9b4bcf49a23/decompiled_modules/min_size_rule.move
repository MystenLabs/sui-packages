module 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::min_size_rule {
    struct MinSizeRule has drop {
        dummy_field: bool,
    }

    struct Config<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool_min_sizes: 0x2::vec_map::VecMap<0x2::object::ID, u64>,
    }

    public fun check_stake_response<T0>(arg0: &Config<T0>, arg1: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::PointCenter<T0>, arg2: &mut 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::StakeResponse<T0>) {
        let (v0, v1, v2, _) = 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::stake_res_data<T0>(arg2);
        let v4 = v0;
        if (current_size<T0>(arg1, v1, &v4) + v2 < min_size_of<T0>(arg0, &v4)) {
            err_lower_than_min_size_after_stake();
        };
        let v5 = MinSizeRule{dummy_field: false};
        0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::stake_res_add_witness<T0, MinSizeRule>(arg2, v5);
    }

    public fun check_unstake_response<T0>(arg0: &Config<T0>, arg1: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::PointCenter<T0>, arg2: &mut 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::UnstakeResponse<T0>) {
        let (v0, v1, v2, _) = 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::unstake_res_data<T0>(arg2);
        let v4 = v0;
        let v5 = current_size<T0>(arg1, v1, &v4);
        if (v5 >= v2) {
            let v6 = v5 - v2;
            if (v6 != 0 && v6 < min_size_of<T0>(arg0, &v4)) {
                err_lower_than_min_size_after_unstake();
            };
            let v7 = MinSizeRule{dummy_field: false};
            0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::unstake_res_add_witness<T0, MinSizeRule>(arg2, v7);
        };
    }

    public fun create_config<T0>(arg0: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Config<T0>>(new_config<T0>(arg0, arg1));
    }

    public fun current_size<T0>(arg0: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::PointCenter<T0>, arg1: address, arg2: &0x2::object::ID) : u64 {
        if (0x2::linked_table::contains<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::user_profiles<T0>(arg0), arg1) && 0x2::vec_map::contains<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::stake::Stake>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::stakes<T0>(0x2::linked_table::borrow<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::user_profiles<T0>(arg0), arg1)), arg2)) {
            0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::stake::amount(0x2::vec_map::get<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::stake::Stake>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::stakes<T0>(0x2::linked_table::borrow<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::user_profiles<T0>(arg0), arg1)), arg2))
        } else {
            0
        }
    }

    fun err_lower_than_min_size_after_stake() {
        abort 0
    }

    fun err_lower_than_min_size_after_unstake() {
        abort 0
    }

    public fun min_size_of<T0>(arg0: &Config<T0>, arg1: &0x2::object::ID) : u64 {
        if (0x2::vec_map::contains<0x2::object::ID, u64>(pool_min_sizes<T0>(arg0), arg1)) {
            *0x2::vec_map::get<0x2::object::ID, u64>(pool_min_sizes<T0>(arg0), arg1)
        } else {
            0
        }
    }

    public fun new_config<T0>(arg0: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>, arg1: &mut 0x2::tx_context::TxContext) : Config<T0> {
        Config<T0>{
            id             : 0x2::object::new(arg1),
            pool_min_sizes : 0x2::vec_map::empty<0x2::object::ID, u64>(),
        }
    }

    public fun pool_min_sizes<T0>(arg0: &Config<T0>) : &0x2::vec_map::VecMap<0x2::object::ID, u64> {
        &arg0.pool_min_sizes
    }

    public fun set_min_size<T0>(arg0: &mut Config<T0>, arg1: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>, arg2: 0x2::object::ID, arg3: u64) {
        if (0x2::vec_map::contains<0x2::object::ID, u64>(pool_min_sizes<T0>(arg0), &arg2)) {
            *0x2::vec_map::get_mut<0x2::object::ID, u64>(&mut arg0.pool_min_sizes, &arg2) = arg3;
        } else {
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut arg0.pool_min_sizes, arg2, arg3);
        };
    }

    // decompiled from Move bytecode v6
}

