module 0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::refund {
    struct Refund has store, key {
        id: 0x2::object::UID,
        payment_id: 0x2::object::ID,
        merchant: address,
        payer: address,
        amount: u64,
        currency: 0x1::type_name::TypeName,
        reason: 0x1::string::String,
        status: u8,
        created_at: u64,
        executed_at: 0x1::option::Option<u64>,
    }

    struct RefundCap has store, key {
        id: 0x2::object::UID,
        refund_id: 0x2::object::ID,
    }

    struct RefundCreated has copy, drop {
        refund_id: 0x2::object::ID,
        payment_id: 0x2::object::ID,
        merchant: address,
        payer: address,
        amount: u64,
        currency: 0x1::type_name::TypeName,
        reason: 0x1::string::String,
        timestamp: u64,
    }

    struct RefundExecuted has copy, drop {
        refund_id: 0x2::object::ID,
        payment_id: 0x2::object::ID,
        payer: address,
        amount: u64,
        timestamp: u64,
    }

    struct RefundCancelled has copy, drop {
        refund_id: 0x2::object::ID,
        payment_id: 0x2::object::ID,
        merchant: address,
        reason: 0x1::string::String,
        timestamp: u64,
    }

    public fun get_amount(arg0: &Refund) : u64 {
        arg0.amount
    }

    public fun get_currency(arg0: &Refund) : 0x1::type_name::TypeName {
        arg0.currency
    }

    public fun get_id(arg0: &Refund) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_merchant(arg0: &Refund) : address {
        arg0.merchant
    }

    public fun get_payer(arg0: &Refund) : address {
        arg0.payer
    }

    public fun get_status(arg0: &Refund) : u8 {
        arg0.status
    }

    public entry fun cancel_refund(arg0: &mut Refund, arg1: &RefundCap, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        assert!(v0 == arg1.refund_id, 1);
        assert!(arg0.status == 0, 104);
        arg0.status = 2;
        0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::events::emit_refund_cancelled(v0, arg0.payment_id, arg0.merchant, arg0.reason, 0x2::clock::timestamp_ms(arg2));
    }

    public fun create_refund(arg0: &0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::payment::Payment, arg1: &0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::MerchantCap, arg2: u64, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (Refund, RefundCap) {
        assert!(0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::payment::get_status(arg0) == 1, 102);
        let v0 = 0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::payment::get_merchant(arg0);
        let v1 = 0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::payment::get_id(arg0);
        let v2 = 0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::payment::get_payer(arg0);
        let v3 = 0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::payment::get_currency(arg0);
        assert!(0x1::option::is_some<address>(&v2), 102);
        let v4 = *0x1::option::borrow<address>(&v2);
        assert!(arg2 > 0, 100);
        assert!(arg2 <= 0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::payment::get_amount(arg0), 103);
        let v5 = 0x1::string::length(&arg3);
        assert!(v5 > 0 && v5 <= 500, 101);
        let v6 = 0x2::object::new(arg5);
        let v7 = 0x2::object::uid_to_inner(&v6);
        let v8 = 0x2::clock::timestamp_ms(arg4);
        let v9 = Refund{
            id          : v6,
            payment_id  : v1,
            merchant    : v0,
            payer       : v4,
            amount      : arg2,
            currency    : v3,
            reason      : arg3,
            status      : 0,
            created_at  : v8,
            executed_at : 0x1::option::none<u64>(),
        };
        let v10 = RefundCap{
            id        : 0x2::object::new(arg5),
            refund_id : v7,
        };
        0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::events::emit_refund_created(v7, v1, v0, v4, arg2, v3, arg3, v8);
        (v9, v10)
    }

    public fun execute_refund<T0>(arg0: &mut Refund, arg1: &RefundCap, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        assert!(v0 == arg1.refund_id, 1);
        assert!(arg0.status == 0, 104);
        assert!(0x2::coin::value<T0>(&arg2) >= arg0.amount, 105);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, arg0.amount, arg4), arg0.payer);
        arg0.status = 1;
        let v1 = 0x2::clock::timestamp_ms(arg3);
        arg0.executed_at = 0x1::option::some<u64>(v1);
        0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::events::emit_refund_executed(v0, arg0.payment_id, arg0.payer, arg0.amount, v1);
        arg2
    }

    public fun get_created_at(arg0: &Refund) : u64 {
        arg0.created_at
    }

    public fun get_executed_at(arg0: &Refund) : 0x1::option::Option<u64> {
        arg0.executed_at
    }

    public fun get_payment_id(arg0: &Refund) : 0x2::object::ID {
        arg0.payment_id
    }

    public fun get_reason(arg0: &Refund) : 0x1::string::String {
        arg0.reason
    }

    public fun is_cancelled(arg0: &Refund) : bool {
        arg0.status == 2
    }

    public fun is_executed(arg0: &Refund) : bool {
        arg0.status == 1
    }

    public fun is_pending(arg0: &Refund) : bool {
        arg0.status == 0
    }

    // decompiled from Move bytecode v6
}

