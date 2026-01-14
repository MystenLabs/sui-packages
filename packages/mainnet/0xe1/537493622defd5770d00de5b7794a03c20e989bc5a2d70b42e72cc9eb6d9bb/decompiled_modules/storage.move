module 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::storage {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct StorageAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Storage has store, key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        reserves: 0x2::table::Table<u8, ReserveData>,
        reserves_count: u8,
        users: vector<address>,
        user_info: 0x2::table::Table<address, UserInfo>,
    }

    struct ReserveData has store {
        id: u8,
        oracle_id: u8,
        coin_type: 0x1::ascii::String,
        is_isolated: bool,
        supply_cap_ceiling: u256,
        borrow_cap_ceiling: u256,
        current_supply_rate: u256,
        current_borrow_rate: u256,
        current_supply_index: u256,
        current_borrow_index: u256,
        supply_balance: TokenBalance,
        borrow_balance: TokenBalance,
        last_update_timestamp: u64,
        ltv: u256,
        treasury_factor: u256,
        treasury_balance: u256,
        borrow_rate_factors: BorrowRateFactors,
        liquidation_factors: LiquidationFactors,
        reserve_field_a: u256,
        reserve_field_b: u256,
        reserve_field_c: u256,
    }

    struct UserInfo has store {
        collaterals: vector<u8>,
        loans: vector<u8>,
    }

    struct ReserveConfigurationMap has copy, store {
        data: u256,
    }

    struct UserConfigurationMap has copy, store {
        data: u256,
    }

    struct TokenBalance has store {
        user_state: 0x2::table::Table<address, u256>,
        total_supply: u256,
    }

    struct BorrowRateFactors has store {
        base_rate: u256,
        multiplier: u256,
        jump_rate_multiplier: u256,
        reserve_factor: u256,
        optimal_utilization: u256,
    }

    struct LiquidationFactors has store {
        ratio: u256,
        bonus: u256,
        threshold: u256,
    }

    struct Emode has store {
        emodes_pair: 0x2::table::Table<u64, EmodeConfig>,
        user_emode_id: 0x2::table::Table<address, u64>,
        current_emode_id: u64,
    }

    struct EmodeConfig has store {
        assetA: EmodeAsset,
        assetB: EmodeAsset,
        isActive: bool,
    }

    struct EmodeAsset has store {
        assetId: u8,
        isCollateral: bool,
        isDebt: bool,
        ltv: u256,
        lt: u256,
        liquidation_bonus: u256,
    }

    struct MarketInfo has store {
        market_id: u64,
        last_market_id: u64,
        is_main_market: bool,
    }

    struct StorageConfiguratorSetting has copy, drop {
        sender: address,
        configurator: address,
        value: bool,
    }

    struct Paused has copy, drop {
        paused: bool,
    }

    struct WithdrawTreasuryEvent has copy, drop {
        sender: address,
        recipient: address,
        asset: u8,
        amount: u256,
        poolId: address,
        before: u256,
        after: u256,
        index: u256,
    }

    struct LiquidatorSet has copy, drop {
        liquidator: address,
        user: address,
        is_liquidatable: bool,
    }

    struct ProtectedUserSet has copy, drop {
        user: address,
        is_protected: bool,
    }

    struct EmodePairCreated has copy, drop {
        emode_id: u64,
        assetA: u8,
        assetB: u8,
    }

    struct EmodeParamSet has copy, drop {
        emode_id: u64,
        asset: u8,
        value: u256,
        param_type: u8,
    }

    struct EmodeUserStateChanged has copy, drop {
        user: address,
        emode_id: u64,
        is_entered: bool,
    }

    struct MarketCreated has copy, drop {
        market_id: u64,
    }

    struct BorrowWeightSet has copy, drop {
        asset: u8,
        weight: u64,
    }

    struct BorrowWeightRemoved has copy, drop {
        asset: u8,
    }

    struct DESIGNATED_LIQUIDATORS_KEY has copy, drop, store {
        dummy_field: bool,
    }

    struct PROTECTED_LIQUIDATION_USERS_KEY has copy, drop, store {
        dummy_field: bool,
    }

    struct EMODE_KEY has copy, drop, store {
        dummy_field: bool,
    }

    struct MARKET_KEY has copy, drop, store {
        dummy_field: bool,
    }

    struct BORROW_WEIGHT_KEY has copy, drop, store {
        dummy_field: bool,
    }

    public fun create_caps(arg0: &StorageAdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg2)};
        let v1 = StorageAdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<OwnerCap>(v0, arg1);
        0x2::transfer::transfer<StorageAdminCap>(v1, arg1);
    }

    public(friend) fun create_emode_asset(arg0: u8, arg1: bool, arg2: bool, arg3: u256, arg4: u256, arg5: u256) : EmodeAsset {
        EmodeAsset{
            assetId           : arg0,
            isCollateral      : arg1,
            isDebt            : arg2,
            ltv               : arg3,
            lt                : arg4,
            liquidation_bonus : arg5,
        }
    }

    public(friend) fun create_emode_pair(arg0: &mut Storage, arg1: EmodeAsset, arg2: EmodeAsset) {
        assert!(arg1.assetId < arg2.assetId, 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::error::invalid_value());
        let v0 = EMODE_KEY{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<EMODE_KEY, Emode>(&mut arg0.id, v0);
        let v2 = v1.current_emode_id;
        let v3 = EmodeConfig{
            assetA   : arg1,
            assetB   : arg2,
            isActive : true,
        };
        0x2::table::add<u64, EmodeConfig>(&mut v1.emodes_pair, v2, v3);
        v1.current_emode_id = v2 + 1;
        0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::event::emit_emode_pair_created(v2, arg1.assetId, arg2.assetId, get_market_id(arg0));
    }

    public(friend) fun create_new_market(arg0: &mut Storage, arg1: &mut 0x2::tx_context::TxContext) {
        version_verification(arg0);
        let v0 = MARKET_KEY{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<MARKET_KEY, MarketInfo>(&mut arg0.id, v0);
        assert!(v1.is_main_market, 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::error::invalid_function_call());
        let v2 = Storage{
            id             : 0x2::object::new(arg1),
            version        : 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::version::this_version(),
            paused         : false,
            reserves       : 0x2::table::new<u8, ReserveData>(arg1),
            reserves_count : 0,
            users          : 0x1::vector::empty<address>(),
            user_info      : 0x2::table::new<address, UserInfo>(arg1),
        };
        let v3 = &mut v2;
        init_protected_liquidation_fields(v3, arg1);
        let v4 = &mut v2;
        init_emode_fields(v4, arg1);
        let v5 = &mut v2;
        init_borrow_weight_fields(v5, arg1);
        let v6 = MarketInfo{
            market_id      : v1.last_market_id + 1,
            last_market_id : 0,
            is_main_market : false,
        };
        let v7 = MARKET_KEY{dummy_field: false};
        0x2::dynamic_field::add<MARKET_KEY, MarketInfo>(&mut v2.id, v7, v6);
        0x2::transfer::share_object<Storage>(v2);
        v1.last_market_id = v1.last_market_id + 1;
        0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::event::emit_market_created(v1.last_market_id);
    }

    fun decrease_balance(arg0: &mut TokenBalance, arg1: address, arg2: u256) {
        let v0 = 0;
        if (0x2::table::contains<address, u256>(&arg0.user_state, arg1)) {
            v0 = 0x2::table::remove<address, u256>(&mut arg0.user_state, arg1);
        };
        assert!(v0 >= arg2, 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::error::insufficient_balance());
        0x2::table::add<address, u256>(&mut arg0.user_state, arg1, v0 - arg2);
        arg0.total_supply = arg0.total_supply - arg2;
    }

    public(friend) fun decrease_borrow_balance(arg0: &mut Storage, arg1: u8, arg2: address, arg3: u256) {
        version_verification(arg0);
        let v0 = &mut 0x2::table::borrow_mut<u8, ReserveData>(&mut arg0.reserves, arg1).borrow_balance;
        decrease_balance(v0, arg2, arg3);
    }

    public(friend) fun decrease_supply_balance(arg0: &mut Storage, arg1: u8, arg2: address, arg3: u256) {
        version_verification(arg0);
        let v0 = &mut 0x2::table::borrow_mut<u8, ReserveData>(&mut arg0.reserves, arg1).supply_balance;
        decrease_balance(v0, arg2, arg3);
    }

    public(friend) fun decrease_total_supply_balance(arg0: &mut Storage, arg1: u8, arg2: u256) {
        let v0 = &mut 0x2::table::borrow_mut<u8, ReserveData>(&mut arg0.reserves, arg1).supply_balance;
        v0.total_supply = v0.total_supply - arg2;
    }

    public fun destory_user(arg0: &StorageAdminCap, arg1: &mut Storage) {
        abort 0
    }

    public(friend) fun enter_emode(arg0: &mut Storage, arg1: u64, arg2: address) {
        version_verification(arg0);
        when_not_paused(arg0);
        let v0 = EMODE_KEY{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<EMODE_KEY, Emode>(&mut arg0.id, v0);
        assert!(0x2::table::borrow<u64, EmodeConfig>(&v1.emodes_pair, arg1).isActive, 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::error::emode_is_not_active());
        assert!(!0x2::table::contains<address, u64>(&v1.user_emode_id, arg2), 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::error::duplicate_emode());
        0x2::table::add<address, u64>(&mut v1.user_emode_id, arg2, arg1);
        0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::event::emit_emode_user_state_changed(arg2, arg1, true, get_market_id(arg0));
    }

    public(friend) fun exit_emode(arg0: &mut Storage, arg1: address) {
        version_verification(arg0);
        when_not_paused(arg0);
        let v0 = EMODE_KEY{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<EMODE_KEY, Emode>(&mut arg0.id, v0);
        assert!(0x2::table::contains<address, u64>(&v1.user_emode_id, arg1), 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::error::not_in_emode());
        0x2::table::remove<address, u64>(&mut v1.user_emode_id, arg1);
        0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::event::emit_emode_user_state_changed(arg1, *0x2::table::borrow<address, u64>(&v1.user_emode_id, arg1), false, get_market_id(arg0));
    }

    public fun get_asset_ltv(arg0: &Storage, arg1: u8) : u256 {
        0x2::table::borrow<u8, ReserveData>(&arg0.reserves, arg1).ltv
    }

    public fun get_borrow_cap_ceiling_ratio(arg0: &mut Storage, arg1: u8) : u256 {
        0x2::table::borrow<u8, ReserveData>(&arg0.reserves, arg1).borrow_cap_ceiling
    }

    public fun get_borrow_rate_factors(arg0: &mut Storage, arg1: u8) : (u256, u256, u256, u256, u256) {
        let v0 = 0x2::table::borrow<u8, ReserveData>(&arg0.reserves, arg1);
        (v0.borrow_rate_factors.base_rate, v0.borrow_rate_factors.multiplier, v0.borrow_rate_factors.jump_rate_multiplier, v0.borrow_rate_factors.reserve_factor, v0.borrow_rate_factors.optimal_utilization)
    }

    public fun get_borrow_weight(arg0: &Storage, arg1: u8) : u64 {
        let v0 = BORROW_WEIGHT_KEY{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<BORROW_WEIGHT_KEY, 0x2::table::Table<u8, u64>>(&arg0.id, v0);
        if (0x2::table::contains<u8, u64>(v1, arg1)) {
            *0x2::table::borrow<u8, u64>(v1, arg1)
        } else {
            0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::constants::percentage_benchmark()
        }
    }

    public fun get_coin_type(arg0: &Storage, arg1: u8) : 0x1::ascii::String {
        0x2::table::borrow<u8, ReserveData>(&arg0.reserves, arg1).coin_type
    }

    public fun get_current_rate(arg0: &mut Storage, arg1: u8) : (u256, u256) {
        let v0 = 0x2::table::borrow<u8, ReserveData>(&arg0.reserves, arg1);
        (v0.current_supply_rate, v0.current_borrow_rate)
    }

    fun get_emode_asset(arg0: &Storage, arg1: u64, arg2: u8) : &EmodeAsset {
        let v0 = EMODE_KEY{dummy_field: false};
        let v1 = 0x2::table::borrow<u64, EmodeConfig>(&0x2::dynamic_field::borrow<EMODE_KEY, Emode>(&arg0.id, v0).emodes_pair, arg1);
        if (v1.assetA.assetId == arg2) {
            &v1.assetA
        } else {
            assert!(v1.assetB.assetId == arg2, 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::error::not_in_emode());
            &v1.assetB
        }
    }

    public fun get_emode_asset_info(arg0: &Storage, arg1: u64, arg2: u8) : (u256, u256, u256) {
        let v0 = get_emode_asset(arg0, arg1, arg2);
        (v0.ltv, v0.lt, v0.liquidation_bonus)
    }

    fun get_emode_asset_mut(arg0: &mut Storage, arg1: u64, arg2: u8) : &mut EmodeAsset {
        let v0 = EMODE_KEY{dummy_field: false};
        let v1 = 0x2::table::borrow_mut<u64, EmodeConfig>(&mut 0x2::dynamic_field::borrow_mut<EMODE_KEY, Emode>(&mut arg0.id, v0).emodes_pair, arg1);
        if (v1.assetA.assetId == arg2) {
            &mut v1.assetA
        } else {
            assert!(v1.assetB.assetId == arg2, 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::error::not_in_emode());
            &mut v1.assetB
        }
    }

    public fun get_emode_info(arg0: &Storage, arg1: u64) : (u256, u256, u256, u256, u256, u256, bool) {
        let v0 = EMODE_KEY{dummy_field: false};
        let v1 = 0x2::table::borrow<u64, EmodeConfig>(&0x2::dynamic_field::borrow<EMODE_KEY, Emode>(&arg0.id, v0).emodes_pair, arg1);
        (v1.assetA.ltv, v1.assetA.lt, v1.assetA.liquidation_bonus, v1.assetB.ltv, v1.assetB.lt, v1.assetB.liquidation_bonus, v1.isActive)
    }

    public fun get_index(arg0: &mut Storage, arg1: u8) : (u256, u256) {
        let v0 = 0x2::table::borrow<u8, ReserveData>(&arg0.reserves, arg1);
        (v0.current_supply_index, v0.current_borrow_index)
    }

    public fun get_last_update_timestamp(arg0: &Storage, arg1: u8) : u64 {
        0x2::table::borrow<u8, ReserveData>(&arg0.reserves, arg1).last_update_timestamp
    }

    public fun get_liquidation_factors(arg0: &mut Storage, arg1: u8) : (u256, u256, u256) {
        let v0 = 0x2::table::borrow<u8, ReserveData>(&arg0.reserves, arg1);
        (v0.liquidation_factors.ratio, v0.liquidation_factors.bonus, v0.liquidation_factors.threshold)
    }

    public fun get_market_id(arg0: &Storage) : u64 {
        let v0 = MARKET_KEY{dummy_field: false};
        0x2::dynamic_field::borrow<MARKET_KEY, MarketInfo>(&arg0.id, v0).market_id
    }

    public fun get_oracle_id(arg0: &Storage, arg1: u8) : u8 {
        0x2::table::borrow<u8, ReserveData>(&arg0.reserves, arg1).oracle_id
    }

    public fun get_reserve_for_testing(arg0: &Storage, arg1: u8) : &ReserveData {
        0x2::table::borrow<u8, ReserveData>(&arg0.reserves, arg1)
    }

    public fun get_reserves_count(arg0: &Storage) : u8 {
        arg0.reserves_count
    }

    public fun get_storage_market_info(arg0: &Storage) : (u64, u64, bool) {
        let v0 = MARKET_KEY{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<MARKET_KEY, MarketInfo>(&arg0.id, v0);
        (v1.market_id, v1.last_market_id, v1.is_main_market)
    }

    public fun get_supply_cap_ceiling(arg0: &mut Storage, arg1: u8) : u256 {
        0x2::table::borrow<u8, ReserveData>(&arg0.reserves, arg1).supply_cap_ceiling
    }

    public fun get_total_supply(arg0: &mut Storage, arg1: u8) : (u256, u256) {
        let v0 = 0x2::table::borrow<u8, ReserveData>(&arg0.reserves, arg1);
        (v0.supply_balance.total_supply, v0.borrow_balance.total_supply)
    }

    public fun get_treasury_balance(arg0: &Storage, arg1: u8) : u256 {
        0x2::table::borrow<u8, ReserveData>(&arg0.reserves, arg1).treasury_balance
    }

    public fun get_treasury_factor(arg0: &mut Storage, arg1: u8) : u256 {
        0x2::table::borrow<u8, ReserveData>(&arg0.reserves, arg1).treasury_factor
    }

    public fun get_user_assets(arg0: &Storage, arg1: address) : (vector<u8>, vector<u8>) {
        if (!0x2::table::contains<address, UserInfo>(&arg0.user_info, arg1)) {
            return (0x1::vector::empty<u8>(), 0x1::vector::empty<u8>())
        };
        let v0 = 0x2::table::borrow<address, UserInfo>(&arg0.user_info, arg1);
        (v0.collaterals, v0.loans)
    }

    public fun get_user_balance(arg0: &mut Storage, arg1: u8, arg2: address) : (u256, u256) {
        let v0 = 0x2::table::borrow<u8, ReserveData>(&arg0.reserves, arg1);
        let v1 = 0;
        let v2 = 0;
        if (0x2::table::contains<address, u256>(&v0.supply_balance.user_state, arg2)) {
            v1 = *0x2::table::borrow<address, u256>(&v0.supply_balance.user_state, arg2);
        };
        if (0x2::table::contains<address, u256>(&v0.borrow_balance.user_state, arg2)) {
            v2 = *0x2::table::borrow<address, u256>(&v0.borrow_balance.user_state, arg2);
        };
        (v1, v2)
    }

    public fun get_user_emode_id(arg0: &Storage, arg1: address) : u64 {
        let v0 = EMODE_KEY{dummy_field: false};
        *0x2::table::borrow<address, u64>(&0x2::dynamic_field::borrow<EMODE_KEY, Emode>(&arg0.id, v0).user_emode_id, arg1)
    }

    fun increase_balance(arg0: &mut TokenBalance, arg1: address, arg2: u256) {
        let v0 = 0;
        if (0x2::table::contains<address, u256>(&arg0.user_state, arg1)) {
            v0 = 0x2::table::remove<address, u256>(&mut arg0.user_state, arg1);
        };
        0x2::table::add<address, u256>(&mut arg0.user_state, arg1, v0 + arg2);
        arg0.total_supply = arg0.total_supply + arg2;
    }

    public(friend) fun increase_balance_for_pool(arg0: &mut Storage, arg1: u8, arg2: u256, arg3: u256) {
        version_verification(arg0);
        let v0 = 0x2::table::borrow_mut<u8, ReserveData>(&mut arg0.reserves, arg1);
        let v1 = &mut v0.supply_balance;
        let v2 = &mut v0.borrow_balance;
        v1.total_supply = v1.total_supply + arg2;
        v2.total_supply = v2.total_supply + arg3;
    }

    public(friend) fun increase_borrow_balance(arg0: &mut Storage, arg1: u8, arg2: address, arg3: u256) {
        version_verification(arg0);
        let v0 = &mut 0x2::table::borrow_mut<u8, ReserveData>(&mut arg0.reserves, arg1).borrow_balance;
        increase_balance(v0, arg2, arg3);
    }

    public(friend) fun increase_supply_balance(arg0: &mut Storage, arg1: u8, arg2: address, arg3: u256) {
        version_verification(arg0);
        let v0 = &mut 0x2::table::borrow_mut<u8, ReserveData>(&mut arg0.reserves, arg1).supply_balance;
        increase_balance(v0, arg2, arg3);
    }

    public(friend) fun increase_total_supply_balance(arg0: &mut Storage, arg1: u8, arg2: u256) {
        let v0 = &mut 0x2::table::borrow_mut<u8, ReserveData>(&mut arg0.reserves, arg1).supply_balance;
        v0.total_supply = v0.total_supply + arg2;
    }

    public(friend) fun increase_treasury_balance(arg0: &mut Storage, arg1: u8, arg2: u256) {
        let v0 = 0x2::table::borrow_mut<u8, ReserveData>(&mut arg0.reserves, arg1);
        v0.treasury_balance = v0.treasury_balance + arg2;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StorageAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<StorageAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OwnerCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = Storage{
            id             : 0x2::object::new(arg0),
            version        : 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::version::this_version(),
            paused         : false,
            reserves       : 0x2::table::new<u8, ReserveData>(arg0),
            reserves_count : 0,
            users          : 0x1::vector::empty<address>(),
            user_info      : 0x2::table::new<address, UserInfo>(arg0),
        };
        let v3 = &mut v2;
        init_protected_liquidation_fields(v3, arg0);
        let v4 = &mut v2;
        init_emode_fields(v4, arg0);
        let v5 = &mut v2;
        init_borrow_weight_fields(v5, arg0);
        let v6 = &mut v2;
        init_main_market(v6);
        0x2::transfer::share_object<Storage>(v2);
    }

    fun init_borrow_weight_fields(arg0: &mut Storage, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BORROW_WEIGHT_KEY{dummy_field: false};
        0x2::dynamic_field::add<BORROW_WEIGHT_KEY, 0x2::table::Table<u8, u64>>(&mut arg0.id, v0, 0x2::table::new<u8, u64>(arg1));
    }

    public fun init_borrow_weight_for_main_market(arg0: &StorageAdminCap, arg1: &mut Storage, arg2: &mut 0x2::tx_context::TxContext) {
        init_borrow_weight_fields(arg1, arg2);
    }

    fun init_emode_fields(arg0: &mut Storage, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Emode{
            emodes_pair      : 0x2::table::new<u64, EmodeConfig>(arg1),
            user_emode_id    : 0x2::table::new<address, u64>(arg1),
            current_emode_id : 0,
        };
        let v1 = EMODE_KEY{dummy_field: false};
        0x2::dynamic_field::add<EMODE_KEY, Emode>(&mut arg0.id, v1, v0);
    }

    public fun init_emode_for_main_market(arg0: &StorageAdminCap, arg1: &mut Storage, arg2: &mut 0x2::tx_context::TxContext) {
        init_emode_fields(arg1, arg2);
    }

    public fun init_for_main_market(arg0: &StorageAdminCap, arg1: &mut Storage) {
        init_main_market(arg1);
    }

    fun init_main_market(arg0: &mut Storage) {
        let v0 = MARKET_KEY{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<MARKET_KEY>(&arg0.id, v0), 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::error::invalid_function_call());
        let v1 = MARKET_KEY{dummy_field: false};
        let v2 = MarketInfo{
            market_id      : 0,
            last_market_id : 0,
            is_main_market : true,
        };
        0x2::dynamic_field::add<MARKET_KEY, MarketInfo>(&mut arg0.id, v1, v2);
    }

    public(friend) fun init_protected_liquidation_fields(arg0: &mut Storage, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DESIGNATED_LIQUIDATORS_KEY{dummy_field: false};
        0x2::dynamic_field::add<DESIGNATED_LIQUIDATORS_KEY, 0x2::table::Table<address, 0x2::table::Table<address, bool>>>(&mut arg0.id, v0, 0x2::table::new<address, 0x2::table::Table<address, bool>>(arg1));
        let v1 = PROTECTED_LIQUIDATION_USERS_KEY{dummy_field: false};
        0x2::dynamic_field::add<PROTECTED_LIQUIDATION_USERS_KEY, 0x2::table::Table<address, bool>>(&mut arg0.id, v1, 0x2::table::new<address, bool>(arg1));
    }

    public entry fun init_reserve<T0>(arg0: &StorageAdminCap, arg1: &0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::pool::PoolAdminCap, arg2: &0x2::clock::Clock, arg3: &mut Storage, arg4: u8, arg5: bool, arg6: u256, arg7: u256, arg8: u256, arg9: u256, arg10: u256, arg11: u256, arg12: u256, arg13: u256, arg14: u256, arg15: u256, arg16: u256, arg17: u256, arg18: &0x2::coin::CoinMetadata<T0>, arg19: &mut 0x2::tx_context::TxContext) {
        version_verification(arg3);
        let v0 = arg3.reserves_count;
        assert!(v0 < 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::constants::max_number_of_reserves(), 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::error::no_more_reserves_allowed());
        reserve_validation<T0>(arg3);
        percentage_ray_validation(arg7);
        percentage_ray_validation(arg9);
        percentage_ray_validation(arg12);
        percentage_ray_validation(arg14);
        percentage_ray_validation(arg15);
        percentage_ray_validation(arg16);
        percentage_ray_validation(arg13);
        percentage_ray_validation(arg17);
        let v1 = TokenBalance{
            user_state   : 0x2::table::new<address, u256>(arg19),
            total_supply : 0,
        };
        let v2 = TokenBalance{
            user_state   : 0x2::table::new<address, u256>(arg19),
            total_supply : 0,
        };
        let v3 = BorrowRateFactors{
            base_rate            : arg8,
            multiplier           : arg10,
            jump_rate_multiplier : arg11,
            reserve_factor       : arg12,
            optimal_utilization  : arg9,
        };
        let v4 = LiquidationFactors{
            ratio     : arg15,
            bonus     : arg16,
            threshold : arg17,
        };
        let v5 = ReserveData{
            id                    : arg3.reserves_count,
            oracle_id             : arg4,
            coin_type             : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            is_isolated           : arg5,
            supply_cap_ceiling    : arg6,
            borrow_cap_ceiling    : arg7,
            current_supply_rate   : 0,
            current_borrow_rate   : 0,
            current_supply_index  : 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::ray_math::ray(),
            current_borrow_index  : 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::ray_math::ray(),
            supply_balance        : v1,
            borrow_balance        : v2,
            last_update_timestamp : 0x2::clock::timestamp_ms(arg2),
            ltv                   : arg13,
            treasury_factor       : arg14,
            treasury_balance      : 0,
            borrow_rate_factors   : v3,
            liquidation_factors   : v4,
            reserve_field_a       : 0,
            reserve_field_b       : 0,
            reserve_field_c       : 0,
        };
        0x2::table::add<u8, ReserveData>(&mut arg3.reserves, v0, v5);
        arg3.reserves_count = v0 + 1;
        let v6 = MARKET_KEY{dummy_field: false};
        0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::pool::create_pool_with_market_id<T0>(arg1, 0x2::coin::get_decimals<T0>(arg18), 0x2::dynamic_field::borrow<MARKET_KEY, MarketInfo>(&arg3.id, v6).market_id, arg19);
    }

    public entry fun init_reserve_with_decimals<T0>(arg0: &StorageAdminCap, arg1: &0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::pool::PoolAdminCap, arg2: &0x2::clock::Clock, arg3: &mut Storage, arg4: u8, arg5: bool, arg6: u256, arg7: u256, arg8: u256, arg9: u256, arg10: u256, arg11: u256, arg12: u256, arg13: u256, arg14: u256, arg15: u256, arg16: u256, arg17: u256, arg18: u8, arg19: &mut 0x2::tx_context::TxContext) {
        version_verification(arg3);
        let v0 = arg3.reserves_count;
        assert!(v0 < 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::constants::max_number_of_reserves(), 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::error::no_more_reserves_allowed());
        reserve_validation<T0>(arg3);
        percentage_ray_validation(arg7);
        percentage_ray_validation(arg9);
        percentage_ray_validation(arg12);
        percentage_ray_validation(arg14);
        percentage_ray_validation(arg15);
        percentage_ray_validation(arg16);
        percentage_ray_validation(arg13);
        percentage_ray_validation(arg17);
        let v1 = TokenBalance{
            user_state   : 0x2::table::new<address, u256>(arg19),
            total_supply : 0,
        };
        let v2 = TokenBalance{
            user_state   : 0x2::table::new<address, u256>(arg19),
            total_supply : 0,
        };
        let v3 = BorrowRateFactors{
            base_rate            : arg8,
            multiplier           : arg10,
            jump_rate_multiplier : arg11,
            reserve_factor       : arg12,
            optimal_utilization  : arg9,
        };
        let v4 = LiquidationFactors{
            ratio     : arg15,
            bonus     : arg16,
            threshold : arg17,
        };
        let v5 = ReserveData{
            id                    : arg3.reserves_count,
            oracle_id             : arg4,
            coin_type             : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            is_isolated           : arg5,
            supply_cap_ceiling    : arg6,
            borrow_cap_ceiling    : arg7,
            current_supply_rate   : 0,
            current_borrow_rate   : 0,
            current_supply_index  : 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::ray_math::ray(),
            current_borrow_index  : 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::ray_math::ray(),
            supply_balance        : v1,
            borrow_balance        : v2,
            last_update_timestamp : 0x2::clock::timestamp_ms(arg2),
            ltv                   : arg13,
            treasury_factor       : arg14,
            treasury_balance      : 0,
            borrow_rate_factors   : v3,
            liquidation_factors   : v4,
            reserve_field_a       : 0,
            reserve_field_b       : 0,
            reserve_field_c       : 0,
        };
        0x2::table::add<u8, ReserveData>(&mut arg3.reserves, v0, v5);
        arg3.reserves_count = v0 + 1;
        let v6 = MARKET_KEY{dummy_field: false};
        0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::pool::create_pool_with_market_id<T0>(arg1, arg18, 0x2::dynamic_field::borrow<MARKET_KEY, MarketInfo>(&arg3.id, v6).market_id, arg19);
    }

    public fun is_in_emode(arg0: &Storage, arg1: address) : bool {
        let v0 = EMODE_KEY{dummy_field: false};
        0x2::table::contains<address, u64>(&0x2::dynamic_field::borrow<EMODE_KEY, Emode>(&arg0.id, v0).user_emode_id, arg1)
    }

    public fun is_liquidatable(arg0: &mut Storage, arg1: address, arg2: address) : bool {
        let v0 = PROTECTED_LIQUIDATION_USERS_KEY{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<PROTECTED_LIQUIDATION_USERS_KEY, 0x2::table::Table<address, bool>>(&arg0.id, v0);
        let v2 = DESIGNATED_LIQUIDATORS_KEY{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow<DESIGNATED_LIQUIDATORS_KEY, 0x2::table::Table<address, 0x2::table::Table<address, bool>>>(&arg0.id, v2);
        if (!0x2::table::contains<address, bool>(v1, arg2) || !*0x2::table::borrow<address, bool>(v1, arg2)) {
            return true
        };
        if (!0x2::table::contains<address, 0x2::table::Table<address, bool>>(v3, arg1)) {
            return false
        };
        let v4 = 0x2::table::borrow<address, 0x2::table::Table<address, bool>>(v3, arg1);
        if (!0x2::table::contains<address, bool>(v4, arg2)) {
            return false
        };
        *0x2::table::borrow<address, bool>(v4, arg2)
    }

    public fun is_passed_emode_check(arg0: &Storage, arg1: address, arg2: u8, arg3: bool, arg4: bool) : bool {
        let v0 = EMODE_KEY{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<EMODE_KEY, Emode>(&arg0.id, v0);
        if (!0x2::table::contains<address, u64>(&v1.user_emode_id, arg1)) {
            return true
        };
        let v2 = get_emode_asset(arg0, *0x2::table::borrow<address, u64>(&v1.user_emode_id, arg1), arg2);
        if (arg3 && !v2.isCollateral) {
            return false
        };
        if (arg4 && !v2.isDebt) {
            return false
        };
        true
    }

    public fun mint_owner_cap(arg0: &StorageAdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<OwnerCap>(v0, arg1);
    }

    public fun pause(arg0: &Storage) : bool {
        arg0.paused
    }

    fun percentage_ray_validation(arg0: u256) {
        assert!(arg0 <= 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::ray_math::ray(), 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::error::invalid_value());
    }

    public(friend) fun remove_borrow_weight(arg0: &mut Storage, arg1: u8) {
        version_verification(arg0);
        let v0 = BORROW_WEIGHT_KEY{dummy_field: false};
        0x2::table::remove<u8, u64>(0x2::dynamic_field::borrow_mut<BORROW_WEIGHT_KEY, 0x2::table::Table<u8, u64>>(&mut arg0.id, v0), arg1);
        0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::event::emit_borrow_weight_removed(arg1, get_market_id(arg0));
    }

    public(friend) fun remove_user_collaterals(arg0: &mut Storage, arg1: u8, arg2: address) {
        let v0 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.user_info, arg2);
        let (v1, v2) = 0x1::vector::index_of<u8>(&v0.collaterals, &arg1);
        if (v1) {
            0x1::vector::remove<u8>(&mut v0.collaterals, v2);
        };
    }

    public(friend) fun remove_user_loans(arg0: &mut Storage, arg1: u8, arg2: address) {
        let v0 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.user_info, arg2);
        let (v1, v2) = 0x1::vector::index_of<u8>(&v0.loans, &arg1);
        if (v1) {
            0x1::vector::remove<u8>(&mut v0.loans, v2);
        };
    }

    public fun reserve_validation<T0>(arg0: &Storage) {
        let v0 = 0;
        while (v0 < arg0.reserves_count) {
            assert!(0x2::table::borrow<u8, ReserveData>(&arg0.reserves, v0).coin_type != 0x1::type_name::into_string(0x1::type_name::get<T0>()), 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::error::duplicate_reserve());
            v0 = v0 + 1;
        };
    }

    public fun set_base_rate(arg0: &OwnerCap, arg1: &mut Storage, arg2: u8, arg3: u256) {
        version_verification(arg1);
        0x2::table::borrow_mut<u8, ReserveData>(&mut arg1.reserves, arg2).borrow_rate_factors.base_rate = arg3;
    }

    public fun set_borrow_cap(arg0: &OwnerCap, arg1: &mut Storage, arg2: u8, arg3: u256) {
        version_verification(arg1);
        percentage_ray_validation(arg3);
        0x2::table::borrow_mut<u8, ReserveData>(&mut arg1.reserves, arg2).borrow_cap_ceiling = arg3;
    }

    public(friend) fun set_borrow_weight(arg0: &mut Storage, arg1: u8, arg2: u64) {
        version_verification(arg0);
        assert!(arg2 <= 10 * 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::constants::percentage_benchmark(), 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::error::invalid_value());
        assert!(arg2 >= 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::constants::percentage_benchmark(), 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::error::invalid_value());
        let v0 = BORROW_WEIGHT_KEY{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<BORROW_WEIGHT_KEY, 0x2::table::Table<u8, u64>>(&mut arg0.id, v0);
        if (!0x2::table::contains<u8, u64>(v1, arg1)) {
            0x2::table::add<u8, u64>(v1, arg1, arg2);
        } else {
            *0x2::table::borrow_mut<u8, u64>(v1, arg1) = arg2;
        };
        0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::event::emit_borrow_weight_set(arg1, arg2, get_market_id(arg0));
    }

    public(friend) fun set_designated_liquidators(arg0: &mut Storage, arg1: address, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        version_verification(arg0);
        let v0 = DESIGNATED_LIQUIDATORS_KEY{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<DESIGNATED_LIQUIDATORS_KEY, 0x2::table::Table<address, 0x2::table::Table<address, bool>>>(&mut arg0.id, v0);
        if (!0x2::table::contains<address, 0x2::table::Table<address, bool>>(v1, arg1)) {
            0x2::table::add<address, 0x2::table::Table<address, bool>>(v1, arg1, 0x2::table::new<address, bool>(arg4));
        };
        let v2 = 0x2::table::borrow_mut<address, 0x2::table::Table<address, bool>>(v1, arg1);
        if (!0x2::table::contains<address, bool>(v2, arg2)) {
            0x2::table::add<address, bool>(v2, arg2, arg3);
        } else {
            *0x2::table::borrow_mut<address, bool>(v2, arg2) = arg3;
        };
        0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::event::emit_liquidator_set(arg1, arg2, arg3, get_market_id(arg0));
    }

    public(friend) fun set_emode_asset_liquidation_bonus(arg0: &mut Storage, arg1: u64, arg2: u8, arg3: u256) {
        let v0 = get_emode_asset_mut(arg0, arg1, arg2);
        percentage_ray_validation(arg3);
        v0.liquidation_bonus = arg3;
        0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::event::emit_emode_param_set(arg1, arg2, arg3, 2, get_market_id(arg0));
    }

    public(friend) fun set_emode_asset_lt(arg0: &mut Storage, arg1: u64, arg2: u8, arg3: u256) {
        let v0 = get_emode_asset_mut(arg0, arg1, arg2);
        percentage_ray_validation(arg3);
        v0.lt = arg3;
        0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::event::emit_emode_param_set(arg1, arg2, arg3, 0, get_market_id(arg0));
    }

    public(friend) fun set_emode_asset_ltv(arg0: &mut Storage, arg1: u64, arg2: u8, arg3: u256) {
        let v0 = get_emode_asset_mut(arg0, arg1, arg2);
        percentage_ray_validation(arg3);
        v0.ltv = arg3;
        0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::event::emit_emode_param_set(arg1, arg2, arg3, 1, get_market_id(arg0));
    }

    public(friend) fun set_emode_config_active(arg0: &mut Storage, arg1: u64, arg2: bool) {
        let v0 = EMODE_KEY{dummy_field: false};
        0x2::table::borrow_mut<u64, EmodeConfig>(&mut 0x2::dynamic_field::borrow_mut<EMODE_KEY, Emode>(&mut arg0.id, v0).emodes_pair, arg1).isActive = arg2;
    }

    public fun set_jump_rate_multiplier(arg0: &OwnerCap, arg1: &mut Storage, arg2: u8, arg3: u256) {
        version_verification(arg1);
        0x2::table::borrow_mut<u8, ReserveData>(&mut arg1.reserves, arg2).borrow_rate_factors.jump_rate_multiplier = arg3;
    }

    public fun set_liquidation_bonus(arg0: &OwnerCap, arg1: &mut Storage, arg2: u8, arg3: u256) {
        version_verification(arg1);
        percentage_ray_validation(arg3);
        0x2::table::borrow_mut<u8, ReserveData>(&mut arg1.reserves, arg2).liquidation_factors.bonus = arg3;
    }

    public fun set_liquidation_ratio(arg0: &OwnerCap, arg1: &mut Storage, arg2: u8, arg3: u256) {
        version_verification(arg1);
        percentage_ray_validation(arg3);
        0x2::table::borrow_mut<u8, ReserveData>(&mut arg1.reserves, arg2).liquidation_factors.ratio = arg3;
    }

    public fun set_liquidation_threshold(arg0: &OwnerCap, arg1: &mut Storage, arg2: u8, arg3: u256) {
        version_verification(arg1);
        percentage_ray_validation(arg3);
        0x2::table::borrow_mut<u8, ReserveData>(&mut arg1.reserves, arg2).liquidation_factors.threshold = arg3;
    }

    public fun set_ltv(arg0: &OwnerCap, arg1: &mut Storage, arg2: u8, arg3: u256) {
        version_verification(arg1);
        percentage_ray_validation(arg3);
        0x2::table::borrow_mut<u8, ReserveData>(&mut arg1.reserves, arg2).ltv = arg3;
    }

    public fun set_multiplier(arg0: &OwnerCap, arg1: &mut Storage, arg2: u8, arg3: u256) {
        version_verification(arg1);
        0x2::table::borrow_mut<u8, ReserveData>(&mut arg1.reserves, arg2).borrow_rate_factors.multiplier = arg3;
    }

    public fun set_optimal_utilization(arg0: &OwnerCap, arg1: &mut Storage, arg2: u8, arg3: u256) {
        version_verification(arg1);
        percentage_ray_validation(arg3);
        0x2::table::borrow_mut<u8, ReserveData>(&mut arg1.reserves, arg2).borrow_rate_factors.optimal_utilization = arg3;
    }

    public entry fun set_pause(arg0: &OwnerCap, arg1: &mut Storage, arg2: bool) {
        version_verification(arg1);
        arg1.paused = arg2;
        0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::event::emit_paused(arg2, get_market_id(arg1));
    }

    public(friend) fun set_protected_liquidation_users(arg0: &mut Storage, arg1: address, arg2: bool) {
        version_verification(arg0);
        let v0 = PROTECTED_LIQUIDATION_USERS_KEY{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<PROTECTED_LIQUIDATION_USERS_KEY, 0x2::table::Table<address, bool>>(&mut arg0.id, v0);
        if (!0x2::table::contains<address, bool>(v1, arg1)) {
            0x2::table::add<address, bool>(v1, arg1, arg2);
        } else {
            *0x2::table::borrow_mut<address, bool>(v1, arg1) = arg2;
        };
        0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::event::emit_protected_user_set(arg1, arg2, get_market_id(arg0));
    }

    public fun set_reserve_factor(arg0: &OwnerCap, arg1: &mut Storage, arg2: u8, arg3: u256) {
        version_verification(arg1);
        percentage_ray_validation(arg3);
        0x2::table::borrow_mut<u8, ReserveData>(&mut arg1.reserves, arg2).borrow_rate_factors.reserve_factor = arg3;
    }

    public fun set_supply_cap(arg0: &OwnerCap, arg1: &mut Storage, arg2: u8, arg3: u256) {
        version_verification(arg1);
        0x2::table::borrow_mut<u8, ReserveData>(&mut arg1.reserves, arg2).supply_cap_ceiling = arg3;
    }

    public fun set_treasury_factor(arg0: &OwnerCap, arg1: &mut Storage, arg2: u8, arg3: u256) {
        version_verification(arg1);
        percentage_ray_validation(arg3);
        0x2::table::borrow_mut<u8, ReserveData>(&mut arg1.reserves, arg2).treasury_factor = arg3;
    }

    public(friend) fun update_interest_rate(arg0: &mut Storage, arg1: u8, arg2: u256, arg3: u256) {
        version_verification(arg0);
        let v0 = 0x2::table::borrow_mut<u8, ReserveData>(&mut arg0.reserves, arg1);
        v0.current_supply_rate = arg3;
        v0.current_borrow_rate = arg2;
    }

    public(friend) fun update_state(arg0: &mut Storage, arg1: u8, arg2: u256, arg3: u256, arg4: u64, arg5: u256) {
        version_verification(arg0);
        let v0 = 0x2::table::borrow_mut<u8, ReserveData>(&mut arg0.reserves, arg1);
        v0.current_borrow_index = arg2;
        v0.current_supply_index = arg3;
        v0.last_update_timestamp = arg4;
        v0.treasury_balance = v0.treasury_balance + arg5;
    }

    public(friend) fun update_user_collaterals(arg0: &mut Storage, arg1: u8, arg2: address) {
        if (!0x2::table::contains<address, UserInfo>(&arg0.user_info, arg2)) {
            let v0 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v0, arg1);
            let v1 = UserInfo{
                collaterals : v0,
                loans       : 0x1::vector::empty<u8>(),
            };
            0x2::table::add<address, UserInfo>(&mut arg0.user_info, arg2, v1);
        } else {
            let v2 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.user_info, arg2);
            if (!0x1::vector::contains<u8>(&v2.collaterals, &arg1)) {
                0x1::vector::push_back<u8>(&mut v2.collaterals, arg1);
            };
        };
    }

    public(friend) fun update_user_loans(arg0: &mut Storage, arg1: u8, arg2: address) {
        if (!0x2::table::contains<address, UserInfo>(&arg0.user_info, arg2)) {
            let v0 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v0, arg1);
            let v1 = UserInfo{
                collaterals : 0x1::vector::empty<u8>(),
                loans       : v0,
            };
            0x2::table::add<address, UserInfo>(&mut arg0.user_info, arg2, v1);
        } else {
            let v2 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.user_info, arg2);
            if (!0x1::vector::contains<u8>(&v2.loans, &arg1)) {
                0x1::vector::push_back<u8>(&mut v2.loans, arg1);
            };
        };
    }

    public fun verify_emode_support(arg0: &Storage, arg1: address, arg2: u8, arg3: bool, arg4: bool) {
        assert!(is_passed_emode_check(arg0, arg1, arg2, arg3, arg4), 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::error::ineligible_for_emode());
    }

    public entry fun version_migrate(arg0: &StorageAdminCap, arg1: &mut Storage) {
        assert!(arg1.version < 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::version::this_version(), 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::error::not_available_version());
        arg1.version = 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::version::this_version();
    }

    public fun version_verification(arg0: &Storage) {
        0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::version::pre_check_version(arg0.version);
    }

    public fun when_liquidatable(arg0: &mut Storage, arg1: address, arg2: address) {
        assert!(is_liquidatable(arg0, arg1, arg2), 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::error::not_liquidatable());
    }

    public fun when_not_paused(arg0: &Storage) {
        assert!(!pause(arg0), 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::error::paused());
    }

    public fun withdraw_treasury<T0>(arg0: &StorageAdminCap, arg1: &0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::pool::PoolAdminCap, arg2: &mut Storage, arg3: u8, arg4: &mut 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::pool::Pool<T0>, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::error::invalid_function_call()
    }

    public fun withdraw_treasury_v2<T0>(arg0: &StorageAdminCap, arg1: &0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::pool::PoolAdminCap, arg2: &mut Storage, arg3: u8, arg4: &mut 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::pool::Pool<T0>, arg5: u64, arg6: address, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(get_coin_type(arg2, arg3) == 0x1::type_name::into_string(0x1::type_name::get<T0>()), 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::error::invalid_coin_type());
        let (v0, _) = get_index(arg2, arg3);
        let v2 = 0x2::table::borrow_mut<u8, ReserveData>(&mut arg2.reserves, arg3);
        let v3 = v2.treasury_balance;
        let v4 = 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::safe_math::min((0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::pool::normal_amount<T0>(arg4, arg5) as u256), 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::ray_math::ray_mul(v3, v0));
        let v5 = 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::ray_math::ray_div(v4, v0);
        v2.treasury_balance = v3 - v5;
        decrease_total_supply_balance(arg2, arg3, v5);
        0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::pool::withdraw_reserve_balance_v2<T0>(arg1, arg4, 0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::pool::unnormal_amount<T0>(arg4, (v4 as u64)), arg6, arg7, arg8);
        0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::event::emit_withdraw_treasury_event(0x2::tx_context::sender(arg8), arg6, arg3, v4, 0x2::object::uid_to_address(0xe1537493622defd5770d00de5b7794a03c20e989bc5a2d70b42e72cc9eb6d9bb::pool::uid<T0>(arg4)), v3, get_treasury_balance(arg2, arg3), v0, get_market_id(arg2));
    }

    // decompiled from Move bytecode v6
}

