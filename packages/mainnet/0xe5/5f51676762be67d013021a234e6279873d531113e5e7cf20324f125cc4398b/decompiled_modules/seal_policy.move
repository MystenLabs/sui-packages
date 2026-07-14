module 0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::seal_policy {
    public fun seal_approve(arg0: vector<u8>, arg1: &0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::mandate::Mandate, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::mandate::Mandate>(arg1);
        let v1 = 0x2::object::id_to_bytes(&v0);
        assert!(starts_with(&arg0, &v1), 100);
        assert!(!0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::mandate::pending_init(arg1), 13);
        assert!(!0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::mandate::is_revoked(arg1), 21);
        assert!(0x2::clock::timestamp_ms(arg3) <= 0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::mandate::expires_at_ms(arg1), 22);
        assert!(0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::mandate::is_category_allowed(arg1, &arg2), 25);
        assert!(0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::mandate::projected_today_spent(arg1, 0, arg3) <= 0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::mandate::daily_limit(arg1), 28);
    }

    fun starts_with(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg1);
        if (0x1::vector::length<u8>(arg0) < v0) {
            return false
        };
        let v1 = 0;
        while (v1 < v0) {
            if (*0x1::vector::borrow<u8>(arg0, v1) != *0x1::vector::borrow<u8>(arg1, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    // decompiled from Move bytecode v7
}

