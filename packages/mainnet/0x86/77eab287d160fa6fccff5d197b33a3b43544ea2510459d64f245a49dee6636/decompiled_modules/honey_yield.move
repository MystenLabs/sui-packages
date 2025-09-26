module 0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::honey_yield {
    struct HoneyYield has key {
        id: 0x2::object::UID,
        sui_treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        honey_bought_back: 0x2::balance::Balance<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::honey::HONEY>,
        honey_to_burn: 0x2::balance::Balance<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::honey::HONEY>,
        decimal_precisions: 0x2::linked_table::LinkedTable<0x1::string::String, u8>,
        pool_fee_config: DefaultFeeInfo,
        fee_collectors: 0x2::linked_table::LinkedTable<0x1::ascii::String, address>,
        treasury_percent: u64,
        honey_buyback_pct: u64,
        honey_tax_pct: u64,
        creator_tax_pct: 0x2::linked_table::LinkedTable<0x1::ascii::String, u64>,
        bag: 0x2::bag::Bag,
        module_version: u64,
    }

    struct DefaultFeeInfo has store {
        weighted_pool_fee: FeeInfo,
        stable_pool_fee: FeeInfo,
        curved_pool_fee: FeeInfo,
    }

    struct FeeInfo has copy, store {
        total_fee_bps: u64,
        protocol_fee_pct: u64,
    }

    struct FeeCollector<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        creator_rewards: 0x2::balance::Balance<T0>,
    }

    struct TwoAmmAccess has store, key {
        id: 0x2::object::UID,
    }

    struct TreasuryClaimCap has store, key {
        id: 0x2::object::UID,
    }

    struct HoneyYieldAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct HoneyBoughtBackClaimCap has store, key {
        id: 0x2::object::UID,
    }

    struct TokenRulesClaimCap has store, key {
        id: 0x2::object::UID,
    }

    struct DecimalPrecisionForCoinTypesWhitelisted has copy, drop {
        coin_types: vector<0x1::string::String>,
        decimal_precisions: vector<u8>,
    }

    struct DefaultFeeSet has copy, drop {
        curve: 0x1::type_name::TypeName,
        total_fee_bps: u64,
        protocol_fee_pct: u64,
    }

    struct FeeDistributionPctUpdated has copy, drop {
        treasury_fee_percent: u64,
        honey_buyback_pct: u64,
    }

    struct TreasuryResourcesDistributed has copy, drop {
        amount: u64,
    }

    struct NewFeeCollectorKrafted has copy, drop {
        coin_type: 0x1::ascii::String,
        fee_collector_addr: address,
    }

    struct FeeCollectedForCoin has copy, drop {
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct CreatorRewardsAddedForCoin has copy, drop {
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct FeeExtractedForCoin has copy, drop {
        token: 0x1::ascii::String,
        amount: u64,
    }

    struct CreatorRewardsClaimed has copy, drop {
        token: 0x1::ascii::String,
        amount: u64,
    }

    struct HoneyBoughtBackWithdrawn has copy, drop {
        amount: u64,
    }

    struct HoneyTaxUpdated has copy, drop {
        tax_pct: u64,
    }

    struct AdminTaxForTokenUpdated has copy, drop {
        token: 0x1::ascii::String,
        tax_pct: u64,
    }

    struct PrecisionInfo has copy, store {
        coin_types: vector<0x1::string::String>,
        decimal_precision_list: vector<u8>,
        limit: u64,
    }

    struct FeeCollectorsInfo has copy, store {
        coin_types: vector<0x1::ascii::String>,
        fee_collector_addr_list: vector<address>,
        limit: u64,
    }

    struct PoolFeeInfo has copy, store {
        total_fee_bps: u64,
        protocol_fee_pct: u64,
    }

    struct FeeDistributionInfo has copy, store {
        treasury_percent: u64,
        honey_buyback_pct: u64,
    }

    struct FeeCollectorInfo has copy, store {
        protocol_fees: u64,
        creator_rewards: u64,
    }

    public fun add_honey_bought_back(arg0: &mut HoneyYield, arg1: 0x2::balance::Balance<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::honey::HONEY>) {
        0x2::balance::join<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::honey::HONEY>(&mut arg0.honey_bought_back, arg1);
    }

    public fun add_rewards_for_coin<T0>(arg0: &mut FeeCollector<T0>, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) > 0) {
            let v0 = CreatorRewardsAddedForCoin{
                token  : 0x1::type_name::with_defining_ids<T0>(),
                amount : 0x2::balance::value<T0>(&arg1),
            };
            0x2::event::emit<CreatorRewardsAddedForCoin>(v0);
        };
        0x2::balance::join<T0>(&mut arg0.creator_rewards, arg1);
    }

    public fun add_to_treasury(arg0: &mut HoneyYield, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_treasury, arg1);
    }

    public fun claim_creator_rewards<T0>(arg0: &TokenRulesClaimCap, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: &mut FeeCollector<T0>) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg2.creator_rewards);
        let v1 = CreatorRewardsClaimed{
            token  : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            amount : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<CreatorRewardsClaimed>(v1);
        v0
    }

    public fun collect_fee_for_coin<T0>(arg0: &mut FeeCollector<T0>, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) > 0) {
            let v0 = FeeCollectedForCoin{
                token  : 0x1::type_name::with_defining_ids<T0>(),
                amount : 0x2::balance::value<T0>(&arg1),
            };
            0x2::event::emit<FeeCollectedForCoin>(v0);
        };
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
    }

    public fun create_fee_collector<T0>(arg0: &TwoAmmAccess, arg1: &mut HoneyYield, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 4010);
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        if (0x2::linked_table::contains<0x1::ascii::String, address>(&arg1.fee_collectors, v0)) {
            return
        };
        let v1 = FeeCollector<T0>{
            id              : 0x2::derived_object::claim<0x1::ascii::String>(&mut arg1.id, v0),
            balance         : 0x2::balance::zero<T0>(),
            creator_rewards : 0x2::balance::zero<T0>(),
        };
        let v2 = 0x2::object::uid_to_address(&v1.id);
        0x2::linked_table::push_back<0x1::ascii::String, address>(&mut arg1.fee_collectors, v0, v2);
        0x2::linked_table::push_back<0x1::ascii::String, u64>(&mut arg1.creator_tax_pct, v0, 0);
        let v3 = NewFeeCollectorKrafted{
            coin_type          : v0,
            fee_collector_addr : v2,
        };
        0x2::event::emit<NewFeeCollectorKrafted>(v3);
        0x2::transfer::share_object<FeeCollector<T0>>(v1);
    }

    public fun deposit_honey_to_burn(arg0: &mut HoneyYield, arg1: 0x2::balance::Balance<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::honey::HONEY>) {
        assert!(arg0.module_version == 0, 4010);
        0x2::balance::join<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::honey::HONEY>(&mut arg0.honey_to_burn, arg1);
    }

    public fun entry_add_to_treasury(arg0: &mut HoneyYield, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 4010);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        add_to_treasury(arg0, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg2));
        if (0x2::balance::value<0x2::sui::SUI>(&v0) == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg3), 0x2::tx_context::sender(arg3));
    }

    public fun extract_fee_for_coin<T0>(arg0: &TwoAmmAccess, arg1: &mut FeeCollector<T0>) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg1.balance);
        let v1 = FeeExtractedForCoin{
            token  : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            amount : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<FeeExtractedForCoin>(v1);
        v0
    }

    public fun get_creator_tax_pct<T0>(arg0: &HoneyYield) : u64 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        if (0x2::linked_table::contains<0x1::ascii::String, u64>(&arg0.creator_tax_pct, v0)) {
            *0x2::linked_table::borrow<0x1::ascii::String, u64>(&arg0.creator_tax_pct, v0)
        } else {
            0
        }
    }

    public fun get_curved_pool_fee_info(arg0: &HoneyYield) : PoolFeeInfo {
        PoolFeeInfo{
            total_fee_bps    : arg0.pool_fee_config.curved_pool_fee.total_fee_bps,
            protocol_fee_pct : arg0.pool_fee_config.curved_pool_fee.protocol_fee_pct,
        }
    }

    public fun get_decimals_for_coin<T0>(arg0: &HoneyYield) : (bool, u8) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        if (0x2::linked_table::contains<0x1::string::String, u8>(&arg0.decimal_precisions, v0)) {
            (true, *0x2::linked_table::borrow<0x1::string::String, u8>(&arg0.decimal_precisions, v0))
        } else {
            (false, 0)
        }
    }

    public fun get_decimals_for_coin_type(arg0: &HoneyYield, arg1: 0x1::type_name::TypeName) : (bool, u8) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(arg1));
        if (0x2::linked_table::contains<0x1::string::String, u8>(&arg0.decimal_precisions, v0)) {
            (true, *0x2::linked_table::borrow<0x1::string::String, u8>(&arg0.decimal_precisions, v0))
        } else {
            (false, 0)
        }
    }

    public fun get_fee_collector_balances<T0>(arg0: &FeeCollector<T0>) : FeeCollectorInfo {
        FeeCollectorInfo{
            protocol_fees   : 0x2::balance::value<T0>(&arg0.balance),
            creator_rewards : 0x2::balance::value<T0>(&arg0.creator_rewards),
        }
    }

    public fun get_fee_collector_id<T0>(arg0: &HoneyYield) : address {
        *0x2::linked_table::borrow<0x1::ascii::String, address>(&arg0.fee_collectors, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))
    }

    public fun get_fee_collector_info<T0>(arg0: &FeeCollector<T0>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.balance), 0x2::balance::value<T0>(&arg0.creator_rewards))
    }

    public fun get_fee_info<T0>(arg0: &HoneyYield) : (u64, u64) {
        if (0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::curves::is_stable<T0>()) {
            return (arg0.pool_fee_config.stable_pool_fee.total_fee_bps, arg0.pool_fee_config.stable_pool_fee.protocol_fee_pct)
        };
        if (0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::curves::is_weighted<T0>()) {
            return (arg0.pool_fee_config.weighted_pool_fee.total_fee_bps, arg0.pool_fee_config.weighted_pool_fee.protocol_fee_pct)
        };
        if (0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::curves::is_curved<T0>()) {
            return (arg0.pool_fee_config.curved_pool_fee.total_fee_bps, arg0.pool_fee_config.curved_pool_fee.protocol_fee_pct)
        };
        (0, 0)
    }

    public fun get_honey_tax_pct(arg0: &HoneyYield) : u64 {
        arg0.honey_tax_pct
    }

    public fun get_stable_pool_fee_info(arg0: &HoneyYield) : PoolFeeInfo {
        PoolFeeInfo{
            total_fee_bps    : arg0.pool_fee_config.stable_pool_fee.total_fee_bps,
            protocol_fee_pct : arg0.pool_fee_config.stable_pool_fee.protocol_fee_pct,
        }
    }

    public fun get_sui_fee_distribution(arg0: &HoneyYield) : FeeDistributionInfo {
        FeeDistributionInfo{
            treasury_percent  : arg0.treasury_percent,
            honey_buyback_pct : arg0.honey_buyback_pct,
        }
    }

    public fun get_sui_fee_distribution_info(arg0: &HoneyYield) : (u64, u64) {
        (arg0.treasury_percent, arg0.honey_buyback_pct)
    }

    public fun get_treasury_balance(arg0: &HoneyYield) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_treasury)
    }

    public fun get_weighted_pool_fee_info(arg0: &HoneyYield) : PoolFeeInfo {
        PoolFeeInfo{
            total_fee_bps    : arg0.pool_fee_config.weighted_pool_fee.total_fee_bps,
            protocol_fee_pct : arg0.pool_fee_config.weighted_pool_fee.protocol_fee_pct,
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HoneyYieldAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<HoneyYieldAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = TreasuryClaimCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<TreasuryClaimCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = TwoAmmAccess{id: 0x2::object::new(arg0)};
        let v3 = HoneyBoughtBackClaimCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<HoneyBoughtBackClaimCap>(v3, 0x2::tx_context::sender(arg0));
        let v4 = TokenRulesClaimCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<TokenRulesClaimCap>(v4, 0x2::tx_context::sender(arg0));
        let v5 = FeeInfo{
            total_fee_bps    : 100,
            protocol_fee_pct : 50,
        };
        let v6 = FeeInfo{
            total_fee_bps    : 100,
            protocol_fee_pct : 50,
        };
        let v7 = FeeInfo{
            total_fee_bps    : 100,
            protocol_fee_pct : 50,
        };
        let v8 = DefaultFeeInfo{
            weighted_pool_fee : v5,
            stable_pool_fee   : v6,
            curved_pool_fee   : v7,
        };
        let v9 = HoneyYield{
            id                 : 0x2::object::new(arg0),
            sui_treasury       : 0x2::balance::zero<0x2::sui::SUI>(),
            honey_bought_back  : 0x2::balance::zero<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::honey::HONEY>(),
            honey_to_burn      : 0x2::balance::zero<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::honey::HONEY>(),
            decimal_precisions : 0x2::linked_table::new<0x1::string::String, u8>(arg0),
            pool_fee_config    : v8,
            fee_collectors     : 0x2::linked_table::new<0x1::ascii::String, address>(arg0),
            treasury_percent   : 50,
            honey_buyback_pct  : 100 - 50,
            honey_tax_pct      : 10,
            creator_tax_pct    : 0x2::linked_table::new<0x1::ascii::String, u64>(arg0),
            bag                : 0x2::bag::new(arg0),
            module_version     : 0,
        };
        let v10 = &mut v9;
        create_fee_collector<0x2::sui::SUI>(&v2, v10, arg0);
        0x2::transfer::transfer<TwoAmmAccess>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<HoneyYield>(v9);
    }

    public fun is_fee_collector_present<T0>(arg0: &HoneyYield) : bool {
        0x2::linked_table::contains<0x1::ascii::String, address>(&arg0.fee_collectors, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))
    }

    public fun query_fee_collectors(arg0: &HoneyYield, arg1: 0x1::option::Option<0x1::ascii::String>, arg2: u64) : FeeCollectorsInfo {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = 0x1::vector::empty<address>();
        let v2 = if (0x1::option::is_some<0x1::ascii::String>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<0x1::ascii::String, address>(&arg0.fee_collectors)
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<0x1::ascii::String>(&v3) && v4 < arg2) {
            let v5 = 0x1::option::borrow<0x1::ascii::String>(&v3);
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, *v5);
            0x1::vector::push_back<address>(&mut v1, *0x2::linked_table::borrow<0x1::ascii::String, address>(&arg0.fee_collectors, *v5));
            v3 = *0x2::linked_table::next<0x1::ascii::String, address>(&arg0.fee_collectors, *v5);
            v4 = v4 + 1;
        };
        FeeCollectorsInfo{
            coin_types              : v0,
            fee_collector_addr_list : v1,
            limit                   : 0x2::linked_table::length<0x1::ascii::String, address>(&arg0.fee_collectors),
        }
    }

    public fun query_precisions_for_coin_types(arg0: &HoneyYield, arg1: 0x1::option::Option<0x1::string::String>, arg2: u64) : PrecisionInfo {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = 0x1::vector::empty<u8>();
        let v2 = if (0x1::option::is_some<0x1::string::String>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<0x1::string::String, u8>(&arg0.decimal_precisions)
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<0x1::string::String>(&v3) && v4 < arg2) {
            let v5 = 0x1::option::borrow<0x1::string::String>(&v3);
            0x1::vector::push_back<0x1::string::String>(&mut v0, *v5);
            0x1::vector::push_back<u8>(&mut v1, *0x2::linked_table::borrow<0x1::string::String, u8>(&arg0.decimal_precisions, *v5));
            v3 = *0x2::linked_table::next<0x1::string::String, u8>(&arg0.decimal_precisions, *v5);
            v4 = v4 + 1;
        };
        PrecisionInfo{
            coin_types             : v0,
            decimal_precision_list : v1,
            limit                  : 0x2::linked_table::length<0x1::string::String, u8>(&arg0.decimal_precisions),
        }
    }

    public fun release_sui_from_treasury(arg0: &TreasuryClaimCap, arg1: &mut HoneyYield, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 4010);
        let v0 = if (arg2 == 0) {
            0x2::balance::value<0x2::sui::SUI>(&arg1.sui_treasury)
        } else {
            arg2
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_treasury, v0), arg4), arg3);
        let v1 = TreasuryResourcesDistributed{amount: arg2};
        0x2::event::emit<TreasuryResourcesDistributed>(v1);
    }

    public fun set_creator_tax_pct_for_token<T0>(arg0: &mut HoneyYield, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: u64) {
        assert!(arg2 <= 100 / 2, 3020);
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        assert!(0x2::linked_table::contains<0x1::ascii::String, u64>(&arg0.creator_tax_pct, v0), 4020);
        *0x2::linked_table::borrow_mut<0x1::ascii::String, u64>(&mut arg0.creator_tax_pct, v0) = arg2;
        let v1 = AdminTaxForTokenUpdated{
            token   : v0,
            tax_pct : arg2,
        };
        0x2::event::emit<AdminTaxForTokenUpdated>(v1);
    }

    public fun update_default_fee_for_curve<T0>(arg0: &mut HoneyYield, arg1: &HoneyYieldAdminCap, arg2: u64, arg3: u64) {
        assert!(arg0.module_version == 0, 4010);
        0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::curves::assert_valid_curve<T0>();
        if (0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::curves::is_stable<T0>()) {
            let v0 = &mut arg0.pool_fee_config.stable_pool_fee;
            update_fee(v0, arg2, arg3);
        } else if (0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::curves::is_weighted<T0>()) {
            let v1 = &mut arg0.pool_fee_config.weighted_pool_fee;
            update_fee(v1, arg2, arg3);
        } else if (0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::curves::is_curved<T0>()) {
            let v2 = &mut arg0.pool_fee_config.curved_pool_fee;
            update_fee(v2, arg2, arg3);
        };
        let v3 = DefaultFeeSet{
            curve            : 0x1::type_name::with_defining_ids<T0>(),
            total_fee_bps    : arg2,
            protocol_fee_pct : arg3,
        };
        0x2::event::emit<DefaultFeeSet>(v3);
    }

    fun update_fee(arg0: &mut FeeInfo, arg1: u64, arg2: u64) {
        if (arg1 > 0) {
            assert!(arg1 >= 1 && arg1 <= 300, 3020);
            arg0.total_fee_bps = arg1;
        };
        if (arg2 > 0) {
            assert!(arg2 >= 50 && arg2 <= 100, 3020);
            arg0.protocol_fee_pct = arg2;
        };
    }

    public fun update_honey_tax_pct(arg0: &mut HoneyYield, arg1: &HoneyYieldAdminCap, arg2: u64) {
        assert!(arg2 <= 100 / 2, 3020);
        arg0.honey_tax_pct = arg2;
        let v0 = HoneyTaxUpdated{tax_pct: arg2};
        0x2::event::emit<HoneyTaxUpdated>(v0);
    }

    public fun update_honey_yield_config_pct(arg0: &mut HoneyYield, arg1: &HoneyYieldAdminCap, arg2: u64) {
        assert!(arg0.module_version == 0, 4010);
        assert!(arg2 < 100, 3020);
        arg0.treasury_percent = arg2;
        arg0.honey_buyback_pct = 100 - arg2;
        let v0 = FeeDistributionPctUpdated{
            treasury_fee_percent : arg2,
            honey_buyback_pct    : 100 - arg2,
        };
        0x2::event::emit<FeeDistributionPctUpdated>(v0);
    }

    public fun update_module_version(arg0: &mut HoneyYield) {
        assert!(arg0.module_version < 0, 4000);
        arg0.module_version = 0;
    }

    public fun whitelist_decimal_precisions(arg0: &mut HoneyYield, arg1: &HoneyYieldAdminCap, arg2: vector<0x1::string::String>, arg3: vector<u8>) {
        assert!(arg0.module_version == 0, 4010);
        assert!(0x1::vector::length<0x1::string::String>(&arg2) == 0x1::vector::length<u8>(&arg3), 3030);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            let v1 = *0x1::vector::borrow<0x1::string::String>(&arg2, v0);
            if (0x2::linked_table::contains<0x1::string::String, u8>(&arg0.decimal_precisions, v1)) {
                *0x2::linked_table::borrow_mut<0x1::string::String, u8>(&mut arg0.decimal_precisions, v1) = *0x1::vector::borrow<u8>(&arg3, v0);
            } else {
                0x2::linked_table::push_back<0x1::string::String, u8>(&mut arg0.decimal_precisions, v1, *0x1::vector::borrow<u8>(&arg3, v0));
            };
            v0 = v0 + 1;
        };
        let v2 = DecimalPrecisionForCoinTypesWhitelisted{
            coin_types         : arg2,
            decimal_precisions : arg3,
        };
        0x2::event::emit<DecimalPrecisionForCoinTypesWhitelisted>(v2);
    }

    public fun withdraw_honey_bought_back(arg0: &HoneyBoughtBackClaimCap, arg1: &mut HoneyYield) : 0x2::balance::Balance<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::honey::HONEY> {
        let v0 = HoneyBoughtBackWithdrawn{amount: 0x2::balance::value<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::honey::HONEY>(&arg1.honey_bought_back)};
        0x2::event::emit<HoneyBoughtBackWithdrawn>(v0);
        0x2::balance::withdraw_all<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::honey::HONEY>(&mut arg1.honey_bought_back)
    }

    public fun withdraw_honey_to_burn(arg0: &mut HoneyYield, arg1: &0x2::coin::TreasuryCap<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::honey::HONEY>) : 0x2::balance::Balance<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::honey::HONEY> {
        0x2::balance::withdraw_all<0x8677eab287d160fa6fccff5d197b33a3b43544ea2510459d64f245a49dee6636::honey::HONEY>(&mut arg0.honey_to_burn)
    }

    // decompiled from Move bytecode v6
}

