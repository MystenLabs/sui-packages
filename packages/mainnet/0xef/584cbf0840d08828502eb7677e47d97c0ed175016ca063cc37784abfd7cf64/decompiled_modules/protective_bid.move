module 0xef584cbf0840d08828502eb7677e47d97c0ed175016ca063cc37784abfd7cf64::protective_bid {
    struct ProtectiveBid<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        account_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        dao_amm_asset_principal: 0x1::option::Option<u64>,
        dao_amm_stable_principal: 0x1::option::Option<u64>,
        base_fee_bps: u64,
        surge_fee_bps: u64,
        surge_end_ms: u64,
        created_at_ms: u64,
        vault_admin_cap: 0x1::option::Option<0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::vault::VaultAdminCap>,
        reserved_amount: u64,
        nav_discount_bps: u64,
        base_bought_amount: u64,
        fees_collected: u64,
        seq_num: u64,
        release_deadline_ms: u64,
        active: bool,
        snapshot_backing: u64,
        snapshot_circulating: u64,
    }

    struct ProtectiveBidCreated has copy, drop {
        bid_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        base_fee_bps: u64,
        surge_fee_bps: u64,
        surge_end_ms: u64,
        reserved_amount: u64,
        nav_discount_bps: u64,
        release_deadline_ms: u64,
    }

    struct TokensSoldToBid has copy, drop {
        bid_id: 0x2::object::ID,
        seller: address,
        tokens_sold: u64,
        stable_received: u64,
        fee_amount: u64,
        nav_at_sale: u64,
        post_reserved_amount: u64,
        post_base_bought_amount: u64,
        seq_num: u64,
    }

    struct BidReleased has copy, drop {
        bid_id: 0x2::object::ID,
        final_reserved_amount: u64,
        final_base_bought: u64,
        final_fees_collected: u64,
    }

    public fun account_id<T0, T1>(arg0: &ProtectiveBid<T0, T1>) : 0x2::object::ID {
        arg0.account_id
    }

    public fun base_bought_amount<T0, T1>(arg0: &ProtectiveBid<T0, T1>) : u64 {
        arg0.base_bought_amount
    }

    public fun base_fee_bps<T0, T1>(arg0: &ProtectiveBid<T0, T1>) : u64 {
        arg0.base_fee_bps
    }

    public fun calculate_nav<T0: store, T1, T2, T3>(arg0: &ProtectiveBid<T1, T2>, arg1: &0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::account::Account, arg2: &0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::package_registry::PackageRegistry, arg3: &0xef584cbf0840d08828502eb7677e47d97c0ed175016ca063cc37784abfd7cf64::unified_spot_pool::UnifiedSpotPool<T1, T2, T3>) : u64 {
        if (0x2::object::id<0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::account::Account>(arg1) != arg0.account_id) {
            return 0
        };
        if (0x2::object::id<0xef584cbf0840d08828502eb7677e47d97c0ed175016ca063cc37784abfd7cf64::unified_spot_pool::UnifiedSpotPool<T1, T2, T3>>(arg3) != arg0.pool_id) {
            return 0
        };
        let v0 = 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::currency::coin_type_supply<T1>(arg1, arg2);
        let v1 = 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::vault::get_total_balance<T0, T1>(arg1, arg2);
        let (v2, v3) = dao_amm_principal_for_nav<T1, T2, T3>(arg0, arg3);
        if ((v0 as u128) < (v1 as u128) + (v2 as u128)) {
            return 0
        };
        let v4 = v0 - v1 - v2;
        if (v4 == 0) {
            return 0
        };
        let v5 = (((v3 as u128) + (0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::vault::get_total_balance<T0, T2>(arg1, arg2) as u128)) as u256) * (0x5d369bb8a96e9d5d3e9ed434f5d1ba3de449ce392dc574d23b86791e08ee2129::constants::price_precision_scale() as u256) / (v4 as u256);
        if (v5 > (18446744073709551615 as u256)) {
            (18446744073709551615 as u64)
        } else {
            (v5 as u64)
        }
    }

    public fun cancel<T0, T1>(arg0: &mut ProtectiveBid<T0, T1>, arg1: &mut 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::account::Account, arg2: &0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::package_registry::PackageRegistry, arg3: 0xef584cbf0840d08828502eb7677e47d97c0ed175016ca063cc37784abfd7cf64::spot_pool_mutation_auth::SpotPoolMutationAuth) {
        assert!(0xef584cbf0840d08828502eb7677e47d97c0ed175016ca063cc37784abfd7cf64::spot_pool_mutation_auth::target_id(&arg3) == arg0.pool_id, 22);
        assert!(arg0.active, 2);
        assert!(0x2::object::id<0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::account::Account>(arg1) == arg0.account_id, 7);
        deactivate_internal<T0, T1>(arg0, arg1, arg2);
    }

    public fun close<T0, T1>(arg0: &mut ProtectiveBid<T0, T1>, arg1: &mut 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::account::Account, arg2: &0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::package_registry::PackageRegistry, arg3: &0x2::clock::Clock) {
        assert!(arg0.active, 2);
        assert!(arg0.release_deadline_ms > 0, 23);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.release_deadline_ms, 3);
        assert!(0x2::object::id<0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::account::Account>(arg1) == arg0.account_id, 7);
        deactivate_internal<T0, T1>(arg0, arg1, arg2);
    }

    public fun create<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::vault::VaultAdminCap, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : ProtectiveBid<T0, T1> {
        assert!(arg2 <= 0x5d369bb8a96e9d5d3e9ed434f5d1ba3de449ce392dc574d23b86791e08ee2129::constants::max_protective_bid_fee_bps(), 9);
        assert!(arg3 <= 0x5d369bb8a96e9d5d3e9ed434f5d1ba3de449ce392dc574d23b86791e08ee2129::constants::max_protective_bid_fee_bps(), 9);
        assert!(arg8 < 10000, 24);
        if (arg3 > 0) {
            assert!(arg3 >= arg2, 9);
        };
        let v0 = 0x2::clock::timestamp_ms(arg9);
        let v1 = if (arg5 == 0) {
            0
        } else {
            v0 + arg5
        };
        let v2 = if (arg3 == 0 || arg4 == 0) {
            0
        } else {
            v0 + arg4
        };
        let v3 = ProtectiveBid<T0, T1>{
            id                       : 0x2::object::new(arg10),
            account_id               : arg0,
            pool_id                  : arg1,
            dao_amm_asset_principal  : 0x1::option::none<u64>(),
            dao_amm_stable_principal : 0x1::option::none<u64>(),
            base_fee_bps             : arg2,
            surge_fee_bps            : arg3,
            surge_end_ms             : v2,
            created_at_ms            : v0,
            vault_admin_cap          : 0x1::option::some<0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::vault::VaultAdminCap>(arg6),
            reserved_amount          : arg7,
            nav_discount_bps         : arg8,
            base_bought_amount       : 0,
            fees_collected           : 0,
            seq_num                  : 0,
            release_deadline_ms      : v1,
            active                   : true,
            snapshot_backing         : 0,
            snapshot_circulating     : 0,
        };
        let v4 = ProtectiveBidCreated{
            bid_id              : 0x2::object::id<ProtectiveBid<T0, T1>>(&v3),
            account_id          : arg0,
            pool_id             : arg1,
            base_fee_bps        : arg2,
            surge_fee_bps       : arg3,
            surge_end_ms        : v2,
            reserved_amount     : arg7,
            nav_discount_bps    : arg8,
            release_deadline_ms : v1,
        };
        0x2::event::emit<ProtectiveBidCreated>(v4);
        v3
    }

    public fun create_with_principal<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::vault::VaultAdminCap, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : ProtectiveBid<T0, T1> {
        assert!(arg2 <= 0x5d369bb8a96e9d5d3e9ed434f5d1ba3de449ce392dc574d23b86791e08ee2129::constants::max_protective_bid_fee_bps(), 9);
        assert!(arg3 <= 0x5d369bb8a96e9d5d3e9ed434f5d1ba3de449ce392dc574d23b86791e08ee2129::constants::max_protective_bid_fee_bps(), 9);
        assert!(arg10 < 10000, 24);
        if (arg3 > 0) {
            assert!(arg3 >= arg2, 9);
        };
        let v0 = 0x2::clock::timestamp_ms(arg11);
        let v1 = if (arg5 == 0) {
            0
        } else {
            v0 + arg5
        };
        let v2 = if (arg3 == 0 || arg4 == 0) {
            0
        } else {
            v0 + arg4
        };
        let v3 = ProtectiveBid<T0, T1>{
            id                       : 0x2::object::new(arg12),
            account_id               : arg0,
            pool_id                  : arg1,
            dao_amm_asset_principal  : 0x1::option::some<u64>(arg6),
            dao_amm_stable_principal : 0x1::option::some<u64>(arg7),
            base_fee_bps             : arg2,
            surge_fee_bps            : arg3,
            surge_end_ms             : v2,
            created_at_ms            : v0,
            vault_admin_cap          : 0x1::option::some<0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::vault::VaultAdminCap>(arg8),
            reserved_amount          : arg9,
            nav_discount_bps         : arg10,
            base_bought_amount       : 0,
            fees_collected           : 0,
            seq_num                  : 0,
            release_deadline_ms      : v1,
            active                   : true,
            snapshot_backing         : 0,
            snapshot_circulating     : 0,
        };
        let v4 = ProtectiveBidCreated{
            bid_id              : 0x2::object::id<ProtectiveBid<T0, T1>>(&v3),
            account_id          : arg0,
            pool_id             : arg1,
            base_fee_bps        : arg2,
            surge_fee_bps       : arg3,
            surge_end_ms        : v2,
            reserved_amount     : arg9,
            nav_discount_bps    : arg10,
            release_deadline_ms : v1,
        };
        0x2::event::emit<ProtectiveBidCreated>(v4);
        v3
    }

    public fun created_at_ms<T0, T1>(arg0: &ProtectiveBid<T0, T1>) : u64 {
        arg0.created_at_ms
    }

    public fun current_fee_bps<T0, T1>(arg0: &ProtectiveBid<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        current_fee_bps_at<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg1))
    }

    fun current_fee_bps_at<T0, T1>(arg0: &ProtectiveBid<T0, T1>, arg1: u64) : u64 {
        if (arg0.surge_end_ms == 0 || arg0.surge_fee_bps == 0) {
            return arg0.base_fee_bps
        };
        if (arg1 >= arg0.surge_end_ms) {
            return arg0.base_fee_bps
        };
        let v0 = arg0.surge_end_ms - arg0.created_at_ms;
        if (v0 == 0) {
            return arg0.base_fee_bps
        };
        let v1 = if (arg0.surge_fee_bps > arg0.base_fee_bps) {
            ((((arg0.surge_fee_bps - arg0.base_fee_bps) as u128) * ((arg0.surge_end_ms - arg1) as u128) / (v0 as u128)) as u64)
        } else {
            0
        };
        arg0.base_fee_bps + v1
    }

    fun dao_amm_principal_for_nav<T0, T1, T2>(arg0: &ProtectiveBid<T0, T1>, arg1: &0xef584cbf0840d08828502eb7677e47d97c0ed175016ca063cc37784abfd7cf64::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>) : (u64, u64) {
        if (0x1::option::is_some<u64>(&arg0.dao_amm_asset_principal) || 0x1::option::is_some<u64>(&arg0.dao_amm_stable_principal)) {
            assert!(0x1::option::is_some<u64>(&arg0.dao_amm_asset_principal) && 0x1::option::is_some<u64>(&arg0.dao_amm_stable_principal), 20);
            return (*0x1::option::borrow<u64>(&arg0.dao_amm_asset_principal), *0x1::option::borrow<u64>(&arg0.dao_amm_stable_principal))
        };
        let (v0, v1) = 0xef584cbf0840d08828502eb7677e47d97c0ed175016ca063cc37784abfd7cf64::unified_spot_pool::get_initial_reserves<T0, T1, T2>(arg1);
        let v2 = v1;
        let v3 = v0;
        assert!(0x1::option::is_some<u64>(&v3) && 0x1::option::is_some<u64>(&v2), 19);
        (*0x1::option::borrow<u64>(&v3), *0x1::option::borrow<u64>(&v2))
    }

    fun deactivate_internal<T0, T1>(arg0: &mut ProtectiveBid<T0, T1>, arg1: &mut 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::account::Account, arg2: &0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::package_registry::PackageRegistry) {
        assert!(0x1::option::is_some<0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::vault::VaultAdminCap>(&arg0.vault_admin_cap), 26);
        0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::vault::destroy_vault_admin_cap(0x1::option::extract<0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::vault::VaultAdminCap>(&mut arg0.vault_admin_cap));
        arg0.active = false;
        0xef584cbf0840d08828502eb7677e47d97c0ed175016ca063cc37784abfd7cf64::protective_bid_registry::clear_with_package_witness(arg1, arg2, 0x2::object::id<ProtectiveBid<T0, T1>>(arg0));
        let v0 = BidReleased{
            bid_id                : 0x2::object::id<ProtectiveBid<T0, T1>>(arg0),
            final_reserved_amount : arg0.reserved_amount,
            final_base_bought     : arg0.base_bought_amount,
            final_fees_collected  : arg0.fees_collected,
        };
        0x2::event::emit<BidReleased>(v0);
    }

    public fun emergency_deactivate<T0, T1>(arg0: &mut ProtectiveBid<T0, T1>, arg1: &mut 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::account::Account, arg2: &0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::package_registry::PackageRegistry, arg3: &0x664a0e25093ade2eb071799f7b24a821a5eeb6f355986f6bc15c582b60d0c6a0::emergency_cap::EmergencyCap, arg4: &0x2::clock::Clock) {
        0x664a0e25093ade2eb071799f7b24a821a5eeb6f355986f6bc15c582b60d0c6a0::emergency_cap::assert_ready(arg3, arg4);
        if (0x1::option::is_some<0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::vault::VaultAdminCap>(&arg0.vault_admin_cap)) {
            0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::vault::destroy_vault_admin_cap(0x1::option::extract<0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::vault::VaultAdminCap>(&mut arg0.vault_admin_cap));
        };
        arg0.active = false;
        0xef584cbf0840d08828502eb7677e47d97c0ed175016ca063cc37784abfd7cf64::protective_bid_registry::clear_with_package_witness(arg1, arg2, 0x2::object::id<ProtectiveBid<T0, T1>>(arg0));
    }

    public fun fees_collected<T0, T1>(arg0: &ProtectiveBid<T0, T1>) : u64 {
        arg0.fees_collected
    }

    public fun is_active<T0, T1>(arg0: &ProtectiveBid<T0, T1>) : bool {
        arg0.active
    }

    public fun nav_discount_bps<T0, T1>(arg0: &ProtectiveBid<T0, T1>) : u64 {
        arg0.nav_discount_bps
    }

    public fun pool_id<T0, T1>(arg0: &ProtectiveBid<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun precision() : u64 {
        0x5d369bb8a96e9d5d3e9ed434f5d1ba3de449ce392dc574d23b86791e08ee2129::constants::price_precision_scale()
    }

    public fun quote_sell<T0: store, T1, T2, T3>(arg0: &ProtectiveBid<T1, T2>, arg1: &0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::account::Account, arg2: &0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::package_registry::PackageRegistry, arg3: &0xef584cbf0840d08828502eb7677e47d97c0ed175016ca063cc37784abfd7cf64::unified_spot_pool::UnifiedSpotPool<T1, T2, T3>, arg4: u64, arg5: &0x2::clock::Clock) : u64 {
        if (!arg0.active) {
            return 0
        };
        if (arg4 == 0) {
            return 0
        };
        if (arg0.reserved_amount == 0) {
            return 0
        };
        if (arg0.release_deadline_ms > 0 && 0x2::clock::timestamp_ms(arg5) >= arg0.release_deadline_ms) {
            return 0
        };
        if (0x2::object::id<0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::account::Account>(arg1) != arg0.account_id) {
            return 0
        };
        if (0x2::object::id<0xef584cbf0840d08828502eb7677e47d97c0ed175016ca063cc37784abfd7cf64::unified_spot_pool::UnifiedSpotPool<T1, T2, T3>>(arg3) != arg0.pool_id) {
            return 0
        };
        if (0xef584cbf0840d08828502eb7677e47d97c0ed175016ca063cc37784abfd7cf64::unified_spot_pool::is_locked_for_proposal<T1, T2, T3>(arg3)) {
            return 0
        };
        let v0 = 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::currency::coin_type_supply<T1>(arg1, arg2);
        let v1 = 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::vault::get_total_balance<T0, T1>(arg1, arg2);
        let (v2, v3) = dao_amm_principal_for_nav<T1, T2, T3>(arg0, arg3);
        if ((v0 as u128) < (v1 as u128) + (v2 as u128)) {
            return 0
        };
        let v4 = v0 - v1 - v2;
        if (v4 == 0) {
            return 0
        };
        let v5 = if (arg0.nav_discount_bps == 0) {
            (v3 as u128) + (0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::vault::get_total_balance<T0, T2>(arg1, arg2) as u128)
        } else {
            ((v3 as u128) + (0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::vault::get_total_balance<T0, T2>(arg1, arg2) as u128)) * ((10000 - arg0.nav_discount_bps) as u128) / 10000
        };
        let v6 = (((arg4 as u256) * (v5 as u256) / (v4 as u256)) as u64);
        if (v6 > arg0.reserved_amount) {
            return 0
        };
        let v7 = (((v6 as u128) * (current_fee_bps_at<T1, T2>(arg0, 0x2::clock::timestamp_ms(arg5)) as u128) / 10000) as u64);
        if (v6 > v7) {
            v6 - v7
        } else {
            0
        }
    }

    public fun release_deadline_ms<T0, T1>(arg0: &ProtectiveBid<T0, T1>) : u64 {
        arg0.release_deadline_ms
    }

    public fun reserved_amount<T0, T1>(arg0: &ProtectiveBid<T0, T1>) : u64 {
        arg0.reserved_amount
    }

    public fun sell_to_bid<T0: store, T1: drop, T2, T3>(arg0: &mut ProtectiveBid<T1, T2>, arg1: &mut 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::account::Account, arg2: &0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::package_registry::PackageRegistry, arg3: &0xef584cbf0840d08828502eb7677e47d97c0ed175016ca063cc37784abfd7cf64::unified_spot_pool::UnifiedSpotPool<T1, T2, T3>, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x664a0e25093ade2eb071799f7b24a821a5eeb6f355986f6bc15c582b60d0c6a0::futarchy_config::assert_not_terminated(0x664a0e25093ade2eb071799f7b24a821a5eeb6f355986f6bc15c582b60d0c6a0::futarchy_config::dao_state(0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::account::config<0x664a0e25093ade2eb071799f7b24a821a5eeb6f355986f6bc15c582b60d0c6a0::futarchy_config::FutarchyConfig>(arg1)));
        assert!(arg0.active, 2);
        assert!(0x2::object::id<0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::account::Account>(arg1) == arg0.account_id, 7);
        assert!(0x2::object::id<0xef584cbf0840d08828502eb7677e47d97c0ed175016ca063cc37784abfd7cf64::unified_spot_pool::UnifiedSpotPool<T1, T2, T3>>(arg3) == arg0.pool_id, 16);
        assert!(!0xef584cbf0840d08828502eb7677e47d97c0ed175016ca063cc37784abfd7cf64::unified_spot_pool::is_locked_for_proposal<T1, T2, T3>(arg3), 15);
        if (arg0.release_deadline_ms > 0) {
            assert!(0x2::clock::timestamp_ms(arg5) < arg0.release_deadline_ms, 14);
        };
        assert!(arg0.reserved_amount > 0, 13);
        let v0 = 0x2::coin::value<T1>(&arg4);
        assert!(v0 > 0, 5);
        let v1 = 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::currency::coin_type_supply<T1>(arg1, arg2);
        let v2 = 0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::vault::get_total_balance<T0, T1>(arg1, arg2);
        let (v3, v4) = dao_amm_principal_for_nav<T1, T2, T3>(arg0, arg3);
        assert!((v1 as u128) >= (v2 as u128) + (v3 as u128), 17);
        let v5 = v1 - v2 - v3;
        assert!(v5 > 0, 8);
        assert!(v0 <= v5, 11);
        let v6 = (v4 as u128) + (0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::vault::get_total_balance<T0, T2>(arg1, arg2) as u128);
        let v7 = if (arg0.nav_discount_bps == 0) {
            v6
        } else {
            v6 * ((10000 - arg0.nav_discount_bps) as u128) / 10000
        };
        let v8 = (((v0 as u256) * (v7 as u256) / (v5 as u256)) as u64);
        assert!(arg0.reserved_amount >= v8, 1);
        let v9 = (((v8 as u128) * (current_fee_bps_at<T1, T2>(arg0, 0x2::clock::timestamp_ms(arg5)) as u128) / 10000) as u64);
        let v10 = v8 - v9;
        assert!(v10 > 0, 10);
        0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::currency::public_burn<T1>(arg1, arg2, arg4);
        arg0.reserved_amount = arg0.reserved_amount - v8;
        arg0.fees_collected = arg0.fees_collected + v9;
        arg0.base_bought_amount = arg0.base_bought_amount + v0;
        arg0.seq_num = arg0.seq_num + 1;
        let v11 = (v6 as u256) * (0x5d369bb8a96e9d5d3e9ed434f5d1ba3de449ce392dc574d23b86791e08ee2129::constants::price_precision_scale() as u256) / (v5 as u256);
        let v12 = if (v11 > (18446744073709551615 as u256)) {
            (18446744073709551615 as u64)
        } else {
            (v11 as u64)
        };
        let v13 = TokensSoldToBid{
            bid_id                  : 0x2::object::id<ProtectiveBid<T1, T2>>(arg0),
            seller                  : 0x2::tx_context::sender(arg6),
            tokens_sold             : v0,
            stable_received         : v10,
            fee_amount              : v9,
            nav_at_sale             : v12,
            post_reserved_amount    : arg0.reserved_amount,
            post_base_bought_amount : arg0.base_bought_amount,
            seq_num                 : arg0.seq_num,
        };
        0x2::event::emit<TokensSoldToBid>(v13);
        0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::vault::withdraw_with_admin_cap<T0, T2>(arg1, arg2, 0x1::option::borrow<0xeabe417719b67991896029b26cad43d8a5138109a577c0c56f174e0577e8fe00::vault::VaultAdminCap>(&arg0.vault_admin_cap), v10, arg6)
    }

    public fun seq_num<T0, T1>(arg0: &ProtectiveBid<T0, T1>) : u64 {
        arg0.seq_num
    }

    public fun surge_end_ms<T0, T1>(arg0: &ProtectiveBid<T0, T1>) : u64 {
        arg0.surge_end_ms
    }

    public fun surge_fee_bps<T0, T1>(arg0: &ProtectiveBid<T0, T1>) : u64 {
        arg0.surge_fee_bps
    }

    // decompiled from Move bytecode v6
}

