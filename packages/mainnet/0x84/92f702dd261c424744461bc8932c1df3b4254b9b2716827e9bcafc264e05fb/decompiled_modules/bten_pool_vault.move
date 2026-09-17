module 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten_pool_vault {
    struct ProtocolPoolVault has key {
        id: 0x2::object::UID,
        paused: bool,
        position_count: u64,
        pool_position_counts: 0x2::table::Table<address, u64>,
    }

    struct ProtocolVaultAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ProtocolPositionSlot has key {
        id: 0x2::object::UID,
        pool_id: address,
        position_id: address,
        vault_id: address,
    }

    struct VaultCreated has copy, drop {
        vault_id: address,
    }

    struct ProtocolPositionDeposited has copy, drop {
        vault_id: address,
        slot_id: address,
        pool_id: address,
        position_id: address,
        liquidity: u128,
    }

    struct ProtocolPositionWithdrawn has copy, drop {
        vault_id: address,
        slot_id: address,
        pool_id: address,
        position_id: address,
    }

    struct VaultSwapRouted has copy, drop {
        vault_id: address,
        pool_id: address,
        trader: address,
        paid_points: u64,
    }

    struct VaultLiquidityMutated has copy, drop {
        vault_id: address,
        slot_id: address,
        pool_id: address,
        position_id: address,
        add: bool,
    }

    fun assert_vault_ready(arg0: &ProtocolPoolVault, arg1: address) {
        assert!(!arg0.paused, 2);
        assert!(vault_has_depth(arg0, arg1), 4);
    }

    public entry fun create_protocol_pool_vault(arg0: &0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::RegistryAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolPoolVault{
            id                   : 0x2::object::new(arg1),
            paused               : false,
            position_count       : 0,
            pool_position_counts : 0x2::table::new<address, u64>(arg1),
        };
        let v1 = 0x2::object::id<ProtocolPoolVault>(&v0);
        let v2 = VaultCreated{vault_id: 0x2::object::id_to_address(&v1)};
        0x2::event::emit<VaultCreated>(v2);
        0x2::transfer::share_object<ProtocolPoolVault>(v0);
        let v3 = ProtocolVaultAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<ProtocolVaultAdminCap>(v3, 0x2::tx_context::sender(arg1));
    }

    public entry fun deposit_protocol_position<T0, T1>(arg0: &mut ProtocolPoolVault, arg1: &ProtocolVaultAdminCap, arg2: &0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::OpsInteractionFeeConfig, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::collect_ops_interaction_fee(arg2, arg3, arg6);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4);
        let v1 = 0x2::object::id_to_address(&v0);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg5);
        assert!(0x2::object::id_to_address(&v2) == v1, 6);
        let v3 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg5);
        let v4 = 0x2::object::id_to_address(&v3);
        let v5 = 0x2::object::id<ProtocolPoolVault>(arg0);
        let v6 = 0x2::object::id_to_address(&v5);
        let v7 = ProtocolPositionSlot{
            id          : 0x2::object::new(arg6),
            pool_id     : v1,
            position_id : v4,
            vault_id    : v6,
        };
        let v8 = 0x2::object::id<ProtocolPositionSlot>(&v7);
        0x2::dynamic_object_field::add<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut v7.id, b"position", arg5);
        if (0x2::table::contains<address, u64>(&arg0.pool_position_counts, v1)) {
            let v9 = 0x2::table::borrow_mut<address, u64>(&mut arg0.pool_position_counts, v1);
            *v9 = *v9 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.pool_position_counts, v1, 1);
        };
        arg0.position_count = arg0.position_count + 1;
        let v10 = ProtocolPositionDeposited{
            vault_id    : v6,
            slot_id     : 0x2::object::id_to_address(&v8),
            pool_id     : v1,
            position_id : v4,
            liquidity   : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg5),
        };
        0x2::event::emit<ProtocolPositionDeposited>(v10);
        0x2::transfer::share_object<ProtocolPositionSlot>(v7);
    }

    fun emit_routed(arg0: &ProtocolPoolVault, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<ProtocolPoolVault>(arg0);
        let v1 = VaultSwapRouted{
            vault_id    : 0x2::object::id_to_address(&v0),
            pool_id     : arg1,
            trader      : 0x2::tx_context::sender(arg3),
            paid_points : arg2,
        };
        0x2::event::emit<VaultSwapRouted>(v1);
    }

    public entry fun set_vault_paused(arg0: &mut ProtocolPoolVault, arg1: &ProtocolVaultAdminCap, arg2: bool) {
        arg0.paused = arg2;
    }

    public fun slot_pool_id(arg0: &ProtocolPositionSlot) : address {
        arg0.pool_id
    }

    public fun slot_position_id(arg0: &ProtocolPositionSlot) : address {
        arg0.position_id
    }

    public fun slot_vault_id(arg0: &ProtocolPositionSlot) : address {
        arg0.vault_id
    }

    public entry fun vault_add_liquidity<T0, T1>(arg0: &ProtocolPoolVault, arg1: &ProtocolVaultAdminCap, arg2: &0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::OpsInteractionFeeConfig, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut ProtocolPositionSlot, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: bool, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        let v0 = 0x2::object::id<ProtocolPoolVault>(arg0);
        let v1 = 0x2::object::id_to_address(&v0);
        assert!(arg4.vault_id == v1, 1);
        0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::collect_ops_interaction_fee(arg2, arg3, arg13);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg6);
        let v3 = 0x2::object::id_to_address(&v2);
        assert!(arg4.pool_id == v3, 6);
        assert!(0x2::dynamic_object_field::exists<vector<u8>>(&arg4.id, b"position"), 5);
        assert!(arg9 > 0 || arg10 > 0, 7);
        let v4 = 0x2::dynamic_object_field::remove<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg4.id, b"position");
        let v5 = if (arg11) {
            arg9
        } else {
            arg10
        };
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg5, arg6, &mut v4, v5, arg11, arg12);
        let (v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v6);
        assert!(v7 <= arg9 && v8 <= arg10, 1);
        assert!(0x2::coin::value<T0>(&arg7) >= v7 && 0x2::coin::value<T1>(&arg8) >= v8, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg5, arg6, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg7, v7, arg13)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg8, v8, arg13)), v6);
        let v9 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v4);
        arg4.position_id = 0x2::object::id_to_address(&v9);
        0x2::dynamic_object_field::add<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg4.id, b"position", v4);
        let v10 = 0x2::object::id<ProtocolPositionSlot>(arg4);
        let v11 = VaultLiquidityMutated{
            vault_id    : v1,
            slot_id     : 0x2::object::id_to_address(&v10),
            pool_id     : v3,
            position_id : arg4.position_id,
            add         : true,
        };
        0x2::event::emit<VaultLiquidityMutated>(v11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg7, 0x2::tx_context::sender(arg13));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg8, 0x2::tx_context::sender(arg13));
    }

    public fun vault_has_depth(arg0: &ProtocolPoolVault, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.pool_position_counts, arg1) && *0x2::table::borrow<address, u64>(&arg0.pool_position_counts, arg1) > 0
    }

    public fun vault_is_paused(arg0: &ProtocolPoolVault) : bool {
        arg0.paused
    }

    public fun vault_pool_position_count(arg0: &ProtocolPoolVault, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.pool_position_counts, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.pool_position_counts, arg1)
        } else {
            0
        }
    }

    public fun vault_position_count(arg0: &ProtocolPoolVault) : u64 {
        arg0.position_count
    }

    public entry fun vault_remove_liquidity<T0, T1>(arg0: &ProtocolPoolVault, arg1: &ProtocolVaultAdminCap, arg2: &0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::OpsInteractionFeeConfig, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut ProtocolPositionSlot, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        let v0 = 0x2::object::id<ProtocolPoolVault>(arg0);
        let v1 = 0x2::object::id_to_address(&v0);
        assert!(arg4.vault_id == v1, 1);
        0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::collect_ops_interaction_fee(arg2, arg3, arg9);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg6);
        let v3 = 0x2::object::id_to_address(&v2);
        assert!(arg4.pool_id == v3, 6);
        assert!(0x2::dynamic_object_field::exists<vector<u8>>(&arg4.id, b"position"), 5);
        assert!(arg7 > 0, 7);
        let v4 = 0x2::dynamic_object_field::remove<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg4.id, b"position");
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg5, arg6, &mut v4, arg7, arg8);
        let v7 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v4);
        arg4.position_id = 0x2::object::id_to_address(&v7);
        0x2::dynamic_object_field::add<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg4.id, b"position", v4);
        let v8 = 0x2::object::id<ProtocolPositionSlot>(arg4);
        let v9 = VaultLiquidityMutated{
            vault_id    : v1,
            slot_id     : 0x2::object::id_to_address(&v8),
            pool_id     : v3,
            position_id : arg4.position_id,
            add         : false,
        };
        0x2::event::emit<VaultLiquidityMutated>(v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg9), 0x2::tx_context::sender(arg9));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v6, arg9), 0x2::tx_context::sender(arg9));
    }

    public entry fun vault_sui_to_bten_to_sui(arg0: &ProtocolPoolVault, arg1: &mut 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::EmissionState, arg2: &0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::PoolRegistry, arg3: &0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::OpsInteractionFeeConfig, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN, 0x2::sui::SUI>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: u64, arg9: u128, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN, 0x2::sui::SUI>>(arg6);
        let v1 = 0x2::object::id_to_address(&v0);
        assert_vault_ready(arg0, v1);
        0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::collect_ops_interaction_fee(arg3, arg4, arg12);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg7) > 0, 7);
        let v2 = 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::open_composable_route(arg12);
        let (v3, v4) = 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::cetus_swap_to_bten_b2a_return<0x2::sui::SUI>(arg2, arg5, arg6, arg7, 1, arg9, arg11, &mut v2, arg12);
        let (v5, v6) = 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::cetus_swap_from_bten_a2b_return<0x2::sui::SUI>(arg2, arg5, arg6, v4, arg8, arg10, arg11, &mut v2, arg12);
        let v7 = v6;
        assert!(0x2::coin::value<0x2::sui::SUI>(&v7) >= arg8, 1);
        0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::seal_composable_route(arg1, v2, arg11, arg12);
        emit_routed(arg0, v1, 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::composable_route_paid_points_view(&v2), arg12);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, 0x2::tx_context::sender(arg12));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN>>(v5, 0x2::tx_context::sender(arg12));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v7, 0x2::tx_context::sender(arg12));
    }

    public entry fun vault_swap_from_bten<T0>(arg0: &ProtocolPoolVault, arg1: &mut 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::EmissionState, arg2: &0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::PoolRegistry, arg3: &0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::OpsInteractionFeeConfig, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN>, arg7: 0x2::coin::Coin<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN>, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN>>(arg6);
        let v1 = 0x2::object::id_to_address(&v0);
        assert_vault_ready(arg0, v1);
        0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::collect_ops_interaction_fee(arg3, arg4, arg11);
        let v2 = 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::open_composable_route(arg11);
        let (v3, v4) = 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::cetus_swap_from_bten_return<T0>(arg2, arg5, arg6, arg7, arg8, arg9, arg10, &mut v2, arg11);
        0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::seal_composable_route(arg1, v2, arg10, arg11);
        emit_routed(arg0, v1, 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::composable_route_paid_points_view(&v2), arg11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN>>(v3, 0x2::tx_context::sender(arg11));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun vault_swap_from_bten_a2b<T0>(arg0: &ProtocolPoolVault, arg1: &mut 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::EmissionState, arg2: &0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::PoolRegistry, arg3: &0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::OpsInteractionFeeConfig, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN, T0>, arg7: 0x2::coin::Coin<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN>, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN, T0>>(arg6);
        let v1 = 0x2::object::id_to_address(&v0);
        assert_vault_ready(arg0, v1);
        0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::collect_ops_interaction_fee(arg3, arg4, arg11);
        let v2 = 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::open_composable_route(arg11);
        let (v3, v4) = 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::cetus_swap_from_bten_a2b_return<T0>(arg2, arg5, arg6, arg7, arg8, arg9, arg10, &mut v2, arg11);
        0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::seal_composable_route(arg1, v2, arg10, arg11);
        emit_routed(arg0, v1, 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::composable_route_paid_points_view(&v2), arg11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN>>(v3, 0x2::tx_context::sender(arg11));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun vault_swap_registered_a2b<T0, T1>(arg0: &ProtocolPoolVault, arg1: &mut 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::EmissionState, arg2: &0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::PoolRegistry, arg3: &0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::OpsInteractionFeeConfig, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg6);
        let v1 = 0x2::object::id_to_address(&v0);
        assert_vault_ready(arg0, v1);
        0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::collect_ops_interaction_fee(arg3, arg4, arg11);
        let v2 = 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::open_composable_route(arg11);
        let (v3, v4) = 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::cetus_swap_registered_a2b_return<T0, T1>(arg2, arg5, arg6, arg7, arg8, arg9, arg10, &mut v2, arg11);
        0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::seal_composable_route(arg1, v2, arg10, arg11);
        emit_routed(arg0, v1, 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::composable_route_paid_points_view(&v2), arg11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun vault_swap_registered_b2a<T0, T1>(arg0: &ProtocolPoolVault, arg1: &mut 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::EmissionState, arg2: &0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::PoolRegistry, arg3: &0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::OpsInteractionFeeConfig, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg6);
        let v1 = 0x2::object::id_to_address(&v0);
        assert_vault_ready(arg0, v1);
        0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::collect_ops_interaction_fee(arg3, arg4, arg11);
        let v2 = 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::open_composable_route(arg11);
        let (v3, v4) = 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::cetus_swap_registered_b2a_return<T0, T1>(arg2, arg5, arg6, arg7, arg8, arg9, arg10, &mut v2, arg11);
        0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::seal_composable_route(arg1, v2, arg10, arg11);
        emit_routed(arg0, v1, 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::composable_route_paid_points_view(&v2), arg11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, 0x2::tx_context::sender(arg11));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun vault_swap_to_bten<T0>(arg0: &ProtocolPoolVault, arg1: &mut 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::EmissionState, arg2: &0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::PoolRegistry, arg3: &0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::OpsInteractionFeeConfig, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN>, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN>>(arg6);
        let v1 = 0x2::object::id_to_address(&v0);
        assert_vault_ready(arg0, v1);
        0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::collect_ops_interaction_fee(arg3, arg4, arg11);
        let v2 = 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::open_composable_route(arg11);
        let (v3, v4) = 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::cetus_swap_to_bten_return<T0>(arg2, arg5, arg6, arg7, arg8, arg9, arg10, &mut v2, arg11);
        0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::seal_composable_route(arg1, v2, arg10, arg11);
        emit_routed(arg0, v1, 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::composable_route_paid_points_view(&v2), arg11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun vault_swap_to_bten_b2a<T0>(arg0: &ProtocolPoolVault, arg1: &mut 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::EmissionState, arg2: &0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::PoolRegistry, arg3: &0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::OpsInteractionFeeConfig, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN, T0>, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN, T0>>(arg6);
        let v1 = 0x2::object::id_to_address(&v0);
        assert_vault_ready(arg0, v1);
        0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::collect_ops_interaction_fee(arg3, arg4, arg11);
        let v2 = 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::open_composable_route(arg11);
        let (v3, v4) = 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::cetus_swap_to_bten_b2a_return<T0>(arg2, arg5, arg6, arg7, arg8, arg9, arg10, &mut v2, arg11);
        0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::seal_composable_route(arg1, v2, arg10, arg11);
        emit_routed(arg0, v1, 0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::composable_route_paid_points_view(&v2), arg11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, 0x2::tx_context::sender(arg11));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::BTEN>>(v4, 0x2::tx_context::sender(arg11));
    }

    public entry fun withdraw_protocol_position(arg0: &mut ProtocolPoolVault, arg1: &ProtocolVaultAdminCap, arg2: &0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::OpsInteractionFeeConfig, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: ProtocolPositionSlot, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        0x31c6c71184b08a574bd62fa8edd9a75aab9a986427484cf765a1890ce00aece0::bten::collect_ops_interaction_fee(arg2, arg3, arg5);
        let v0 = 0x2::object::id<ProtocolPoolVault>(arg0);
        let v1 = 0x2::object::id_to_address(&v0);
        assert!(arg4.vault_id == v1, 1);
        assert!(0x2::dynamic_object_field::exists<vector<u8>>(&arg4.id, b"position"), 5);
        let ProtocolPositionSlot {
            id          : v2,
            pool_id     : v3,
            position_id : v4,
            vault_id    : _,
        } = arg4;
        let v6 = v2;
        0x2::object::delete(v6);
        assert!(0x2::table::contains<address, u64>(&arg0.pool_position_counts, v3), 4);
        let v7 = 0x2::table::borrow_mut<address, u64>(&mut arg0.pool_position_counts, v3);
        assert!(*v7 > 0, 4);
        *v7 = *v7 - 1;
        arg0.position_count = arg0.position_count - 1;
        let v8 = ProtocolPositionWithdrawn{
            vault_id    : v1,
            slot_id     : 0x2::object::uid_to_address(&v6),
            pool_id     : v3,
            position_id : v4,
        };
        0x2::event::emit<ProtocolPositionWithdrawn>(v8);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x2::dynamic_object_field::remove<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut v6, b"position"), 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v7
}

