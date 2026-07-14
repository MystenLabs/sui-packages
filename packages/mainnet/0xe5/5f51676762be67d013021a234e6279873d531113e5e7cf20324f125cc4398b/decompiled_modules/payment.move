module 0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::payment {
    struct PaymentAuthorized has copy, drop {
        mandate_id: 0x2::object::ID,
        category: vector<u8>,
        nonce: u64,
    }

    public fun authorize_action(arg0: &mut 0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::mandate::Mandate, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::mandate::assert_initialized(arg0);
        assert!(0x2::hash::keccak256(&arg2) == 0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::mandate::auth_secret_hash(arg0), 20);
        assert!(!0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::mandate::is_revoked(arg0), 21);
        assert!(0x2::clock::timestamp_ms(arg5) <= 0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::mandate::expires_at_ms(arg0), 22);
        assert!(0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::mandate::is_category_allowed(arg0, &arg1), 25);
        assert!(0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::mandate::projected_today_spent(arg0, 0, arg5) <= 0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::mandate::daily_limit(arg0), 28);
        0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::mandate::record_payment_and_rotate(arg0, 0, arg3, arg4, arg5);
        let v0 = PaymentAuthorized{
            mandate_id : 0x2::object::id<0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::mandate::Mandate>(arg0),
            category   : arg1,
            nonce      : 0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::mandate::nonce(arg0) + 1,
        };
        0x2::event::emit<PaymentAuthorized>(v0);
    }

    // decompiled from Move bytecode v7
}

