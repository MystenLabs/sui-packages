module 0xee3494c4946be0d3810fc78db7c16b3b1dd839b138c1e5c5ad5801e0a539527::pilgrimage {
    struct PilgrimageTracker has key {
        id: 0x2::object::UID,
        total_locked: u64,
    }

    struct Stake has key {
        id: 0x2::object::UID,
        owner: address,
        amount: u64,
        lock_until: u64,
        tier: u8,
        created_at: u64,
        jui_balance: 0x2::balance::Balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>,
    }

    struct StakeCreated has copy, drop {
        staker: address,
        amount: u64,
        tier: u8,
        lock_until: u64,
        scrolls_expected: u64,
        total_locked: u64,
    }

    struct StakeClaimed has copy, drop {
        staker: address,
        amount: u64,
        tier: u8,
        scrolls_awarded: u64,
        lock_duration_actual: u64,
        total_locked: u64,
    }

    fun calc_scrolls(arg0: u64, arg1: u8) : u64 {
        arg0 / 1000000000000000 * tier_scrolls_per_1m(arg1)
    }

    public entry fun claim(arg0: Stake, arg1: &mut PilgrimageTracker, arg2: &mut 0xf8d13dc8e1679228d9a44ff4865b03861ee404f8dd7925a4fbf2da096c3f6311::holy_lottery::LotteryState, arg3: &0xf8d13dc8e1679228d9a44ff4865b03861ee404f8dd7925a4fbf2da096c3f6311::holy_lottery::PilgrimageCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 >= arg0.lock_until, 2);
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 3);
        let Stake {
            id          : v1,
            owner       : v2,
            amount      : v3,
            lock_until  : _,
            tier        : v5,
            created_at  : v6,
            jui_balance : v7,
        } = arg0;
        0x2::object::delete(v1);
        let v8 = calc_scrolls(v3, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(v7, arg5), v2);
        if (arg1.total_locked >= v3) {
            arg1.total_locked = arg1.total_locked - v3;
        } else {
            arg1.total_locked = 0;
        };
        if (v8 > 0) {
            0xf8d13dc8e1679228d9a44ff4865b03861ee404f8dd7925a4fbf2da096c3f6311::holy_lottery::add_faith_scrolls(arg2, arg3, v2, v8, arg5);
        };
        let v9 = StakeClaimed{
            staker               : v2,
            amount               : v3,
            tier                 : v5,
            scrolls_awarded      : v8,
            lock_duration_actual : v0 - v6,
            total_locked         : arg1.total_locked,
        };
        0x2::event::emit<StakeClaimed>(v9);
    }

    public entry fun claim_v2(arg0: Stake, arg1: &mut PilgrimageTracker, arg2: &0xf8d13dc8e1679228d9a44ff4865b03861ee404f8dd7925a4fbf2da096c3f6311::holy_lottery::PilgrimageCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg0.lock_until, 2);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 3);
        let Stake {
            id          : v1,
            owner       : v2,
            amount      : v3,
            lock_until  : _,
            tier        : v5,
            created_at  : v6,
            jui_balance : v7,
        } = arg0;
        0x2::object::delete(v1);
        let v8 = calc_scrolls(v3, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(v7, arg4), v2);
        if (arg1.total_locked >= v3) {
            arg1.total_locked = arg1.total_locked - v3;
        } else {
            arg1.total_locked = 0;
        };
        if (v8 > 0) {
            0xf8d13dc8e1679228d9a44ff4865b03861ee404f8dd7925a4fbf2da096c3f6311::holy_lottery::issue_faith_balance(arg2, v2, v8, arg4);
        };
        let v9 = StakeClaimed{
            staker               : v2,
            amount               : v3,
            tier                 : v5,
            scrolls_awarded      : v8,
            lock_duration_actual : v0 - v6,
            total_locked         : arg1.total_locked,
        };
        0x2::event::emit<StakeClaimed>(v9);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PilgrimageTracker{
            id           : 0x2::object::new(arg0),
            total_locked : 0,
        };
        0x2::transfer::share_object<PilgrimageTracker>(v0);
    }

    public entry fun stake(arg0: &mut PilgrimageTracker, arg1: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg1);
        assert!(v0 >= 1000000000000000, 0);
        assert!(arg2 >= 1 && arg2 <= 3, 1);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = v1 + tier_duration_ms(arg2);
        let v3 = 0x2::tx_context::sender(arg4);
        arg0.total_locked = arg0.total_locked + v0;
        let v4 = Stake{
            id          : 0x2::object::new(arg4),
            owner       : v3,
            amount      : v0,
            lock_until  : v2,
            tier        : arg2,
            created_at  : v1,
            jui_balance : 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg1),
        };
        let v5 = StakeCreated{
            staker           : v3,
            amount           : v0,
            tier             : arg2,
            lock_until       : v2,
            scrolls_expected : calc_scrolls(v0, arg2),
            total_locked     : arg0.total_locked,
        };
        0x2::event::emit<StakeCreated>(v5);
        0x2::transfer::transfer<Stake>(v4, v3);
    }

    public fun stake_amount(arg0: &Stake) : u64 {
        arg0.amount
    }

    public fun stake_lock_until(arg0: &Stake) : u64 {
        arg0.lock_until
    }

    public fun stake_owner(arg0: &Stake) : address {
        arg0.owner
    }

    public fun stake_scrolls_expected(arg0: &Stake) : u64 {
        calc_scrolls(arg0.amount, arg0.tier)
    }

    public fun stake_tier(arg0: &Stake) : u8 {
        arg0.tier
    }

    fun tier_duration_ms(arg0: u8) : u64 {
        if (arg0 == 1) {
            604800000
        } else if (arg0 == 2) {
            2592000000
        } else {
            7776000000
        }
    }

    fun tier_scrolls_per_1m(arg0: u8) : u64 {
        if (arg0 == 1) {
            20
        } else if (arg0 == 2) {
            60
        } else {
            150
        }
    }

    public fun total_locked(arg0: &PilgrimageTracker) : u64 {
        arg0.total_locked
    }

    // decompiled from Move bytecode v6
}

