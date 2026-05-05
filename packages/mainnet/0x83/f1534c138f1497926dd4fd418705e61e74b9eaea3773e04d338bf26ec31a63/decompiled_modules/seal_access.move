module 0x83f1534c138f1497926dd4fd418705e61e74b9eaea3773e04d338bf26ec31a63::seal_access {
    entry fun seal_approve(arg0: vector<u8>, arg1: &0x83f1534c138f1497926dd4fd418705e61e74b9eaea3773e04d338bf26ec31a63::admin::AdminAllowlist, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x83f1534c138f1497926dd4fd418705e61e74b9eaea3773e04d338bf26ec31a63::admin::AdminAllowlist>(arg1);
        let v1 = 0x2::object::id_to_bytes(&v0);
        let v2 = 0x1::vector::length<u8>(&v1);
        assert!(0x1::vector::length<u8>(&arg0) >= v2, 400);
        let v3 = 0;
        while (v3 < v2) {
            assert!(*0x1::vector::borrow<u8>(&arg0, v3) == *0x1::vector::borrow<u8>(&v1, v3), 400);
            v3 = v3 + 1;
        };
        assert!(0x83f1534c138f1497926dd4fd418705e61e74b9eaea3773e04d338bf26ec31a63::admin::is_member(arg1, 0x2::tx_context::sender(arg2)), 401);
    }

    // decompiled from Move bytecode v7
}

