module 0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::lp_executor {
    struct LPExecuted has copy, drop {
        mandate_id: 0x2::object::ID,
        category: vector<u8>,
        amount_a: u64,
        amount_b: u64,
    }

    public fun lp_entry(arg0: &0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::mandate::Mandate, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::mandate::assert_initialized(arg0);
        assert!(0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::mandate::is_category_allowed(arg0, &arg1), 100);
        let v0 = LPExecuted{
            mandate_id : 0x2::object::id<0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::mandate::Mandate>(arg0),
            category   : arg1,
            amount_a   : arg2,
            amount_b   : arg3,
        };
        0x2::event::emit<LPExecuted>(v0);
    }

    // decompiled from Move bytecode v7
}

