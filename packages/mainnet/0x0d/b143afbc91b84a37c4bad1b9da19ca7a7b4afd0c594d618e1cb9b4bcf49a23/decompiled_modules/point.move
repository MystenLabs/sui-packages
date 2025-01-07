module 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::point {
    struct PointCenter<phantom T0> has store, key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<T0>,
        buffer: 0x2::balance::Balance<T0>,
        user_profiles: 0x2::linked_table::LinkedTable<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>>,
        pool_states: 0x2::vec_map::VecMap<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::PoolState>,
        claimable: bool,
        stake_policy: vector<0x1::type_name::TypeName>,
        unstake_policy: vector<0x1::type_name::TypeName>,
    }

    struct POINT has drop {
        dummy_field: bool,
    }

    struct AccountPoints has copy, drop {
        account: address,
        points: u64,
    }

    struct AccountInfo has copy, drop {
        points: u64,
        pool_ids: vector<0x2::object::ID>,
        stake_vec: vector<u64>,
        cumulative_vec: vector<u64>,
    }

    public fun burn<T0>(arg0: &mut PointCenter<T0>, arg1: 0x2::coin::Coin<T0>) : u64 {
        let v0 = 0x2::coin::value<T0>(&arg1);
        0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::event::emit_burn<T0>(v0, 0x2::coin::burn<T0>(&mut arg0.cap, arg1), 0x1::option::none<0x1::type_name::TypeName>());
        v0
    }

    public fun new<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) : (PointCenter<T0>, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>) {
        let v0 = PointCenter<T0>{
            id             : 0x2::object::new(arg2),
            cap            : arg0,
            buffer         : 0x2::balance::zero<T0>(),
            user_profiles  : 0x2::linked_table::new<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>>(arg2),
            pool_states    : 0x2::vec_map::empty<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::PoolState>(),
            claimable      : arg1,
            stake_policy   : 0x1::vector::empty<0x1::type_name::TypeName>(),
            unstake_policy : 0x1::vector::empty<0x1::type_name::TypeName>(),
        };
        let v1 = 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::new<T0>(arg2);
        0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::event::emit_new_center<T0>(0x2::object::id<PointCenter<T0>>(&v0), 0x2::object::id<0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>>(&v1));
        (v0, v1)
    }

    public fun add_rule<T0, T1>(arg0: &mut PointCenter<T0>, arg1: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>, arg2: bool) {
        let v0 = 0x1::type_name::get<T1>();
        if (arg2) {
            if (!0x1::vector::contains<0x1::type_name::TypeName>(stake_policy<T0>(arg0), &v0)) {
                0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.stake_policy, v0);
            };
        } else if (!0x1::vector::contains<0x1::type_name::TypeName>(unstake_policy<T0>(arg0), &v0)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.unstake_policy, v0);
        };
    }

    public fun borrow_treasury_cap<T0>(arg0: &PointCenter<T0>, arg1: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>) : &0x2::coin::TreasuryCap<T0> {
        &arg0.cap
    }

    public fun burn_with_witness<T0, T1: drop>(arg0: &mut PointCenter<T0>, arg1: 0x2::coin::Coin<T0>, arg2: T1) : u64 {
        let v0 = 0x2::coin::value<T0>(&arg1);
        0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::event::emit_burn<T0>(v0, 0x2::coin::burn<T0>(&mut arg0.cap, arg1), 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T1>()));
        v0
    }

    public fun claim<T0>(arg0: &mut PointCenter<T0>, arg1: &0x2::clock::Clock, arg2: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::AccountRequest, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (!claimable<T0>(arg0)) {
            err_points_not_claimable();
        };
        let v0 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::account::destroy(arg2);
        let v1 = settle_user_points<T0>(arg0, arg1, v0);
        if (v1 < arg3) {
            err_points_not_enough();
        };
        0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::event::emit_claim<T0>(v0, arg3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::points_mut<T0>(0x2::linked_table::borrow_mut<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>>(&mut arg0.user_profiles, v0)), arg3), arg4)
    }

    public fun claimable<T0>(arg0: &PointCenter<T0>) : bool {
        arg0.claimable
    }

    public fun create_pool<T0, T1>(arg0: &mut PointCenter<T0>, arg1: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = new_pool<T0, T1>(arg0, arg1, arg2, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::from_fraction(arg3, arg4), arg5, arg6);
        0x2::transfer::public_share_object<0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::DegenPool<T0, T1>>(v0);
        0x2::object::id<0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::DegenPool<T0, T1>>(&v0)
    }

    entry fun default<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new<T0>(arg0, arg1, arg2);
        0x2::transfer::share_object<PointCenter<T0>>(v0);
        0x2::transfer::public_transfer<0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun end_all_pools<T0>(arg0: &mut PointCenter<T0>, arg1: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::vec_map::keys<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::PoolState>(pool_states<T0>(arg0));
        0x1::vector::reverse<0x2::object::ID>(&mut v0);
        while (0x1::vector::length<0x2::object::ID>(&v0) != 0) {
            let v1 = 0x1::vector::pop_back<0x2::object::ID>(&mut v0);
            end_pool<T0>(arg0, arg1, arg2, &v1);
        };
        0x1::vector::destroy_empty<0x2::object::ID>(v0);
    }

    public fun end_pool<T0>(arg0: &mut PointCenter<T0>, arg1: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::object::ID) {
        set_flow_rate<T0>(arg0, arg1, arg2, arg3, 0, 1);
    }

    fun err_account_not_found() {
        abort 4
    }

    fun err_invalid_start_time() {
        abort 0
    }

    fun err_points_not_claimable() {
        abort 2
    }

    fun err_points_not_enough() {
        abort 3
    }

    fun err_pool_not_exists() {
        abort 1
    }

    fun err_stake_policy_not_fulfilled() {
        abort 5
    }

    fun err_unstake_policy_not_fulfilled() {
        abort 6
    }

    public fun fulfill_stake<T0>(arg0: &mut PointCenter<T0>, arg1: &0x2::clock::Clock, arg2: 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::StakeResponse<T0>) {
        let v0 = stake_policy<T0>(arg0);
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(v0)) {
            if (!0x2::vec_set::contains<0x1::type_name::TypeName>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::stake_res_witness<T0>(&arg2), 0x1::vector::borrow<0x1::type_name::TypeName>(v0, v1))) {
                v2 = false;
                /* label 6 */
                if (!v2) {
                    err_stake_policy_not_fulfilled();
                };
                let (v3, v4, v5, v6) = 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::destroy_stake_res<T0>(arg2);
                let v7 = v3;
                settle_user_points<T0>(arg0, arg1, v4);
                0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::stake(0x2::vec_map::get_mut<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::PoolState>(&mut arg0.pool_states, &v7), v5);
                if (!0x2::linked_table::contains<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>>(user_profiles<T0>(arg0), v4)) {
                    0x2::linked_table::push_back<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>>(&mut arg0.user_profiles, v4, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::new<T0>());
                };
                let v8 = 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::stakes_mut<T0>(0x2::linked_table::borrow_mut<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>>(&mut arg0.user_profiles, v4));
                let v9 = if (0x2::vec_map::contains<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::stake::Stake>(v8, &v7)) {
                    0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::stake::add(0x2::vec_map::get_mut<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::stake::Stake>(v8, &v7), v5)
                } else {
                    0x2::vec_map::insert<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::stake::Stake>(v8, v7, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::stake::new(v5, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::unit(0x2::vec_map::get<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::PoolState>(pool_states<T0>(arg0), &v7))));
                    v5
                };
                0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::event::emit_stake<T0>(v7, v6, v4, v5, v9);
                return
            };
            v1 = v1 + 1;
        };
        v2 = true;
        /* goto 6 */
    }

    public fun fulfill_unstake<T0>(arg0: &mut PointCenter<T0>, arg1: &0x2::clock::Clock, arg2: 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::UnstakeResponse<T0>) {
        let v0 = unstake_policy<T0>(arg0);
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(v0)) {
            if (!0x2::vec_set::contains<0x1::type_name::TypeName>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::unstake_res_witness<T0>(&arg2), 0x1::vector::borrow<0x1::type_name::TypeName>(v0, v1))) {
                v2 = false;
                /* label 6 */
                if (!v2) {
                    err_unstake_policy_not_fulfilled();
                };
                let (v3, v4, v5, v6) = 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::destroy_unstake_res<T0>(arg2);
                let v7 = v3;
                let v8 = user_profiles<T0>(arg0);
                if (!0x2::linked_table::contains<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>>(v8, v4) || !0x2::vec_map::contains<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::stake::Stake>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::stakes<T0>(0x2::linked_table::borrow<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>>(v8, v4)), &v7)) {
                    err_account_not_found();
                };
                settle_user_points<T0>(arg0, arg1, v4);
                0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::unstake(0x2::vec_map::get_mut<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::PoolState>(&mut arg0.pool_states, &v7), v5);
                0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::event::emit_unstake<T0>(v7, v6, v4, v5, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::stake::sub(0x2::vec_map::get_mut<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::stake::Stake>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::stakes_mut<T0>(0x2::linked_table::borrow_mut<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>>(&mut arg0.user_profiles, v4)), &v7), v5));
                return
            };
            v1 = v1 + 1;
        };
        v2 = true;
        /* goto 6 */
    }

    public fun get_account_info<T0>(arg0: &PointCenter<T0>, arg1: &0x2::clock::Clock, arg2: address) : 0x1::option::Option<AccountInfo> {
        if (0x2::linked_table::contains<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>>(user_profiles<T0>(arg0), arg2)) {
            let v1 = 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::stakes<T0>(0x2::linked_table::borrow<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>>(user_profiles<T0>(arg0), arg2));
            let v2 = 0x2::vec_map::keys<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::stake::Stake>(v1);
            let v3 = &v2;
            let v4 = vector[];
            let v5 = 0;
            while (v5 < 0x1::vector::length<0x2::object::ID>(v3)) {
                0x1::vector::push_back<u64>(&mut v4, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::stake::amount(0x2::vec_map::get<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::stake::Stake>(v1, 0x1::vector::borrow<0x2::object::ID>(v3, v5))));
                v5 = v5 + 1;
            };
            let v6 = &v2;
            let v7 = vector[];
            let v8 = 0;
            while (v8 < 0x1::vector::length<0x2::object::ID>(v6)) {
                0x1::vector::push_back<u64>(&mut v7, realtime_cumulative_points_by_pool_id<T0>(arg0, arg2, 0x1::vector::borrow<0x2::object::ID>(v6, v8), arg1));
                v8 = v8 + 1;
            };
            let v9 = AccountInfo{
                points         : realtime_points<T0>(arg0, arg2, arg1),
                pool_ids       : v2,
                stake_vec      : v4,
                cumulative_vec : v7,
            };
            0x1::option::some<AccountInfo>(v9)
        } else {
            0x1::option::none<AccountInfo>()
        }
    }

    fun init(arg0: POINT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<POINT>(arg0, arg1);
    }

    public fun multi_get_account_points<T0>(arg0: &PointCenter<T0>, arg1: &0x2::clock::Clock, arg2: 0x1::option::Option<address>, arg3: u64, arg4: u64) : (vector<AccountPoints>, 0x1::option::Option<address>) {
        if (0x1::option::is_none<address>(&arg2)) {
            arg2 = *0x2::linked_table::front<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>>(&arg0.user_profiles);
        };
        if (0x1::option::is_none<address>(&arg2)) {
            return (0x1::vector::empty<AccountPoints>(), 0x1::option::none<address>())
        };
        let v0 = 0;
        if (!0x2::linked_table::contains<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>>(user_profiles<T0>(arg0), *0x1::option::borrow<address>(&arg2))) {
            err_account_not_found();
        };
        let v1 = 0x1::vector::empty<AccountPoints>();
        while (0x1::option::is_some<address>(&arg2) && v0 < arg4) {
            let v2 = 0x1::option::extract<address>(&mut arg2);
            arg2 = *0x2::linked_table::next<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>>(user_profiles<T0>(arg0), v2);
            if (v0 % arg3 == 0) {
                let v3 = AccountPoints{
                    account : v2,
                    points  : realtime_points<T0>(arg0, v2, arg1),
                };
                0x1::vector::push_back<AccountPoints>(&mut v1, v3);
            };
            v0 = v0 + 1;
        };
        (v1, arg2)
    }

    public fun new_pool<T0, T1>(arg0: &mut PointCenter<T0>, arg1: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>, arg2: &0x2::clock::Clock, arg3: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::DegenPool<T0, T1> {
        if (arg4 < 0x2::clock::timestamp_ms(arg2)) {
            err_invalid_start_time();
        };
        let v0 = 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::new<T0, T1>(arg5);
        0x2::vec_map::insert<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::PoolState>(&mut arg0.pool_states, 0x2::object::id<0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::DegenPool<T0, T1>>(&v0), 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::new<T1>(arg3, arg4, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::from(0)));
        0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::event::emit_new_pool<T0, T1>(0x2::object::id<0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::DegenPool<T0, T1>>(&v0));
        v0
    }

    public fun pool_states<T0>(arg0: &PointCenter<T0>) : &0x2::vec_map::VecMap<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::PoolState> {
        &arg0.pool_states
    }

    public fun realtime_cumulative_points_by_pool_id<T0>(arg0: &PointCenter<T0>, arg1: address, arg2: &0x2::object::ID, arg3: &0x2::clock::Clock) : u64 {
        if (0x2::linked_table::contains<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>>(user_profiles<T0>(arg0), arg1)) {
            let v1 = 0x2::vec_map::try_get<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::stake::Stake>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::stakes<T0>(0x2::linked_table::borrow<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>>(user_profiles<T0>(arg0), arg1)), arg2);
            let v2 = &v1;
            let v3 = if (0x1::option::is_some<0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::stake::Stake>(v2)) {
                0x1::option::some<u64>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::stake::cumulant(0x1::option::borrow<0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::stake::Stake>(v2)))
            } else {
                0x1::option::none<u64>()
            };
            let v4 = v3;
            unsettled_points_by_pool_id<T0>(arg0, arg1, arg2, arg3) + 0x1::option::get_with_default<u64>(&v4, 0)
        } else {
            0
        }
    }

    public fun realtime_points<T0>(arg0: &PointCenter<T0>, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        settled_points<T0>(arg0, arg1) + unsettled_points<T0>(arg0, arg1, arg2)
    }

    public fun realtime_supply<T0>(arg0: &PointCenter<T0>, arg1: &0x2::clock::Clock) : u64 {
        supply<T0>(arg0) + unsettled_supply<T0>(arg0, arg1)
    }

    public fun remove_rule<T0, T1>(arg0: &mut PointCenter<T0>, arg1: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>, arg2: bool) {
        let v0 = 0x1::type_name::get<T1>();
        if (arg2) {
            let v1 = stake_policy<T0>(arg0);
            let v2 = 0;
            let v3;
            while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
                if (0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2) == &v0) {
                    v3 = 0x1::option::some<u64>(v2);
                    /* label 7 */
                    if (0x1::option::is_some<u64>(&v3)) {
                        0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg0.stake_policy, 0x1::option::destroy_some<u64>(v3));
                    };
                    return
                };
                v2 = v2 + 1;
            };
            v3 = 0x1::option::none<u64>();
            /* goto 7 */
        } else {
            let v4 = unstake_policy<T0>(arg0);
            let v5 = 0;
            let v6;
            while (v5 < 0x1::vector::length<0x1::type_name::TypeName>(v4)) {
                if (0x1::vector::borrow<0x1::type_name::TypeName>(v4, v5) == &v0) {
                    v6 = 0x1::option::some<u64>(v5);
                    /* label 19 */
                    let v7 = v6;
                    if (0x1::option::is_some<u64>(&v7)) {
                        0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg0.unstake_policy, 0x1::option::destroy_some<u64>(v7));
                        return
                    } else {
                        return
                    };
                } else {
                    v5 = v5 + 1;
                };
            };
            v6 = 0x1::option::none<u64>();
            /* goto 19 */
        };
    }

    public fun set_flow_rate<T0>(arg0: &mut PointCenter<T0>, arg1: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::object::ID, arg4: u64, arg5: u64) {
        update_pool_state<T0>(arg0, arg2, arg3);
        0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::set_flow_rate(0x2::vec_map::get_mut<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::PoolState>(&mut arg0.pool_states, arg3), 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::from_fraction(arg4, arg5));
    }

    fun settle_user_points<T0>(arg0: &mut PointCenter<T0>, arg1: &0x2::clock::Clock, arg2: address) : u64 {
        update_all_pool_states<T0>(arg0, arg1);
        if (0x2::linked_table::contains<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>>(user_profiles<T0>(arg0), arg2)) {
            let v1 = 0x2::vec_map::keys<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::stake::Stake>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::stakes<T0>(0x2::linked_table::borrow<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>>(user_profiles<T0>(arg0), arg2)));
            let v2 = &v1;
            let v3 = vector[];
            let v4 = 0;
            while (v4 < 0x1::vector::length<0x2::object::ID>(v2)) {
                let v5 = 0x1::vector::borrow<0x2::object::ID>(v2, v4);
                let v6 = 0x2::vec_map::get<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::PoolState>(pool_states<T0>(arg0), v5);
                let v7 = 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::unit(v6);
                let v8 = 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::asset_type(v6);
                let v9 = unsettled_points_by_pool_id<T0>(arg0, arg2, v5, arg1);
                let v10 = 0x2::vec_map::get_mut<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::stake::Stake>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::stakes_mut<T0>(0x2::linked_table::borrow_mut<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>>(&mut arg0.user_profiles, arg2)), v5);
                0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::stake::set_unit(v10, v7);
                0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::event::emit_cumulate<T0>(v5, v8, arg2, v9, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::stake::cumulate(v10, v9));
                0x1::vector::push_back<u64>(&mut v3, v9);
                v4 = v4 + 1;
            };
            let v11 = 0;
            0x1::vector::reverse<u64>(&mut v3);
            while (0x1::vector::length<u64>(&v3) != 0) {
                v11 = v11 + 0x1::vector::pop_back<u64>(&mut v3);
            };
            0x1::vector::destroy_empty<u64>(v3);
            0x2::balance::join<T0>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::points_mut<T0>(0x2::linked_table::borrow_mut<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>>(&mut arg0.user_profiles, arg2)), 0x2::balance::split<T0>(&mut arg0.buffer, v11))
        } else {
            0
        }
    }

    public fun settled_points<T0>(arg0: &PointCenter<T0>, arg1: address) : u64 {
        if (0x2::linked_table::contains<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>>(user_profiles<T0>(arg0), arg1)) {
            0x2::balance::value<T0>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::points<T0>(0x2::linked_table::borrow<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>>(user_profiles<T0>(arg0), arg1)))
        } else {
            0
        }
    }

    public fun stake_policy<T0>(arg0: &PointCenter<T0>) : &vector<0x1::type_name::TypeName> {
        &arg0.stake_policy
    }

    public fun supply<T0>(arg0: &PointCenter<T0>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.cap)
    }

    public fun toggle_claimable<T0>(arg0: &mut PointCenter<T0>, arg1: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<T0>) {
        arg0.claimable = !claimable<T0>(arg0);
    }

    public fun unsettled_points<T0>(arg0: &PointCenter<T0>, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        if (0x2::linked_table::contains<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>>(user_profiles<T0>(arg0), arg1)) {
            let v1 = 0x2::vec_map::keys<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::stake::Stake>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::stakes<T0>(0x2::linked_table::borrow<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>>(user_profiles<T0>(arg0), arg1)));
            let v2 = &v1;
            let v3 = vector[];
            let v4 = 0;
            while (v4 < 0x1::vector::length<0x2::object::ID>(v2)) {
                0x1::vector::push_back<u64>(&mut v3, unsettled_points_by_pool_id<T0>(arg0, arg1, 0x1::vector::borrow<0x2::object::ID>(v2, v4), arg2));
                v4 = v4 + 1;
            };
            let v5 = 0;
            0x1::vector::reverse<u64>(&mut v3);
            while (0x1::vector::length<u64>(&v3) != 0) {
                v5 = v5 + 0x1::vector::pop_back<u64>(&mut v3);
            };
            0x1::vector::destroy_empty<u64>(v3);
            v5
        } else {
            0
        }
    }

    public fun unsettled_points_by_pool_id<T0>(arg0: &PointCenter<T0>, arg1: address, arg2: &0x2::object::ID, arg3: &0x2::clock::Clock) : u64 {
        if (!0x2::vec_map::contains<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::PoolState>(pool_states<T0>(arg0), arg2)) {
            err_pool_not_exists();
        };
        if (0x2::linked_table::contains<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>>(user_profiles<T0>(arg0), arg1) && 0x2::vec_map::contains<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::stake::Stake>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::stakes<T0>(0x2::linked_table::borrow<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>>(user_profiles<T0>(arg0), arg1)), arg2)) {
            let v1 = 0x2::vec_map::get<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::PoolState>(pool_states<T0>(arg0), arg2);
            let v2 = 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::total_stake(v1);
            if (v2 > 0) {
                let v3 = 0x2::vec_map::get<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::stake::Stake>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::stakes<T0>(0x2::linked_table::borrow<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>>(user_profiles<T0>(arg0), arg1)), arg2);
                0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::ceil(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::mul_u64(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::sub(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::add(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::unit(v1), 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::from_fraction(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::get_release_amount(v1, 0x2::clock::timestamp_ms(arg3)), v2)), 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::stake::unit(v3)), 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::stake::amount(v3)))
            } else {
                0
            }
        } else {
            0
        }
    }

    public fun unsettled_supply<T0>(arg0: &PointCenter<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::vec_map::keys<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::PoolState>(pool_states<T0>(arg0));
        let v1 = &v0;
        let v2 = vector[];
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x2::object::ID>(v1)) {
            let v4 = 0x1::vector::borrow<0x2::object::ID>(v1, v3);
            let v5 = if (0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::total_stake(0x2::vec_map::get<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::PoolState>(pool_states<T0>(arg0), v4)) > 0) {
                0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::get_release_amount(0x2::vec_map::get<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::PoolState>(pool_states<T0>(arg0), v4), 0x2::clock::timestamp_ms(arg1))
            } else {
                0
            };
            0x1::vector::push_back<u64>(&mut v2, v5);
            v3 = v3 + 1;
        };
        let v6 = 0;
        0x1::vector::reverse<u64>(&mut v2);
        while (0x1::vector::length<u64>(&v2) != 0) {
            v6 = v6 + 0x1::vector::pop_back<u64>(&mut v2);
        };
        0x1::vector::destroy_empty<u64>(v2);
        v6
    }

    public fun unstake_policy<T0>(arg0: &PointCenter<T0>) : &vector<0x1::type_name::TypeName> {
        &arg0.unstake_policy
    }

    fun update_all_pool_states<T0>(arg0: &mut PointCenter<T0>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::vec_map::keys<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::PoolState>(pool_states<T0>(arg0));
        let v1 = &v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(v1)) {
            update_pool_state<T0>(arg0, arg1, 0x1::vector::borrow<0x2::object::ID>(v1, v2));
            v2 = v2 + 1;
        };
    }

    fun update_pool_state<T0>(arg0: &mut PointCenter<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::object::ID) {
        if (!0x2::vec_map::contains<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::PoolState>(&arg0.pool_states, arg2)) {
            err_pool_not_exists();
        };
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::PoolState>(&mut arg0.pool_states, arg2);
        let v1 = 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::total_stake(v0);
        let v2 = 0x2::clock::timestamp_ms(arg1);
        if (v2 > 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::timestamp(v0)) {
            if (v1 > 0) {
                let v3 = 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::get_release_amount(v0, v2);
                if (v3 > 0) {
                    0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::add_unit(v0, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::from_fraction(v3, v1));
                    0x2::balance::join<T0>(&mut arg0.buffer, 0x2::balance::increase_supply<T0>(0x2::coin::supply_mut<T0>(&mut arg0.cap), v3));
                    0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::event::emit_mint<T0>(arg2, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::asset_type(v0), v3, 0x2::coin::total_supply<T0>(&arg0.cap));
                };
            };
            0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::state::set_timestamp(v0, v2);
        };
    }

    public fun user_profiles<T0>(arg0: &PointCenter<T0>) : &0x2::linked_table::LinkedTable<address, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::profile::Profile<T0>> {
        &arg0.user_profiles
    }

    // decompiled from Move bytecode v6
}

