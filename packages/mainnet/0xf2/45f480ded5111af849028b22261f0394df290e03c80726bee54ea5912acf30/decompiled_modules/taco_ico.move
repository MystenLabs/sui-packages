module 0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::taco_ico {
    struct IcoPool has key {
        id: 0x2::object::UID,
        start_time_ms: u64,
        end_time_ms: u64,
        claim_start_delay_ms: u64,
        lock_duration_ms: u64,
        linear_release_duration_ms: u64,
        max_sui_per_user: u64,
        total_sui_raised: u64,
        total_taco_committed: u64,
        sui_raised: 0x2::balance::Balance<0x2::sui::SUI>,
        taco_pool: 0x2::balance::Balance<0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::taco::TACO>,
        contributions: 0x2::table::Table<address, u64>,
        claimed_amount: 0x2::table::Table<address, u64>,
    }

    struct IcoAdminCap has key {
        id: 0x2::object::UID,
        pool_id: address,
    }

    struct IcoCreated has copy, drop {
        pool_id: address,
        creator: address,
        start_time_ms: u64,
        end_time_ms: u64,
        max_sui_per_user: u64,
    }

    struct ScheduleUpdated has copy, drop {
        start_time_ms: u64,
        end_time_ms: u64,
    }

    struct MaxSuiPerUserUpdated has copy, drop {
        max_sui_per_user: u64,
    }

    struct VestingConfigUpdated has copy, drop {
        claim_start_delay_ms: u64,
        lock_duration_ms: u64,
        linear_release_duration_ms: u64,
    }

    struct TacoDeposited has copy, drop {
        amount: u64,
        total_taco_committed: u64,
    }

    struct SuiContributed has copy, drop {
        user: address,
        amount: u64,
        user_total: u64,
        total_sui_raised: u64,
    }

    struct TacoClaimed has copy, drop {
        user: address,
        amount: u64,
        total_claimed: u64,
    }

    struct RaisedSuiWithdrawn has copy, drop {
        admin: address,
        amount: u64,
        remaining_raised: u64,
    }

    fun assert_cap(arg0: &IcoPool, arg1: &IcoAdminCap) {
        assert!(0x2::object::id_address<IcoPool>(arg0) == arg1.pool_id, 13012);
    }

    public fun claim_start_delay_ms(arg0: &IcoPool) : u64 {
        arg0.claim_start_delay_ms
    }

    public fun claim_start_time_ms(arg0: &IcoPool) : u64 {
        safe_add(arg0.end_time_ms, arg0.claim_start_delay_ms)
    }

    public fun claim_taco(arg0: &mut IcoPool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::taco::TACO>>(claim_taco_ptb(arg0, arg1, arg2), v0);
    }

    fun claim_taco_internal(arg0: &mut IcoPool, arg1: &0x2::clock::Clock, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::taco::TACO> {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= claim_start_time_ms(arg0), 13009);
        assert!(0x2::table::contains<address, u64>(&arg0.contributions, arg2), 13008);
        assert!(arg0.total_sui_raised > 0, 13010);
        let v1 = *0x2::table::borrow<address, u64>(&arg0.contributions, arg2);
        assert!(v1 > 0, 13008);
        let v2 = vested_amount(arg0, to_u64((v1 as u256) * (arg0.total_taco_committed as u256) / (arg0.total_sui_raised as u256)), v0);
        let v3 = if (0x2::table::contains<address, u64>(&arg0.claimed_amount, arg2)) {
            *0x2::table::borrow<address, u64>(&arg0.claimed_amount, arg2)
        } else {
            0
        };
        assert!(v2 > v3, 13008);
        let v4 = v2 - v3;
        if (0x2::table::contains<address, u64>(&arg0.claimed_amount, arg2)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.claimed_amount, arg2) = v2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.claimed_amount, arg2, v2);
        };
        if (v4 == 0) {
            return 0x2::coin::from_balance<0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::taco::TACO>(0x2::balance::zero<0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::taco::TACO>(), arg3)
        };
        let v5 = TacoClaimed{
            user          : arg2,
            amount        : v4,
            total_claimed : v2,
        };
        0x2::event::emit<TacoClaimed>(v5);
        0x2::coin::from_balance<0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::taco::TACO>(0x2::balance::split<0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::taco::TACO>(&mut arg0.taco_pool, v4), arg3)
    }

    public fun claim_taco_ptb(arg0: &mut IcoPool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::taco::TACO> {
        let v0 = 0x2::tx_context::sender(arg2);
        claim_taco_internal(arg0, arg1, v0, arg2)
    }

    public fun contribute_sui(arg0: &mut IcoPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        contribute_sui_internal(arg0, arg1, arg2, 0x2::tx_context::sender(arg3));
    }

    fun contribute_sui_internal(arg0: &mut IcoPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: address) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.start_time_ms, 13003);
        assert!(v0 < arg0.end_time_ms, 13004);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 > 0, 13005);
        let v2 = if (0x2::table::contains<address, u64>(&arg0.contributions, arg3)) {
            *0x2::table::borrow<address, u64>(&arg0.contributions, arg3)
        } else {
            0
        };
        assert!(v2 + v1 <= arg0.max_sui_per_user, 13006);
        if (0x2::table::contains<address, u64>(&arg0.contributions, arg3)) {
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.contributions, arg3);
            *v3 = *v3 + v1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.contributions, arg3, v1);
        };
        arg0.total_sui_raised = arg0.total_sui_raised + v1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_raised, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v4 = SuiContributed{
            user             : arg3,
            amount           : v1,
            user_total       : v2 + v1,
            total_sui_raised : arg0.total_sui_raised,
        };
        0x2::event::emit<SuiContributed>(v4);
    }

    public fun contribute_sui_with_sender(arg0: &mut IcoPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: address) {
        contribute_sui_internal(arg0, arg1, arg2, arg3);
    }

    public fun create_ico(arg0: u64, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_ico_internal(arg0, arg1, arg2, arg3);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg3);
        let v4 = IcoCreated{
            pool_id          : 0x2::object::id_address<IcoPool>(&v2),
            creator          : v3,
            start_time_ms    : arg0,
            end_time_ms      : arg1,
            max_sui_per_user : arg2,
        };
        0x2::event::emit<IcoCreated>(v4);
        0x2::transfer::transfer<IcoAdminCap>(v1, v3);
        0x2::transfer::share_object<IcoPool>(v2);
    }

    fun create_ico_internal(arg0: u64, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (IcoPool, IcoAdminCap) {
        assert!(arg0 < arg1, 13001);
        assert!(arg2 > 0, 13002);
        let v0 = IcoPool{
            id                         : 0x2::object::new(arg3),
            start_time_ms              : arg0,
            end_time_ms                : arg1,
            claim_start_delay_ms       : 0,
            lock_duration_ms           : 0,
            linear_release_duration_ms : 0,
            max_sui_per_user           : arg2,
            total_sui_raised           : 0,
            total_taco_committed       : 0,
            sui_raised                 : 0x2::balance::zero<0x2::sui::SUI>(),
            taco_pool                  : 0x2::balance::zero<0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::taco::TACO>(),
            contributions              : 0x2::table::new<address, u64>(arg3),
            claimed_amount             : 0x2::table::new<address, u64>(arg3),
        };
        let v1 = IcoAdminCap{
            id      : 0x2::object::new(arg3),
            pool_id : 0x2::object::id_address<IcoPool>(&v0),
        };
        (v0, v1)
    }

    public fun deposit_taco(arg0: &mut IcoPool, arg1: &IcoAdminCap, arg2: 0x2::coin::Coin<0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::taco::TACO>) {
        assert_cap(arg0, arg1);
        let v0 = 0x2::coin::value<0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::taco::TACO>(&arg2);
        arg0.total_taco_committed = arg0.total_taco_committed + v0;
        0x2::balance::join<0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::taco::TACO>(&mut arg0.taco_pool, 0x2::coin::into_balance<0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::taco::TACO>(arg2));
        let v1 = TacoDeposited{
            amount               : v0,
            total_taco_committed : arg0.total_taco_committed,
        };
        0x2::event::emit<TacoDeposited>(v1);
    }

    public fun end_time_ms(arg0: &IcoPool) : u64 {
        arg0.end_time_ms
    }

    public fun linear_release_duration_ms(arg0: &IcoPool) : u64 {
        arg0.linear_release_duration_ms
    }

    public fun lock_duration_ms(arg0: &IcoPool) : u64 {
        arg0.lock_duration_ms
    }

    public fun max_sui_per_user(arg0: &IcoPool) : u64 {
        arg0.max_sui_per_user
    }

    fun safe_add(arg0: u64, arg1: u64) : u64 {
        if (arg0 > 18446744073709551615 - arg1) {
            abort 13013
        };
        arg0 + arg1
    }

    public fun set_max_sui_per_user(arg0: &mut IcoPool, arg1: &IcoAdminCap, arg2: u64) {
        assert_cap(arg0, arg1);
        assert!(arg2 > 0, 13002);
        arg0.max_sui_per_user = arg2;
        let v0 = MaxSuiPerUserUpdated{max_sui_per_user: arg2};
        0x2::event::emit<MaxSuiPerUserUpdated>(v0);
    }

    public fun set_schedule(arg0: &mut IcoPool, arg1: &IcoAdminCap, arg2: u64, arg3: u64) {
        assert_cap(arg0, arg1);
        assert!(arg2 < arg3, 13001);
        arg0.start_time_ms = arg2;
        arg0.end_time_ms = arg3;
        let v0 = ScheduleUpdated{
            start_time_ms : arg2,
            end_time_ms   : arg3,
        };
        0x2::event::emit<ScheduleUpdated>(v0);
    }

    public fun set_vesting_config(arg0: &mut IcoPool, arg1: &IcoAdminCap, arg2: u64, arg3: u64, arg4: u64) {
        assert_cap(arg0, arg1);
        arg0.claim_start_delay_ms = arg2;
        arg0.lock_duration_ms = arg3;
        arg0.linear_release_duration_ms = arg4;
        let v0 = VestingConfigUpdated{
            claim_start_delay_ms       : arg2,
            lock_duration_ms           : arg3,
            linear_release_duration_ms : arg4,
        };
        0x2::event::emit<VestingConfigUpdated>(v0);
    }

    public fun start_time_ms(arg0: &IcoPool) : u64 {
        arg0.start_time_ms
    }

    public fun time_until_start_ms(arg0: &IcoPool, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 >= arg0.start_time_ms) {
            0
        } else {
            arg0.start_time_ms - v0
        }
    }

    fun to_u64(arg0: u256) : u64 {
        if (arg0 > 18446744073709551615) {
            abort 13013
        };
        (arg0 as u64)
    }

    public fun total_sui_raised(arg0: &IcoPool) : u64 {
        arg0.total_sui_raised
    }

    public fun total_taco_committed(arg0: &IcoPool) : u64 {
        arg0.total_taco_committed
    }

    public fun user_contribution(arg0: &IcoPool, arg1: address) : u64 {
        if (!0x2::table::contains<address, u64>(&arg0.contributions, arg1)) {
            return 0
        };
        *0x2::table::borrow<address, u64>(&arg0.contributions, arg1)
    }

    fun vested_amount(arg0: &IcoPool, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = safe_add(claim_start_time_ms(arg0), arg0.lock_duration_ms);
        if (arg2 < v0) {
            return 0
        };
        if (arg0.linear_release_duration_ms == 0) {
            return arg1
        };
        let v1 = arg2 - v0;
        if (v1 >= arg0.linear_release_duration_ms) {
            return arg1
        };
        to_u64((arg1 as u256) * (v1 as u256) / (arg0.linear_release_duration_ms as u256))
    }

    public fun withdraw_raised_sui(arg0: &mut IcoPool, arg1: &IcoAdminCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(withdraw_raised_sui_ptb(arg0, arg1, arg2, arg3, arg4), v0);
    }

    public fun withdraw_raised_sui_ptb(arg0: &mut IcoPool, arg1: &IcoAdminCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_cap(arg0, arg1);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.end_time_ms, 13007);
        assert!(arg2 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_raised), 13011);
        let v0 = RaisedSuiWithdrawn{
            admin            : 0x2::tx_context::sender(arg4),
            amount           : arg2,
            remaining_raised : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_raised),
        };
        0x2::event::emit<RaisedSuiWithdrawn>(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_raised, arg2), arg4)
    }

    // decompiled from Move bytecode v6
}

