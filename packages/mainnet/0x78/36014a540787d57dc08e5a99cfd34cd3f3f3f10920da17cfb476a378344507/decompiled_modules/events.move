module 0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::events {
    struct PaymentCreated has copy, drop {
        payment_id: 0x2::object::ID,
        merchant: address,
        amount: u64,
        currency: 0x1::type_name::TypeName,
        description: 0x1::string::String,
        timestamp: u64,
    }

    struct PaymentCompleted has copy, drop {
        payment_id: 0x2::object::ID,
        merchant: address,
        payer: address,
        amount: u64,
        currency: 0x1::type_name::TypeName,
        fee_amount: u64,
        net_amount: u64,
        tx_hash: vector<u8>,
        timestamp: u64,
    }

    struct PaymentFailed has copy, drop {
        payment_id: 0x2::object::ID,
        merchant: address,
        payer: address,
        reason: 0x1::string::String,
        timestamp: u64,
    }

    struct PaymentCancelled has copy, drop {
        payment_id: 0x2::object::ID,
        reason: 0x1::string::String,
        timestamp: u64,
    }

    struct PaymentExpired has copy, drop {
        payment_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct MerchantRegistered has copy, drop {
        merchant_id: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
        timestamp: u64,
    }

    struct MerchantSettingsUpdated has copy, drop {
        merchant_id: 0x2::object::ID,
        updated_by: address,
        timestamp: u64,
    }

    struct MerchantStatusChanged has copy, drop {
        merchant_id: 0x2::object::ID,
        is_active: bool,
        changed_by: address,
        timestamp: u64,
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

    public fun emit_merchant_registered(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::string::String, arg3: u64) {
        let v0 = MerchantRegistered{
            merchant_id : arg0,
            owner       : arg1,
            name        : arg2,
            timestamp   : arg3,
        };
        0x2::event::emit<MerchantRegistered>(v0);
    }

    public fun emit_merchant_settings_updated(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = MerchantSettingsUpdated{
            merchant_id : arg0,
            updated_by  : arg1,
            timestamp   : arg2,
        };
        0x2::event::emit<MerchantSettingsUpdated>(v0);
    }

    public fun emit_merchant_status_changed(arg0: 0x2::object::ID, arg1: bool, arg2: address, arg3: u64) {
        let v0 = MerchantStatusChanged{
            merchant_id : arg0,
            is_active   : arg1,
            changed_by  : arg2,
            timestamp   : arg3,
        };
        0x2::event::emit<MerchantStatusChanged>(v0);
    }

    public fun emit_payment_cancelled(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64) {
        let v0 = PaymentCancelled{
            payment_id : arg0,
            reason     : arg1,
            timestamp  : arg2,
        };
        0x2::event::emit<PaymentCancelled>(v0);
    }

    public fun emit_payment_completed(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: 0x1::type_name::TypeName, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: u64) {
        let v0 = PaymentCompleted{
            payment_id : arg0,
            merchant   : arg1,
            payer      : arg2,
            amount     : arg3,
            currency   : arg4,
            fee_amount : arg5,
            net_amount : arg6,
            tx_hash    : arg7,
            timestamp  : arg8,
        };
        0x2::event::emit<PaymentCompleted>(v0);
    }

    public fun emit_payment_created(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: 0x1::type_name::TypeName, arg4: 0x1::string::String, arg5: u64) {
        let v0 = PaymentCreated{
            payment_id  : arg0,
            merchant    : arg1,
            amount      : arg2,
            currency    : arg3,
            description : arg4,
            timestamp   : arg5,
        };
        0x2::event::emit<PaymentCreated>(v0);
    }

    public fun emit_payment_expired(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = PaymentExpired{
            payment_id : arg0,
            timestamp  : arg1,
        };
        0x2::event::emit<PaymentExpired>(v0);
    }

    public fun emit_payment_failed(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: 0x1::string::String, arg4: u64) {
        let v0 = PaymentFailed{
            payment_id : arg0,
            merchant   : arg1,
            payer      : arg2,
            reason     : arg3,
            timestamp  : arg4,
        };
        0x2::event::emit<PaymentFailed>(v0);
    }

    public fun emit_refund_cancelled(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: 0x1::string::String, arg4: u64) {
        let v0 = RefundCancelled{
            refund_id  : arg0,
            payment_id : arg1,
            merchant   : arg2,
            reason     : arg3,
            timestamp  : arg4,
        };
        0x2::event::emit<RefundCancelled>(v0);
    }

    public fun emit_refund_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: address, arg4: u64, arg5: 0x1::type_name::TypeName, arg6: 0x1::string::String, arg7: u64) {
        let v0 = RefundCreated{
            refund_id  : arg0,
            payment_id : arg1,
            merchant   : arg2,
            payer      : arg3,
            amount     : arg4,
            currency   : arg5,
            reason     : arg6,
            timestamp  : arg7,
        };
        0x2::event::emit<RefundCreated>(v0);
    }

    public fun emit_refund_executed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64) {
        let v0 = RefundExecuted{
            refund_id  : arg0,
            payment_id : arg1,
            payer      : arg2,
            amount     : arg3,
            timestamp  : arg4,
        };
        0x2::event::emit<RefundExecuted>(v0);
    }

    // decompiled from Move bytecode v6
}

