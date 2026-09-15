module 0x710ee802f34bc22b66f6ac5ab3de25a818280f2412dd3b71bbfae4106a81dd4c::platform_fees {
    struct Accrued has copy, drop {
        pool: 0x2::object::ID,
        config: 0x2::object::ID,
        quote_type: 0x1::type_name::TypeName,
        amount: u64,
        balance: u64,
    }

    struct Collected has copy, drop {
        pool: 0x2::object::ID,
        config: 0x2::object::ID,
        quote_type: 0x1::type_name::TypeName,
        amount: u64,
        balance: u64,
        collector: address,
    }

    public(friend) fun accrued<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        if (arg2 > 0) {
            let v0 = Accrued{
                pool       : arg0,
                config     : arg1,
                quote_type : 0x1::type_name::with_original_ids<T0>(),
                amount     : arg2,
                balance    : arg3,
            };
            0x2::event::emit<Accrued>(v0);
        };
    }

    public(friend) fun collected<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: address) {
        if (arg2 > 0) {
            let v0 = Collected{
                pool       : arg0,
                config     : arg1,
                quote_type : 0x1::type_name::with_original_ids<T0>(),
                amount     : arg2,
                balance    : arg3,
                collector  : arg4,
            };
            0x2::event::emit<Collected>(v0);
        };
    }

    // decompiled from Move bytecode v7
}

