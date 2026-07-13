module 0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::lp_ops {
    struct LpActionAuthorized has copy, drop {
        mandate_id: 0x2::object::ID,
        category: vector<u8>,
        merchant: address,
        nonce: u64,
    }

    public fun authorize_lp_action(arg0: &mut 0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::mandate::Mandate, arg1: vector<u8>, arg2: address, arg3: &0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::merchant_registry::MerchantRegistry, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::mandate::assert_initialized(arg0);
        assert!(0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::mandate::is_category_allowed(arg0, &arg1), 25);
        assert!(0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::merchant_registry::is_registered_as(arg3, arg2, &arg1), 30);
        assert!(0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::mandate::projected_today_spent(arg0, 0, arg4) <= 0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::mandate::daily_limit(arg0), 28);
        0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::mandate::record_payment_and_rotate(arg0, 0, b"", b"", arg4);
        let v0 = LpActionAuthorized{
            mandate_id : 0x2::object::id<0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::mandate::Mandate>(arg0),
            category   : arg1,
            merchant   : arg2,
            nonce      : 0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::mandate::nonce(arg0),
        };
        0x2::event::emit<LpActionAuthorized>(v0);
    }

    // decompiled from Move bytecode v7
}

