module 0xf548d98175bb5e0358b5b5149d9156fd861087d5d44e214c961c96889a68712b::features {
    struct Features has store, key {
        id: 0x2::object::UID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public(friend) fun new(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Features {
        Features{
            id        : 0x2::object::new(arg2),
            coin_type : arg0,
            amount    : arg1,
        }
    }

    public fun amount(arg0: &Features) : u64 {
        arg0.amount
    }

    public fun coin_type(arg0: &Features) : 0x1::type_name::TypeName {
        arg0.coin_type
    }

    public(friend) fun destroy(arg0: Features) {
        let Features {
            id        : v0,
            coin_type : _,
            amount    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

