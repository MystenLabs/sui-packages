module 0x6f056e484dc806bcee3453068bab1777e2120fcac237ccf7c29e932860adea2::reward_distributor {
    struct Create has copy, drop {
        vault_id: 0x2::object::ID,
        asset_type: 0x1::ascii::String,
        reward_type: 0x1::ascii::String,
    }

    struct UpdateFlowRate has copy, drop {
        vault_id: 0x2::object::ID,
        asset_type: 0x1::ascii::String,
        reward_type: 0x1::ascii::String,
        flow_rate: u256,
    }

    struct RewardEarned has copy, drop {
        vault_id: 0x2::object::ID,
        asset_type: 0x1::ascii::String,
        reward_type: 0x1::ascii::String,
        amount: u64,
    }

    struct Deposit has copy, drop {
        vault_id: 0x2::object::ID,
        asset_type: 0x1::ascii::String,
        reward_type: 0x1::ascii::String,
        account: address,
        amount: u64,
    }

    struct RequestWithdraw has copy, drop {
        vault_id: 0x2::object::ID,
        asset_type: 0x1::ascii::String,
        reward_type: 0x1::ascii::String,
        request_id: 0x2::object::ID,
        account: address,
        amount: u64,
        expected_withdrawal_time: u64,
    }

    struct CancelWithdraw has copy, drop {
        vault_id: 0x2::object::ID,
        asset_type: 0x1::ascii::String,
        reward_type: 0x1::ascii::String,
        request_id: 0x2::object::ID,
        account: address,
        amount: u64,
    }

    struct Withdraw has copy, drop {
        vault_id: 0x2::object::ID,
        asset_type: 0x1::ascii::String,
        reward_type: 0x1::ascii::String,
        account: address,
        amount: u64,
    }

    struct ClaimReward has copy, drop {
        vault_id: 0x2::object::ID,
        asset_type: 0x1::ascii::String,
        reward_type: 0x1::ascii::String,
        account: address,
        amount: u64,
        cumulative_amount: u64,
    }

    struct StakeData<phantom T0, phantom T1> has store {
        unit: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double,
        stake_amount: u64,
        reward: 0x2::balance::Balance<T1>,
        cumulative_reward_amount: u64,
    }

    struct StakeDataDisplay has copy, drop {
        stake_coin_type: 0x1::ascii::String,
        reward_coin_type: 0x1::ascii::String,
        stake_amount: u64,
        claimable_reward_amount: u64,
        cumulative_reward_amount: u64,
    }

    struct WithdrawRequest has store {
        account: address,
        withdrawal_amount: u64,
        expected_withdrawal_time: u64,
        is_withdrawable: bool,
    }

    struct WithdrawRequestData has copy, drop {
        request_id: 0x2::object::ID,
        account: address,
        withdrawal_amount: u64,
        expected_withdrawal_time: u64,
        is_withdrawable: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RewardDistributor<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u16>,
        source: 0x2::balance::Balance<T1>,
        pool: 0x2::balance::Balance<T1>,
        stake: 0x2::balance::Balance<T0>,
        flow_rate: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double,
        stake_table: 0x2::table::Table<address, StakeData<T0, T1>>,
        unit: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double,
        timestamp: u64,
        managers: 0x2::vec_set::VecSet<address>,
        stake_cap: u64,
        total_earned_amount: u64,
        delay_ms: u64,
        withdraw_requests: 0x2::linked_table::LinkedTable<0x2::object::ID, WithdrawRequest>,
    }

    public fun new<T0, T1>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : RewardDistributor<T0, T1> {
        let v0 = RewardDistributor<T0, T1>{
            id                  : 0x2::object::new(arg3),
            versions            : 0x2::vec_set::singleton<u16>(package_version()),
            source              : 0x2::balance::zero<T1>(),
            pool                : 0x2::balance::zero<T1>(),
            stake               : 0x2::balance::zero<T0>(),
            flow_rate           : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::zero(),
            stake_table         : 0x2::table::new<address, StakeData<T0, T1>>(arg3),
            unit                : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from(0),
            timestamp           : 0,
            managers            : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg3)),
            stake_cap           : arg1,
            total_earned_amount : 0,
            delay_ms            : arg2,
            withdraw_requests   : 0x2::linked_table::new<0x2::object::ID, WithdrawRequest>(arg3),
        };
        let v1 = Create{
            vault_id    : id<T0, T1>(&v0),
            asset_type  : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            reward_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
        };
        0x2::event::emit<Create>(v1);
        v0
    }

    public fun id<T0, T1>(arg0: &RewardDistributor<T0, T1>) : 0x2::object::ID {
        0x2::object::id<RewardDistributor<T0, T1>>(arg0)
    }

    public fun add_manager<T0, T1>(arg0: &mut RewardDistributor<T0, T1>, arg1: &AdminCap, arg2: address) {
        assert_valid_package_version<T0, T1>(arg0);
        0x2::vec_set::insert<address>(&mut arg0.managers, arg2);
    }

    public fun add_version<T0, T1>(arg0: &mut RewardDistributor<T0, T1>, arg1: &AdminCap, arg2: u16) {
        0x2::vec_set::insert<u16>(&mut arg0.versions, arg2);
    }

    fun assert_sender_is_manager<T0, T1>(arg0: &RewardDistributor<T0, T1>, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest) {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1);
        if (!0x2::vec_set::contains<address>(&arg0.managers, &v0)) {
            err_sender_is_not_manager();
        };
    }

    fun assert_valid_package_version<T0, T1>(arg0: &RewardDistributor<T0, T1>) {
        let v0 = package_version();
        if (!0x2::vec_set::contains<u16>(&arg0.versions, &v0)) {
            err_invalid_package_version();
        };
    }

    public fun cancel_withdraw<T0, T1>(arg0: &mut RewardDistributor<T0, T1>, arg1: 0x2::object::ID, arg2: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest) {
        assert_valid_package_version<T0, T1>(arg0);
        if (!0x2::linked_table::contains<0x2::object::ID, WithdrawRequest>(withdraw_requests<T0, T1>(arg0), arg1)) {
            return
        };
        let WithdrawRequest {
            account                  : v0,
            withdrawal_amount        : v1,
            expected_withdrawal_time : _,
            is_withdrawable          : _,
        } = 0x2::linked_table::remove<0x2::object::ID, WithdrawRequest>(&mut arg0.withdraw_requests, arg1);
        if (v0 != 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg2)) {
            err_not_canceled_by_owner();
        };
        let v4 = CancelWithdraw{
            vault_id    : id<T0, T1>(arg0),
            asset_type  : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            reward_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            request_id  : arg1,
            account     : v0,
            amount      : v1,
        };
        0x2::event::emit<CancelWithdraw>(v4);
    }

    public fun claim<T0, T1>(arg0: &mut RewardDistributor<T0, T1>, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_valid_package_version<T0, T1>(arg0);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1);
        let v1 = id<T0, T1>(arg0);
        settle_reward<T0, T1>(arg0, v0, arg2);
        let v2 = stake_data_mut<T0, T1>(arg0, v0);
        let v3 = 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut v2.reward), arg3);
        let v4 = stake_data_mut<T0, T1>(arg0, v0);
        v4.cumulative_reward_amount = v4.cumulative_reward_amount + 0x2::coin::value<T1>(&v3);
        let v5 = ClaimReward{
            vault_id          : v1,
            asset_type        : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            reward_type       : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            account           : v0,
            amount            : 0x2::coin::value<T1>(&v3),
            cumulative_amount : v4.cumulative_reward_amount,
        };
        0x2::event::emit<ClaimReward>(v5);
        v3
    }

    public fun default<T0, T1>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<RewardDistributor<T0, T1>>(new<T0, T1>(arg0, arg1, arg2, arg3));
    }

    public fun delay_ms<T0, T1>(arg0: &RewardDistributor<T0, T1>) : u64 {
        arg0.delay_ms
    }

    public fun deposit<T0, T1>(arg0: &mut RewardDistributor<T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: address) {
        assert_valid_package_version<T0, T1>(arg0);
        source_to_pool<T0, T1>(arg0, arg1);
        settle_reward<T0, T1>(arg0, arg3, arg1);
        let v0 = stake_data_mut<T0, T1>(arg0, arg3);
        let v1 = 0x2::coin::value<T0>(&arg2);
        v0.stake_amount = v0.stake_amount + v1;
        if (v0.stake_amount > arg0.stake_cap) {
            err_exceed_deposit_cap();
        };
        0x2::balance::join<T0>(&mut arg0.stake, 0x2::coin::into_balance<T0>(arg2));
        let v2 = Deposit{
            vault_id    : id<T0, T1>(arg0),
            asset_type  : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            reward_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            account     : arg3,
            amount      : v1,
        };
        0x2::event::emit<Deposit>(v2);
    }

    public fun deposit_to_pool<T0, T1>(arg0: &mut RewardDistributor<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        assert_valid_package_version<T0, T1>(arg0);
        0x2::balance::join<T1>(&mut arg0.pool, 0x2::coin::into_balance<T1>(arg1));
    }

    public fun deposit_to_source<T0, T1>(arg0: &mut RewardDistributor<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        assert_valid_package_version<T0, T1>(arg0);
        arg0.total_earned_amount = arg0.total_earned_amount + 0x2::coin::value<T1>(&arg1);
        let v0 = RewardEarned{
            vault_id    : id<T0, T1>(arg0),
            asset_type  : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            reward_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            amount      : 0x2::coin::value<T1>(&arg1),
        };
        0x2::event::emit<RewardEarned>(v0);
        0x2::balance::join<T1>(&mut arg0.source, 0x2::coin::into_balance<T1>(arg1));
    }

    public fun deposit_to_source_by_manager<T0, T1>(arg0: &mut RewardDistributor<T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest) {
        deposit_to_source<T0, T1>(arg0, arg2);
        source_to_pool<T0, T1>(arg0, arg1);
        let v0 = 0x2::balance::value<T1>(&arg0.source);
        update_flow_rate<T0, T1>(arg0, arg1, v0, arg3, arg4);
    }

    fun err_exceed_deposit_cap() {
        abort 203
    }

    fun err_invalid_package_version() {
        abort 204
    }

    fun err_not_canceled_by_owner() {
        abort 205
    }

    fun err_sender_is_not_manager() {
        abort 202
    }

    fun err_withdraw_too_much() {
        abort 201
    }

    public fun execute_withdraw<T0, T1>(arg0: &mut RewardDistributor<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version<T0, T1>(arg0);
        assert_sender_is_manager<T0, T1>(arg0, arg2);
        if (!0x2::linked_table::contains<0x2::object::ID, WithdrawRequest>(withdraw_requests<T0, T1>(arg0), arg3)) {
            return
        };
        let WithdrawRequest {
            account                  : v0,
            withdrawal_amount        : v1,
            expected_withdrawal_time : v2,
            is_withdrawable          : v3,
        } = 0x2::linked_table::remove<0x2::object::ID, WithdrawRequest>(&mut arg0.withdraw_requests, arg3);
        if (!v3 || v2 > 0x2::clock::timestamp_ms(arg1)) {
            return
        };
        source_to_pool<T0, T1>(arg0, arg1);
        settle_reward<T0, T1>(arg0, v0, arg1);
        let v4 = stake_data_mut<T0, T1>(arg0, v0);
        let v5 = 0x1::u64::max(v1, v4.stake_amount);
        if (v5 > 0) {
            v4.stake_amount = v4.stake_amount - v5;
            let v6 = Withdraw{
                vault_id    : id<T0, T1>(arg0),
                asset_type  : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
                reward_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
                account     : v0,
                amount      : v5,
            };
            0x2::event::emit<Withdraw>(v6);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.stake, v5), arg4), v0);
        };
    }

    public fun get_stake_data<T0, T1>(arg0: &RewardDistributor<T0, T1>, arg1: address, arg2: &0x2::clock::Clock) : StakeDataDisplay {
        let v0 = stake_data<T0, T1>(arg0, arg1);
        StakeDataDisplay{
            stake_coin_type          : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            reward_coin_type         : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            stake_amount             : v0.stake_amount,
            claimable_reward_amount  : realtime_reward_amount<T0, T1>(arg0, arg1, arg2),
            cumulative_reward_amount : v0.cumulative_reward_amount,
        }
    }

    public fun get_withdraw_requests<T0, T1>(arg0: &RewardDistributor<T0, T1>, arg1: 0x1::option::Option<0x2::object::ID>, arg2: u64) : (vector<WithdrawRequestData>, 0x1::option::Option<0x2::object::ID>) {
        let v0 = 0x1::vector::empty<WithdrawRequestData>();
        let v1 = &arg0.withdraw_requests;
        if (0x1::option::is_none<0x2::object::ID>(&arg1)) {
            arg1 = *0x2::linked_table::front<0x2::object::ID, WithdrawRequest>(v1);
        };
        let v2 = 0;
        while (0x1::option::is_some<0x2::object::ID>(&arg1) && v2 < arg2) {
            let v3 = *0x1::option::borrow<0x2::object::ID>(&arg1);
            let v4 = 0x2::linked_table::borrow<0x2::object::ID, WithdrawRequest>(v1, v3);
            let v5 = WithdrawRequestData{
                request_id               : v3,
                account                  : v4.account,
                withdrawal_amount        : v4.withdrawal_amount,
                expected_withdrawal_time : v4.expected_withdrawal_time,
                is_withdrawable          : v4.is_withdrawable,
            };
            0x1::vector::push_back<WithdrawRequestData>(&mut v0, v5);
            v2 = v2 + 1;
            arg1 = *0x2::linked_table::next<0x2::object::ID, WithdrawRequest>(v1, v3);
        };
        (v0, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun new_request_id(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg0);
        0x2::object::delete(v0);
        0x2::object::uid_to_inner(&v0)
    }

    public fun package_version() : u16 {
        2
    }

    public fun realtime_reward_amount<T0, T1>(arg0: &RewardDistributor<T0, T1>, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        let v0 = if (stake_exists<T0, T1>(arg0, arg1)) {
            0x2::balance::value<T1>(&stake_data<T0, T1>(arg0, arg1).reward)
        } else {
            0
        };
        v0 + unsettled_reward_amount<T0, T1>(arg0, arg1, arg2)
    }

    fun realtime_rewarder_release_and_unit<T0, T1>(arg0: &RewardDistributor<T0, T1>, arg1: &0x2::clock::Clock) : (u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double) {
        let v0 = total_stake_amount<T0, T1>(arg0);
        if (v0 > 0) {
            let v3 = 0x1::u64::min(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::mul_u64(arg0.flow_rate, 0x2::clock::timestamp_ms(arg1) - arg0.timestamp)), 0x2::balance::value<T1>(&arg0.source));
            (v3, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::add(arg0.unit, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from_fraction(v3, v0)))
        } else {
            (0, arg0.unit)
        }
    }

    public fun remove_manager<T0, T1>(arg0: &mut RewardDistributor<T0, T1>, arg1: &AdminCap, arg2: address) {
        assert_valid_package_version<T0, T1>(arg0);
        0x2::vec_set::remove<address>(&mut arg0.managers, &arg2);
    }

    public fun remove_version<T0, T1>(arg0: &mut RewardDistributor<T0, T1>, arg1: &AdminCap, arg2: u16) {
        0x2::vec_set::remove<u16>(&mut arg0.versions, &arg2);
    }

    public fun request_withdraw<T0, T1>(arg0: &mut RewardDistributor<T0, T1>, arg1: &0x2::clock::Clock, arg2: u64, arg3: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg4: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version<T0, T1>(arg0);
        let v0 = new_request_id(arg4);
        let v1 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg3);
        let v2 = if (stake_exists<T0, T1>(arg0, v1)) {
            stake_data<T0, T1>(arg0, v1).stake_amount
        } else {
            0
        };
        if (v2 < arg2) {
            err_withdraw_too_much();
        };
        let v3 = 0x2::clock::timestamp_ms(arg1) + delay_ms<T0, T1>(arg0);
        let v4 = WithdrawRequest{
            account                  : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg3),
            withdrawal_amount        : arg2,
            expected_withdrawal_time : v3,
            is_withdrawable          : true,
        };
        let v5 = RequestWithdraw{
            vault_id                 : id<T0, T1>(arg0),
            asset_type               : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            reward_type              : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            request_id               : v0,
            account                  : v1,
            amount                   : arg2,
            expected_withdrawal_time : v3,
        };
        0x2::event::emit<RequestWithdraw>(v5);
        0x2::linked_table::push_back<0x2::object::ID, WithdrawRequest>(&mut arg0.withdraw_requests, v0, v4);
    }

    public fun set_delay_ms<T0, T1>(arg0: &mut RewardDistributor<T0, T1>, arg1: &AdminCap, arg2: u64) {
        assert_valid_package_version<T0, T1>(arg0);
        arg0.delay_ms = arg2;
    }

    public fun set_stake_cap<T0, T1>(arg0: &mut RewardDistributor<T0, T1>, arg1: &AdminCap, arg2: u64) {
        assert_valid_package_version<T0, T1>(arg0);
        arg0.stake_cap = arg2;
    }

    public fun set_withdrawable<T0, T1>(arg0: &mut RewardDistributor<T0, T1>, arg1: 0x2::object::ID, arg2: bool, arg3: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest) {
        assert_valid_package_version<T0, T1>(arg0);
        assert_sender_is_manager<T0, T1>(arg0, arg3);
        if (!0x2::linked_table::contains<0x2::object::ID, WithdrawRequest>(&arg0.withdraw_requests, arg1)) {
            return
        };
        0x2::linked_table::borrow_mut<0x2::object::ID, WithdrawRequest>(&mut arg0.withdraw_requests, arg1).is_withdrawable = arg2;
    }

    fun settle_reward<T0, T1>(arg0: &mut RewardDistributor<T0, T1>, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        source_to_pool<T0, T1>(arg0, arg2);
        let v0 = 0x2::balance::split<T1>(&mut arg0.pool, unsettled_reward_amount<T0, T1>(arg0, arg1, arg2));
        if (stake_exists<T0, T1>(arg0, arg1)) {
            let v2 = arg0.unit;
            let v3 = stake_data_mut<T0, T1>(arg0, arg1);
            v3.unit = v2;
            0x2::balance::join<T1>(&mut v3.reward, v0)
        } else {
            let v4 = StakeData<T0, T1>{
                unit                     : arg0.unit,
                stake_amount             : 0,
                reward                   : v0,
                cumulative_reward_amount : 0,
            };
            0x2::table::add<address, StakeData<T0, T1>>(&mut arg0.stake_table, arg1, v4);
            0x2::balance::value<T1>(&v0)
        }
    }

    fun source_to_pool<T0, T1>(arg0: &mut RewardDistributor<T0, T1>, arg1: &0x2::clock::Clock) {
        let (v0, v1) = realtime_rewarder_release_and_unit<T0, T1>(arg0, arg1);
        arg0.timestamp = 0x2::clock::timestamp_ms(arg1);
        arg0.unit = v1;
        0x2::balance::join<T1>(&mut arg0.pool, 0x2::balance::split<T1>(&mut arg0.source, v0));
    }

    fun stake_data<T0, T1>(arg0: &RewardDistributor<T0, T1>, arg1: address) : &StakeData<T0, T1> {
        0x2::table::borrow<address, StakeData<T0, T1>>(&arg0.stake_table, arg1)
    }

    fun stake_data_mut<T0, T1>(arg0: &mut RewardDistributor<T0, T1>, arg1: address) : &mut StakeData<T0, T1> {
        0x2::table::borrow_mut<address, StakeData<T0, T1>>(&mut arg0.stake_table, arg1)
    }

    public fun stake_exists<T0, T1>(arg0: &RewardDistributor<T0, T1>, arg1: address) : bool {
        0x2::table::contains<address, StakeData<T0, T1>>(&arg0.stake_table, arg1)
    }

    public fun total_stake_amount<T0, T1>(arg0: &RewardDistributor<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.stake)
    }

    fun unsettled_reward_amount<T0, T1>(arg0: &RewardDistributor<T0, T1>, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        if (stake_exists<T0, T1>(arg0, arg1)) {
            let (v1, v2) = realtime_rewarder_release_and_unit<T0, T1>(arg0, arg2);
            let v3 = stake_data<T0, T1>(arg0, arg1);
            0x1::u64::min(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::sub(v2, v3.unit), v3.stake_amount)), v1 + 0x2::balance::value<T1>(&arg0.pool))
        } else {
            0
        }
    }

    public fun update_flow_rate<T0, T1>(arg0: &mut RewardDistributor<T0, T1>, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest) {
        assert_valid_package_version<T0, T1>(arg0);
        assert_sender_is_manager<T0, T1>(arg0, arg4);
        source_to_pool<T0, T1>(arg0, arg1);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from_fraction(arg2, arg3);
        arg0.flow_rate = v0;
        let v1 = UpdateFlowRate{
            vault_id    : id<T0, T1>(arg0),
            asset_type  : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            reward_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            flow_rate   : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::to_scaled_val(v0),
        };
        0x2::event::emit<UpdateFlowRate>(v1);
    }

    public fun withdraw_from_source<T0, T1>(arg0: &mut RewardDistributor<T0, T1>, arg1: &AdminCap, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_valid_package_version<T0, T1>(arg0);
        source_to_pool<T0, T1>(arg0, arg2);
        arg0.total_earned_amount = arg0.total_earned_amount - arg3;
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.source, arg3), arg4)
    }

    public fun withdraw_requests<T0, T1>(arg0: &RewardDistributor<T0, T1>) : &0x2::linked_table::LinkedTable<0x2::object::ID, WithdrawRequest> {
        &arg0.withdraw_requests
    }

    // decompiled from Move bytecode v6
}

