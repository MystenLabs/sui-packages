module 0xbaac739939538e93167c6063b3f0b9318d52b66677070676815c8266d328a340::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TreasuryCap has store, key {
        id: 0x2::object::UID,
    }

    struct BoxConfig has copy, drop, store {
        max_supply: u64,
        supply: u64,
        public_price: u64,
        whitelist_price: u64,
        whitelist_allocation: u64,
        whitelist_minted: u64,
        tier1_chance: u64,
        tier2_chance: u64,
        tier3_chance: u64,
        image_hash: 0x1::string::String,
    }

    struct WhitelistAllocation has store {
        allocation: u64,
        minted: u64,
    }

    struct WhitelistConfig has store {
        whitelist: 0x2::table::Table<address, WhitelistAllocation>,
        whitelist_start: u64,
        whitelist_end: u64,
    }

    struct Configuration has key {
        id: 0x2::object::UID,
        box_config: 0x2::table::Table<0x1::string::String, BoxConfig>,
        whitelist_config: WhitelistConfig,
        public_sale_start: u64,
        can_reveal: bool,
        supply: u64,
        paused: bool,
    }

    struct FundStorage has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun add_box_config(arg0: &mut Configuration, arg1: 0x1::string::String, arg2: BoxConfig, arg3: &AdminCap) {
        0x2::table::add<0x1::string::String, BoxConfig>(&mut arg0.box_config, arg1, arg2);
    }

    public fun admin_claim_fee(arg0: &mut FundStorage, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance), arg2)
    }

    public fun assert_address_allocation(arg0: &Configuration, arg1: address, arg2: u64) {
        let (v0, v1) = get_whitelist_allocation(arg0, arg1);
        assert!(v0 - v1 >= arg2, 11);
    }

    public fun assert_box_allocation(arg0: &Configuration, arg1: 0x1::string::String, arg2: u64) {
        let v0 = 0x2::table::borrow<0x1::string::String, BoxConfig>(&arg0.box_config, arg1);
        assert!(v0.whitelist_allocation - v0.whitelist_minted >= arg2, 10);
    }

    public fun assert_can_reveal(arg0: &Configuration) {
        assert!(arg0.can_reveal, 9);
    }

    public fun assert_enough_box(arg0: &Configuration, arg1: 0x1::string::String, arg2: u64) {
        let v0 = 0x2::table::borrow<0x1::string::String, BoxConfig>(&arg0.box_config, arg1);
        assert!(v0.supply + arg2 <= v0.max_supply, 7);
    }

    public fun assert_not_paused(arg0: &Configuration) {
        assert!(!arg0.paused, 8);
    }

    public fun assert_version(arg0: &Configuration) {
        assert!(*0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, 0x1::string::utf8(b"version")) == 1, 1000);
    }

    public fun batch_update_whitelist_allocation(arg0: &mut Configuration, arg1: vector<address>, arg2: vector<u64>, arg3: &AdminCap) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            update_whitelist_allocation_int(arg0, *0x1::vector::borrow<address>(&arg1, v0), *0x1::vector::borrow<u64>(&arg2, v0));
            v0 = v0 + 1;
        };
    }

    public fun can_reveal(arg0: &Configuration) : bool {
        arg0.can_reveal
    }

    public fun check_mint_phase(arg0: &Configuration, arg1: &0x2::clock::Clock) : (bool, bool) {
        let v0 = arg0.whitelist_config.whitelist_start;
        let v1 = arg0.whitelist_config.whitelist_end;
        let v2 = public_sale_start(arg0);
        let v3 = if (v0 != 0) {
            if (v1 != 0) {
                if (0x2::clock::timestamp_ms(arg1) >= v0) {
                    0x2::clock::timestamp_ms(arg1) <= v1
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v4 = v2 != 0 && 0x2::clock::timestamp_ms(arg1) >= v2;
        (v3, v4)
    }

    public(friend) fun collect_sui(arg0: &mut FundStorage, arg1: &BoxConfig, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: bool) : (u64, u64) {
        let v0 = if (arg3) {
            arg1.whitelist_price
        } else {
            arg1.public_price
        };
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2) / v0;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) % v0 == 0, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v2 = v1;
        if (!arg3) {
            let v3 = v1 + v1 / 10 * 3;
            v2 = v3;
            if (v1 % 10 >= 5) {
                v2 = v3 + 1;
            };
        };
        (v1, v2)
    }

    public(friend) fun generate_tier(arg0: &Configuration, arg1: 0x1::string::String, arg2: &mut 0x2::random::RandomGenerator) : 0x1::string::String {
        let v0 = (0x2::random::generate_u128_in_range(arg2, 0, 99) as u64);
        let BoxConfig {
            max_supply           : _,
            supply               : _,
            public_price         : _,
            whitelist_price      : _,
            whitelist_allocation : _,
            whitelist_minted     : _,
            tier1_chance         : v7,
            tier2_chance         : v8,
            tier3_chance         : v9,
            image_hash           : _,
        } = *get_box_config(arg0, arg1);
        let v11 = if (v0 < v7) {
            b"Pirate"
        } else if (v0 < v7 + v8) {
            b"Ninja"
        } else if (v0 < v7 + v8 + v9) {
            b"Samurai"
        } else {
            b"Lord"
        };
        0x1::string::utf8(v11)
    }

    public fun get_box_config(arg0: &Configuration, arg1: 0x1::string::String) : &BoxConfig {
        0x2::table::borrow<0x1::string::String, BoxConfig>(&arg0.box_config, arg1)
    }

    public fun get_whitelist_allocation(arg0: &Configuration, arg1: address) : (u64, u64) {
        if (0x2::table::contains<address, WhitelistAllocation>(&arg0.whitelist_config.whitelist, arg1)) {
            let v2 = 0x2::table::borrow<address, WhitelistAllocation>(&arg0.whitelist_config.whitelist, arg1);
            (v2.allocation, v2.minted)
        } else {
            (0, 0)
        }
    }

    public fun image_hash(arg0: &BoxConfig) : 0x1::string::String {
        arg0.image_hash
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = WhitelistConfig{
            whitelist       : 0x2::table::new<address, WhitelistAllocation>(arg0),
            whitelist_start : 0,
            whitelist_end   : 0,
        };
        let v1 = Configuration{
            id                : 0x2::object::new(arg0),
            box_config        : 0x2::table::new<0x1::string::String, BoxConfig>(arg0),
            whitelist_config  : v0,
            public_sale_start : 0,
            can_reveal        : false,
            supply            : 0,
            paused            : true,
        };
        let v2 = FundStorage{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Configuration>(v1);
        0x2::transfer::share_object<FundStorage>(v2);
        let v3 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg0));
    }

    public fun max_supply() : u64 {
        4000
    }

    public fun mint_treasury_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : TreasuryCap {
        TreasuryCap{id: 0x2::object::new(arg1)}
    }

    public fun new_box_config(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::string::String) : BoxConfig {
        let v0 = if (arg1 > 0) {
            if (arg2 > 0) {
                arg1 > arg2
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 5);
        assert!(arg4 + arg5 + arg6 <= 100, 6);
        BoxConfig{
            max_supply           : arg0,
            supply               : 0,
            public_price         : arg1,
            whitelist_price      : arg2,
            whitelist_allocation : arg3,
            whitelist_minted     : 0,
            tier1_chance         : arg4,
            tier2_chance         : arg5,
            tier3_chance         : arg6,
            image_hash           : arg7,
        }
    }

    public fun public_sale_start(arg0: &Configuration) : u64 {
        arg0.public_sale_start
    }

    public fun set_can_reveal(arg0: &mut Configuration, arg1: bool, arg2: &AdminCap) {
        arg0.can_reveal = arg1;
    }

    public fun set_paused(arg0: &mut Configuration, arg1: bool, arg2: &AdminCap) {
        arg0.paused = arg1;
    }

    public fun set_version(arg0: &mut Configuration, arg1: u64, arg2: &AdminCap) {
        let v0 = 0x1::string::utf8(b"version");
        0x2::dynamic_field::remove_if_exists<0x1::string::String, u64>(&mut arg0.id, v0);
        0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg0.id, v0, arg1);
    }

    public fun supply(arg0: &Configuration) : u64 {
        arg0.supply
    }

    public(friend) fun update_after_sale(arg0: &mut Configuration, arg1: 0x1::string::String, arg2: u64, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<0x1::string::String, BoxConfig>(&mut arg0.box_config, arg1);
        v0.supply = v0.supply + arg2;
        if (arg3) {
            v0.whitelist_minted = v0.whitelist_minted + arg2;
        };
        if (arg3) {
            let v1 = 0x2::table::borrow_mut<address, WhitelistAllocation>(&mut arg0.whitelist_config.whitelist, 0x2::tx_context::sender(arg4));
            v1.minted = v1.minted + arg2;
        };
        arg0.supply = arg0.supply + arg2;
    }

    public fun update_box_chance(arg0: &mut Configuration, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: &AdminCap) {
        assert!(arg2 + arg3 + arg4 <= 100, 6);
        let v0 = 0x2::table::borrow_mut<0x1::string::String, BoxConfig>(&mut arg0.box_config, arg1);
        v0.tier1_chance = arg2;
        v0.tier2_chance = arg3;
        v0.tier3_chance = arg4;
    }

    public fun update_box_max_supply(arg0: &mut Configuration, arg1: 0x1::string::String, arg2: u64, arg3: &AdminCap) {
        let v0 = 0x2::table::borrow_mut<0x1::string::String, BoxConfig>(&mut arg0.box_config, arg1);
        assert!(arg2 >= v0.supply, 3);
        v0.max_supply = arg2;
    }

    public fun update_box_price(arg0: &mut Configuration, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: &AdminCap) {
        let v0 = if (arg2 > 0) {
            if (arg3 > 0) {
                arg2 > arg3
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 5);
        let v1 = 0x2::table::borrow_mut<0x1::string::String, BoxConfig>(&mut arg0.box_config, arg1);
        v1.public_price = arg2;
        v1.whitelist_price = arg3;
    }

    public fun update_box_whitelist_allocation(arg0: &mut Configuration, arg1: 0x1::string::String, arg2: u64, arg3: &AdminCap) {
        let v0 = 0x2::table::borrow_mut<0x1::string::String, BoxConfig>(&mut arg0.box_config, arg1);
        assert!(arg2 >= v0.whitelist_minted, 4);
        v0.whitelist_allocation = arg2;
    }

    public fun update_public_sale_start(arg0: &mut Configuration, arg1: u64, arg2: &AdminCap) {
        let v0 = arg0.whitelist_config.whitelist_end;
        if (v0 != 0) {
            assert!(arg1 > v0, 2);
        };
        arg0.public_sale_start = arg1;
    }

    public fun update_whitelist_allocation(arg0: &mut Configuration, arg1: address, arg2: u64, arg3: &AdminCap) {
        update_whitelist_allocation_int(arg0, arg1, arg2);
    }

    fun update_whitelist_allocation_int(arg0: &mut Configuration, arg1: address, arg2: u64) {
        let v0 = &mut arg0.whitelist_config.whitelist;
        if (!0x2::table::contains<address, WhitelistAllocation>(v0, arg1)) {
            let v1 = WhitelistAllocation{
                allocation : arg2,
                minted     : 0,
            };
            0x2::table::add<address, WhitelistAllocation>(v0, arg1, v1);
        } else {
            let v2 = 0x2::table::borrow_mut<address, WhitelistAllocation>(v0, arg1);
            assert!(arg2 >= v2.minted, 12);
            v2.allocation = arg2;
        };
    }

    public fun update_whitelist_dates(arg0: &mut Configuration, arg1: u64, arg2: u64, arg3: &AdminCap) {
        assert!(arg1 < arg2, 0);
        if (arg0.public_sale_start != 0) {
            assert!(arg2 < arg0.public_sale_start, 0);
        };
        arg0.whitelist_config.whitelist_start = arg1;
        arg0.whitelist_config.whitelist_end = arg2;
    }

    public fun version() : u64 {
        1
    }

    public fun whitelist_config(arg0: &Configuration) : &WhitelistConfig {
        &arg0.whitelist_config
    }

    public fun whitelist_end(arg0: &WhitelistConfig) : u64 {
        arg0.whitelist_end
    }

    public fun whitelist_start(arg0: &WhitelistConfig) : u64 {
        arg0.whitelist_start
    }

    // decompiled from Move bytecode v6
}

