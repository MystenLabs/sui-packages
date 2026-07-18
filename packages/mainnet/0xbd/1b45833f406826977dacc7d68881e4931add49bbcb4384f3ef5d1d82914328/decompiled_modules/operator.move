module 0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::operator {
    struct OperatorHub has key {
        id: 0x2::object::UID,
        operator: address,
        paused: bool,
        version: u64,
    }

    struct OperatorRotated has copy, drop {
        old_operator: address,
        new_operator: address,
    }

    struct GlobalPauseSet has copy, drop {
        paused: bool,
    }

    public fun operator(arg0: &OperatorHub) : address {
        arg0.operator
    }

    public fun assert_active_operator(arg0: &OperatorHub, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        assert!(!arg0.paused, 1);
        assert!(0x2::tx_context::sender(arg1) == arg0.operator, 2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorHub{
            id       : 0x2::object::new(arg0),
            operator : 0x2::tx_context::sender(arg0),
            paused   : false,
            version  : 1,
        };
        0x2::transfer::share_object<OperatorHub>(v0);
    }

    public fun is_paused(arg0: &OperatorHub) : bool {
        arg0.paused
    }

    public fun set_operator(arg0: &0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::admin::AdminCap, arg1: &mut OperatorHub, arg2: address) {
        arg1.operator = arg2;
        let v0 = OperatorRotated{
            old_operator : arg1.operator,
            new_operator : arg2,
        };
        0x2::event::emit<OperatorRotated>(v0);
    }

    public fun set_paused(arg0: &0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::admin::AdminCap, arg1: &mut OperatorHub, arg2: bool) {
        arg1.paused = arg2;
        let v0 = GlobalPauseSet{paused: arg2};
        0x2::event::emit<GlobalPauseSet>(v0);
    }

    // decompiled from Move bytecode v7
}

