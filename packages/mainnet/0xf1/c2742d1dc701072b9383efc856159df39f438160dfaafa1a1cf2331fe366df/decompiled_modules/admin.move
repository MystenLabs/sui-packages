module 0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SystemConfig has key {
        id: 0x2::object::UID,
        paused: bool,
        fee_recipient: address,
        fee_bps: u64,
        epoch_duration_ms: u64,
        version: u64,
    }

    struct SystemPausedEvent has copy, drop {
        paused: bool,
    }

    struct FeeUpdatedEvent has copy, drop {
        new_fee_bps: u64,
        new_recipient: address,
    }

    public fun assert_not_paused(arg0: &SystemConfig) {
        assert!(!arg0.paused, 1);
    }

    public fun epoch_duration_ms(arg0: &SystemConfig) : u64 {
        arg0.epoch_duration_ms
    }

    public fun fee_bps(arg0: &SystemConfig) : u64 {
        arg0.fee_bps
    }

    public fun fee_recipient(arg0: &SystemConfig) : address {
        arg0.fee_recipient
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = SystemConfig{
            id                : 0x2::object::new(arg0),
            paused            : false,
            fee_recipient     : 0x2::tx_context::sender(arg0),
            fee_bps           : 250,
            epoch_duration_ms : 86400000,
            version           : 1,
        };
        0x2::transfer::share_object<SystemConfig>(v1);
    }

    public fun is_paused(arg0: &SystemConfig) : bool {
        arg0.paused
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut SystemConfig, arg2: bool) {
        arg1.paused = arg2;
        let v0 = SystemPausedEvent{paused: arg2};
        0x2::event::emit<SystemPausedEvent>(v0);
    }

    public fun update_epoch_duration(arg0: &AdminCap, arg1: &mut SystemConfig, arg2: u64) {
        arg1.epoch_duration_ms = arg2;
    }

    public fun update_fees(arg0: &AdminCap, arg1: &mut SystemConfig, arg2: u64, arg3: address) {
        arg1.fee_bps = arg2;
        arg1.fee_recipient = arg3;
        let v0 = FeeUpdatedEvent{
            new_fee_bps   : arg2,
            new_recipient : arg3,
        };
        0x2::event::emit<FeeUpdatedEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

