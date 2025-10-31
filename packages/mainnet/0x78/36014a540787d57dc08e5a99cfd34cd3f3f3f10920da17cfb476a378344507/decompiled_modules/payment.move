module 0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::payment {
    struct Payment has store, key {
        id: 0x2::object::UID,
        merchant: address,
        payer: 0x1::option::Option<address>,
        amount: u64,
        currency: 0x1::type_name::TypeName,
        created_at: u64,
        completed_at: 0x1::option::Option<u64>,
        expires_at: u64,
        status: u8,
        metadata: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        description: 0x1::string::String,
        refundable: bool,
        refund_window: u64,
    }

    struct PaymentConfig has store {
        default_expiry: u64,
        min_amount: u64,
        max_amount: u64,
        enabled: bool,
    }

    fun calculate_fee(arg0: u64) : u64 {
        (((arg0 as u128) * (30 as u128) / 10000) as u64)
    }

    fun calculate_fee_with_bps(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    public entry fun cancel_payment(arg0: &mut Payment, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.merchant, 1);
        assert!(arg0.status == 0, 103);
        arg0.status = 4;
        0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::events::emit_payment_cancelled(0x2::object::uid_to_inner(&arg0.id), arg1, 0x2::tx_context::epoch_timestamp_ms(arg2));
    }

    public fun create_payment(arg0: address, arg1: u64, arg2: 0x1::type_name::TypeName, arg3: 0x1::string::String, arg4: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : Payment {
        assert!(arg0 != @0x0, 106);
        assert!(arg1 > 0, 100);
        assert!(arg1 <= 1000000000000, 108);
        assert!(0x1::string::length(&arg3) <= 500, 109);
        assert!(0x2::vec_map::length<0x1::string::String, 0x1::string::String>(&arg4) <= 10, 110);
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg6);
        let v1 = if (arg5 == 0) {
            v0 + 3600000
        } else {
            assert!(arg5 <= 31536000, 107);
            let v2 = arg5 * 1000;
            assert!(v2 / 1000 == arg5, 107);
            assert!(v0 + v2 > v0, 107);
            v0 + v2
        };
        let v3 = 0x2::object::new(arg6);
        let v4 = Payment{
            id            : v3,
            merchant      : arg0,
            payer         : 0x1::option::none<address>(),
            amount        : arg1,
            currency      : arg2,
            created_at    : v0,
            completed_at  : 0x1::option::none<u64>(),
            expires_at    : v1,
            status        : 0,
            metadata      : arg4,
            description   : arg3,
            refundable    : true,
            refund_window : 604800000,
        };
        0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::events::emit_payment_created(0x2::object::uid_to_inner(&v3), arg0, arg1, arg2, arg3, v0);
        v4
    }

    public fun create_payment_with_merchant(arg0: &0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::Merchant, arg1: u64, arg2: 0x1::type_name::TypeName, arg3: 0x1::string::String, arg4: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : Payment {
        assert!(0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::is_merchant_active(arg0), 111);
        create_payment(0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::get_owner(arg0), arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public entry fun execute_payment<T0>(arg0: &mut Payment, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg2);
        if (v0 > arg0.expires_at && arg0.status == 0) {
            arg0.status = 3;
        };
        assert!(arg0.status == 0, 101);
        assert!(0x2::coin::value<T0>(&arg1) == arg0.amount, 104);
        assert!(0x1::type_name::with_original_ids<T0>() == arg0.currency, 105);
        let v2 = calculate_fee(arg0.amount);
        arg0.payer = 0x1::option::some<address>(v1);
        arg0.status = 1;
        arg0.completed_at = 0x1::option::some<u64>(v0);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v2, arg2), arg0.merchant);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.merchant);
        0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::events::emit_payment_completed(0x2::object::uid_to_inner(&arg0.id), arg0.merchant, v1, arg0.amount, arg0.currency, v2, arg0.amount - v2, 0x1::vector::empty<u8>(), v0);
    }

    public entry fun execute_payment_with_merchant<T0>(arg0: &mut Payment, arg1: &0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::Merchant, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::get_owner(arg1);
        assert!(v2 == arg0.merchant, 112);
        assert!(0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::is_merchant_active(arg1), 111);
        if (v0 > arg0.expires_at && arg0.status == 0) {
            arg0.status = 3;
        };
        assert!(arg0.status == 0, 101);
        assert!(0x2::coin::value<T0>(&arg2) == arg0.amount, 104);
        assert!(0x1::type_name::with_original_ids<T0>() == arg0.currency, 105);
        let v3 = calculate_fee_with_bps(arg0.amount, 0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::get_platform_fee_bps(arg1));
        arg0.payer = 0x1::option::some<address>(v1);
        arg0.status = 1;
        arg0.completed_at = 0x1::option::some<u64>(v0);
        let v4 = if (0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::is_currency_supported<T0>(arg1)) {
            0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::get_receiving_address<T0>(arg1)
        } else {
            v2
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v3, arg3), v4);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v4);
        0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::events::emit_payment_completed(0x2::object::uid_to_inner(&arg0.id), arg0.merchant, v1, arg0.amount, arg0.currency, v3, arg0.amount - v3, 0x1::vector::empty<u8>(), v0);
    }

    public fun get_amount(arg0: &Payment) : u64 {
        arg0.amount
    }

    public fun get_created_at(arg0: &Payment) : u64 {
        arg0.created_at
    }

    public fun get_currency(arg0: &Payment) : 0x1::type_name::TypeName {
        arg0.currency
    }

    public fun get_description(arg0: &Payment) : 0x1::string::String {
        arg0.description
    }

    public fun get_expires_at(arg0: &Payment) : u64 {
        arg0.expires_at
    }

    public fun get_id(arg0: &Payment) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_merchant(arg0: &Payment) : address {
        arg0.merchant
    }

    public fun get_metadata(arg0: &Payment) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.metadata
    }

    public fun get_payer(arg0: &Payment) : 0x1::option::Option<address> {
        arg0.payer
    }

    public fun get_status(arg0: &Payment) : u8 {
        arg0.status
    }

    public fun is_expired(arg0: &Payment, arg1: &0x2::tx_context::TxContext) : bool {
        0x2::tx_context::epoch_timestamp_ms(arg1) > arg0.expires_at
    }

    public fun is_refundable(arg0: &Payment) : bool {
        arg0.refundable
    }

    // decompiled from Move bytecode v6
}

