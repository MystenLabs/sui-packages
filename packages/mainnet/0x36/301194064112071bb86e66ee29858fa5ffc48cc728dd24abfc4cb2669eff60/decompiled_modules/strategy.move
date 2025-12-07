module 0x36301194064112071bb86e66ee29858fa5ffc48cc728dd24abfc4cb2669eff60::strategy {
    struct Allocation has copy, drop {
        protocol: u8,
        reserve_index: u64,
        ratio_bps: u64,
        loop_multiplier_bps: u64,
    }

    struct Strategy has store {
        id: 0x2::object::UID,
        protocol: u8,
        reserve_index: u64,
        ratio_bps: u64,
        loop_multiplier_bps: u64,
        active: bool,
        approved: bool,
    }

    struct Strategies has store, key {
        id: 0x2::object::UID,
        list: vector<Strategy>,
        admin: address,
    }

    public(friend) entry fun add_strategy(arg0: &mut Strategies, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg0.admin, 1001);
        assert!(arg3 <= 10000, 1002);
        assert!(arg4 >= 10000, 1006);
        let v0 = Strategy{
            id                  : 0x2::object::new(arg7),
            protocol            : arg1,
            reserve_index       : arg2,
            ratio_bps           : arg3,
            loop_multiplier_bps : arg4,
            active              : arg6,
            approved            : arg5,
        };
        0x1::vector::push_back<Strategy>(&mut arg0.list, v0);
    }

    public(friend) fun allocate_and_execute(arg0: &Strategies, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Strategy>(&arg0.list)) {
            let v1 = 0x1::vector::borrow<Strategy>(&arg0.list, v0);
            let v2 = if (v1.active) {
                if (v1.approved) {
                    v1.ratio_bps > 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                deploy_to_strategy(v1, arg1 * v1.ratio_bps / 10000, arg2);
            };
            v0 = v0 + 1;
        };
    }

    public(friend) entry fun approve_strategy(arg0: &mut Strategies, arg1: &0x36301194064112071bb86e66ee29858fa5ffc48cc728dd24abfc4cb2669eff60::governance::Governance, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 1003);
        let v0 = &mut arg0.list;
        find_strategy_mut(v0, arg2).approved = true;
    }

    public fun create_strategies(arg0: vector<u8>, arg1: vector<u64>, arg2: vector<u64>, arg3: vector<u64>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : Strategies {
        let v0 = 0x1::vector::length<u8>(&arg0);
        assert!(v0 == 0x1::vector::length<u64>(&arg1), 2001);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 2002);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 2003);
        let v1 = Strategies{
            id    : 0x2::object::new(arg5),
            list  : 0x1::vector::empty<Strategy>(),
            admin : arg4,
        };
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u64>(&arg2, v2);
            let v4 = *0x1::vector::borrow<u64>(&arg3, v2);
            assert!(v3 <= 10000, 1002);
            assert!(v4 >= 10000, 1006);
            let v5 = Strategy{
                id                  : 0x2::object::new(arg5),
                protocol            : *0x1::vector::borrow<u8>(&arg0, v2),
                reserve_index       : *0x1::vector::borrow<u64>(&arg1, v2),
                ratio_bps           : v3,
                loop_multiplier_bps : v4,
                active              : true,
                approved            : true,
            };
            0x1::vector::push_back<Strategy>(&mut v1.list, v5);
            v2 = v2 + 1;
        };
        v1
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
        abort 100
    }

    public fun get_allocation_fields(arg0: &Allocation) : (u8, u64, u64, u64) {
        (arg0.protocol, arg0.reserve_index, arg0.ratio_bps, arg0.loop_multiplier_bps)
    }

    public(friend) fun get_allocations(arg0: &Strategies) : vector<Allocation> {
        let v0 = 0x1::vector::empty<Allocation>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Strategy>(&arg0.list)) {
            let v2 = 0x1::vector::borrow<Strategy>(&arg0.list, v1);
            let v3 = if (v2.active) {
                if (v2.approved) {
                    v2.ratio_bps > 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v3) {
                let v4 = Allocation{
                    protocol            : v2.protocol,
                    reserve_index       : v2.reserve_index,
                    ratio_bps           : v2.ratio_bps,
                    loop_multiplier_bps : v2.loop_multiplier_bps,
                };
                0x1::vector::push_back<Allocation>(&mut v0, v4);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun get_loop_multiplier_bps(arg0: &Strategy) : u64 {
        arg0.loop_multiplier_bps
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Strategies{
            id    : 0x2::object::new(arg0),
            list  : 0x1::vector::empty<Strategy>(),
            admin : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::public_share_object<Strategies>(v0);
    }

    public(friend) entry fun set_active(arg0: &mut Strategies, arg1: address, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 1005);
        let v0 = &mut arg0.list;
        find_strategy_mut(v0, arg1).active = arg2;
    }

    public(friend) entry fun update_strategy(arg0: &mut Strategies, arg1: address, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 1004);
        let v0 = &mut arg0.list;
        let v1 = find_strategy_mut(v0, arg1);
        v1.ratio_bps = arg2;
        v1.active = arg3;
    }

    // decompiled from Move bytecode v6
}

