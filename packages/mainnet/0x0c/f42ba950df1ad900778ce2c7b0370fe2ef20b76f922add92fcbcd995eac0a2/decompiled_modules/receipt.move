module 0xcf42ba950df1ad900778ce2c7b0370fe2ef20b76f922add92fcbcd995eac0a2::receipt {
    struct ReceiptCreated has copy, drop {
        receipt_id: address,
        vault_id: address,
    }

    struct Receipt has store, key {
        id: 0x2::object::UID,
        vault_id: address,
    }

    public(friend) fun create_receipt(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : Receipt {
        let v0 = Receipt{
            id       : 0x2::object::new(arg1),
            vault_id : arg0,
        };
        let v1 = ReceiptCreated{
            receipt_id : 0x2::object::uid_to_address(&v0.id),
            vault_id   : arg0,
        };
        0x2::event::emit<ReceiptCreated>(v1);
        v0
    }

    public fun receipt_id(arg0: &Receipt) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun vault_id(arg0: &Receipt) : address {
        arg0.vault_id
    }

    // decompiled from Move bytecode v6
}

