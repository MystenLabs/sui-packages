module 0x33143a0dbf61ecc464d91e401748b7cb1172215265c1734c17c26650979dab86::rewards_core {
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

    struct RewardsAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DistributorCap has key {
        id: 0x2::object::UID,
    }

    struct GuardianCap has key {
        id: 0x2::object::UID,
    }

    struct RewardVault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
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
        total_converted_out: u64,
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

    struct BudgetConverted has copy, drop {
        vault_id: 0x2::object::ID,
        period: u64,
        converted: bool,
        sui_offered: u64,
        sui_in: u64,
        quote_out: u64,
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

    struct Migrated has copy, drop {
        from_version: u64,
        to_version: u64,
    }

    struct VaultWitness has drop {
        dummy_field: bool,
    }

    public fun add_exclusion(arg0: &RewardsAdminCap, arg1: &mut RewardRegistry, arg2: address) {
        check_version(arg1);
        if (!0x2::table::contains<address, bool>(&arg1.excluded, arg2)) {
            0x2::table::add<address, bool>(&mut arg1.excluded, arg2, true);
        };
        let v0 = ExclusionSet{
            addr     : arg2,
            excluded : true,
        };
        0x2::event::emit<ExclusionSet>(v0);
    }

    fun assert_active_creator<T0>(arg0: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::CreatorCap, arg1: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::Curve<T0>) {
        assert!(0x2::object::id<0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::CreatorCap>(arg0) == 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::active_creator_cap_id<T0>(arg1), 1);
    }

    fun assert_not_excluded<T0>(arg0: &RewardRegistry, arg1: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::Curve<T0>, arg2: address, arg3: address) {
        assert!(arg3 != @0x0, 33);
        assert!(arg3 != arg2, 33);
        assert!(arg3 != 0x2::object::id_address<0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::Curve<T0>>(arg1), 33);
        let v0 = 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::pool_id<T0>(arg1);
        assert!(0x1::option::is_none<0x2::object::ID>(&v0) || arg3 != 0x2::object::id_to_address(0x1::option::borrow<0x2::object::ID>(&v0)), 33);
        assert!(arg3 != 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::creator<T0>(arg1), 33);
        assert!(!0x2::table::contains<address, bool>(&arg0.excluded, arg3), 33);
    }

    fun assert_vault_curve<T0, T1>(arg0: &RewardVault<T0, T1>, arg1: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::Curve<T0>) {
        assert!(0x2::object::id<0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::Curve<T0>>(arg1) == arg0.curve_id, 2);
    }

    public fun asset_available<T0, T1, T2>(arg0: &RewardVault<T0, T1>) : u64 {
        available<T0, T1, T2>(arg0)
    }

    public fun asset_converted_out<T0, T1, T2>(arg0: &RewardVault<T0, T1>) : u64 {
        let v0 = AssetKey<T2>{dummy_field: false};
        if (!0x2::dynamic_field::exists<AssetKey<T2>>(&arg0.id, v0)) {
            return 0
        };
        0x2::dynamic_field::borrow<AssetKey<T2>, AssetState<T2>>(&arg0.id, v0).total_converted_out
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

    fun begin_converting_close<T0, T1>(arg0: &RewardRegistry, arg1: &mut RewardVault<T0, T1>, arg2: &0x2::clock::Clock) : (u64, u64, 0x2::balance::Balance<0x2::sui::SUI>) {
        check_version(arg0);
        assert!(!is_type<T1, 0x2::sui::SUI>(), 37);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg1.period_start_ms + arg1.period_ms, 7);
        let v1 = available<T0, T1, 0x2::sui::SUI>(arg1);
        let v2 = mul_bps(v1, 1000);
        let v3 = v1 - v2;
        let v4 = if (v3 == 0) {
            0x2::balance::zero<0x2::sui::SUI>()
        } else {
            let v5 = AssetKey<0x2::sui::SUI>{dummy_field: false};
            0x2::balance::split<0x2::sui::SUI>(&mut 0x2::dynamic_field::borrow_mut<AssetKey<0x2::sui::SUI>, AssetState<0x2::sui::SUI>>(&mut arg1.id, v5).balance, v3)
        };
        (v0, v2, v4)
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
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.distributor) && *0x1::option::borrow<0x2::object::ID>(&arg0.distributor) == 0x2::object::id<DistributorCap>(arg1), 22);
    }

    fun check_guardian(arg0: &RewardRegistry, arg1: &GuardianCap) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.guardian) && *0x1::option::borrow<0x2::object::ID>(&arg0.guardian) == 0x2::object::id<GuardianCap>(arg1), 22);
    }

    fun check_version(arg0: &RewardRegistry) {
        assert!(arg0.version == 1, 23);
    }

    fun close_open_budget<T0, T1>(arg0: &mut RewardVault<T0, T1>, arg1: u64) : u64 {
        let v0 = 0x2::table::borrow_mut<u64, PeriodRecord>(&mut arg0.periods, arg1);
        v0.open_budgets = v0.open_budgets - 1;
        if (v0.open_budgets > 0) {
            return 0
        };
        let v1 = v0.gas_unassigned;
        v0.gas_unassigned = 0;
        release<T0, T1, 0x2::sui::SUI>(arg0, v1);
        v1
    }

    public fun close_period<T0, T1>(arg0: &RewardRegistry, arg1: &mut RewardVault<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg1.period_start_ms + arg1.period_ms, 7);
        if (!is_type<T1, 0x2::sui::SUI>()) {
            assert!(v0 >= arg1.period_start_ms + arg1.period_ms + 3600000, 36);
        };
        let v1 = mul_bps(available<T0, T1, 0x2::sui::SUI>(arg1), 1000);
        freeze_and_advance<T0, T1>(arg1, v1, v0, *0x2::tx_context::digest(arg3), 0x2::tx_context::reference_gas_price(arg3));
    }

    public fun close_period_converting<T0, T1>(arg0: &RewardRegistry, arg1: &mut RewardVault<T0, T1>, arg2: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::PriceConfig, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        let (v0, v1, v2) = begin_converting_close<T0, T1>(arg0, arg1, arg5);
        let v3 = v2;
        let (v4, v5) = 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::try_swap_sui_for_usd_quote<T1>(arg2, arg3, arg4, v3, arg5);
        finish_converting_close<T0, T1>(arg1, v4, v5, 0x2::balance::value<0x2::sui::SUI>(&v3), v1, v0, *0x2::tx_context::digest(arg6), 0x2::tx_context::reference_gas_price(arg6));
    }

    public fun collect<T0, T1, T2>(arg0: &RewardRegistry, arg1: &mut RewardVault<T0, T1>, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T2>>) {
        check_version(arg0);
        let v0 = if (is_type<T2, T1>()) {
            true
        } else if (is_type<T2, T0>()) {
            true
        } else {
            is_type<T2, 0x2::sui::SUI>()
        };
        assert!(v0, 6);
        let v1 = 0x2::transfer::public_receive<0x2::coin::Coin<T2>>(&mut arg1.id, arg2);
        credit<T0, T1, T2>(arg1, 0x2::coin::into_balance<T2>(v1));
        let v2 = Collected{
            vault_id : 0x2::object::id<RewardVault<T0, T1>>(arg1),
            asset    : 0x1::type_name::with_defining_ids<T2>(),
            coin_id  : 0x2::object::id<0x2::coin::Coin<T2>>(&v1),
            amount   : 0x2::coin::value<T2>(&v1),
        };
        0x2::event::emit<Collected>(v2);
    }

    public fun collect_reward<T0, T1, T2>(arg0: &DistributorCap, arg1: &RewardRegistry, arg2: &mut RewardVault<T0, T1>, arg3: 0x2::transfer::Receiving<0x2::coin::Coin<T2>>) {
        check_version(arg1);
        check_distributor(arg1, arg0);
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
            assert!(0x1::vector::length<u8>(&v2) == 32, 19);
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

    public fun convert_grace_ms() : u64 {
        3600000
    }

    public fun create_vault<T0, T1>(arg0: &mut RewardRegistry, arg1: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::CreatorCap, arg2: &mut 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::Curve<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority::PriceConfig, arg6: &mut 0x2::tx_context::TxContext) : address {
        check_version(arg0);
        assert_active_creator<T0>(arg1, arg2);
        assert!(0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::graduation_quote<T0>(arg2) == 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T1>()), 3);
        assert!(is_valid_period_ms(arg3), 5);
        let v0 = 0x2::object::id<0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::Curve<T0>>(arg2);
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.vaults, v0), 4);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = RewardVault<T0, T1>{
            id              : 0x2::object::new(arg6),
            curve_id        : v0,
            period_ms       : arg3,
            next_period_ms  : arg3,
            period          : 0,
            period_start_ms : v1,
            periods         : 0x2::table::new<u64, PeriodRecord>(arg6),
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
        let v6 = VaultWitness{dummy_field: false};
        0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::bind_rewards_vault<T0, VaultWitness>(v6, arg1, arg2, arg5, v5, arg4);
        0x2::transfer::share_object<RewardVault<T0, T1>>(v2);
        v5
    }

    fun credit<T0, T1, T2>(arg0: &mut RewardVault<T0, T1>, arg1: 0x2::balance::Balance<T2>) {
        let v0 = AssetKey<T2>{dummy_field: false};
        if (!0x2::dynamic_field::exists<AssetKey<T2>>(&arg0.id, v0)) {
            let v1 = AssetState<T2>{
                balance             : 0x2::balance::zero<T2>(),
                committed           : 0,
                total_in            : 0,
                total_paid          : 0,
                total_reimbursed    : 0,
                total_converted_out : 0,
            };
            0x2::dynamic_field::add<AssetKey<T2>, AssetState<T2>>(&mut arg0.id, v0, v1);
        };
        let v2 = 0x2::dynamic_field::borrow_mut<AssetKey<T2>, AssetState<T2>>(&mut arg0.id, v0);
        v2.total_in = v2.total_in + 0x2::balance::value<T2>(&arg1);
        0x2::balance::join<T2>(&mut v2.balance, arg1);
    }

    public fun deposit_as_creator<T0, T1, T2>(arg0: &RewardRegistry, arg1: &mut RewardVault<T0, T1>, arg2: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::Curve<T0>, arg3: 0x2::coin::Coin<T2>, arg4: &0x2::tx_context::TxContext) {
        check_version(arg0);
        assert_vault_curve<T0, T1>(arg1, arg2);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::creator<T0>(arg2), 1);
        let v1 = 0x2::coin::value<T2>(&arg3);
        assert!(v1 > 0, 20);
        credit<T0, T1, T2>(arg1, 0x2::coin::into_balance<T2>(arg3));
        let v2 = CreatorDeposited{
            vault_id : 0x2::object::id<RewardVault<T0, T1>>(arg1),
            curve_id : 0x2::object::id<0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::Curve<T0>>(arg2),
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
        check_version(arg0);
        assert!(budget_state<T0, T1, T2>(arg1, arg2) == 1, 15);
        let v0 = RootKey<T2>{period: arg2};
        let v1 = 0x2::dynamic_field::borrow<RootKey<T2>, Root>(&arg1.id, v0);
        assert!(0x2::clock::timestamp_ms(arg3) >= v1.deadline_ms, 17);
        let v2 = v1.total - v1.paid_amount;
        let v3 = (v1.count - v1.paid_count) * v1.rate;
        set_budget_state<T0, T1, T2>(arg1, arg2, 3);
        release<T0, T1, T2>(arg1, v2);
        release<T0, T1, 0x2::sui::SUI>(arg1, v3);
        let v4 = RootExpired{
            vault_id     : 0x2::object::id<RewardVault<T0, T1>>(arg1),
            period       : arg2,
            asset        : 0x1::type_name::with_defining_ids<T2>(),
            released     : v2,
            gas_released : v3,
        };
        0x2::event::emit<RootExpired>(v4);
    }

    fun finish_converting_close<T0, T1>(arg0: &mut RewardVault<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: u64) {
        let v0 = 0x2::balance::value<T1>(&arg1);
        let v1 = arg3 - 0x2::balance::value<0x2::sui::SUI>(&arg2);
        let v2 = AssetKey<0x2::sui::SUI>{dummy_field: false};
        if (0x2::dynamic_field::exists<AssetKey<0x2::sui::SUI>>(&arg0.id, v2)) {
            let v3 = 0x2::dynamic_field::borrow_mut<AssetKey<0x2::sui::SUI>, AssetState<0x2::sui::SUI>>(&mut arg0.id, v2);
            v3.total_converted_out = v3.total_converted_out + v1;
            0x2::balance::join<0x2::sui::SUI>(&mut v3.balance, arg2);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(arg2);
        };
        if (v0 > 0) {
            credit<T0, T1, T1>(arg0, arg1);
        } else {
            0x2::balance::destroy_zero<T1>(arg1);
        };
        let v4 = BudgetConverted{
            vault_id    : 0x2::object::id<RewardVault<T0, T1>>(arg0),
            period      : arg0.period,
            converted   : v1 > 0,
            sui_offered : arg3,
            sui_in      : v1,
            quote_out   : v0,
        };
        0x2::event::emit<BudgetConverted>(v4);
        freeze_and_advance<T0, T1>(arg0, arg4, arg5, arg6, arg7);
    }

    fun freeze_and_advance<T0, T1>(arg0: &mut RewardVault<T0, T1>, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: u64) {
        let v0 = if (is_type<T1, 0x2::sui::SUI>()) {
            available<T0, T1, 0x2::sui::SUI>(arg0) - arg1
        } else {
            available<T0, T1, T1>(arg0)
        };
        let v1 = if (is_type<T0, T1>() || is_type<T0, 0x2::sui::SUI>()) {
            0
        } else {
            available<T0, T1, T0>(arg0)
        };
        commit<T0, T1, 0x2::sui::SUI>(arg0, arg1);
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
        check_version(arg0);
        let v0 = if (!is_type<T2, T1>()) {
            if (!is_type<T2, T0>()) {
                !is_type<T2, 0x2::sui::SUI>()
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 6);
        assert!(arg1.period > 0, 39);
        let v1 = arg1.period - 1;
        assert!(0x2::table::borrow<u64, PeriodRecord>(&arg1.periods, v1).close_digest == *0x2::tx_context::digest(arg2), 39);
        let v2 = BudgetKey<T2>{period: v1};
        if (0x2::dynamic_field::exists<BudgetKey<T2>>(&arg1.id, v2)) {
            return 0
        };
        let v3 = available<T0, T1, T2>(arg1);
        if (v3 == 0) {
            return 0
        };
        record_budget<T0, T1, T2>(arg1, v1, v3);
        v3
    }

    public fun gas_per_recipient_mist() : u64 {
        5000000
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
            version            : 1,
            distributor        : 0x1::option::none<0x2::object::ID>(),
            distributor_holder : 0x1::option::none<address>(),
            guardian           : 0x1::option::none<0x2::object::ID>(),
            guardian_holder    : 0x1::option::none<address>(),
            vaults             : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg0),
            excluded           : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<RewardRegistry>(v0);
        let v1 = RewardsAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<RewardsAdminCap>(v1, 0x2::tx_context::sender(arg0));
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

    public fun migrate(arg0: &RewardsAdminCap, arg1: &mut RewardRegistry) {
        assert!(arg1.version < 1, 24);
        arg1.version = 1;
        let v0 = Migrated{
            from_version : arg1.version,
            to_version   : 1,
        };
        0x2::event::emit<Migrated>(v0);
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

    public fun payout_cost_bound(arg0: u64) : u64 {
        let v0 = (737 as u128) * (arg0 as u128) + (1877330 as u128);
        if (v0 < (5000000 as u128)) {
            (v0 as u64)
        } else {
            5000000
        }
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
        check_version(arg1);
        check_distributor(arg1, arg0);
        assert!(0x2::table::contains<u64, PeriodRecord>(&arg2.periods, arg3), 8);
        let v0 = BudgetKey<T2>{period: arg3};
        assert!(0x2::dynamic_field::exists<BudgetKey<T2>>(&arg2.id, v0), 38);
        let v1 = 0x2::clock::timestamp_ms(arg10);
        let v2 = 0x2::dynamic_field::borrow_mut<BudgetKey<T2>, Budget>(&mut arg2.id, v0);
        assert!(v2.state == 0, 9);
        assert!(v1 <= 0x2::table::borrow<u64, PeriodRecord>(&arg2.periods, arg3).post_deadline_ms, 28);
        assert!(arg9 == 4, 27);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 10);
        assert!(arg6 >= 1 && arg6 <= 1048576, 11);
        assert!(arg5 > 0, 26);
        assert!(arg5 <= v2.amount, 12);
        assert!(arg7 <= 5000000, 14);
        assert!(arg7 <= payout_cost_bound(0x2::table::borrow<u64, PeriodRecord>(&arg2.periods, arg3).ref_gas_price), 41);
        v2.state = 1;
        let v3 = v2.amount;
        let v4 = 0x2::table::borrow_mut<u64, PeriodRecord>(&mut arg2.periods, arg3);
        assert!((arg6 as u128) * (arg7 as u128) <= (v4.gas_unassigned as u128), 13);
        v4.gas_unassigned = v4.gas_unassigned - arg6 * arg7;
        let v5 = v3 - arg5;
        release<T0, T1, T2>(arg2, v5);
        let v6 = close_open_budget<T0, T1>(arg2, arg3);
        let v7 = v1 + 1800000;
        let v8 = v7 + 604800000;
        let v9 = RootKey<T2>{period: arg3};
        let v10 = Root{
            merkle_root         : arg4,
            total               : arg5,
            count               : arg6,
            rate                : arg7,
            snapshot_checkpoint : arg8,
            rule_version        : arg9,
            posted_ms           : v1,
            payable_ms          : v7,
            deadline_ms         : v8,
            paid_amount         : 0,
            paid_count          : 0,
            paid_bits           : 0x2::table::new<u64, u256>(arg11),
        };
        0x2::dynamic_field::add<RootKey<T2>, Root>(&mut arg2.id, v9, v10);
        let v11 = RootPosted{
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
            payable_ms          : v7,
            deadline_ms         : v8,
            released            : v5,
            gas_released        : v6,
        };
        0x2::event::emit<RootPosted>(v11);
    }

    public fun push<T0, T1, T2>(arg0: &RewardRegistry, arg1: &mut RewardVault<T0, T1>, arg2: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::Curve<T0>, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: vector<vector<u8>>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        check_version(arg0);
        assert_vault_curve<T0, T1>(arg1, arg2);
        assert!(budget_state<T0, T1, T2>(arg1, arg3) == 1, 15);
        let v0 = 0x2::object::id_address<RewardVault<T0, T1>>(arg1);
        assert_not_excluded<T0>(arg0, arg2, v0, arg5);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        let v2 = RootKey<T2>{period: arg3};
        let v3 = 0x2::dynamic_field::borrow_mut<RootKey<T2>, Root>(&mut arg1.id, v2);
        assert!(v1 >= v3.payable_ms, 30);
        assert!(v1 < v3.deadline_ms, 16);
        assert!(arg4 < v3.count, 18);
        assert!(arg6 > 0, 20);
        assert!((arg6 as u128) * (10000 as u128) <= (v3.total as u128) * (1000 as u128), 32);
        assert!(0x1::vector::length<vector<u8>>(&arg7) == merkle_depth(v3.count), 25);
        assert!(compute_root(leaf_hash(v0, arg3, asset_string<T2>(), arg4, arg5, arg6), arg4, &arg7) == v3.merkle_root, 19);
        if (bit_is_set(&v3.paid_bits, arg4)) {
            return 0x2::coin::zero<0x2::sui::SUI>(arg9)
        };
        assert!(arg6 <= v3.total - v3.paid_amount, 21);
        let v4 = &mut v3.paid_bits;
        set_bit(v4, arg4);
        v3.paid_amount = v3.paid_amount + arg6;
        v3.paid_count = v3.paid_count + 1;
        let v5 = v3.rate;
        let v6 = AssetKey<T2>{dummy_field: false};
        let v7 = 0x2::dynamic_field::borrow_mut<AssetKey<T2>, AssetState<T2>>(&mut arg1.id, v6);
        v7.committed = v7.committed - arg6;
        v7.total_paid = v7.total_paid + arg6;
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut v7.balance, arg6), arg9), arg5);
        let v8 = if (v5 > 0) {
            let v9 = AssetKey<0x2::sui::SUI>{dummy_field: false};
            let v10 = 0x2::dynamic_field::borrow_mut<AssetKey<0x2::sui::SUI>, AssetState<0x2::sui::SUI>>(&mut arg1.id, v9);
            v10.committed = v10.committed - v5;
            v10.total_reimbursed = v10.total_reimbursed + v5;
            0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v10.balance, v5), arg9)
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg9)
        };
        let v11 = Pushed{
            vault_id      : 0x2::object::id<RewardVault<T0, T1>>(arg1),
            period        : arg3,
            asset         : 0x1::type_name::with_defining_ids<T2>(),
            leaf_idx      : arg4,
            recipient     : arg5,
            amount        : arg6,
            pusher        : 0x2::tx_context::sender(arg9),
            reimbursement : v5,
        };
        0x2::event::emit<Pushed>(v11);
        v8
    }

    public fun push_compute_units() : u64 {
        737
    }

    public fun push_storage_net_mist() : u64 {
        1877330
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

    fun release<T0, T1, T2>(arg0: &mut RewardVault<T0, T1>, arg1: u64) {
        if (arg1 == 0) {
            return
        };
        let v0 = AssetKey<T2>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<AssetKey<T2>, AssetState<T2>>(&mut arg0.id, v0);
        v1.committed = v1.committed - arg1;
    }

    public fun release_unassigned_gas<T0, T1>(arg0: &RewardRegistry, arg1: &mut RewardVault<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(0x2::table::contains<u64, PeriodRecord>(&arg1.periods, arg2), 8);
        let v0 = 0x2::table::borrow_mut<u64, PeriodRecord>(&mut arg1.periods, arg2);
        assert!((v0.open_budgets == 0 || 0x2::clock::timestamp_ms(arg3) > v0.post_deadline_ms) && v0.close_digest != *0x2::tx_context::digest(arg4), 40);
        let v1 = v0.gas_unassigned;
        v0.gas_unassigned = 0;
        if (v1 == 0) {
            return
        };
        release<T0, T1, 0x2::sui::SUI>(arg1, v1);
        let v2 = GasReleased{
            vault_id     : 0x2::object::id<RewardVault<T0, T1>>(arg1),
            period       : arg2,
            gas_released : v1,
        };
        0x2::event::emit<GasReleased>(v2);
    }

    public fun release_unposted<T0, T1, T2>(arg0: &RewardRegistry, arg1: &mut RewardVault<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock) {
        check_version(arg0);
        assert!(0x2::table::contains<u64, PeriodRecord>(&arg1.periods, arg2), 8);
        let v0 = BudgetKey<T2>{period: arg2};
        assert!(0x2::dynamic_field::exists<BudgetKey<T2>>(&arg1.id, v0), 38);
        let v1 = 0x2::dynamic_field::borrow_mut<BudgetKey<T2>, Budget>(&mut arg1.id, v0);
        assert!(v1.state == 0, 35);
        assert!(0x2::clock::timestamp_ms(arg3) > 0x2::table::borrow<u64, PeriodRecord>(&arg1.periods, arg2).post_deadline_ms, 29);
        v1.state = 4;
        let v2 = v1.amount;
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

    public fun remove_exclusion(arg0: &RewardsAdminCap, arg1: &mut RewardRegistry, arg2: address) {
        check_version(arg1);
        if (0x2::table::contains<address, bool>(&arg1.excluded, arg2)) {
            0x2::table::remove<address, bool>(&mut arg1.excluded, arg2);
        };
        let v0 = ExclusionSet{
            addr     : arg2,
            excluded : false,
        };
        0x2::event::emit<ExclusionSet>(v0);
    }

    public fun revoke_distributor(arg0: &RewardsAdminCap, arg1: &mut RewardRegistry) {
        check_version(arg1);
        arg1.distributor = 0x1::option::none<0x2::object::ID>();
        arg1.distributor_holder = 0x1::option::none<address>();
        let v0 = DistributorSet{
            cap_id : 0x1::option::none<0x2::object::ID>(),
            holder : 0x1::option::none<address>(),
        };
        0x2::event::emit<DistributorSet>(v0);
    }

    public fun revoke_guardian(arg0: &RewardsAdminCap, arg1: &mut RewardRegistry) {
        check_version(arg1);
        arg1.guardian = 0x1::option::none<0x2::object::ID>();
        arg1.guardian_holder = 0x1::option::none<address>();
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

    public fun set_distributor(arg0: &RewardsAdminCap, arg1: &mut RewardRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        assert!(arg2 != 0x2::tx_context::sender(arg3), 34);
        assert!(arg1.guardian_holder != 0x1::option::some<address>(arg2), 34);
        let v0 = DistributorCap{id: 0x2::object::new(arg3)};
        let v1 = 0x2::object::id<DistributorCap>(&v0);
        arg1.distributor = 0x1::option::some<0x2::object::ID>(v1);
        arg1.distributor_holder = 0x1::option::some<address>(arg2);
        0x2::transfer::transfer<DistributorCap>(v0, arg2);
        let v2 = DistributorSet{
            cap_id : 0x1::option::some<0x2::object::ID>(v1),
            holder : 0x1::option::some<address>(arg2),
        };
        0x2::event::emit<DistributorSet>(v2);
    }

    public fun set_frequency<T0, T1>(arg0: &RewardRegistry, arg1: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::CreatorCap, arg2: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::Curve<T0>, arg3: &mut RewardVault<T0, T1>, arg4: u64) {
        check_version(arg0);
        assert_vault_curve<T0, T1>(arg3, arg2);
        assert_active_creator<T0>(arg1, arg2);
        assert!(is_valid_period_ms(arg4), 5);
        arg3.next_period_ms = arg4;
        let v0 = PeriodMsSet{
            vault_id       : 0x2::object::id<RewardVault<T0, T1>>(arg3),
            next_period_ms : arg4,
            current_period : arg3.period,
        };
        0x2::event::emit<PeriodMsSet>(v0);
    }

    public fun set_guardian(arg0: &RewardsAdminCap, arg1: &mut RewardRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        assert!(arg2 != 0x2::tx_context::sender(arg3), 34);
        assert!(arg1.distributor_holder != 0x1::option::some<address>(arg2), 34);
        let v0 = GuardianCap{id: 0x2::object::new(arg3)};
        let v1 = 0x2::object::id<GuardianCap>(&v0);
        arg1.guardian = 0x1::option::some<0x2::object::ID>(v1);
        arg1.guardian_holder = 0x1::option::some<address>(arg2);
        0x2::transfer::transfer<GuardianCap>(v0, arg2);
        let v2 = GuardianSet{
            cap_id : 0x1::option::some<0x2::object::ID>(v1),
            holder : 0x1::option::some<address>(arg2),
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

    public fun version(arg0: &RewardRegistry) : u64 {
        arg0.version
    }

    public fun veto_as_creator<T0, T1, T2>(arg0: &RewardRegistry, arg1: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::CreatorCap, arg2: &0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::curve::Curve<T0>, arg3: &mut RewardVault<T0, T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        check_version(arg0);
        assert_vault_curve<T0, T1>(arg3, arg2);
        assert_active_creator<T0>(arg1, arg2);
        veto_internal<T0, T1, T2>(arg3, arg4, arg5, 0, 0x2::tx_context::sender(arg6));
    }

    public fun veto_as_guardian<T0, T1, T2>(arg0: &RewardRegistry, arg1: &GuardianCap, arg2: &mut RewardVault<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_guardian(arg0, arg1);
        veto_internal<T0, T1, T2>(arg2, arg3, arg4, 1, 0x2::tx_context::sender(arg5));
    }

    fun veto_internal<T0, T1, T2>(arg0: &mut RewardVault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: u8, arg4: address) {
        assert!(budget_state<T0, T1, T2>(arg0, arg1) == 1, 15);
        let v0 = RootKey<T2>{period: arg1};
        let Root {
            merkle_root         : _,
            total               : v2,
            count               : v3,
            rate                : v4,
            snapshot_checkpoint : _,
            rule_version        : _,
            posted_ms           : _,
            payable_ms          : v8,
            deadline_ms         : _,
            paid_amount         : v10,
            paid_count          : v11,
            paid_bits           : v12,
        } = 0x2::dynamic_field::remove<RootKey<T2>, Root>(&mut arg0.id, v0);
        assert!(0x2::clock::timestamp_ms(arg2) < v8, 31);
        0x2::table::destroy_empty<u64, u256>(v12);
        let v13 = v2 - v10;
        let v14 = (v3 - v11) * v4;
        set_budget_state<T0, T1, T2>(arg0, arg1, 2);
        release<T0, T1, T2>(arg0, v13);
        release<T0, T1, 0x2::sui::SUI>(arg0, v14);
        let v15 = RootVetoed{
            vault_id     : 0x2::object::id<RewardVault<T0, T1>>(arg0),
            period       : arg1,
            asset        : 0x1::type_name::with_defining_ids<T2>(),
            by           : arg3,
            vetoer       : arg4,
            released     : v13,
            gas_released : v14,
        };
        0x2::event::emit<RootVetoed>(v15);
    }

    // decompiled from Move bytecode v7
}

