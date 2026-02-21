module 0xe7e06cfbe7b0aad520d70c72735a1aefc59cb1f8b4528c64b1fe220b50e5f6bf::AuditSecurity {
    struct AUDITSECURITY has drop {
        dummy_field: bool,
    }

    struct AuditSecurity has key {
        id: 0x2::object::UID,
        admin: address,
        paused: bool,
        last_action: u64,
        last_actor: address,
        last_timestamp: u64,
        threat_count: u64,
        trace_nonce: u64,
    }

    struct PauseEvent has copy, drop {
        admin: address,
        timestamp: u64,
        reason: vector<u8>,
        trace_nonce: u64,
    }

    struct ResumeEvent has copy, drop {
        admin: address,
        timestamp: u64,
        reason: vector<u8>,
        trace_nonce: u64,
    }

    struct SecureActionEvent has copy, drop {
        actor: address,
        code: u64,
        timestamp: u64,
        trace_nonce: u64,
    }

    struct ThreatEvent has copy, drop {
        actor: address,
        threat_code: u64,
        detail: vector<u8>,
        timestamp: u64,
        trace_nonce: u64,
    }

    struct InvariantViolationEvent has copy, drop {
        actor: address,
        code: u64,
        detail: vector<u8>,
        timestamp: u64,
        trace_nonce: u64,
    }

    struct BottleneckEvent has copy, drop {
        actor: address,
        detail: vector<u8>,
        timestamp: u64,
        trace_nonce: u64,
    }

    public fun assert_invariant(arg0: &AuditSecurity, arg1: address, arg2: u64) {
        if (arg0.admin == @0x0) {
            let v0 = 1001;
            let v1 = InvariantViolationEvent{
                actor       : arg1,
                code        : v0,
                detail      : b"admin address invalid",
                timestamp   : arg2,
                trace_nonce : arg0.trace_nonce + 1,
            };
            0x2::event::emit<InvariantViolationEvent>(v1);
            abort v0
        };
    }

    public fun get_fields(arg0: &AuditSecurity) : (address, bool, u64, address, u64, u64, u64) {
        (arg0.admin, arg0.paused, arg0.last_action, arg0.last_actor, arg0.last_timestamp, arg0.threat_count, arg0.trace_nonce)
    }

    fun init(arg0: AUDITSECURITY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = AuditSecurity{
            id             : 0x2::object::new(arg1),
            admin          : v0,
            paused         : false,
            last_action    : 0,
            last_actor     : v0,
            last_timestamp : 0,
            threat_count   : 0,
            trace_nonce    : 0,
        };
        0x2::transfer::share_object<AuditSecurity>(v1);
    }

    public fun pause(arg0: &mut AuditSecurity, arg1: address, arg2: vector<u8>, arg3: u64) {
        arg0.trace_nonce = arg0.trace_nonce + 1;
        assert_invariant(arg0, arg1, arg3);
        if (arg1 != arg0.admin) {
            abort 1002
        };
        if (arg0.paused) {
            abort 2
        };
        arg0.paused = true;
        arg0.last_action = 100;
        arg0.last_actor = arg1;
        arg0.last_timestamp = arg3;
        let v0 = PauseEvent{
            admin       : arg1,
            timestamp   : arg3,
            reason      : arg2,
            trace_nonce : arg0.trace_nonce,
        };
        0x2::event::emit<PauseEvent>(v0);
    }

    public fun resume(arg0: &mut AuditSecurity, arg1: address, arg2: vector<u8>, arg3: u64) {
        arg0.trace_nonce = arg0.trace_nonce + 1;
        assert_invariant(arg0, arg1, arg3);
        if (arg1 != arg0.admin) {
            abort 1003
        };
        if (!arg0.paused) {
            abort 2
        };
        arg0.paused = false;
        arg0.last_action = 101;
        arg0.last_actor = arg1;
        arg0.last_timestamp = arg3;
        let v0 = ResumeEvent{
            admin       : arg1,
            timestamp   : arg3,
            reason      : arg2,
            trace_nonce : arg0.trace_nonce,
        };
        0x2::event::emit<ResumeEvent>(v0);
    }

    public fun secure_action(arg0: &mut AuditSecurity, arg1: address, arg2: u64, arg3: u64) {
        arg0.trace_nonce = arg0.trace_nonce + 1;
        assert_invariant(arg0, arg1, arg3);
        if (arg0.paused) {
            abort 2
        };
        if (arg2 >= 1000000) {
            abort 4
        };
        if (arg1 != arg0.admin && arg2 > 1000) {
            abort 2001
        };
        if (arg2 > 900000) {
            abort 5
        };
        if (arg0.threat_count > 10) {
            abort 6
        };
        if (arg1 == arg0.admin) {
            let v0 = 10;
            let v1 = SecureActionEvent{
                actor       : arg1,
                code        : v0,
                timestamp   : arg3,
                trace_nonce : arg0.trace_nonce,
            };
            0x2::event::emit<SecureActionEvent>(v1);
            arg0.last_action = v0;
            arg0.last_actor = arg1;
            arg0.last_timestamp = arg3;
        } else {
            let v2 = 11;
            let v3 = SecureActionEvent{
                actor       : arg1,
                code        : v2,
                timestamp   : arg3,
                trace_nonce : arg0.trace_nonce,
            };
            0x2::event::emit<SecureActionEvent>(v3);
            arg0.last_action = v2;
            arg0.last_actor = arg1;
            arg0.last_timestamp = arg3;
        };
    }

    public fun simulate_bottleneck(arg0: &mut AuditSecurity, arg1: address, arg2: u64) {
        arg0.trace_nonce = arg0.trace_nonce + 1;
        if (arg0.trace_nonce >= 1000) {
            let v0 = BottleneckEvent{
                actor       : arg1,
                detail      : b"bottleneck detected",
                timestamp   : arg2,
                trace_nonce : arg0.trace_nonce,
            };
            0x2::event::emit<BottleneckEvent>(v0);
            arg0.paused = true;
            let v1 = PauseEvent{
                admin       : arg0.admin,
                timestamp   : arg2,
                reason      : b"auto-paused by bottleneck",
                trace_nonce : arg0.trace_nonce,
            };
            0x2::event::emit<PauseEvent>(v1);
            abort 3001
        };
    }

    // decompiled from Move bytecode v6
}

