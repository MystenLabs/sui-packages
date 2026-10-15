module 0x9c1a1f266840a9909e866424cebd11775805a1978de3c409a302796ee0103770::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        relayers: 0x2::vec_set::VecSet<address>,
        trade_fee_bps: u64,
        creator_fee_bps: u64,
        launch_fee: u64,
        virtual_sui: u64,
        virtual_tokens: u64,
        curve_supply: u64,
        total_supply: u64,
        decimals: u8,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        graduator: 0x1::option::Option<0x1::type_name::TypeName>,
        bridge: 0x1::option::Option<0x1::type_name::TypeName>,
    }

    struct ConfigChanged has copy, drop {
        what: vector<u8>,
    }

    public fun add_relayer(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        if (!0x2::vec_set::contains<address>(&arg1.relayers, &arg2)) {
            0x2::vec_set::insert<address>(&mut arg1.relayers, arg2);
        };
        let v0 = ConfigChanged{what: b"relayers"};
        0x2::event::emit<ConfigChanged>(v0);
    }

    public fun assert_bridge<T0: drop>(arg0: &Config, arg1: &T0) {
        assert!(arg0.bridge == 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T0>()), 13906834595251093519);
    }

    public fun assert_graduator<T0: drop>(arg0: &Config, arg1: &T0) {
        assert!(arg0.graduator == 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T0>()), 13906834578071093261);
    }

    public fun assert_live(arg0: &Config) {
        assert!(arg0.version == 1, 13906834539415732227);
        assert!(!arg0.paused, 13906834543710961671);
    }

    public fun assert_relayer(arg0: &Config, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.relayers, &v0), 13906834560890699781);
    }

    public(friend) fun collect(arg0: &mut Config, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, arg1);
    }

    public fun creator_fee_bps(arg0: &Config) : u64 {
        arg0.creator_fee_bps
    }

    public fun curve_supply(arg0: &Config) : u64 {
        arg0.curve_supply
    }

    public fun decimals(arg0: &Config) : u8 {
        arg0.decimals
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = Config{
            id              : 0x2::object::new(arg0),
            version         : 1,
            paused          : false,
            relayers        : v0,
            trade_fee_bps   : 100,
            creator_fee_bps : 50,
            launch_fee      : 1000000000,
            virtual_sui     : 1500000000000,
            virtual_tokens  : 1073000000000000,
            curve_supply    : 793100000000000,
            total_supply    : 1000000000000000,
            decimals        : 6,
            treasury        : 0x2::balance::zero<0x2::sui::SUI>(),
            graduator       : 0x1::option::none<0x1::type_name::TypeName>(),
            bridge          : 0x1::option::none<0x1::type_name::TypeName>(),
        };
        0x2::transfer::share_object<Config>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun is_relayer(arg0: &Config, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.relayers, &arg1)
    }

    public fun launch_fee(arg0: &Config) : u64 {
        arg0.launch_fee
    }

    public fun remove_relayer(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        if (0x2::vec_set::contains<address>(&arg1.relayers, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg1.relayers, &arg2);
        };
        let v0 = ConfigChanged{what: b"relayers"};
        0x2::event::emit<ConfigChanged>(v0);
    }

    public fun set_bridge<T0: drop>(arg0: &AdminCap, arg1: &mut Config) {
        arg1.bridge = 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T0>());
        let v0 = ConfigChanged{what: b"bridge"};
        0x2::event::emit<ConfigChanged>(v0);
    }

    public fun set_curve(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = if (arg2 > 0) {
            if (arg4 < arg3) {
                arg4 < arg5
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13906834891603574795);
        arg1.virtual_sui = arg2;
        arg1.virtual_tokens = arg3;
        arg1.curve_supply = arg4;
        arg1.total_supply = arg5;
        let v1 = ConfigChanged{what: b"curve"};
        0x2::event::emit<ConfigChanged>(v1);
    }

    public fun set_fees(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg2 <= 300 && arg3 <= arg2, 13906834822883966985);
        arg1.trade_fee_bps = arg2;
        arg1.creator_fee_bps = arg3;
        arg1.launch_fee = arg4;
        let v0 = ConfigChanged{what: b"fees"};
        0x2::event::emit<ConfigChanged>(v0);
    }

    public fun set_graduator<T0: drop>(arg0: &AdminCap, arg1: &mut Config) {
        arg1.graduator = 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T0>());
        let v0 = ConfigChanged{what: b"graduator"};
        0x2::event::emit<ConfigChanged>(v0);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.paused = arg2;
        let v0 = ConfigChanged{what: b"paused"};
        0x2::event::emit<ConfigChanged>(v0);
    }

    public fun total_supply(arg0: &Config) : u64 {
        arg0.total_supply
    }

    public fun trade_fee_bps(arg0: &Config) : u64 {
        arg0.trade_fee_bps
    }

    public fun treasury_value(arg0: &Config) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
    }

    public fun virtual_sui(arg0: &Config) : u64 {
        arg0.virtual_sui
    }

    public fun virtual_tokens(arg0: &Config) : u64 {
        arg0.virtual_tokens
    }

    public fun withdraw_treasury(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::take<0x2::sui::SUI>(&mut arg1.treasury, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

