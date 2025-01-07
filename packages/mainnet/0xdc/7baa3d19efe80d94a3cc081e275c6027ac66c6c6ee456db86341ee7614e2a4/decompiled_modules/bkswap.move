module 0xdc7baa3d19efe80d94a3cc081e275c6027ac66c6c6ee456db86341ee7614e2a4::bkswap {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct GlobalStatus has key {
        id: 0x2::object::UID,
        pause: bool,
        fee_rate: u64,
        fee_recipient: address,
    }

    struct InitEvent has copy, drop {
        sender: address,
        global_status_id: 0x2::object::ID,
    }

    struct SetPauseEvent has copy, drop {
        sender: address,
        status: bool,
    }

    struct SetFeeRateEvent has copy, drop {
        sender: address,
        fee_rate: u64,
    }

    struct SetFeeRecipientEvent has copy, drop {
        sender: address,
        fee_recipient: address,
    }

    public fun assert_pause(arg0: &GlobalStatus) {
        assert!(!get_pause_status(arg0), 1);
    }

    public fun collect_fee<T0>(arg0: &GlobalStatus, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        assert_pause(arg0);
        let v0 = 0;
        if (arg0.fee_rate > 0) {
            let v1 = safe_mul_div_u64(arg2, arg0.fee_rate, 10000);
            v0 = v1;
            0x2::pay::split_and_transfer<T0>(arg1, v1, arg0.fee_recipient, arg3);
        };
        arg2 - v0
    }

    fun get_pause_status(arg0: &GlobalStatus) : bool {
        arg0.pause
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = new_global_status_and_shared(arg0);
        let v2 = InitEvent{
            sender           : 0x2::tx_context::sender(arg0),
            global_status_id : v1,
        };
        0x2::event::emit<InitEvent>(v2);
    }

    fun new_global_status_and_shared(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = GlobalStatus{
            id            : 0x2::object::new(arg0),
            pause         : false,
            fee_rate      : 30,
            fee_recipient : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<GlobalStatus>(v0);
        0x2::object::id<GlobalStatus>(&v0)
    }

    fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public entry fun set_fee_rate(arg0: &AdminCap, arg1: &mut GlobalStatus, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 2500, 2);
        arg1.fee_rate = arg2;
        let v0 = SetFeeRateEvent{
            sender   : 0x2::tx_context::sender(arg3),
            fee_rate : arg2,
        };
        0x2::event::emit<SetFeeRateEvent>(v0);
    }

    public entry fun set_fee_recipient(arg0: &AdminCap, arg1: &mut GlobalStatus, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.fee_recipient = arg2;
        let v0 = SetFeeRecipientEvent{
            sender        : 0x2::tx_context::sender(arg3),
            fee_recipient : arg2,
        };
        0x2::event::emit<SetFeeRecipientEvent>(v0);
    }

    public entry fun set_pause_status(arg0: &AdminCap, arg1: &mut GlobalStatus, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.pause = arg2;
        let v0 = SetPauseEvent{
            sender : 0x2::tx_context::sender(arg3),
            status : arg2,
        };
        0x2::event::emit<SetPauseEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

