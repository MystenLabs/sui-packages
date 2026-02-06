module 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::invoice {
    struct Invoice<phantom T0> has store, key {
        id: 0x2::object::UID,
        payee: address,
        payer: 0x1::option::Option<address>,
        amount: u64,
        status: u8,
        expires_at: u64,
        escrow: 0x2::balance::Balance<T0>,
        release_conditions: vector<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::ReleaseCondition>,
        metadata: vector<u8>,
        created_at: u64,
    }

    public fun add_release_condition<T0>(arg0: &mut Invoice<T0>, arg1: 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::ReleaseCondition, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.payee, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::not_payee());
        assert!(0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_invoice_pending(arg0.status), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invoice_not_pending());
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_release_condition_added(0x2::object::id<Invoice<T0>>(arg0), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::condition_type(&arg1), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::condition_value(&arg1));
        0x1::vector::push_back<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::ReleaseCondition>(&mut arg0.release_conditions, arg1);
    }

    public fun all_conditions_met<T0>(arg0: &Invoice<T0>) : bool {
        let v0 = 0x1::vector::length<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::ReleaseCondition>(&arg0.release_conditions);
        if (v0 == 0) {
            return true
        };
        let v1 = 0;
        while (v1 < v0) {
            if (!0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_condition_met(0x1::vector::borrow<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::ReleaseCondition>(&arg0.release_conditions, v1))) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun amount<T0>(arg0: &Invoice<T0>) : u64 {
        arg0.amount
    }

    public fun cancel<T0>(arg0: &mut Invoice<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.payee, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::not_payee());
        assert!(0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_invoice_pending(arg0.status), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invoice_not_pending());
        assert!(0x2::balance::value<T0>(&arg0.escrow) == 0, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::cannot_cancel_with_escrow());
        arg0.status = 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::invoice_status_cancelled();
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_invoice_cancelled(0x2::object::id<Invoice<T0>>(arg0), 0x2::tx_context::sender(arg1), 0x2::tx_context::epoch_timestamp_ms(arg1));
    }

    public fun cancel_expired<T0>(arg0: &mut Invoice<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg1);
        assert!(v0 >= arg0.expires_at, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_timestamp());
        assert!(0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_invoice_pending(arg0.status) || 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_invoice_paid(arg0.status), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_status());
        let v1 = 0x2::balance::value<T0>(&arg0.escrow);
        if (v1 > 0) {
            arg0.status = 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::invoice_status_refunded();
            if (0x1::option::is_some<address>(&arg0.payer)) {
                0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_invoice_refunded(0x2::object::id<Invoice<T0>>(arg0), *0x1::option::borrow<address>(&arg0.payer), v1, v0);
            };
            0x1::option::some<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.escrow), arg1))
        } else {
            arg0.status = 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::invoice_status_cancelled();
            0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_invoice_cancelled(0x2::object::id<Invoice<T0>>(arg0), 0x2::tx_context::sender(arg1), v0);
            0x1::option::none<0x2::coin::Coin<T0>>()
        }
    }

    entry fun create_and_share<T0>(arg0: address, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Invoice<T0>>(create_invoice<T0>(arg0, arg1, arg2, arg3, arg4));
    }

    entry fun create_directed_and_share<T0>(arg0: address, arg1: address, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Invoice<T0>>(create_directed_invoice<T0>(arg0, arg1, arg2, arg3, arg4, arg5));
    }

    public fun create_directed_invoice<T0>(arg0: address, arg1: address, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : Invoice<T0> {
        assert!(arg2 > 0, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_amount());
        assert!(arg3 > 0x2::tx_context::epoch_timestamp_ms(arg5), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_timestamp());
        let v0 = Invoice<T0>{
            id                 : 0x2::object::new(arg5),
            payee              : arg0,
            payer              : 0x1::option::some<address>(arg1),
            amount             : arg2,
            status             : 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::invoice_status_pending(),
            expires_at         : arg3,
            escrow             : 0x2::balance::zero<T0>(),
            release_conditions : 0x1::vector::empty<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::ReleaseCondition>(),
            metadata           : arg4,
            created_at         : 0x2::tx_context::epoch_timestamp_ms(arg5),
        };
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_invoice_created(0x2::object::id<Invoice<T0>>(&v0), arg0, 0x1::option::some<address>(arg1), arg2, arg3, 0x2::tx_context::epoch_timestamp_ms(arg5));
        v0
    }

    public fun create_invoice<T0>(arg0: address, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : Invoice<T0> {
        assert!(arg1 > 0, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_amount());
        assert!(arg2 > 0x2::tx_context::epoch_timestamp_ms(arg4), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_timestamp());
        let v0 = Invoice<T0>{
            id                 : 0x2::object::new(arg4),
            payee              : arg0,
            payer              : 0x1::option::none<address>(),
            amount             : arg1,
            status             : 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::invoice_status_pending(),
            expires_at         : arg2,
            escrow             : 0x2::balance::zero<T0>(),
            release_conditions : 0x1::vector::empty<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::ReleaseCondition>(),
            metadata           : arg3,
            created_at         : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_invoice_created(0x2::object::id<Invoice<T0>>(&v0), arg0, 0x1::option::none<address>(), arg1, arg2, 0x2::tx_context::epoch_timestamp_ms(arg4));
        v0
    }

    public fun created_at<T0>(arg0: &Invoice<T0>) : u64 {
        arg0.created_at
    }

    public fun destroy<T0>(arg0: Invoice<T0>) {
        let Invoice {
            id                 : v0,
            payee              : _,
            payer              : _,
            amount             : _,
            status             : v4,
            expires_at         : _,
            escrow             : v6,
            release_conditions : _,
            metadata           : _,
            created_at         : _,
        } = arg0;
        let v10 = v6;
        assert!(0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_invoice_terminal(v4), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_status());
        assert!(0x2::balance::value<T0>(&v10) == 0, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::cannot_cancel_with_escrow());
        0x2::balance::destroy_zero<T0>(v10);
        0x2::object::delete(v0);
    }

    public fun dispute<T0>(arg0: &mut Invoice<T0>, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.payee || 0x1::option::is_some<address>(&arg0.payer) && v0 == *0x1::option::borrow<address>(&arg0.payer), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::not_authorized());
        assert!(0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_invoice_paid(arg0.status), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invoice_not_paid());
        arg0.status = 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::invoice_status_disputed();
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_invoice_disputed(0x2::object::id<Invoice<T0>>(arg0), v0, arg1, 0x2::tx_context::epoch_timestamp_ms(arg2));
    }

    public fun escrow_balance<T0>(arg0: &Invoice<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.escrow)
    }

    public fun expires_at<T0>(arg0: &Invoice<T0>) : u64 {
        arg0.expires_at
    }

    public fun fulfill_oracle_condition<T0>(arg0: &mut Invoice<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_invoice_paid(arg0.status), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invoice_not_paid());
        assert!(arg1 < 0x1::vector::length<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::ReleaseCondition>(&arg0.release_conditions), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::not_found());
        let v0 = 0x1::vector::borrow_mut<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::ReleaseCondition>(&mut arg0.release_conditions, arg1);
        assert!(0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::condition_type(v0) == 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::release_condition_oracle(), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_status());
        let v1 = 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::condition_required_address(v0);
        assert!(0x1::option::is_some<address>(&v1), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::not_found());
        assert!(0x2::tx_context::sender(arg2) == *0x1::option::borrow<address>(&v1), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::not_authorized());
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::mark_condition_met(v0);
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_release_condition_met(0x2::object::id<Invoice<T0>>(arg0), arg1, 0x2::tx_context::epoch_timestamp_ms(arg2));
    }

    public fun fulfill_signature_condition<T0>(arg0: &mut Invoice<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_invoice_paid(arg0.status), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invoice_not_paid());
        assert!(arg1 < 0x1::vector::length<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::ReleaseCondition>(&arg0.release_conditions), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::not_found());
        let v0 = 0x1::vector::borrow_mut<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::ReleaseCondition>(&mut arg0.release_conditions, arg1);
        assert!(0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::condition_type(v0) == 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::release_condition_signature(), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invalid_status());
        let v1 = 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::condition_required_address(v0);
        assert!(0x1::option::is_some<address>(&v1), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::not_found());
        assert!(0x2::tx_context::sender(arg2) == *0x1::option::borrow<address>(&v1), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::not_authorized());
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::mark_condition_met(v0);
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_release_condition_met(0x2::object::id<Invoice<T0>>(arg0), arg1, 0x2::tx_context::epoch_timestamp_ms(arg2));
    }

    public fun fulfill_time_condition<T0>(arg0: &mut Invoice<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_invoice_paid(arg0.status), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invoice_not_paid());
        assert!(arg1 < 0x1::vector::length<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::ReleaseCondition>(&arg0.release_conditions), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::not_found());
        let v0 = 0x1::vector::borrow_mut<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::ReleaseCondition>(&mut arg0.release_conditions, arg1);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        assert!(0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::check_time_condition(v0, v1), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::release_conditions_not_met());
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::mark_condition_met(v0);
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_release_condition_met(0x2::object::id<Invoice<T0>>(arg0), arg1, v1);
    }

    public fun is_expired<T0>(arg0: &Invoice<T0>, arg1: u64) : bool {
        arg1 >= arg0.expires_at
    }

    public fun is_paid<T0>(arg0: &Invoice<T0>) : bool {
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_invoice_paid(arg0.status)
    }

    public fun is_pending<T0>(arg0: &Invoice<T0>) : bool {
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_invoice_pending(arg0.status)
    }

    public fun metadata<T0>(arg0: &Invoice<T0>) : vector<u8> {
        arg0.metadata
    }

    entry fun pay<T0>(arg0: &mut Invoice<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        pay_invoice<T0>(arg0, arg1, arg2);
    }

    public fun pay_invoice<T0>(arg0: &mut Invoice<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        assert!(0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_invoice_pending(arg0.status), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invoice_not_pending());
        assert!(v1 < arg0.expires_at, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invoice_expired());
        if (0x1::option::is_some<address>(&arg0.payer)) {
            assert!(v0 == *0x1::option::borrow<address>(&arg0.payer), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::not_payer());
        };
        assert!(0x2::coin::value<T0>(&arg1) >= arg0.amount, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::insufficient_funds());
        0x2::balance::join<T0>(&mut arg0.escrow, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, arg0.amount, arg2)));
        if (0x2::coin::value<T0>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<T0>(arg1);
        };
        arg0.status = 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::invoice_status_paid();
        if (0x1::option::is_none<address>(&arg0.payer)) {
            arg0.payer = 0x1::option::some<address>(v0);
        };
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_invoice_paid(0x2::object::id<Invoice<T0>>(arg0), v0, arg0.amount, v1);
    }

    public fun payee<T0>(arg0: &Invoice<T0>) : address {
        arg0.payee
    }

    public fun payer<T0>(arg0: &Invoice<T0>) : 0x1::option::Option<address> {
        arg0.payer
    }

    public fun release<T0>(arg0: &mut Invoice<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.payee || 0x1::option::is_some<address>(&arg0.payer) && v0 == *0x1::option::borrow<address>(&arg0.payer), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::not_authorized());
        assert!(0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_invoice_paid(arg0.status), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invoice_not_paid());
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::ReleaseCondition>(&arg0.release_conditions)) {
            assert!(0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_condition_met(0x1::vector::borrow<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::ReleaseCondition>(&arg0.release_conditions, v1)), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::release_conditions_not_met());
            v1 = v1 + 1;
        };
        arg0.status = 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::invoice_status_released();
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_invoice_released(0x2::object::id<Invoice<T0>>(arg0), arg0.payee, 0x2::balance::value<T0>(&arg0.escrow), 0x2::tx_context::epoch_timestamp_ms(arg1));
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.escrow), arg1)
    }

    public fun release_conditions<T0>(arg0: &Invoice<T0>) : &vector<0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::ReleaseCondition> {
        &arg0.release_conditions
    }

    entry fun release_to_payee<T0>(arg0: &mut Invoice<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = release<T0>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg0.payee);
    }

    public fun resolve_refund<T0>(arg0: &mut Invoice<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x1::option::is_some<address>(&arg0.payer), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::not_payer());
        assert!(0x2::tx_context::sender(arg1) == *0x1::option::borrow<address>(&arg0.payer), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::not_payer());
        assert!(0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_invoice_disputed(arg0.status), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invoice_not_disputed());
        arg0.status = 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::invoice_status_refunded();
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_invoice_refunded(0x2::object::id<Invoice<T0>>(arg0), *0x1::option::borrow<address>(&arg0.payer), 0x2::balance::value<T0>(&arg0.escrow), 0x2::tx_context::epoch_timestamp_ms(arg1));
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.escrow), arg1)
    }

    public fun resolve_release<T0>(arg0: &mut Invoice<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg1) == arg0.payee, 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::not_payee());
        assert!(0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::is_invoice_disputed(arg0.status), 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::errors::invoice_not_disputed());
        arg0.status = 0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::types::invoice_status_released();
        0xd713ac3a77a342cde2a0f9c3b5ba5143588a8d1da75d4d732094b9a715e5d566::events::emit_invoice_released(0x2::object::id<Invoice<T0>>(arg0), arg0.payee, 0x2::balance::value<T0>(&arg0.escrow), 0x2::tx_context::epoch_timestamp_ms(arg1));
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.escrow), arg1)
    }

    public fun status<T0>(arg0: &Invoice<T0>) : u8 {
        arg0.status
    }

    // decompiled from Move bytecode v6
}

