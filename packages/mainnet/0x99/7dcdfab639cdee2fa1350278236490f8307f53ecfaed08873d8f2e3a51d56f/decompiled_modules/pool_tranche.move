module 0x997dcdfab639cdee2fa1350278236490f8307f53ecfaed08873d8f2e3a51d56f::pool_tranche {
    struct SuperAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PoolTrancheManager has store, key {
        id: 0x2::object::UID,
        version: u64,
        admins: 0x2::vec_set::VecSet<address>,
        pool_tranches: 0x2::table::Table<0x2::object::ID, vector<PoolTranche>>,
        whitelisted_tokens: 0x2::table::Table<0x1::type_name::TypeName, bool>,
        ignore_whitelist: bool,
        osail_epoch: 0x2::table::Table<u64, 0x1::type_name::TypeName>,
        bag: 0x2::bag::Bag,
    }

    struct PoolTranche has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        rewards_balance: 0x2::bag::Bag,
        total_balance_epoch: 0x2::table::Table<u64, 0x2::table::Table<0x1::type_name::TypeName, u64>>,
        total_income_epoch: 0x2::table::Table<u64, u64>,
        claimed_rewards: 0x2::table::Table<0x2::object::ID, 0x2::table::Table<u64, 0x2::table::Table<0x1::type_name::TypeName, bool>>>,
        volume_in_coin_a: bool,
        total_volume: u128,
        current_volume: u128,
        filled: bool,
        minimum_remaining_volume_percentage: u64,
        duration_profitabilities: vector<u64>,
        bag: 0x2::bag::Bag,
    }

    struct InitTrancheManagerEvent has copy, drop {
        tranche_manager_id: 0x2::object::ID,
    }

    struct SetIgnoreWhitelistEvent has copy, drop {
        ignore_whitelist: bool,
    }

    struct UpdateTotalIncomeEpochEvent has copy, drop {
        tranche_id: 0x2::object::ID,
        epoch_start: u64,
        total_income: u64,
    }

    struct AddTokenTypeToWhitelistEvent has copy, drop {
        token_type: 0x1::type_name::TypeName,
    }

    struct RemoveTokenTypeFromWhitelistEvent has copy, drop {
        token_type: 0x1::type_name::TypeName,
    }

    struct CreatePoolTrancheEvent has copy, drop {
        tranche_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        volume_in_coin_a: bool,
        total_volume: u128,
        duration_profitabilities: vector<u64>,
        minimum_remaining_volume_percentage: u64,
        index: u64,
    }

    struct UpdateTrancheEvent has copy, drop {
        tranche_id: 0x2::object::ID,
        volume_in_coin_a: bool,
        total_volume: u128,
        duration_profitabilities: vector<u64>,
        minimum_remaining_volume_percentage: u64,
    }

    struct FillTrancheEvent has copy, drop {
        tranche_id: 0x2::object::ID,
        current_volume: u128,
        filled: bool,
    }

    struct AddRewardEvent has copy, drop {
        tranche_id: 0x2::object::ID,
        epoch_start: u64,
        reward_type: 0x1::type_name::TypeName,
        balance_value: u64,
        after_amount: u64,
    }

    struct SetIncomeEvent has copy, drop {
        tranche_id: 0x2::object::ID,
        epoch_start: u64,
        total_income: u64,
        osail_epoch: 0x1::type_name::TypeName,
    }

    struct UpdateOSailEpochEvent has copy, drop {
        epoch_start: u64,
        osail_epoch: 0x1::type_name::TypeName,
    }

    struct GetRewardEvent has copy, drop {
        tranche_id: 0x2::object::ID,
        epoch_start: u64,
        reward_type: 0x1::type_name::TypeName,
        reward_amount: u64,
    }

    public fun new<T0, T1>(arg0: &mut PoolTrancheManager, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg2: bool, arg3: u128, arg4: vector<u64>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_admin(arg0, 0x2::tx_context::sender(arg6));
        let v0 = 0x2::object::id<0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>>(arg1);
        let v1 = PoolTranche{
            id                                  : 0x2::object::new(arg6),
            pool_id                             : v0,
            rewards_balance                     : 0x2::bag::new(arg6),
            total_balance_epoch                 : 0x2::table::new<u64, 0x2::table::Table<0x1::type_name::TypeName, u64>>(arg6),
            total_income_epoch                  : 0x2::table::new<u64, u64>(arg6),
            claimed_rewards                     : 0x2::table::new<0x2::object::ID, 0x2::table::Table<u64, 0x2::table::Table<0x1::type_name::TypeName, bool>>>(arg6),
            volume_in_coin_a                    : arg2,
            total_volume                        : arg3,
            current_volume                      : 0,
            filled                              : false,
            minimum_remaining_volume_percentage : arg5,
            duration_profitabilities            : arg4,
            bag                                 : 0x2::bag::new(arg6),
        };
        if (!0x2::table::contains<0x2::object::ID, vector<PoolTranche>>(&arg0.pool_tranches, v0)) {
            0x2::table::add<0x2::object::ID, vector<PoolTranche>>(&mut arg0.pool_tranches, v0, 0x1::vector::empty<PoolTranche>());
        };
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, vector<PoolTranche>>(&mut arg0.pool_tranches, v0);
        0x1::vector::push_back<PoolTranche>(v2, v1);
        let v3 = CreatePoolTrancheEvent{
            tranche_id                          : 0x2::object::id<PoolTranche>(&v1),
            pool_id                             : v0,
            volume_in_coin_a                    : arg2,
            total_volume                        : arg3,
            duration_profitabilities            : arg4,
            minimum_remaining_volume_percentage : arg5,
            index                               : 0x1::vector::length<PoolTranche>(v2) - 1,
        };
        0x2::event::emit<CreatePoolTrancheEvent>(v3);
    }

    public fun add_admin(arg0: &SuperAdminCap, arg1: &mut PoolTrancheManager, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg1);
        check_admin(arg1, 0x2::tx_context::sender(arg3));
        assert!(!0x2::vec_set::contains<address>(&arg1.admins, &arg2), 913497842032463613);
        0x2::vec_set::insert<address>(&mut arg1.admins, arg2);
    }

    public fun add_reward<T0>(arg0: &mut PoolTrancheManager, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: 0x2::balance::Balance<T0>, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        checked_package_version(arg0);
        check_admin(arg0, 0x2::tx_context::sender(arg5));
        assert!(arg0.ignore_whitelist || 0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.whitelisted_tokens, 0x1::type_name::get<T0>()), 932069230794534963);
        let v0 = get_tranche_by_id(arg0, arg1, arg2);
        add_reward_internal<T0>(v0, 0x997dcdfab639cdee2fa1350278236490f8307f53ecfaed08873d8f2e3a51d56f::time_manager::epoch_start(arg3), arg4, arg5)
    }

    fun add_reward_internal<T0>(arg0: &mut PoolTranche, arg1: u64, arg2: 0x2::balance::Balance<T0>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::balance::value<T0>(&arg2);
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.rewards_balance, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.rewards_balance, v0, 0x2::balance::zero<T0>());
        };
        let v2 = 0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.rewards_balance, v0), arg2);
        if (!0x2::table::contains<u64, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&arg0.total_balance_epoch, arg1)) {
            0x2::table::add<u64, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&mut arg0.total_balance_epoch, arg1, 0x2::table::new<0x1::type_name::TypeName, u64>(arg3));
        };
        if (!0x2::table::contains<0x1::type_name::TypeName, u64>(0x2::table::borrow<u64, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&arg0.total_balance_epoch, arg1), v0)) {
            0x2::table::add<0x1::type_name::TypeName, u64>(0x2::table::borrow_mut<u64, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&mut arg0.total_balance_epoch, arg1), v0, 0);
        };
        *0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(0x2::table::borrow_mut<u64, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&mut arg0.total_balance_epoch, arg1), v0) = *0x2::table::borrow<0x1::type_name::TypeName, u64>(0x2::table::borrow<u64, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&arg0.total_balance_epoch, arg1), v0) + v1;
        let v3 = AddRewardEvent{
            tranche_id    : 0x2::object::id<PoolTranche>(arg0),
            epoch_start   : arg1,
            reward_type   : v0,
            balance_value : v1,
            after_amount  : v2,
        };
        0x2::event::emit<AddRewardEvent>(v3);
        v2
    }

    public fun add_token_types_to_whitelist(arg0: &mut PoolTrancheManager, arg1: vector<0x1::type_name::TypeName>, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_admin(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(&arg1)) {
            let v1 = *0x1::vector::borrow<0x1::type_name::TypeName>(&arg1, v0);
            if (!0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.whitelisted_tokens, v1)) {
                0x2::table::add<0x1::type_name::TypeName, bool>(&mut arg0.whitelisted_tokens, v1, true);
                let v2 = AddTokenTypeToWhitelistEvent{token_type: v1};
                0x2::event::emit<AddTokenTypeToWhitelistEvent>(v2);
            };
            v0 = v0 + 1;
        };
    }

    public fun check_admin(arg0: &PoolTrancheManager, arg1: address) {
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &arg1), 9389469239702349);
    }

    public fun checked_package_version(arg0: &PoolTrancheManager) {
        assert!(arg0.version == 1, 945973054793406234);
    }

    public(friend) fun fill_tranches(arg0: &mut PoolTranche, arg1: u128) {
        assert!(!arg0.filled, 92357345723427311);
        assert!(arg0.current_volume + arg1 <= arg0.total_volume, 923487825237423743);
        arg0.current_volume = arg0.current_volume + arg1;
        if (arg0.current_volume == arg0.total_volume || 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u128::mul_div_round(arg0.total_volume, (arg0.minimum_remaining_volume_percentage as u128), (0x997dcdfab639cdee2fa1350278236490f8307f53ecfaed08873d8f2e3a51d56f::consts::minimum_remaining_volume_percentage_denom() as u128)) >= arg0.total_volume - arg0.current_volume) {
            arg0.filled = true;
        };
        let v0 = FillTrancheEvent{
            tranche_id     : 0x2::object::id<PoolTranche>(arg0),
            current_volume : arg0.current_volume,
            filled         : arg0.filled,
        };
        0x2::event::emit<FillTrancheEvent>(v0);
    }

    public fun get_balance_amount<T0>(arg0: &mut PoolTrancheManager, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : u64 {
        let v0 = get_tranche_by_id(arg0, arg1, arg2);
        let v1 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&v0.rewards_balance, v1)) {
            return 0
        };
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&v0.rewards_balance, v1))
    }

    public fun get_duration_profitabilities(arg0: &PoolTranche) : vector<u64> {
        arg0.duration_profitabilities
    }

    public fun get_free_volume(arg0: &PoolTranche) : (u128, bool) {
        (arg0.total_volume - arg0.current_volume, arg0.volume_in_coin_a)
    }

    public fun get_ignore_whitelist_flag(arg0: &PoolTrancheManager) : bool {
        arg0.ignore_whitelist
    }

    public fun get_osail_epoch(arg0: &PoolTrancheManager, arg1: u64) : &0x1::type_name::TypeName {
        assert!(0x2::table::contains<u64, 0x1::type_name::TypeName>(&arg0.osail_epoch, arg1), 940709547884708027);
        0x2::table::borrow<u64, 0x1::type_name::TypeName>(&arg0.osail_epoch, arg1)
    }

    public(friend) fun get_reward_balance<T0>(arg0: &mut PoolTrancheManager, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        checked_package_version(arg0);
        let v0 = get_tranche_by_id(arg0, arg1, arg2);
        let v1 = 0x997dcdfab639cdee2fa1350278236490f8307f53ecfaed08873d8f2e3a51d56f::time_manager::epoch_start(arg5);
        let v2 = 0x1::type_name::get<T0>();
        let v3 = if (!0x2::table::contains<0x2::object::ID, 0x2::table::Table<u64, 0x2::table::Table<0x1::type_name::TypeName, bool>>>(&v0.claimed_rewards, arg3)) {
            true
        } else if (!0x2::table::contains<u64, 0x2::table::Table<0x1::type_name::TypeName, bool>>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<u64, 0x2::table::Table<0x1::type_name::TypeName, bool>>>(&v0.claimed_rewards, arg3), v1)) {
            true
        } else {
            !0x2::table::contains<0x1::type_name::TypeName, bool>(0x2::table::borrow<u64, 0x2::table::Table<0x1::type_name::TypeName, bool>>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<u64, 0x2::table::Table<0x1::type_name::TypeName, bool>>>(&v0.claimed_rewards, arg3), v1), v2)
        };
        assert!(v3, 930267340729430623);
        let v4 = if (0x2::table::contains<u64, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&v0.total_balance_epoch, v1)) {
            if (0x2::table::contains<0x1::type_name::TypeName, u64>(0x2::table::borrow<u64, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&v0.total_balance_epoch, v1), v2)) {
                if (*0x2::table::borrow<0x1::type_name::TypeName, u64>(0x2::table::borrow<u64, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&v0.total_balance_epoch, v1), v2) > 0) {
                    0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&v0.rewards_balance, v2)) > 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, 91235834582491043);
        assert!(*0x2::table::borrow<u64, u64>(&v0.total_income_epoch, v1) >= arg4, 93976047920347034);
        let v5 = 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u64::mul_div_floor(*0x2::table::borrow<0x1::type_name::TypeName, u64>(0x2::table::borrow<u64, 0x2::table::Table<0x1::type_name::TypeName, u64>>(&v0.total_balance_epoch, v1), v2), arg4, *0x2::table::borrow<u64, u64>(&v0.total_income_epoch, v1));
        let v6 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0.rewards_balance, v2);
        assert!(v5 <= 0x2::balance::value<T0>(v6), 91294503453406623);
        if (!0x2::table::contains<0x2::object::ID, 0x2::table::Table<u64, 0x2::table::Table<0x1::type_name::TypeName, bool>>>(&v0.claimed_rewards, arg3)) {
            0x2::table::add<0x2::object::ID, 0x2::table::Table<u64, 0x2::table::Table<0x1::type_name::TypeName, bool>>>(&mut v0.claimed_rewards, arg3, 0x2::table::new<u64, 0x2::table::Table<0x1::type_name::TypeName, bool>>(arg6));
        };
        if (!0x2::table::contains<u64, 0x2::table::Table<0x1::type_name::TypeName, bool>>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<u64, 0x2::table::Table<0x1::type_name::TypeName, bool>>>(&v0.claimed_rewards, arg3), v1)) {
            0x2::table::add<u64, 0x2::table::Table<0x1::type_name::TypeName, bool>>(0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<u64, 0x2::table::Table<0x1::type_name::TypeName, bool>>>(&mut v0.claimed_rewards, arg3), v1, 0x2::table::new<0x1::type_name::TypeName, bool>(arg6));
        };
        if (!0x2::table::contains<0x1::type_name::TypeName, bool>(0x2::table::borrow<u64, 0x2::table::Table<0x1::type_name::TypeName, bool>>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<u64, 0x2::table::Table<0x1::type_name::TypeName, bool>>>(&v0.claimed_rewards, arg3), v1), v2)) {
            0x2::table::add<0x1::type_name::TypeName, bool>(0x2::table::borrow_mut<u64, 0x2::table::Table<0x1::type_name::TypeName, bool>>(0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<u64, 0x2::table::Table<0x1::type_name::TypeName, bool>>>(&mut v0.claimed_rewards, arg3), v1), v2, true);
        } else {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, bool>(0x2::table::borrow_mut<u64, 0x2::table::Table<0x1::type_name::TypeName, bool>>(0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<u64, 0x2::table::Table<0x1::type_name::TypeName, bool>>>(&mut v0.claimed_rewards, arg3), v1), v2) = true;
        };
        let v7 = GetRewardEvent{
            tranche_id    : arg2,
            epoch_start   : v1,
            reward_type   : v2,
            reward_amount : v5,
        };
        0x2::event::emit<GetRewardEvent>(v7);
        0x2::balance::split<T0>(v6, v5)
    }

    fun get_tranche_by_id(arg0: &mut PoolTrancheManager, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : &mut PoolTranche {
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, vector<PoolTranche>>(&mut arg0.pool_tranches, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<PoolTranche>(v0)) {
            let v2 = 0x1::vector::borrow_mut<PoolTranche>(v0, v1);
            if (arg2 == 0x2::object::id<PoolTranche>(v2)) {
                return v2
            };
            v1 = v1 + 1;
        };
        abort 923487825237452354
    }

    public(friend) fun get_tranches(arg0: &mut PoolTrancheManager, arg1: 0x2::object::ID) : &mut vector<PoolTranche> {
        0x2::table::borrow_mut<0x2::object::ID, vector<PoolTranche>>(&mut arg0.pool_tranches, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolTrancheManager{
            id                 : 0x2::object::new(arg0),
            version            : 1,
            admins             : 0x2::vec_set::empty<address>(),
            pool_tranches      : 0x2::table::new<0x2::object::ID, vector<PoolTranche>>(arg0),
            whitelisted_tokens : 0x2::table::new<0x1::type_name::TypeName, bool>(arg0),
            ignore_whitelist   : false,
            osail_epoch        : 0x2::table::new<u64, 0x1::type_name::TypeName>(arg0),
            bag                : 0x2::bag::new(arg0),
        };
        0x2::vec_set::insert<address>(&mut v0.admins, 0x2::tx_context::sender(arg0));
        let v1 = SuperAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SuperAdminCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<PoolTrancheManager>(v0);
        let v2 = InitTrancheManagerEvent{tranche_manager_id: 0x2::object::id<PoolTrancheManager>(&v0)};
        0x2::event::emit<InitTrancheManagerEvent>(v2);
    }

    public fun is_admin(arg0: &PoolTrancheManager, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.admins, &arg1)
    }

    public fun is_filled(arg0: &PoolTranche) : bool {
        arg0.filled
    }

    public fun is_token_whitelisted(arg0: &PoolTrancheManager, arg1: 0x1::type_name::TypeName) : bool {
        0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.whitelisted_tokens, arg1)
    }

    public fun remove_token_types_from_whitelist(arg0: &mut PoolTrancheManager, arg1: vector<0x1::type_name::TypeName>, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_admin(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(&arg1)) {
            let v1 = *0x1::vector::borrow<0x1::type_name::TypeName>(&arg1, v0);
            if (0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.whitelisted_tokens, v1)) {
                0x2::table::remove<0x1::type_name::TypeName, bool>(&mut arg0.whitelisted_tokens, v1);
                let v2 = RemoveTokenTypeFromWhitelistEvent{token_type: v1};
                0x2::event::emit<RemoveTokenTypeFromWhitelistEvent>(v2);
            };
            v0 = v0 + 1;
        };
    }

    public fun revoke_admin(arg0: &SuperAdminCap, arg1: &mut PoolTrancheManager, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg1);
        check_admin(arg1, 0x2::tx_context::sender(arg3));
        assert!(0x2::vec_set::contains<address>(&arg1.admins, &arg2), 913497842032463613);
        0x2::vec_set::remove<address>(&mut arg1.admins, &arg2);
    }

    public fun set_ignore_whitelist(arg0: &mut PoolTrancheManager, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_admin(arg0, 0x2::tx_context::sender(arg2));
        arg0.ignore_whitelist = arg1;
        let v0 = SetIgnoreWhitelistEvent{ignore_whitelist: arg1};
        0x2::event::emit<SetIgnoreWhitelistEvent>(v0);
    }

    public fun set_total_incomed_and_add_reward<T0, T1>(arg0: &mut PoolTrancheManager, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: 0x2::balance::Balance<T1>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        checked_package_version(arg0);
        check_admin(arg0, 0x2::tx_context::sender(arg6));
        let v0 = 0x997dcdfab639cdee2fa1350278236490f8307f53ecfaed08873d8f2e3a51d56f::time_manager::epoch_start(arg3);
        let v1 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<u64, 0x1::type_name::TypeName>(&arg0.osail_epoch, v0)) {
            0x2::table::add<u64, 0x1::type_name::TypeName>(&mut arg0.osail_epoch, v0, v1);
        };
        assert!(arg0.ignore_whitelist || 0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.whitelisted_tokens, 0x1::type_name::get<T1>()), 932069230794534963);
        let v2 = get_tranche_by_id(arg0, arg1, arg2);
        assert!(!0x2::table::contains<u64, u64>(&v2.total_income_epoch, v0), 932078340620346346);
        0x2::table::add<u64, u64>(&mut v2.total_income_epoch, v0, arg5);
        let v3 = SetIncomeEvent{
            tranche_id   : arg2,
            epoch_start  : v0,
            total_income : arg5,
            osail_epoch  : v1,
        };
        0x2::event::emit<SetIncomeEvent>(v3);
        add_reward_internal<T1>(v2, v0, arg4, arg6)
    }

    public fun update_osail_epoch<T0>(arg0: &mut PoolTrancheManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_admin(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<u64, 0x1::type_name::TypeName>(&arg0.osail_epoch, arg1)) {
            0x2::table::remove<u64, 0x1::type_name::TypeName>(&mut arg0.osail_epoch, arg1);
        };
        0x2::table::add<u64, 0x1::type_name::TypeName>(&mut arg0.osail_epoch, arg1, v0);
        let v1 = UpdateOSailEpochEvent{
            epoch_start : arg1,
            osail_epoch : v0,
        };
        0x2::event::emit<UpdateOSailEpochEvent>(v1);
    }

    public fun update_total_income_epoch(arg0: &mut PoolTrancheManager, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_admin(arg0, 0x2::tx_context::sender(arg5));
        let v0 = 0x997dcdfab639cdee2fa1350278236490f8307f53ecfaed08873d8f2e3a51d56f::time_manager::epoch_start(arg3);
        let v1 = get_tranche_by_id(arg0, arg1, arg2);
        if (0x2::table::contains<u64, u64>(&v1.total_income_epoch, v0)) {
            0x2::table::remove<u64, u64>(&mut v1.total_income_epoch, v0);
        };
        0x2::table::add<u64, u64>(&mut v1.total_income_epoch, v0, arg4);
        let v2 = UpdateTotalIncomeEpochEvent{
            tranche_id   : arg2,
            epoch_start  : v0,
            total_income : arg4,
        };
        0x2::event::emit<UpdateTotalIncomeEpochEvent>(v2);
    }

    public fun update_tranche(arg0: &mut PoolTrancheManager, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: bool, arg4: u128, arg5: vector<u64>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        check_admin(arg0, 0x2::tx_context::sender(arg7));
        let v0 = get_tranche_by_id(arg0, arg1, arg2);
        assert!(!v0.filled, 909797676721269952);
        v0.volume_in_coin_a = arg3;
        v0.total_volume = arg4;
        v0.duration_profitabilities = arg5;
        v0.minimum_remaining_volume_percentage = arg6;
        let v1 = UpdateTrancheEvent{
            tranche_id                          : arg2,
            volume_in_coin_a                    : arg3,
            total_volume                        : arg4,
            duration_profitabilities            : arg5,
            minimum_remaining_volume_percentage : arg6,
        };
        0x2::event::emit<UpdateTrancheEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

