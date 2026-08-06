module 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::wind_down {
    struct WindDownStartedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        sender: address,
    }

    struct LiquidityRemovedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        liquidity_removed: u128,
        amount_a: u64,
        amount_b: u64,
        sender: address,
    }

    struct PositionClosedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        sender: address,
    }

    struct WindDownFinalizedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        withdrawable_a: u64,
        withdrawable_b: u64,
        total_vault_coin_supply: u64,
        seed_vault_coin_balance: u64,
        circulating_vault_coin_supply: u64,
        sender: address,
    }

    struct WithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        vault_coin_burnt: u64,
        withdraw_coin_a: u64,
        withdraw_coin_b: u64,
        sender: address,
    }

    struct RewardStoredEvent has copy, drop {
        vault_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        total_stored: u64,
        sender: address,
    }

    struct RewardClaimedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        rebalance_cap_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    struct RewardClaimCapIssuedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        rebalance_cap_id: 0x2::object::ID,
        whitelisted_address: address,
        sender: address,
    }

    struct RewardSettledEvent has copy, drop {
        vault_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        input_amount: u64,
        output_amount: u64,
        returns_a: bool,
        sender: address,
    }

    public fun begin<T0, T1, T2, T3: copy + drop + store>(arg0: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::AdminCap, arg1: &mut 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>, arg2: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::assert_supported_version(arg2);
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::begin_wind_down<T0, T1, T2, T3>(arg1);
        let v0 = WindDownStartedEvent{
            vault_id : 0x2::object::id<0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>>(arg1),
            sender   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<WindDownStartedEvent>(v0);
    }

    public fun claim_stored_reward<T0, T1, T2, T3: copy + drop + store, T4>(arg0: &mut 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>, arg1: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::RebalanceCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::take_wind_down_reward<T0, T1, T2, T3, T4>(arg0, arg1, arg2);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = RewardClaimedEvent{
            vault_id         : 0x2::object::id<0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>>(arg0),
            rebalance_cap_id : 0x2::object::id<0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::RebalanceCap>(arg1),
            reward_type      : 0x1::type_name::get<T4>(),
            amount           : 0x2::balance::value<T4>(&v0),
            recipient        : v1,
        };
        0x2::event::emit<RewardClaimedEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(0x2::coin::from_balance<T4>(v0, arg2), v1);
    }

    public fun close_position<T0, T1, T2, T3: copy + drop + store>(arg0: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::AdminCap, arg1: &mut 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>, arg2: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg3: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::Version, arg4: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::assert_supported_version(arg3);
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::assert_unwinding<T0, T1, T2, T3>(arg1);
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::check_pool_compatibility<T0, T1, T2, T3>(arg1, arg2);
        assert!(0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::has_position<T0, T1, T2, T3>(arg1), 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::error::position_not_open());
        assert!(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::liquidity(0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::position_borrow<T0, T1, T2, T3>(arg1)) == 0, 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::error::position_has_liquidity());
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity::close_position(0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::remove_position<T0, T1, T2, T3>(arg1), arg4, arg5);
        let v0 = PositionClosedEvent{
            vault_id : 0x2::object::id<0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>>(arg1),
            sender   : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<PositionClosedEvent>(v0);
    }

    public fun collect_fees<T0, T1, T2, T3: copy + drop + store>(arg0: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::AdminCap, arg1: &mut 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>, arg2: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::Version, arg5: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::assert_supported_version(arg4);
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::assert_unwinding<T0, T1, T2, T3>(arg1);
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::collect::fees_internal<T0, T1, T2, T3>(arg1, arg2, arg5, arg3, arg6);
    }

    public fun collect_reward<T0, T1, T2, T3: copy + drop + store, T4>(arg0: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::AdminCap, arg1: &mut 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>, arg2: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg3: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault_acl::VaultAcl, arg4: &0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::RouterAcl, arg5: &0x2::clock::Clock, arg6: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::Version, arg7: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg8: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::assert_supported_version(arg6);
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::assert_unwinding<T0, T1, T2, T3>(arg1);
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::collect::rewards_internal<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg4, arg7, arg5, arg8)
    }

    public fun collect_reward_a<T0, T1, T2, T3: copy + drop + store>(arg0: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::AdminCap, arg1: &mut 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>, arg2: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::Version, arg5: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::assert_supported_version(arg4);
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::assert_unwinding<T0, T1, T2, T3>(arg1);
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::collect::rewards_x_internal<T0, T1, T2, T3>(arg1, arg2, arg5, arg3, arg6);
    }

    public fun collect_reward_b<T0, T1, T2, T3: copy + drop + store>(arg0: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::AdminCap, arg1: &mut 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>, arg2: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::Version, arg5: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::assert_supported_version(arg4);
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::assert_unwinding<T0, T1, T2, T3>(arg1);
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::collect::rewards_y_internal<T0, T1, T2, T3>(arg1, arg2, arg5, arg3, arg6);
    }

    public fun collect_reward_to_reserve<T0, T1, T2, T3: copy + drop + store, T4>(arg0: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::AdminCap, arg1: &mut 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>, arg2: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::Version, arg5: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::assert_supported_version(arg4);
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::assert_unwinding<T0, T1, T2, T3>(arg1);
        let v0 = 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::collect::reward_balance_internal<T0, T1, T2, T3, T4>(arg1, arg2, arg5, arg3, arg6);
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::store_wind_down_reward<T0, T1, T2, T3, T4>(arg1, v0);
        let v1 = RewardStoredEvent{
            vault_id     : 0x2::object::id<0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>>(arg1),
            reward_type  : 0x1::type_name::get<T4>(),
            amount       : 0x2::balance::value<T4>(&v0),
            total_stored : 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::stored_wind_down_reward<T0, T1, T2, T3, T4>(arg1),
            sender       : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<RewardStoredEvent>(v1);
    }

    public fun consume_finalized_reward_swap<T0, T1, T2, T3: copy + drop + store, T4>(arg0: 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg1: &mut 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>, arg2: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::RebalanceCap, arg3: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault_acl::VaultAcl, arg4: u64, arg5: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::assert_current_version(arg5);
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::assert_finalized<T0, T1, T2, T3>(arg1);
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::assert_rebalance_cap_identity<T0, T1, T2, T3>(arg1, arg2, arg6);
        let (v0, v1, v2) = 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::route::consume_finalized_reward_receipt<T0, T1, T2, T3, T4>(arg0, arg1, arg3, arg4);
        let v3 = RewardSettledEvent{
            vault_id      : 0x2::object::id<0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>>(arg1),
            reward_type   : 0x1::type_name::get<T4>(),
            input_amount  : v0,
            output_amount : v1,
            returns_a     : v2,
            sender        : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<RewardSettledEvent>(v3);
    }

    public fun consume_reward_swap<T0, T1, T2, T3: copy + drop + store, T4>(arg0: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::AdminCap, arg1: 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg2: &mut 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>, arg3: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault_acl::VaultAcl, arg4: u64, arg5: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::assert_supported_version(arg5);
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::assert_unwinding<T0, T1, T2, T3>(arg2);
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::route::consume_receipt_internal<T0, T1, T2, T3, T4>(arg1, arg2, arg3, arg4, arg6);
    }

    public fun finalize<T0, T1, T2, T3: copy + drop + store>(arg0: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::AdminCap, arg1: &mut 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>, arg2: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::assert_supported_version(arg2);
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::finalize_wind_down<T0, T1, T2, T3>(arg1);
        let v0 = 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::seed_balance<T0, T1, T2, T3>(arg1);
        let v1 = 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::total_vault_coin_supply<T0, T1, T2, T3>(arg1);
        let v2 = WindDownFinalizedEvent{
            vault_id                      : 0x2::object::id<0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>>(arg1),
            withdrawable_a                : 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::free_balance_a_val<T0, T1, T2, T3>(arg1),
            withdrawable_b                : 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::free_balance_b_val<T0, T1, T2, T3>(arg1),
            total_vault_coin_supply       : v1,
            seed_vault_coin_balance       : v0,
            circulating_vault_coin_supply : v1 - v0,
            sender                        : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<WindDownFinalizedEvent>(v2);
    }

    public fun issue_reward_claim_cap<T0, T1, T2, T3: copy + drop + store>(arg0: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::AdminCap, arg1: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>, arg2: address, arg3: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::assert_supported_version(arg3);
        let v0 = RewardClaimCapIssuedEvent{
            vault_id            : 0x2::object::id<0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>>(arg1),
            rebalance_cap_id    : 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::issue_wind_down_reward_cap<T0, T1, T2, T3>(arg1, arg2, arg4),
            whitelisted_address : arg2,
            sender              : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<RewardClaimCapIssuedEvent>(v0);
    }

    public fun issue_stored_reward_swap<T0, T1, T2, T3: copy + drop + store, T4>(arg0: &mut 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>, arg1: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::RebalanceCap, arg2: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault_acl::VaultAcl, arg3: &0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::RouterAcl, arg4: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::Version, arg5: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::assert_current_version(arg4);
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::route::issue_finalized_reward_receipt<T0, T1, T2, T3, T4>(0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::take_wind_down_reward<T0, T1, T2, T3, T4>(arg0, arg1, arg5), arg0, arg2, arg3, arg5)
    }

    public fun position_debts<T0, T1, T2, T3: copy + drop + store>(arg0: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>) : (u128, u64, u64, u64, bool) {
        let v0 = 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::position_borrow<T0, T1, T2, T3>(arg0);
        (0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::liquidity(v0), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::owed_coin_x(v0), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::owed_coin_y(v0), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::reward_length(v0), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::is_empty(v0))
    }

    public fun preview_withdraw<T0, T1, T2, T3: copy + drop + store>(arg0: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>, arg1: u64) : (u64, u64) {
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::preview_finalized_share<T0, T1, T2, T3>(arg0, arg1)
    }

    public fun remove_all_liquidity<T0, T1, T2, T3: copy + drop + store>(arg0: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::AdminCap, arg1: &mut 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>, arg2: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::Version, arg7: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::assert_supported_version(arg6);
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::assert_unwinding<T0, T1, T2, T3>(arg1);
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::check_pool_compatibility<T0, T1, T2, T3>(arg1, arg2);
        assert!(0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::has_position<T0, T1, T2, T3>(arg1), 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::error::position_not_open());
        let v0 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::liquidity(0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::position_borrow<T0, T1, T2, T3>(arg1));
        let (v1, v2) = if (v0 > 0) {
            let (v3, v4) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity::remove_liquidity<T0, T1>(arg2, 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::position_borrow_mut<T0, T1, T2, T3>(arg1), v0, arg3, arg4, arg5, arg7, arg8);
            (0x2::coin::into_balance<T0>(v3), 0x2::coin::into_balance<T1>(v4))
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v5 = v2;
        let v6 = v1;
        let v7 = 0x2::balance::value<T0>(&v6);
        let v8 = 0x2::balance::value<T1>(&v5);
        assert!(v7 >= arg3 && v8 >= arg4, 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::error::min_receive_not_honoured());
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::add_free_balance_a<T0, T1, T2, T3>(arg1, v6);
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::add_free_balance_b<T0, T1, T2, T3>(arg1, v5);
        let v9 = LiquidityRemovedEvent{
            vault_id          : 0x2::object::id<0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>>(arg1),
            liquidity_removed : v0,
            amount_a          : v7,
            amount_b          : v8,
            sender            : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<LiquidityRemovedEvent>(v9);
    }

    public fun reward_owed<T0, T1, T2, T3: copy + drop + store>(arg0: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>, arg1: u64) : u64 {
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::position::coins_owed_reward(0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::position_borrow<T0, T1, T2, T3>(arg0), arg1)
    }

    public fun set_finalized_reward_route<T0, T1, T2, T3: copy + drop + store, T4>(arg0: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::AdminCap, arg1: &mut 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>, arg3: bool, arg4: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::Version) {
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::assert_current_version(arg4);
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::assert_finalized<T0, T1, T2, T3>(arg1);
        if (0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::has_swap_route<T0, T1, T2, T3, T4>(arg1)) {
            0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::remove_swap_route<T0, T1, T2, T3, T4>(arg1);
        };
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::add_swap_route<T0, T1, T2, T3, T4>(arg1, arg2, arg3);
    }

    public fun set_reward_route<T0, T1, T2, T3: copy + drop + store, T4>(arg0: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::AdminCap, arg1: &mut 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>, arg3: bool, arg4: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::Version) {
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::assert_supported_version(arg4);
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::assert_unwinding<T0, T1, T2, T3>(arg1);
        if (0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::has_swap_route<T0, T1, T2, T3, T4>(arg1)) {
            0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::remove_swap_route<T0, T1, T2, T3, T4>(arg1);
        };
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::add_swap_route<T0, T1, T2, T3, T4>(arg1, arg2, arg3);
    }

    public fun settle_stored_reward_a<T0, T1, T2, T3: copy + drop + store>(arg0: &mut 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>, arg1: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::RebalanceCap, arg2: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::assert_current_version(arg2);
        let v0 = 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::take_wind_down_reward<T0, T1, T2, T3, T0>(arg0, arg1, arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::add_finalized_reward_a<T0, T1, T2, T3>(arg0, v0);
        let v2 = RewardSettledEvent{
            vault_id      : 0x2::object::id<0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>>(arg0),
            reward_type   : 0x1::type_name::get<T0>(),
            input_amount  : v1,
            output_amount : v1,
            returns_a     : true,
            sender        : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<RewardSettledEvent>(v2);
    }

    public fun settle_stored_reward_b<T0, T1, T2, T3: copy + drop + store>(arg0: &mut 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>, arg1: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::RebalanceCap, arg2: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::version::assert_current_version(arg2);
        let v0 = 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::take_wind_down_reward<T0, T1, T2, T3, T1>(arg0, arg1, arg3);
        let v1 = 0x2::balance::value<T1>(&v0);
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::add_finalized_reward_b<T0, T1, T2, T3>(arg0, v0);
        let v2 = RewardSettledEvent{
            vault_id      : 0x2::object::id<0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>>(arg0),
            reward_type   : 0x1::type_name::get<T1>(),
            input_amount  : v1,
            output_amount : v1,
            returns_a     : false,
            sender        : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<RewardSettledEvent>(v2);
    }

    public fun stored_reward_balance<T0, T1, T2, T3: copy + drop + store, T4>(arg0: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>) : u64 {
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::stored_wind_down_reward<T0, T1, T2, T3, T4>(arg0)
    }

    public entry fun withdraw<T0, T1, T2, T3: copy + drop + store>(arg0: &mut 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>, arg1: 0x2::coin::Coin<T2>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::take_finalized_share<T0, T1, T2, T3>(arg0, arg1);
        let v3 = v1;
        let v4 = v0;
        let v5 = 0x2::balance::value<T0>(&v4);
        let v6 = 0x2::balance::value<T1>(&v3);
        assert!(v5 >= arg2 && v6 >= arg3, 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::error::min_receive_not_honoured());
        let v7 = WithdrawEvent{
            vault_id         : 0x2::object::id<0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>>(arg0),
            vault_coin_burnt : v2,
            withdraw_coin_a  : v5,
            withdraw_coin_b  : v6,
            sender           : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<WithdrawEvent>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg4), 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v3, arg4), 0x2::tx_context::sender(arg4));
    }

    public fun withdrawable_balances<T0, T1, T2, T3: copy + drop + store>(arg0: &0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::Vault<T0, T1, T2, T3>) : (u64, u64, u64, u64) {
        0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::assert_finalized<T0, T1, T2, T3>(arg0);
        (0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::free_balance_a_val<T0, T1, T2, T3>(arg0), 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::free_balance_b_val<T0, T1, T2, T3>(arg0), 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::total_vault_coin_supply<T0, T1, T2, T3>(arg0), 0x1c2af95e845df26d65c22522392f52d933a713e8553709fd0a465cf27189c3b3::vault::seed_balance<T0, T1, T2, T3>(arg0))
    }

    // decompiled from Move bytecode v7
}

