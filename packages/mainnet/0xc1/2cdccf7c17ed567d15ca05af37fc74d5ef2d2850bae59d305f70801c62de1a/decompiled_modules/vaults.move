module 0x5ed6cff2d8c1f697b3742f0fcc67337bfd33b574ae4382305d2beda28997ef9::vaults {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VaultsManager has store, key {
        id: 0x2::object::UID,
        index: u64,
        package_version: u64,
        vault_to_pool_maps: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        acl: 0x5ed6cff2d8c1f697b3742f0fcc67337bfd33b574ae4382305d2beda28997ef9::acl::ACL,
    }

    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
        liquidity: u128,
        protocol_fee_rate: u64,
        is_pause: bool,
        positions: vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
        lp_token_treasury: 0x2::coin::TreasuryCap<T0>,
        harvest_assets: 0x2::bag::Bag,
        protocol_fees: 0x2::bag::Bag,
        max_quota: u128,
        status: u8,
        quota_based_type: 0x1::type_name::TypeName,
    }

    struct InitEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
        manager_id: 0x2::object::ID,
    }

    struct CreateEvent has copy, drop {
        id: 0x2::object::ID,
        clmm_pool: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
        lp_token_treasury: 0x2::object::ID,
    }

    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        before_liquidity: u128,
        delta_liquidity: u128,
        before_supply: u64,
        lp_amount: u64,
    }

    struct RemoveEvent has copy, drop {
        vault_id: 0x2::object::ID,
        lp_amount: u64,
        liquidity: u128,
        amount_a: u64,
        amount_b: u64,
        protocol_fee_a_amount: u64,
        protocol_fee_b_amount: u64,
    }

    struct ReinvestEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        remaining_amount: u64,
        delta_liquidity: u128,
        current_sqrt_price: u128,
    }

    struct FinishRebalanceEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        remaining_amount_a: u64,
        remaining_amount_b: u64,
        delta_liquidity: u128,
        current_sqrt_price: u128,
    }

    struct RebalanceRewarderEvent has copy, drop {
        vault_id: 0x2::object::ID,
        rewarder: 0x1::type_name::TypeName,
        rebalance_to_type: 0x1::type_name::TypeName,
        rewarder_amount: u64,
        amount: u64,
    }

    struct RebalanceEvent has copy, drop {
        vault_id: 0x2::object::ID,
        old_position: 0x2::object::ID,
        new_position: 0x2::object::ID,
        remaining_amount: u64,
        old_tick_lower: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        old_tick_upper: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        old_liquidity: u128,
        current_sqrt_price: u128,
        tick_lower: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        tick_upper: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
    }

    struct FeeClaimedEvent has copy, drop {
        amount_a: u64,
        amount_b: u64,
        vault_id: 0x2::object::ID,
    }

    struct RewarderClaimedEvent has copy, drop {
        amount: u64,
        rewarder_type: 0x1::type_name::TypeName,
        vault_id: 0x2::object::ID,
    }

    struct PauseEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct UnpauseEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct UpdateFeeRateEvent has copy, drop {
        old_fee_rate: u64,
        new_fee_rate: u64,
    }

    struct ClaimProtocolFeeEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        type_name: 0x1::type_name::TypeName,
    }

    struct SetPackageVersion has copy, drop {
        new_version: u64,
        old_version: u64,
    }

    struct SetRolesEvent has copy, drop {
        member: address,
        roles: u128,
    }

    struct AddRoleEvent has copy, drop {
        member: address,
        role: u8,
    }

    struct RemoveRoleEvent has copy, drop {
        member: address,
        role: u8,
    }

    struct RemoveMemberEvent has copy, drop {
        member: address,
    }

    struct UpdateMaxQuotaEvent has copy, drop {
        vault_id: 0x2::object::ID,
        old_quota: u128,
        new_quota: u128,
    }

    public fun remove<T0, T1, T2>(arg0: &VaultsManager, arg1: &mut Vault<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x2::coin::Coin<T2>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        checked_package_version(arg0);
        assert!(!arg1.is_pause, 6);
        assert!(arg1.status == 1, 17);
        assert!(arg5 > 0, 5);
        assert!(0x2::coin::value<T2>(arg4) >= arg5, 9);
        assert!(0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.positions) == 1, 2);
        let v0 = 0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.positions, 0);
        let v1 = get_share_liquidity_by_amount(arg5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v0), total_token_amount<T2>(arg1));
        arg1.liquidity = arg1.liquidity - v1;
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg2, arg3, v0, v1, arg8);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::balance::value<T0>(&v5);
        let v7 = 0x2::balance::value<T1>(&v4);
        let v8 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_ceil(0x2::balance::value<T0>(&v5), arg1.protocol_fee_rate, 10000);
        let v9 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_ceil(0x2::balance::value<T1>(&v4), arg1.protocol_fee_rate, 10000);
        assert!(v6 - v8 >= arg6, 1);
        assert!(v7 - v9 >= arg7, 1);
        let v10 = RemoveEvent{
            vault_id              : 0x2::object::id<Vault<T2>>(arg1),
            lp_amount             : arg5,
            liquidity             : v1,
            amount_a              : v6,
            amount_b              : v7,
            protocol_fee_a_amount : v8,
            protocol_fee_b_amount : v9,
        };
        0x2::event::emit<RemoveEvent>(v10);
        merge_protocol_asset<T0, T2>(arg1, 0x2::balance::split<T0>(&mut v5, v8));
        merge_protocol_asset<T1, T2>(arg1, 0x2::balance::split<T1>(&mut v4, v9));
        0x2::coin::burn<T2>(&mut arg1.lp_token_treasury, 0x2::coin::split<T2>(arg4, arg5, arg9));
        (0x2::coin::from_balance<T0>(v5, arg9), 0x2::coin::from_balance<T1>(v4, arg9))
    }

    public fun add_role(arg0: &AdminCap, arg1: &mut VaultsManager, arg2: address, arg3: u8) {
        checked_package_version(arg1);
        0x5ed6cff2d8c1f697b3742f0fcc67337bfd33b574ae4382305d2beda28997ef9::acl::add_role(&mut arg1.acl, arg2, arg3);
        let v0 = AddRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<AddRoleEvent>(v0);
    }

    public fun remove_member(arg0: &AdminCap, arg1: &mut VaultsManager, arg2: address) {
        checked_package_version(arg1);
        0x5ed6cff2d8c1f697b3742f0fcc67337bfd33b574ae4382305d2beda28997ef9::acl::remove_member(&mut arg1.acl, arg2);
        let v0 = RemoveMemberEvent{member: arg2};
        0x2::event::emit<RemoveMemberEvent>(v0);
    }

    public fun remove_role(arg0: &AdminCap, arg1: &mut VaultsManager, arg2: address, arg3: u8) {
        checked_package_version(arg1);
        0x5ed6cff2d8c1f697b3742f0fcc67337bfd33b574ae4382305d2beda28997ef9::acl::remove_role(&mut arg1.acl, arg2, arg3);
        let v0 = RemoveRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<RemoveRoleEvent>(v0);
    }

    public fun set_roles(arg0: &AdminCap, arg1: &mut VaultsManager, arg2: address, arg3: u128) {
        checked_package_version(arg1);
        0x5ed6cff2d8c1f697b3742f0fcc67337bfd33b574ae4382305d2beda28997ef9::acl::set_roles(&mut arg1.acl, arg2, arg3);
        let v0 = SetRolesEvent{
            member : arg2,
            roles  : arg3,
        };
        0x2::event::emit<SetRolesEvent>(v0);
    }

    fun calculate_updated_quota<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: 0x1::type_name::TypeName, arg2: u128, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg4: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg5: u64, arg6: u64) : u128 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0);
        let (v1, v2) = 0x5ed6cff2d8c1f697b3742f0fcc67337bfd33b574ae4382305d2beda28997ef9::utils::get_amount_by_liquidity(arg3, arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0), v0, arg2, true);
        assert!(0x1::type_name::get<T0>() == arg1 || 0x1::type_name::get<T1>() == arg1, 19);
        let v3 = 0x1::type_name::get<T0>() == arg1;
        get_tvl_of_based_coin(v0, v1 + arg5, v2 + arg6, v3)
    }

    public fun check_pool_manager_role(arg0: &VaultsManager, arg1: address) {
        assert!(0x5ed6cff2d8c1f697b3742f0fcc67337bfd33b574ae4382305d2beda28997ef9::acl::has_role(&arg0.acl, arg1, 2), 13);
    }

    public fun check_protocol_fee_claim_role(arg0: &VaultsManager, arg1: address) {
        assert!(0x5ed6cff2d8c1f697b3742f0fcc67337bfd33b574ae4382305d2beda28997ef9::acl::has_role(&arg0.acl, arg1, 0), 11);
    }

    public fun check_reinvest_role(arg0: &VaultsManager, arg1: address) {
        assert!(0x5ed6cff2d8c1f697b3742f0fcc67337bfd33b574ae4382305d2beda28997ef9::acl::has_role(&arg0.acl, arg1, 1), 12);
    }

    public fun checked_package_version(arg0: &VaultsManager) {
        assert!(1 >= arg0.package_version, 3);
    }

    public fun claim_protocol_fee<T0, T1>(arg0: &VaultsManager, arg1: &mut Vault<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_protocol_fee_claim_role(arg0, 0x2::tx_context::sender(arg2));
        let v0 = take_protocol_asset<T0, T1>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg2), 0x2::tx_context::sender(arg2));
        let v1 = ClaimProtocolFeeEvent{
            vault_id  : 0x2::object::id<Vault<T1>>(arg1),
            amount    : 0x2::balance::value<T0>(&v0),
            type_name : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ClaimProtocolFeeEvent>(v1);
    }

    public fun collect_fee<T0, T1, T2>(arg0: &VaultsManager, arg1: &mut Vault<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_reinvest_role(arg0, 0x2::tx_context::sender(arg4));
        assert!(!arg1.is_pause, 6);
        assert!(0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.positions) == 1, 2);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg3, 0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.positions, 0), true);
        let v2 = v1;
        let v3 = v0;
        merge_harvest_asset<T0, T2>(arg1, v3);
        merge_harvest_asset<T1, T2>(arg1, v2);
        let v4 = FeeClaimedEvent{
            amount_a : 0x2::balance::value<T0>(&v3),
            amount_b : 0x2::balance::value<T1>(&v2),
            vault_id : 0x2::object::id<Vault<T2>>(arg1),
        };
        0x2::event::emit<FeeClaimedEvent>(v4);
    }

    public entry fun collect_fee_v2<T0, T1, T2, T3>(arg0: &VaultsManager, arg1: &mut Vault<T2>, arg2: &mut Vault<T3>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_reinvest_role(arg0, 0x2::tx_context::sender(arg5));
        assert!(!arg1.is_pause, 6);
        assert!(0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.positions) == 1, 2);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg3, arg4, 0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.positions, 0), true);
        let v2 = v1;
        let v3 = v0;
        merge_harvest_asset<T0, T3>(arg2, v3);
        merge_harvest_asset<T1, T3>(arg2, v2);
        let v4 = FeeClaimedEvent{
            amount_a : 0x2::balance::value<T0>(&v3),
            amount_b : 0x2::balance::value<T1>(&v2),
            vault_id : 0x2::object::id<Vault<T2>>(arg1),
        };
        0x2::event::emit<FeeClaimedEvent>(v4);
    }

    public fun collect_rewarder<T0, T1, T2, T3>(arg0: &VaultsManager, arg1: &mut Vault<T3>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_reinvest_role(arg0, 0x2::tx_context::sender(arg6));
        assert!(!arg1.is_pause, 6);
        assert!(0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.positions) == 1, 2);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg2, arg3, 0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.positions, 0), arg4, true, arg5);
        merge_harvest_asset<T2, T3>(arg1, v0);
        let v1 = RewarderClaimedEvent{
            amount        : 0x2::balance::value<T2>(&v0),
            rewarder_type : 0x1::type_name::get<T2>(),
            vault_id      : 0x2::object::id<Vault<T3>>(arg1),
        };
        0x2::event::emit<RewarderClaimedEvent>(v1);
    }

    public entry fun collect_rewarder_v2<T0, T1, T2, T3, T4>(arg0: &VaultsManager, arg1: &mut Vault<T3>, arg2: &mut Vault<T4>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_reinvest_role(arg0, 0x2::tx_context::sender(arg7));
        assert!(!arg1.is_pause, 6);
        assert!(0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.positions) == 1, 2);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg3, arg4, 0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.positions, 0), arg5, true, arg6);
        merge_harvest_asset<T2, T4>(arg2, v0);
        let v1 = RewarderClaimedEvent{
            amount        : 0x2::balance::value<T2>(&v0),
            rewarder_type : 0x1::type_name::get<T2>(),
            vault_id      : 0x2::object::id<Vault<T3>>(arg1),
        };
        0x2::event::emit<RewarderClaimedEvent>(v1);
    }

    public(friend) fun create_vault<T0, T1, T2>(arg0: &mut VaultsManager, arg1: 0x2::coin::TreasuryCap<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u32, arg5: u32, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_pool_manager_role(arg0, 0x2::tx_context::sender(arg7));
        assert!(0x2::coin::total_supply<T2>(&arg1) == 0, 14);
        let v0 = if (arg6) {
            0x1::type_name::get<T0>()
        } else {
            0x1::type_name::get<T1>()
        };
        let v1 = 0x1::vector::empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>();
        0x1::vector::push_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg2, arg3, arg4, arg5, arg7));
        let v2 = Vault<T2>{
            id                : 0x2::object::new(arg7),
            pool              : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3),
            liquidity         : 0,
            protocol_fee_rate : 0,
            is_pause          : false,
            positions         : v1,
            lp_token_treasury : arg1,
            harvest_assets    : 0x2::bag::new(arg7),
            protocol_fees     : 0x2::bag::new(arg7),
            max_quota         : 0,
            status            : 1,
            quota_based_type  : v0,
        };
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.vault_to_pool_maps, 0x2::object::id<Vault<T2>>(&v2), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3));
        let v3 = CreateEvent{
            id                : 0x2::object::id<Vault<T2>>(&v2),
            clmm_pool         : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3),
            tick_lower        : arg4,
            tick_upper        : arg5,
            lp_token_treasury : 0x2::object::id<0x2::coin::TreasuryCap<T2>>(&arg1),
        };
        0x2::event::emit<CreateEvent>(v3);
        0x2::transfer::share_object<Vault<T2>>(v2);
    }

    public(friend) fun deposit<T0, T1, T2>(arg0: &VaultsManager, arg1: &mut Vault<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        assert!(!arg1.is_pause, 6);
        assert!(arg1.status == 1, 17);
        assert!(0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.positions) == 1, 2);
        let v0 = total_token_amount<T2>(arg1);
        let v1 = 0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.positions, 0);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v1);
        let v3 = if (arg8) {
            arg6
        } else {
            arg7
        };
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg2, arg3, v1, v3, arg8, arg9);
        if (arg1.max_quota != 0) {
            let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v4);
            let (v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(v1);
            assert!(calculate_updated_quota<T0, T1>(arg3, arg1.quota_based_type, arg1.liquidity, v7, v8, v5, v6) <= arg1.max_quota, 16);
        };
        0x5ed6cff2d8c1f697b3742f0fcc67337bfd33b574ae4382305d2beda28997ef9::utils::repay_add_liquidity<T0, T1>(arg2, arg3, v4, arg4, arg5, arg6, arg7, arg10);
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v1) - v2;
        arg1.liquidity = arg1.liquidity + v9;
        let v10 = get_lp_amount_by_liquidity(v0, v9, v2);
        assert!(v10 > 0, 5);
        assert!(v10 < 18446744073709551615 - (v0 as u128), 4);
        0x2::coin::mint_and_transfer<T2>(&mut arg1.lp_token_treasury, (v10 as u64), 0x2::tx_context::sender(arg10), arg10);
        let v11 = DepositEvent{
            vault_id         : 0x2::object::id<Vault<T2>>(arg1),
            before_liquidity : v2,
            delta_liquidity  : v9,
            before_supply    : v0,
            lp_amount        : (v10 as u64),
        };
        0x2::event::emit<DepositEvent>(v11);
    }

    public fun finish_rebalance<T0, T1, T2>(arg0: &VaultsManager, arg1: &mut Vault<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: bool, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_reinvest_role(arg0, 0x2::tx_context::sender(arg11));
        assert!(!arg1.is_pause, 6);
        assert!(arg1.status == 2, 18);
        assert!(0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.positions) == 1, 2);
        if (arg9) {
            arg1.status = 1;
        };
        let v0 = take_harvest_asset<T0, T2>(arg1);
        let v1 = 0x2::coin::from_balance<T0>(v0, arg11);
        let v2 = take_harvest_asset<T1, T2>(arg1);
        let v3 = 0x2::coin::from_balance<T1>(v2, arg11);
        let v4 = 0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.positions, 0);
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v4);
        let (v6, v7) = rebalance_and_add_liquidity_v2<T0, T1>(v4, v1, v3, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg10, arg11);
        let v8 = v7;
        let v9 = v6;
        let v10 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v4) - v5;
        arg1.liquidity = arg1.liquidity + v10;
        let v11 = FinishRebalanceEvent{
            vault_id           : 0x2::object::id<Vault<T2>>(arg1),
            amount_a           : 0x2::coin::value<T0>(&v1),
            amount_b           : 0x2::coin::value<T1>(&v3),
            remaining_amount_a : 0x2::coin::value<T0>(&v9),
            remaining_amount_b : 0x2::coin::value<T1>(&v8),
            delta_liquidity    : v10,
            current_sqrt_price : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3),
        };
        0x2::event::emit<FinishRebalanceEvent>(v11);
        merge_harvest_asset<T0, T2>(arg1, 0x2::coin::into_balance<T0>(v9));
        merge_harvest_asset<T1, T2>(arg1, 0x2::coin::into_balance<T1>(v8));
    }

    fun get_lp_amount_by_liquidity(arg0: u64, arg1: u128, arg2: u128) : u128 {
        if (arg0 == 0) {
            return arg1
        };
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((arg0 as u128), arg1, arg2)
    }

    public fun get_position_amounts<T0, T1, T2>(arg0: &Vault<T2>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64) : (u64, u64) {
        assert!(0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions) == 1, 2);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(0x1::vector::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions, 0));
        0x5ed6cff2d8c1f697b3742f0fcc67337bfd33b574ae4382305d2beda28997ef9::utils::get_amount_by_liquidity(v0, v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), (arg2 as u128), false)
    }

    fun get_share_liquidity_by_amount(arg0: u64, arg1: u128, arg2: u64) : u128 {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((arg0 as u128), arg1, (arg2 as u128))
    }

    fun get_tvl_of_based_coin(arg0: u128, arg1: u64, arg2: u64, arg3: bool) : u128 {
        let v0 = (arg0 as u256) * 100000000000000000000 / 18446744073709551616;
        if (arg3) {
            (arg1 as u128) + (((arg2 as u256) * 100000000000000000000 / v0 * v0 / 100000000000000000000) as u128)
        } else {
            (arg2 as u128) + (((arg1 as u256) * v0 * v0 / 100000000000000000000 / 100000000000000000000) as u128)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = VaultsManager{
            id                 : 0x2::object::new(arg0),
            index              : 0,
            package_version    : 1,
            vault_to_pool_maps : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg0),
            acl                : 0x5ed6cff2d8c1f697b3742f0fcc67337bfd33b574ae4382305d2beda28997ef9::acl::new(arg0),
        };
        let v2 = InitEvent{
            admin_cap_id : 0x2::object::id<AdminCap>(&v0),
            manager_id   : 0x2::object::id<VaultsManager>(&v1),
        };
        0x2::event::emit<InitEvent>(v2);
        let v3 = &mut v1;
        set_roles(&v0, v3, 0x2::tx_context::sender(arg0), 0 | 1 << 2 | 1 << 1 | 1 << 0);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<VaultsManager>(v1);
    }

    fun merge_harvest_asset<T0, T1>(arg0: &mut Vault<T1>, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (0x2::bag::contains<0x1::string::String>(&arg0.harvest_assets, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.harvest_assets, v0), arg1);
        } else {
            0x2::bag::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.harvest_assets, v0, arg1);
        };
    }

    fun merge_protocol_asset<T0, T1>(arg0: &mut Vault<T1>, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (0x2::bag::contains<0x1::string::String>(&arg0.protocol_fees, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.protocol_fees, v0), arg1);
        } else {
            0x2::bag::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.protocol_fees, v0, arg1);
        };
    }

    public fun package_version() : u64 {
        1
    }

    public fun pause<T0>(arg0: &VaultsManager, arg1: &mut Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        arg1.is_pause = true;
        let v0 = PauseEvent{vault_id: 0x2::object::id<Vault<T0>>(arg1)};
        0x2::event::emit<PauseEvent>(v0);
    }

    public fun rebalance<T0, T1, T2>(arg0: &VaultsManager, arg1: &mut Vault<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u64, arg5: u64, arg6: u32, arg7: u32, arg8: bool, arg9: u64, arg10: u64, arg11: bool, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_reinvest_role(arg0, 0x2::tx_context::sender(arg13));
        assert!(!arg1.is_pause, 6);
        assert!(0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.positions) == 1, 2);
        let v0 = 0x1::vector::pop_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.positions);
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(&v0);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3);
        let (v4, v5) = 0x5ed6cff2d8c1f697b3742f0fcc67337bfd33b574ae4382305d2beda28997ef9::utils::close_position<T0, T1>(arg2, arg3, v0, arg4, arg5, arg12);
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg2, arg3, arg6, arg7, arg13);
        let (v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(&v6);
        let v9 = &mut v6;
        let v10 = 0x2::coin::from_balance<T0>(v4, arg13);
        let v11 = 0x2::coin::from_balance<T1>(v5, arg13);
        let (v12, v13) = rebalance_and_add_liquidity<T0, T1>(v9, v10, v11, arg2, arg3, arg8, arg9, arg10, arg11, arg12, arg13);
        let v14 = v13;
        let v15 = v12;
        arg1.liquidity = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v6);
        let v16 = if (arg11) {
            0x2::coin::value<T1>(&v14)
        } else {
            0x2::coin::value<T0>(&v15)
        };
        let v17 = RebalanceEvent{
            vault_id           : 0x2::object::id<Vault<T2>>(arg1),
            old_position       : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0),
            new_position       : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v6),
            remaining_amount   : v16,
            old_tick_lower     : v1,
            old_tick_upper     : v2,
            old_liquidity      : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v0),
            current_sqrt_price : v3,
            tick_lower         : v7,
            tick_upper         : v8,
        };
        0x2::event::emit<RebalanceEvent>(v17);
        merge_harvest_asset<T0, T2>(arg1, 0x2::coin::into_balance<T0>(v15));
        merge_harvest_asset<T1, T2>(arg1, 0x2::coin::into_balance<T1>(v14));
        0x1::vector::push_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.positions, v6);
    }

    fun rebalance_and_add_liquidity<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: bool, arg6: u64, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = if (arg5) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let (v1, v2) = if (arg6 == 0) {
            let v3 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v3, arg1);
            let v4 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
            0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v4, arg2);
            (0x5ed6cff2d8c1f697b3742f0fcc67337bfd33b574ae4382305d2beda28997ef9::utils::merge_coins<T0>(v3, arg10), 0x5ed6cff2d8c1f697b3742f0fcc67337bfd33b574ae4382305d2beda28997ef9::utils::merge_coins<T1>(v4, arg10))
        } else {
            let v5 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v5, arg1);
            let v6 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
            0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v6, arg2);
            0x5ed6cff2d8c1f697b3742f0fcc67337bfd33b574ae4382305d2beda28997ef9::utils::swap<T0, T1>(arg3, arg4, v5, v6, arg5, true, arg6, arg7, v0, arg9, arg10)
        };
        let v7 = v2;
        let v8 = v1;
        let v9 = 0x2::coin::value<T0>(&v8);
        let v10 = 0x2::coin::value<T1>(&v7);
        let v11 = if (arg8) {
            v9
        } else {
            v10
        };
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg3, arg4, arg0, v11, arg8, arg9);
        let (v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v12);
        if (arg8) {
            assert!(v13 == v9, 8);
            assert!(v14 <= v10, 8);
        } else {
            assert!(v13 <= v9, 8);
            assert!(v14 == v10, 8);
        };
        let (v15, v16, v17, v18) = if (arg8) {
            (0x2::coin::zero<T0>(arg10), v7, 0x2::coin::into_balance<T0>(v8), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v7, v14, arg10)))
        } else {
            (v8, 0x2::coin::zero<T1>(arg10), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v8, v13, arg10)), 0x2::coin::into_balance<T1>(v7))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg3, arg4, v17, v18, v12);
        (v15, v16)
    }

    fun rebalance_and_add_liquidity_v2<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: bool, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = if (arg5) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let (v1, v2) = if (arg6 == 0) {
            (arg1, arg2)
        } else {
            let v3 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v3, arg1);
            let v4 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
            0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v4, arg2);
            0x5ed6cff2d8c1f697b3742f0fcc67337bfd33b574ae4382305d2beda28997ef9::utils::swap<T0, T1>(arg3, arg4, v3, v4, arg5, true, arg6, arg7, v0, arg10, arg11)
        };
        let v5 = v2;
        let v6 = v1;
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg3, arg4, arg0, arg8, arg9, arg10);
        let (v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v7);
        if (arg9) {
            assert!(v8 == arg8, 8);
            assert!(v9 <= 0x2::coin::value<T1>(&v5), 8);
        } else {
            assert!(v8 <= 0x2::coin::value<T0>(&v6), 8);
            assert!(v9 == arg8, 8);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg3, arg4, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v6, v8, arg11)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v5, v9, arg11)), v7);
        (v6, v5)
    }

    public fun rebalance_v2<T0, T1, T2>(arg0: &VaultsManager, arg1: &mut Vault<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u64, arg5: u64, arg6: u32, arg7: u32, arg8: u64, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_reinvest_role(arg0, 0x2::tx_context::sender(arg11));
        assert!(!arg1.is_pause, 6);
        assert!(0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.positions) == 1, 2);
        arg1.status = 2;
        let v0 = 0x1::vector::pop_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.positions);
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(&v0);
        let (v3, v4) = 0x5ed6cff2d8c1f697b3742f0fcc67337bfd33b574ae4382305d2beda28997ef9::utils::close_position<T0, T1>(arg2, arg3, v0, arg4, arg5, arg10);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg2, arg3, arg6, arg7, arg11);
        let (v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(&v7);
        let v10 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg2, arg3, &mut v7, arg8, arg9, arg10);
        let (v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v10);
        if (arg9) {
            assert!(v11 == arg8, 8);
            assert!(v12 <= 0x2::balance::value<T1>(&v5), 8);
        } else {
            assert!(v11 <= 0x2::balance::value<T0>(&v6), 8);
            assert!(v12 == arg8, 8);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg2, arg3, 0x2::balance::split<T0>(&mut v6, v11), 0x2::balance::split<T1>(&mut v5, v12), v10);
        arg1.liquidity = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v7);
        let v13 = if (arg9) {
            assert!(0x2::balance::value<T0>(&v6) == 0, 8);
            0x2::balance::value<T1>(&v5)
        } else {
            assert!(0x2::balance::value<T1>(&v5) == 0, 8);
            0x2::balance::value<T0>(&v6)
        };
        let v14 = RebalanceEvent{
            vault_id           : 0x2::object::id<Vault<T2>>(arg1),
            old_position       : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0),
            new_position       : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v7),
            remaining_amount   : v13,
            old_tick_lower     : v1,
            old_tick_upper     : v2,
            old_liquidity      : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v0),
            current_sqrt_price : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3),
            tick_lower         : v8,
            tick_upper         : v9,
        };
        0x2::event::emit<RebalanceEvent>(v14);
        merge_harvest_asset<T0, T2>(arg1, v6);
        merge_harvest_asset<T1, T2>(arg1, v5);
        0x1::vector::push_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.positions, v7);
    }

    public fun reinvest<T0, T1, T2>(arg0: &VaultsManager, arg1: &mut Vault<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: bool, arg5: u64, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_reinvest_role(arg0, 0x2::tx_context::sender(arg9));
        assert!(!arg1.is_pause, 6);
        assert!(arg1.status == 1, 17);
        assert!(0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.positions) == 1, 2);
        let v0 = take_harvest_asset<T0, T2>(arg1);
        let v1 = 0x2::coin::from_balance<T0>(v0, arg9);
        let v2 = take_harvest_asset<T1, T2>(arg1);
        let v3 = 0x2::coin::from_balance<T1>(v2, arg9);
        let v4 = 0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.positions, 0);
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v4);
        let (v6, v7) = rebalance_and_add_liquidity<T0, T1>(v4, v1, v3, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v8 = v7;
        let v9 = v6;
        let v10 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v4) - v5;
        arg1.liquidity = arg1.liquidity + v10;
        let v11 = if (arg7) {
            0x2::coin::value<T1>(&v8)
        } else {
            0x2::coin::value<T0>(&v9)
        };
        let v12 = ReinvestEvent{
            vault_id           : 0x2::object::id<Vault<T2>>(arg1),
            amount_a           : 0x2::coin::value<T0>(&v1),
            amount_b           : 0x2::coin::value<T1>(&v3),
            remaining_amount   : v11,
            delta_liquidity    : v10,
            current_sqrt_price : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3),
        };
        0x2::event::emit<ReinvestEvent>(v12);
        merge_harvest_asset<T0, T2>(arg1, 0x2::coin::into_balance<T0>(v9));
        merge_harvest_asset<T1, T2>(arg1, 0x2::coin::into_balance<T1>(v8));
    }

    public fun rewarder_swap<T0, T1, T2>(arg0: &VaultsManager, arg1: &mut Vault<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_reinvest_role(arg0, 0x2::tx_context::sender(arg8));
        assert!(!arg1.is_pause, 6);
        assert!(0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.positions) == 1, 2);
        let (v0, v1, v2, v3) = if (arg4) {
            let v4 = take_harvest_asset_by_amount<T0, T2>(arg1, arg5);
            let v5 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v5, 0x2::coin::from_balance<T0>(v4, arg8));
            let (v6, v7) = 0x5ed6cff2d8c1f697b3742f0fcc67337bfd33b574ae4382305d2beda28997ef9::utils::swap<T0, T1>(arg2, arg3, v5, 0x1::vector::empty<0x2::coin::Coin<T1>>(), true, true, arg5, arg6, 4295048016, arg7, arg8);
            let v8 = v7;
            0x2::coin::destroy_zero<T0>(v6);
            merge_harvest_asset<T1, T2>(arg1, 0x2::coin::into_balance<T1>(v8));
            (0x2::balance::value<T0>(&v4), 0x2::coin::value<T1>(&v8), 0x1::type_name::get<T1>(), 0x1::type_name::get<T0>())
        } else {
            let v9 = take_harvest_asset_by_amount<T1, T2>(arg1, arg5);
            let v10 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
            0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v10, 0x2::coin::from_balance<T1>(v9, arg8));
            let (v11, v12) = 0x5ed6cff2d8c1f697b3742f0fcc67337bfd33b574ae4382305d2beda28997ef9::utils::swap<T0, T1>(arg2, arg3, 0x1::vector::empty<0x2::coin::Coin<T0>>(), v10, false, true, arg5, arg6, 79226673515401279992447579055, arg7, arg8);
            let v13 = v11;
            0x2::coin::destroy_zero<T1>(v12);
            merge_harvest_asset<T0, T2>(arg1, 0x2::coin::into_balance<T0>(v13));
            (0x2::balance::value<T1>(&v9), 0x2::coin::value<T0>(&v13), 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>())
        };
        let v14 = RebalanceRewarderEvent{
            vault_id          : 0x2::object::id<Vault<T2>>(arg1),
            rewarder          : v3,
            rebalance_to_type : v2,
            rewarder_amount   : v0,
            amount            : v1,
        };
        0x2::event::emit<RebalanceRewarderEvent>(v14);
    }

    public entry fun take_all<T0, T1>(arg0: &VaultsManager, arg1: &mut Vault<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        abort 1
    }

    fun take_harvest_asset<T0, T1>(arg0: &mut Vault<T1>) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (!0x2::bag::contains<0x1::string::String>(&arg0.harvest_assets, v0)) {
            return 0x2::balance::zero<T0>()
        };
        0x2::bag::remove<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.harvest_assets, v0)
    }

    fun take_harvest_asset_by_amount<T0, T1>(arg0: &mut Vault<T1>, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.harvest_assets, v0), 7);
        0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.harvest_assets, v0), arg1)
    }

    fun take_protocol_asset<T0, T1>(arg0: &mut Vault<T1>) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.protocol_fees, v0), 7);
        0x2::bag::remove<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.protocol_fees, v0)
    }

    public fun total_token_amount<T0>(arg0: &Vault<T0>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.lp_token_treasury)
    }

    public fun unpause<T0>(arg0: &VaultsManager, arg1: &mut Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        arg1.is_pause = false;
        let v0 = UnpauseEvent{vault_id: 0x2::object::id<Vault<T0>>(arg1)};
        0x2::event::emit<UnpauseEvent>(v0);
    }

    public fun update_max_quota<T0>(arg0: &VaultsManager, arg1: &mut Vault<T0>, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) {
        check_pool_manager_role(arg0, 0x2::tx_context::sender(arg3));
        assert!(!arg1.is_pause, 6);
        checked_package_version(arg0);
        arg1.max_quota = arg2;
        let v0 = UpdateMaxQuotaEvent{
            vault_id  : 0x2::object::id<Vault<T0>>(arg1),
            old_quota : arg1.max_quota,
            new_quota : arg2,
        };
        0x2::event::emit<UpdateMaxQuotaEvent>(v0);
    }

    public entry fun update_package_version(arg0: &AdminCap, arg1: &mut VaultsManager, arg2: u64) {
        let v0 = arg1.package_version;
        assert!(arg2 > v0, 15);
        arg1.package_version = arg2;
        let v1 = SetPackageVersion{
            new_version : arg2,
            old_version : v0,
        };
        0x2::event::emit<SetPackageVersion>(v1);
    }

    public fun update_protocol_fee_rate<T0>(arg0: &VaultsManager, arg1: &mut Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_pool_manager_role(arg0, 0x2::tx_context::sender(arg3));
        assert!(arg2 <= 2000, 10);
        assert!(!arg1.is_pause, 6);
        checked_package_version(arg0);
        arg1.protocol_fee_rate = arg2;
        let v0 = UpdateFeeRateEvent{
            old_fee_rate : arg1.protocol_fee_rate,
            new_fee_rate : arg2,
        };
        0x2::event::emit<UpdateFeeRateEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

