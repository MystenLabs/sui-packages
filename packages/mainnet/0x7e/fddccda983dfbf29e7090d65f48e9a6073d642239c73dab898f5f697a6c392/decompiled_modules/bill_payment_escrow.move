module 0x7efddccda983dfbf29e7090d65f48e9a6073d642239c73dab898f5f697a6c392::bill_payment_escrow {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BillPaymentEscrow<phantom T0> has store, key {
        id: 0x2::object::UID,
        payer: address,
        amount: u64,
        bill_type: 0x1::string::String,
        bill_details: 0x1::string::String,
        provider: 0x1::string::String,
        status: u8,
        created_at: u64,
        expires_at: u64,
        escrow_balance: 0x2::balance::Balance<T0>,
        api_reference: 0x1::string::String,
        refund_address: address,
        coin_type: 0x1::type_name::TypeName,
    }

    struct PaymentInitiated has copy, drop {
        escrow_id: 0x2::object::ID,
        payer: address,
        amount: u64,
        bill_type: 0x1::string::String,
        provider: 0x1::string::String,
        timestamp: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct PaymentCompleted has copy, drop {
        escrow_id: 0x2::object::ID,
        payer: address,
        amount: u64,
        api_reference: 0x1::string::String,
        timestamp: u64,
    }

    struct PaymentRefunded has copy, drop {
        escrow_id: 0x2::object::ID,
        payer: address,
        amount: u64,
        reason: 0x1::string::String,
        timestamp: u64,
    }

    public fun create_escrow<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        let v3 = BillPaymentEscrow<T0>{
            id             : 0x2::object::new(arg5),
            payer          : v1,
            amount         : v0,
            bill_type      : arg1,
            bill_details   : arg2,
            provider       : arg3,
            status         : 0,
            created_at     : v2,
            expires_at     : v2 + 300000,
            escrow_balance : 0x2::coin::into_balance<T0>(arg0),
            api_reference  : 0x1::string::utf8(b""),
            refund_address : v1,
            coin_type      : 0x1::type_name::get<T0>(),
        };
        let v4 = 0x2::object::id<BillPaymentEscrow<T0>>(&v3);
        let v5 = PaymentInitiated{
            escrow_id : v4,
            payer     : v1,
            amount    : v0,
            bill_type : arg1,
            provider  : arg3,
            timestamp : v2,
            coin_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<PaymentInitiated>(v5);
        0x2::transfer::share_object<BillPaymentEscrow<T0>>(v3);
        v4
    }

    public fun get_amount<T0>(arg0: &BillPaymentEscrow<T0>) : u64 {
        arg0.amount
    }

    public fun get_coin_type<T0>(arg0: &BillPaymentEscrow<T0>) : 0x1::type_name::TypeName {
        arg0.coin_type
    }

    public fun get_payer<T0>(arg0: &BillPaymentEscrow<T0>) : address {
        arg0.payer
    }

    public fun get_status<T0>(arg0: &BillPaymentEscrow<T0>) : u8 {
        arg0.status
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_expired<T0>(arg0: &BillPaymentEscrow<T0>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.expires_at
    }

    public fun mark_success<T0>(arg0: &AdminCap, arg1: &mut BillPaymentEscrow<T0>, arg2: 0x1::string::String, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 0, 2);
        assert!(0x2::clock::timestamp_ms(arg4) < arg1.expires_at, 3);
        arg1.status = 1;
        arg1.api_reference = arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.escrow_balance), arg5), arg3);
        let v0 = PaymentCompleted{
            escrow_id     : 0x2::object::id<BillPaymentEscrow<T0>>(arg1),
            payer         : arg1.payer,
            amount        : arg1.amount,
            api_reference : arg2,
            timestamp     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<PaymentCompleted>(v0);
    }

    public fun process_expired<T0>(arg0: &mut BillPaymentEscrow<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 2);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.expires_at, 4);
        arg0.status = 3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.escrow_balance), arg2), arg0.refund_address);
        let v0 = PaymentRefunded{
            escrow_id : 0x2::object::id<BillPaymentEscrow<T0>>(arg0),
            payer     : arg0.payer,
            amount    : arg0.amount,
            reason    : 0x1::string::utf8(b"Payment expired"),
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<PaymentRefunded>(v0);
    }

    public fun refund_payment<T0>(arg0: &AdminCap, arg1: &mut BillPaymentEscrow<T0>, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 0, 2);
        arg1.status = 3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.escrow_balance), arg4), arg1.refund_address);
        let v0 = PaymentRefunded{
            escrow_id : 0x2::object::id<BillPaymentEscrow<T0>>(arg1),
            payer     : arg1.payer,
            amount    : arg1.amount,
            reason    : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PaymentRefunded>(v0);
    }

    // decompiled from Move bytecode v6
}

