module 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Preset has copy, drop, store {
        bin_step: u64,
        base_factor: u64,
        filter_period_ms: u64,
        decay_period_ms: u64,
        reduction_factor: u64,
        variable_fee_control: u64,
        max_volatility_accumulator: u64,
        protocol_share_bps: u64,
    }

    struct PoolKey has copy, drop, store {
        low: 0x1::type_name::TypeName,
        high: 0x1::type_name::TypeName,
        bin_step: u64,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        presets: 0x2::vec_map::VecMap<u64, Preset>,
        ppx_bps: u64,
        ppx_recipient: address,
        treasury: address,
        pools: 0x2::table::Table<PoolKey, 0x2::object::ID>,
    }

    struct PresetChanged has copy, drop {
        config: 0x2::object::ID,
        bin_step: u64,
        preset: 0x1::option::Option<Preset>,
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

    public fun base_factor(arg0: &Preset) : u64 {
        arg0.base_factor
    }

    public fun bin_step(arg0: &Preset) : u64 {
        arg0.bin_step
    }

    public fun bin_steps(arg0: &Config) : vector<u64> {
        assert_version(arg0);
        0x2::vec_map::keys<u64, Preset>(&arg0.presets)
    }

    public fun decay_period_ms(arg0: &Preset) : u64 {
        arg0.decay_period_ms
    }

    public fun filter_period_ms(arg0: &Preset) : u64 {
        arg0.filter_period_ms
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id            : 0x2::object::new(arg0),
            version       : 1,
            paused        : false,
            presets       : 0x2::vec_map::empty<u64, Preset>(),
            ppx_bps       : 5000,
            ppx_recipient : 0x2::tx_context::sender(arg0),
            treasury      : 0x2::tx_context::sender(arg0),
            pools         : 0x2::table::new<PoolKey, 0x2::object::ID>(arg0),
        };
        let v1 = &mut v0;
        insert_preset(v1, new_preset(100, 10000, 30000, 600000, 5000, 7000, 350000, 2000));
        let v2 = &mut v0;
        insert_preset(v2, new_preset(25, 10000, 30000, 600000, 5000, 40000, 350000, 2000));
        0x2::transfer::share_object<Config>(v0);
        let v3 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg0));
    }

    fun insert_preset(arg0: &mut Config, arg1: Preset) {
        if (0x2::vec_map::contains<u64, Preset>(&arg0.presets, &arg1.bin_step)) {
            let (_, _) = 0x2::vec_map::remove<u64, Preset>(&mut arg0.presets, &arg1.bin_step);
        };
        0x2::vec_map::insert<u64, Preset>(&mut arg0.presets, arg1.bin_step, arg1);
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

    public fun max_volatility_accumulator(arg0: &Preset) : u64 {
        arg0.max_volatility_accumulator
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

    public fun new_preset(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : Preset {
        assert!(arg0 > 0 && arg0 <= 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::max_bin_step(), 3);
        assert!(arg2 < arg3 && arg4 <= 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::basis(), 3);
        assert!(arg6 <= 10000000 && arg7 <= 5000, 3);
        assert!(arg1 > 0 && (0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::base_fee_rate(arg1, arg0) as u128) + (0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::variable_fee_rate(arg6, arg0, arg5) as u128) <= (0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::max_fee_rate() as u128), 3);
        Preset{
            bin_step                   : arg0,
            base_factor                : arg1,
            filter_period_ms           : arg2,
            decay_period_ms            : arg3,
            reduction_factor           : arg4,
            variable_fee_control       : arg5,
            max_volatility_accumulator : arg6,
            protocol_share_bps         : arg7,
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
            bin_step : arg0,
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

    public fun preset(arg0: &Config, arg1: u64) : Preset {
        assert_version(arg0);
        assert!(0x2::vec_map::contains<u64, Preset>(&arg0.presets, &arg1), 3);
        *0x2::vec_map::get<u64, Preset>(&arg0.presets, &arg1)
    }

    public fun protocol_share_bps(arg0: &Preset) : u64 {
        arg0.protocol_share_bps
    }

    public fun reduction_factor(arg0: &Preset) : u64 {
        arg0.reduction_factor
    }

    public(friend) fun register_pool<T0, T1>(arg0: &mut Config, arg1: u64, arg2: 0x2::object::ID) {
        assert_open(arg0);
        let v0 = pool_key<T0, T1>(arg1);
        assert!(!0x2::table::contains<PoolKey, 0x2::object::ID>(&arg0.pools, v0), 6);
        0x2::table::add<PoolKey, 0x2::object::ID>(&mut arg0.pools, v0, arg2);
    }

    public fun remove_preset(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert_version(arg1);
        assert!(0x2::vec_map::contains<u64, Preset>(&arg1.presets, &arg2), 3);
        let (_, _) = 0x2::vec_map::remove<u64, Preset>(&mut arg1.presets, &arg2);
        let v2 = PresetChanged{
            config   : 0x2::object::id<Config>(arg1),
            bin_step : arg2,
            preset   : 0x1::option::none<Preset>(),
        };
        0x2::event::emit<PresetChanged>(v2);
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

    public fun set_preset(arg0: &AdminCap, arg1: &mut Config, arg2: Preset) {
        assert_version(arg1);
        insert_preset(arg1, arg2);
        let v0 = PresetChanged{
            config   : 0x2::object::id<Config>(arg1),
            bin_step : arg2.bin_step,
            preset   : 0x1::option::some<Preset>(arg2),
        };
        0x2::event::emit<PresetChanged>(v0);
    }

    public fun set_recipients(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: address, arg4: address) {
        assert_version(arg1);
        assert!(arg2 <= 0x4b683626c001e323fb3a47368193728cda982a69ccf0a1557da4de731773c124::dlmm_math::basis(), 4);
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

    public fun treasury(arg0: &Config) : address {
        assert_version(arg0);
        arg0.treasury
    }

    public fun variable_fee_control(arg0: &Preset) : u64 {
        arg0.variable_fee_control
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

