module 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::basket_yield {
    struct BasketAsset has copy, drop, store {
        asset: 0x1::type_name::TypeName,
        weight_bps: u64,
    }

    struct BasketConfig has copy, drop, store {
        assets: vector<BasketAsset>,
        equal_weight: bool,
        payout_mode: u8,
    }

    struct BasketHolder has drop, store {
        amount: u64,
    }

    struct AssetPotKey has copy, drop, store {
        asset: 0x1::type_name::TypeName,
    }

    struct AssetPot<phantom T0> has store {
        bal: 0x2::balance::Balance<T0>,
    }

    struct HolderAssetKey has copy, drop, store {
        who: address,
        asset: 0x1::type_name::TypeName,
    }

    struct AssetAcc has drop, store {
        debt: u256,
        unpaid: u64,
    }

    struct BasketYieldVault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        lock_id: 0x2::object::ID,
        bluefin_pool_id: 0x2::object::ID,
        config: BasketConfig,
        holders: 0x2::table::Table<address, BasketHolder>,
        total_registered: u64,
        quote_staging: 0x2::balance::Balance<T1>,
        mps: u256,
        rotate_index: u64,
        asset_mps: 0x2::table::Table<0x1::type_name::TypeName, u256>,
        asset_acc: 0x2::table::Table<HolderAssetKey, AssetAcc>,
    }

    fun accrue_all_assets<T0, T1>(arg0: &mut BasketYieldVault<T0, T1>, arg1: address) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<BasketAsset>(&arg0.config.assets)) {
            let v1 = 0x1::vector::borrow<BasketAsset>(&arg0.config.assets, v0).asset;
            accrue_asset<T0, T1>(arg0, arg1, v1);
            v0 = v0 + 1;
        };
    }

    fun accrue_asset<T0, T1>(arg0: &mut BasketYieldVault<T0, T1>, arg1: address, arg2: 0x1::type_name::TypeName) {
        if (!0x2::table::contains<address, BasketHolder>(&arg0.holders, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow<address, BasketHolder>(&arg0.holders, arg1).amount;
        let v1 = asset_mps_of<T0, T1>(arg0, arg2);
        ensure_asset_acc<T0, T1>(arg0, arg1, arg2);
        let v2 = HolderAssetKey{
            who   : arg1,
            asset : arg2,
        };
        let v3 = 0x2::table::borrow_mut<HolderAssetKey, AssetAcc>(&mut arg0.asset_acc, v2);
        let v4 = (v0 as u256) * v1;
        if (v4 > v3.debt) {
            v3.unpaid = v3.unpaid + u256_to_u64((v4 - v3.debt) / 1000000000000);
        };
        v3.debt = v4;
    }

    public fun advance_rotation<T0, T1>(arg0: &mut BasketYieldVault<T0, T1>, arg1: &0x2::clock::Clock) {
        assert!(arg0.config.payout_mode == 1, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::basket_mode());
        let v0 = 0x1::vector::length<BasketAsset>(&arg0.config.assets);
        assert!(v0 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::basket_empty());
        let v1 = arg0.rotate_index;
        let v2 = (v1 + 1) % v0;
        arg0.rotate_index = v2;
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::events::emit_basket_yield_rotate(arg0.lock_id, 0x2::object::id<BasketYieldVault<T0, T1>>(arg0), v1, v2, 0x1::vector::borrow<BasketAsset>(&arg0.config.assets, v2).asset, 0x2::clock::timestamp_ms(arg1));
    }

    public fun assert_asset_in_config(arg0: &BasketConfig, arg1: 0x1::type_name::TypeName) {
        assert!(config_contains_asset(arg0, arg1), 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::unknown_rwa());
    }

    public fun assert_bound_to_lock<T0, T1>(arg0: &BasketYieldVault<T0, T1>, arg1: 0x2::object::ID) {
        assert!(arg0.lock_id == arg1, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::wrong_basket());
    }

    public fun asset_mps_of<T0, T1>(arg0: &BasketYieldVault<T0, T1>, arg1: 0x1::type_name::TypeName) : u256 {
        if (!0x2::table::contains<0x1::type_name::TypeName, u256>(&arg0.asset_mps, arg1)) {
            0
        } else {
            *0x2::table::borrow<0x1::type_name::TypeName, u256>(&arg0.asset_mps, arg1)
        }
    }

    public fun asset_type(arg0: &BasketAsset) : 0x1::type_name::TypeName {
        arg0.asset
    }

    public fun asset_weight_bps(arg0: &BasketAsset) : u64 {
        arg0.weight_bps
    }

    public fun bluefin_pool_id<T0, T1>(arg0: &BasketYieldVault<T0, T1>) : 0x2::object::ID {
        arg0.bluefin_pool_id
    }

    public fun bps() : u64 {
        10000
    }

    public fun claim_all<T0, T1, T2>(arg0: &mut BasketYieldVault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(arg0.config.payout_mode == 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::basket_mode());
        claim_asset_inner<T0, T1, T2>(arg0, arg1)
    }

    public fun claim_asset<T0, T1, T2>(arg0: &mut BasketYieldVault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        claim_asset_inner<T0, T1, T2>(arg0, arg1)
    }

    fun claim_asset_inner<T0, T1, T2>(arg0: &mut BasketYieldVault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::type_name::with_defining_ids<T2>();
        assert_asset_in_config(&arg0.config, v1);
        assert!(0x2::table::contains<address, BasketHolder>(&arg0.holders, v0), 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::nothing_to_claim());
        accrue_asset<T0, T1>(arg0, v0, v1);
        let v2 = HolderAssetKey{
            who   : v0,
            asset : v1,
        };
        assert!(0x2::table::contains<HolderAssetKey, AssetAcc>(&arg0.asset_acc, v2), 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::nothing_to_claim());
        let v3 = 0x2::table::borrow_mut<HolderAssetKey, AssetAcc>(&mut arg0.asset_acc, v2);
        let v4 = v3.unpaid;
        v3.unpaid = 0;
        assert!(v4 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::nothing_to_claim());
        let v5 = AssetPotKey{asset: v1};
        assert!(0x2::dynamic_field::exists<AssetPotKey>(&arg0.id, v5), 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::nothing_to_claim());
        let v6 = AssetPotKey{asset: v1};
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::events::emit_basket_yield_claim(arg0.lock_id, 0x2::object::id<BasketYieldVault<T0, T1>>(arg0), v0, v1, v4, arg0.config.payout_mode);
        0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut 0x2::dynamic_field::borrow_mut<AssetPotKey, AssetPot<T2>>(&mut arg0.id, v6).bal, v4), arg1)
    }

    public fun claim_rotating<T0, T1, T2>(arg0: &mut BasketYieldVault<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(arg0.config.payout_mode == 1, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::basket_mode());
        let v0 = arg0.rotate_index;
        assert!(v0 < 0x1::vector::length<BasketAsset>(&arg0.config.assets), 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::bad_param());
        assert!(0x1::vector::borrow<BasketAsset>(&arg0.config.assets, v0).asset == 0x1::type_name::with_defining_ids<T2>(), 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::unknown_rwa());
        let v1 = claim_asset_inner<T0, T1, T2>(arg0, arg2);
        advance_rotation<T0, T1>(arg0, arg1);
        v1
    }

    public fun config_asset_count(arg0: &BasketConfig) : u64 {
        0x1::vector::length<BasketAsset>(&arg0.assets)
    }

    public fun config_assets(arg0: &BasketConfig) : &vector<BasketAsset> {
        &arg0.assets
    }

    public fun config_contains_asset(arg0: &BasketConfig, arg1: 0x1::type_name::TypeName) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<BasketAsset>(&arg0.assets)) {
            if (0x1::vector::borrow<BasketAsset>(&arg0.assets, v0).asset == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun config_equal_weight(arg0: &BasketConfig) : bool {
        arg0.equal_weight
    }

    public fun config_payout_mode(arg0: &BasketConfig) : u8 {
        arg0.payout_mode
    }

    public fun convert_stub<T0, T1>(arg0: &mut BasketYieldVault<T0, T1>) {
        abort 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::retired()
    }

    public(friend) fun create_and_share<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: BasketConfig, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        validate_config(&arg2);
        let v0 = BasketYieldVault<T0, T1>{
            id               : 0x2::object::new(arg3),
            lock_id          : arg0,
            bluefin_pool_id  : arg1,
            config           : arg2,
            holders          : 0x2::table::new<address, BasketHolder>(arg3),
            total_registered : 0,
            quote_staging    : 0x2::balance::zero<T1>(),
            mps              : 0,
            rotate_index     : 0,
            asset_mps        : 0x2::table::new<0x1::type_name::TypeName, u256>(arg3),
            asset_acc        : 0x2::table::new<HolderAssetKey, AssetAcc>(arg3),
        };
        0x2::transfer::share_object<BasketYieldVault<T0, T1>>(v0);
        0x2::object::id<BasketYieldVault<T0, T1>>(&v0)
    }

    public(friend) fun create_vault_for_lock<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: BasketConfig, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        create_and_share<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun deposit_converted_asset<T0, T1, T2>(arg0: &mut BasketYieldVault<T0, T1>, arg1: 0x2::coin::Coin<T2>, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        assert_asset_in_config(&arg0.config, v0);
        let v1 = 0x2::coin::value<T2>(&arg1);
        assert!(v1 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::zero_amount());
        assert!(arg0.total_registered > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::no_holders());
        ensure_asset_pot<T0, T1, T2>(arg0, v0);
        let v2 = AssetPotKey{asset: v0};
        0x2::balance::join<T2>(&mut 0x2::dynamic_field::borrow_mut<AssetPotKey, AssetPot<T2>>(&mut arg0.id, v2).bal, 0x2::coin::into_balance<T2>(arg1));
        if (!0x2::table::contains<0x1::type_name::TypeName, u256>(&arg0.asset_mps, v0)) {
            0x2::table::add<0x1::type_name::TypeName, u256>(&mut arg0.asset_mps, v0, 0);
        };
        let v3 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u256>(&mut arg0.asset_mps, v0);
        *v3 = *v3 + (v1 as u256) * 1000000000000 / (arg0.total_registered as u256);
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::events::emit_basket_yield_converted(arg0.lock_id, 0x2::object::id<BasketYieldVault<T0, T1>>(arg0), 0x1::type_name::with_defining_ids<T1>(), arg2, v0, v1, 0x2::clock::timestamp_ms(arg3));
    }

    public fun effective_weight_bps(arg0: &BasketConfig, arg1: u64) : u64 {
        if (arg0.equal_weight) {
            equal_weight_bps(arg0, arg1)
        } else {
            0x1::vector::borrow<BasketAsset>(&arg0.assets, arg1).weight_bps
        }
    }

    fun ensure_asset_acc<T0, T1>(arg0: &mut BasketYieldVault<T0, T1>, arg1: address, arg2: 0x1::type_name::TypeName) {
        let v0 = HolderAssetKey{
            who   : arg1,
            asset : arg2,
        };
        if (!0x2::table::contains<HolderAssetKey, AssetAcc>(&arg0.asset_acc, v0)) {
            let v1 = AssetAcc{
                debt   : 0,
                unpaid : 0,
            };
            0x2::table::add<HolderAssetKey, AssetAcc>(&mut arg0.asset_acc, v0, v1);
        };
    }

    fun ensure_asset_pot<T0, T1, T2>(arg0: &mut BasketYieldVault<T0, T1>, arg1: 0x1::type_name::TypeName) {
        let v0 = AssetPotKey{asset: arg1};
        if (!0x2::dynamic_field::exists<AssetPotKey>(&arg0.id, v0)) {
            let v1 = AssetPot<T2>{bal: 0x2::balance::zero<T2>()};
            0x2::dynamic_field::add<AssetPotKey, AssetPot<T2>>(&mut arg0.id, v0, v1);
        };
    }

    fun ensure_holder<T0, T1>(arg0: &mut BasketYieldVault<T0, T1>, arg1: address) {
        if (!0x2::table::contains<address, BasketHolder>(&arg0.holders, arg1)) {
            let v0 = BasketHolder{amount: 0};
            0x2::table::add<address, BasketHolder>(&mut arg0.holders, arg1, v0);
        };
    }

    public fun equal_weight_bps(arg0: &BasketConfig, arg1: u64) : u64 {
        let v0 = 0x1::vector::length<BasketAsset>(&arg0.assets);
        assert!(v0 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::basket_empty());
        assert!(arg1 < v0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::bad_param());
        if (arg1 + 1 == v0) {
            10000 - 10000 / v0 * (v0 - 1)
        } else {
            10000 / v0
        }
    }

    public fun holder_amount<T0, T1>(arg0: &BasketYieldVault<T0, T1>, arg1: address) : u64 {
        if (!0x2::table::contains<address, BasketHolder>(&arg0.holders, arg1)) {
            0
        } else {
            0x2::table::borrow<address, BasketHolder>(&arg0.holders, arg1).amount
        }
    }

    public fun lock_id<T0, T1>(arg0: &BasketYieldVault<T0, T1>) : 0x2::object::ID {
        arg0.lock_id
    }

    public fun max_assets() : u64 {
        3
    }

    public fun mps<T0, T1>(arg0: &BasketYieldVault<T0, T1>) : u256 {
        arg0.mps
    }

    public fun new_asset(arg0: 0x1::type_name::TypeName, arg1: u64) : BasketAsset {
        BasketAsset{
            asset      : arg0,
            weight_bps : arg1,
        }
    }

    public fun new_config(arg0: vector<BasketAsset>, arg1: bool, arg2: u8) : BasketConfig {
        let v0 = BasketConfig{
            assets       : arg0,
            equal_weight : arg1,
            payout_mode  : arg2,
        };
        validate_config(&v0);
        v0
    }

    public fun payout_all_at_once() : u8 {
        0
    }

    public fun payout_rotating() : u8 {
        1
    }

    public fun pending_asset<T0, T1, T2>(arg0: &BasketYieldVault<T0, T1>, arg1: address) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        if (!0x2::table::contains<address, BasketHolder>(&arg0.holders, arg1)) {
            return 0
        };
        let v1 = HolderAssetKey{
            who   : arg1,
            asset : v0,
        };
        let (v2, v3) = if (0x2::table::contains<HolderAssetKey, AssetAcc>(&arg0.asset_acc, v1)) {
            let v4 = 0x2::table::borrow<HolderAssetKey, AssetAcc>(&arg0.asset_acc, v1);
            (v4.debt, v4.unpaid)
        } else {
            (0, 0)
        };
        let v5 = (0x2::table::borrow<address, BasketHolder>(&arg0.holders, arg1).amount as u256) * asset_mps_of<T0, T1>(arg0, v0);
        let v6 = if (v5 > v2) {
            u256_to_u64((v5 - v2) / 1000000000000)
        } else {
            0
        };
        v3 + v6
    }

    public fun pending_quote_normalized<T0, T1>(arg0: &BasketYieldVault<T0, T1>, arg1: address) : u64 {
        if (!0x2::table::contains<address, BasketHolder>(&arg0.holders, arg1) || arg0.total_registered == 0) {
            return 0
        };
        (((0x2::balance::value<T1>(&arg0.quote_staging) as u128) * (0x2::table::borrow<address, BasketHolder>(&arg0.holders, arg1).amount as u128) / (arg0.total_registered as u128)) as u64)
    }

    public fun pot_value<T0, T1, T2>(arg0: &BasketYieldVault<T0, T1>) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        let v1 = AssetPotKey{asset: v0};
        if (!0x2::dynamic_field::exists<AssetPotKey>(&arg0.id, v1)) {
            0
        } else {
            let v3 = AssetPotKey{asset: v0};
            0x2::balance::value<T2>(&0x2::dynamic_field::borrow<AssetPotKey, AssetPot<T2>>(&arg0.id, v3).bal)
        }
    }

    public fun quote_share_for_index(arg0: &BasketConfig, arg1: u64, arg2: u64) : u64 {
        (((arg2 as u128) * (effective_weight_bps(arg0, arg1) as u128) / (10000 as u128)) as u64)
    }

    public fun quote_staging_value<T0, T1>(arg0: &BasketYieldVault<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.quote_staging)
    }

    fun reset_asset_debts<T0, T1>(arg0: &mut BasketYieldVault<T0, T1>, arg1: address, arg2: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<BasketAsset>(&arg0.config.assets)) {
            let v1 = 0x1::vector::borrow<BasketAsset>(&arg0.config.assets, v0).asset;
            let v2 = asset_mps_of<T0, T1>(arg0, v1);
            ensure_asset_acc<T0, T1>(arg0, arg1, v1);
            let v3 = HolderAssetKey{
                who   : arg1,
                asset : v1,
            };
            0x2::table::borrow_mut<HolderAssetKey, AssetAcc>(&mut arg0.asset_acc, v3).debt = (arg2 as u256) * v2;
            v0 = v0 + 1;
        };
    }

    public fun rotate_index<T0, T1>(arg0: &BasketYieldVault<T0, T1>) : u64 {
        arg0.rotate_index
    }

    public fun sync_registration<T0, T1>(arg0: &mut BasketYieldVault<T0, T1>, arg1: &0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<T0>(arg1);
        ensure_holder<T0, T1>(arg0, v0);
        accrue_all_assets<T0, T1>(arg0, v0);
        let v2 = 0x2::table::borrow_mut<address, BasketHolder>(&mut arg0.holders, v0);
        let v3 = v2.amount;
        if (v1 >= v3) {
            arg0.total_registered = arg0.total_registered + v1 - v3;
        } else {
            arg0.total_registered = arg0.total_registered - v3 - v1;
        };
        v2.amount = v1;
        reset_asset_debts<T0, T1>(arg0, v0, v1);
    }

    public fun take_quote_for_convert<T0, T1>(arg0: &mut BasketYieldVault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg1 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::zero_amount());
        assert!(arg1 <= 0x2::balance::value<T1>(&arg0.quote_staging), 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::bad_param());
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.quote_staging, arg1), arg2)
    }

    public fun total_registered<T0, T1>(arg0: &BasketYieldVault<T0, T1>) : u64 {
        arg0.total_registered
    }

    public(friend) fun try_fund_quote<T0, T1>(arg0: &mut BasketYieldVault<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::value<T1>(&arg1);
        if (v0 == 0 || arg0.total_registered == 0) {
            return arg1
        };
        0x2::balance::join<T1>(&mut arg0.quote_staging, arg1);
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::events::emit_basket_yield_funded(arg0.lock_id, 0x2::object::id<BasketYieldVault<T0, T1>>(arg0), arg0.bluefin_pool_id, 0x1::type_name::with_defining_ids<T1>(), v0, 0x2::clock::timestamp_ms(arg2));
        0x2::balance::zero<T1>()
    }

    fun u256_to_u64(arg0: u256) : u64 {
        assert!(arg0 <= 18446744073709551615, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::overflow());
        (arg0 as u64)
    }

    public fun validate_config(arg0: &BasketConfig) {
        let v0 = 0x1::vector::length<BasketAsset>(&arg0.assets);
        assert!(v0 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::basket_empty());
        assert!(v0 <= 3, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::basket_bad_weights());
        assert!(arg0.payout_mode == 0 || arg0.payout_mode == 1, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::basket_mode());
        let v1 = 0x2::vec_set::empty<0x1::type_name::TypeName>();
        let v2 = 0;
        let v3 = 0;
        while (v2 < v0) {
            let v4 = 0x1::vector::borrow<BasketAsset>(&arg0.assets, v2);
            assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&v1, &v4.asset), 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::basket_bad_weights());
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v1, v4.asset);
            if (!arg0.equal_weight) {
                assert!(v4.weight_bps > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::basket_bad_weights());
                v3 = v3 + v4.weight_bps;
            };
            v2 = v2 + 1;
        };
        if (!arg0.equal_weight) {
            assert!(v3 == 10000, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::basket_bad_weights());
        };
    }

    public fun vault_config<T0, T1>(arg0: &BasketYieldVault<T0, T1>) : &BasketConfig {
        &arg0.config
    }

    // decompiled from Move bytecode v7
}

