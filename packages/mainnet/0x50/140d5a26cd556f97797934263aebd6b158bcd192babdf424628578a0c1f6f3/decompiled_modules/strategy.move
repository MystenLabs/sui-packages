module 0x50140d5a26cd556f97797934263aebd6b158bcd192babdf424628578a0c1f6f3::strategy {
    struct Strategy has store {
        id: 0x2::object::UID,
        strategy_type: u8,
        target_protocol: vector<u8>,
        allocation_bps: u64,
        active: bool,
        approved: bool,
        loop_enabled: bool,
        loop_leverage_bps: u64,
        loop_hf_target_bps: u64,
        loop_hf_warn_bps: u64,
        loop_hf_stop_bps: u64,
        loop_max_iterations: u64,
    }

    struct Strategies has store, key {
        id: 0x2::object::UID,
        list: vector<Strategy>,
        admin: address,
    }

    struct LoopSettings has copy, drop {
        leverage_bps: u64,
        hf_target_bps: u64,
        hf_warn_bps: u64,
        hf_stop_bps: u64,
        max_iterations: u64,
    }

    public entry fun add_strategy(arg0: &mut Strategies, arg1: u8, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, 0x2::tx_context::sender(arg4));
        assert!(arg3 <= 10000, 1002);
        let (v0, v1, v2, v3, v4, v5) = defaults();
        let v6 = Strategy{
            id                  : 0x2::object::new(arg4),
            strategy_type       : arg1,
            target_protocol     : arg2,
            allocation_bps      : arg3,
            active              : false,
            approved            : false,
            loop_enabled        : v0,
            loop_leverage_bps   : v1,
            loop_hf_target_bps  : v2,
            loop_hf_warn_bps    : v3,
            loop_hf_stop_bps    : v4,
            loop_max_iterations : v5,
        };
        0x1::vector::push_back<Strategy>(&mut arg0.list, v6);
    }

    public(friend) fun allocate_and_execute(arg0: &Strategies, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Strategy>(&arg0.list)) {
            let v1 = 0x1::vector::borrow<Strategy>(&arg0.list, v0);
            let v2 = if (v1.active) {
                if (v1.approved) {
                    v1.allocation_bps > 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                deploy_to_strategy(v1, arg1 * v1.allocation_bps / 10000, arg2);
            };
            v0 = v0 + 1;
        };
    }

    public(friend) entry fun approve_strategy(arg0: &mut Strategies, arg1: &0x50140d5a26cd556f97797934263aebd6b158bcd192babdf424628578a0c1f6f3::governance::Governance, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, 0x2::tx_context::sender(arg3));
        let v0 = &mut arg0.list;
        find_strategy_mut(v0, arg2).approved = true;
    }

    public entry fun approve_strategy_simple(arg0: &mut Strategies, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, 0x2::tx_context::sender(arg2));
        let v0 = &mut arg0.list;
        find_strategy_mut(v0, arg1).approved = true;
    }

    fun assert_admin(arg0: &Strategies, arg1: address) {
        assert!(arg1 == arg0.admin, 1001);
    }

    public entry fun create_strategies(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Strategies{
            id    : 0x2::object::new(arg0),
            list  : 0x1::vector::empty<Strategy>(),
            admin : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::public_share_object<Strategies>(v0);
    }

    fun defaults() : (bool, u64, u64, u64, u64, u64) {
        (false, 10000, 15000, 13500, 13000, 6)
    }

    public(friend) fun deploy_to_strategy(arg0: &Strategy, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
    }

    fun find_strategy_mut(arg0: &mut vector<Strategy>, arg1: address) : &mut Strategy {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Strategy>(arg0)) {
            let v1 = 0x1::vector::borrow_mut<Strategy>(arg0, v0);
            if (0x2::object::uid_to_address(&v1.id) == arg1) {
                return v1
            };
            v0 = v0 + 1;
        };
        abort 1100
    }

    public fun first_active_loop(arg0: &Strategies) : 0x1::option::Option<LoopSettings> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Strategy>(&arg0.list)) {
            let v1 = 0x1::vector::borrow<Strategy>(&arg0.list, v0);
            let v2 = if (v1.active) {
                if (v1.approved) {
                    v1.loop_enabled
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                let v3 = LoopSettings{
                    leverage_bps   : v1.loop_leverage_bps,
                    hf_target_bps  : v1.loop_hf_target_bps,
                    hf_warn_bps    : v1.loop_hf_warn_bps,
                    hf_stop_bps    : v1.loop_hf_stop_bps,
                    max_iterations : v1.loop_max_iterations,
                };
                return 0x1::option::some<LoopSettings>(v3)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<LoopSettings>()
    }

    public fun loop_hf_stop_bps(arg0: &LoopSettings) : u64 {
        arg0.hf_stop_bps
    }

    public fun loop_hf_target_bps(arg0: &LoopSettings) : u64 {
        arg0.hf_target_bps
    }

    public fun loop_hf_warn_bps(arg0: &LoopSettings) : u64 {
        arg0.hf_warn_bps
    }

    public fun loop_leverage_bps(arg0: &LoopSettings) : u64 {
        arg0.leverage_bps
    }

    public fun loop_max_iterations(arg0: &LoopSettings) : u64 {
        arg0.max_iterations
    }

    public entry fun set_active_admin(arg0: &mut Strategies, arg1: address, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, 0x2::tx_context::sender(arg3));
        let v0 = &mut arg0.list;
        find_strategy_mut(v0, arg1).active = arg2;
    }

    public(friend) entry fun set_loop_config(arg0: &mut Strategies, arg1: address, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, 0x2::tx_context::sender(arg8));
        assert!(arg3 >= 10000, 1101);
        assert!(arg4 >= arg5 && arg5 >= arg6, 1102);
        assert!(arg6 > 0, 1103);
        assert!(arg7 > 0, 1104);
        let v0 = &mut arg0.list;
        let v1 = find_strategy_mut(v0, arg1);
        v1.loop_enabled = arg2;
        v1.loop_leverage_bps = arg3;
        v1.loop_hf_target_bps = arg4;
        v1.loop_hf_warn_bps = arg5;
        v1.loop_hf_stop_bps = arg6;
        v1.loop_max_iterations = arg7;
    }

    public entry fun set_loop_config_admin(arg0: &mut Strategies, arg1: address, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        set_loop_config(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public(friend) entry fun update_strategy(arg0: &mut Strategies, arg1: address, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, 0x2::tx_context::sender(arg4));
        assert!(arg2 <= 10000, 1002);
        let v0 = &mut arg0.list;
        let v1 = find_strategy_mut(v0, arg1);
        v1.allocation_bps = arg2;
        v1.active = arg3;
    }

    // decompiled from Move bytecode v6
}

