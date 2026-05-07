module 0xb90d18321d8c4652743a7c0ae0747b4723e7dedb954d5844c48b3bd44a715c4d::events {
    struct FormCreated has copy, drop {
        form_id: 0x2::object::ID,
        owner: address,
        schema_version: u64,
    }

    struct ResponseSubmitted has copy, drop {
        form_id: 0x2::object::ID,
        response_index: u64,
        submitter: address,
        severity: u8,
    }

    struct AdminAdded has copy, drop {
        form_id: 0x2::object::ID,
        admin: address,
    }

    struct BountyPaid has copy, drop {
        form_id: 0x2::object::ID,
        response_index: u64,
        recipient: address,
        amount: u64,
    }

    struct ReceiptMinted has copy, drop {
        form_id: 0x2::object::ID,
        response_index: u64,
        recipient: address,
    }

    public fun emit_admin_added(arg0: 0x2::object::ID, arg1: address) {
        let v0 = AdminAdded{
            form_id : arg0,
            admin   : arg1,
        };
        0x2::event::emit<AdminAdded>(v0);
    }

    public fun emit_bounty_paid(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: u64) {
        let v0 = BountyPaid{
            form_id        : arg0,
            response_index : arg1,
            recipient      : arg2,
            amount         : arg3,
        };
        0x2::event::emit<BountyPaid>(v0);
    }

    public fun emit_form_created(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = FormCreated{
            form_id        : arg0,
            owner          : arg1,
            schema_version : arg2,
        };
        0x2::event::emit<FormCreated>(v0);
    }

    public fun emit_receipt_minted(arg0: 0x2::object::ID, arg1: u64, arg2: address) {
        let v0 = ReceiptMinted{
            form_id        : arg0,
            response_index : arg1,
            recipient      : arg2,
        };
        0x2::event::emit<ReceiptMinted>(v0);
    }

    public fun emit_response_submitted(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: u8) {
        let v0 = ResponseSubmitted{
            form_id        : arg0,
            response_index : arg1,
            submitter      : arg2,
            severity       : arg3,
        };
        0x2::event::emit<ResponseSubmitted>(v0);
    }

    // decompiled from Move bytecode v7
}

