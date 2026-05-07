module 0xb90d18321d8c4652743a7c0ae0747b4723e7dedb954d5844c48b3bd44a715c4d::receipt {
    struct Receipt has store, key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
        response_index: u64,
        issued_to: address,
        issued_at_ms: u64,
    }

    public fun form_id(arg0: &Receipt) : 0x2::object::ID {
        arg0.form_id
    }

    public fun issued_to(arg0: &Receipt) : address {
        arg0.issued_to
    }

    public fun mint_receipt(arg0: &0xb90d18321d8c4652743a7c0ae0747b4723e7dedb954d5844c48b3bd44a715c4d::form::Form, arg1: u64, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Receipt {
        let v0 = Receipt{
            id             : 0x2::object::new(arg4),
            form_id        : 0xb90d18321d8c4652743a7c0ae0747b4723e7dedb954d5844c48b3bd44a715c4d::form::id(arg0),
            response_index : arg1,
            issued_to      : arg2,
            issued_at_ms   : arg3,
        };
        0xb90d18321d8c4652743a7c0ae0747b4723e7dedb954d5844c48b3bd44a715c4d::events::emit_receipt_minted(0xb90d18321d8c4652743a7c0ae0747b4723e7dedb954d5844c48b3bd44a715c4d::form::id(arg0), arg1, arg2);
        v0
    }

    public fun response_index(arg0: &Receipt) : u64 {
        arg0.response_index
    }

    // decompiled from Move bytecode v7
}

