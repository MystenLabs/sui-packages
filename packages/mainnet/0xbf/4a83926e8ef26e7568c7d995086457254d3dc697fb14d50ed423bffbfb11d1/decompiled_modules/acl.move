module 0xbf4a83926e8ef26e7568c7d995086457254d3dc697fb14d50ed423bffbfb11d1::acl {
    public fun seal_approve(arg0: &0xbf4a83926e8ef26e7568c7d995086457254d3dc697fb14d50ed423bffbfb11d1::form::Form, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xbf4a83926e8ef26e7568c7d995086457254d3dc697fb14d50ed423bffbfb11d1::form::Form>(arg0);
        let v1 = 0x2::object::id_to_bytes(&v0);
        let v2 = 0x1::vector::length<u8>(&v1);
        assert!(0x1::vector::length<u8>(&arg1) >= v2, 2);
        let v3 = 0;
        while (v3 < v2) {
            assert!(*0x1::vector::borrow<u8>(&arg1, v3) == *0x1::vector::borrow<u8>(&v1, v3), 2);
            v3 = v3 + 1;
        };
        assert!(0xbf4a83926e8ef26e7568c7d995086457254d3dc697fb14d50ed423bffbfb11d1::form::is_admin(arg0, 0x2::tx_context::sender(arg2)), 1);
    }

    // decompiled from Move bytecode v7
}

