module 0x6682aaed15da135e34449cce7f89bf9e79c0fce1087173391a041742d8081690::lootbox {
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
    }

    struct Lootbox<phantom T0> has store, key {
        id: 0x2::object::UID,
        magic: u64,
        tier: u8,
        amount: u64,
        use_amount: bool,
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

    struct PrizePoolCreated<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    public fun add_new_prize_pool<T0>(arg0: &AdminCap, arg1: &mut LootboxTreasury) {
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

    public fun admin_issue_lootbox<T0>(arg0: &AdminCap, arg1: u8, arg2: address, arg3: u64, arg4: bool, arg5: &mut LootboxSettings, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Lootbox<T0>{
            id         : 0x2::object::new(arg6),
            magic      : arg5.seed,
            tier       : arg1,
            amount     : arg3,
            use_amount : arg4,
        };
        arg5.seed = arg5.seed + 1;
        let v1 = LootboxIssued{lootbox: 0x2::object::id<Lootbox<T0>>(&v0)};
        0x2::event::emit<LootboxIssued>(v1);
        0x2::transfer::transfer<Lootbox<T0>>(v0, arg2);
    }

    public fun admin_update_lootbox_settings(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut LootboxSettings) {
        arg8.prize_tier_0 = arg1;
        arg8.prize_tier_0_probability = arg2;
        arg8.prize_tier_1 = arg3;
        arg8.prize_tier_1_probability = arg4;
        arg8.prize_tier_2 = arg5;
        arg8.prize_tier_2_probability = arg6;
        arg8.seed = arg7;
    }

    public fun create_lootbox_display<T0>(arg0: &AdminCap, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::display::new<Lootbox<T0>>(arg1, arg2);
        0x2::display::add<Lootbox<T0>>(&mut v0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Zolian Shard"));
        0x2::display::add<Lootbox<T0>>(&mut v0, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Zolian Shard contains mystery rewards prepared by the ZO Planet DAO. Collect Shards, Earn Huge!"));
        0x2::display::add<Lootbox<T0>>(&mut v0, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://zofai.io/"));
        0x2::display::add<Lootbox<T0>>(&mut v0, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://app.zofai.io/"));
        0x2::display::add<Lootbox<T0>>(&mut v0, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"ZO Finance"));
        0x2::display::add<Lootbox<T0>>(&mut v0, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://img.zofinance.io/zolian-shard.gif"));
        0x2::display::update_version<Lootbox<T0>>(&mut v0);
        0x2::transfer::public_transfer<0x2::display::Display<Lootbox<T0>>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun create_lootbox_treasury(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = LootboxTreasury{
            id                 : 0x2::object::new(arg1),
            prize_pools_locked : false,
            prize_pools        : 0x2::bag::new(arg1),
        };
        let v1 = LootboxCreated{prize_pools_parent: 0x2::object::id<0x2::bag::Bag>(&v0.prize_pools)};
        0x2::event::emit<LootboxCreated>(v1);
        0x2::transfer::share_object<LootboxTreasury>(v0);
    }

    public fun deposit<T0>(arg0: &AdminCap, arg1: &mut LootboxTreasury, arg2: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = PrizePoolName<T0>{dummy_field: false};
        let v2 = 0x2::bag::borrow_mut<PrizePoolName<T0>, PrizePool<T0>>(&mut arg1.prize_pools, v1);
        assert!(v2.enabled, 1);
        assert!(v0 > 0, 3);
        0x2::balance::join<T0>(&mut v2.liquidity, 0x2::coin::into_balance<T0>(arg2));
        let v3 = Deposited<T0>{deposit_amount: v0};
        0x2::event::emit<Deposited<T0>>(v3);
    }

    fun get_prize_amount(arg0: u64, arg1: u8, arg2: u64, arg3: bool, arg4: u64, arg5: &LootboxSettings) : u64 {
        if (arg2 == 16489) {
            1 * arg4
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
        };
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<LOOTBOX>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<LootboxSettings>(v1);
    }

    public fun open_lootbox<T0>(arg0: &mut LootboxTreasury, arg1: Lootbox<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &LootboxSettings, arg4: &mut 0x2::tx_context::TxContext) {
        let Lootbox {
            id         : v0,
            magic      : v1,
            tier       : v2,
            amount     : v3,
            use_amount : v4,
        } = arg1;
        0x2::object::delete(v0);
        let v5 = get_prize_amount(v1, v2, v3, v4, 0x1::u64::pow(10, 0x2::coin::get_decimals<T0>(arg2)), arg3);
        let v6 = PrizePoolName<T0>{dummy_field: false};
        let v7 = 0x2::bag::borrow_mut<PrizePoolName<T0>, PrizePool<T0>>(&mut arg0.prize_pools, v6);
        assert!(v7.enabled, 1);
        assert!(v5 <= 0x2::balance::value<T0>(&v7.liquidity), 2);
        let v8 = 0x2::balance::split<T0>(&mut v7.liquidity, v5);
        let v9 = 0x2::tx_context::sender(arg4);
        pay_from_balance<T0>(v8, v9, arg4);
        let v10 = LootboxOpened<T0>{
            lootbox_opener : v9,
            price_value    : 0x2::balance::value<T0>(&v8),
        };
        0x2::event::emit<LootboxOpened<T0>>(v10);
    }

    fun pay_from_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun withdraw<T0>(arg0: &AdminCap, arg1: &mut LootboxTreasury, arg2: &0x2::coin::CoinMetadata<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
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

