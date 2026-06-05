module 0x9030312e76bdace0dc95f51441b2a40b7eb9811d724e8e9390090b1a959d1cea::risk_guardian {
    struct RiskGuardian has key {
        id: 0x2::object::UID,
        market_paused: bool,
        current_ltv_bps: u64,
        current_borrow_cap: u64,
        action_count: u64,
        last_action_at: u64,
        last_trigger_score: u64,
        protocol_name: 0x1::string::String,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GuardianCap has store, key {
        id: 0x2::object::UID,
    }

    struct MarketPaused has copy, drop {
        guardian_id: address,
        risk_score: u64,
        reason: 0x1::string::String,
        timestamp: u64,
        action_id: 0x1::string::String,
    }

    struct MarketResumed has copy, drop {
        guardian_id: address,
        resumed_by: address,
        reason: 0x1::string::String,
        timestamp: u64,
    }

    struct LTVAdjusted has copy, drop {
        guardian_id: address,
        old_ltv_bps: u64,
        new_ltv_bps: u64,
        risk_score: u64,
        reason: 0x1::string::String,
        timestamp: u64,
        action_id: 0x1::string::String,
    }

    struct BorrowCapAdjusted has copy, drop {
        guardian_id: address,
        old_borrow_cap: u64,
        new_borrow_cap: u64,
        risk_score: u64,
        reason: 0x1::string::String,
        timestamp: u64,
        action_id: 0x1::string::String,
    }

    struct ActionOverridden has copy, drop {
        guardian_id: address,
        action_id: 0x1::string::String,
        override_by: address,
        reason: 0x1::string::String,
        timestamp: u64,
    }

    struct ParamsSnapshot has copy, drop {
        guardian_id: address,
        market_paused: bool,
        current_ltv_bps: u64,
        current_borrow_cap: u64,
        action_count: u64,
        timestamp: u64,
    }

    public fun action_count(arg0: &RiskGuardian) : u64 {
        arg0.action_count
    }

    public entry fun adjust_borrow_cap(arg0: &mut RiskGuardian, arg1: &GuardianCap, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 7);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        arg0.current_borrow_cap = arg2;
        arg0.action_count = arg0.action_count + 1;
        arg0.last_action_at = v0;
        arg0.last_trigger_score = arg3;
        let v1 = BorrowCapAdjusted{
            guardian_id    : 0x2::object::id_address<RiskGuardian>(arg0),
            old_borrow_cap : arg0.current_borrow_cap,
            new_borrow_cap : arg2,
            risk_score     : arg3,
            reason         : 0x1::string::utf8(arg4),
            timestamp      : v0,
            action_id      : 0x1::string::utf8(arg5),
        };
        0x2::event::emit<BorrowCapAdjusted>(v1);
    }

    public entry fun adjust_ltv(arg0: &mut RiskGuardian, arg1: &GuardianCap, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 1000 && arg2 <= 9500, 6);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        arg0.current_ltv_bps = arg2;
        arg0.action_count = arg0.action_count + 1;
        arg0.last_action_at = v0;
        arg0.last_trigger_score = arg3;
        let v1 = LTVAdjusted{
            guardian_id : 0x2::object::id_address<RiskGuardian>(arg0),
            old_ltv_bps : arg0.current_ltv_bps,
            new_ltv_bps : arg2,
            risk_score  : arg3,
            reason      : 0x1::string::utf8(arg4),
            timestamp   : v0,
            action_id   : 0x1::string::utf8(arg5),
        };
        0x2::event::emit<LTVAdjusted>(v1);
    }

    public entry fun admin_set_borrow_cap(arg0: &mut RiskGuardian, arg1: &AdminCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 7);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg0.current_borrow_cap = arg2;
        arg0.last_action_at = v0;
        emit_snapshot(arg0, v0);
    }

    public entry fun admin_set_ltv(arg0: &mut RiskGuardian, arg1: &AdminCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 1000 && arg2 <= 9500, 6);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg0.current_ltv_bps = arg2;
        arg0.last_action_at = v0;
        emit_snapshot(arg0, v0);
    }

    public fun current_borrow_cap(arg0: &RiskGuardian) : u64 {
        arg0.current_borrow_cap
    }

    public fun current_ltv_bps(arg0: &RiskGuardian) : u64 {
        arg0.current_ltv_bps
    }

    fun emit_snapshot(arg0: &RiskGuardian, arg1: u64) {
        let v0 = ParamsSnapshot{
            guardian_id        : 0x2::object::id_address<RiskGuardian>(arg0),
            market_paused      : arg0.market_paused,
            current_ltv_bps    : arg0.current_ltv_bps,
            current_borrow_cap : arg0.current_borrow_cap,
            action_count       : arg0.action_count,
            timestamp          : arg1,
        };
        0x2::event::emit<ParamsSnapshot>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RiskGuardian{
            id                 : 0x2::object::new(arg0),
            market_paused      : false,
            current_ltv_bps    : 7500,
            current_borrow_cap : 1000000000000,
            action_count       : 0,
            last_action_at     : 0,
            last_trigger_score : 0,
            protocol_name      : 0x1::string::utf8(b"Iglo Risk Guardian"),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = GuardianCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<RiskGuardian>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<GuardianCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun is_paused(arg0: &RiskGuardian) : bool {
        arg0.market_paused
    }

    public fun last_trigger_score(arg0: &RiskGuardian) : u64 {
        arg0.last_trigger_score
    }

    public entry fun override_action(arg0: &mut RiskGuardian, arg1: &AdminCap, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        if (arg5 && arg0.market_paused) {
            arg0.market_paused = false;
        };
        let v1 = if (arg4 > 0) {
            if (arg4 >= 1000) {
                arg4 <= 9500
            } else {
                false
            }
        } else {
            false
        };
        if (v1) {
            arg0.current_ltv_bps = arg4;
        };
        arg0.last_action_at = v0;
        let v2 = ActionOverridden{
            guardian_id : 0x2::object::id_address<RiskGuardian>(arg0),
            action_id   : 0x1::string::utf8(arg2),
            override_by : 0x2::tx_context::sender(arg7),
            reason      : 0x1::string::utf8(arg3),
            timestamp   : v0,
        };
        0x2::event::emit<ActionOverridden>(v2);
    }

    public entry fun pause_market(arg0: &mut RiskGuardian, arg1: &GuardianCap, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.market_paused, 2);
        assert!(arg2 >= 80, 5);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        arg0.market_paused = true;
        arg0.action_count = arg0.action_count + 1;
        arg0.last_action_at = v0;
        arg0.last_trigger_score = arg2;
        let v1 = MarketPaused{
            guardian_id : 0x2::object::id_address<RiskGuardian>(arg0),
            risk_score  : arg2,
            reason      : 0x1::string::utf8(arg3),
            timestamp   : v0,
            action_id   : 0x1::string::utf8(arg4),
        };
        0x2::event::emit<MarketPaused>(v1);
    }

    public entry fun resume_market(arg0: &mut RiskGuardian, arg1: &AdminCap, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.market_paused, 3);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg0.market_paused = false;
        arg0.last_action_at = v0;
        let v1 = MarketResumed{
            guardian_id : 0x2::object::id_address<RiskGuardian>(arg0),
            resumed_by  : 0x2::tx_context::sender(arg4),
            reason      : 0x1::string::utf8(arg2),
            timestamp   : v0,
        };
        0x2::event::emit<MarketResumed>(v1);
    }

    public entry fun transfer_guardian_cap(arg0: GuardianCap, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<GuardianCap>(arg0, arg2);
    }

    // decompiled from Move bytecode v7
}

