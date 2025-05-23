module 0xe48836adecb638703f5444b2d26fefb729c967c9455334867c3f25a6edc7e610::securetransfer {
    struct Payment has key {
        id: 0x2::object::UID,
        payer: address,
        payee: address,
        amount: 0x2::balance::Balance<0x2::sui::SUI>,
        created_at: u64,
        payment_id: vector<u8>,
        status: u8,
    }

    struct PaymentReceipt has store, key {
        id: 0x2::object::UID,
        payment_id: vector<u8>,
        payment_object_id: address,
    }

    struct PaymentSent has copy, drop {
        payment_id: vector<u8>,
        from: address,
        to: address,
        amount: u64,
        payment_object_id: address,
    }

    struct PaymentClaimed has copy, drop {
        payment_id: vector<u8>,
        by: address,
        payment_object_id: address,
    }

    struct PaymentReimbursed has copy, drop {
        payment_id: vector<u8>,
        by: address,
        payment_object_id: address,
    }

    public entry fun claim(arg0: &mut Payment, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.status == 0, 3);
        assert!(v0 == arg0.payee, 4);
        arg0.status = 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.amount, 0x2::balance::value<0x2::sui::SUI>(&arg0.amount), arg1), v0);
        let v1 = PaymentClaimed{
            payment_id        : arg0.payment_id,
            by                : v0,
            payment_object_id : 0x2::object::uid_to_address(&arg0.id),
        };
        0x2::event::emit<PaymentClaimed>(v1);
    }

    public fun get_payment_details(arg0: &Payment) : (address, address, u64, u64, 0x1::string::String) {
        (arg0.payer, arg0.payee, 0x2::balance::value<0x2::sui::SUI>(&arg0.amount), arg0.created_at, status_as_string(arg0))
    }

    public entry fun reimburse(arg0: &mut Payment, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.status == 0, 5);
        assert!(v0 == arg0.payer, 6);
        arg0.status = 2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.amount, 0x2::balance::value<0x2::sui::SUI>(&arg0.amount), arg1), v0);
        let v1 = PaymentReimbursed{
            payment_id        : arg0.payment_id,
            by                : v0,
            payment_object_id : 0x2::object::uid_to_address(&arg0.id),
        };
        0x2::event::emit<PaymentReimbursed>(v1);
    }

    public entry fun send_to(arg0: vector<u8>, arg1: address, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v1 > 0, 1);
        assert!(arg1 != @0x0, 2);
        let v2 = Payment{
            id         : 0x2::object::new(arg3),
            payer      : v0,
            payee      : arg1,
            amount     : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
            created_at : 0x2::tx_context::epoch(arg3),
            payment_id : arg0,
            status     : 0,
        };
        let v3 = 0x2::object::uid_to_address(&v2.id);
        let v4 = PaymentReceipt{
            id                : 0x2::object::new(arg3),
            payment_id        : arg0,
            payment_object_id : v3,
        };
        0x2::transfer::public_transfer<PaymentReceipt>(v4, v0);
        0x2::transfer::share_object<Payment>(v2);
        let v5 = PaymentSent{
            payment_id        : arg0,
            from              : v0,
            to                : arg1,
            amount            : v1,
            payment_object_id : v3,
        };
        0x2::event::emit<PaymentSent>(v5);
    }

    public fun status_as_string(arg0: &Payment) : 0x1::string::String {
        if (arg0.status == 0) {
            0x1::string::utf8(b"Sent")
        } else if (arg0.status == 1) {
            0x1::string::utf8(b"Claimed")
        } else {
            0x1::string::utf8(b"Reimbursed")
        }
    }

    public fun status_is_claimed(arg0: &Payment) : bool {
        arg0.status == 1
    }

    public fun status_is_reimbursed(arg0: &Payment) : bool {
        arg0.status == 2
    }

    public fun status_is_sent(arg0: &Payment) : bool {
        arg0.status == 0
    }

    // decompiled from Move bytecode v6
}

