module 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center {
    struct DE_CENTER has drop {
        dummy_field: bool,
    }

    struct AdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct PenaltyInfo has drop, store {
        elapsed_percentage: u32,
        penalty_percentage: u32,
    }

    struct DeCenter<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u64>,
        max_time: u64,
        offset: u64,
        minted_escrow: u64,
        locked_total: u64,
        penalty: vector<PenaltyInfo>,
        penalty_fee_bps: u64,
        penalty_fee_balance: 0x2::balance::Balance<T0>,
        penalty_fee_admin: 0x1::option::Option<0x1::type_name::TypeName>,
        penalty_reserve: 0x2::balance::Balance<T0>,
        whitelist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        point: 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::point::Point,
        slope_changes: 0x2::table::Table<u64, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::I128>,
        response_checklists: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct DeTokenUpdateResponse<phantom T0, phantom T1> {
        id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        action: 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::action::Action,
        checklists: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        max_time: u64,
        balance: u64,
        end: u64,
        early_unlock: bool,
        raw_voting_weight: u64,
        voting_weight: u64,
    }

    struct CreatePoolEvent has copy, drop {
        protocol: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
        id: 0x2::object::ID,
        max_time: u64,
        offset: u64,
    }

    struct LockEvent has copy, drop {
        escrow_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        locked_value: u64,
        unlock_time: u64,
        timestamp: u64,
    }

    struct IncreaseUnlockTimeEvent has copy, drop {
        escrow_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        timestamp: u64,
        extended_duration: u64,
    }

    struct IncreaseUnlockAmountEvent has copy, drop {
        escrow_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        locked_amount: u64,
        timestamp: u64,
    }

    struct MergeEvent has copy, drop {
        escrow_id: 0x2::object::ID,
        merged_escrow_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        locked_value: u64,
        new_unlock_time: u64,
        merged_value: u64,
        merged_unlock_time: u64,
        timestamp: u64,
    }

    struct UnlockEvent has copy, drop {
        escrow_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        unlocked_value: u64,
        locked_end: u64,
        timestamp: u64,
    }

    struct WithdrawEvent has copy, drop {
        escrow_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        withdrawl: u64,
        locked_end: u64,
        timestamp: u64,
        whitelist: 0x1::option::Option<0x1::type_name::TypeName>,
    }

    struct PenaltyEvent has copy, drop {
        escrow_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        penalty_amount: u64,
        penalty_fee: u64,
        penalty_reserve: u64,
    }

    public fun new<T0, T1>(arg0: &AdminCap<T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : DeCenter<T0, T1> {
        let v0 = DeCenter<T0, T1>{
            id                  : 0x2::object::new(arg4),
            versions            : 0x2::vec_set::singleton<u64>(2),
            max_time            : round_down_week(arg1),
            offset              : arg2,
            minted_escrow       : 0,
            locked_total        : 0,
            penalty             : 0x1::vector::empty<PenaltyInfo>(),
            penalty_fee_bps     : 500000,
            penalty_fee_balance : 0x2::balance::zero<T0>(),
            penalty_fee_admin   : 0x1::option::none<0x1::type_name::TypeName>(),
            penalty_reserve     : 0x2::balance::zero<T0>(),
            whitelist           : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            point               : 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::point::new(0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::zero(), 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::zero(), 0x2::clock::timestamp_ms(arg3)),
            slope_changes       : 0x2::table::new<u64, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::I128>(arg4),
            response_checklists : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v1 = CreatePoolEvent{
            protocol  : 0x1::type_name::get<T1>(),
            coin_type : 0x1::type_name::get<T0>(),
            id        : 0x2::object::id<DeCenter<T0, T1>>(&v0),
            max_time  : arg1,
            offset    : arg2,
        };
        0x2::event::emit<CreatePoolEvent>(v1);
        v0
    }

    public fun add_penalty<T0, T1>(arg0: &mut DeCenter<T0, T1>, arg1: &AdminCap<T1>, arg2: u32, arg3: u32) {
        assert_version<T0, T1>(arg0);
        if (0x1::vector::is_empty<PenaltyInfo>(&arg0.penalty)) {
            let v0 = PenaltyInfo{
                elapsed_percentage : arg2,
                penalty_percentage : arg3,
            };
            0x1::vector::push_back<PenaltyInfo>(&mut arg0.penalty, v0);
        } else {
            let v1 = 0;
            while (v1 < 0x1::vector::length<PenaltyInfo>(&arg0.penalty)) {
                let v2 = 0x1::vector::borrow<PenaltyInfo>(&arg0.penalty, v1);
                if (arg2 < v2.elapsed_percentage) {
                    let v3 = PenaltyInfo{
                        elapsed_percentage : arg2,
                        penalty_percentage : arg3,
                    };
                    0x1::vector::insert<PenaltyInfo>(&mut arg0.penalty, v3, v1);
                    return
                };
                if (arg2 == v2.elapsed_percentage) {
                    let v4 = PenaltyInfo{
                        elapsed_percentage : arg2,
                        penalty_percentage : arg3,
                    };
                    *0x1::vector::borrow_mut<PenaltyInfo>(&mut arg0.penalty, v1) = v4;
                    return
                };
                v1 = v1 + 1;
            };
            let v5 = PenaltyInfo{
                elapsed_percentage : arg2,
                penalty_percentage : arg3,
            };
            0x1::vector::push_back<PenaltyInfo>(&mut arg0.penalty, v5);
        };
    }

    public fun add_penalty_fee_admin<T0, T1, T2: drop>(arg0: &mut DeCenter<T0, T1>, arg1: &AdminCap<T1>) {
        assert_version<T0, T1>(arg0);
        0x1::option::swap_or_fill<0x1::type_name::TypeName>(&mut arg0.penalty_fee_admin, 0x1::type_name::get<T2>());
    }

    public fun add_penalty_fee_balance<T0, T1>(arg0: &mut DeCenter<T0, T1>, arg1: 0x2::balance::Balance<T0>) {
        assert_version<T0, T1>(arg0);
        0x2::balance::join<T0>(&mut arg0.penalty_fee_balance, arg1);
    }

    public fun add_penalty_reserve<T0, T1>(arg0: &mut DeCenter<T0, T1>, arg1: 0x2::balance::Balance<T0>) {
        assert_version<T0, T1>(arg0);
        0x2::balance::join<T0>(&mut arg0.penalty_reserve, arg1);
    }

    public fun add_response_checklists<T0, T1, T2: drop>(arg0: &mut DeCenter<T0, T1>, arg1: &AdminCap<T1>) {
        assert_version<T0, T1>(arg0);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.response_checklists, 0x1::type_name::get<T2>());
    }

    public fun add_version<T0, T1>(arg0: &mut DeCenter<T0, T1>, arg1: &AdminCap<T1>, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg0.versions, arg2);
    }

    public fun add_whitelist<T0, T1, T2: drop>(arg0: &mut DeCenter<T0, T1>, arg1: &AdminCap<T1>) {
        assert_version<T0, T1>(arg0);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.whitelist, 0x1::type_name::get<T2>());
    }

    fun assert_matched_escrow<T0, T1>(arg0: &DeCenter<T0, T1>, arg1: &0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>) {
        assert!(0x2::object::id<DeCenter<T0, T1>>(arg0) == 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::pool_id<T0, T1>(arg1), 106);
    }

    fun assert_version<T0, T1>(arg0: &DeCenter<T0, T1>) {
        let v0 = 2;
        assert!(0x2::vec_set::contains<u64>(&arg0.versions, &v0), 101);
    }

    public fun checkpoint<T0, T1>(arg0: &mut DeCenter<T0, T1>, arg1: &0x2::clock::Clock) {
        checkpoint_<T0, T1>(arg0, false, 0, 0, 0, 0, arg1);
    }

    fun checkpoint_<T0, T1>(arg0: &mut DeCenter<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::zero();
        let v2 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::zero();
        let v3 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::zero();
        let v4 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::zero();
        let v5 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::zero();
        let v6 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::zero();
        if (arg1) {
            if (arg3 > v0 && arg2 > 0) {
                v2 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::calculate_slope(arg2, arg0.max_time);
                v3 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::calculate_bias(arg2, arg3, v0, arg0.max_time);
            };
            if (arg5 > v0 && arg4 > 0) {
                v5 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::calculate_slope(arg4, arg0.max_time);
                v6 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::calculate_bias(arg4, arg5, v0, arg0.max_time);
            };
            if (0x2::table::contains<u64, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::I128>(&arg0.slope_changes, arg3)) {
                v1 = *0x2::table::borrow<u64, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::I128>(&arg0.slope_changes, arg3);
            };
            if (arg5 != 0) {
                if (arg5 == arg3) {
                    v4 = v1;
                } else if (0x2::table::contains<u64, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::I128>(&arg0.slope_changes, arg5)) {
                    v4 = *0x2::table::borrow<u64, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::I128>(&arg0.slope_changes, arg5);
                };
            };
        };
        let v7 = arg0.point;
        let v8 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::point::bias(&v7);
        let v9 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::point::slope(&v7);
        let v10 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::point::timestamp(&v7);
        let v11 = v10;
        let v12 = arg0.offset + round_down_week(v10);
        let v13 = 0;
        while (v13 < 255) {
            let v14 = v12 + 604800000;
            v12 = v14;
            let v15 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::zero();
            if (v14 > v0) {
                v12 = v0;
            } else if (0x2::table::contains<u64, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::I128>(&arg0.slope_changes, v14)) {
                v15 = *0x2::table::borrow<u64, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::I128>(&arg0.slope_changes, v14);
            };
            let v16 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::calculate_bias_by_slope(v9, v12, v10);
            let v17 = &v8;
            v8 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::sub(v17, &v16);
            let v18 = &v9;
            v9 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::add(v18, &v15);
            if (0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::is_neg(&v8)) {
                v8 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::zero();
            };
            if (0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::is_neg(&v9)) {
                v9 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::zero();
            };
            v11 = v12;
            if (v12 == v0) {
                break
            };
            arg0.point = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::point::new(v8, v9, v12);
            v13 = v13 + 1;
        };
        if (arg1) {
            let v19 = &v9;
            let v20 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::sub(&v5, &v2);
            v9 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::add(v19, &v20);
            let v21 = &v8;
            let v22 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::sub(&v6, &v3);
            v8 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::add(v21, &v22);
            if (0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::is_neg(&v8)) {
                v8 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::zero();
            };
            if (0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::is_neg(&v9)) {
                v9 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::zero();
            };
        };
        let v23 = if (0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::point::timestamp(&arg0.point) != v11) {
            true
        } else if (!0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::is_zero(&v9)) {
            true
        } else {
            !0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::is_zero(&v8)
        };
        if (v23) {
            arg0.point = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::point::new(v8, v9, v11);
        };
        if (arg1) {
            if (arg3 > v0) {
                let v24 = &v1;
                v1 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::add(v24, &v2);
                if (arg5 == arg3) {
                    let v25 = &v1;
                    v1 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::sub(v25, &v5);
                };
                if (0x2::table::contains<u64, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::I128>(&arg0.slope_changes, arg3)) {
                    *0x2::table::borrow_mut<u64, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::I128>(&mut arg0.slope_changes, arg3) = v1;
                } else {
                    0x2::table::add<u64, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::I128>(&mut arg0.slope_changes, arg3, v1);
                };
            };
            if (arg5 > v0) {
                if (arg5 > arg3) {
                    let v26 = &v4;
                    v4 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::sub(v26, &v5);
                    if (0x2::table::contains<u64, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::I128>(&arg0.slope_changes, arg5)) {
                        *0x2::table::borrow_mut<u64, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::I128>(&mut arg0.slope_changes, arg5) = v4;
                    } else {
                        0x2::table::add<u64, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::I128>(&mut arg0.slope_changes, arg5, v4);
                    };
                };
            };
        };
    }

    public fun current_penalty<T0, T1>(arg0: &DeCenter<T0, T1>, arg1: u64) : 0x1::option::Option<PenaltyInfo> {
        abort 0
    }

    public fun default<T0, T1>(arg0: &AdminCap<T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<DeCenter<T0, T1>>(new<T0, T1>(arg0, arg1, arg2, arg3, arg4));
    }

    public fun escrow_current_penalty<T0, T1>(arg0: &DeCenter<T0, T1>, arg1: &0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>, arg2: &0x2::clock::Clock) : 0x1::option::Option<PenaltyInfo> {
        let v0 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::point::timestamp(0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::point<T0, T1>(arg1));
        let v1 = 0x2::clock::timestamp_ms(arg2) - v0;
        let v2 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::end<T0, T1>(arg1) - v0;
        if (0x1::vector::is_empty<PenaltyInfo>(&arg0.penalty)) {
            0x1::option::none<PenaltyInfo>()
        } else if (v1 >= v2) {
            0x1::option::none<PenaltyInfo>()
        } else {
            let (v4, v5) = penalty_info<T0, T1>(arg0);
            let v6 = v5;
            let v7 = v4;
            let v8 = 0;
            0x1::vector::reverse<u32>(&mut v7);
            0x1::vector::reverse<u32>(&mut v6);
            while (v8 < 0x1::vector::length<u32>(&v7)) {
                let v9 = *0x1::vector::borrow<u32>(&v7, v8);
                if (v1 >= (v9 as u64) * v2 / 1000000) {
                    let v10 = PenaltyInfo{
                        elapsed_percentage : v9,
                        penalty_percentage : *0x1::vector::borrow<u32>(&v6, v8),
                    };
                    return 0x1::option::some<PenaltyInfo>(v10)
                };
                v8 = v8 + 1;
            };
            0x1::option::none<PenaltyInfo>()
        }
    }

    public fun escrow_penalty<T0, T1>(arg0: &0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>, arg1: &DeCenter<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock) : 0x1::option::Option<u64> {
        assert!(0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::balance<T0, T1>(arg0) >= arg2, 113);
        if (0x2::clock::timestamp_ms(arg3) >= 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::end<T0, T1>(arg0)) {
            return 0x1::option::some<u64>(0)
        };
        let v0 = escrow_current_penalty<T0, T1>(arg1, arg0, arg3);
        if (0x1::option::is_none<PenaltyInfo>(&v0)) {
            0x1::option::none<u64>()
        } else {
            let v2 = 0x1::option::extract<PenaltyInfo>(&mut v0);
            0x1::option::some<u64>((((v2.penalty_percentage as u128) * (arg2 as u128) / (1000000 as u128)) as u64))
        }
    }

    public fun force_unlock_with_penalty<T0, T1>(arg0: &mut DeCenter<T0, T1>, arg1: 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, DeTokenUpdateResponse<T0, T1>) {
        assert_version<T0, T1>(arg0);
        assert_matched_escrow<T0, T1>(arg0, &arg1);
        assert!(0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::early_unlock<T0, T1>(&arg1), 107);
        assert!(0x2::clock::timestamp_ms(arg2) < 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::end<T0, T1>(&arg1), 105);
        assert!(0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::balance<T0, T1>(&arg1) > 0, 104);
        let v0 = escrow_current_penalty<T0, T1>(arg0, &arg1, arg2);
        assert!(0x1::option::is_some<PenaltyInfo>(&v0), 107);
        let (v1, v2) = unlock_<T0, T1>(arg0, arg1, arg2, arg3);
        let v3 = v1;
        let v4 = 0x1::option::extract<PenaltyInfo>(&mut v0);
        let v5 = (v4.penalty_percentage as u128) * (0x2::coin::value<T0>(&v3) as u128) / (1000000 as u128);
        let v6 = 0x2::coin::split<T0>(&mut v3, (v5 as u64), arg3);
        let v7 = v5 * (arg0.penalty_fee_bps as u128) / (1000000 as u128);
        0x2::balance::join<T0>(&mut arg0.penalty_fee_balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v6, (v7 as u64), arg3)));
        0x2::balance::join<T0>(&mut arg0.penalty_reserve, 0x2::coin::into_balance<T0>(v6));
        let v8 = PenaltyEvent{
            escrow_id       : 0x2::object::id<0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>>(&arg1),
            pool_id         : 0x2::object::id<DeCenter<T0, T1>>(arg0),
            penalty_amount  : (v5 as u64),
            penalty_fee     : (v7 as u64),
            penalty_reserve : 0x2::coin::value<T0>(&v6),
        };
        0x2::event::emit<PenaltyEvent>(v8);
        (v3, v2)
    }

    public fun force_unlock_with_whitelist<T0, T1, T2: drop>(arg0: &mut DeCenter<T0, T1>, arg1: 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>, arg2: T2, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, DeTokenUpdateResponse<T0, T1>) {
        assert_version<T0, T1>(arg0);
        let v0 = 0x1::type_name::get<T2>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.whitelist, &v0), 108);
        assert_matched_escrow<T0, T1>(arg0, &arg1);
        unlock_<T0, T1>(arg0, arg1, arg3, arg4)
    }

    public fun force_withdraw_with_penalty<T0, T1>(arg0: &mut DeCenter<T0, T1>, arg1: &mut 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, DeTokenUpdateResponse<T0, T1>) {
        assert_version<T0, T1>(arg0);
        assert_matched_escrow<T0, T1>(arg0, arg1);
        assert!(0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::early_unlock<T0, T1>(arg1), 107);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::object::id<0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>>(arg1);
        let v2 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::balance<T0, T1>(arg1);
        let v3 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::end<T0, T1>(arg1);
        assert!(v0 < v3, 105);
        assert!(v2 > 0, 104);
        let v4 = escrow_current_penalty<T0, T1>(arg0, arg1, arg3);
        assert!(0x1::option::is_some<PenaltyInfo>(&v4), 107);
        let v5 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::action::withdraw();
        let v6 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::withdraw<T0, T1>(arg1, v5, arg2, arg3, arg4);
        checkpoint_<T0, T1>(arg0, true, v2, v3, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::balance<T0, T1>(arg1), 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::end<T0, T1>(arg1), arg3);
        arg0.locked_total = arg0.locked_total - 0x2::coin::value<T0>(&v6);
        let v7 = 0x1::option::extract<PenaltyInfo>(&mut v4);
        let v8 = (v7.penalty_percentage as u128) * (0x2::coin::value<T0>(&v6) as u128) / (1000000 as u128);
        let v9 = 0x2::coin::split<T0>(&mut v6, (v8 as u64), arg4);
        let v10 = v8 * (arg0.penalty_fee_bps as u128) / (1000000 as u128);
        0x2::balance::join<T0>(&mut arg0.penalty_fee_balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v9, (v10 as u64), arg4)));
        0x2::balance::join<T0>(&mut arg0.penalty_reserve, 0x2::coin::into_balance<T0>(v9));
        let v11 = PenaltyEvent{
            escrow_id       : v1,
            pool_id         : 0x2::object::id<DeCenter<T0, T1>>(arg0),
            penalty_amount  : (v8 as u64),
            penalty_fee     : (v10 as u64),
            penalty_reserve : 0x2::coin::value<T0>(&v9),
        };
        0x2::event::emit<PenaltyEvent>(v11);
        let v12 = WithdrawEvent{
            escrow_id  : v1,
            pool_id    : 0x2::object::id<DeCenter<T0, T1>>(arg0),
            coin_type  : 0x1::type_name::get<T0>(),
            withdrawl  : 0x2::coin::value<T0>(&v6),
            locked_end : v3,
            timestamp  : v0,
            whitelist  : 0x1::option::none<0x1::type_name::TypeName>(),
        };
        0x2::event::emit<WithdrawEvent>(v12);
        (v6, to_vesting_token_update_response<T0, T1>(arg1, v5, arg3))
    }

    public fun force_withdraw_with_whitelist<T0, T1, T2: drop>(arg0: &mut DeCenter<T0, T1>, arg1: &mut 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>, arg2: T2, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, DeTokenUpdateResponse<T0, T1>) {
        assert_version<T0, T1>(arg0);
        let v0 = 0x1::type_name::get<T2>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.whitelist, &v0), 108);
        assert_matched_escrow<T0, T1>(arg0, arg1);
        let v1 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::end<T0, T1>(arg1);
        let v2 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::action::withdraw();
        let v3 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::withdraw<T0, T1>(arg1, v2, arg3, arg4, arg5);
        checkpoint_<T0, T1>(arg0, true, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::balance<T0, T1>(arg1), v1, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::balance<T0, T1>(arg1), 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::end<T0, T1>(arg1), arg4);
        arg0.locked_total = arg0.locked_total - 0x2::coin::value<T0>(&v3);
        let v4 = WithdrawEvent{
            escrow_id  : 0x2::object::id<0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>>(arg1),
            pool_id    : 0x2::object::id<DeCenter<T0, T1>>(arg0),
            coin_type  : 0x1::type_name::get<T0>(),
            withdrawl  : 0x2::coin::value<T0>(&v3),
            locked_end : v1,
            timestamp  : 0x2::clock::timestamp_ms(arg4),
            whitelist  : 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::get<T2>()),
        };
        0x2::event::emit<WithdrawEvent>(v4);
        (v3, to_vesting_token_update_response<T0, T1>(arg1, v2, arg4))
    }

    public fun fulfill_response<T0, T1>(arg0: DeTokenUpdateResponse<T0, T1>, arg1: &DeCenter<T0, T1>) {
        let DeTokenUpdateResponse {
            id                : _,
            pool_id           : _,
            action            : _,
            checklists        : v3,
            max_time          : _,
            balance           : _,
            end               : _,
            early_unlock      : _,
            raw_voting_weight : _,
            voting_weight     : _,
        } = arg0;
        let v10 = v3;
        let v11 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(arg1.response_checklists);
        let v12 = &v11;
        let v13 = 0;
        let v14;
        while (v13 < 0x1::vector::length<0x1::type_name::TypeName>(v12)) {
            if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&v10, 0x1::vector::borrow<0x1::type_name::TypeName>(v12, v13))) {
                v14 = false;
                /* label 6 */
                if (!v14) {
                    abort 110
                };
                return
            };
            v13 = v13 + 1;
        };
        v14 = true;
        /* goto 6 */
    }

    public fun get_locked_end<T0, T1>(arg0: &DeCenter<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = arg1 + v0;
        let v2 = arg0.offset + round_down_week(v1) + 604800000;
        let v3 = v2;
        if (v1 % 604800000 == offset<T0, T1>(arg0)) {
            v3 = v2 - 604800000;
        };
        let v4 = offset<T0, T1>(arg0) + round_down_week(v0 + arg0.max_time);
        if (v3 > v4) {
            v4
        } else {
            v3
        }
    }

    public fun increase_unlock_amount<T0, T1>(arg0: &mut DeCenter<T0, T1>, arg1: &mut 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock) : DeTokenUpdateResponse<T0, T1> {
        assert_version<T0, T1>(arg0);
        assert_matched_escrow<T0, T1>(arg0, arg1);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::balance<T0, T1>(arg1);
        let v2 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::end<T0, T1>(arg1);
        assert!(v2 > v0, 105);
        assert!(v1 > 0, 104);
        let v3 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::action::extend_balance_action();
        let v4 = 0x2::coin::value<T0>(&arg2);
        if (v4 == 0) {
            0x2::coin::destroy_zero<T0>(arg2);
        } else {
            0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::extend<T0, T1>(arg1, v3, 0x1::option::some<0x2::coin::Coin<T0>>(arg2), 0, arg3);
            arg0.locked_total = arg0.locked_total + v4;
            checkpoint_<T0, T1>(arg0, true, v1, v2, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::balance<T0, T1>(arg1), v2, arg3);
            let v5 = IncreaseUnlockAmountEvent{
                escrow_id     : 0x2::object::id<0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>>(arg1),
                pool_id       : 0x2::object::id<DeCenter<T0, T1>>(arg0),
                coin_type     : 0x1::type_name::get<T0>(),
                locked_amount : v4,
                timestamp     : v0,
            };
            0x2::event::emit<IncreaseUnlockAmountEvent>(v5);
        };
        to_vesting_token_update_response<T0, T1>(arg1, v3, arg3)
    }

    public fun increase_unlock_time<T0, T1>(arg0: &mut DeCenter<T0, T1>, arg1: &mut 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock) : DeTokenUpdateResponse<T0, T1> {
        assert_version<T0, T1>(arg0);
        assert_matched_escrow<T0, T1>(arg0, arg1);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::balance<T0, T1>(arg1);
        let v2 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::end<T0, T1>(arg1);
        let v3 = get_locked_end<T0, T1>(arg0, arg2, arg3);
        assert!(v2 > v0, 105);
        assert!(v1 > 0, 104);
        assert!(v3 > v2, 102);
        assert!(v3 > v0 && arg2 <= arg0.max_time, 102);
        let v4 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::action::extend_time_action();
        0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::extend<T0, T1>(arg1, v4, 0x1::option::none<0x2::coin::Coin<T0>>(), v3, arg3);
        checkpoint_<T0, T1>(arg0, true, v1, v2, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::balance<T0, T1>(arg1), 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::end<T0, T1>(arg1), arg3);
        let v5 = IncreaseUnlockTimeEvent{
            escrow_id         : 0x2::object::id<0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>>(arg1),
            pool_id           : 0x2::object::id<DeCenter<T0, T1>>(arg0),
            coin_type         : 0x1::type_name::get<T0>(),
            timestamp         : v0,
            extended_duration : v3 - v2,
        };
        0x2::event::emit<IncreaseUnlockTimeEvent>(v5);
        to_vesting_token_update_response<T0, T1>(arg1, v4, arg3)
    }

    fun init(arg0: DE_CENTER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<DE_CENTER>(arg0, arg1);
    }

    public fun lock<T0, T1>(arg0: &mut DeCenter<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>, DeTokenUpdateResponse<T0, T1>) {
        assert_version<T0, T1>(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = get_locked_end<T0, T1>(arg0, arg2, arg4);
        let v2 = 0x2::object::id<DeCenter<T0, T1>>(arg0);
        let v3 = 0x2::coin::value<T0>(&arg1);
        assert!(v3 > 0, 104);
        assert!(v1 > v0 && arg2 <= arg0.max_time, 102);
        let v4 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::action::lock_action();
        let v5 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::new<T0, T1>(v4, arg1, v2, arg0.max_time, v1, arg3, arg4, arg5);
        arg0.minted_escrow = arg0.minted_escrow + 1;
        arg0.locked_total = arg0.locked_total + v3;
        checkpoint_<T0, T1>(arg0, true, 0, 0, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::balance<T0, T1>(&v5), 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::end<T0, T1>(&v5), arg4);
        let v6 = LockEvent{
            escrow_id    : 0x2::object::id<0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>>(&v5),
            pool_id      : v2,
            coin_type    : 0x1::type_name::get<T0>(),
            locked_value : 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::balance<T0, T1>(&v5),
            unlock_time  : 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::end<T0, T1>(&v5),
            timestamp    : v0,
        };
        0x2::event::emit<LockEvent>(v6);
        (v5, to_vesting_token_update_response<T0, T1>(&v5, v4, arg4))
    }

    public fun locked_total<T0, T1>(arg0: &DeCenter<T0, T1>) : u64 {
        arg0.locked_total
    }

    public fun max_locked_end<T0, T1>(arg0: &DeCenter<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        arg0.offset + round_down_week(arg0.max_time + 0x2::clock::timestamp_ms(arg1))
    }

    public fun max_time<T0, T1>(arg0: &DeCenter<T0, T1>) : u64 {
        arg0.max_time
    }

    public fun merge<T0, T1>(arg0: &mut DeCenter<T0, T1>, arg1: &mut 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>, arg2: 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (DeTokenUpdateResponse<T0, T1>, DeTokenUpdateResponse<T0, T1>) {
        assert_version<T0, T1>(arg0);
        assert_matched_escrow<T0, T1>(arg0, arg1);
        assert_matched_escrow<T0, T1>(arg0, &arg2);
        let v0 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::balance<T0, T1>(arg1);
        let v1 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::end<T0, T1>(arg1);
        let v2 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::balance<T0, T1>(&arg2);
        let v3 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::end<T0, T1>(&arg2);
        let v4 = 0x2::clock::timestamp_ms(arg3);
        let v5 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::early_unlock<T0, T1>(arg1) && 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::early_unlock<T0, T1>(&arg2);
        assert!(v1 > v4 && v3 > v4, 105);
        assert!(v0 > 0 && v2 > 0, 104);
        checkpoint_<T0, T1>(arg0, true, v2, v3, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::balance<T0, T1>(&arg2), 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::end<T0, T1>(&arg2), arg3);
        0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::destroy<T0, T1>(arg2);
        let v6 = if (v1 > v3) {
            v1
        } else {
            v3
        };
        0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::update_early_unlock<T0, T1>(arg1, v5);
        arg0.minted_escrow = arg0.minted_escrow - 1;
        0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::extend<T0, T1>(arg1, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::action::primary(), 0x1::option::some<0x2::coin::Coin<T0>>(0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::withdraw_all<T0, T1>(&mut arg2, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::action::to_merge(), arg3, arg4)), v6, arg3);
        checkpoint_<T0, T1>(arg0, true, v0, v1, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::balance<T0, T1>(arg1), 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::end<T0, T1>(arg1), arg3);
        let v7 = MergeEvent{
            escrow_id          : 0x2::object::id<0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>>(arg1),
            merged_escrow_id   : 0x2::object::id<0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>>(&arg2),
            pool_id            : 0x2::object::id<DeCenter<T0, T1>>(arg0),
            coin_type          : 0x1::type_name::get<T0>(),
            locked_value       : 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::balance<T0, T1>(arg1),
            new_unlock_time    : 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::end<T0, T1>(arg1),
            merged_value       : v2,
            merged_unlock_time : v3,
            timestamp          : v4,
        };
        0x2::event::emit<MergeEvent>(v7);
        (to_vesting_token_update_response<T0, T1>(arg1, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::action::to_merge(), arg3), to_vesting_token_update_response<T0, T1>(&arg2, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::action::primary(), arg3))
    }

    public fun minted_escrow<T0, T1>(arg0: &DeCenter<T0, T1>) : u64 {
        arg0.minted_escrow
    }

    public fun new_admin<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : AdminCap<T0> {
        assert!(0x2::types::is_one_time_witness<T0>(&arg0), 109);
        AdminCap<T0>{id: 0x2::object::new(arg1)}
    }

    public fun offset<T0, T1>(arg0: &DeCenter<T0, T1>) : u64 {
        arg0.offset
    }

    public fun package_version() : u64 {
        2
    }

    public fun penalty_fee_admin<T0, T1>(arg0: &DeCenter<T0, T1>) : 0x1::option::Option<0x1::type_name::TypeName> {
        arg0.penalty_fee_admin
    }

    public fun penalty_fee_balance<T0, T1>(arg0: &DeCenter<T0, T1>) : &0x2::balance::Balance<T0> {
        &arg0.penalty_fee_balance
    }

    public fun penalty_fee_bps<T0, T1>(arg0: &DeCenter<T0, T1>) : u64 {
        arg0.penalty_fee_bps
    }

    public fun penalty_info<T0, T1>(arg0: &DeCenter<T0, T1>) : (vector<u32>, vector<u32>) {
        let v0 = vector[];
        let v1 = vector[];
        let v2 = &arg0.penalty;
        let v3 = 0;
        while (v3 < 0x1::vector::length<PenaltyInfo>(v2)) {
            let v4 = 0x1::vector::borrow<PenaltyInfo>(v2, v3);
            0x1::vector::push_back<u32>(&mut v0, v4.elapsed_percentage);
            0x1::vector::push_back<u32>(&mut v1, v4.penalty_percentage);
            v3 = v3 + 1;
        };
        (v0, v1)
    }

    public fun penalty_info_elapsed_percentage(arg0: &PenaltyInfo) : u32 {
        arg0.elapsed_percentage
    }

    public fun penalty_info_penalty_percentage(arg0: &PenaltyInfo) : u32 {
        arg0.penalty_percentage
    }

    public fun penalty_reserve<T0, T1>(arg0: &DeCenter<T0, T1>) : &0x2::balance::Balance<T0> {
        &arg0.penalty_reserve
    }

    public fun point<T0, T1>(arg0: &DeCenter<T0, T1>) : &0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::point::Point {
        &arg0.point
    }

    public fun remove_penalty<T0, T1>(arg0: &mut DeCenter<T0, T1>, arg1: &AdminCap<T1>, arg2: u32) {
        assert_version<T0, T1>(arg0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<PenaltyInfo>(&arg0.penalty)) {
            if (0x1::vector::borrow<PenaltyInfo>(&arg0.penalty, v0).elapsed_percentage == arg2) {
                0x1::vector::remove<PenaltyInfo>(&mut arg0.penalty, v0);
                return
            };
            v0 = v0 + 1;
        };
    }

    public fun remove_penalty_fee_admin<T0, T1>(arg0: &mut DeCenter<T0, T1>, arg1: &AdminCap<T1>) {
        assert_version<T0, T1>(arg0);
        0x1::option::extract<0x1::type_name::TypeName>(&mut arg0.penalty_fee_admin);
    }

    public fun remove_response_checklists<T0, T1, T2: drop>(arg0: &mut DeCenter<T0, T1>, arg1: &AdminCap<T1>) {
        assert_version<T0, T1>(arg0);
        let v0 = 0x1::type_name::get<T2>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.response_checklists, &v0), 112);
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.response_checklists, &v0);
    }

    public fun remove_version<T0, T1>(arg0: &mut DeCenter<T0, T1>, arg1: &AdminCap<T1>, arg2: u64) {
        0x2::vec_set::remove<u64>(&mut arg0.versions, &arg2);
    }

    public fun remove_whitelist<T0, T1, T2: drop>(arg0: &mut DeCenter<T0, T1>, arg1: &AdminCap<T1>) {
        assert_version<T0, T1>(arg0);
        let v0 = 0x1::type_name::get<T2>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.whitelist, &v0), 112);
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.whitelist, &v0);
    }

    public fun response_check_rule<T0, T1, T2: drop>(arg0: &mut DeTokenUpdateResponse<T0, T1>, arg1: T2) {
        let v0 = 0x1::type_name::get<T2>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.checklists, &v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.checklists, v0);
        };
    }

    public fun response_checklists<T0, T1>(arg0: &DeCenter<T0, T1>) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &arg0.response_checklists
    }

    public fun round_down_week(arg0: u64) : u64 {
        arg0 / 604800000 * 604800000
    }

    public fun scaling() : u64 {
        1000000
    }

    public(friend) fun to_vesting_token_update_response<T0, T1>(arg0: &0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>, arg1: 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::action::Action, arg2: &0x2::clock::Clock) : DeTokenUpdateResponse<T0, T1> {
        DeTokenUpdateResponse<T0, T1>{
            id                : 0x2::object::id<0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>>(arg0),
            pool_id           : 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::pool_id<T0, T1>(arg0),
            action            : arg1,
            checklists        : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            max_time          : 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::max_time<T0, T1>(arg0),
            balance           : 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::balance<T0, T1>(arg0),
            end               : 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::end<T0, T1>(arg0),
            early_unlock      : 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::early_unlock<T0, T1>(arg0),
            raw_voting_weight : 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::raw_voting_weight<T0, T1>(arg0),
            voting_weight     : 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::voting_weight<T0, T1>(arg0, arg2),
        }
    }

    public fun total_voting_weight<T0, T1>(arg0: &DeCenter<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        total_voting_weight_at<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg1))
    }

    public fun total_voting_weight_at<T0, T1>(arg0: &DeCenter<T0, T1>, arg1: u64) : u64 {
        let v0 = arg0.point;
        let v1 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::point::bias(&v0);
        let v2 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::point::slope(&v0);
        let v3 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::point::timestamp(&v0);
        let v4 = arg0.offset + round_down_week(v3);
        let v5 = 0;
        while (v5 < 255) {
            let v6 = v4 + 604800000;
            v4 = v6;
            let v7 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::zero();
            if (v6 > arg1) {
                v4 = arg1;
            } else if (0x2::table::contains<u64, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::I128>(&arg0.slope_changes, v6)) {
                v7 = *0x2::table::borrow<u64, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::I128>(&arg0.slope_changes, v6);
            };
            let v8 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::calculate_bias_by_slope(v2, v4, v3);
            let v9 = &v1;
            v1 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::sub(v9, &v8);
            if (v4 == arg1) {
                break
            };
            let v10 = &v2;
            v2 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::add(v10, &v7);
            v5 = v5 + 1;
        };
        if (0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::is_neg(&v1)) {
            v1 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::zero();
        };
        (0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::i128::as_u128(&v1) as u64)
    }

    public fun unlock<T0, T1>(arg0: &mut DeCenter<T0, T1>, arg1: 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, DeTokenUpdateResponse<T0, T1>) {
        assert_version<T0, T1>(arg0);
        assert!(0x2::clock::timestamp_ms(arg2) >= 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::end<T0, T1>(&arg1), 103);
        assert!(0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::balance<T0, T1>(&arg1) > 0, 104);
        assert_matched_escrow<T0, T1>(arg0, &arg1);
        unlock_<T0, T1>(arg0, arg1, arg2, arg3)
    }

    fun unlock_<T0, T1>(arg0: &mut DeCenter<T0, T1>, arg1: 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, DeTokenUpdateResponse<T0, T1>) {
        let v0 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::end<T0, T1>(&arg1);
        let v1 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::action::unlock_action();
        let v2 = 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::withdraw_all<T0, T1>(&mut arg1, v1, arg2, arg3);
        checkpoint_<T0, T1>(arg0, true, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::balance<T0, T1>(&arg1), v0, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::balance<T0, T1>(&arg1), 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::end<T0, T1>(&arg1), arg2);
        arg0.locked_total = arg0.locked_total - 0x2::coin::value<T0>(&v2);
        arg0.minted_escrow = arg0.minted_escrow - 1;
        0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::destroy<T0, T1>(arg1);
        let v3 = UnlockEvent{
            escrow_id      : 0x2::object::id<0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>>(&arg1),
            pool_id        : 0x2::object::id<DeCenter<T0, T1>>(arg0),
            coin_type      : 0x1::type_name::get<T0>(),
            unlocked_value : 0x2::coin::value<T0>(&v2),
            locked_end     : v0,
            timestamp      : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<UnlockEvent>(v3);
        (v2, to_vesting_token_update_response<T0, T1>(&arg1, v1, arg2))
    }

    public fun vesting_token_update_response_balance<T0, T1>(arg0: &DeTokenUpdateResponse<T0, T1>) : u64 {
        arg0.balance
    }

    public fun vesting_token_update_response_checklists<T0, T1>(arg0: &DeTokenUpdateResponse<T0, T1>) : 0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        arg0.checklists
    }

    public fun vesting_token_update_response_early_unlock<T0, T1>(arg0: &DeTokenUpdateResponse<T0, T1>) : bool {
        arg0.early_unlock
    }

    public fun vesting_token_update_response_end<T0, T1>(arg0: &DeTokenUpdateResponse<T0, T1>) : u64 {
        arg0.balance
    }

    public fun vesting_token_update_response_id<T0, T1>(arg0: &DeTokenUpdateResponse<T0, T1>) : 0x2::object::ID {
        arg0.id
    }

    public fun vesting_token_update_response_max_time<T0, T1>(arg0: &DeTokenUpdateResponse<T0, T1>) : u64 {
        arg0.max_time
    }

    public fun vesting_token_update_response_pool_id<T0, T1>(arg0: &DeTokenUpdateResponse<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun vesting_token_update_response_raw_voting_weight<T0, T1>(arg0: &DeTokenUpdateResponse<T0, T1>) : u64 {
        arg0.raw_voting_weight
    }

    public fun vesting_token_update_response_voting_weight<T0, T1>(arg0: &DeTokenUpdateResponse<T0, T1>) : u64 {
        arg0.voting_weight
    }

    public fun vesting_tokenupdate_response_balance<T0, T1>(arg0: &DeTokenUpdateResponse<T0, T1>) : u64 {
        arg0.balance
    }

    public fun vesting_tokenupdate_response_checklists<T0, T1>(arg0: &DeTokenUpdateResponse<T0, T1>) : 0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        arg0.checklists
    }

    public fun vesting_tokenupdate_response_early_unlock<T0, T1>(arg0: &DeTokenUpdateResponse<T0, T1>) : bool {
        arg0.early_unlock
    }

    public fun vesting_tokenupdate_response_end<T0, T1>(arg0: &DeTokenUpdateResponse<T0, T1>) : u64 {
        arg0.end
    }

    public fun vesting_tokenupdate_response_id<T0, T1>(arg0: &DeTokenUpdateResponse<T0, T1>) : 0x2::object::ID {
        arg0.id
    }

    public fun vesting_tokenupdate_response_max_time<T0, T1>(arg0: &DeTokenUpdateResponse<T0, T1>) : u64 {
        arg0.max_time
    }

    public fun vesting_tokenupdate_response_pool_id<T0, T1>(arg0: &DeTokenUpdateResponse<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun vesting_tokenupdate_response_raw_voting_weight<T0, T1>(arg0: &DeTokenUpdateResponse<T0, T1>) : u64 {
        arg0.raw_voting_weight
    }

    public fun vesting_tokenupdate_response_voting_weight<T0, T1>(arg0: &DeTokenUpdateResponse<T0, T1>) : u64 {
        arg0.voting_weight
    }

    public fun week() : u64 {
        604800000
    }

    public fun whitelist<T0, T1>(arg0: &DeCenter<T0, T1>) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &arg0.whitelist
    }

    public fun withdraw_penalty_fee<T0, T1>(arg0: &mut DeCenter<T0, T1>, arg1: &AdminCap<T1>, arg2: u64) : 0x2::balance::Balance<T0> {
        assert_version<T0, T1>(arg0);
        0x2::balance::split<T0>(&mut arg0.penalty_fee_balance, arg2)
    }

    public fun withdraw_penalty_reserve<T0, T1, T2: drop>(arg0: &mut DeCenter<T0, T1>, arg1: T2, arg2: u64) : 0x2::balance::Balance<T0> {
        assert_version<T0, T1>(arg0);
        let v0 = 0x1::type_name::get<T2>();
        assert!(0x1::option::borrow<0x1::type_name::TypeName>(&arg0.penalty_fee_admin) == &v0, 111);
        0x2::balance::split<T0>(&mut arg0.penalty_reserve, arg2)
    }

    // decompiled from Move bytecode v6
}

