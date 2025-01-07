module 0xe24128e4d513803988fdcf75d0aa371d1efa0c90079472a6d58d772225d9fa3e::vaults {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VaultsManager has store, key {
        id: 0x2::object::UID,
        index: u64,
        package_version: u64,
        vault_to_pool_maps: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        acl: 0xe24128e4d513803988fdcf75d0aa371d1efa0c90079472a6d58d772225d9fa3e::acl::ACL,
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

    struct RebalanceRewarderEvent has copy, drop {
        vault_id: 0x2::object::ID,
        rewarder: 0x1::type_name::TypeName,
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

    public(friend) fun remove<T0, T1, T2>(arg0: &VaultsManager, arg1: &mut Vault<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x2::coin::Coin<T2>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        assert!(!arg1.is_pause, 6);
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
        0xe24128e4d513803988fdcf75d0aa371d1efa0c90079472a6d58d772225d9fa3e::utils::send_coin<T0>(0x2::coin::from_balance<T0>(v5, arg9), 0x2::tx_context::sender(arg9));
        0xe24128e4d513803988fdcf75d0aa371d1efa0c90079472a6d58d772225d9fa3e::utils::send_coin<T1>(0x2::coin::from_balance<T1>(v4, arg9), 0x2::tx_context::sender(arg9));
    }

    public fun collect_fee<T0, T1, T2>(arg0: &VaultsManager, arg1: &mut Vault<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_reinvest_role(arg0, 0x2::tx_context::sender(arg4));
        assert!(!arg1.is_pause, 6);
        assert!(0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.positions) == 1, 2);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg3, 0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.positions, 0), true);
        merge_harvest_asset<T0, T2>(arg1, v0);
        merge_harvest_asset<T1, T2>(arg1, v1);
    }

    public fun add_role(arg0: &AdminCap, arg1: &mut VaultsManager, arg2: address, arg3: u8) {
        checked_package_version(arg1);
        0xe24128e4d513803988fdcf75d0aa371d1efa0c90079472a6d58d772225d9fa3e::acl::add_role(&mut arg1.acl, arg2, arg3);
        let v0 = AddRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<AddRoleEvent>(v0);
    }

    public fun remove_member(arg0: &AdminCap, arg1: &mut VaultsManager, arg2: address) {
        checked_package_version(arg1);
        0xe24128e4d513803988fdcf75d0aa371d1efa0c90079472a6d58d772225d9fa3e::acl::remove_member(&mut arg1.acl, arg2);
        let v0 = RemoveMemberEvent{member: arg2};
        0x2::event::emit<RemoveMemberEvent>(v0);
    }

    public fun remove_role(arg0: &AdminCap, arg1: &mut VaultsManager, arg2: address, arg3: u8) {
        checked_package_version(arg1);
        0xe24128e4d513803988fdcf75d0aa371d1efa0c90079472a6d58d772225d9fa3e::acl::remove_role(&mut arg1.acl, arg2, arg3);
        let v0 = RemoveRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<RemoveRoleEvent>(v0);
    }

    public fun set_roles(arg0: &AdminCap, arg1: &mut VaultsManager, arg2: address, arg3: u128) {
        checked_package_version(arg1);
        0xe24128e4d513803988fdcf75d0aa371d1efa0c90079472a6d58d772225d9fa3e::acl::set_roles(&mut arg1.acl, arg2, arg3);
        let v0 = SetRolesEvent{
            member : arg2,
            roles  : arg3,
        };
        0x2::event::emit<SetRolesEvent>(v0);
    }

    public fun check_pool_manager_role(arg0: &VaultsManager, arg1: address) {
        assert!(0xe24128e4d513803988fdcf75d0aa371d1efa0c90079472a6d58d772225d9fa3e::acl::has_role(&arg0.acl, arg1, 2), 13);
    }

    public fun check_protocol_fee_claim_role(arg0: &VaultsManager, arg1: address) {
        assert!(0xe24128e4d513803988fdcf75d0aa371d1efa0c90079472a6d58d772225d9fa3e::acl::has_role(&arg0.acl, arg1, 0), 11);
    }

    public fun check_reinvest_role(arg0: &VaultsManager, arg1: address) {
        assert!(0xe24128e4d513803988fdcf75d0aa371d1efa0c90079472a6d58d772225d9fa3e::acl::has_role(&arg0.acl, arg1, 1), 12);
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

    public fun collect_rewarder<T0, T1, T2, T3>(arg0: &VaultsManager, arg1: &mut Vault<T3>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_reinvest_role(arg0, 0x2::tx_context::sender(arg6));
        assert!(!arg1.is_pause, 6);
        assert!(0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.positions) == 1, 2);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg2, arg3, 0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.positions, 0), arg4, true, arg5);
        merge_harvest_asset<T2, T3>(arg1, v0);
    }

    public(friend) fun create_vault<T0, T1, T2>(arg0: &mut VaultsManager, arg1: 0x2::coin::TreasuryCap<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u32, arg5: u32, arg6: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_pool_manager_role(arg0, 0x2::tx_context::sender(arg6));
        assert!(0x2::coin::total_supply<T2>(&arg1) == 0, 14);
        let v0 = 0x1::vector::empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>();
        0x1::vector::push_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg2, arg3, arg4, arg5, arg6));
        let v1 = Vault<T2>{
            id                : 0x2::object::new(arg6),
            pool              : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3),
            liquidity         : 0,
            protocol_fee_rate : 0,
            is_pause          : false,
            positions         : v0,
            lp_token_treasury : arg1,
            harvest_assets    : 0x2::bag::new(arg6),
            protocol_fees     : 0x2::bag::new(arg6),
        };
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.vault_to_pool_maps, 0x2::object::id<Vault<T2>>(&v1), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3));
        let v2 = CreateEvent{
            id                : 0x2::object::id<Vault<T2>>(&v1),
            clmm_pool         : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3),
            tick_lower        : arg4,
            tick_upper        : arg5,
            lp_token_treasury : 0x2::object::id<0x2::coin::TreasuryCap<T2>>(&arg1),
        };
        0x2::event::emit<CreateEvent>(v2);
        0x2::transfer::share_object<Vault<T2>>(v1);
    }

    public(friend) fun deposit<T0, T1, T2>(arg0: &VaultsManager, arg1: &mut Vault<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        assert!(!arg1.is_pause, 6);
        assert!(0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.positions) == 1, 2);
        let v0 = total_token_amount<T2>(arg1);
        let v1 = 0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.positions, 0);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v1);
        let v3 = if (arg8) {
            arg6
        } else {
            arg7
        };
        0xe24128e4d513803988fdcf75d0aa371d1efa0c90079472a6d58d772225d9fa3e::utils::repay_add_liquidity<T0, T1>(arg2, arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg2, arg3, v1, v3, arg8, arg9), arg4, arg5, arg6, arg7, arg10);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v1) - v2;
        arg1.liquidity = arg1.liquidity + v4;
        let v5 = get_lp_amount_by_liquidity(v0, v4, v2);
        assert!(v5 < 18446744073709551615 - (v0 as u128), 4);
        0x2::coin::mint_and_transfer<T2>(&mut arg1.lp_token_treasury, (v5 as u64), 0x2::tx_context::sender(arg10), arg10);
        let v6 = DepositEvent{
            vault_id         : 0x2::object::id<Vault<T2>>(arg1),
            before_liquidity : v2,
            delta_liquidity  : v4,
            before_supply    : v0,
            lp_amount        : (v5 as u64),
        };
        0x2::event::emit<DepositEvent>(v6);
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
        0xe24128e4d513803988fdcf75d0aa371d1efa0c90079472a6d58d772225d9fa3e::utils::get_amount_by_liquidity(v0, v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), (arg2 as u128), false)
    }

    fun get_share_liquidity_by_amount(arg0: u64, arg1: u128, arg2: u64) : u128 {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((arg0 as u128), arg1, (arg2 as u128))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = VaultsManager{
            id                 : 0x2::object::new(arg0),
            index              : 0,
            package_version    : 1,
            vault_to_pool_maps : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg0),
            acl                : 0xe24128e4d513803988fdcf75d0aa371d1efa0c90079472a6d58d772225d9fa3e::acl::new(arg0),
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
        check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        arg1.is_pause = true;
        let v0 = PauseEvent{vault_id: 0x2::object::id<Vault<T0>>(arg1)};
        0x2::event::emit<PauseEvent>(v0);
    }

    public fun rebalance<T0, T1, T2>(arg0: &VaultsManager, arg1: &mut Vault<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u64, arg5: u64, arg6: u32, arg7: u32, arg8: bool, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_reinvest_role(arg0, 0x2::tx_context::sender(arg12));
        assert!(!arg1.is_pause, 6);
        assert!(0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.positions) == 1, 2);
        let v0 = 0x1::vector::pop_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.positions);
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(&v0);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3);
        let (v4, v5) = 0xe24128e4d513803988fdcf75d0aa371d1efa0c90079472a6d58d772225d9fa3e::utils::close_position<T0, T1>(arg2, arg3, v0, arg4, arg5, arg11);
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg2, arg3, arg6, arg7, arg12);
        let (v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(&v6);
        let v9 = &mut v6;
        let v10 = 0x2::coin::from_balance<T0>(v4, arg12);
        let v11 = 0x2::coin::from_balance<T1>(v5, arg12);
        let v12 = rebalance_and_add_liquidity<T0, T1>(v9, v10, v11, arg2, arg3, arg8, arg9, arg10, arg11, arg12);
        arg1.liquidity = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v6);
        let v13 = RebalanceEvent{
            vault_id           : 0x2::object::id<Vault<T2>>(arg1),
            old_position       : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0),
            new_position       : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v6),
            remaining_amount   : 0x2::coin::value<T1>(&v12),
            old_tick_lower     : v1,
            old_tick_upper     : v2,
            old_liquidity      : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v0),
            current_sqrt_price : v3,
            tick_lower         : v7,
            tick_upper         : v8,
        };
        0x2::event::emit<RebalanceEvent>(v13);
        merge_harvest_asset<T1, T2>(arg1, 0x2::coin::into_balance<T1>(v12));
        0x1::vector::push_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.positions, v6);
    }

    fun rebalance_and_add_liquidity<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: bool, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = if (arg5) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v1, arg1);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v2, arg2);
        let (v3, v4) = 0xe24128e4d513803988fdcf75d0aa371d1efa0c90079472a6d58d772225d9fa3e::utils::swap<T0, T1>(arg3, arg4, v1, v2, arg5, true, arg6, arg7, v0, arg8, arg9);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0x2::coin::value<T0>(&v6);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg3, arg4, arg0, v7, true, arg8);
        let (v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v8);
        assert!(v9 == v7, 8);
        assert!(v10 <= 0x2::coin::value<T1>(&v5), 8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg3, arg4, 0x2::coin::into_balance<T0>(v6), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v5, v10, arg9)), v8);
        v5
    }

    public fun rebalance_rewarder<T0, T1, T2>(arg0: &VaultsManager, arg1: &mut Vault<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_reinvest_role(arg0, 0x2::tx_context::sender(arg8));
        assert!(!arg1.is_pause, 6);
        assert!(0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.positions) == 1, 2);
        let (v0, v1, v2) = if (arg4) {
            let v3 = take_harvest_asset_by_amount<T0, T2>(arg1, arg5);
            let v4 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v4, 0x2::coin::from_balance<T0>(v3, arg8));
            let (v5, v6) = 0xe24128e4d513803988fdcf75d0aa371d1efa0c90079472a6d58d772225d9fa3e::utils::swap<T0, T1>(arg2, arg3, v4, 0x1::vector::empty<0x2::coin::Coin<T1>>(), true, true, arg5, arg6, 4295048016, arg7, arg8);
            let v7 = v6;
            0x2::coin::destroy_zero<T0>(v5);
            merge_harvest_asset<T1, T2>(arg1, 0x2::coin::into_balance<T1>(v7));
            (0x2::balance::value<T0>(&v3), 0x2::coin::value<T1>(&v7), 0x1::type_name::get<T0>())
        } else {
            let v8 = take_harvest_asset_by_amount<T1, T2>(arg1, arg5);
            let v9 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
            0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v9, 0x2::coin::from_balance<T1>(v8, arg8));
            let (v10, v11) = 0xe24128e4d513803988fdcf75d0aa371d1efa0c90079472a6d58d772225d9fa3e::utils::swap<T0, T1>(arg2, arg3, 0x1::vector::empty<0x2::coin::Coin<T0>>(), v9, false, true, arg5, arg6, 79226673515401279992447579055, arg7, arg8);
            let v12 = v10;
            0x2::coin::destroy_zero<T1>(v11);
            merge_harvest_asset<T0, T2>(arg1, 0x2::coin::into_balance<T0>(v12));
            (0x2::balance::value<T1>(&v8), 0x2::coin::value<T0>(&v12), 0x1::type_name::get<T1>())
        };
        let v13 = RebalanceRewarderEvent{
            vault_id        : 0x2::object::id<Vault<T2>>(arg1),
            rewarder        : v2,
            rewarder_amount : v0,
            amount          : v1,
        };
        0x2::event::emit<RebalanceRewarderEvent>(v13);
    }

    public fun reinvest<T0, T1, T2>(arg0: &VaultsManager, arg1: &mut Vault<T2>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_reinvest_role(arg0, 0x2::tx_context::sender(arg8));
        assert!(!arg1.is_pause, 6);
        assert!(0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.positions) == 1, 2);
        let v0 = take_harvest_asset<T0, T2>(arg1);
        let v1 = 0x2::coin::from_balance<T0>(v0, arg8);
        let v2 = take_harvest_asset<T1, T2>(arg1);
        let v3 = 0x2::coin::from_balance<T1>(v2, arg8);
        let v4 = 0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.positions, 0);
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v4);
        let v6 = rebalance_and_add_liquidity<T0, T1>(v4, v1, v3, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v4) - v5;
        arg1.liquidity = arg1.liquidity + v7;
        let v8 = ReinvestEvent{
            vault_id           : 0x2::object::id<Vault<T2>>(arg1),
            amount_a           : 0x2::coin::value<T0>(&v1),
            amount_b           : 0x2::coin::value<T1>(&v3),
            remaining_amount   : 0x2::coin::value<T1>(&v6),
            delta_liquidity    : v7,
            current_sqrt_price : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3),
        };
        0x2::event::emit<ReinvestEvent>(v8);
        merge_harvest_asset<T1, T2>(arg1, 0x2::coin::into_balance<T1>(v6));
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
        check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        arg1.is_pause = false;
        let v0 = UnpauseEvent{vault_id: 0x2::object::id<Vault<T0>>(arg1)};
        0x2::event::emit<UnpauseEvent>(v0);
    }

    public entry fun update_package_version(arg0: &AdminCap, arg1: &mut VaultsManager, arg2: u64) {
        arg1.package_version = arg2;
        let v0 = SetPackageVersion{
            new_version : arg2,
            old_version : arg1.package_version,
        };
        0x2::event::emit<SetPackageVersion>(v0);
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

