module 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::timelock {
    struct TimelockCanceled<phantom T0> has copy, drop {
        sender: address,
        timelock_id: 0x2::object::ID,
        timelock_owner: address,
        funder: address,
        canceled_amount: u64,
        paid_amount: u64,
        reclaimer: address,
    }

    struct TimelockClaimed<phantom T0> has copy, drop {
        sender: address,
        timelock_id: 0x2::object::ID,
        funder: address,
        amount: u64,
    }

    struct TimelockForceClaimed<phantom T0> has copy, drop {
        sender: address,
        timelock_id: 0x2::object::ID,
        timelock_owner: address,
        funder: address,
        amount: u64,
    }

    struct TimelockOwnerChanged<phantom T0> has copy, drop {
        sender: address,
        timelock_id: 0x2::object::ID,
        old_owner: address,
        new_owner: address,
        funder: address,
    }

    struct Timelock<phantom T0> has key {
        id: 0x2::object::UID,
        release_schedule: 0x2::object::ID,
        schedule_config: 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::schedule_config::ScheduleConfig,
        owner: address,
        funder: address,
        commencement_timestamp: u64,
        tokens_transferred: u64,
        total_amount: u64,
        left_balance: 0x2::balance::Balance<T0>,
        canceled_at: 0x1::option::Option<u64>,
        versioning: 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::versioning::Versioning,
    }

    struct FundScheduleAbility has drop {
        dummy_field: bool,
    }

    struct ForceFundScheduleAbility has drop {
        dummy_field: bool,
    }

    struct TimelockCancelAbility has drop {
        dummy_field: bool,
    }

    struct ForceClaimAbility has drop {
        dummy_field: bool,
    }

    struct SetTimelockOwnerAbility has drop {
        dummy_field: bool,
    }

    struct ReleaseScheduleFunded<phantom T0> has copy, drop {
        sender: address,
        recipient: address,
        schedule_id: 0x2::object::ID,
        amount: u64,
        commencement_timestamp: u64,
        timelock_id: 0x2::object::ID,
    }

    public fun destroy_empty<T0>(arg0: Timelock<T0>, arg1: &0x2::tx_context::TxContext) : (0x2::object::ID, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::schedule_config::ScheduleConfig, address, address, u64, u64, u64) {
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::versioning::assert_is_valid_version(&arg0.versioning);
        let Timelock {
            id                     : v0,
            release_schedule       : v1,
            schedule_config        : v2,
            owner                  : v3,
            funder                 : v4,
            commencement_timestamp : v5,
            tokens_transferred     : v6,
            total_amount           : v7,
            left_balance           : v8,
            canceled_at            : _,
            versioning             : _,
        } = arg0;
        assert!(v4 == 0x2::tx_context::sender(arg1), 5);
        0x2::balance::destroy_zero<T0>(v8);
        0x2::object::delete(v0);
        (v1, v2, v3, v4, v5, v6, v7)
    }

    public fun new<T0>(arg0: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>, arg1: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::release_schedule::ReleaseSchedule<T0>, arg2: 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::SharedToken<T0>, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (Timelock<T0>, 0x2::token::ActionRequest<T0>) {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, FundScheduleAbility>(arg0), 1);
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::token_owner<T0>(&arg2) == 0x2::tx_context::sender(arg5), 2);
        let v0 = 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::transfer<T0>(&mut arg2, arg3, arg5);
        (new_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5), v0)
    }

    public fun versioning<T0>(arg0: &Timelock<T0>) : 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::versioning::Versioning {
        arg0.versioning
    }

    public fun release_schedule<T0>(arg0: &Timelock<T0>) : 0x2::object::ID {
        arg0.release_schedule
    }

    public fun schedule_config<T0>(arg0: &Timelock<T0>) : 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::schedule_config::ScheduleConfig {
        arg0.schedule_config
    }

    public fun calculate_unlocked<T0>(arg0: &Timelock<T0>, arg1: u64) : u64 {
        let v0 = if (0x1::option::is_some<u64>(&arg0.canceled_at)) {
            0x1::u64::min(arg1, *0x1::option::borrow<u64>(&arg0.canceled_at))
        } else {
            arg1
        };
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::schedule_config::calculate_unlocked(arg0.schedule_config, arg0.total_amount, arg0.commencement_timestamp, v0)
    }

    public fun share<T0>(arg0: Timelock<T0>) {
        0x2::transfer::share_object<Timelock<T0>>(arg0);
    }

    public fun cancel<T0>(arg0: &mut Timelock<T0>, arg1: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>, arg2: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::reclaimer::Reclaimer<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::versioning::assert_is_valid_version(&arg0.versioning);
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, TimelockCancelAbility>(arg1), 3);
        assert!(0x1::option::is_none<u64>(&arg0.canceled_at), 7);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = arg0.total_amount - calculate_unlocked<T0>(arg0, v0);
        assert!(v1 > 0, 8);
        arg0.canceled_at = 0x1::option::some<u64>(v0);
        let v2 = 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::from_balance_with_policy_cap<T0>(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::policy_cap<T0>(arg1), 0x2::balance::split<T0>(&mut arg0.left_balance, v1), arg0.owner, arg4);
        let v3 = 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::reclaimer::addr<T0>(arg2);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::transfer_with_policy_cap<T0>(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::policy_cap<T0>(arg1), &mut v2, v3, arg4);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::share<T0>(v2);
        let v4 = TimelockCanceled<T0>{
            sender          : 0x2::tx_context::sender(arg4),
            timelock_id     : 0x2::object::id<Timelock<T0>>(arg0),
            timelock_owner  : owner<T0>(arg0),
            funder          : funder<T0>(arg0),
            canceled_amount : v1,
            paid_amount     : total_amount<T0>(arg0) - v1,
            reclaimer       : v3,
        };
        0x2::event::emit<TimelockCanceled<T0>>(v4);
    }

    public fun canceled_at<T0>(arg0: &Timelock<T0>) : 0x1::option::Option<u64> {
        arg0.canceled_at
    }

    public fun claim<T0>(arg0: &mut Timelock<T0>, arg1: 0x1::option::Option<u64>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::SplitJoinRequest<T0> {
        claim_internal<T0>(arg0, arg1, arg2, arg3)
    }

    fun claim_internal<T0>(arg0: &mut Timelock<T0>, arg1: 0x1::option::Option<u64>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::SplitJoinRequest<T0> {
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::versioning::assert_is_valid_version(&arg0.versioning);
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 4);
        let v0 = take_unlocked<T0>(arg0, 0x2::clock::timestamp_ms(arg2), arg1);
        let v1 = 0x2::balance::value<T0>(&v0);
        let (v2, v3) = 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::from_coin<T0>(0x2::coin::from_balance<T0>(v0, arg3), arg3);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::share<T0>(v2);
        let v4 = TimelockClaimed<T0>{
            sender      : 0x2::tx_context::sender(arg3),
            timelock_id : 0x2::object::id<Timelock<T0>>(arg0),
            funder      : funder<T0>(arg0),
            amount      : v1,
        };
        0x2::event::emit<TimelockClaimed<T0>>(v4);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::new_split_join_request<T0>(v3, v1 + 0x2::balance::value<T0>(&arg0.left_balance))
    }

    public fun claim_tail<T0>(arg0: &mut Timelock<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::SplitJoinRequest<T0> {
        let v0 = claim_internal<T0>(arg0, 0x1::option::none<u64>(), arg1, arg2);
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::request_amount<T0>(&v0) > 0, 9);
        assert!(0x2::balance::value<T0>(&arg0.left_balance) == 0, 10);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::min_amount_rule::approve_timelock_tail<T0>(&mut v0, arg2);
        v0
    }

    public fun commencement_timestamp<T0>(arg0: &Timelock<T0>) : u64 {
        arg0.commencement_timestamp
    }

    public fun force_claim<T0>(arg0: &mut Timelock<T0>, arg1: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::SharedToken<T0> {
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::versioning::assert_is_valid_version(&arg0.versioning);
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, ForceClaimAbility>(arg1), 11);
        let v0 = take_unlocked<T0>(arg0, 0x2::clock::timestamp_ms(arg2), 0x1::option::none<u64>());
        let v1 = 0x2::balance::value<T0>(&v0);
        assert!(v1 > 0, 9);
        let v2 = TimelockForceClaimed<T0>{
            sender         : 0x2::tx_context::sender(arg3),
            timelock_id    : 0x2::object::id<Timelock<T0>>(arg0),
            timelock_owner : arg0.owner,
            funder         : arg0.funder,
            amount         : v1,
        };
        0x2::event::emit<TimelockForceClaimed<T0>>(v2);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::from_balance_with_policy_cap<T0>(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::policy_cap<T0>(arg1), v0, arg0.owner, arg3)
    }

    public fun force_new<T0>(arg0: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>, arg1: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::release_schedule::ReleaseSchedule<T0>, arg2: 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::SharedToken<T0>, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : Timelock<T0> {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, ForceFundScheduleAbility>(arg0), 0);
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::token_owner<T0>(&arg2) == 0x2::tx_context::sender(arg5), 2);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::transfer_with_treasury_cap<T0>(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::treasury_cap<T0>(arg0), &mut arg2, arg3, arg5);
        new_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun force_set_owner<T0>(arg0: &mut Timelock<T0>, arg1: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::versioning::assert_is_valid_version(&arg0.versioning);
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, SetTimelockOwnerAbility>(arg1), 12);
        arg0.owner = arg2;
        let v0 = TimelockOwnerChanged<T0>{
            sender      : 0x2::tx_context::sender(arg3),
            timelock_id : 0x2::object::id<Timelock<T0>>(arg0),
            old_owner   : arg0.owner,
            new_owner   : arg2,
            funder      : arg0.funder,
        };
        0x2::event::emit<TimelockOwnerChanged<T0>>(v0);
    }

    public fun funder<T0>(arg0: &Timelock<T0>) : address {
        arg0.funder
    }

    public fun is_valid_version<T0>(arg0: &Timelock<T0>) : bool {
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::versioning::is_current_version_valid(&arg0.versioning)
    }

    public fun left_balance<T0>(arg0: &Timelock<T0>) : &0x2::balance::Balance<T0> {
        &arg0.left_balance
    }

    fun new_internal<T0>(arg0: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>, arg1: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::release_schedule::ReleaseSchedule<T0>, arg2: 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::SharedToken<T0>, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : Timelock<T0> {
        let v0 = 0x2::coin::into_balance<T0>(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::shared_token::to_coin_with_treasury_cap<T0>(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::treasury_cap<T0>(arg0), arg2, arg5));
        let v1 = 0x2::balance::value<T0>(&v0);
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = 0x2::object::id<0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::release_schedule::ReleaseSchedule<T0>>(arg1);
        let v4 = Timelock<T0>{
            id                     : 0x2::object::new(arg5),
            release_schedule       : v3,
            schedule_config        : *0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::release_schedule::config<T0>(arg1),
            owner                  : arg3,
            funder                 : v2,
            commencement_timestamp : arg4,
            tokens_transferred     : 0,
            total_amount           : v1,
            left_balance           : v0,
            canceled_at            : 0x1::option::none<u64>(),
            versioning             : 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::versioning<T0>(arg0),
        };
        let v5 = ReleaseScheduleFunded<T0>{
            sender                 : v2,
            recipient              : arg3,
            schedule_id            : v3,
            amount                 : v1,
            commencement_timestamp : arg4,
            timelock_id            : 0x2::object::id<Timelock<T0>>(&v4),
        };
        0x2::event::emit<ReleaseScheduleFunded<T0>>(v5);
        v4
    }

    public fun owner<T0>(arg0: &Timelock<T0>) : address {
        arg0.owner
    }

    public fun sync_versioning<T0>(arg0: &mut Timelock<T0>, arg1: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::versioning::VersionRegistry) {
        arg0.versioning = 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::versioning::versioning(arg1);
    }

    fun take_unlocked<T0>(arg0: &mut Timelock<T0>, arg1: u64, arg2: 0x1::option::Option<u64>) : 0x2::balance::Balance<T0> {
        let v0 = calculate_unlocked<T0>(arg0, arg1);
        let v1 = arg0.tokens_transferred;
        let v2 = if (0x1::option::is_some<u64>(&arg2)) {
            0x1::option::destroy_some<u64>(arg2)
        } else {
            0x1::option::destroy_none<u64>(arg2);
            v0 - v1
        };
        assert!(v2 + v1 <= v0, 6);
        arg0.tokens_transferred = v1 + v2;
        0x2::balance::split<T0>(&mut arg0.left_balance, v2)
    }

    public fun tokens_transferred<T0>(arg0: &Timelock<T0>) : u64 {
        arg0.tokens_transferred
    }

    public fun total_amount<T0>(arg0: &Timelock<T0>) : u64 {
        arg0.total_amount
    }

    // decompiled from Move bytecode v7
}

