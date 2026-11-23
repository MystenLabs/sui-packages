module 0x6a3002ffdc45f107f6bd4079671283b4af28192cbdf2b90eb0dd3dab3f5569f1::invoice {
    struct Invoice<phantom T0> has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        agent: address,
        amount: u64,
        memo: 0x1::string::String,
        status: u8,
        payer: 0x1::option::Option<address>,
    }

    struct InvoiceCreated has copy, drop {
        invoice_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        agent: address,
        amount: u64,
        memo: 0x1::string::String,
    }

    struct InvoicePaid has copy, drop {
        invoice_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        agent: address,
        payer: address,
        amount: u64,
    }

    struct InvoiceCancelled has copy, drop {
        invoice_id: 0x2::object::ID,
    }

    public fun amount<T0>(arg0: &Invoice<T0>) : u64 {
        arg0.amount
    }

    public fun cancel<T0>(arg0: &mut Invoice<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.agent, 105);
        assert!(arg0.status == 0, 102);
        arg0.status = 2;
        let v0 = InvoiceCancelled{invoice_id: 0x2::object::id<Invoice<T0>>(arg0)};
        0x2::event::emit<InvoiceCancelled>(v0);
    }

    public fun create<T0>(arg0: &0x6a3002ffdc45f107f6bd4079671283b4af28192cbdf2b90eb0dd3dab3f5569f1::pool::Pool<T0>, arg1: u64, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x6a3002ffdc45f107f6bd4079671283b4af28192cbdf2b90eb0dd3dab3f5569f1::pool::has_card<T0>(arg0, v0), 101);
        assert!(0x6a3002ffdc45f107f6bd4079671283b4af28192cbdf2b90eb0dd3dab3f5569f1::pool::card_is_active<T0>(arg0, v0), 101);
        0x6a3002ffdc45f107f6bd4079671283b4af28192cbdf2b90eb0dd3dab3f5569f1::pool::check_memo(&arg2);
        let v1 = Invoice<T0>{
            id      : 0x2::object::new(arg3),
            pool_id : 0x2::object::id<0x6a3002ffdc45f107f6bd4079671283b4af28192cbdf2b90eb0dd3dab3f5569f1::pool::Pool<T0>>(arg0),
            agent   : v0,
            amount  : arg1,
            memo    : arg2,
            status  : 0,
            payer   : 0x1::option::none<address>(),
        };
        let v2 = InvoiceCreated{
            invoice_id : 0x2::object::id<Invoice<T0>>(&v1),
            pool_id    : 0x2::object::id<0x6a3002ffdc45f107f6bd4079671283b4af28192cbdf2b90eb0dd3dab3f5569f1::pool::Pool<T0>>(arg0),
            agent      : v0,
            amount     : arg1,
            memo       : arg2,
        };
        0x2::event::emit<InvoiceCreated>(v2);
        0x2::transfer::share_object<Invoice<T0>>(v1);
    }

    public fun is_paid<T0>(arg0: &Invoice<T0>) : bool {
        arg0.status == 1
    }

    public fun pay<T0>(arg0: &mut Invoice<T0>, arg1: &mut 0x6a3002ffdc45f107f6bd4079671283b4af28192cbdf2b90eb0dd3dab3f5569f1::pool::Pool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        settle<T0>(arg0, arg1, 0x2::coin::value<T0>(&arg2), arg3);
        0x6a3002ffdc45f107f6bd4079671283b4af28192cbdf2b90eb0dd3dab3f5569f1::pool::credit_earning<T0>(arg1, arg0.agent, 0x2::coin::into_balance<T0>(arg2), 0x2::tx_context::sender(arg3));
    }

    public fun pay_from_pool<T0>(arg0: &0x6a3002ffdc45f107f6bd4079671283b4af28192cbdf2b90eb0dd3dab3f5569f1::platform::Platform, arg1: &mut Invoice<T0>, arg2: &mut 0x6a3002ffdc45f107f6bd4079671283b4af28192cbdf2b90eb0dd3dab3f5569f1::pool::Pool<T0>, arg3: &mut 0x6a3002ffdc45f107f6bd4079671283b4af28192cbdf2b90eb0dd3dab3f5569f1::pool::Pool<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6a3002ffdc45f107f6bd4079671283b4af28192cbdf2b90eb0dd3dab3f5569f1::pool::spend_coin<T0>(arg0, arg3, arg1.agent, arg1.amount, arg1.memo, arg4, arg5);
        settle<T0>(arg1, arg2, 0x2::coin::value<T0>(&v0), arg5);
        0x6a3002ffdc45f107f6bd4079671283b4af28192cbdf2b90eb0dd3dab3f5569f1::pool::credit_earning<T0>(arg2, arg1.agent, 0x2::coin::into_balance<T0>(v0), 0x2::tx_context::sender(arg5));
    }

    public fun pay_from_same_pool<T0>(arg0: &0x6a3002ffdc45f107f6bd4079671283b4af28192cbdf2b90eb0dd3dab3f5569f1::platform::Platform, arg1: &mut Invoice<T0>, arg2: &mut 0x6a3002ffdc45f107f6bd4079671283b4af28192cbdf2b90eb0dd3dab3f5569f1::pool::Pool<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x6a3002ffdc45f107f6bd4079671283b4af28192cbdf2b90eb0dd3dab3f5569f1::pool::spend_coin<T0>(arg0, arg2, arg1.agent, arg1.amount, arg1.memo, arg3, arg4);
        settle<T0>(arg1, arg2, 0x2::coin::value<T0>(&v0), arg4);
        0x6a3002ffdc45f107f6bd4079671283b4af28192cbdf2b90eb0dd3dab3f5569f1::pool::credit_earning<T0>(arg2, arg1.agent, 0x2::coin::into_balance<T0>(v0), 0x2::tx_context::sender(arg4));
    }

    fun settle<T0>(arg0: &mut Invoice<T0>, arg1: &0x6a3002ffdc45f107f6bd4079671283b4af28192cbdf2b90eb0dd3dab3f5569f1::pool::Pool<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 102);
        assert!(arg0.pool_id == 0x2::object::id<0x6a3002ffdc45f107f6bd4079671283b4af28192cbdf2b90eb0dd3dab3f5569f1::pool::Pool<T0>>(arg1), 104);
        assert!(arg2 == arg0.amount, 103);
        arg0.status = 1;
        arg0.payer = 0x1::option::some<address>(0x2::tx_context::sender(arg3));
        let v0 = InvoicePaid{
            invoice_id : 0x2::object::id<Invoice<T0>>(arg0),
            pool_id    : arg0.pool_id,
            agent      : arg0.agent,
            payer      : 0x2::tx_context::sender(arg3),
            amount     : arg2,
        };
        0x2::event::emit<InvoicePaid>(v0);
    }

    // decompiled from Move bytecode v7
}

