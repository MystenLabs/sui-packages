module 0x696c636bc931bde52f54054a8b6e2081148f064526847c8b903d60e355ec602a::admin {
    struct AdminCapCreated has copy, drop {
        admin_cap_id: 0x2::object::ID,
        created_at: u64,
    }

    struct ProtocolPaused has copy, drop {
        paused_at: u64,
        reason: 0x1::string::String,
    }

    struct ProtocolUnpaused has copy, drop {
        unpaused_at: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        created_at: u64,
    }

    struct ProtocolState has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        paused_at: 0x1::option::Option<u64>,
        pause_reason: 0x1::option::Option<0x1::string::String>,
    }

    fun assert_version(arg0: &ProtocolState) {
        assert!(arg0.version == 1, 30);
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg0);
        let v1 = AdminCap{
            id         : 0x2::object::new(arg0),
            created_at : v0,
        };
        let v2 = AdminCapCreated{
            admin_cap_id : 0x2::object::id<AdminCap>(&v1),
            created_at   : v0,
        };
        0x2::event::emit<AdminCapCreated>(v2);
        v1
    }

    public(friend) fun create_protocol_state(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolState{
            id           : 0x2::object::new(arg0),
            version      : 1,
            paused       : false,
            paused_at    : 0x1::option::none<u64>(),
            pause_reason : 0x1::option::none<0x1::string::String>(),
        };
        0x2::transfer::share_object<ProtocolState>(v0);
    }

    public fun created_at(arg0: &AdminCap) : u64 {
        arg0.created_at
    }

    public fun is_paused(arg0: &ProtocolState) : bool {
        arg0.paused
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut ProtocolState) {
        assert!(arg1.version < 1, 30);
        arg1.version = 1;
    }

    public fun pause(arg0: &AdminCap, arg1: &mut ProtocolState, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg3);
        arg1.paused = true;
        arg1.paused_at = 0x1::option::some<u64>(v0);
        arg1.pause_reason = 0x1::option::some<0x1::string::String>(arg2);
        let v1 = ProtocolPaused{
            paused_at : v0,
            reason    : arg2,
        };
        0x2::event::emit<ProtocolPaused>(v1);
    }

    public fun pause_reason(arg0: &ProtocolState) : 0x1::option::Option<0x1::string::String> {
        arg0.pause_reason
    }

    public fun paused_at(arg0: &ProtocolState) : 0x1::option::Option<u64> {
        arg0.paused_at
    }

    public fun unpause(arg0: &AdminCap, arg1: &mut ProtocolState, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        arg1.paused = false;
        arg1.paused_at = 0x1::option::none<u64>();
        arg1.pause_reason = 0x1::option::none<0x1::string::String>();
        let v0 = ProtocolUnpaused{unpaused_at: 0x2::tx_context::epoch_timestamp_ms(arg2)};
        0x2::event::emit<ProtocolUnpaused>(v0);
    }

    public fun version(arg0: &ProtocolState) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

