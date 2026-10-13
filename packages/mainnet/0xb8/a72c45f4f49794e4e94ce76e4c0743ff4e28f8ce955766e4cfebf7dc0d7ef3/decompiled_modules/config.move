module 0xb8a72c45f4f49794e4e94ce76e4c0743ff4e28f8ce955766e4cfebf7dc0d7ef3::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        guardian: address,
        fee_recipient: address,
        paused: bool,
        change_delay_ms: u64,
        pending_recipient: 0x1::option::Option<address>,
        pending_ms: u64,
    }

    struct GuardianChanged has copy, drop {
        schema: u8,
        guardian: address,
    }

    struct PauseChanged has copy, drop {
        schema: u8,
        paused: bool,
        by: address,
    }

    struct RecipientProposed has copy, drop {
        schema: u8,
        recipient: address,
        effective_ms: u64,
    }

    struct RecipientChanged has copy, drop {
        schema: u8,
        recipient: address,
    }

    public fun id(arg0: &Config) : 0x2::object::ID {
        0x2::object::id<Config>(arg0)
    }

    public fun admin_pause(arg0: &AdminCap, arg1: &mut Config, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        arg1.paused = arg2;
        let v0 = PauseChanged{
            schema : 1,
            paused : arg2,
            by     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<PauseChanged>(v0);
    }

    public fun apply_recipient(arg0: &mut Config, arg1: &0x2::clock::Clock) {
        assert!(0x1::option::is_some<address>(&arg0.pending_recipient), 4);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.pending_ms, 5);
        let v0 = 0x1::option::extract<address>(&mut arg0.pending_recipient);
        arg0.fee_recipient = v0;
        let v1 = RecipientChanged{
            schema    : 1,
            recipient : v0,
        };
        0x2::event::emit<RecipientChanged>(v1);
    }

    public fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 1);
    }

    public fun change_delay_ms(arg0: &Config) : u64 {
        arg0.change_delay_ms
    }

    public fun fee_recipient(arg0: &Config) : address {
        arg0.fee_recipient
    }

    public fun guardian(arg0: &Config) : address {
        arg0.guardian
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                : 0x2::object::new(arg0),
            version           : 1,
            guardian          : 0x2::tx_context::sender(arg0),
            fee_recipient     : 0x2::tx_context::sender(arg0),
            paused            : false,
            change_delay_ms   : 86400000,
            pending_recipient : 0x1::option::none<address>(),
            pending_ms        : 0,
        };
        0x2::transfer::share_object<Config>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun pause(arg0: &mut Config, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.guardian, 2);
        arg0.paused = true;
        let v0 = PauseChanged{
            schema : 1,
            paused : true,
            by     : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<PauseChanged>(v0);
    }

    public fun paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun propose_recipient(arg0: &AdminCap, arg1: &mut Config, arg2: address, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3) + arg1.change_delay_ms;
        arg1.pending_recipient = 0x1::option::some<address>(arg2);
        arg1.pending_ms = v0;
        let v1 = RecipientProposed{
            schema       : 1,
            recipient    : arg2,
            effective_ms : v0,
        };
        0x2::event::emit<RecipientProposed>(v1);
    }

    public fun schema() : u8 {
        1
    }

    public fun set_change_delay(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        let v0 = if (arg2 >= arg1.change_delay_ms) {
            if (arg2 <= 1209600000) {
                arg2 >= 3600000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 3);
        arg1.change_delay_ms = arg2;
    }

    public fun set_guardian(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        arg1.guardian = arg2;
        let v0 = GuardianChanged{
            schema   : 1,
            guardian : arg2,
        };
        0x2::event::emit<GuardianChanged>(v0);
    }

    // decompiled from Move bytecode v7
}

