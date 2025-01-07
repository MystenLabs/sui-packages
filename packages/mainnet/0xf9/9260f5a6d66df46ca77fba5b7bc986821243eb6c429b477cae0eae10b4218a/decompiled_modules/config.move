module 0xf99260f5a6d66df46ca77fba5b7bc986821243eb6c429b477cae0eae10b4218a::config {
    struct Config has key {
        id: 0x2::object::UID,
        coin_decimals: 0x2::table::Table<0x1::string::String, u8>,
        stable_identifiers: 0x2::table::Table<0x1::type_name::TypeName, bool>,
        amm_fee_collectors: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
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

    struct AuctionCapability has store, key {
        id: 0x2::object::UID,
    }

    struct Treasury<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct GemsTreasury has store, key {
        id: 0x2::object::UID,
        available_gems: 0xf99260f5a6d66df46ca77fba5b7bc986821243eb6c429b477cae0eae10b4218a::hive_gems::HiveGems,
    }

    struct TwoAmmFeeCollectionCapability has store, key {
        id: 0x2::object::UID,
    }

    struct ThreeAmmFeeCollectionCapability has store, key {
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

    struct CoinDecimalsAdded has copy, drop {
        tokens: vector<0x1::string::String>,
        decimals: vector<u8>,
    }

    struct StableIdentifierAdded has copy, drop {
        identifier: 0x1::type_name::TypeName,
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

    struct NewFeeCoinCreated has copy, drop {
        token: 0x1::type_name::TypeName,
        id: 0x2::object::ID,
    }

    struct FeeCollectedForCoin has copy, drop {
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct FeeExtractedForCoin has copy, drop {
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct GemsAddedToTreasury has copy, drop {
        deposit_amt: u64,
    }

    public fun add_coin_decimals(arg0: &mut Config, arg1: &HiveDaoCapability, arg2: vector<0x1::string::String>, arg3: vector<u8>) {
        assert!(0x1::vector::length<0x1::string::String>(&arg2) == 0x1::vector::length<u8>(&arg3), 303);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            let v1 = *0x1::vector::borrow<0x1::string::String>(&arg2, v0);
            if (0x2::table::contains<0x1::string::String, u8>(&arg0.coin_decimals, v1)) {
                *0x2::table::borrow_mut<0x1::string::String, u8>(&mut arg0.coin_decimals, v1) = *0x1::vector::borrow<u8>(&arg3, v0);
            } else {
                0x2::table::add<0x1::string::String, u8>(&mut arg0.coin_decimals, v1, *0x1::vector::borrow<u8>(&arg3, v0));
            };
            v0 = v0 + 1;
        };
        let v2 = CoinDecimalsAdded{
            tokens   : arg2,
            decimals : arg3,
        };
        0x2::event::emit<CoinDecimalsAdded>(v2);
    }

    public fun add_stable_identifer(arg0: &mut Config, arg1: &HiveDaoCapability, arg2: 0x1::type_name::TypeName) {
        if (!0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.stable_identifiers, arg2)) {
            0x2::table::add<0x1::type_name::TypeName, bool>(&mut arg0.stable_identifiers, arg2, true);
        } else {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, bool>(&mut arg0.stable_identifiers, arg2) = true;
        };
        let v0 = StableIdentifierAdded{identifier: arg2};
        0x2::event::emit<StableIdentifierAdded>(v0);
    }

    public fun add_stable_identifer_by_type<T0>(arg0: &mut Config, arg1: &HiveDaoCapability) {
        add_stable_identifer(arg0, arg1, 0x1::type_name::get<T0>());
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
        let v1 = 0x2::object::uid_to_inner(&v0);
        assert!(!0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.amm_fee_collectors, 0x1::type_name::get<T0>()), 304);
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.amm_fee_collectors, 0x1::type_name::get<T0>(), v1);
        let v2 = NewFeeCoinCreated{
            token : 0x1::type_name::get<T0>(),
            id    : v1,
        };
        0x2::event::emit<NewFeeCoinCreated>(v2);
        let v3 = FeeCollector<T0>{
            id                 : v0,
            balance            : 0x2::balance::zero<T0>(),
            lifetime_collected : 0,
        };
        0x2::transfer::share_object<FeeCollector<T0>>(v3);
    }

    public fun deposit_gems_to_treasury(arg0: &mut GemsTreasury, arg1: 0xf99260f5a6d66df46ca77fba5b7bc986821243eb6c429b477cae0eae10b4218a::hive_gems::HiveGems, arg2: u64) : 0xf99260f5a6d66df46ca77fba5b7bc986821243eb6c429b477cae0eae10b4218a::hive_gems::HiveGems {
        let v0 = GemsAddedToTreasury{deposit_amt: arg2};
        0x2::event::emit<GemsAddedToTreasury>(v0);
        0xf99260f5a6d66df46ca77fba5b7bc986821243eb6c429b477cae0eae10b4218a::hive_gems::join(&mut arg0.available_gems, 0xf99260f5a6d66df46ca77fba5b7bc986821243eb6c429b477cae0eae10b4218a::hive_gems::split(&mut arg1, arg2));
        arg1
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

    public fun extract_fee_for_coin_2amm<T0>(arg0: &TwoAmmFeeCollectionCapability, arg1: &mut FeeCollector<T0>) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg1.balance);
        let v1 = FeeExtractedForCoin{
            token  : 0x1::type_name::get<T0>(),
            amount : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<FeeExtractedForCoin>(v1);
        v0
    }

    public fun extract_fee_for_coin_3amm<T0>(arg0: &ThreeAmmFeeCollectionCapability, arg1: &mut FeeCollector<T0>) : 0x2::balance::Balance<T0> {
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
        if (0x2::table::contains<0x1::string::String, u8>(&arg0.coin_decimals, v0)) {
            (true, *0x2::table::borrow<0x1::string::String, u8>(&arg0.coin_decimals, v0))
        } else {
            (false, 0)
        }
    }

    public fun get_decimals_for_coin_type(arg0: &Config, arg1: 0x1::type_name::TypeName) : (bool, u8) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(arg1));
        if (0x2::table::contains<0x1::string::String, u8>(&arg0.coin_decimals, v0)) {
            (true, *0x2::table::borrow<0x1::string::String, u8>(&arg0.coin_decimals, v0))
        } else {
            (false, 0)
        }
    }

    public entry fun get_fee_collector_id<T0>(arg0: &Config) : 0x2::object::ID {
        *0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.amm_fee_collectors, 0x1::type_name::get<T0>())
    }

    public entry fun get_fee_info<T0>(arg0: &Config) : (u64, u64) {
        if (0xf99260f5a6d66df46ca77fba5b7bc986821243eb6c429b477cae0eae10b4218a::curves::is_stable<T0>()) {
            return (arg0.stable_pool_fee.total_fee_bps, arg0.stable_pool_fee.hive_fee_percent)
        };
        if (0xf99260f5a6d66df46ca77fba5b7bc986821243eb6c429b477cae0eae10b4218a::curves::is_weighted<T0>()) {
            return (arg0.weighted_pool_fee.total_fee_bps, arg0.weighted_pool_fee.hive_fee_percent)
        };
        if (0xf99260f5a6d66df46ca77fba5b7bc986821243eb6c429b477cae0eae10b4218a::curves::is_curved<T0>()) {
            return (arg0.curved_pool_fee.total_fee_bps, arg0.curved_pool_fee.hive_fee_percent)
        };
        (0, 0)
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

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HiveDaoCapability{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<HiveDaoCapability>(v0, 0x2::tx_context::sender(arg0));
        let v1 = DexDaoCapability{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DexDaoCapability>(v1, 0x2::tx_context::sender(arg0));
        let v2 = AuctionCapability{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AuctionCapability>(v2, 0x2::tx_context::sender(arg0));
        let v3 = TwoAmmFeeCollectionCapability{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<TwoAmmFeeCollectionCapability>(v3, 0x2::tx_context::sender(arg0));
        let v4 = ThreeAmmFeeCollectionCapability{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ThreeAmmFeeCollectionCapability>(v4, 0x2::tx_context::sender(arg0));
        let v5 = FeeInfo{
            total_fee_bps    : 35,
            hive_fee_percent : 34,
        };
        let v6 = FeeInfo{
            total_fee_bps    : 10,
            hive_fee_percent : 35,
        };
        let v7 = FeeInfo{
            total_fee_bps    : 40,
            hive_fee_percent : 42,
        };
        let v8 = Config{
            id                 : 0x2::object::new(arg0),
            coin_decimals      : 0x2::table::new<0x1::string::String, u8>(arg0),
            stable_identifiers : 0x2::table::new<0x1::type_name::TypeName, bool>(arg0),
            amm_fee_collectors : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg0),
            weighted_pool_fee  : v5,
            stable_pool_fee    : v6,
            curved_pool_fee    : v7,
            treasury_percent   : 10,
        };
        0x2::transfer::share_object<Config>(v8);
        let v9 = Treasury<0xf99260f5a6d66df46ca77fba5b7bc986821243eb6c429b477cae0eae10b4218a::hsui::HSUI>{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0xf99260f5a6d66df46ca77fba5b7bc986821243eb6c429b477cae0eae10b4218a::hsui::HSUI>(),
        };
        0x2::transfer::share_object<Treasury<0xf99260f5a6d66df46ca77fba5b7bc986821243eb6c429b477cae0eae10b4218a::hsui::HSUI>>(v9);
        let v10 = GemsTreasury{
            id             : 0x2::object::new(arg0),
            available_gems : 0xf99260f5a6d66df46ca77fba5b7bc986821243eb6c429b477cae0eae10b4218a::hive_gems::zero(),
        };
        0x2::transfer::share_object<GemsTreasury>(v10);
    }

    public entry fun is_fee_collector_present<T0>(arg0: &Config) : bool {
        0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.amm_fee_collectors, 0x1::type_name::get<T0>())
    }

    public entry fun is_stable_identifier<T0>(arg0: &Config) : bool {
        if (0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.stable_identifiers, 0x1::type_name::get<T0>())) {
            return *0x2::table::borrow<0x1::type_name::TypeName, bool>(&arg0.stable_identifiers, 0x1::type_name::get<T0>())
        };
        false
    }

    public fun kraft_treasury_for_hive<T0>(arg0: &DexDaoCapability, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Treasury<T0>>(v0);
    }

    public fun remove_stable_identifer(arg0: &mut Config, arg1: &HiveDaoCapability, arg2: 0x1::type_name::TypeName) {
        *0x2::table::borrow_mut<0x1::type_name::TypeName, bool>(&mut arg0.stable_identifiers, arg2) = false;
        let v0 = StableIdentifierRemoved{identifier: arg2};
        0x2::event::emit<StableIdentifierRemoved>(v0);
    }

    public fun update_default_fee_for_curve<T0>(arg0: &mut Config, arg1: &HiveDaoCapability, arg2: u64, arg3: u64) {
        0xf99260f5a6d66df46ca77fba5b7bc986821243eb6c429b477cae0eae10b4218a::curves::assert_valid_curve<T0>();
        if (0xf99260f5a6d66df46ca77fba5b7bc986821243eb6c429b477cae0eae10b4218a::curves::is_stable<T0>()) {
            let v0 = &mut arg0.stable_pool_fee;
            update_fee(v0, arg2, arg3);
        } else if (0xf99260f5a6d66df46ca77fba5b7bc986821243eb6c429b477cae0eae10b4218a::curves::is_weighted<T0>()) {
            let v1 = &mut arg0.weighted_pool_fee;
            update_fee(v1, arg2, arg3);
        } else if (0xf99260f5a6d66df46ca77fba5b7bc986821243eb6c429b477cae0eae10b4218a::curves::is_curved<T0>()) {
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
            assert!(arg1 >= 1 && arg1 <= 100, 302);
            arg0.total_fee_bps = arg1;
        };
        if (arg2 > 0) {
            assert!(arg2 >= 30 && arg2 <= 50, 302);
            arg0.hive_fee_percent = arg2;
        };
    }

    public fun update_treasury_percent(arg0: &mut Config, arg1: &HiveDaoCapability, arg2: u64) {
        assert!(arg2 >= 5 && arg2 <= 25, 302);
        arg0.treasury_percent = arg2;
        let v0 = TreasuryPercentUpdated{treasury_fee_percent: arg2};
        0x2::event::emit<TreasuryPercentUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

