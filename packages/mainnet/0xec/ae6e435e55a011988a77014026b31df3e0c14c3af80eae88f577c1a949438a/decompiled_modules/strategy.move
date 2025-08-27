module 0xecae6e435e55a011988a77014026b31df3e0c14c3af80eae88f577c1a949438a::strategy {
    struct Strategy has store {
        id: 0x2::object::UID,
        strategy_type: u8,
        target_protocol: vector<u8>,
        allocation_bps: u64,
        active: bool,
        approved: bool,
    }

    struct Strategies has store, key {
        id: 0x2::object::UID,
        list: vector<Strategy>,
        admin: address,
    }

    public(friend) entry fun add_strategy(arg0: &mut Strategies, arg1: u8, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 1001);
        assert!(arg3 <= 10000, 1002);
        let v0 = Strategy{
            id              : 0x2::object::new(arg4),
            strategy_type   : arg1,
            target_protocol : arg2,
            allocation_bps  : arg3,
            active          : false,
            approved        : false,
        };
        0x1::vector::push_back<Strategy>(&mut arg0.list, v0);
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

    public(friend) entry fun approve_strategy(arg0: &mut Strategies, arg1: &0xecae6e435e55a011988a77014026b31df3e0c14c3af80eae88f577c1a949438a::governance::Governance, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 1003);
        let v0 = &mut arg0.list;
        find_strategy_mut(v0, arg2).approved = true;
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
        v1.allocation_bps = arg2;
        v1.active = arg3;
    }

    // decompiled from Move bytecode v6
}

