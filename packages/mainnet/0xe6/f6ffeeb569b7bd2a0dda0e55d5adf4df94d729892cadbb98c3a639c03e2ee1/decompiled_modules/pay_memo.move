module 0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::pay_memo {
    struct PayMemo has copy, drop {
        reference_id: 0x2::object::ID,
        merchant: 0x1::string::String,
        description: 0x1::string::String,
    }

    public entry fun emit(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        let v0 = PayMemo{
            reference_id : arg0,
            merchant     : arg1,
            description  : arg2,
        };
        0x2::event::emit<PayMemo>(v0);
    }

    // decompiled from Move bytecode v6
}

