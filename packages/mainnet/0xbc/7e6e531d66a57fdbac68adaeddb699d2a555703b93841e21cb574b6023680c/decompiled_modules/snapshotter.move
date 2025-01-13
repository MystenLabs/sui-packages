module 0xbc7e6e531d66a57fdbac68adaeddb699d2a555703b93841e21cb574b6023680c::snapshotter {
    struct BUT_TGE has drop {
        dummy_field: bool,
    }

    struct Simulation<phantom T0, phantom T1> has copy, drop {
        account: address,
        allocation: u64,
    }

    struct AirdropAllocation<phantom T0, phantom T1> has copy, drop {
        account: address,
        allocation: u64,
    }

    struct Snapshotter<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        total_points: u64,
        total_allocation: u64,
        cumulative_allocation: u64,
        threshold: u64,
        cursor: 0x1::option::Option<address>,
        total_user: u64,
        allocated_user: u64,
    }

    public fun new<T0, T1>(arg0: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::PointCenter<T0>, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Snapshotter<T0, T1> {
        let v0 = 0x2::linked_table::front<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::user_profiles<T0>(arg0));
        if (0x1::option::is_none<address>(v0)) {
            err_no_user_in_the_center();
        };
        Snapshotter<T0, T1>{
            id                    : 0x2::object::new(arg4),
            total_points          : 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::realtime_supply<T0>(arg0, arg1),
            total_allocation      : arg2,
            cumulative_allocation : 0,
            threshold             : arg3,
            cursor                : *v0,
            total_user            : 0,
            allocated_user        : 0,
        }
    }

    public fun create<T0, T1>(arg0: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::PointCenter<T0>, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = new<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::transfer<Snapshotter<T0, T1>>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun destroy<T0, T1>(arg0: Snapshotter<T0, T1>) {
        let Snapshotter {
            id                    : v0,
            total_points          : _,
            total_allocation      : _,
            cumulative_allocation : _,
            threshold             : _,
            cursor                : v5,
            total_user            : _,
            allocated_user        : _,
        } = arg0;
        let v8 = v5;
        assert!(0x1::option::is_none<address>(&v8), 9223372440581701631);
        0x2::object::delete(v0);
    }

    fun err_no_user_in_the_center() {
        abort 0
    }

    public fun settle_all_pools<T0>(arg0: &mut 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::PointCenter<T0>, arg1: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>, arg2: &0x2::clock::Clock, arg3: u64) {
        let v0 = 0x2::vec_map::keys<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::PoolState>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::pool_states<T0>(arg0));
        let v1 = &v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(v1)) {
            let v3 = 0x1::vector::borrow<0x2::object::ID>(v1, v2);
            0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::set_flow_rate<T0>(arg0, arg1, arg2, v3, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::floor(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::mul_u64(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::flow_rate(0x2::vec_map::get<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::PoolState>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::pool_states<T0>(arg0), v3)), 86400000)), 86400000);
            v2 = v2 + 1;
        };
        0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::postpone<T0>(arg0, arg1, arg3);
    }

    public fun simulate<T0, T1>(arg0: &mut Snapshotter<T0, T1>, arg1: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::PointCenter<T0>, arg2: &0x2::clock::Clock, arg3: u64) {
        let v0 = 0;
        while (v0 < arg3 && 0x1::option::is_some<address>(&arg0.cursor)) {
            let v1 = *0x1::option::borrow<address>(&arg0.cursor);
            let v2 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::floor(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::mul_u64(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::from_fraction(arg0.total_allocation, arg0.total_points), 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::realtime_points<T0>(arg1, v1, arg2))) / arg0.threshold;
            if (v2 > 0) {
                let v3 = v2 * arg0.threshold;
                let v4 = Simulation<T0, T1>{
                    account    : v1,
                    allocation : v3,
                };
                0x2::event::emit<Simulation<T0, T1>>(v4);
                arg0.allocated_user = arg0.allocated_user + 1;
                arg0.cumulative_allocation = arg0.cumulative_allocation + v3;
            };
            arg0.cursor = *0x2::linked_table::next<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::user_profiles<T0>(arg1), v1);
            arg0.total_user = arg0.total_user + 1;
            v0 = v0 + 1;
        };
    }

    public fun snapshot<T0, T1>(arg0: &mut Snapshotter<T0, T1>, arg1: &mut 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::PointCenter<T0>, arg2: &0x2::clock::Clock, arg3: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::privilege::Privilege<T0, BUT_TGE>, arg4: &mut 0x7043eeab02e5ce9e9272e6fdd0006759721f995e2026850683c3674bb519e13f::airdrop::AirdropPool<T1, T0>, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg5 && 0x1::option::is_some<address>(&arg0.cursor)) {
            let v1 = *0x1::option::borrow<address>(&arg0.cursor);
            let v2 = 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::realtime_points<T0>(arg1, v1, arg2);
            let v3 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::floor(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::mul_u64(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::from_fraction(arg0.total_allocation, arg0.total_points), v2)) / arg0.threshold;
            if (v3 > 0) {
                let v4 = v3 * arg0.threshold;
                let v5 = AirdropAllocation<T0, T1>{
                    account    : v1,
                    allocation : v4,
                };
                0x2::event::emit<AirdropAllocation<T0, T1>>(v5);
                arg0.allocated_user = arg0.allocated_user + 1;
                arg0.cumulative_allocation = arg0.cumulative_allocation + v4;
                let v6 = BUT_TGE{dummy_field: false};
                0x2::transfer::public_transfer<0x7043eeab02e5ce9e9272e6fdd0006759721f995e2026850683c3674bb519e13f::airdrop::Eligibility>(0x7043eeab02e5ce9e9272e6fdd0006759721f995e2026850683c3674bb519e13f::airdrop::allocate<T1, T0>(arg4, v4, arg7), v1);
                if (arg6) {
                    let v7 = BUT_TGE{dummy_field: false};
                    0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::burn_with_witness<T0, BUT_TGE>(arg1, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::levy<T0, BUT_TGE>(arg1, arg2, arg3, v6, v1, v2, arg7), v7);
                } else {
                    0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::burn<T0>(arg1, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::levy<T0, BUT_TGE>(arg1, arg2, arg3, v6, v1, v2, arg7));
                };
            };
            arg0.cursor = *0x2::linked_table::next<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point::user_profiles<T0>(arg1), v1);
            arg0.total_user = arg0.total_user + 1;
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

