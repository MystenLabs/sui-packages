module 0x3d4154629dfd823f9608108c50b1559dbe7d3a7102176b9138c39c255b03bfc::alphafi_cetus_compensation {
    struct CetusCompensator has store, key {
        id: 0x2::object::UID,
        old_positions: 0x2::vec_map::VecMap<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
        cur_acc_per_xtokens: 0x2::vec_map::VecMap<0x2::object::ID, u256>,
        user_last_acc_per_xtokens: 0x2::vec_map::VecMap<0x2::object::ID, u256>,
        total_xtokens: 0x2::vec_map::VecMap<0x2::object::ID, u256>,
        cetus_balance: 0x2::balance::Balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>,
    }

    public fun collect_cetus_compensation<T0, T1>(arg0: &0x3d4154629dfd823f9608108c50b1559dbe7d3a7102176b9138c39c255b03bfc::version::Version, arg1: &mut CetusCompensator, arg2: &0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::versioned::Versioned, arg3: &mut 0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::clmm_vester::ClmmVester, arg4: u16, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: 0x2::object::ID, arg7: &0x2::clock::Clock) {
        0x3d4154629dfd823f9608108c50b1559dbe7d3a7102176b9138c39c255b03bfc::version::assert_current_version(arg0);
        let v0 = collect_cetus_compensation_inner<T0, T1>(arg1, arg6, arg2, arg3, arg5, arg4, arg7);
        0x2::balance::join<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut arg1.cetus_balance, v0);
        let v1 = 0x2::vec_map::get_mut<0x2::object::ID, u256>(&mut arg1.cur_acc_per_xtokens, &arg6);
        *v1 = *v1 + (0x2::balance::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&v0) as u256) * (1000000000000000000000000000000000000 as u256) / (*0x2::vec_map::get<0x2::object::ID, u256>(&arg1.total_xtokens, &arg6) as u256);
    }

    public(friend) fun collect_cetus_compensation_inner<T0, T1>(arg0: &mut CetusCompensator, arg1: 0x2::object::ID, arg2: &0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::versioned::Versioned, arg3: &mut 0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::clmm_vester::ClmmVester, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: u16, arg6: &0x2::clock::Clock) : 0x2::balance::Balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS> {
        0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::clmm_vester::redeem<T0, T1>(arg2, arg3, arg4, 0x2::vec_map::get_mut<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.old_positions, &arg1), arg5, arg6)
    }

    public fun collect_position<T0, T1>(arg0: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::AdminCap, arg1: &0x3d4154629dfd823f9608108c50b1559dbe7d3a7102176b9138c39c255b03bfc::version::Version, arg2: &mut CetusCompensator, arg3: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_investor::Investor<T0, T1>, arg4: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_pool::Pool<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
        0x3d4154629dfd823f9608108c50b1559dbe7d3a7102176b9138c39c255b03bfc::version::assert_current_version(arg1);
        let v0 = 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_investor::remove_old_position<T0, T1>(arg0, arg3);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_attacked_position<T0, T1>(arg5, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0)), 3);
        0x2::vec_map::insert<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg2.old_positions, 0x2::object::id<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_pool::Pool<T0, T1>>(arg4), v0);
        0x2::vec_map::insert<0x2::object::ID, u256>(&mut arg2.total_xtokens, 0x2::object::id<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_pool::Pool<T0, T1>>(arg4), 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_pool::cetus_total_xtokens<T0, T1>(arg4));
        0x2::vec_map::insert<0x2::object::ID, u256>(&mut arg2.cur_acc_per_xtokens, 0x2::object::id<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_pool::Pool<T0, T1>>(arg4), 0);
    }

    public fun collect_position_base_a<T0, T1>(arg0: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::AdminCap, arg1: &0x3d4154629dfd823f9608108c50b1559dbe7d3a7102176b9138c39c255b03bfc::version::Version, arg2: &mut CetusCompensator, arg3: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_investor_base_a::Investor<T0, T1>, arg4: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_pool_base_a::Pool<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
        0x3d4154629dfd823f9608108c50b1559dbe7d3a7102176b9138c39c255b03bfc::version::assert_current_version(arg1);
        let v0 = 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_investor_base_a::remove_old_position<T0, T1>(arg0, arg3);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_attacked_position<T0, T1>(arg5, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0)), 3);
        0x2::vec_map::insert<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg2.old_positions, 0x2::object::id<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_pool_base_a::Pool<T0, T1>>(arg4), v0);
        0x2::vec_map::insert<0x2::object::ID, u256>(&mut arg2.total_xtokens, 0x2::object::id<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_pool_base_a::Pool<T0, T1>>(arg4), 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_pool_base_a::cetus_total_xtokens<T0, T1>(arg4));
        0x2::vec_map::insert<0x2::object::ID, u256>(&mut arg2.cur_acc_per_xtokens, 0x2::object::id<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_pool_base_a::Pool<T0, T1>>(arg4), 0);
    }

    public fun collect_position_sui<T0, T1>(arg0: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::AdminCap, arg1: &0x3d4154629dfd823f9608108c50b1559dbe7d3a7102176b9138c39c255b03bfc::version::Version, arg2: &mut CetusCompensator, arg3: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_sui_investor::Investor<T0, T1>, arg4: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_sui_pool::Pool<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
        0x3d4154629dfd823f9608108c50b1559dbe7d3a7102176b9138c39c255b03bfc::version::assert_current_version(arg1);
        let v0 = 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_sui_investor::remove_old_position<T0, T1>(arg0, arg3);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_attacked_position<T0, T1>(arg5, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0)), 3);
        0x2::vec_map::insert<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg2.old_positions, 0x2::object::id<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_sui_pool::Pool<T0, T1>>(arg4), v0);
        0x2::vec_map::insert<0x2::object::ID, u256>(&mut arg2.total_xtokens, 0x2::object::id<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_sui_pool::Pool<T0, T1>>(arg4), 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_sui_pool::cetus_total_xtokens<T0, T1>(arg4));
        0x2::vec_map::insert<0x2::object::ID, u256>(&mut arg2.cur_acc_per_xtokens, 0x2::object::id<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_sui_pool::Pool<T0, T1>>(arg4), 0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CetusCompensator{
            id                        : 0x2::object::new(arg0),
            old_positions             : 0x2::vec_map::empty<0x2::object::ID, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(),
            cur_acc_per_xtokens       : 0x2::vec_map::empty<0x2::object::ID, u256>(),
            user_last_acc_per_xtokens : 0x2::vec_map::empty<0x2::object::ID, u256>(),
            total_xtokens             : 0x2::vec_map::empty<0x2::object::ID, u256>(),
            cetus_balance             : 0x2::balance::zero<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(),
        };
        0x2::transfer::share_object<CetusCompensator>(v0);
    }

    public fun user_collect_cetus_compensation<T0, T1>(arg0: &0x3d4154629dfd823f9608108c50b1559dbe7d3a7102176b9138c39c255b03bfc::version::Version, arg1: &mut CetusCompensator, arg2: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_pool::Receipt, arg3: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_pool::Pool<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS> {
        0x3d4154629dfd823f9608108c50b1559dbe7d3a7102176b9138c39c255b03bfc::version::assert_current_version(arg0);
        let v0 = 0x2::object::id<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_pool::Receipt>(arg2);
        assert!(0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_pool::get_pool_id_from_receipt(arg2) == 0x2::object::id<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_pool::Pool<T0, T1>>(arg3), 1);
        let v1 = 0x2::object::id<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_pool::Pool<T0, T1>>(arg3);
        let v2 = *0x2::vec_map::get<0x2::object::ID, u256>(&arg1.cur_acc_per_xtokens, &v1);
        if (!0x2::vec_map::contains<0x2::object::ID, u256>(&arg1.user_last_acc_per_xtokens, &v0)) {
            0x2::vec_map::insert<0x2::object::ID, u256>(&mut arg1.user_last_acc_per_xtokens, v0, 0);
        };
        let v3 = 0x2::vec_map::get_mut<0x2::object::ID, u256>(&mut arg1.user_last_acc_per_xtokens, &v0);
        let v4 = (((v2 - *v3) * (0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_pool::get_user_cetus_compensation_share<T0, T1>(arg3, arg2, arg4) as u256) / (1000000000000000000000000000000000000 as u256)) as u64);
        *v3 = v2;
        assert!(0x2::balance::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&arg1.cetus_balance) >= v4, 2);
        0x2::coin::from_balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(0x2::balance::split<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut arg1.cetus_balance, v4), arg4)
    }

    public fun user_collect_cetus_compensation_base_a<T0, T1>(arg0: &0x3d4154629dfd823f9608108c50b1559dbe7d3a7102176b9138c39c255b03bfc::version::Version, arg1: &mut CetusCompensator, arg2: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_pool_base_a::Receipt, arg3: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_pool_base_a::Pool<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS> {
        0x3d4154629dfd823f9608108c50b1559dbe7d3a7102176b9138c39c255b03bfc::version::assert_current_version(arg0);
        let v0 = 0x2::object::id<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_pool_base_a::Receipt>(arg2);
        assert!(0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_pool_base_a::get_pool_id_from_receipt(arg2) == 0x2::object::id<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_pool_base_a::Pool<T0, T1>>(arg3), 1);
        let v1 = 0x2::object::id<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_pool_base_a::Pool<T0, T1>>(arg3);
        let v2 = *0x2::vec_map::get<0x2::object::ID, u256>(&arg1.cur_acc_per_xtokens, &v1);
        if (!0x2::vec_map::contains<0x2::object::ID, u256>(&arg1.user_last_acc_per_xtokens, &v0)) {
            0x2::vec_map::insert<0x2::object::ID, u256>(&mut arg1.user_last_acc_per_xtokens, v0, 0);
        };
        let v3 = 0x2::vec_map::get_mut<0x2::object::ID, u256>(&mut arg1.user_last_acc_per_xtokens, &v0);
        let v4 = (((v2 - *v3) * (0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_pool_base_a::get_user_cetus_compensation_share<T0, T1>(arg3, arg2, arg4) as u256) / (1000000000000000000000000000000000000 as u256)) as u64);
        *v3 = v2;
        assert!(0x2::balance::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&arg1.cetus_balance) >= v4, 2);
        0x2::coin::from_balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(0x2::balance::split<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut arg1.cetus_balance, v4), arg4)
    }

    public fun user_collect_cetus_compensation_sui<T0, T1>(arg0: &0x3d4154629dfd823f9608108c50b1559dbe7d3a7102176b9138c39c255b03bfc::version::Version, arg1: &mut CetusCompensator, arg2: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_sui_pool::Receipt, arg3: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_sui_pool::Pool<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS> {
        0x3d4154629dfd823f9608108c50b1559dbe7d3a7102176b9138c39c255b03bfc::version::assert_current_version(arg0);
        let v0 = 0x2::object::id<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_sui_pool::Receipt>(arg2);
        assert!(0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_sui_pool::get_pool_id_from_receipt(arg2) == 0x2::object::id<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_sui_pool::Pool<T0, T1>>(arg3), 1);
        let v1 = 0x2::object::id<0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_sui_pool::Pool<T0, T1>>(arg3);
        let v2 = *0x2::vec_map::get<0x2::object::ID, u256>(&arg1.cur_acc_per_xtokens, &v1);
        if (!0x2::vec_map::contains<0x2::object::ID, u256>(&arg1.user_last_acc_per_xtokens, &v0)) {
            0x2::vec_map::insert<0x2::object::ID, u256>(&mut arg1.user_last_acc_per_xtokens, v0, 0);
        };
        let v3 = 0x2::vec_map::get_mut<0x2::object::ID, u256>(&mut arg1.user_last_acc_per_xtokens, &v0);
        let v4 = (((v2 - *v3) * (0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphafi_cetus_sui_pool::get_user_cetus_compensation_share<T0, T1>(arg3, arg2, arg4) as u256) / (1000000000000000000000000000000000000 as u256)) as u64);
        *v3 = v2;
        assert!(0x2::balance::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&arg1.cetus_balance) >= v4, 2);
        0x2::coin::from_balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(0x2::balance::split<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut arg1.cetus_balance, v4), arg4)
    }

    // decompiled from Move bytecode v6
}

