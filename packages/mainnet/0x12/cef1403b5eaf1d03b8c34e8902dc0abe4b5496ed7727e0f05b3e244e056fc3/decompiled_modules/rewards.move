module 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::rewards {
    struct RewardRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        distributor: 0x1::option::Option<0x2::object::ID>,
        distributor_holder: 0x1::option::Option<address>,
        guardian: 0x1::option::Option<0x2::object::ID>,
        guardian_holder: 0x1::option::Option<address>,
        vaults: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        excluded: 0x2::table::Table<address, bool>,
    }

    struct DistributorCap has key {
        id: 0x2::object::UID,
    }

    struct GuardianCap has key {
        id: 0x2::object::UID,
    }

    struct RewardVault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        version: u64,
        curve_id: 0x2::object::ID,
        period_ms: u64,
        next_period_ms: u64,
        period: u64,
        period_start_ms: u64,
        periods: 0x2::table::Table<u64, PeriodRecord>,
    }

    struct PeriodRecord has store {
        start_ms: u64,
        end_ms: u64,
        post_deadline_ms: u64,
        gas_budget: u64,
        gas_unassigned: u64,
        open_budgets: u64,
        close_digest: vector<u8>,
        ref_gas_price: u64,
    }

    struct BudgetKey<phantom T0> has copy, drop, store {
        period: u64,
    }

    struct Budget has store {
        amount: u64,
        state: u8,
    }

    struct AssetKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct AssetState<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        committed: u64,
        total_in: u64,
        total_paid: u64,
        total_reimbursed: u64,
    }

    struct RootKey<phantom T0> has copy, drop, store {
        period: u64,
    }

    struct Root has store {
        merkle_root: vector<u8>,
        total: u64,
        count: u64,
        rate: u64,
        snapshot_checkpoint: u64,
        rule_version: u64,
        posted_ms: u64,
        payable_ms: u64,
        deadline_ms: u64,
        paid_amount: u64,
        paid_count: u64,
        paid_bits: 0x2::table::Table<u64, u256>,
    }

    struct LeafData has copy, drop {
        vault_id: address,
        period: u64,
        asset: 0x1::ascii::String,
        leaf_idx: u64,
        recipient: address,
        amount: u64,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        curve_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
        pay_asset: 0x1::type_name::TypeName,
        period_ms: u64,
        start_ms: u64,
    }

    struct Collected has copy, drop {
        vault_id: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        coin_id: 0x2::object::ID,
        amount: u64,
    }

    struct RewardCollected has copy, drop {
        vault_id: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        coin_id: 0x2::object::ID,
        amount: u64,
    }

    struct CreatorDeposited has copy, drop {
        vault_id: 0x2::object::ID,
        curve_id: 0x2::object::ID,
        creator: address,
        asset: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct PeriodMsSet has copy, drop {
        vault_id: 0x2::object::ID,
        next_period_ms: u64,
        current_period: u64,
    }

    struct PeriodClosed has copy, drop {
        vault_id: 0x2::object::ID,
        period: u64,
        start_ms: u64,
        end_ms: u64,
        gas_budget: u64,
        next_period_ms: u64,
        post_deadline_ms: u64,
        ref_gas_price: u64,
    }

    struct BudgetFrozen has copy, drop {
        vault_id: 0x2::object::ID,
        period: u64,
        asset: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct GasReleased has copy, drop {
        vault_id: 0x2::object::ID,
        period: u64,
        gas_released: u64,
    }

    struct RootPosted has copy, drop {
        vault_id: 0x2::object::ID,
        period: u64,
        asset: 0x1::type_name::TypeName,
        merkle_root: vector<u8>,
        total: u64,
        count: u64,
        rate: u64,
        snapshot_checkpoint: u64,
        rule_version: u64,
        posted_ms: u64,
        payable_ms: u64,
        deadline_ms: u64,
        released: u64,
        gas_released: u64,
    }

    struct RootVetoed has copy, drop {
        vault_id: 0x2::object::ID,
        period: u64,
        asset: 0x1::type_name::TypeName,
        by: u8,
        vetoer: address,
        released: u64,
        gas_released: u64,
    }

    struct Pushed has copy, drop {
        vault_id: 0x2::object::ID,
        period: u64,
        asset: 0x1::type_name::TypeName,
        leaf_idx: u64,
        recipient: address,
        amount: u64,
        pusher: address,
        reimbursement: u64,
    }

    struct RootExpired has copy, drop {
        vault_id: 0x2::object::ID,
        period: u64,
        asset: 0x1::type_name::TypeName,
        released: u64,
        gas_released: u64,
    }

    struct PeriodLapsed has copy, drop {
        vault_id: 0x2::object::ID,
        period: u64,
        asset: 0x1::type_name::TypeName,
        released: u64,
        gas_released: u64,
    }

    struct DistributorSet has copy, drop {
        cap_id: 0x1::option::Option<0x2::object::ID>,
        holder: 0x1::option::Option<address>,
    }

    struct GuardianSet has copy, drop {
        cap_id: 0x1::option::Option<0x2::object::ID>,
        holder: 0x1::option::Option<address>,
    }

    struct ExclusionSet has copy, drop {
        addr: address,
        excluded: bool,
    }

    struct RegistryMigrated has copy, drop {
        registry_id: 0x2::object::ID,
        from_version: u64,
        to_version: u64,
    }

    struct VaultMigrated has copy, drop {
        vault_id: 0x2::object::ID,
        from_version: u64,
        to_version: u64,
    }

    public fun add_exclusion(arg0: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::AdminCap, arg1: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::AdminRegistry, arg2: &mut RewardRegistry, arg3: address) {
        0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::assert_active_admin(arg0, arg1);
        assert_registry_version(arg2);
        if (!0x2::table::contains<address, bool>(&arg2.excluded, arg3)) {
            0x2::table::add<address, bool>(&mut arg2.excluded, arg3, true);
        };
        let v0 = ExclusionSet{
            addr     : arg3,
            excluded : true,
        };
        0x2::event::emit<ExclusionSet>(v0);
    }

    fun assert_not_excluded<T0, T1>(arg0: &RewardRegistry, arg1: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::QuoteCurve<T0, T1>, arg2: address, arg3: address) {
        assert!(arg3 != @0x0, 13898958278068994120);
        assert!(arg3 != arg2, 13898958282363961416);
        assert!(arg3 != 0x2::object::id_address<0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::QuoteCurve<T0, T1>>(arg1), 13898958286658928712);
        let v0 = 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::pool_id<T0, T1>(arg1);
        assert!(0x1::option::is_none<0x2::object::ID>(&v0) || arg3 != 0x2::object::id_to_address(0x1::option::borrow<0x2::object::ID>(&v0)), 13898958295248863304);
        assert!(arg3 != 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::creator<T0, T1>(arg1), 13898958299543830600);
        assert!(!0x2::table::contains<address, bool>(&arg0.excluded, arg3), 13898958303838797896);
    }

    fun assert_registry_version(arg0: &RewardRegistry) {
        assert!(arg0.version == 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::version::current(), 13853640703735824402);
    }

    fun assert_vault_curve<T0, T1>(arg0: &RewardVault<T0, T1>, arg1: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::QuoteCurve<T0, T1>) {
        assert!(0x2::object::id<0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::QuoteCurve<T0, T1>>(arg1) == arg0.curve_id, 13891639894311370772);
    }

    fun assert_vault_version<T0, T1>(arg0: &RewardVault<T0, T1>) {
        assert!(arg0.version == 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::version::current(), 13853640720915693586);
    }

    public fun asset_available<T0, T1, T2>(arg0: &RewardVault<T0, T1>) : u64 {
        available<T0, T1, T2>(arg0)
    }

    public fun asset_state<T0, T1, T2>(arg0: &RewardVault<T0, T1>) : (u64, u64, u64, u64, u64) {
        let v0 = AssetKey<T2>{dummy_field: false};
        if (!0x2::dynamic_field::exists<AssetKey<T2>>(&arg0.id, v0)) {
            return (0, 0, 0, 0, 0)
        };
        let v1 = 0x2::dynamic_field::borrow<AssetKey<T2>, AssetState<T2>>(&arg0.id, v0);
        (0x2::balance::value<T2>(&v1.balance), v1.committed, v1.total_in, v1.total_paid, v1.total_reimbursed)
    }

    public fun asset_string<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())
    }

    fun available<T0, T1, T2>(arg0: &RewardVault<T0, T1>) : u64 {
        let v0 = AssetKey<T2>{dummy_field: false};
        if (!0x2::dynamic_field::exists<AssetKey<T2>>(&arg0.id, v0)) {
            return 0
        };
        let v1 = 0x2::dynamic_field::borrow<AssetKey<T2>, AssetState<T2>>(&arg0.id, v0);
        0x2::balance::value<T2>(&v1.balance) - v1.committed
    }

    fun bit_is_set(arg0: &0x2::table::Table<u64, u256>, arg1: u64) : bool {
        let v0 = arg1 / 256;
        if (!0x2::table::contains<u64, u256>(arg0, v0)) {
            return false
        };
        *0x2::table::borrow<u64, u256>(arg0, v0) & 1 << ((arg1 % 256) as u8) != 0
    }

    public fun budget_info<T0, T1, T2>(arg0: &RewardVault<T0, T1>, arg1: u64) : (u64, u8) {
        let v0 = BudgetKey<T2>{period: arg1};
        if (!0x2::dynamic_field::exists<BudgetKey<T2>>(&arg0.id, v0)) {
            return (0, 255)
        };
        let v1 = 0x2::dynamic_field::borrow<BudgetKey<T2>, Budget>(&arg0.id, v0);
        (v1.amount, v1.state)
    }

    fun budget_state<T0, T1, T2>(arg0: &RewardVault<T0, T1>, arg1: u64) : u8 {
        let v0 = BudgetKey<T2>{period: arg1};
        if (!0x2::dynamic_field::exists<BudgetKey<T2>>(&arg0.id, v0)) {
            return 255
        };
        0x2::dynamic_field::borrow<BudgetKey<T2>, Budget>(&arg0.id, v0).state
    }

    public fun challenge_ms() : u64 {
        1800000
    }

    fun check_distributor(arg0: &RewardRegistry, arg1: &DistributorCap) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.distributor) && *0x1::option::borrow<0x2::object::ID>(&arg0.distributor) == 0x2::object::id<DistributorCap>(arg1), 13896424934557941814);
    }

    fun check_guardian(arg0: &RewardRegistry, arg1: &GuardianCap) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.guardian) && *0x1::option::borrow<0x2::object::ID>(&arg0.guardian) == 0x2::object::id<GuardianCap>(arg1), 13896424951737810998);
    }

    fun close_open_budget<T0, T1>(arg0: &mut RewardVault<T0, T1>, arg1: u64) : u64 {
        let v0 = 0x2::table::borrow_mut<u64, PeriodRecord>(&mut arg0.periods, arg1);
        v0.open_budgets = v0.open_budgets - 1;
        if (v0.open_budgets > 0) {
            return 0
        };
        let v1 = v0.gas_unassigned;
        v0.gas_unassigned = 0;
        release<T0, T1, T1>(arg0, v1);
        v1
    }

    public fun close_period<T0, T1>(arg0: &RewardRegistry, arg1: &mut RewardVault<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_registry_version(arg0);
        assert_vault_version<T0, T1>(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg1.period_start_ms + arg1.period_ms, 13892763045439668252);
        let v1 = mul_bps(available<T0, T1, T1>(arg1), 1000);
        freeze_and_advance<T0, T1>(arg1, v1, v0, *0x2::tx_context::digest(arg3), 0x2::tx_context::reference_gas_price(arg3));
    }

    public fun collect<T0, T1, T2>(arg0: &RewardRegistry, arg1: &mut RewardVault<T0, T1>, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T2>>) {
        assert_registry_version(arg0);
        assert_vault_version<T0, T1>(arg1);
        assert!(is_type<T2, T1>() || is_type<T2, T0>(), 13892481261225181210);
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T2>>(&mut arg1.id, arg2);
        credit<T0, T1, T2>(arg1, 0x2::coin::into_balance<T2>(v0));
        let v1 = Collected{
            vault_id : 0x2::object::id<RewardVault<T0, T1>>(arg1),
            asset    : 0x1::type_name::with_defining_ids<T2>(),
            coin_id  : 0x2::object::id<0x2::coin::Coin<T2>>(&v0),
            amount   : 0x2::coin::value<T2>(&v0),
        };
        0x2::event::emit<Collected>(v1);
    }

    public fun collect_reward<T0, T1, T2>(arg0: &DistributorCap, arg1: &RewardRegistry, arg2: &mut RewardVault<T0, T1>, arg3: 0x2::transfer::Receiving<0x2::coin::Coin<T2>>) {
        assert_registry_version(arg1);
        assert_vault_version<T0, T1>(arg2);
        check_distributor(arg1, arg0);
        assert!(!is_type<T2, 0x2::sui::SUI>(), 13900925605019713622);
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T2>>(&mut arg2.id, arg3);
        credit<T0, T1, T2>(arg2, 0x2::coin::into_balance<T2>(v0));
        let v1 = RewardCollected{
            vault_id : 0x2::object::id<RewardVault<T0, T1>>(arg2),
            asset    : 0x1::type_name::with_defining_ids<T2>(),
            coin_id  : 0x2::object::id<0x2::coin::Coin<T2>>(&v0),
            amount   : 0x2::coin::value<T2>(&v0),
        };
        0x2::event::emit<RewardCollected>(v1);
    }

    fun commit<T0, T1, T2>(arg0: &mut RewardVault<T0, T1>, arg1: u64) {
        if (arg1 == 0) {
            return
        };
        let v0 = AssetKey<T2>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<AssetKey<T2>, AssetState<T2>>(&mut arg0.id, v0);
        v1.committed = v1.committed + arg1;
    }

    public fun compute_root(arg0: vector<u8>, arg1: u64, arg2: &vector<vector<u8>>) : vector<u8> {
        let v0 = arg0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg2)) {
            let v2 = *0x1::vector::borrow<vector<u8>>(arg2, v1);
            assert!(0x1::vector::length<u8>(&v2) == 32, 13895861254459818034);
            let v3 = if (arg1 % 2 == 0) {
                node_hash(v0, v2)
            } else {
                node_hash(v2, v0)
            };
            v0 = v3;
            arg1 = arg1 / 2;
            v1 = v1 + 1;
        };
        v0
    }

    public fun create_vault<T0, T1>(arg0: &mut RewardRegistry, arg1: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::CreatorCap, arg2: &mut 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::QuoteCurve<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : address {
        assert_registry_version(arg0);
        0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::assert_active_creator<T0, T1>(arg1, arg2);
        assert!(is_valid_period_ms(arg3), 13892199507075465240);
        let v0 = 0x2::object::id<0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::QuoteCurve<T0, T1>>(arg2);
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.vaults, v0), 13891918040688558102);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = RewardVault<T0, T1>{
            id              : 0x2::object::new(arg5),
            version         : 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::version::current(),
            curve_id        : v0,
            period_ms       : arg3,
            next_period_ms  : arg3,
            period          : 0,
            period_start_ms : v1,
            periods         : 0x2::table::new<u64, PeriodRecord>(arg5),
        };
        let v3 = 0x2::object::id<RewardVault<T0, T1>>(&v2);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.vaults, v0, v3);
        let v4 = VaultCreated{
            vault_id   : v3,
            curve_id   : v0,
            token_type : 0x1::type_name::with_defining_ids<T0>(),
            pay_asset  : 0x1::type_name::with_defining_ids<T1>(),
            period_ms  : arg3,
            start_ms   : v1,
        };
        0x2::event::emit<VaultCreated>(v4);
        let v5 = 0x2::object::id_to_address(&v3);
        0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::bind_rewards_vault<T0, T1>(arg1, arg2, v5, arg4);
        0x2::transfer::share_object<RewardVault<T0, T1>>(v2);
        v5
    }

    fun credit<T0, T1, T2>(arg0: &mut RewardVault<T0, T1>, arg1: 0x2::balance::Balance<T2>) {
        let v0 = AssetKey<T2>{dummy_field: false};
        if (!0x2::dynamic_field::exists<AssetKey<T2>>(&arg0.id, v0)) {
            let v1 = AssetState<T2>{
                balance          : 0x2::balance::zero<T2>(),
                committed        : 0,
                total_in         : 0,
                total_paid       : 0,
                total_reimbursed : 0,
            };
            0x2::dynamic_field::add<AssetKey<T2>, AssetState<T2>>(&mut arg0.id, v0, v1);
        };
        let v2 = 0x2::dynamic_field::borrow_mut<AssetKey<T2>, AssetState<T2>>(&mut arg0.id, v0);
        v2.total_in = v2.total_in + 0x2::balance::value<T2>(&arg1);
        0x2::balance::join<T2>(&mut v2.balance, arg1);
    }

    public fun deposit_as_creator<T0, T1, T2>(arg0: &RewardRegistry, arg1: &mut RewardVault<T0, T1>, arg2: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::QuoteCurve<T0, T1>, arg3: 0x2::coin::Coin<T2>, arg4: &0x2::tx_context::TxContext) {
        assert_registry_version(arg0);
        assert_vault_version<T0, T1>(arg1);
        assert_vault_curve<T0, T1>(arg1, arg2);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::creator<T0, T1>(arg2), 13900644228827119700);
        assert!(!is_type<T2, 0x2::sui::SUI>(), 13900925708098928726);
        let v1 = 0x2::coin::value<T2>(&arg3);
        assert!(v1 > 0, 13837030896970956816);
        credit<T0, T1, T2>(arg1, 0x2::coin::into_balance<T2>(arg3));
        let v2 = CreatorDeposited{
            vault_id : 0x2::object::id<RewardVault<T0, T1>>(arg1),
            curve_id : 0x2::object::id<0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::QuoteCurve<T0, T1>>(arg2),
            creator  : v0,
            asset    : 0x1::type_name::with_defining_ids<T2>(),
            amount   : v1,
        };
        0x2::event::emit<CreatorDeposited>(v2);
    }

    public fun distributor(arg0: &RewardRegistry) : 0x1::option::Option<0x2::object::ID> {
        arg0.distributor
    }

    public fun distributor_holder(arg0: &RewardRegistry) : 0x1::option::Option<address> {
        arg0.distributor_holder
    }

    public fun expire_root<T0, T1, T2>(arg0: &RewardRegistry, arg1: &mut RewardVault<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_registry_version(arg0);
        assert_vault_version<T0, T1>(arg1);
        assert!(budget_state<T0, T1, T2>(arg1, arg2) == 1, 13894734585753305130);
        let v0 = RootKey<T2>{period: arg2};
        let v1 = 0x2::dynamic_field::borrow<RootKey<T2>, Root>(&arg1.id, v0);
        assert!(0x2::clock::timestamp_ms(arg3) >= v1.deadline_ms, 13895297548591890478);
        let v2 = v1.total - v1.paid_amount;
        let v3 = (v1.count - v1.paid_count) * v1.rate;
        set_budget_state<T0, T1, T2>(arg1, arg2, 3);
        release<T0, T1, T2>(arg1, v2);
        release<T0, T1, T1>(arg1, v3);
        let v4 = RootExpired{
            vault_id     : 0x2::object::id<RewardVault<T0, T1>>(arg1),
            period       : arg2,
            asset        : 0x1::type_name::with_defining_ids<T2>(),
            released     : v2,
            gas_released : v3,
        };
        0x2::event::emit<RootExpired>(v4);
    }

    fun freeze_and_advance<T0, T1>(arg0: &mut RewardVault<T0, T1>, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: u64) {
        let v0 = available<T0, T1, T1>(arg0) - arg1;
        let v1 = available<T0, T1, T0>(arg0);
        commit<T0, T1, T1>(arg0, arg1);
        let v2 = arg0.period;
        let v3 = arg0.period_start_ms;
        let v4 = arg2 + arg0.next_period_ms;
        let v5 = PeriodRecord{
            start_ms         : v3,
            end_ms           : arg2,
            post_deadline_ms : v4,
            gas_budget       : arg1,
            gas_unassigned   : arg1,
            open_budgets     : 0,
            close_digest     : arg3,
            ref_gas_price    : arg4,
        };
        0x2::table::add<u64, PeriodRecord>(&mut arg0.periods, v2, v5);
        arg0.period = v2 + 1;
        arg0.period_start_ms = arg2;
        arg0.period_ms = arg0.next_period_ms;
        let v6 = PeriodClosed{
            vault_id         : 0x2::object::id<RewardVault<T0, T1>>(arg0),
            period           : v2,
            start_ms         : v3,
            end_ms           : arg2,
            gas_budget       : arg1,
            next_period_ms   : arg0.period_ms,
            post_deadline_ms : v4,
            ref_gas_price    : arg4,
        };
        0x2::event::emit<PeriodClosed>(v6);
        if (v0 > 0) {
            record_budget<T0, T1, T1>(arg0, v2, v0);
        };
        if (v1 > 0) {
            record_budget<T0, T1, T0>(arg0, v2, v1);
        };
    }

    public fun freeze_asset<T0, T1, T2>(arg0: &RewardRegistry, arg1: &mut RewardVault<T0, T1>, arg2: &0x2::tx_context::TxContext) : u64 {
        assert_registry_version(arg0);
        assert_vault_version<T0, T1>(arg1);
        assert!(!is_type<T2, T1>() && !is_type<T2, T0>(), 13892481647772237850);
        assert!(!is_type<T2, 0x2::sui::SUI>(), 13900925901372457046);
        assert!(arg1.period > 0, 13900081480736899152);
        let v0 = arg1.period - 1;
        assert!(0x2::table::borrow<u64, PeriodRecord>(&arg1.periods, v0).close_digest == *0x2::tx_context::digest(arg2), 13900081489326833744);
        let v1 = BudgetKey<T2>{period: v0};
        if (0x2::dynamic_field::exists<BudgetKey<T2>>(&arg1.id, v1)) {
            return 0
        };
        let v2 = available<T0, T1, T2>(arg1);
        if (v2 == 0) {
            return 0
        };
        record_budget<T0, T1, T2>(arg1, v0, v2);
        v2
    }

    public fun gas_reserve_bps() : u64 {
        1000
    }

    public fun guardian(arg0: &RewardRegistry) : 0x1::option::Option<0x2::object::ID> {
        arg0.guardian
    }

    public fun guardian_holder(arg0: &RewardRegistry) : 0x1::option::Option<address> {
        arg0.guardian_holder
    }

    public fun has_root<T0, T1, T2>(arg0: &RewardVault<T0, T1>, arg1: u64) : bool {
        let v0 = RootKey<T2>{period: arg1};
        0x2::dynamic_field::exists<RootKey<T2>>(&arg0.id, v0)
    }

    public fun hour_ms() : u64 {
        3600000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardRegistry{
            id                 : 0x2::object::new(arg0),
            version            : 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::version::current(),
            distributor        : 0x1::option::none<0x2::object::ID>(),
            distributor_holder : 0x1::option::none<address>(),
            guardian           : 0x1::option::none<0x2::object::ID>(),
            guardian_holder    : 0x1::option::none<address>(),
            vaults             : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg0),
            excluded           : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<RewardRegistry>(v0);
    }

    public fun is_excluded(arg0: &RewardRegistry, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.excluded, arg1)
    }

    public fun is_leaf_paid<T0, T1, T2>(arg0: &RewardVault<T0, T1>, arg1: u64, arg2: u64) : bool {
        let v0 = RootKey<T2>{period: arg1};
        if (!0x2::dynamic_field::exists<RootKey<T2>>(&arg0.id, v0)) {
            return false
        };
        bit_is_set(&0x2::dynamic_field::borrow<RootKey<T2>, Root>(&arg0.id, v0).paid_bits, arg2)
    }

    fun is_type<T0, T1>() : bool {
        0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<T1>()
    }

    fun is_valid_period_ms(arg0: u64) : bool {
        if (arg0 > 0) {
            if (arg0 % 3600000 == 0) {
                arg0 / 3600000 <= 168
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun leaf_hash(arg0: address, arg1: u64, arg2: 0x1::ascii::String, arg3: u64, arg4: address, arg5: u64) : vector<u8> {
        let v0 = LeafData{
            vault_id  : arg0,
            period    : arg1,
            asset     : arg2,
            leaf_idx  : arg3,
            recipient : arg4,
            amount    : arg5,
        };
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v1, 0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<LeafData>(&v0));
        0x2::hash::blake2b256(&v1)
    }

    public fun max_leaf_bps() : u64 {
        1000
    }

    public fun max_leaves() : u64 {
        1048576
    }

    public fun max_period_hours() : u64 {
        168
    }

    public fun merkle_depth(arg0: u64) : u64 {
        let v0 = 0;
        let v1 = 1;
        while (v1 < arg0) {
            v1 = v1 * 2;
            v0 = v0 + 1;
        };
        v0
    }

    public fun migrate_reward_registry(arg0: &mut RewardRegistry) {
        assert!(arg0.version < 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::version::current(), 13853639780317855762);
        arg0.version = 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::version::current();
        let v0 = RegistryMigrated{
            registry_id  : 0x2::object::id<RewardRegistry>(arg0),
            from_version : arg0.version,
            to_version   : 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::version::current(),
        };
        0x2::event::emit<RegistryMigrated>(v0);
    }

    public fun migrate_reward_vault<T0, T1>(arg0: &mut RewardVault<T0, T1>) {
        assert!(arg0.version < 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::version::current(), 13853639818972561426);
        arg0.version = 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::version::current();
        let v0 = VaultMigrated{
            vault_id     : 0x2::object::id<RewardVault<T0, T1>>(arg0),
            from_version : arg0.version,
            to_version   : 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::version::current(),
        };
        0x2::event::emit<VaultMigrated>(v0);
    }

    fun mul_bps(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public fun node_hash(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 1);
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        0x2::hash::blake2b256(&v0)
    }

    public fun period_info<T0, T1>(arg0: &RewardVault<T0, T1>, arg1: u64) : (u64, u64, u64, u64, u64) {
        let v0 = 0x2::table::borrow<u64, PeriodRecord>(&arg0.periods, arg1);
        (v0.start_ms, v0.end_ms, v0.gas_budget, v0.gas_unassigned, v0.open_budgets)
    }

    public fun period_ref_gas_price<T0, T1>(arg0: &RewardVault<T0, T1>, arg1: u64) : u64 {
        0x2::table::borrow<u64, PeriodRecord>(&arg0.periods, arg1).ref_gas_price
    }

    public fun post_deadline_ms<T0, T1>(arg0: &RewardVault<T0, T1>, arg1: u64) : u64 {
        0x2::table::borrow<u64, PeriodRecord>(&arg0.periods, arg1).post_deadline_ms
    }

    public fun post_root<T0, T1, T2>(arg0: &DistributorCap, arg1: &RewardRegistry, arg2: &mut RewardVault<T0, T1>, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert_registry_version(arg1);
        assert_vault_version<T0, T1>(arg2);
        check_distributor(arg1, arg0);
        assert!(0x2::table::contains<u64, PeriodRecord>(&arg2.periods, arg3), 13893045078762258462);
        let v0 = BudgetKey<T2>{period: arg3};
        assert!(0x2::dynamic_field::exists<BudgetKey<T2>>(&arg2.id, v0), 13899800486796394574);
        let v1 = 0x2::clock::timestamp_ms(arg10);
        let v2 = 0x2::table::borrow<u64, PeriodRecord>(&arg2.periods, arg3);
        let v3 = 0x2::dynamic_field::borrow<BudgetKey<T2>, Budget>(&arg2.id, v0);
        assert!(v3.state == 0, 13893326583803871264);
        assert!(v1 <= v2.post_deadline_ms, 13897548712751464510);
        assert!(arg9 == 4, 13897267242069590076);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 13893608071665614882);
        assert!(arg6 >= 1 && arg6 <= 1048576, 13893889550937423908);
        assert!(arg5 > 0, 13896985779977650234);
        assert!(arg5 <= v3.amount, 13894171034504200230);
        assert!((arg6 as u128) * (arg7 as u128) <= (v2.gas_unassigned as u128), 13894452513776009256);
        let v4 = v3.amount;
        set_budget_state<T0, T1, T2>(arg2, arg3, 1);
        let v5 = 0x2::table::borrow_mut<u64, PeriodRecord>(&mut arg2.periods, arg3);
        v5.gas_unassigned = v5.gas_unassigned - arg6 * arg7;
        let v6 = v4 - arg5;
        release<T0, T1, T2>(arg2, v6);
        let v7 = close_open_budget<T0, T1>(arg2, arg3);
        let v8 = v1 + 1800000;
        let v9 = v8 + 604800000;
        let v10 = RootKey<T2>{period: arg3};
        let v11 = Root{
            merkle_root         : arg4,
            total               : arg5,
            count               : arg6,
            rate                : arg7,
            snapshot_checkpoint : arg8,
            rule_version        : arg9,
            posted_ms           : v1,
            payable_ms          : v8,
            deadline_ms         : v9,
            paid_amount         : 0,
            paid_count          : 0,
            paid_bits           : 0x2::table::new<u64, u256>(arg11),
        };
        0x2::dynamic_field::add<RootKey<T2>, Root>(&mut arg2.id, v10, v11);
        let v12 = RootPosted{
            vault_id            : 0x2::object::id<RewardVault<T0, T1>>(arg2),
            period              : arg3,
            asset               : 0x1::type_name::with_defining_ids<T2>(),
            merkle_root         : arg4,
            total               : arg5,
            count               : arg6,
            rate                : arg7,
            snapshot_checkpoint : arg8,
            rule_version        : arg9,
            posted_ms           : v1,
            payable_ms          : v8,
            deadline_ms         : v9,
            released            : v6,
            gas_released        : v7,
        };
        0x2::event::emit<RootPosted>(v12);
    }

    public fun push<T0, T1, T2>(arg0: &RewardRegistry, arg1: &mut RewardVault<T0, T1>, arg2: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::QuoteCurve<T0, T1>, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: vector<vector<u8>>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_registry_version(arg0);
        assert_vault_version<T0, T1>(arg1);
        assert_vault_curve<T0, T1>(arg1, arg2);
        assert!(budget_state<T0, T1, T2>(arg1, arg3) == 1, 13894734336645201962);
        let v0 = 0x2::object::id_address<RewardVault<T0, T1>>(arg1);
        assert_not_excluded<T0, T1>(arg0, arg2, v0, arg5);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        let v2 = RootKey<T2>{period: arg3};
        let v3 = 0x2::dynamic_field::borrow<RootKey<T2>, Root>(&arg1.id, v2);
        assert!(v1 >= v3.payable_ms, 13898112062137106498);
        assert!(v1 < v3.deadline_ms, 13895015841686814764);
        assert!(arg4 < v3.count, 13895578795935465520);
        assert!(arg6 > 0, 13837032005072519184);
        assert!((arg6 as u128) * (10000 as u128) <= (v3.total as u128) * (1000 as u128), 13898675029270659142);
        assert!(0x1::vector::length<vector<u8>>(&arg7) == merkle_depth(v3.count), 13896704708727734328);
        assert!(compute_root(leaf_hash(v0, arg3, asset_string<T2>(), arg4, arg5, arg6), arg4, &arg7) == v3.merkle_root, 13895860292387143730);
        let v4 = bit_is_set(&v3.paid_bits, arg4);
        if (!v4) {
            assert!(arg6 <= v3.total - v3.paid_amount, 13896141775953920052);
        };
        let v5 = v3.rate;
        if (v4) {
            return 0x2::coin::zero<T1>(arg9)
        };
        let v6 = RootKey<T2>{period: arg3};
        let v7 = 0x2::dynamic_field::borrow_mut<RootKey<T2>, Root>(&mut arg1.id, v6);
        let v8 = &mut v7.paid_bits;
        set_bit(v8, arg4);
        v7.paid_amount = v7.paid_amount + arg6;
        v7.paid_count = v7.paid_count + 1;
        let v9 = AssetKey<T2>{dummy_field: false};
        let v10 = 0x2::dynamic_field::borrow_mut<AssetKey<T2>, AssetState<T2>>(&mut arg1.id, v9);
        v10.committed = v10.committed - arg6;
        v10.total_paid = v10.total_paid + arg6;
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut v10.balance, arg6), arg9), arg5);
        let v11 = if (v5 > 0) {
            let v12 = AssetKey<T1>{dummy_field: false};
            let v13 = 0x2::dynamic_field::borrow_mut<AssetKey<T1>, AssetState<T1>>(&mut arg1.id, v12);
            v13.committed = v13.committed - v5;
            v13.total_reimbursed = v13.total_reimbursed + v5;
            0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v13.balance, v5), arg9)
        } else {
            0x2::coin::zero<T1>(arg9)
        };
        let v14 = Pushed{
            vault_id      : 0x2::object::id<RewardVault<T0, T1>>(arg1),
            period        : arg3,
            asset         : 0x1::type_name::with_defining_ids<T2>(),
            leaf_idx      : arg4,
            recipient     : arg5,
            amount        : arg6,
            pusher        : 0x2::tx_context::sender(arg9),
            reimbursement : v5,
        };
        0x2::event::emit<Pushed>(v14);
        v11
    }

    public fun push_window_ms() : u64 {
        604800000
    }

    fun record_budget<T0, T1, T2>(arg0: &mut RewardVault<T0, T1>, arg1: u64, arg2: u64) {
        commit<T0, T1, T2>(arg0, arg2);
        let v0 = BudgetKey<T2>{period: arg1};
        let v1 = Budget{
            amount : arg2,
            state  : 0,
        };
        0x2::dynamic_field::add<BudgetKey<T2>, Budget>(&mut arg0.id, v0, v1);
        let v2 = 0x2::table::borrow_mut<u64, PeriodRecord>(&mut arg0.periods, arg1);
        v2.open_budgets = v2.open_budgets + 1;
        let v3 = BudgetFrozen{
            vault_id : 0x2::object::id<RewardVault<T0, T1>>(arg0),
            period   : arg1,
            asset    : 0x1::type_name::with_defining_ids<T2>(),
            amount   : arg2,
        };
        0x2::event::emit<BudgetFrozen>(v3);
    }

    public fun registry_version(arg0: &RewardRegistry) : u64 {
        arg0.version
    }

    fun release<T0, T1, T2>(arg0: &mut RewardVault<T0, T1>, arg1: u64) {
        if (arg1 == 0) {
            return
        };
        let v0 = AssetKey<T2>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<AssetKey<T2>, AssetState<T2>>(&mut arg0.id, v0);
        v1.committed = v1.committed - arg1;
    }

    public fun release_unassigned_gas<T0, T1>(arg0: &RewardRegistry, arg1: &mut RewardVault<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_registry_version(arg0);
        assert_vault_version<T0, T1>(arg1);
        assert!(0x2::table::contains<u64, PeriodRecord>(&arg1.periods, arg2), 13893044898373632030);
        let v0 = 0x2::table::borrow<u64, PeriodRecord>(&arg1.periods, arg2);
        assert!((v0.open_budgets == 0 || 0x2::clock::timestamp_ms(arg3) > v0.post_deadline_ms) && v0.close_digest != *0x2::tx_context::digest(arg4), 13900363269246353490);
        let v1 = 0x2::table::borrow_mut<u64, PeriodRecord>(&mut arg1.periods, arg2);
        let v2 = v1.gas_unassigned;
        v1.gas_unassigned = 0;
        if (v2 == 0) {
            return
        };
        release<T0, T1, T1>(arg1, v2);
        let v3 = GasReleased{
            vault_id     : 0x2::object::id<RewardVault<T0, T1>>(arg1),
            period       : arg2,
            gas_released : v2,
        };
        0x2::event::emit<GasReleased>(v3);
    }

    public fun release_unposted<T0, T1, T2>(arg0: &RewardRegistry, arg1: &mut RewardVault<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_registry_version(arg0);
        assert_vault_version<T0, T1>(arg1);
        assert!(0x2::table::contains<u64, PeriodRecord>(&arg1.periods, arg2), 13893045834676502558);
        let v0 = BudgetKey<T2>{period: arg2};
        assert!(0x2::dynamic_field::exists<BudgetKey<T2>>(&arg1.id, v0), 13899801242710638670);
        let v1 = 0x2::dynamic_field::borrow<BudgetKey<T2>, Budget>(&arg1.id, v0);
        assert!(v1.state == 0, 13899519784913666124);
        assert!(0x2::clock::timestamp_ms(arg3) > 0x2::table::borrow<u64, PeriodRecord>(&arg1.periods, arg2).post_deadline_ms, 13897830939347583040);
        let v2 = v1.amount;
        set_budget_state<T0, T1, T2>(arg1, arg2, 4);
        release<T0, T1, T2>(arg1, v2);
        let v3 = close_open_budget<T0, T1>(arg1, arg2);
        let v4 = PeriodLapsed{
            vault_id     : 0x2::object::id<RewardVault<T0, T1>>(arg1),
            period       : arg2,
            asset        : 0x1::type_name::with_defining_ids<T2>(),
            released     : v2,
            gas_released : v3,
        };
        0x2::event::emit<PeriodLapsed>(v4);
    }

    public fun remove_exclusion(arg0: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::AdminCap, arg1: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::AdminRegistry, arg2: &mut RewardRegistry, arg3: address) {
        0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::assert_active_admin(arg0, arg1);
        assert_registry_version(arg2);
        if (0x2::table::contains<address, bool>(&arg2.excluded, arg3)) {
            0x2::table::remove<address, bool>(&mut arg2.excluded, arg3);
        };
        let v0 = ExclusionSet{
            addr     : arg3,
            excluded : false,
        };
        0x2::event::emit<ExclusionSet>(v0);
    }

    public fun revoke_distributor(arg0: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::AdminCap, arg1: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::AdminRegistry, arg2: &mut RewardRegistry) {
        0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::assert_active_admin(arg0, arg1);
        assert_registry_version(arg2);
        arg2.distributor = 0x1::option::none<0x2::object::ID>();
        arg2.distributor_holder = 0x1::option::none<address>();
        let v0 = DistributorSet{
            cap_id : 0x1::option::none<0x2::object::ID>(),
            holder : 0x1::option::none<address>(),
        };
        0x2::event::emit<DistributorSet>(v0);
    }

    public fun revoke_guardian(arg0: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::AdminCap, arg1: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::AdminRegistry, arg2: &mut RewardRegistry) {
        0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::assert_active_admin(arg0, arg1);
        assert_registry_version(arg2);
        arg2.guardian = 0x1::option::none<0x2::object::ID>();
        arg2.guardian_holder = 0x1::option::none<address>();
        let v0 = GuardianSet{
            cap_id : 0x1::option::none<0x2::object::ID>(),
            holder : 0x1::option::none<address>(),
        };
        0x2::event::emit<GuardianSet>(v0);
    }

    public fun root_info<T0, T1, T2>(arg0: &RewardVault<T0, T1>, arg1: u64) : (vector<u8>, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64) {
        let v0 = RootKey<T2>{period: arg1};
        let v1 = 0x2::dynamic_field::borrow<RootKey<T2>, Root>(&arg0.id, v0);
        (v1.merkle_root, v1.total, v1.count, v1.rate, v1.snapshot_checkpoint, v1.rule_version, v1.posted_ms, v1.payable_ms, v1.deadline_ms, v1.paid_amount, v1.paid_count)
    }

    fun set_bit(arg0: &mut 0x2::table::Table<u64, u256>, arg1: u64) {
        let v0 = arg1 / 256;
        if (!0x2::table::contains<u64, u256>(arg0, v0)) {
            0x2::table::add<u64, u256>(arg0, v0, 1 << ((arg1 % 256) as u8));
        } else {
            let v1 = 0x2::table::borrow_mut<u64, u256>(arg0, v0);
            *v1 = *v1 | 1 << ((arg1 % 256) as u8);
        };
    }

    fun set_budget_state<T0, T1, T2>(arg0: &mut RewardVault<T0, T1>, arg1: u64, arg2: u8) {
        let v0 = BudgetKey<T2>{period: arg1};
        0x2::dynamic_field::borrow_mut<BudgetKey<T2>, Budget>(&mut arg0.id, v0).state = arg2;
    }

    public fun set_distributor(arg0: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::AdminCap, arg1: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::AdminRegistry, arg2: &mut RewardRegistry, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::assert_active_admin(arg0, arg1);
        assert_registry_version(arg2);
        assert!(arg3 != 0x2::tx_context::sender(arg4), 13899238413016039498);
        assert!(arg2.guardian_holder != 0x1::option::some<address>(arg3), 13899238417311006794);
        let v0 = DistributorCap{id: 0x2::object::new(arg4)};
        let v1 = 0x2::object::id<DistributorCap>(&v0);
        arg2.distributor = 0x1::option::some<0x2::object::ID>(v1);
        arg2.distributor_holder = 0x1::option::some<address>(arg3);
        0x2::transfer::transfer<DistributorCap>(v0, arg3);
        let v2 = DistributorSet{
            cap_id : 0x1::option::some<0x2::object::ID>(v1),
            holder : 0x1::option::some<address>(arg3),
        };
        0x2::event::emit<DistributorSet>(v2);
    }

    public fun set_frequency<T0, T1>(arg0: &RewardRegistry, arg1: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::CreatorCap, arg2: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::QuoteCurve<T0, T1>, arg3: &mut RewardVault<T0, T1>, arg4: u64) {
        assert_registry_version(arg0);
        assert_vault_version<T0, T1>(arg3);
        assert_vault_curve<T0, T1>(arg3, arg2);
        0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::assert_active_creator<T0, T1>(arg1, arg2);
        assert!(is_valid_period_ms(arg4), 13892199696054026264);
        arg3.next_period_ms = arg4;
        let v0 = PeriodMsSet{
            vault_id       : 0x2::object::id<RewardVault<T0, T1>>(arg3),
            next_period_ms : arg4,
            current_period : arg3.period,
        };
        0x2::event::emit<PeriodMsSet>(v0);
    }

    public fun set_guardian(arg0: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::AdminCap, arg1: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::AdminRegistry, arg2: &mut RewardRegistry, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority::assert_active_admin(arg0, arg1);
        assert_registry_version(arg2);
        assert!(arg3 != 0x2::tx_context::sender(arg4), 13899238554749960266);
        assert!(arg2.distributor_holder != 0x1::option::some<address>(arg3), 13899238559044927562);
        let v0 = GuardianCap{id: 0x2::object::new(arg4)};
        let v1 = 0x2::object::id<GuardianCap>(&v0);
        arg2.guardian = 0x1::option::some<0x2::object::ID>(v1);
        arg2.guardian_holder = 0x1::option::some<address>(arg3);
        0x2::transfer::transfer<GuardianCap>(v0, arg3);
        let v2 = GuardianSet{
            cap_id : 0x1::option::some<0x2::object::ID>(v1),
            holder : 0x1::option::some<address>(arg3),
        };
        0x2::event::emit<GuardianSet>(v2);
    }

    public fun snapshot_rule_version() : u64 {
        4
    }

    public fun state_closed() : u8 {
        0
    }

    public fun state_expired() : u8 {
        3
    }

    public fun state_lapsed() : u8 {
        4
    }

    public fun state_none() : u8 {
        255
    }

    public fun state_posted() : u8 {
        1
    }

    public fun state_vetoed() : u8 {
        2
    }

    public fun vault_curve_id<T0, T1>(arg0: &RewardVault<T0, T1>) : 0x2::object::ID {
        arg0.curve_id
    }

    public fun vault_next_period_ms<T0, T1>(arg0: &RewardVault<T0, T1>) : u64 {
        arg0.next_period_ms
    }

    public fun vault_of(arg0: &RewardRegistry, arg1: 0x2::object::ID) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.vaults, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.vaults, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun vault_period<T0, T1>(arg0: &RewardVault<T0, T1>) : u64 {
        arg0.period
    }

    public fun vault_period_ms<T0, T1>(arg0: &RewardVault<T0, T1>) : u64 {
        arg0.period_ms
    }

    public fun vault_period_start_ms<T0, T1>(arg0: &RewardVault<T0, T1>) : u64 {
        arg0.period_start_ms
    }

    public fun vault_version<T0, T1>(arg0: &RewardVault<T0, T1>) : u64 {
        arg0.version
    }

    public fun veto_as_creator<T0, T1, T2>(arg0: &RewardRegistry, arg1: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::CreatorCap, arg2: &0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::QuoteCurve<T0, T1>, arg3: &mut RewardVault<T0, T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_registry_version(arg0);
        assert_vault_version<T0, T1>(arg3);
        assert_vault_curve<T0, T1>(arg3, arg2);
        0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::curve::assert_active_creator<T0, T1>(arg1, arg2);
        veto_internal<T0, T1, T2>(arg3, arg4, arg5, 0, 0x2::tx_context::sender(arg6));
    }

    public fun veto_as_guardian<T0, T1, T2>(arg0: &RewardRegistry, arg1: &GuardianCap, arg2: &mut RewardVault<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_registry_version(arg0);
        assert_vault_version<T0, T1>(arg2);
        check_guardian(arg0, arg1);
        veto_internal<T0, T1, T2>(arg2, arg3, arg4, 1, 0x2::tx_context::sender(arg5));
    }

    fun veto_internal<T0, T1, T2>(arg0: &mut RewardVault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: u8, arg4: address) {
        assert!(budget_state<T0, T1, T2>(arg0, arg1) == 1, 13894735766869311530);
        let v0 = RootKey<T2>{period: arg1};
        assert!(0x2::clock::timestamp_ms(arg2) < 0x2::dynamic_field::borrow<RootKey<T2>, Root>(&arg0.id, v0).payable_ms, 13898394958748123204);
        let v1 = RootKey<T2>{period: arg1};
        let Root {
            merkle_root         : _,
            total               : v3,
            count               : v4,
            rate                : v5,
            snapshot_checkpoint : _,
            rule_version        : _,
            posted_ms           : _,
            payable_ms          : _,
            deadline_ms         : _,
            paid_amount         : v11,
            paid_count          : v12,
            paid_bits           : v13,
        } = 0x2::dynamic_field::remove<RootKey<T2>, Root>(&mut arg0.id, v1);
        0x2::table::destroy_empty<u64, u256>(v13);
        let v14 = v3 - v11;
        let v15 = (v4 - v12) * v5;
        set_budget_state<T0, T1, T2>(arg0, arg1, 2);
        release<T0, T1, T2>(arg0, v14);
        release<T0, T1, T1>(arg0, v15);
        let v16 = RootVetoed{
            vault_id     : 0x2::object::id<RewardVault<T0, T1>>(arg0),
            period       : arg1,
            asset        : 0x1::type_name::with_defining_ids<T2>(),
            by           : arg3,
            vetoer       : arg4,
            released     : v14,
            gas_released : v15,
        };
        0x2::event::emit<RootVetoed>(v16);
    }

    // decompiled from Move bytecode v7
}

