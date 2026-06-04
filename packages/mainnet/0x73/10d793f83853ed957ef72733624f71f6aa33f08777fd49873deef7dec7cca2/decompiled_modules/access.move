module 0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::access {
    entry fun seal_approve(arg0: vector<u8>, arg1: &0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::Form, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::Form>(arg1);
        let v1 = 0x2::object::id_to_bytes(&v0);
        assert!(starts_with(&arg0, &v1), 13906834247357825025);
        assert!(0x7310d793f83853ed957ef72733624f71f6aa33f08777fd49873deef7dec7cca2::forms::is_authorized(arg1, 0x2::tx_context::sender(arg2)), 13906834251652923395);
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

    // decompiled from Move bytecode v6
}

