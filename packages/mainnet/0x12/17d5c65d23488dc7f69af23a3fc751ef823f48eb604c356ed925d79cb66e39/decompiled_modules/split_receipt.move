module 0x1217d5c65d23488dc7f69af23a3fc751ef823f48eb604c356ed925d79cb66e39::split_receipt {
    struct SplitReceipt has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        face_value: u64,
        backing_amount: u64,
        initial_rate: u64,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : SplitReceipt {
        SplitReceipt{
            id             : 0x2::object::new(arg4),
            market_id      : arg0,
            face_value     : arg1,
            backing_amount : arg2,
            initial_rate   : arg3,
        }
    }

    public fun backing_amount(arg0: &SplitReceipt) : u64 {
        arg0.backing_amount
    }

    public(friend) fun consume_for_early_exit(arg0: SplitReceipt, arg1: 0x2::object::ID, arg2: u64, arg3: u64) : u64 {
        assert!(arg0.market_id == arg1, 0);
        assert!(arg0.face_value == arg2, 1);
        assert!(arg0.face_value == arg3, 1);
        destroy_inner(arg0);
        arg0.backing_amount
    }

    public(friend) fun destroy(arg0: SplitReceipt, arg1: 0x2::object::ID) {
        assert!(arg0.market_id == arg1, 0);
        destroy_inner(arg0);
    }

    fun destroy_inner(arg0: SplitReceipt) {
        let SplitReceipt {
            id             : v0,
            market_id      : _,
            face_value     : _,
            backing_amount : _,
            initial_rate   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun face_value(arg0: &SplitReceipt) : u64 {
        arg0.face_value
    }

    public fun initial_rate(arg0: &SplitReceipt) : u64 {
        arg0.initial_rate
    }

    public fun market_id(arg0: &SplitReceipt) : 0x2::object::ID {
        arg0.market_id
    }

    // decompiled from Move bytecode v7
}

