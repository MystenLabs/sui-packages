module 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config {
    struct ConfigCap has store, key {
        id: 0x2::object::UID,
    }

    struct Rates has copy, drop, store {
        bundle_bps: u16,
        raffle_bps: u16,
        swap_flat: u64,
        swap_bps: u16,
        offer_bps: u16,
        listing_bps: u16,
    }

    struct Queued has copy, drop, store {
        ready_ms: u64,
        treasury: address,
        rates: Rates,
    }

    struct Config has key {
        id: 0x2::object::UID,
        treasury: address,
        rates: Rates,
        queued: 0x1::option::Option<Queued>,
        paused: bool,
        version: u64,
    }

    public fun apply(arg0: &mut Config, arg1: &0x2::clock::Clock) {
        assert!(0x1::option::is_some<Queued>(&arg0.queued), 104);
        let Queued {
            ready_ms : v0,
            treasury : v1,
            rates    : v2,
        } = 0x1::option::extract<Queued>(&mut arg0.queued);
        let v3 = v2;
        assert!(0x2::clock::timestamp_ms(arg1) >= v0, 105);
        arg0.treasury = v1;
        arg0.rates = v3;
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::events::config_applied(0x2::object::id<Config>(arg0), v1, rates_vector(&v3));
    }

    public(friend) fun assert_object(arg0: u64) {
        assert!(arg0 <= 1, 102);
    }

    public(friend) fun assert_open(arg0: &Config) {
        assert!(arg0.version == 1, 102);
        assert!(!arg0.paused, 101);
    }

    public fun bundle_bps(arg0: &Config) : u16 {
        arg0.rates.bundle_bps
    }

    fun check_ceilings(arg0: &Rates) {
        assert!(arg0.listing_bps <= 500, 103);
        assert!(arg0.offer_bps <= 500, 103);
        assert!(arg0.swap_bps <= 500, 103);
        assert!(arg0.raffle_bps <= 500, 103);
        assert!(arg0.bundle_bps <= 500, 103);
        assert!(arg0.swap_flat <= 1000000000, 103);
    }

    public(friend) fun current() : u64 {
        1
    }

    fun default_rates() : Rates {
        Rates{
            bundle_bps  : 10,
            raffle_bps  : 10,
            swap_flat   : 0,
            swap_bps    : 10,
            offer_bps   : 10,
            listing_bps : 10,
        }
    }

    public fun delay_ms() : u64 {
        172800000
    }

    public fun discard(arg0: &ConfigCap, arg1: &mut Config) {
        assert!(0x1::option::is_some<Queued>(&arg1.queued), 104);
        arg1.queued = 0x1::option::none<Queued>();
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::events::config_discarded(0x2::object::id<Config>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id       : 0x2::object::new(arg0),
            treasury : 0x2::tx_context::sender(arg0),
            rates    : default_rates(),
            queued   : 0x1::option::none<Queued>(),
            paused   : false,
            version  : 1,
        };
        0x2::transfer::share_object<Config>(v0);
        let v1 = ConfigCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ConfigCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun listing_bps(arg0: &Config) : u16 {
        arg0.rates.listing_bps
    }

    public fun migrate(arg0: &ConfigCap, arg1: &mut Config) {
        assert!(arg1.version < 1, 106);
        arg1.version = 1;
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::events::config_migrated(0x2::object::id<Config>(arg1), 1);
    }

    public fun new_rates(arg0: u16, arg1: u16, arg2: u16, arg3: u64, arg4: u16, arg5: u16) : Rates {
        Rates{
            bundle_bps  : arg5,
            raffle_bps  : arg4,
            swap_flat   : arg3,
            swap_bps    : arg2,
            offer_bps   : arg1,
            listing_bps : arg0,
        }
    }

    public fun offer_bps(arg0: &Config) : u16 {
        arg0.rates.offer_bps
    }

    public fun portion(arg0: u64, arg1: u16) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public fun queue(arg0: &ConfigCap, arg1: &mut Config, arg2: Rates, arg3: address, arg4: &0x2::clock::Clock) {
        assert!(arg1.version == 1, 102);
        check_ceilings(&arg2);
        let v0 = 0x2::clock::timestamp_ms(arg4) + 172800000;
        let v1 = Queued{
            ready_ms : v0,
            treasury : arg3,
            rates    : arg2,
        };
        arg1.queued = 0x1::option::some<Queued>(v1);
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::events::config_queued(0x2::object::id<Config>(arg1), v0, arg3, rates_vector(&arg2));
    }

    public fun queued_ready_ms(arg0: &Config) : 0x1::option::Option<u64> {
        if (0x1::option::is_some<Queued>(&arg0.queued)) {
            0x1::option::some<u64>(0x1::option::borrow<Queued>(&arg0.queued).ready_ms)
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun raffle_bps(arg0: &Config) : u16 {
        arg0.rates.raffle_bps
    }

    public fun rate_ceiling_bps() : u16 {
        500
    }

    fun rates_vector(arg0: &Rates) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, (arg0.listing_bps as u64));
        0x1::vector::push_back<u64>(v1, (arg0.offer_bps as u64));
        0x1::vector::push_back<u64>(v1, (arg0.swap_bps as u64));
        0x1::vector::push_back<u64>(v1, arg0.swap_flat);
        0x1::vector::push_back<u64>(v1, (arg0.raffle_bps as u64));
        0x1::vector::push_back<u64>(v1, (arg0.bundle_bps as u64));
        v0
    }

    public(friend) fun send(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<0x2::sui::SUI>(&arg0) == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(arg0, arg2), arg1);
        };
    }

    public fun set_paused(arg0: &ConfigCap, arg1: &mut Config, arg2: bool) {
        arg1.paused = arg2;
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::events::config_paused(0x2::object::id<Config>(arg1), arg2);
    }

    public fun swap_bps(arg0: &Config) : u16 {
        arg0.rates.swap_bps
    }

    public fun swap_flat(arg0: &Config) : u64 {
        arg0.rates.swap_flat
    }

    public fun treasury(arg0: &Config) : address {
        arg0.treasury
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

