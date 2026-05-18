module 0xeafe4800dc71923b1e743f199738aa85fbdc6c8cec55ff138f0d69ee6da72dd4::acl {
    public fun seal_approve(arg0: vector<u8>, arg1: &0xeafe4800dc71923b1e743f199738aa85fbdc6c8cec55ff138f0d69ee6da72dd4::form::Form, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xeafe4800dc71923b1e743f199738aa85fbdc6c8cec55ff138f0d69ee6da72dd4::form::Form>(arg1);
        let v1 = 0x2::object::id_to_bytes(&v0);
        let v2 = 0x1::vector::length<u8>(&v1);
        assert!(0x1::vector::length<u8>(&arg0) >= v2, 2);
        let v3 = 0;
        while (v3 < v2) {
            assert!(*0x1::vector::borrow<u8>(&arg0, v3) == *0x1::vector::borrow<u8>(&v1, v3), 2);
            v3 = v3 + 1;
        };
        assert!(0xeafe4800dc71923b1e743f199738aa85fbdc6c8cec55ff138f0d69ee6da72dd4::form::is_admin(arg1, 0x2::tx_context::sender(arg2)), 1);
    }

    // decompiled from Move bytecode v7
}

