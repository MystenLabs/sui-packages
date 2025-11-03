module 0xab54f551967677dbd179e2dd3d5dd3af985c65b5dd65e53998b96e510dce5a5f::lake_vault {
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

    struct Deposit has copy, drop {
        vault_id: 0x2::object::ID,
        asset_type: 0x1::ascii::String,
        reward_type: 0x1::ascii::String,
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

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LakeVault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        source: 0x2::balance::Balance<T1>,
        pool: 0x2::balance::Balance<T1>,
        stake: 0x2::balance::Balance<T0>,
        flow_rate: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double,
        stake_table: 0x2::table::Table<address, StakeData<T0, T1>>,
        unit: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double,
        timestamp: u64,
        managers: 0x2::vec_set::VecSet<address>,
    }

    public fun id<T0, T1>(arg0: &LakeVault<T0, T1>) : 0x2::object::ID {
        0x2::object::id<LakeVault<T0, T1>>(arg0)
    }

    public fun new<T0, T1>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : LakeVault<T0, T1> {
        let v0 = LakeVault<T0, T1>{
            id          : 0x2::object::new(arg1),
            source      : 0x2::balance::zero<T1>(),
            pool        : 0x2::balance::zero<T1>(),
            stake       : 0x2::balance::zero<T0>(),
            flow_rate   : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::zero(),
            stake_table : 0x2::table::new<address, StakeData<T0, T1>>(arg1),
            unit        : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from(0),
            timestamp   : 0,
            managers    : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg1)),
        };
        let v1 = Create{
            vault_id    : id<T0, T1>(&v0),
            asset_type  : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            reward_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
        };
        0x2::event::emit<Create>(v1);
        v0
    }

    public fun add_manager<T0, T1>(arg0: &mut LakeVault<T0, T1>, arg1: &AdminCap, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg0.managers, arg2);
    }

    fun assert_sender_is_manager<T0, T1>(arg0: &LakeVault<T0, T1>, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest) {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1);
        if (!0x2::vec_set::contains<address>(&arg0.managers, &v0)) {
            err_sender_is_not_manager();
        };
    }

    public fun claim<T0, T1>(arg0: &mut LakeVault<T0, T1>, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
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

    public fun default<T0, T1>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<LakeVault<T0, T1>>(new<T0, T1>(arg0, arg1));
    }

    public fun deposit<T0, T1>(arg0: &mut LakeVault<T0, T1>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: address) {
        source_to_pool<T0, T1>(arg0, arg1);
        settle_reward<T0, T1>(arg0, arg3, arg1);
        let v0 = stake_data_mut<T0, T1>(arg0, arg3);
        let v1 = 0x2::coin::value<T0>(&arg2);
        v0.stake_amount = v0.stake_amount + v1;
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

    public fun deposit_to_pool<T0, T1>(arg0: &mut LakeVault<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        0x2::balance::join<T1>(&mut arg0.pool, 0x2::coin::into_balance<T1>(arg1));
    }

    public fun deposit_to_source<T0, T1>(arg0: &mut LakeVault<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        0x2::balance::join<T1>(&mut arg0.source, 0x2::coin::into_balance<T1>(arg1));
    }

    fun err_sender_is_not_manager() {
        abort 202
    }

    fun err_withdraw_too_much() {
        abort 201
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun package_version() : u16 {
        1
    }

    public fun realtime_reward_amount<T0, T1>(arg0: &LakeVault<T0, T1>, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        let v0 = if (stake_exists<T0, T1>(arg0, arg1)) {
            0x2::balance::value<T1>(&stake_data<T0, T1>(arg0, arg1).reward)
        } else {
            0
        };
        v0 + unsettled_reward_amount<T0, T1>(arg0, arg1, arg2)
    }

    fun realtime_rewarder_release_and_unit<T0, T1>(arg0: &LakeVault<T0, T1>, arg1: &0x2::clock::Clock) : (u64, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double) {
        let v0 = total_stake_amount<T0, T1>(arg0);
        if (v0 > 0) {
            let v3 = 0x1::u64::min(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::mul_u64(arg0.flow_rate, 0x2::clock::timestamp_ms(arg1) - arg0.timestamp)), 0x2::balance::value<T1>(&arg0.source));
            (v3, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::add(arg0.unit, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from_fraction(v3, v0)))
        } else {
            (0, arg0.unit)
        }
    }

    public fun remove_manager<T0, T1>(arg0: &mut LakeVault<T0, T1>, arg1: &AdminCap, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg0.managers, &arg2);
    }

    fun settle_reward<T0, T1>(arg0: &mut LakeVault<T0, T1>, arg1: address, arg2: &0x2::clock::Clock) : u64 {
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

    fun source_to_pool<T0, T1>(arg0: &mut LakeVault<T0, T1>, arg1: &0x2::clock::Clock) {
        let (v0, v1) = realtime_rewarder_release_and_unit<T0, T1>(arg0, arg1);
        arg0.timestamp = 0x2::clock::timestamp_ms(arg1);
        arg0.unit = v1;
        0x2::balance::join<T1>(&mut arg0.pool, 0x2::balance::split<T1>(&mut arg0.source, v0));
    }

    fun stake_data<T0, T1>(arg0: &LakeVault<T0, T1>, arg1: address) : &StakeData<T0, T1> {
        0x2::table::borrow<address, StakeData<T0, T1>>(&arg0.stake_table, arg1)
    }

    fun stake_data_mut<T0, T1>(arg0: &mut LakeVault<T0, T1>, arg1: address) : &mut StakeData<T0, T1> {
        0x2::table::borrow_mut<address, StakeData<T0, T1>>(&mut arg0.stake_table, arg1)
    }

    public fun stake_exists<T0, T1>(arg0: &LakeVault<T0, T1>, arg1: address) : bool {
        0x2::table::contains<address, StakeData<T0, T1>>(&arg0.stake_table, arg1)
    }

    public fun total_stake_amount<T0, T1>(arg0: &LakeVault<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.stake)
    }

    fun unsettled_reward_amount<T0, T1>(arg0: &LakeVault<T0, T1>, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        if (stake_exists<T0, T1>(arg0, arg1)) {
            let (v1, v2) = realtime_rewarder_release_and_unit<T0, T1>(arg0, arg2);
            let (v3, v4) = if (stake_exists<T0, T1>(arg0, arg1)) {
                let v5 = stake_data<T0, T1>(arg0, arg1);
                (v5.unit, v5.stake_amount)
            } else {
                (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from(0), 0)
            };
            0x1::u64::min(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::sub(v2, v3), v4)), v1 + 0x2::balance::value<T1>(&arg0.pool))
        } else {
            0
        }
    }

    public fun update_flow_rate<T0, T1>(arg0: &mut LakeVault<T0, T1>, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest) {
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

    public fun withdraw<T0, T1>(arg0: &mut LakeVault<T0, T1>, arg1: &0x2::clock::Clock, arg2: u64, arg3: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg3);
        source_to_pool<T0, T1>(arg0, arg1);
        settle_reward<T0, T1>(arg0, v0, arg1);
        let v1 = stake_data_mut<T0, T1>(arg0, v0);
        if (arg2 > v1.stake_amount) {
            err_withdraw_too_much();
        };
        v1.stake_amount = v1.stake_amount - arg2;
        let v2 = Withdraw{
            vault_id    : id<T0, T1>(arg0),
            asset_type  : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            reward_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            account     : v0,
            amount      : arg2,
        };
        0x2::event::emit<Withdraw>(v2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.stake, arg2), arg4)
    }

    public fun withdraw_from_source<T0, T1>(arg0: &mut LakeVault<T0, T1>, arg1: &AdminCap, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        source_to_pool<T0, T1>(arg0, arg2);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.source, arg3), arg4)
    }

    // decompiled from Move bytecode v6
}

