module 0x3fef274ab2363f7bb99b937bc303299e59d5330066416cf61fa2e3f7d99fad70::admin {
    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x3fef274ab2363f7bb99b937bc303299e59d5330066416cf61fa2e3f7d99fad70::permission::create(arg0);
    }

    public fun removeAdmin(arg0: &mut 0x3fef274ab2363f7bb99b937bc303299e59d5330066416cf61fa2e3f7d99fad70::permission::Admin, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x3fef274ab2363f7bb99b937bc303299e59d5330066416cf61fa2e3f7d99fad70::permission::is_admin(arg0, v0), 0);
        assert!(arg1 != v0, 1);
        0x3fef274ab2363f7bb99b937bc303299e59d5330066416cf61fa2e3f7d99fad70::permission::remove_admin(arg0, arg1);
    }

    public fun setAdmin(arg0: &mut 0x3fef274ab2363f7bb99b937bc303299e59d5330066416cf61fa2e3f7d99fad70::permission::Admin, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x3fef274ab2363f7bb99b937bc303299e59d5330066416cf61fa2e3f7d99fad70::permission::is_admin(arg0, 0x2::tx_context::sender(arg2)), 0);
        0x3fef274ab2363f7bb99b937bc303299e59d5330066416cf61fa2e3f7d99fad70::permission::set_admin(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

