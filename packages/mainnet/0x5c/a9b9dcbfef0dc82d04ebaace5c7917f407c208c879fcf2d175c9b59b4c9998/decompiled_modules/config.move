module 0x5ca9b9dcbfef0dc82d04ebaace5c7917f407c208c879fcf2d175c9b59b4c9998::config {
    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        fee_bps: u64,
        fee_recipient: address,
        keepers: vector<address>,
        open_fill: bool,
        base_coins: vector<0x1::string::String>,
        min_base: vector<u64>,
        max_order_ms: u64,
        paused: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Migrated has copy, drop {
        from: u64,
        to: u64,
    }

    struct ParamsChanged has copy, drop {
        fee_bps: u64,
        fee_recipient: address,
        max_order_ms: u64,
    }

    struct KeepersChanged has copy, drop {
        keepers: vector<address>,
        open_fill: bool,
    }

    struct BaseCoinsChanged has copy, drop {
        base_coins: vector<0x1::string::String>,
        min_base: vector<u64>,
    }

    struct PauseChanged has copy, drop {
        paused: bool,
    }

    public fun assert_filler(arg0: &Config, arg1: address) {
        assert!(arg0.open_fill || 0x1::vector::contains<address>(&arg0.keepers, &arg1), 104);
    }

    public fun assert_open(arg0: &Config) {
        assert_version(arg0);
        assert!(!arg0.paused, 103);
    }

    public fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 100);
    }

    public fun base_coins(arg0: &Config) : vector<0x1::string::String> {
        arg0.base_coins
    }

    public fun base_min<T0>(arg0: &Config) : (bool, u64) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()));
        let (v1, v2) = 0x1::vector::index_of<0x1::string::String>(&arg0.base_coins, &v0);
        if (v1) {
            (true, *0x1::vector::borrow<u64>(&arg0.min_base, v2))
        } else {
            (false, 0)
        }
    }

    public fun fee_bps(arg0: &Config) : u64 {
        arg0.fee_bps
    }

    public fun fee_on(arg0: &Config, arg1: u64) : u64 {
        (((arg1 as u128) * (arg0.fee_bps as u128) / (10000 as u128)) as u64)
    }

    public fun fee_recipient(arg0: &Config) : address {
        arg0.fee_recipient
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, sui_name());
        let v1 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v1, 1000000000);
        let v2 = Config{
            id            : 0x2::object::new(arg0),
            version       : 1,
            fee_bps       : 30,
            fee_recipient : 0x2::tx_context::sender(arg0),
            keepers       : vector[],
            open_fill     : true,
            base_coins    : v0,
            min_base      : v1,
            max_order_ms  : 2592000000,
            paused        : false,
        };
        0x2::transfer::share_object<Config>(v2);
        let v3 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg0));
    }

    public fun keepers(arg0: &Config) : vector<address> {
        arg0.keepers
    }

    public fun max_fee_bps() : u64 {
        100
    }

    public fun max_order_ms(arg0: &Config) : u64 {
        arg0.max_order_ms
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Config) {
        assert!(arg1.version < 1, 101);
        let v0 = Migrated{
            from : arg1.version,
            to   : 1,
        };
        0x2::event::emit<Migrated>(v0);
        arg1.version = 1;
    }

    public fun open_fill(arg0: &Config) : bool {
        arg0.open_fill
    }

    public fun paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun set_base_coins(arg0: &AdminCap, arg1: &mut Config, arg2: vector<0x1::string::String>, arg3: vector<u64>) {
        assert!(!0x1::vector::is_empty<0x1::string::String>(&arg2) && 0x1::vector::length<0x1::string::String>(&arg2) == 0x1::vector::length<u64>(&arg3), 102);
        arg1.base_coins = arg2;
        arg1.min_base = arg3;
        let v0 = BaseCoinsChanged{
            base_coins : arg2,
            min_base   : arg3,
        };
        0x2::event::emit<BaseCoinsChanged>(v0);
    }

    public fun set_keepers(arg0: &AdminCap, arg1: &mut Config, arg2: vector<address>, arg3: bool) {
        arg1.keepers = arg2;
        arg1.open_fill = arg3;
        let v0 = KeepersChanged{
            keepers   : arg2,
            open_fill : arg3,
        };
        0x2::event::emit<KeepersChanged>(v0);
    }

    public fun set_params(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: address, arg4: u64) {
        assert!(arg2 <= 100, 102);
        assert!(arg3 != @0x0, 102);
        assert!(arg4 > 0 && arg4 <= 31536000000, 102);
        arg1.fee_bps = arg2;
        arg1.fee_recipient = arg3;
        arg1.max_order_ms = arg4;
        let v0 = ParamsChanged{
            fee_bps       : arg2,
            fee_recipient : arg3,
            max_order_ms  : arg4,
        };
        0x2::event::emit<ParamsChanged>(v0);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.paused = arg2;
        let v0 = PauseChanged{paused: arg2};
        0x2::event::emit<PauseChanged>(v0);
    }

    fun sui_name() : 0x1::string::String {
        0x1::string::utf8(b"0000000000000000000000000000000000000000000000000000000000000002::sui::SUI")
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

