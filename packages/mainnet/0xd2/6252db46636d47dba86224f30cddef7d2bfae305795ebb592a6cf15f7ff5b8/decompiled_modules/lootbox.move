module 0xd2e44dc1311833ddb0427f2141e2935720cf5454cf0ef39141fc80c19e1e6caa::lootbox {
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

    struct Lootbox has store, key {
        id: 0x2::object::UID,
        magic: u64,
        tier: u8,
        expiration_epoch: u64,
    }

    struct LootboxWithAmount<phantom T0> has store, key {
        id: 0x2::object::UID,
        amount: u64,
        expiration_epoch: u64,
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

    public fun admin_issue_lootbox(arg0: &AdminCap, arg1: u8, arg2: address, arg3: &mut LootboxSettings, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Lootbox{
            id               : 0x2::object::new(arg4),
            magic            : arg3.seed,
            tier             : arg1,
            expiration_epoch : 0x2::tx_context::epoch(arg4) + 30,
        };
        arg3.seed = arg3.seed + 1;
        let v1 = LootboxIssued{lootbox: 0x2::object::id<Lootbox>(&v0)};
        0x2::event::emit<LootboxIssued>(v1);
        0x2::transfer::transfer<Lootbox>(v0, arg2);
    }

    public fun admin_issue_lootbox_with_amount<T0>(arg0: &AdminCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = LootboxWithAmount<T0>{
            id               : 0x2::object::new(arg3),
            amount           : arg1,
            expiration_epoch : 0x2::tx_context::epoch(arg3) + 30,
        };
        let v1 = LootboxIssued{lootbox: 0x2::object::id<LootboxWithAmount<T0>>(&v0)};
        0x2::event::emit<LootboxIssued>(v1);
        0x2::transfer::transfer<LootboxWithAmount<T0>>(v0, arg2);
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

    fun get_prize_amount(arg0: u64, arg1: u8, arg2: u64, arg3: &LootboxSettings) : u64 {
        if (arg1 == 0) {
            if (arg0 % arg3.prize_tier_0_probability == 0) {
                arg3.prize_tier_0 * arg2
            } else {
                0
            }
        } else if (arg1 == 1) {
            if (arg0 % arg3.prize_tier_1_probability == 0) {
                arg3.prize_tier_1 * arg2
            } else {
                0
            }
        } else if (arg1 == 2) {
            if (arg0 % arg3.prize_tier_2_probability == 0) {
                arg3.prize_tier_2 * arg2
            } else {
                0
            }
        } else {
            0
        }
    }

    fun init(arg0: LOOTBOX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<LOOTBOX>(arg0, arg1);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        let v2 = LootboxSettings{
            id                       : 0x2::object::new(arg1),
            prize_tier_0             : 0,
            prize_tier_0_probability : 1,
            prize_tier_1             : 0,
            prize_tier_1_probability : 1,
            prize_tier_2             : 0,
            prize_tier_2_probability : 1,
            seed                     : 0,
        };
        let v3 = 0x2::display::new<Lootbox>(&v0, arg1);
        0x2::display::add<Lootbox>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"SLP Lootbox"));
        0x2::display::add<Lootbox>(&mut v3, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"A mysterious SLP lootbox. Try your luck!"));
        0x2::display::add<Lootbox>(&mut v3, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://www.sudo.finance/"));
        0x2::display::add<Lootbox>(&mut v3, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://scard.sudo.finance/"));
        0x2::display::add<Lootbox>(&mut v3, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Sudo Finance"));
        0x2::display::add<Lootbox>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://img.sudofinance.xyz/slootbox/lootbox.webp"));
        0x2::display::update_version<Lootbox>(&mut v3);
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Lootbox>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<LootboxSettings>(v2);
    }

    entry fun open_lootbox<T0>(arg0: &mut LootboxTreasury, arg1: Lootbox, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &LootboxSettings, arg4: &mut 0x2::tx_context::TxContext) {
        let Lootbox {
            id               : v0,
            magic            : v1,
            tier             : v2,
            expiration_epoch : v3,
        } = arg1;
        assert!(0x2::tx_context::epoch(arg4) < v3, 4);
        0x2::object::delete(v0);
        let v4 = get_prize_amount(v1, v2, 0x2::math::pow(10, 0x2::coin::get_decimals<T0>(arg2)), arg3);
        let v5 = PrizePoolName<T0>{dummy_field: false};
        let v6 = 0x2::bag::borrow_mut<PrizePoolName<T0>, PrizePool<T0>>(&mut arg0.prize_pools, v5);
        assert!(v6.enabled, 1);
        assert!(v4 <= 0x2::balance::value<T0>(&v6.liquidity), 2);
        let v7 = 0x2::balance::split<T0>(&mut v6.liquidity, v4);
        let v8 = 0x2::tx_context::sender(arg4);
        pay_from_balance<T0>(v7, v8, arg4);
        let v9 = LootboxOpened<T0>{
            lootbox_opener : v8,
            price_value    : 0x2::balance::value<T0>(&v7),
        };
        0x2::event::emit<LootboxOpened<T0>>(v9);
    }

    entry fun open_lootbox_with_amount<T0>(arg0: &mut LootboxTreasury, arg1: LootboxWithAmount<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let LootboxWithAmount {
            id               : v0,
            amount           : v1,
            expiration_epoch : v2,
        } = arg1;
        assert!(0x2::tx_context::epoch(arg3) < v2, 4);
        let v3 = v1 * 0x2::math::pow(10, 0x2::coin::get_decimals<T0>(arg2));
        0x2::object::delete(v0);
        let v4 = PrizePoolName<T0>{dummy_field: false};
        let v5 = 0x2::bag::borrow_mut<PrizePoolName<T0>, PrizePool<T0>>(&mut arg0.prize_pools, v4);
        assert!(v5.enabled, 1);
        assert!(v3 <= 0x2::balance::value<T0>(&v5.liquidity), 2);
        let v6 = 0x2::balance::split<T0>(&mut v5.liquidity, v3);
        let v7 = 0x2::tx_context::sender(arg3);
        pay_from_balance<T0>(v6, v7, arg3);
        let v8 = LootboxOpened<T0>{
            lootbox_opener : v7,
            price_value    : 0x2::balance::value<T0>(&v6),
        };
        0x2::event::emit<LootboxOpened<T0>>(v8);
    }

    fun pay_from_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun withdraw<T0>(arg0: &AdminCap, arg1: &mut LootboxTreasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = PrizePoolName<T0>{dummy_field: false};
        let v2 = 0x2::bag::borrow_mut<PrizePoolName<T0>, PrizePool<T0>>(&mut arg1.prize_pools, v1);
        assert!(v2.enabled, 1);
        assert!(arg2 <= 0x2::balance::value<T0>(&v2.liquidity), 2);
        let v3 = 0x2::balance::split<T0>(&mut v2.liquidity, arg2);
        pay_from_balance<T0>(v3, v0, arg3);
        let v4 = Withdrawn<T0>{withdraw_value: 0x2::balance::value<T0>(&v3)};
        0x2::event::emit<Withdrawn<T0>>(v4);
    }

    // decompiled from Move bytecode v6
}

