module 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config {
    struct ConfigCap has store, key {
        id: 0x2::object::UID,
    }

    struct Change has copy, drop, store {
        at_ms: u64,
        keys: vector<u8>,
        bps: vector<u16>,
        treasury: address,
    }

    struct Config has key {
        id: 0x2::object::UID,
        rev: u64,
        halted: bool,
        treasury: address,
        fees: 0x2::vec_map::VecMap<u8, u16>,
        queued: 0x1::option::Option<Change>,
    }

    public fun apply(arg0: &mut Config, arg1: &0x2::clock::Clock) {
        assert!(0x1::option::is_some<Change>(&arg0.queued), 50);
        assert!(0x2::clock::timestamp_ms(arg1) >= 0x1::option::borrow<Change>(&arg0.queued).at_ms, 51);
        let Change {
            at_ms    : _,
            keys     : v1,
            bps      : v2,
            treasury : v3,
        } = 0x1::option::extract<Change>(&mut arg0.queued);
        let v4 = v2;
        let v5 = v1;
        let v6 = 0x1::vector::length<u8>(&v5);
        while (v6 > 0) {
            v6 = v6 - 1;
            let v7 = *0x1::vector::borrow<u8>(&v5, v6);
            if (0x2::vec_map::contains<u8, u16>(&arg0.fees, &v7)) {
                *0x2::vec_map::get_mut<u8, u16>(&mut arg0.fees, &v7) = *0x1::vector::borrow<u16>(&v4, v6);
                continue
            };
            0x2::vec_map::insert<u8, u16>(&mut arg0.fees, v7, *0x1::vector::borrow<u16>(&v4, v6));
        };
        arg0.treasury = v3;
        let (v8, v9) = 0x2::vec_map::into_keys_values<u8, u16>(arg0.fees);
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::events::fees_applied(0x2::object::id<Config>(arg0), v3, v8, v9);
    }

    public fun bundle_bps(arg0: &Config) : u16 {
        rate(arg0, 5)
    }

    public fun discard(arg0: &ConfigCap, arg1: &mut Config) {
        assert!(0x1::option::is_some<Change>(&arg1.queued), 50);
        arg1.queued = 0x1::option::none<Change>();
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::events::fees_discarded(0x2::object::id<Config>(arg1));
    }

    public fun fee_of(arg0: u64, arg1: u16) : u64 {
        let v0 = (arg1 as u64);
        arg0 / 10000 * v0 + arg0 % 10000 * v0 / 10000
    }

    public(friend) fun gate(arg0: &Config) {
        assert!(!arg0.halted, 20);
        assert!(arg0.rev == 1, 21);
    }

    public(friend) fun gate_rev(arg0: u64) {
        assert!(1 >= arg0, 22);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::empty<u8, u16>();
        let v1 = 0x1::vector::empty<u8>();
        let v2 = &mut v1;
        0x1::vector::push_back<u8>(v2, 1);
        0x1::vector::push_back<u8>(v2, 2);
        0x1::vector::push_back<u8>(v2, 3);
        0x1::vector::push_back<u8>(v2, 4);
        0x1::vector::push_back<u8>(v2, 5);
        0x1::vector::reverse<u8>(&mut v1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(&v1)) {
            0x2::vec_map::insert<u8, u16>(&mut v0, 0x1::vector::pop_back<u8>(&mut v1), 10);
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<u8>(v1);
        let v4 = Config{
            id       : 0x2::object::new(arg0),
            rev      : 1,
            halted   : false,
            treasury : 0x2::tx_context::sender(arg0),
            fees     : v0,
            queued   : 0x1::option::none<Change>(),
        };
        0x2::transfer::share_object<Config>(v4);
        let v5 = ConfigCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<ConfigCap>(v5, 0x2::tx_context::sender(arg0));
    }

    public fun is_halted(arg0: &Config) : bool {
        arg0.halted
    }

    public fun key_bundle() : u8 {
        5
    }

    public fun key_listing() : u8 {
        1
    }

    public fun key_offer() : u8 {
        2
    }

    public fun key_raffle() : u8 {
        4
    }

    public fun key_swap() : u8 {
        3
    }

    public fun listing_bps(arg0: &Config) : u16 {
        rate(arg0, 1)
    }

    public fun max_bps() : u16 {
        300
    }

    public fun migrate(arg0: &ConfigCap, arg1: &mut Config) {
        assert!(1 > arg1.rev, 52);
        arg1.rev = 1;
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::events::market_migrated(0x2::object::id<Config>(arg1), 1);
    }

    public fun offer_bps(arg0: &Config) : u16 {
        rate(arg0, 2)
    }

    public(friend) fun pay_out(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<0x2::sui::SUI>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(arg0);
        };
    }

    public fun queue(arg0: &ConfigCap, arg1: &mut Config, arg2: vector<u8>, arg3: vector<u16>, arg4: address, arg5: &0x2::clock::Clock) {
        assert!(arg1.rev == 1, 21);
        assert!(0x1::vector::length<u8>(&arg2) == 0x1::vector::length<u16>(&arg3), 54);
        let v0 = &arg3;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u16>(v0)) {
            assert!(*0x1::vector::borrow<u16>(v0, v1) <= 300, 53);
            v1 = v1 + 1;
        };
        let v2 = &arg2;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(v2)) {
            assert!(*0x1::vector::borrow<u8>(v2, v3) != 0, 54);
            v3 = v3 + 1;
        };
        let v4 = 0x2::clock::timestamp_ms(arg5) + 172800000;
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::events::fees_queued(0x2::object::id<Config>(arg1), arg4, arg2, arg3, v4);
        let v5 = Change{
            at_ms    : v4,
            keys     : arg2,
            bps      : arg3,
            treasury : arg4,
        };
        arg1.queued = 0x1::option::some<Change>(v5);
    }

    public fun queued_at_ms(arg0: &Config) : 0x1::option::Option<u64> {
        let v0 = &arg0.queued;
        if (0x1::option::is_some<Change>(v0)) {
            0x1::option::some<u64>(0x1::option::borrow<Change>(v0).at_ms)
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun raffle_bps(arg0: &Config) : u16 {
        rate(arg0, 4)
    }

    public fun rate(arg0: &Config, arg1: u8) : u16 {
        if (0x2::vec_map::contains<u8, u16>(&arg0.fees, &arg1)) {
            *0x2::vec_map::get<u8, u16>(&arg0.fees, &arg1)
        } else {
            0
        }
    }

    public(friend) fun rev() : u64 {
        1
    }

    public fun revision(arg0: &Config) : u64 {
        arg0.rev
    }

    public fun set_halted(arg0: &ConfigCap, arg1: &mut Config, arg2: bool) {
        arg1.halted = arg2;
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::events::market_halted(0x2::object::id<Config>(arg1), arg2);
    }

    public fun swap_bps(arg0: &Config) : u16 {
        rate(arg0, 3)
    }

    public fun treasury(arg0: &Config) : address {
        arg0.treasury
    }

    public fun wait_ms() : u64 {
        172800000
    }

    // decompiled from Move bytecode v7
}

