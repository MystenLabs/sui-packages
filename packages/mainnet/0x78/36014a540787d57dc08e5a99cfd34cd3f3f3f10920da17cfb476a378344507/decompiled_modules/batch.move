module 0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::batch {
    struct BatchPayment has key {
        id: 0x2::object::UID,
        sender: address,
        recipients: vector<Recipient>,
        total_amount: u64,
        currency: 0x1::type_name::TypeName,
        status: u8,
        executed_count: u64,
        success_count: u64,
        failed_count: u64,
        created_at: u64,
        executed_at: 0x1::option::Option<u64>,
    }

    struct Recipient has copy, drop, store {
        address: address,
        amount: u64,
        metadata: 0x1::string::String,
        status: u8,
        failure_reason: 0x1::option::Option<0x1::string::String>,
    }

    struct BatchPaymentExecuted has copy, drop {
        batch_id: 0x2::object::ID,
        total_recipients: u64,
        success_count: u64,
        failed_count: u64,
        timestamp: u64,
    }

    public fun create_and_execute_batch<T0>(arg0: vector<Recipient>, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = create_batch_payment<T0>(arg0, arg1, arg3);
        let v1 = &mut v0;
        execute_batch_payment<T0>(v1, arg2, arg3);
        0x2::transfer::transfer<BatchPayment>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun create_batch_payment<T0>(arg0: vector<Recipient>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : BatchPayment {
        let v0 = 0x1::vector::length<Recipient>(&arg0);
        assert!(v0 > 0, 400);
        assert!(v0 <= 100, 401);
        BatchPayment{
            id             : 0x2::object::new(arg2),
            sender         : 0x2::tx_context::sender(arg2),
            recipients     : arg0,
            total_amount   : arg1,
            currency       : 0x1::type_name::get<T0>(),
            status         : 0,
            executed_count : 0,
            success_count  : 0,
            failed_count   : 0,
            created_at     : 0x2::tx_context::epoch(arg2),
            executed_at    : 0x1::option::none<u64>(),
        }
    }

    public fun create_recipient(arg0: address, arg1: u64, arg2: 0x1::string::String) : Recipient {
        Recipient{
            address        : arg0,
            amount         : arg1,
            metadata       : arg2,
            status         : 0,
            failure_reason : 0x1::option::none<0x1::string::String>(),
        }
    }

    public entry fun execute_batch_payment<T0>(arg0: &mut BatchPayment, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) >= arg0.total_amount, 402);
        let v0 = 0;
        let v1 = 0x1::vector::length<Recipient>(&arg0.recipients);
        while (v0 < v1) {
            let v2 = 0x1::vector::borrow_mut<Recipient>(&mut arg0.recipients, v0);
            if (0x2::coin::value<T0>(&arg1) >= v2.amount) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v2.amount, arg2), v2.address);
                v2.status = 1;
                arg0.success_count = arg0.success_count + 1;
            } else {
                v2.status = 2;
                v2.failure_reason = 0x1::option::some<0x1::string::String>(0x1::string::utf8(b"Insufficient remaining balance"));
                arg0.failed_count = arg0.failed_count + 1;
            };
            arg0.executed_count = arg0.executed_count + 1;
            v0 = v0 + 1;
        };
        if (0x2::coin::value<T0>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.sender);
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
        arg0.status = 3;
        arg0.executed_at = 0x1::option::some<u64>(0x2::tx_context::epoch(arg2));
        let v3 = BatchPaymentExecuted{
            batch_id         : 0x2::object::id<BatchPayment>(arg0),
            total_recipients : v1,
            success_count    : arg0.success_count,
            failed_count     : arg0.failed_count,
            timestamp        : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<BatchPaymentExecuted>(v3);
    }

    public fun get_created_at(arg0: &BatchPayment) : u64 {
        arg0.created_at
    }

    public fun get_executed_at(arg0: &BatchPayment) : 0x1::option::Option<u64> {
        arg0.executed_at
    }

    public fun get_executed_count(arg0: &BatchPayment) : u64 {
        arg0.executed_count
    }

    public fun get_failed_count(arg0: &BatchPayment) : u64 {
        arg0.failed_count
    }

    public fun get_recipient(arg0: &BatchPayment, arg1: u64) : &Recipient {
        0x1::vector::borrow<Recipient>(&arg0.recipients, arg1)
    }

    public fun get_recipient_address(arg0: &Recipient) : address {
        arg0.address
    }

    public fun get_recipient_amount(arg0: &Recipient) : u64 {
        arg0.amount
    }

    public fun get_recipient_metadata(arg0: &Recipient) : 0x1::string::String {
        arg0.metadata
    }

    public fun get_recipient_status(arg0: &Recipient) : u8 {
        arg0.status
    }

    public fun get_sender(arg0: &BatchPayment) : address {
        arg0.sender
    }

    public fun get_status(arg0: &BatchPayment) : u8 {
        arg0.status
    }

    public fun get_success_count(arg0: &BatchPayment) : u64 {
        arg0.success_count
    }

    public fun get_total_amount(arg0: &BatchPayment) : u64 {
        arg0.total_amount
    }

    public fun get_total_recipients(arg0: &BatchPayment) : u64 {
        0x1::vector::length<Recipient>(&arg0.recipients)
    }

    public fun is_completed(arg0: &BatchPayment) : bool {
        arg0.status == 3
    }

    public fun is_pending(arg0: &BatchPayment) : bool {
        arg0.status == 0
    }

    // decompiled from Move bytecode v6
}

