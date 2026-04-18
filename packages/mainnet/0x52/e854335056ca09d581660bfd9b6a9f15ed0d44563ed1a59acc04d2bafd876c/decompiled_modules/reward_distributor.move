module 0x52e854335056ca09d581660bfd9b6a9f15ed0d44563ed1a59acc04d2bafd876c::reward_distributor {
    struct Create has copy, drop {
        vault_id: 0x2::object::ID,
        asset_type: 0x1::ascii::String,
    }

    struct AddRewarder has copy, drop {
        vault_id: 0x2::object::ID,
        rewarder_id: 0x2::object::ID,
        asset_type: 0x1::ascii::String,
        reward_type: 0x1::ascii::String,
    }

    struct UpdateFlowRate has copy, drop {
        vault_id: 0x2::object::ID,
        rewarder_id: 0x2::object::ID,
        asset_type: 0x1::ascii::String,
        reward_type: 0x1::ascii::String,
        flow_rate: u256,
    }

    struct RewardEarned has copy, drop {
        vault_id: 0x2::object::ID,
        rewarder_id: 0x2::object::ID,
        asset_type: 0x1::ascii::String,
        reward_type: 0x1::ascii::String,
        reward_amount: u64,
    }

    struct Deposit has copy, drop {
        vault_id: 0x2::object::ID,
        asset_type: 0x1::ascii::String,
        account_address: address,
        stake_amount: u64,
    }

    struct Redeem has copy, drop {
        vault_id: 0x2::object::ID,
        asset_type: 0x1::ascii::String,
        account_address: address,
        withdrawal_amount: u64,
    }

    struct ClaimReward has copy, drop {
        vault_id: 0x2::object::ID,
        rewarder_id: 0x2::object::ID,
        asset_type: 0x1::ascii::String,
        reward_type: 0x1::ascii::String,
        account_address: address,
        reward_amount: u64,
        cumulative_reward_amount: u64,
    }

    struct StakePosition has store {
        stake_amount: u64,
        pending_rewarder_sync: bool,
    }

    struct RewarderKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct RewardData<phantom T0> has store {
        unit: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double,
        reward: 0x2::balance::Balance<T0>,
        cumulative_reward_amount: u64,
    }

    struct Rewarder<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        source: 0x2::balance::Balance<T1>,
        pool: 0x2::balance::Balance<T1>,
        flow_rate: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double,
        unit: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double,
        timestamp: u64,
        total_stake_snapshot: u64,
        reward_table: 0x2::table::Table<address, RewardData<T1>>,
    }

    struct StakeDataDisplay has copy, drop {
        stake_coin_type: 0x1::ascii::String,
        reward_coin_type: 0x1::ascii::String,
        stake_amount: u64,
        claimable_reward_amount: u64,
        cumulative_reward_amount: u64,
    }

    struct DepositChecker<phantom T0> {
        account: address,
        prev_stake_amount: u64,
        rewarder_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct WithdrawChecker<phantom T0> {
        account: address,
        prev_stake_amount: u64,
        rewarder_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RewardDistributor<phantom T0> has store, key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u16>,
        stake: 0x2::balance::Balance<T0>,
        stake_table: 0x2::table::Table<address, StakePosition>,
        managers: 0x2::vec_set::VecSet<address>,
        stake_cap: u64,
        rewarder_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    public fun id<T0>(arg0: &RewardDistributor<T0>) : 0x2::object::ID {
        0x2::object::id<RewardDistributor<T0>>(arg0)
    }

    public fun new<T0>(arg0: &AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : RewardDistributor<T0> {
        let v0 = RewardDistributor<T0>{
            id           : 0x2::object::new(arg2),
            versions     : 0x2::vec_set::singleton<u16>(package_version()),
            stake        : 0x2::balance::zero<T0>(),
            stake_table  : 0x2::table::new<address, StakePosition>(arg2),
            managers     : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg2)),
            stake_cap    : arg1,
            rewarder_ids : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        let v1 = Create{
            vault_id   : id<T0>(&v0),
            asset_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
        };
        0x2::event::emit<Create>(v1);
        v0
    }

    public fun add_manager<T0>(arg0: &mut RewardDistributor<T0>, arg1: &AdminCap, arg2: address) {
        assert_valid_package_version<T0>(arg0);
        0x2::vec_set::insert<address>(&mut arg0.managers, arg2);
    }

    public fun add_rewarder<T0, T1>(arg0: &mut RewardDistributor<T0>, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version<T0>(arg0);
        if (arg3 == 0) {
            err_invalid_reward();
        };
        if (rewarder_exists<T0, T1>(arg0)) {
            err_rewarder_already_exists();
        };
        let v0 = Rewarder<T0, T1>{
            id                   : 0x2::object::new(arg5),
            source               : 0x2::balance::zero<T1>(),
            pool                 : 0x2::balance::zero<T1>(),
            flow_rate            : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from_fraction(arg2, arg3),
            unit                 : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::zero(),
            timestamp            : arg4,
            total_stake_snapshot : total_stake_amount<T0>(arg0),
            reward_table         : 0x2::table::new<address, RewardData<T1>>(arg5),
        };
        let v1 = 0x2::object::id<Rewarder<T0, T1>>(&v0);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.rewarder_ids, v1);
        let v2 = RewarderKey<T1>{dummy_field: false};
        0x2::dynamic_field::add<RewarderKey<T1>, Rewarder<T0, T1>>(&mut arg0.id, v2, v0);
        let v3 = AddRewarder{
            vault_id    : id<T0>(arg0),
            rewarder_id : v1,
            asset_type  : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            reward_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
        };
        0x2::event::emit<AddRewarder>(v3);
    }

    public fun add_version<T0>(arg0: &mut RewardDistributor<T0>, arg1: &AdminCap, arg2: u16) {
        0x2::vec_set::insert<u16>(&mut arg0.versions, arg2);
    }

    fun assert_no_pending_rewarder_sync<T0>(arg0: &RewardDistributor<T0>, arg1: address) {
        if (stake_exists<T0>(arg0, arg1) && stake_position<T0>(arg0, arg1).pending_rewarder_sync) {
            err_pending_rewarder_sync();
        };
    }

    fun assert_sender_is_manager<T0>(arg0: &RewardDistributor<T0>, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest) {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1);
        if (!0x2::vec_set::contains<address>(&arg0.managers, &v0)) {
            err_sender_is_not_manager();
        };
    }

    fun assert_valid_package_version<T0>(arg0: &RewardDistributor<T0>) {
        let v0 = package_version();
        if (!0x2::vec_set::contains<u16>(&arg0.versions, &v0)) {
            err_invalid_package_version();
        };
    }

    fun check_and_settle_rewarder<T0, T1>(arg0: &mut RewardDistributor<T0>, arg1: &mut 0x2::vec_set::VecSet<0x2::object::ID>, arg2: address, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = total_stake_amount<T0>(arg0);
        let v1 = rewarder_mut<T0, T1>(arg0);
        let v2 = 0x2::object::id<Rewarder<T0, T1>>(v1);
        if (!0x2::vec_set::contains<0x2::object::ID>(arg1, &v2)) {
            err_invalid_reward();
        };
        source_to_pool<T0, T1>(v1, arg4);
        settle_reward<T0, T1>(v1, arg2, arg3);
        v1.total_stake_snapshot = v0;
        0x2::vec_set::remove<0x2::object::ID>(arg1, &v2);
        if (0x2::vec_set::is_empty<0x2::object::ID>(arg1)) {
            stake_position_mut_or_insert<T0>(arg0, arg2).pending_rewarder_sync = false;
        };
    }

    public fun claim<T0, T1>(arg0: &mut RewardDistributor<T0>, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_valid_package_version<T0>(arg0);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1);
        assert_no_pending_rewarder_sync<T0>(arg0, v0);
        let v1 = stake_amount<T0>(arg0, v0);
        let v2 = id<T0>(arg0);
        let v3 = rewarder_mut<T0, T1>(arg0);
        if (0x2::clock::timestamp_ms(arg2) < v3.timestamp) {
            return 0x2::coin::zero<T1>(arg3)
        };
        source_to_pool<T0, T1>(v3, arg2);
        settle_reward<T0, T1>(v3, v0, v1);
        let v4 = 0x2::object::id<Rewarder<T0, T1>>(v3);
        let v5 = reward_data_mut_or_insert<T0, T1>(v3, v0);
        let v6 = 0x2::balance::value<T1>(&v5.reward);
        v5.cumulative_reward_amount = v5.cumulative_reward_amount + v6;
        let v7 = ClaimReward{
            vault_id                 : v2,
            rewarder_id              : v4,
            asset_type               : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            reward_type              : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            account_address          : v0,
            reward_amount            : v6,
            cumulative_reward_amount : v5.cumulative_reward_amount,
        };
        0x2::event::emit<ClaimReward>(v7);
        0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut v5.reward), arg3)
    }

    public fun default<T0>(arg0: &AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<RewardDistributor<T0>>(new<T0>(arg0, arg1, arg2));
    }

    public fun deposit<T0>(arg0: &mut RewardDistributor<T0>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest) : DepositChecker<T0> {
        assert_valid_package_version<T0>(arg0);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg3);
        assert_no_pending_rewarder_sync<T0>(arg0, v0);
        let v1 = !0x2::vec_set::is_empty<0x2::object::ID>(&arg0.rewarder_ids);
        let v2 = 0x2::coin::value<T0>(&arg2);
        let v3 = stake_position_mut_or_insert<T0>(arg0, v0);
        let v4 = v3.stake_amount;
        v3.pending_rewarder_sync = v1;
        v3.stake_amount = v3.stake_amount + v2;
        0x2::balance::join<T0>(&mut arg0.stake, 0x2::coin::into_balance<T0>(arg2));
        if (0x2::balance::value<T0>(&arg0.stake) > arg0.stake_cap) {
            err_exceed_deposit_cap();
        };
        let v5 = Deposit{
            vault_id        : id<T0>(arg0),
            asset_type      : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            account_address : v0,
            stake_amount    : v2,
        };
        0x2::event::emit<Deposit>(v5);
        DepositChecker<T0>{
            account           : v0,
            prev_stake_amount : v4,
            rewarder_ids      : arg0.rewarder_ids,
        }
    }

    public fun deposit_to_pool<T0, T1>(arg0: &mut RewardDistributor<T0>, arg1: 0x2::coin::Coin<T1>) {
        assert_valid_package_version<T0>(arg0);
        0x2::balance::join<T1>(&mut rewarder_mut<T0, T1>(arg0).pool, 0x2::coin::into_balance<T1>(arg1));
    }

    public fun deposit_to_source<T0, T1>(arg0: &mut RewardDistributor<T0>, arg1: 0x2::coin::Coin<T1>) {
        assert_valid_package_version<T0>(arg0);
        let v0 = id<T0>(arg0);
        let v1 = rewarder_mut<T0, T1>(arg0);
        0x2::balance::join<T1>(&mut v1.source, 0x2::coin::into_balance<T1>(arg1));
        let v2 = RewardEarned{
            vault_id      : v0,
            rewarder_id   : 0x2::object::id<Rewarder<T0, T1>>(v1),
            asset_type    : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            reward_type   : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            reward_amount : 0x2::coin::value<T1>(&arg1),
        };
        0x2::event::emit<RewardEarned>(v2);
    }

    public fun deposit_to_source_by_manager<T0, T1>(arg0: &mut RewardDistributor<T0>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest) {
        deposit_to_source<T0, T1>(arg0, arg2);
        let v0 = rewarder_source_amount<T0, T1>(arg0);
        update_flow_rate<T0, T1>(arg0, arg1, v0, arg3, arg4);
    }

    public fun destroy_deposit_checker<T0>(arg0: DepositChecker<T0>) {
        let DepositChecker {
            account           : _,
            prev_stake_amount : _,
            rewarder_ids      : v2,
        } = arg0;
        let v3 = v2;
        if (!0x2::vec_set::is_empty<0x2::object::ID>(&v3)) {
            err_missing_rewarder_check();
        };
    }

    public fun destroy_withdraw_checker<T0>(arg0: WithdrawChecker<T0>) {
        let WithdrawChecker {
            account           : _,
            prev_stake_amount : _,
            rewarder_ids      : v2,
        } = arg0;
        let v3 = v2;
        if (!0x2::vec_set::is_empty<0x2::object::ID>(&v3)) {
            err_missing_rewarder_check();
        };
    }

    fun err_exceed_deposit_cap() {
        abort 3
    }

    fun err_invalid_package_version() {
        abort 4
    }

    fun err_invalid_reward() {
        abort 6
    }

    fun err_missing_rewarder_check() {
        abort 7
    }

    fun err_pending_rewarder_sync() {
        abort 9
    }

    fun err_rewarder_already_exists() {
        abort 8
    }

    fun err_sender_is_not_manager() {
        abort 2
    }

    fun err_withdraw_not_enough() {
        abort 5
    }

    fun err_withdraw_too_much() {
        abort 1
    }

    public fun get_rewarder<T0, T1>(arg0: &RewardDistributor<T0>) : &Rewarder<T0, T1> {
        if (!rewarder_exists<T0, T1>(arg0)) {
            err_invalid_reward();
        };
        let v0 = RewarderKey<T1>{dummy_field: false};
        0x2::dynamic_field::borrow<RewarderKey<T1>, Rewarder<T0, T1>>(&arg0.id, v0)
    }

    public fun get_stake_data<T0, T1>(arg0: &RewardDistributor<T0>, arg1: address, arg2: &0x2::clock::Clock) : StakeDataDisplay {
        let v0 = if (rewarder_exists<T0, T1>(arg0)) {
            let v1 = get_rewarder<T0, T1>(arg0);
            if (reward_data_exists<T0, T1>(v1, arg1)) {
                reward_data<T0, T1>(v1, arg1).cumulative_reward_amount
            } else {
                0
            }
        } else {
            0
        };
        StakeDataDisplay{
            stake_coin_type          : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            reward_coin_type         : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            stake_amount             : stake_amount<T0>(arg0, arg1),
            claimable_reward_amount  : realtime_reward_amount<T0, T1>(arg0, arg1, arg2),
            cumulative_reward_amount : v0,
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun package_version() : u16 {
        1
    }

    public fun realtime_reward_amount<T0, T1>(arg0: &RewardDistributor<T0>, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        if (!rewarder_exists<T0, T1>(arg0)) {
            return 0
        };
        let v0 = get_rewarder<T0, T1>(arg0);
        let v1 = if (reward_data_exists<T0, T1>(v0, arg1)) {
            0x2::balance::value<T1>(&reward_data<T0, T1>(v0, arg1).reward)
        } else {
            0
        };
        v1 + unsettled_reward_amount<T0, T1>(v0, arg1, stake_amount<T0>(arg0, arg1), arg2)
    }

    fun realtime_reward_release_and_unit<T0, T1>(arg0: &Rewarder<T0, T1>, arg1: &0x2::clock::Clock) : (u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = arg0.timestamp;
        if (v0 > v1 && arg0.total_stake_snapshot > 0) {
            let v4 = 0x1::u64::min(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::mul_u64(arg0.flow_rate, v0 - v1)), 0x2::balance::value<T1>(&arg0.source));
            (v4, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::add(arg0.unit, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from_fraction(v4, arg0.total_stake_snapshot)))
        } else {
            (0, arg0.unit)
        }
    }

    public fun redeem<T0>(arg0: &mut RewardDistributor<T0>, arg1: &0x2::clock::Clock, arg2: u64, arg3: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, WithdrawChecker<T0>) {
        assert_valid_package_version<T0>(arg0);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg3);
        assert_no_pending_rewarder_sync<T0>(arg0, v0);
        let v1 = withdrawable_amount<T0>(arg0, v0);
        if (arg2 == 0) {
            err_withdraw_not_enough();
        };
        if (arg2 < 1000 && arg2 != v1) {
            err_withdraw_not_enough();
        };
        if (v1 < arg2) {
            err_withdraw_too_much();
        };
        let v2 = !0x2::vec_set::is_empty<0x2::object::ID>(&arg0.rewarder_ids);
        let v3 = stake_position_mut_or_insert<T0>(arg0, v0);
        v3.pending_rewarder_sync = v2;
        v3.stake_amount = v3.stake_amount - arg2;
        let v4 = WithdrawChecker<T0>{
            account           : v0,
            prev_stake_amount : v3.stake_amount,
            rewarder_ids      : arg0.rewarder_ids,
        };
        let v5 = Redeem{
            vault_id          : id<T0>(arg0),
            asset_type        : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            account_address   : v0,
            withdrawal_amount : arg2,
        };
        0x2::event::emit<Redeem>(v5);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.stake, arg2), arg4), v4)
    }

    public fun remove_manager<T0>(arg0: &mut RewardDistributor<T0>, arg1: &AdminCap, arg2: address) {
        assert_valid_package_version<T0>(arg0);
        0x2::vec_set::remove<address>(&mut arg0.managers, &arg2);
    }

    public fun remove_version<T0>(arg0: &mut RewardDistributor<T0>, arg1: &AdminCap, arg2: u16) {
        0x2::vec_set::remove<u16>(&mut arg0.versions, &arg2);
    }

    fun reward_data<T0, T1>(arg0: &Rewarder<T0, T1>, arg1: address) : &RewardData<T1> {
        0x2::table::borrow<address, RewardData<T1>>(&arg0.reward_table, arg1)
    }

    fun reward_data_exists<T0, T1>(arg0: &Rewarder<T0, T1>, arg1: address) : bool {
        0x2::table::contains<address, RewardData<T1>>(&arg0.reward_table, arg1)
    }

    fun reward_data_mut_or_insert<T0, T1>(arg0: &mut Rewarder<T0, T1>, arg1: address) : &mut RewardData<T1> {
        if (!0x2::table::contains<address, RewardData<T1>>(&arg0.reward_table, arg1)) {
            let v0 = RewardData<T1>{
                unit                     : arg0.unit,
                reward                   : 0x2::balance::zero<T1>(),
                cumulative_reward_amount : 0,
            };
            0x2::table::add<address, RewardData<T1>>(&mut arg0.reward_table, arg1, v0);
        };
        0x2::table::borrow_mut<address, RewardData<T1>>(&mut arg0.reward_table, arg1)
    }

    public fun rewarder_exists<T0, T1>(arg0: &RewardDistributor<T0>) : bool {
        let v0 = RewarderKey<T1>{dummy_field: false};
        0x2::dynamic_field::exists_with_type<RewarderKey<T1>, Rewarder<T0, T1>>(&arg0.id, v0)
    }

    public fun rewarder_flow_rate<T0, T1>(arg0: &RewardDistributor<T0>) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double {
        if (!rewarder_exists<T0, T1>(arg0)) {
            return 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::zero()
        };
        get_rewarder<T0, T1>(arg0).flow_rate
    }

    public fun rewarder_id<T0, T1>(arg0: &RewardDistributor<T0>) : 0x2::object::ID {
        0x2::object::id<Rewarder<T0, T1>>(get_rewarder<T0, T1>(arg0))
    }

    public fun rewarder_ids<T0>(arg0: &RewardDistributor<T0>) : &0x2::vec_set::VecSet<0x2::object::ID> {
        &arg0.rewarder_ids
    }

    fun rewarder_mut<T0, T1>(arg0: &mut RewardDistributor<T0>) : &mut Rewarder<T0, T1> {
        let v0 = RewarderKey<T1>{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<RewarderKey<T1>, Rewarder<T0, T1>>(&arg0.id, v0)) {
            err_invalid_reward();
        };
        let v1 = RewarderKey<T1>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<RewarderKey<T1>, Rewarder<T0, T1>>(&mut arg0.id, v1)
    }

    public fun rewarder_pool_amount<T0, T1>(arg0: &RewardDistributor<T0>) : u64 {
        if (!rewarder_exists<T0, T1>(arg0)) {
            return 0
        };
        0x2::balance::value<T1>(&get_rewarder<T0, T1>(arg0).pool)
    }

    public fun rewarder_source_amount<T0, T1>(arg0: &RewardDistributor<T0>) : u64 {
        if (!rewarder_exists<T0, T1>(arg0)) {
            return 0
        };
        0x2::balance::value<T1>(&get_rewarder<T0, T1>(arg0).source)
    }

    public fun rewarder_timestamp<T0, T1>(arg0: &RewardDistributor<T0>) : u64 {
        if (!rewarder_exists<T0, T1>(arg0)) {
            return 0
        };
        get_rewarder<T0, T1>(arg0).timestamp
    }

    public fun rewarder_total_stake_snapshot<T0, T1>(arg0: &RewardDistributor<T0>) : u64 {
        if (!rewarder_exists<T0, T1>(arg0)) {
            return 0
        };
        get_rewarder<T0, T1>(arg0).total_stake_snapshot
    }

    public fun set_stake_cap<T0>(arg0: &mut RewardDistributor<T0>, arg1: &AdminCap, arg2: u64) {
        assert_valid_package_version<T0>(arg0);
        arg0.stake_cap = arg2;
    }

    fun settle_reward<T0, T1>(arg0: &mut Rewarder<T0, T1>, arg1: address, arg2: u64) : u64 {
        let v0 = if (reward_data_exists<T0, T1>(arg0, arg1)) {
            reward_data<T0, T1>(arg0, arg1).unit
        } else {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::zero()
        };
        let v1 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::sub(arg0.unit, v0), arg2));
        let v2 = 0x1::u64::min(v1, 0x2::balance::value<T1>(&arg0.pool));
        let v3 = 0x2::balance::split<T1>(&mut arg0.pool, v2);
        let v4 = arg0.unit;
        let v5 = reward_data_mut_or_insert<T0, T1>(arg0, arg1);
        let v6 = if (arg2 > 0) {
            if (v1 > 0) {
                v2 < v1
            } else {
                false
            }
        } else {
            false
        };
        if (v6) {
            v5.unit = v4;
        } else {
            v5.unit = v4;
        };
        0x2::balance::join<T1>(&mut v5.reward, v3);
        v2
    }

    public fun settle_rewarder_on_deposit<T0, T1>(arg0: &mut DepositChecker<T0>, arg1: &mut RewardDistributor<T0>, arg2: &0x2::clock::Clock) {
        assert_valid_package_version<T0>(arg1);
        let v0 = &mut arg0.rewarder_ids;
        check_and_settle_rewarder<T0, T1>(arg1, v0, arg0.account, arg0.prev_stake_amount, arg2);
    }

    public fun settle_rewarder_on_withdraw<T0, T1>(arg0: &mut WithdrawChecker<T0>, arg1: &mut RewardDistributor<T0>, arg2: &0x2::clock::Clock) {
        assert_valid_package_version<T0>(arg1);
        let v0 = &mut arg0.rewarder_ids;
        check_and_settle_rewarder<T0, T1>(arg1, v0, arg0.account, arg0.prev_stake_amount, arg2);
    }

    fun source_to_pool<T0, T1>(arg0: &mut Rewarder<T0, T1>, arg1: &0x2::clock::Clock) {
        if (0x2::clock::timestamp_ms(arg1) < arg0.timestamp) {
            return
        };
        let (v0, v1) = realtime_reward_release_and_unit<T0, T1>(arg0, arg1);
        arg0.timestamp = 0x2::clock::timestamp_ms(arg1);
        arg0.unit = v1;
        0x2::balance::join<T1>(&mut arg0.pool, 0x2::balance::split<T1>(&mut arg0.source, v0));
    }

    fun stake_amount<T0>(arg0: &RewardDistributor<T0>, arg1: address) : u64 {
        if (stake_exists<T0>(arg0, arg1)) {
            stake_position<T0>(arg0, arg1).stake_amount
        } else {
            0
        }
    }

    public fun stake_exists<T0>(arg0: &RewardDistributor<T0>, arg1: address) : bool {
        0x2::table::contains<address, StakePosition>(&arg0.stake_table, arg1)
    }

    fun stake_position<T0>(arg0: &RewardDistributor<T0>, arg1: address) : &StakePosition {
        0x2::table::borrow<address, StakePosition>(&arg0.stake_table, arg1)
    }

    fun stake_position_mut_or_insert<T0>(arg0: &mut RewardDistributor<T0>, arg1: address) : &mut StakePosition {
        if (!0x2::table::contains<address, StakePosition>(&arg0.stake_table, arg1)) {
            let v0 = StakePosition{
                stake_amount          : 0,
                pending_rewarder_sync : false,
            };
            0x2::table::add<address, StakePosition>(&mut arg0.stake_table, arg1, v0);
        };
        0x2::table::borrow_mut<address, StakePosition>(&mut arg0.stake_table, arg1)
    }

    public fun supply<T0, T1>(arg0: &mut RewardDistributor<T0>, arg1: 0x2::coin::Coin<T1>) {
        deposit_to_source<T0, T1>(arg0, arg1);
    }

    public fun total_stake_amount<T0>(arg0: &RewardDistributor<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.stake)
    }

    fun unsettled_reward_amount<T0, T1>(arg0: &Rewarder<T0, T1>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        let (_, v1) = realtime_reward_release_and_unit<T0, T1>(arg0, arg3);
        let v2 = if (reward_data_exists<T0, T1>(arg0, arg1)) {
            reward_data<T0, T1>(arg0, arg1).unit
        } else {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::zero()
        };
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::sub(v1, v2), arg2))
    }

    public fun update_flow_rate<T0, T1>(arg0: &mut RewardDistributor<T0>, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest) {
        assert_valid_package_version<T0>(arg0);
        assert_sender_is_manager<T0>(arg0, arg4);
        if (arg3 == 0) {
            err_invalid_reward();
        };
        let v0 = id<T0>(arg0);
        let v1 = rewarder_mut<T0, T1>(arg0);
        source_to_pool<T0, T1>(v1, arg1);
        let v2 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from_fraction(arg2, arg3);
        v1.flow_rate = v2;
        let v3 = UpdateFlowRate{
            vault_id    : v0,
            rewarder_id : 0x2::object::id<Rewarder<T0, T1>>(v1),
            asset_type  : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            reward_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            flow_rate   : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::to_scaled_val(v2),
        };
        0x2::event::emit<UpdateFlowRate>(v3);
    }

    public fun withdraw_from_source<T0, T1>(arg0: &mut RewardDistributor<T0>, arg1: &AdminCap, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_valid_package_version<T0>(arg0);
        let v0 = rewarder_mut<T0, T1>(arg0);
        source_to_pool<T0, T1>(v0, arg2);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v0.source, arg3), arg4)
    }

    public fun withdrawable_amount<T0>(arg0: &RewardDistributor<T0>, arg1: address) : u64 {
        if (stake_exists<T0>(arg0, arg1)) {
            stake_position<T0>(arg0, arg1).stake_amount
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}

