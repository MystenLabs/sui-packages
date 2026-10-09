module 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeTier has copy, drop, store {
        fee_rate: u64,
        tick_spacing: u32,
        protocol_share_bps: u64,
    }

    struct PoolKey has copy, drop, store {
        low: 0x1::type_name::TypeName,
        high: 0x1::type_name::TypeName,
        fee_rate: u64,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        tiers: 0x2::vec_map::VecMap<u64, FeeTier>,
        ppx_bps: u64,
        ppx_recipient: address,
        treasury: address,
        pools: 0x2::table::Table<PoolKey, 0x2::object::ID>,
    }

    struct FeeTierChanged has copy, drop {
        config: 0x2::object::ID,
        fee_rate: u64,
        tier: 0x1::option::Option<FeeTier>,
    }

    struct RecipientsChanged has copy, drop {
        config: 0x2::object::ID,
        ppx_bps: u64,
        ppx_recipient: address,
        treasury: address,
    }

    struct PauseChanged has copy, drop {
        config: 0x2::object::ID,
        paused: bool,
    }

    struct Migrated has copy, drop {
        config: 0x2::object::ID,
        from: u64,
        to: u64,
    }

    public fun assert_open(arg0: &Config) {
        assert_version(arg0);
        assert!(!arg0.paused, 2);
    }

    public fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 1);
    }

    public fun fee_rate(arg0: &FeeTier) : u64 {
        arg0.fee_rate
    }

    public fun fee_rates(arg0: &Config) : vector<u64> {
        assert_version(arg0);
        0x2::vec_map::keys<u64, FeeTier>(&arg0.tiers)
    }

    public fun fee_tier(arg0: &Config, arg1: u64) : FeeTier {
        assert_version(arg0);
        assert!(0x2::vec_map::contains<u64, FeeTier>(&arg0.tiers, &arg1), 3);
        *0x2::vec_map::get<u64, FeeTier>(&arg0.tiers, &arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id            : 0x2::object::new(arg0),
            version       : 1,
            paused        : false,
            tiers         : 0x2::vec_map::empty<u64, FeeTier>(),
            ppx_bps       : 5000,
            ppx_recipient : 0x2::tx_context::sender(arg0),
            treasury      : 0x2::tx_context::sender(arg0),
            pools         : 0x2::table::new<PoolKey, 0x2::object::ID>(arg0),
        };
        let v1 = &mut v0;
        insert_tier(v1, new_fee_tier(100, 2, 2000));
        let v2 = &mut v0;
        insert_tier(v2, new_fee_tier(500, 10, 2000));
        let v3 = &mut v0;
        insert_tier(v3, new_fee_tier(3000, 60, 2000));
        let v4 = &mut v0;
        insert_tier(v4, new_fee_tier(10000, 200, 2000));
        let v5 = &mut v0;
        insert_tier(v5, new_fee_tier(20000, 400, 2000));
        0x2::transfer::share_object<Config>(v0);
        let v6 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg0));
    }

    fun insert_tier(arg0: &mut Config, arg1: FeeTier) {
        if (0x2::vec_map::contains<u64, FeeTier>(&arg0.tiers, &arg1.fee_rate)) {
            let (_, _) = 0x2::vec_map::remove<u64, FeeTier>(&mut arg0.tiers, &arg1.fee_rate);
        };
        0x2::vec_map::insert<u64, FeeTier>(&mut arg0.tiers, arg1.fee_rate, arg1);
    }

    fun lexicographically_less(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        let v2 = 0;
        while (v2 < v0 && v2 < v1) {
            if (*0x1::vector::borrow<u8>(arg0, v2) != *0x1::vector::borrow<u8>(arg1, v2)) {
                return *0x1::vector::borrow<u8>(arg0, v2) < *0x1::vector::borrow<u8>(arg1, v2)
            };
            v2 = v2 + 1;
        };
        v0 < v1
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Config) {
        assert!(arg1.version < 1, 1);
        let v0 = Migrated{
            config : 0x2::object::id<Config>(arg1),
            from   : arg1.version,
            to     : 1,
        };
        0x2::event::emit<Migrated>(v0);
        arg1.version = 1;
    }

    public fun new_fee_tier(arg0: u64, arg1: u32, arg2: u64) : FeeTier {
        assert!(arg0 <= 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math::max_fee_rate(), 3);
        assert!(arg1 > 0 && arg1 <= 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::tick_math::max_tick_spacing(), 3);
        assert!(arg2 <= 5000, 3);
        FeeTier{
            fee_rate           : arg0,
            tick_spacing       : arg1,
            protocol_share_bps : arg2,
        }
    }

    public fun paused(arg0: &Config) : bool {
        assert_version(arg0);
        arg0.paused
    }

    public fun pool_id<T0, T1>(arg0: &Config, arg1: u64) : 0x1::option::Option<0x2::object::ID> {
        assert_version(arg0);
        let v0 = pool_key<T0, T1>(arg1);
        if (0x2::table::contains<PoolKey, 0x2::object::ID>(&arg0.pools, v0)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<PoolKey, 0x2::object::ID>(&arg0.pools, v0))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    fun pool_key<T0, T1>(arg0: u64) : PoolKey {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        assert!(v0 != v1, 7);
        let (v2, v3) = if (lexicographically_less(0x1::ascii::as_bytes(0x1::type_name::as_string(&v0)), 0x1::ascii::as_bytes(0x1::type_name::as_string(&v1)))) {
            (v0, v1)
        } else {
            (v1, v0)
        };
        PoolKey{
            low      : v2,
            high     : v3,
            fee_rate : arg0,
        }
    }

    public fun ppx_bps(arg0: &Config) : u64 {
        assert_version(arg0);
        arg0.ppx_bps
    }

    public fun ppx_recipient(arg0: &Config) : address {
        assert_version(arg0);
        arg0.ppx_recipient
    }

    public fun protocol_share_bps(arg0: &FeeTier) : u64 {
        arg0.protocol_share_bps
    }

    public(friend) fun register_pool<T0, T1>(arg0: &mut Config, arg1: u64, arg2: 0x2::object::ID) {
        assert_open(arg0);
        let v0 = pool_key<T0, T1>(arg1);
        assert!(!0x2::table::contains<PoolKey, 0x2::object::ID>(&arg0.pools, v0), 6);
        0x2::table::add<PoolKey, 0x2::object::ID>(&mut arg0.pools, v0, arg2);
    }

    public fun remove_fee_tier(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert_version(arg1);
        assert!(0x2::vec_map::contains<u64, FeeTier>(&arg1.tiers, &arg2), 3);
        let (_, _) = 0x2::vec_map::remove<u64, FeeTier>(&mut arg1.tiers, &arg2);
        let v2 = FeeTierChanged{
            config   : 0x2::object::id<Config>(arg1),
            fee_rate : arg2,
            tier     : 0x1::option::none<FeeTier>(),
        };
        0x2::event::emit<FeeTierChanged>(v2);
    }

    public fun set_fee_tier(arg0: &AdminCap, arg1: &mut Config, arg2: FeeTier) {
        assert_version(arg1);
        insert_tier(arg1, arg2);
        let v0 = FeeTierChanged{
            config   : 0x2::object::id<Config>(arg1),
            fee_rate : arg2.fee_rate,
            tier     : 0x1::option::some<FeeTier>(arg2),
        };
        0x2::event::emit<FeeTierChanged>(v0);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        assert_version(arg1);
        arg1.paused = arg2;
        let v0 = PauseChanged{
            config : 0x2::object::id<Config>(arg1),
            paused : arg2,
        };
        0x2::event::emit<PauseChanged>(v0);
    }

    public fun set_recipients(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: address, arg4: address) {
        assert_version(arg1);
        assert!(arg2 <= 0x17b04168da4b3d5fe07154956c509e45e4c3b8a4c03b22c5d94c5380b244737a::clmm_math::basis(), 4);
        assert!(arg3 != @0x0 && arg4 != @0x0, 5);
        arg1.ppx_bps = arg2;
        arg1.ppx_recipient = arg3;
        arg1.treasury = arg4;
        let v0 = RecipientsChanged{
            config        : 0x2::object::id<Config>(arg1),
            ppx_bps       : arg2,
            ppx_recipient : arg3,
            treasury      : arg4,
        };
        0x2::event::emit<RecipientsChanged>(v0);
    }

    public fun tick_spacing(arg0: &FeeTier) : u32 {
        arg0.tick_spacing
    }

    public fun treasury(arg0: &Config) : address {
        assert_version(arg0);
        arg0.treasury
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

