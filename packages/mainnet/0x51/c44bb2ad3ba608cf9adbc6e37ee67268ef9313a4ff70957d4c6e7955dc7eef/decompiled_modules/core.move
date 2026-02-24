module 0x51c44bb2ad3ba608cf9adbc6e37ee67268ef9313a4ff70957d4c6e7955dc7eef::core {
    struct CORE has drop {
        dummy_field: bool,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        save_fee_bps: u64,
        swap_fee_bps: u64,
        borrow_fee_bps: u64,
        paused: bool,
        pending_save_fee_bps: 0x1::option::Option<u64>,
        pending_swap_fee_bps: 0x1::option::Option<u64>,
        pending_borrow_fee_bps: 0x1::option::Option<u64>,
        fee_change_effective_at: 0x1::option::Option<u64>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        created_at: u64,
    }

    public(friend) fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 7);
    }

    public(friend) fun clear_pending_fees(arg0: &mut Config) {
        arg0.pending_save_fee_bps = 0x1::option::none<u64>();
        arg0.pending_swap_fee_bps = 0x1::option::none<u64>();
        arg0.pending_borrow_fee_bps = 0x1::option::none<u64>();
        arg0.fee_change_effective_at = 0x1::option::none<u64>();
    }

    public(friend) fun fee_change_effective_at(arg0: &Config) : 0x1::option::Option<u64> {
        arg0.fee_change_effective_at
    }

    public fun fee_rate(arg0: &Config, arg1: u8) : u64 {
        if (arg1 == 0) {
            arg0.save_fee_bps
        } else if (arg1 == 1) {
            arg0.swap_fee_bps
        } else if (arg1 == 2) {
            arg0.borrow_fee_bps
        } else {
            0
        }
    }

    fun init(arg0: CORE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                      : 0x2::object::new(arg1),
            version                 : 1,
            save_fee_bps            : 10,
            swap_fee_bps            : 10,
            borrow_fee_bps          : 5,
            paused                  : false,
            pending_save_fee_bps    : 0x1::option::none<u64>(),
            pending_swap_fee_bps    : 0x1::option::none<u64>(),
            pending_borrow_fee_bps  : 0x1::option::none<u64>(),
            fee_change_effective_at : 0x1::option::none<u64>(),
        };
        0x2::transfer::share_object<Config>(v0);
        let v1 = AdminCap{
            id         : 0x2::object::new(arg1),
            created_at : 0,
        };
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun is_paused(arg0: &Config) : bool {
        arg0.paused
    }

    public(friend) fun pending_borrow_fee_bps(arg0: &Config) : 0x1::option::Option<u64> {
        arg0.pending_borrow_fee_bps
    }

    public(friend) fun pending_save_fee_bps(arg0: &Config) : 0x1::option::Option<u64> {
        arg0.pending_save_fee_bps
    }

    public(friend) fun pending_swap_fee_bps(arg0: &Config) : 0x1::option::Option<u64> {
        arg0.pending_swap_fee_bps
    }

    public(friend) fun set_borrow_fee_bps(arg0: &mut Config, arg1: u64) {
        arg0.borrow_fee_bps = arg1;
    }

    public(friend) fun set_paused(arg0: &mut Config, arg1: bool) {
        arg0.paused = arg1;
    }

    public(friend) fun set_pending_fees(arg0: &mut Config, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        arg0.pending_save_fee_bps = 0x1::option::some<u64>(arg1);
        arg0.pending_swap_fee_bps = 0x1::option::some<u64>(arg2);
        arg0.pending_borrow_fee_bps = 0x1::option::some<u64>(arg3);
        arg0.fee_change_effective_at = 0x1::option::some<u64>(arg4);
    }

    public(friend) fun set_save_fee_bps(arg0: &mut Config, arg1: u64) {
        arg0.save_fee_bps = arg1;
    }

    public(friend) fun set_swap_fee_bps(arg0: &mut Config, arg1: u64) {
        arg0.swap_fee_bps = arg1;
    }

    public(friend) fun set_version(arg0: &mut Config, arg1: u64) {
        arg0.version = arg1;
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

