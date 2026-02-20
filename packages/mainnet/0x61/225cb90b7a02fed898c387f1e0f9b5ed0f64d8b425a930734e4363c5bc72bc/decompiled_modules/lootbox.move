module 0xc43002b11b73db988fc354cfc35a8fa774c0a3a2204c8ec79988d0ae51e77b06::lootbox {
    struct LOOTBOX has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LootboxTreasury has key {
        id: 0x2::object::UID,
        prize_pools_locked: bool,
        prize_pools: 0x2::bag::Bag,
        disabled_functions: 0x2::vec_set::VecSet<FunctionMask>,
        version: u64,
    }

    struct Lootbox<phantom T0> has store, key {
        id: 0x2::object::UID,
        magic: u64,
        tier: u8,
        amount: u64,
        use_amount: bool,
        title: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct VestingLootbox<phantom T0> has store, key {
        id: 0x2::object::UID,
        unlocked_amount: u64,
        initial_locked_amount: u64,
        locked_amount_remaining: u64,
        lock_start_ms: u64,
        lock_duration_ms: u64,
    }

    struct FunctionMask has copy, drop, store {
        name: u8,
    }

    struct LootboxSettings has key {
        id: 0x2::object::UID,
        prize_tier_0: u64,
        prize_tier_0_probability: u64,
        prize_tier_1: u64,
        prize_tier_1_probability: u64,
        prize_tier_2: u64,
        prize_tier_2_probability: u64,
        seed: u64,
        special_amount_prize: u64,
        special_amount_target: u64,
    }

    struct PrizePoolName<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct PrizePool<phantom T0> has store {
        enabled: bool,
        last_update: u64,
        liquidity: 0x2::balance::Balance<T0>,
    }

    struct Deposited<phantom T0> has copy, drop {
        deposit_amount: u64,
    }

    struct Withdrawn<phantom T0> has copy, drop {
        withdraw_value: u64,
    }

    struct LootboxCreated has copy, drop {
        prize_pools_parent: 0x2::object::ID,
    }

    struct LootboxOpened<phantom T0> has copy, drop {
        lootbox_opener: address,
        price_value: u64,
    }

    struct LootboxIssued has copy, drop {
        lootbox: 0x2::object::ID,
    }

    struct VestingLootboxIssued<phantom T0> has copy, drop {
        lootbox: 0x2::object::ID,
        unlocked_amount: u64,
        locked_amount: u64,
        lock_duration_ms: u64,
    }

    struct UnlockedClaimed<phantom T0> has copy, drop {
        amount: u64,
    }

    struct VestingClaimed<phantom T0> has copy, drop {
        amount: u64,
    }

    struct PrizePoolCreated<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    public fun add_new_prize_pool<T0>(arg0: &AdminCap, arg1: &mut LootboxTreasury) {
        check_version(arg1);
        assert!(!is_function_disabled(arg1, new_function_mask(5)), 4);
        let v0 = PrizePool<T0>{
            enabled     : true,
            last_update : 0,
            liquidity   : 0x2::balance::zero<T0>(),
        };
        let v1 = PrizePoolName<T0>{dummy_field: false};
        0x2::bag::add<PrizePoolName<T0>, PrizePool<T0>>(&mut arg1.prize_pools, v1, v0);
        let v2 = PrizePoolCreated<T0>{dummy_field: false};
        0x2::event::emit<PrizePoolCreated<T0>>(v2);
    }

    public fun admin_issue_lootbox<T0>(arg0: &AdminCap, arg1: &LootboxTreasury, arg2: u8, arg3: address, arg4: u64, arg5: bool, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut LootboxSettings, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled(arg1, new_function_mask(3)), 4);
        let v0 = Lootbox<T0>{
            id          : 0x2::object::new(arg9),
            magic       : arg8.seed,
            tier        : arg2,
            amount      : arg4,
            use_amount  : arg5,
            title       : arg6,
            description : arg7,
        };
        arg8.seed = arg8.seed + 1;
        let v1 = LootboxIssued{lootbox: 0x2::object::id<Lootbox<T0>>(&v0)};
        0x2::event::emit<LootboxIssued>(v1);
        0x2::transfer::transfer<Lootbox<T0>>(v0, arg3);
    }

    public fun admin_issue_vesting_lootbox<T0>(arg0: &AdminCap, arg1: &LootboxTreasury, arg2: &0x2::clock::Clock, arg3: &0x2::coin::CoinMetadata<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        assert!(!is_function_disabled(arg1, new_function_mask(8)), 4);
        let v0 = 0x2::coin::get_decimals<T0>(arg3);
        assert!(v0 <= 18, 9);
        let v1 = 0x1::u64::pow(10, v0);
        let v2 = arg4 * v1;
        let v3 = arg5 * v1;
        assert!(v2 > 0 || v3 > 0, 3);
        let v4 = VestingLootbox<T0>{
            id                      : 0x2::object::new(arg8),
            unlocked_amount         : v2,
            initial_locked_amount   : v3,
            locked_amount_remaining : v3,
            lock_start_ms           : 0x2::clock::timestamp_ms(arg2),
            lock_duration_ms        : arg6,
        };
        let v5 = VestingLootboxIssued<T0>{
            lootbox          : 0x2::object::id<VestingLootbox<T0>>(&v4),
            unlocked_amount  : v2,
            locked_amount    : v3,
            lock_duration_ms : arg6,
        };
        0x2::event::emit<VestingLootboxIssued<T0>>(v5);
        0x2::transfer::transfer<VestingLootbox<T0>>(v4, arg7);
    }

    public fun admin_issue_vesting_lootbox_precision<T0>(arg0: &AdminCap, arg1: &LootboxTreasury, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        assert!(!is_function_disabled(arg1, new_function_mask(8)), 4);
        assert!(arg3 > 0 || arg4 > 0, 3);
        let v0 = VestingLootbox<T0>{
            id                      : 0x2::object::new(arg7),
            unlocked_amount         : arg3,
            initial_locked_amount   : arg4,
            locked_amount_remaining : arg4,
            lock_start_ms           : 0x2::clock::timestamp_ms(arg2),
            lock_duration_ms        : arg5,
        };
        let v1 = VestingLootboxIssued<T0>{
            lootbox          : 0x2::object::id<VestingLootbox<T0>>(&v0),
            unlocked_amount  : arg3,
            locked_amount    : arg4,
            lock_duration_ms : arg5,
        };
        0x2::event::emit<VestingLootboxIssued<T0>>(v1);
        0x2::transfer::transfer<VestingLootbox<T0>>(v0, arg6);
    }

    public fun admin_set_function_status(arg0: &AdminCap, arg1: &mut LootboxTreasury, arg2: u8, arg3: bool) {
        let v0 = new_function_mask(arg2);
        if (arg3) {
            0x2::vec_set::remove<FunctionMask>(&mut arg1.disabled_functions, &v0);
        } else {
            0x2::vec_set::insert<FunctionMask>(&mut arg1.disabled_functions, v0);
        };
    }

    public fun admin_update_lootbox_settings(arg0: &AdminCap, arg1: &LootboxTreasury, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut LootboxSettings) {
        assert!(!is_function_disabled(arg1, new_function_mask(6)), 4);
        arg11.prize_tier_0 = arg2;
        arg11.prize_tier_0_probability = arg3;
        arg11.prize_tier_1 = arg4;
        arg11.prize_tier_1_probability = arg5;
        arg11.prize_tier_2 = arg6;
        arg11.prize_tier_2_probability = arg7;
        arg11.seed = arg8;
        arg11.special_amount_prize = arg9;
        arg11.special_amount_target = arg10;
    }

    public fun admin_update_special_amount_settings(arg0: &AdminCap, arg1: &LootboxTreasury, arg2: u64, arg3: u64, arg4: &mut LootboxSettings) {
        assert!(!is_function_disabled(arg1, new_function_mask(6)), 4);
        arg4.special_amount_prize = arg2;
        arg4.special_amount_target = arg3;
    }

    public fun bump_version(arg0: &AdminCap, arg1: &mut LootboxTreasury) {
        let v0 = arg1.version + 1;
        assert!(v0 <= 2, 6);
        arg1.version = v0;
    }

    fun check_version(arg0: &LootboxTreasury) {
        assert!(arg0.version == 2, 5);
    }

    public fun claim_unlocked<T0>(arg0: &mut LootboxTreasury, arg1: &mut VestingLootbox<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.unlocked_amount;
        assert!(v0 > 0, 7);
        let v1 = PrizePoolName<T0>{dummy_field: false};
        let v2 = 0x2::bag::borrow_mut<PrizePoolName<T0>, PrizePool<T0>>(&mut arg0.prize_pools, v1);
        assert!(v2.enabled, 1);
        assert!(v0 <= 0x2::balance::value<T0>(&v2.liquidity), 2);
        let v3 = 0x2::tx_context::sender(arg2);
        pay_from_balance<T0>(0x2::balance::split<T0>(&mut v2.liquidity, v0), v3, arg2);
        arg1.unlocked_amount = 0;
        let v4 = UnlockedClaimed<T0>{amount: v0};
        0x2::event::emit<UnlockedClaimed<T0>>(v4);
    }

    public fun claim_vested<T0>(arg0: &mut LootboxTreasury, arg1: &mut VestingLootbox<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = if (v0 >= arg1.lock_start_ms) {
            v0 - arg1.lock_start_ms
        } else {
            0
        };
        let v2 = if (arg1.lock_duration_ms == 0) {
            arg1.initial_locked_amount
        } else {
            let v3 = if (v1 >= arg1.lock_duration_ms) {
                arg1.lock_duration_ms
            } else {
                v1
            };
            (((arg1.initial_locked_amount as u128) * (v3 as u128) / (arg1.lock_duration_ms as u128)) as u64)
        };
        let v4 = arg1.initial_locked_amount - arg1.locked_amount_remaining;
        let v5 = if (v2 > v4) {
            v2 - v4
        } else {
            0
        };
        let v6 = if (v5 <= arg1.locked_amount_remaining) {
            v5
        } else {
            arg1.locked_amount_remaining
        };
        assert!(v6 > 0, 7);
        let v7 = PrizePoolName<T0>{dummy_field: false};
        let v8 = 0x2::bag::borrow_mut<PrizePoolName<T0>, PrizePool<T0>>(&mut arg0.prize_pools, v7);
        assert!(v8.enabled, 1);
        assert!(v6 <= 0x2::balance::value<T0>(&v8.liquidity), 2);
        let v9 = 0x2::tx_context::sender(arg3);
        pay_from_balance<T0>(0x2::balance::split<T0>(&mut v8.liquidity, v6), v9, arg3);
        arg1.locked_amount_remaining = arg1.locked_amount_remaining - v6;
        let v10 = VestingClaimed<T0>{amount: v6};
        0x2::event::emit<VestingClaimed<T0>>(v10);
    }

    public fun create_lootbox_display<T0>(arg0: &AdminCap, arg1: &LootboxTreasury, arg2: &0x2::package::Publisher, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled(arg1, new_function_mask(7)), 4);
        let v0 = 0x2::display::new<Lootbox<T0>>(arg2, arg3);
        0x2::display::add<Lootbox<T0>>(&mut v0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Zolian Shard"));
        0x2::display::add<Lootbox<T0>>(&mut v0, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Zolian Shard contains mystery rewards prepared by the ZO Planet DAO. Collect Shards, Earn Huge!"));
        0x2::display::add<Lootbox<T0>>(&mut v0, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://zofai.io/"));
        0x2::display::add<Lootbox<T0>>(&mut v0, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://app.zofai.io/"));
        0x2::display::add<Lootbox<T0>>(&mut v0, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"ZO Finance"));
        0x2::display::add<Lootbox<T0>>(&mut v0, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://img.zofinance.io/zolian-shard.gif"));
        0x2::display::update_version<Lootbox<T0>>(&mut v0);
        0x2::transfer::public_transfer<0x2::display::Display<Lootbox<T0>>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun create_lootbox_treasury(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = LootboxTreasury{
            id                 : 0x2::object::new(arg1),
            prize_pools_locked : false,
            prize_pools        : 0x2::bag::new(arg1),
            disabled_functions : 0x2::vec_set::empty<FunctionMask>(),
            version            : 2,
        };
        let v1 = LootboxCreated{prize_pools_parent: 0x2::object::id<0x2::bag::Bag>(&v0.prize_pools)};
        0x2::event::emit<LootboxCreated>(v1);
        0x2::transfer::share_object<LootboxTreasury>(v0);
    }

    public fun deposit<T0>(arg0: &AdminCap, arg1: &mut LootboxTreasury, arg2: 0x2::coin::Coin<T0>) {
        check_version(arg1);
        assert!(!is_function_disabled(arg1, new_function_mask(1)), 4);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = PrizePoolName<T0>{dummy_field: false};
        let v2 = 0x2::bag::borrow_mut<PrizePoolName<T0>, PrizePool<T0>>(&mut arg1.prize_pools, v1);
        assert!(v2.enabled, 1);
        assert!(v0 > 0, 3);
        0x2::balance::join<T0>(&mut v2.liquidity, 0x2::coin::into_balance<T0>(arg2));
        let v3 = Deposited<T0>{deposit_amount: v0};
        0x2::event::emit<Deposited<T0>>(v3);
    }

    public fun destroy_vesting_lootbox<T0>(arg0: VestingLootbox<T0>) {
        let VestingLootbox {
            id                      : v0,
            unlocked_amount         : v1,
            initial_locked_amount   : _,
            locked_amount_remaining : v3,
            lock_start_ms           : _,
            lock_duration_ms        : _,
        } = arg0;
        assert!(v1 == 0, 8);
        assert!(v3 == 0, 8);
        0x2::object::delete(v0);
    }

    fun get_prize_amount(arg0: u64, arg1: u8, arg2: u64, arg3: bool, arg4: u64, arg5: &LootboxSettings) : u64 {
        if (arg2 == arg5.special_amount_target) {
            arg5.special_amount_prize * arg4
        } else if (arg3) {
            arg2 * arg4
        } else if (arg1 == 0) {
            if (arg0 % arg5.prize_tier_0_probability == 0) {
                arg5.prize_tier_0 * arg4
            } else {
                0
            }
        } else if (arg1 == 1) {
            if (arg0 % arg5.prize_tier_1_probability == 0) {
                arg5.prize_tier_1 * arg4
            } else {
                0
            }
        } else if (arg1 == 2) {
            if (arg0 % arg5.prize_tier_2_probability == 0) {
                arg5.prize_tier_2 * arg4
            } else {
                0
            }
        } else {
            0
        }
    }

    fun init(arg0: LOOTBOX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = LootboxSettings{
            id                       : 0x2::object::new(arg1),
            prize_tier_0             : 0,
            prize_tier_0_probability : 1,
            prize_tier_1             : 0,
            prize_tier_1_probability : 1,
            prize_tier_2             : 0,
            prize_tier_2_probability : 1,
            seed                     : 0,
            special_amount_prize     : 0,
            special_amount_target    : 0,
        };
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<LOOTBOX>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<LootboxSettings>(v1);
    }

    fun is_function_disabled(arg0: &LootboxTreasury, arg1: FunctionMask) : bool {
        0x2::vec_set::contains<FunctionMask>(&arg0.disabled_functions, &arg1)
    }

    fun new_function_mask(arg0: u8) : FunctionMask {
        FunctionMask{name: arg0}
    }

    public fun open_lootbox<T0>(arg0: &mut LootboxTreasury, arg1: Lootbox<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &LootboxSettings, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(!is_function_disabled(arg0, new_function_mask(4)), 4);
        let Lootbox {
            id          : v0,
            magic       : v1,
            tier        : v2,
            amount      : v3,
            use_amount  : v4,
            title       : _,
            description : _,
        } = arg1;
        0x2::object::delete(v0);
        let v7 = get_prize_amount(v1, v2, v3, v4, 0x1::u64::pow(10, 0x2::coin::get_decimals<T0>(arg2)), arg3);
        let v8 = PrizePoolName<T0>{dummy_field: false};
        let v9 = 0x2::bag::borrow_mut<PrizePoolName<T0>, PrizePool<T0>>(&mut arg0.prize_pools, v8);
        assert!(v9.enabled, 1);
        assert!(v7 <= 0x2::balance::value<T0>(&v9.liquidity), 2);
        let v10 = 0x2::balance::split<T0>(&mut v9.liquidity, v7);
        let v11 = 0x2::tx_context::sender(arg4);
        pay_from_balance<T0>(v10, v11, arg4);
        let v12 = LootboxOpened<T0>{
            lootbox_opener : v11,
            price_value    : 0x2::balance::value<T0>(&v10),
        };
        0x2::event::emit<LootboxOpened<T0>>(v12);
    }

    fun pay_from_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun withdraw<T0>(arg0: &AdminCap, arg1: &mut LootboxTreasury, arg2: &0x2::coin::CoinMetadata<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        assert!(!is_function_disabled(arg1, new_function_mask(2)), 4);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = PrizePoolName<T0>{dummy_field: false};
        let v2 = 0x2::bag::borrow_mut<PrizePoolName<T0>, PrizePool<T0>>(&mut arg1.prize_pools, v1);
        assert!(v2.enabled, 1);
        let v3 = arg3 * 0x1::u64::pow(10, 0x2::coin::get_decimals<T0>(arg2));
        assert!(v3 <= 0x2::balance::value<T0>(&v2.liquidity), 2);
        let v4 = 0x2::balance::split<T0>(&mut v2.liquidity, v3);
        pay_from_balance<T0>(v4, v0, arg4);
        let v5 = Withdrawn<T0>{withdraw_value: 0x2::balance::value<T0>(&v4)};
        0x2::event::emit<Withdrawn<T0>>(v5);
    }

    // decompiled from Move bytecode v6
}

