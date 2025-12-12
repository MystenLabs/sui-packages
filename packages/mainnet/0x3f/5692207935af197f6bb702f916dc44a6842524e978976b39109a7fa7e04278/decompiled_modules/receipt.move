module 0x3f5692207935af197f6bb702f916dc44a6842524e978976b39109a7fa7e04278::receipt {
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

