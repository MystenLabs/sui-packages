module 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::index {
    struct IndexCreated has copy, drop {
        index_id: address,
    }

    struct VaultSubscribed has copy, drop {
        index_id: address,
        vault_id: address,
    }

    struct VaultUnsubscribed has copy, drop {
        index_id: address,
        vault_id: address,
    }

    struct Index<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::version::Version,
        subscribed_vaults: vector<address>,
        assets: vector<u64>,
        weights: vector<u64>,
        deprecated: 0x1::option::Option<address>,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        price_decimals: u8,
        initial_price: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal,
        mint_fee: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal,
        burn_fee: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal,
        lp_rewards: vector<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal>,
        streaming_fee: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::streaming_fee::StreamingFee,
        incentive_goal_value: 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal,
        decimals: u8,
        locked: bool,
        mint_access: u8,
        name: 0x1::ascii::String,
        description: 0x1::ascii::String,
        strategy: u64,
    }

    public fun decimals<T0>(arg0: &Index<T0>) : u8 {
        arg0.decimals
    }

    public(friend) fun assert_index_is_not_locked<T0>(arg0: &Index<T0>) {
        assert!(!arg0.locked, 711);
    }

    public(friend) fun assert_mint_is_open<T0>(arg0: &Index<T0>) {
        assert!(arg0.mint_access != 0, 710);
    }

    public(friend) fun assert_mint_is_public<T0>(arg0: &Index<T0>) {
        assert!(is_mint_public<T0>(arg0), 712);
    }

    public(friend) fun assert_vault_is_subscribed<T0, T1>(arg0: &Index<T0>, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T1>) {
        let v0 = 0x2::object::id<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T1>>(arg1);
        let v1 = 0x2::object::id_to_address(&v0);
        assert!(0x1::vector::contains<address>(&arg0.subscribed_vaults, &v1), 713);
    }

    fun assert_weights<T0>(arg0: &Index<T0>) {
        let v0 = 0;
        let v1 = arg0.weights;
        0x1::vector::reverse<u64>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v1)) {
            v0 = 0x1::vector::pop_back<u64>(&mut v1) + v0;
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u64>(v1);
        assert!(v0 == 10000, 714);
    }

    public(friend) fun assets<T0>(arg0: &Index<T0>) : vector<u64> {
        arg0.assets
    }

    public(friend) fun burn_coin<T0>(arg0: &mut Index<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::burn<T0>(&mut arg0.treasury_cap, arg1);
    }

    public fun burn_fee<T0>(arg0: &Index<T0>) : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal {
        arg0.burn_fee
    }

    public fun close_mint<T0>(arg0: &mut Index<T0>, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::admin::AdminCap) {
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::version::assert_current_version(&arg0.version);
        arg0.mint_access = 0;
    }

    public fun deprecate<T0>(arg0: &mut Index<T0>, arg1: address, arg2: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::admin::AdminCap) {
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::version::assert_current_version(&arg0.version);
        close_mint<T0>(arg0, arg2);
        arg0.burn_fee = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::zero();
        arg0.deprecated = 0x1::option::some<address>(arg1);
    }

    public fun distribute_streaming_fee<T0, T1>(arg0: &mut Index<T0>, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg3: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T1>, arg4: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::fee_dispatcher::FeeDispatcher<T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::streaming_fee::distribute<T1>(&mut arg0.streaming_fee, arg1, arg2, arg3, lp_rewards<T0, T1>(arg0, arg1, arg2), arg4, arg5, arg6, arg7);
    }

    public(friend) fun initial_price<T0>(arg0: &Index<T0>) : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal {
        arg0.initial_price
    }

    public(friend) fun is_mint_public<T0>(arg0: &Index<T0>) : bool {
        arg0.mint_access == 2
    }

    public(friend) fun is_mint_whitelist_only<T0>(arg0: &Index<T0>) : bool {
        arg0.mint_access == 1
    }

    public fun lock_index<T0>(arg0: &mut Index<T0>, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::admin::AdminCap) {
        arg0.locked = true;
    }

    public(friend) fun lp_rewards<T0, T1>(arg0: &Index<T0>, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry) : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal {
        let v0 = *0x1::vector::borrow<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal>(&arg0.lp_rewards, 1);
        if (0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::is_zero(arg0.incentive_goal_value)) {
            return *0x1::vector::borrow<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal>(&arg0.lp_rewards, 0)
        };
        let v1 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::div(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_u64(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::total(arg2, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::lp_product(), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset_id<T1>(arg1)), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::decimals(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset<T1>(arg1))), arg0.incentive_goal_value);
        let v2 = if (0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::gt(v1, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_int(1))) {
            0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_int(1)
        } else {
            v1
        };
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::sub(v0, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::mul(v2, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::sub(v0, *0x1::vector::borrow<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal>(&arg0.lp_rewards, 0))))
    }

    public fun migrate_to_current_version<T0>(arg0: &mut Index<T0>, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::version::VersionCap) {
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::version::migrate_to_current_version(&mut arg0.version, arg1);
    }

    public(friend) fun mint_coin<T0>(arg0: &mut Index<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::mint<T0>(&mut arg0.treasury_cap, arg1, arg2)
    }

    public fun mint_fee<T0>(arg0: &Index<T0>) : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal {
        arg0.mint_fee
    }

    public fun open_mint_public<T0>(arg0: &mut Index<T0>, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::admin::AdminCap) {
        assert_weights<T0>(arg0);
        assert!(0x1::vector::length<u64>(&arg0.assets) == 0x1::vector::length<u64>(&arg0.weights), 13906835071991545855);
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.weights)) {
            v1 = v1 + *0x1::vector::borrow<u64>(&arg0.weights, v0);
            v0 = v0 + 1;
        };
        assert!(v1 == 10000, 13906835119236186111);
        arg0.mint_access = 2;
    }

    public fun open_mint_whitelist_only<T0>(arg0: &mut Index<T0>, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::admin::AdminCap) {
        assert_weights<T0>(arg0);
        arg0.mint_access = 1;
    }

    public(friend) fun price_decimals<T0>(arg0: &Index<T0>) : u8 {
        arg0.price_decimals
    }

    public(friend) fun set_weights<T0>(arg0: &mut Index<T0>, arg1: vector<u64>) {
        assert!(0x1::vector::length<u64>(&arg1) == 0x1::vector::length<u64>(&arg0.weights), 714);
        arg0.weights = arg1;
        assert_weights<T0>(arg0);
    }

    public fun setup<T0>(arg0: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg1: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg2: &0x2::coin::CoinMetadata<T0>, arg3: u8, arg4: u64, arg5: u64, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: u64, arg9: 0x2::coin::TreasuryCap<T0>, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::admin::AdminCap, arg17: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg17);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = IndexCreated{index_id: 0x2::object::id_to_address(&v1)};
        0x2::event::emit<IndexCreated>(v2);
        let v3 = 0x2::object::uid_to_inner(&v0);
        let v4 = 0x1::vector::empty<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal>(v5, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_percentage(arg4));
        0x1::vector::push_back<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::Decimal>(v5, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_percentage(arg5));
        let v6 = Index<T0>{
            id                   : v0,
            version              : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::version::new(),
            subscribed_vaults    : 0x1::vector::empty<address>(),
            assets               : 0x1::vector::empty<u64>(),
            weights              : 0x1::vector::empty<u64>(),
            deprecated           : 0x1::option::none<address>(),
            treasury_cap         : arg9,
            price_decimals       : arg3,
            initial_price        : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_u64(arg10, arg3),
            mint_fee             : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_percentage(arg12),
            burn_fee             : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_percentage(arg13),
            lp_rewards           : v4,
            streaming_fee        : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::streaming_fee::new(arg1, 0x2::object::id_to_address(&v3), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::index_product(), arg14, arg15, arg17),
            incentive_goal_value : 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::decimals::from_u64(arg11, arg3),
            decimals             : 0x2::coin::get_decimals<T0>(arg2),
            locked               : false,
            mint_access          : 0,
            name                 : arg6,
            description          : arg7,
            strategy             : arg8,
        };
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::add_asset<T0>(arg0, arg2, 1, arg16);
        0x2::transfer::public_share_object<Index<T0>>(v6);
    }

    public fun start_streaming_fee_distribution<T0>(arg0: &mut Index<T0>, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::streaming_fee::start_distribution(&mut arg0.streaming_fee, arg1, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::lp_product(), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::index_product(), arg0.assets, arg2);
    }

    public(friend) fun streaming_fee<T0>(arg0: &Index<T0>) : &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::streaming_fee::StreamingFee {
        &arg0.streaming_fee
    }

    public(friend) fun streaming_fee_mut<T0>(arg0: &mut Index<T0>) : &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::streaming_fee::StreamingFee {
        &mut arg0.streaming_fee
    }

    public fun subscribe_vault<T0, T1>(arg0: &mut Index<T0>, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg3: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T1>, arg4: &0x2::clock::Clock, arg5: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::admin::AdminCap, arg6: &mut 0x2::tx_context::TxContext) {
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::version::assert_current_version(&arg0.version);
        assert_index_is_not_locked<T0>(arg0);
        let v0 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset_id<T1>(arg1);
        let v1 = 0x2::object::id<Index<T0>>(arg0);
        let v2 = 0x2::object::id_to_address(&v1);
        assert!(!0x1::vector::contains<u64>(&arg0.assets, &v0), 13906834732689129471);
        let v3 = 0x2::object::id<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T1>>(arg3);
        let v4 = 0x2::object::id_to_address(&v3);
        assert!(!0x1::vector::contains<address>(&arg0.subscribed_vaults, &v4), 13906834736984096767);
        let v5 = 0x2::object::id<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T1>>(arg3);
        0x1::vector::push_back<address>(&mut arg0.subscribed_vaults, 0x2::object::id_to_address(&v5));
        0x1::vector::push_back<u64>(&mut arg0.assets, v0);
        0x1::vector::push_back<u64>(&mut arg0.weights, 0);
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::set_balance<T1>(arg2, arg1, 0, v2, 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::index_product(), arg4, arg6);
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::add_fee<T1>(arg2, arg1, 0, v2);
        let v6 = 0x2::object::id<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T1>>(arg3);
        let v7 = VaultSubscribed{
            index_id : 0x2::object::uid_to_address(&arg0.id),
            vault_id : 0x2::object::id_to_address(&v6),
        };
        0x2::event::emit<VaultSubscribed>(v7);
    }

    public(friend) fun subscribed_vaults<T0>(arg0: &Index<T0>) : vector<address> {
        arg0.subscribed_vaults
    }

    public(friend) fun treasury_cap<T0>(arg0: &Index<T0>) : &0x2::coin::TreasuryCap<T0> {
        &arg0.treasury_cap
    }

    public fun unsubscribe_vault<T0, T1>(arg0: &mut Index<T0>, arg1: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg2: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T1>, arg3: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::admin::AdminCap) {
        0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::version::assert_current_version(&arg0.version);
        assert_index_is_not_locked<T0>(arg0);
        let v0 = 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::get_asset_id<T1>(arg1);
        assert!(0x1::vector::contains<u64>(&arg0.assets, &v0), 13906834844358279167);
        let v1 = 0x2::object::id<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T1>>(arg2);
        let v2 = 0x2::object::id_to_address(&v1);
        assert!(0x1::vector::contains<address>(&arg0.subscribed_vaults, &v2), 13906834848653246463);
        let v3 = 0x2::object::id<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T1>>(arg2);
        let v4 = 0x2::object::id_to_address(&v3);
        let (_, v6) = 0x1::vector::index_of<address>(&arg0.subscribed_vaults, &v4);
        let v7 = 0;
        assert!(0x1::vector::borrow<u64>(&arg0.weights, v6) == &v7, 715);
        0x1::vector::remove<address>(&mut arg0.subscribed_vaults, v6);
        0x1::vector::remove<u64>(&mut arg0.assets, v0);
        0x1::vector::remove<u64>(&mut arg0.weights, v0);
        let v8 = 0x2::object::id<0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T1>>(arg2);
        let v9 = VaultUnsubscribed{
            index_id : 0x2::object::uid_to_address(&arg0.id),
            vault_id : 0x2::object::id_to_address(&v8),
        };
        0x2::event::emit<VaultUnsubscribed>(v9);
    }

    public(friend) fun vaults<T0>(arg0: &Index<T0>) : vector<address> {
        arg0.subscribed_vaults
    }

    public(friend) fun weights<T0>(arg0: &Index<T0>) : vector<u64> {
        arg0.weights
    }

    public fun withdraw_fee<T0, T1>(arg0: &Index<T0>, arg1: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::Vault<T1>, arg2: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::asset_registry::AssetRegistry, arg3: &mut 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::balances_registry::BalancesRegistry, arg4: &0x2::clock::Clock, arg5: &0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::admin::AdminCap, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::object::id<Index<T0>>(arg0);
        0x2::coin::from_balance<T1>(0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::withdraw_fee<T1>(arg1, arg2, arg3, 0x2::object::id_to_address(&v0), 0x1269ebf4edc63a9d4df8469bfd386938f4d71543734ae0cf0398630461085f02::vault::index_product(), arg4, arg6), arg6)
    }

    // decompiled from Move bytecode v6
}

