module 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::security {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CallerCap has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct State has key {
        id: 0x2::object::UID,
        is_paused: bool,
        treasury: address,
    }

    struct ArbitrageSuccessEvent has copy, drop {
        token_symbol: vector<u8>,
        input_amount: u64,
        output_amount: u64,
        net_profit: u64,
        flash_venue: u8,
        swap_venue: u8,
        timestamp_ms: u64,
    }

    public fun assert_valid_execution(arg0: &CallerCap, arg1: &State, arg2: &0x2::tx_context::TxContext) {
        assert!(!arg1.is_paused, 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::errors::emergency_paused());
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0xc04dba99d6913cb13f3a4158a792f208e9039a750d7235afac31257bab4026e1::errors::unauthorized());
    }

    public fun emit_success_event(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: u8, arg6: u64) {
        let v0 = ArbitrageSuccessEvent{
            token_symbol  : arg0,
            input_amount  : arg1,
            output_amount : arg2,
            net_profit    : arg3,
            flash_venue   : arg4,
            swap_venue    : arg5,
            timestamp_ms  : arg6,
        };
        0x2::event::emit<ArbitrageSuccessEvent>(v0);
    }

    public fun get_treasury(arg0: &State) : address {
        arg0.treasury
    }

    public fun grant_caller_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CallerCap{
            id    : 0x2::object::new(arg2),
            owner : arg1,
        };
        0x2::transfer::public_transfer<CallerCap>(v0, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, v0);
        let v2 = CallerCap{
            id    : 0x2::object::new(arg0),
            owner : v0,
        };
        0x2::transfer::public_transfer<CallerCap>(v2, v0);
        let v3 = State{
            id        : 0x2::object::new(arg0),
            is_paused : false,
            treasury  : v0,
        };
        0x2::transfer::share_object<State>(v3);
    }

    public fun revoke_caller_cap(arg0: &AdminCap, arg1: CallerCap) {
        let CallerCap {
            id    : v0,
            owner : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut State, arg2: bool) {
        arg1.is_paused = arg2;
    }

    public fun set_treasury(arg0: &AdminCap, arg1: &mut State, arg2: address) {
        arg1.treasury = arg2;
    }

    // decompiled from Move bytecode v7
}

