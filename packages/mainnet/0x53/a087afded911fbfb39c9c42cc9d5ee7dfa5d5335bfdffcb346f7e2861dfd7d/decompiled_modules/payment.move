module 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::payment {
    struct PaymentRequest has store, key {
        id: 0x2::object::UID,
        creator: address,
        recipient: address,
        label: 0x1::string::String,
        amount: u64,
        paid: bool,
        cancelled: bool,
        payer: 0x1::option::Option<address>,
        created_at_ms: u64,
        expires_at_ms: 0x1::option::Option<u64>,
    }

    struct PaymentRequested has copy, drop {
        request_id: 0x2::object::ID,
        creator: address,
        recipient: address,
        label: 0x1::string::String,
        amount: u64,
        created_at_ms: u64,
        expires_at_ms: 0x1::option::Option<u64>,
    }

    struct PaymentPaid has copy, drop {
        request_id: 0x2::object::ID,
        payer: address,
        recipient: address,
        amount: u64,
    }

    struct PaymentCancelled has copy, drop {
        request_id: 0x2::object::ID,
        by: address,
    }

    public fun cancel(arg0: &mut PaymentRequest, arg1: &0x2::tx_context::TxContext) {
        assert!(!arg0.paid && !arg0.cancelled, 2);
        assert!(0x2::tx_context::sender(arg1) == arg0.creator || 0x2::tx_context::sender(arg1) == arg0.recipient, 4);
        arg0.cancelled = true;
        let v0 = PaymentCancelled{
            request_id : 0x2::object::id<PaymentRequest>(arg0),
            by         : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<PaymentCancelled>(v0);
    }

    public fun create_request(arg0: address, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::option::Option<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 0);
        let v0 = PaymentRequest{
            id            : 0x2::object::new(arg5),
            creator       : 0x2::tx_context::sender(arg5),
            recipient     : arg0,
            label         : arg1,
            amount        : arg2,
            paid          : false,
            cancelled     : false,
            payer         : 0x1::option::none<address>(),
            created_at_ms : 0x2::clock::timestamp_ms(arg4),
            expires_at_ms : arg3,
        };
        let v1 = PaymentRequested{
            request_id    : 0x2::object::id<PaymentRequest>(&v0),
            creator       : v0.creator,
            recipient     : v0.recipient,
            label         : v0.label,
            amount        : v0.amount,
            created_at_ms : v0.created_at_ms,
            expires_at_ms : v0.expires_at_ms,
        };
        0x2::event::emit<PaymentRequested>(v1);
        0x2::transfer::share_object<PaymentRequest>(v0);
    }

    public fun e_already_closed() : u64 {
        2
    }

    public fun e_expired() : u64 {
        3
    }

    public fun e_not_controller() : u64 {
        4
    }

    public fun e_underpaid() : u64 {
        1
    }

    public fun e_zero_amount() : u64 {
        0
    }

    public fun pay(arg0: &mut PaymentRequest, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paid && !arg0.cancelled, 2);
        if (0x1::option::is_some<u64>(&arg0.expires_at_ms)) {
            assert!(0x2::clock::timestamp_ms(arg2) <= *0x1::option::borrow<u64>(&arg0.expires_at_ms), 3);
        };
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= arg0.amount, 1);
        if (v0 > arg0.amount) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v0 - arg0.amount, arg3), 0x2::tx_context::sender(arg3));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.recipient);
        arg0.paid = true;
        arg0.payer = 0x1::option::some<address>(0x2::tx_context::sender(arg3));
        let v1 = PaymentPaid{
            request_id : 0x2::object::id<PaymentRequest>(arg0),
            payer      : 0x2::tx_context::sender(arg3),
            recipient  : arg0.recipient,
            amount     : arg0.amount,
        };
        0x2::event::emit<PaymentPaid>(v1);
    }

    public fun request_amount(arg0: &PaymentRequest) : u64 {
        arg0.amount
    }

    public fun request_cancelled(arg0: &PaymentRequest) : bool {
        arg0.cancelled
    }

    public fun request_created_at_ms(arg0: &PaymentRequest) : u64 {
        arg0.created_at_ms
    }

    public fun request_creator(arg0: &PaymentRequest) : address {
        arg0.creator
    }

    public fun request_expires_at_ms(arg0: &PaymentRequest) : 0x1::option::Option<u64> {
        arg0.expires_at_ms
    }

    public fun request_label(arg0: &PaymentRequest) : 0x1::string::String {
        arg0.label
    }

    public fun request_paid(arg0: &PaymentRequest) : bool {
        arg0.paid
    }

    public fun request_payer(arg0: &PaymentRequest) : 0x1::option::Option<address> {
        arg0.payer
    }

    public fun request_recipient(arg0: &PaymentRequest) : address {
        arg0.recipient
    }

    // decompiled from Move bytecode v7
}

