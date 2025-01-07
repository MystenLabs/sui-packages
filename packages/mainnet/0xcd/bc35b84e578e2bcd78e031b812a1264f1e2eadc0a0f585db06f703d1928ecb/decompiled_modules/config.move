module 0xcdbc35b84e578e2bcd78e031b812a1264f1e2eadc0a0f585db06f703d1928ecb::config {
    struct Config has key {
        id: 0x2::object::UID,
        decimal_precisions: 0x2::linked_table::LinkedTable<0x1::string::String, u8>,
        stable_identifiers: 0x2::linked_table::LinkedTable<0x1::ascii::String, bool>,
        amm_fee_collectors: 0x2::linked_table::LinkedTable<0x1::ascii::String, address>,
        weighted_pool_fee: FeeInfo,
        stable_pool_fee: FeeInfo,
        curved_pool_fee: FeeInfo,
        treasury_percent: u64,
    }

    struct HiveDaoCapability has store, key {
        id: 0x2::object::UID,
    }

    struct DexDaoCapability has store, key {
        id: 0x2::object::UID,
    }

    struct DegenHiveDeployerCap has store, key {
        id: 0x2::object::UID,
        manager_initialized: bool,
        vault_initialized: bool,
    }

    struct BuidlersRoyaltyCollectionAbility has store, key {
        id: 0x2::object::UID,
    }

    struct HiveEntryCap has store, key {
        id: 0x2::object::UID,
        airdrop_open: bool,
        airdrop_unlock_open: bool,
        lockdrop_open: bool,
        lockdrop_withdraw_only: bool,
        auction_open: bool,
        auction_withdraw_only: bool,
        has_hive_fusion_concluded: bool,
    }

    struct InfusionCapability has store, key {
        id: 0x2::object::UID,
        is_vault_initialized: bool,
    }

    struct Treasury<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct TwoAmmFeeClaimCapability has store, key {
        id: 0x2::object::UID,
    }

    struct ThreeAmmFeeClaimCapability has store, key {
        id: 0x2::object::UID,
    }

    struct FeeCollector<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        lifetime_collected: u128,
    }

    struct FeeInfo has copy, store {
        total_fee_bps: u64,
        hive_fee_percent: u64,
    }

    struct DecimalPrecisionForCoinTypesWhitelisted has copy, drop {
        coin_types: vector<0x1::string::String>,
        decimal_precisions: vector<u8>,
    }

    struct StableIdentifierAdded has copy, drop {
        identifier: 0x1::ascii::String,
    }

    struct StableIdentifierRemoved has copy, drop {
        identifier: 0x1::type_name::TypeName,
    }

    struct DefaultFeeSet has copy, drop {
        curve: 0x1::type_name::TypeName,
        total_fee_bps: u64,
        hive_fee_percent: u64,
    }

    struct TreasuryPercentUpdated has copy, drop {
        treasury_fee_percent: u64,
    }

    struct TreasuryResourcesDistributed has copy, drop {
        token: 0x1::type_name::TypeName,
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

    struct FeeExtractedForCoin has copy, drop {
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun add_stable_identifer(arg0: &mut Config, arg1: &HiveDaoCapability, arg2: 0x1::ascii::String) {
        if (!0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.stable_identifiers, arg2)) {
            0x2::linked_table::push_back<0x1::ascii::String, bool>(&mut arg0.stable_identifiers, arg2, true);
        } else {
            *0x2::linked_table::borrow_mut<0x1::ascii::String, bool>(&mut arg0.stable_identifiers, arg2) = true;
        };
        let v0 = StableIdentifierAdded{identifier: arg2};
        0x2::event::emit<StableIdentifierAdded>(v0);
    }

    public fun add_stable_identifer_by_type<T0>(arg0: &mut Config, arg1: &HiveDaoCapability) {
        add_stable_identifer(arg0, arg1, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
    }

    public fun collect_fee_for_coin<T0>(arg0: &mut FeeCollector<T0>, arg1: 0x2::balance::Balance<T0>) {
        arg0.lifetime_collected = arg0.lifetime_collected + (0x2::balance::value<T0>(&arg1) as u128);
        let v0 = FeeCollectedForCoin{
            token  : 0x1::type_name::get<T0>(),
            amount : 0x2::balance::value<T0>(&arg1),
        };
        0x2::event::emit<FeeCollectedForCoin>(v0);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::balance::withdraw_all<T0>(&mut arg1));
        0x2::balance::destroy_zero<T0>(arg1);
    }

    public fun create_fee_collector<T0>(arg0: &mut Config, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_address(&v0);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(!0x2::linked_table::contains<0x1::ascii::String, address>(&arg0.amm_fee_collectors, v2), 3040);
        0x2::linked_table::push_back<0x1::ascii::String, address>(&mut arg0.amm_fee_collectors, v2, v1);
        let v3 = NewFeeCollectorKrafted{
            coin_type          : v2,
            fee_collector_addr : v1,
        };
        0x2::event::emit<NewFeeCollectorKrafted>(v3);
        let v4 = FeeCollector<T0>{
            id                 : v0,
            balance            : 0x2::balance::zero<T0>(),
            lifetime_collected : 0,
        };
        0x2::transfer::share_object<FeeCollector<T0>>(v4);
    }

    public fun deposit_to_treasury<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
    }

    public fun distribute_treasury_resources<T0>(arg0: &HiveDaoCapability, arg1: &mut Treasury<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg4), arg3);
        let v0 = TreasuryResourcesDistributed{
            token  : 0x1::type_name::get<T0>(),
            amount : arg2,
        };
        0x2::event::emit<TreasuryResourcesDistributed>(v0);
    }

    public fun entry_deposit_to_treasury<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        deposit_to_treasury<T0>(arg0, 0x2::balance::split<T0>(&mut v0, arg2));
        if (0x2::balance::value<T0>(&v0) == 0) {
            0x2::balance::destroy_zero<T0>(v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg3), 0x2::tx_context::sender(arg3));
        };
    }

    public fun extract_fee_for_coin_2amm<T0>(arg0: &TwoAmmFeeClaimCapability, arg1: &mut FeeCollector<T0>) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg1.balance);
        let v1 = FeeExtractedForCoin{
            token  : 0x1::type_name::get<T0>(),
            amount : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<FeeExtractedForCoin>(v1);
        v0
    }

    public fun extract_fee_for_coin_3amm<T0>(arg0: &ThreeAmmFeeClaimCapability, arg1: &mut FeeCollector<T0>) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg1.balance);
        let v1 = FeeExtractedForCoin{
            token  : 0x1::type_name::get<T0>(),
            amount : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<FeeExtractedForCoin>(v1);
        v0
    }

    public entry fun get_curved_pool_fee_info(arg0: &Config) : (u64, u64) {
        (arg0.curved_pool_fee.total_fee_bps, arg0.curved_pool_fee.hive_fee_percent)
    }

    public entry fun get_decimals_for_coin<T0>(arg0: &Config) : (bool, u8) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        if (0x2::linked_table::contains<0x1::string::String, u8>(&arg0.decimal_precisions, v0)) {
            (true, *0x2::linked_table::borrow<0x1::string::String, u8>(&arg0.decimal_precisions, v0))
        } else {
            (false, 0)
        }
    }

    public fun get_decimals_for_coin_type(arg0: &Config, arg1: 0x1::type_name::TypeName) : (bool, u8) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(arg1));
        if (0x2::linked_table::contains<0x1::string::String, u8>(&arg0.decimal_precisions, v0)) {
            (true, *0x2::linked_table::borrow<0x1::string::String, u8>(&arg0.decimal_precisions, v0))
        } else {
            (false, 0)
        }
    }

    public entry fun get_fee_collector_id<T0>(arg0: &Config) : address {
        *0x2::linked_table::borrow<0x1::ascii::String, address>(&arg0.amm_fee_collectors, 0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    public entry fun get_fee_info<T0>(arg0: &Config) : (u64, u64) {
        if (0xcdbc35b84e578e2bcd78e031b812a1264f1e2eadc0a0f585db06f703d1928ecb::curves::is_stable<T0>()) {
            return (arg0.stable_pool_fee.total_fee_bps, arg0.stable_pool_fee.hive_fee_percent)
        };
        if (0xcdbc35b84e578e2bcd78e031b812a1264f1e2eadc0a0f585db06f703d1928ecb::curves::is_weighted<T0>()) {
            return (arg0.weighted_pool_fee.total_fee_bps, arg0.weighted_pool_fee.hive_fee_percent)
        };
        if (0xcdbc35b84e578e2bcd78e031b812a1264f1e2eadc0a0f585db06f703d1928ecb::curves::is_curved<T0>()) {
            return (arg0.curved_pool_fee.total_fee_bps, arg0.curved_pool_fee.hive_fee_percent)
        };
        (0, 0)
    }

    public fun get_hive_entry_status(arg0: &HiveEntryCap) : (bool, bool, bool, bool, bool, bool, bool) {
        (arg0.airdrop_open, arg0.airdrop_unlock_open, arg0.lockdrop_open, arg0.lockdrop_withdraw_only, arg0.auction_open, arg0.auction_withdraw_only, arg0.has_hive_fusion_concluded)
    }

    public entry fun get_hive_treasury_fee_info(arg0: &Config) : u64 {
        arg0.treasury_percent
    }

    public entry fun get_stable_pool_fee_info(arg0: &Config) : (u64, u64) {
        (arg0.stable_pool_fee.total_fee_bps, arg0.stable_pool_fee.hive_fee_percent)
    }

    public entry fun get_treasury_balance<T0>(arg0: &Treasury<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public entry fun get_weighted_pool_fee_info(arg0: &Config) : (u64, u64) {
        (arg0.weighted_pool_fee.total_fee_bps, arg0.weighted_pool_fee.hive_fee_percent)
    }

    public fun hive_entry_airdrop_open(arg0: &mut HiveEntryCap) {
        assert!(!arg0.airdrop_open, 3050);
        arg0.airdrop_open = true;
    }

    public fun hive_entry_airdrop_unlocked(arg0: &mut HiveEntryCap) {
        assert!(!arg0.airdrop_unlock_open, 3060);
        arg0.airdrop_unlock_open = true;
    }

    public fun hive_entry_fusion_concluded(arg0: &mut HiveEntryCap) {
        assert!(!arg0.has_hive_fusion_concluded, 311);
        arg0.has_hive_fusion_concluded = true;
    }

    public fun hive_entry_infusion_open(arg0: &mut HiveEntryCap) {
        assert!(!arg0.auction_open, 3090);
        arg0.auction_open = true;
    }

    public fun hive_entry_infusion_withdraw_only(arg0: &mut HiveEntryCap) {
        assert!(!arg0.auction_withdraw_only, 3100);
        arg0.auction_withdraw_only = true;
    }

    public fun hive_entry_lockdrop_open(arg0: &mut HiveEntryCap) {
        assert!(!arg0.lockdrop_open, 3070);
        arg0.lockdrop_open = true;
    }

    public fun hive_entry_lockdrop_withdraw_only(arg0: &mut HiveEntryCap) {
        assert!(!arg0.lockdrop_withdraw_only, 3080);
        arg0.lockdrop_withdraw_only = true;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BuidlersRoyaltyCollectionAbility{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<BuidlersRoyaltyCollectionAbility>(v0, 0x2::tx_context::sender(arg0));
        let v1 = DegenHiveDeployerCap{
            id                  : 0x2::object::new(arg0),
            manager_initialized : false,
            vault_initialized   : false,
        };
        0x2::transfer::transfer<DegenHiveDeployerCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = HiveDaoCapability{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<HiveDaoCapability>(v2, 0x2::tx_context::sender(arg0));
        let v3 = DexDaoCapability{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DexDaoCapability>(v3, 0x2::tx_context::sender(arg0));
        let v4 = HiveEntryCap{
            id                        : 0x2::object::new(arg0),
            airdrop_open              : false,
            airdrop_unlock_open       : false,
            lockdrop_open             : false,
            lockdrop_withdraw_only    : false,
            auction_open              : false,
            auction_withdraw_only     : false,
            has_hive_fusion_concluded : false,
        };
        0x2::transfer::transfer<HiveEntryCap>(v4, 0x2::tx_context::sender(arg0));
        let v5 = InfusionCapability{
            id                   : 0x2::object::new(arg0),
            is_vault_initialized : false,
        };
        0x2::transfer::transfer<InfusionCapability>(v5, 0x2::tx_context::sender(arg0));
        let v6 = TwoAmmFeeClaimCapability{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<TwoAmmFeeClaimCapability>(v6, 0x2::tx_context::sender(arg0));
        let v7 = ThreeAmmFeeClaimCapability{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ThreeAmmFeeClaimCapability>(v7, 0x2::tx_context::sender(arg0));
        let v8 = FeeInfo{
            total_fee_bps    : 35,
            hive_fee_percent : 34,
        };
        let v9 = FeeInfo{
            total_fee_bps    : 20,
            hive_fee_percent : 35,
        };
        let v10 = FeeInfo{
            total_fee_bps    : 40,
            hive_fee_percent : 42,
        };
        let v11 = Config{
            id                 : 0x2::object::new(arg0),
            decimal_precisions : 0x2::linked_table::new<0x1::string::String, u8>(arg0),
            stable_identifiers : 0x2::linked_table::new<0x1::ascii::String, bool>(arg0),
            amm_fee_collectors : 0x2::linked_table::new<0x1::ascii::String, address>(arg0),
            weighted_pool_fee  : v8,
            stable_pool_fee    : v9,
            curved_pool_fee    : v10,
            treasury_percent   : 10,
        };
        0x2::transfer::share_object<Config>(v11);
        let v12 = Treasury<0xcdbc35b84e578e2bcd78e031b812a1264f1e2eadc0a0f585db06f703d1928ecb::hsui::HSUI>{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0xcdbc35b84e578e2bcd78e031b812a1264f1e2eadc0a0f585db06f703d1928ecb::hsui::HSUI>(),
        };
        0x2::transfer::share_object<Treasury<0xcdbc35b84e578e2bcd78e031b812a1264f1e2eadc0a0f585db06f703d1928ecb::hsui::HSUI>>(v12);
    }

    public entry fun is_fee_collector_present<T0>(arg0: &Config) : bool {
        0x2::linked_table::contains<0x1::ascii::String, address>(&arg0.amm_fee_collectors, 0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    public fun is_infusion_initialized(arg0: &InfusionCapability) : bool {
        arg0.is_vault_initialized
    }

    public entry fun is_stable_identifier<T0>(arg0: &Config) : bool {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (0x2::linked_table::contains<0x1::ascii::String, bool>(&arg0.stable_identifiers, v0)) {
            return *0x2::linked_table::borrow<0x1::ascii::String, bool>(&arg0.stable_identifiers, v0)
        };
        false
    }

    public entry fun kraft_hive_entry_cap(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = InfusionCapability{
            id                   : 0x2::object::new(arg0),
            is_vault_initialized : false,
        };
        0x2::transfer::transfer<InfusionCapability>(v0, 0x2::tx_context::sender(arg0));
        let v1 = HiveEntryCap{
            id                        : 0x2::object::new(arg0),
            airdrop_open              : false,
            airdrop_unlock_open       : false,
            lockdrop_open             : false,
            lockdrop_withdraw_only    : false,
            auction_open              : false,
            auction_withdraw_only     : false,
            has_hive_fusion_concluded : false,
        };
        0x2::transfer::transfer<HiveEntryCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun manager_setup_by_deployer(arg0: &mut DegenHiveDeployerCap) {
        assert!(!arg0.manager_initialized, 3120);
        arg0.manager_initialized = true;
    }

    public fun query_amm_fee_collectors(arg0: &Config, arg1: 0x1::option::Option<0x1::ascii::String>, arg2: u64) : (vector<0x1::ascii::String>, vector<address>, u64) {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = 0x1::vector::empty<address>();
        let v2 = if (0x1::option::is_some<0x1::ascii::String>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<0x1::ascii::String, address>(&arg0.amm_fee_collectors)
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<0x1::ascii::String>(&v3) && v4 < arg2) {
            let v5 = 0x1::option::borrow<0x1::ascii::String>(&v3);
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, *v5);
            0x1::vector::push_back<address>(&mut v1, *0x2::linked_table::borrow<0x1::ascii::String, address>(&arg0.amm_fee_collectors, *v5));
            v3 = *0x2::linked_table::next<0x1::ascii::String, address>(&arg0.amm_fee_collectors, *v5);
            v4 = v4 + 1;
        };
        (v0, v1, 0x2::linked_table::length<0x1::ascii::String, address>(&arg0.amm_fee_collectors))
    }

    public fun query_precisions_for_coin_types(arg0: &Config, arg1: 0x1::option::Option<0x1::string::String>, arg2: u64) : (vector<0x1::string::String>, vector<u8>, u64) {
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
        (v0, v1, 0x2::linked_table::length<0x1::string::String, u8>(&arg0.decimal_precisions))
    }

    public fun query_stable_identifiers(arg0: &Config, arg1: 0x1::option::Option<0x1::ascii::String>, arg2: u64) : (vector<0x1::ascii::String>, vector<bool>, u64) {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = 0x1::vector::empty<bool>();
        let v2 = if (0x1::option::is_some<0x1::ascii::String>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<0x1::ascii::String, bool>(&arg0.stable_identifiers)
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<0x1::ascii::String>(&v3) && v4 < arg2) {
            let v5 = 0x1::option::borrow<0x1::ascii::String>(&v3);
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, *v5);
            0x1::vector::push_back<bool>(&mut v1, *0x2::linked_table::borrow<0x1::ascii::String, bool>(&arg0.stable_identifiers, *v5));
            v3 = *0x2::linked_table::next<0x1::ascii::String, bool>(&arg0.stable_identifiers, *v5);
            v4 = v4 + 1;
        };
        (v0, v1, 0x2::linked_table::length<0x1::ascii::String, bool>(&arg0.stable_identifiers))
    }

    public fun remove_stable_identifer(arg0: &mut Config, arg1: &HiveDaoCapability, arg2: 0x1::type_name::TypeName) {
        *0x2::linked_table::borrow_mut<0x1::ascii::String, bool>(&mut arg0.stable_identifiers, 0x1::type_name::into_string(arg2)) = false;
        let v0 = StableIdentifierRemoved{identifier: arg2};
        0x2::event::emit<StableIdentifierRemoved>(v0);
    }

    public fun update_default_fee_for_curve<T0>(arg0: &mut Config, arg1: &HiveDaoCapability, arg2: u64, arg3: u64) {
        0xcdbc35b84e578e2bcd78e031b812a1264f1e2eadc0a0f585db06f703d1928ecb::curves::assert_valid_curve<T0>();
        if (0xcdbc35b84e578e2bcd78e031b812a1264f1e2eadc0a0f585db06f703d1928ecb::curves::is_stable<T0>()) {
            let v0 = &mut arg0.stable_pool_fee;
            update_fee(v0, arg2, arg3);
        } else if (0xcdbc35b84e578e2bcd78e031b812a1264f1e2eadc0a0f585db06f703d1928ecb::curves::is_weighted<T0>()) {
            let v1 = &mut arg0.weighted_pool_fee;
            update_fee(v1, arg2, arg3);
        } else if (0xcdbc35b84e578e2bcd78e031b812a1264f1e2eadc0a0f585db06f703d1928ecb::curves::is_curved<T0>()) {
            let v2 = &mut arg0.curved_pool_fee;
            update_fee(v2, arg2, arg3);
        };
        let v3 = DefaultFeeSet{
            curve            : 0x1::type_name::get<T0>(),
            total_fee_bps    : arg2,
            hive_fee_percent : arg3,
        };
        0x2::event::emit<DefaultFeeSet>(v3);
    }

    fun update_fee(arg0: &mut FeeInfo, arg1: u64, arg2: u64) {
        if (arg1 > 0) {
            assert!(arg1 >= 1 && arg1 <= 100, 3020);
            arg0.total_fee_bps = arg1;
        };
        if (arg2 > 0) {
            assert!(arg2 >= 30 && arg2 <= 50, 3020);
            arg0.hive_fee_percent = arg2;
        };
    }

    public fun update_treasury_percent(arg0: &mut Config, arg1: &HiveDaoCapability, arg2: u64) {
        assert!(arg2 >= 5 && arg2 <= 25, 3020);
        arg0.treasury_percent = arg2;
        let v0 = TreasuryPercentUpdated{treasury_fee_percent: arg2};
        0x2::event::emit<TreasuryPercentUpdated>(v0);
    }

    public fun vault_setup_by_deployer(arg0: &mut DegenHiveDeployerCap) {
        assert!(!arg0.vault_initialized, 3130);
        arg0.vault_initialized = true;
    }

    public fun whitelist_decimal_precisions(arg0: &mut Config, arg1: &HiveDaoCapability, arg2: vector<0x1::string::String>, arg3: vector<u8>) {
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

    // decompiled from Move bytecode v6
}

