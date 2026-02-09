module 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::intent {
    struct ExecutionIntent<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        creator: address,
        receive_amount: u64,
        escrow: 0x2::balance::Balance<T1>,
        max_pay_amount: u64,
        min_price: u64,
        max_price: u64,
        expiry_timestamp_ms: u64,
        status: u8,
    }

    public fun cancel<T0, T1>(arg0: &mut ExecutionIntent<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::not_creator());
        assert!(arg0.status == 0, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::intent_not_pending());
        arg0.status = 2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.escrow), arg1), arg0.creator);
        0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::events::emit_intent_cancelled(0x2::object::uid_to_inner(&arg0.id), arg0.creator, 0x2::balance::value<T1>(&arg0.escrow));
    }

    public fun create_price_bounded<T0, T1>(arg0: u64, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 > 0, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::zero_receive_amount());
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::zero_escrow_amount());
        assert!(arg4 > 0x2::clock::timestamp_ms(arg5), 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::expired_on_create_intent());
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = ExecutionIntent<T0, T1>{
            id                  : 0x2::object::new(arg6),
            creator             : v1,
            receive_amount      : arg0,
            escrow              : 0x2::coin::into_balance<T1>(arg1),
            max_pay_amount      : v0,
            min_price           : arg2,
            max_price           : arg3,
            expiry_timestamp_ms : arg4,
            status              : 0,
        };
        0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::events::emit_intent_submitted(0x2::object::uid_to_inner(&v2.id), v1, arg0, v0, v0, arg2, arg3, arg4);
        0x2::transfer::public_share_object<ExecutionIntent<T0, T1>>(v2);
    }

    public fun creator<T0, T1>(arg0: &ExecutionIntent<T0, T1>) : address {
        arg0.creator
    }

    public fun escrowed_amount<T0, T1>(arg0: &ExecutionIntent<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.escrow)
    }

    public fun execute_against_offer<T0, T1>(arg0: &mut ExecutionIntent<T0, T1>, arg1: &mut 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::offer::LiquidityOffer<T0, T1>, arg2: &0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::capability::ExecutorCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::intent_not_pending());
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.expiry_timestamp_ms, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::intent_expired());
        assert!(0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::offer::is_fillable<T0, T1>(arg1, arg3), 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::offer_not_fillable());
        let (v0, _) = 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::offer::price_bounds<T0, T1>(arg1);
        assert!(v0 >= arg0.min_price, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::price_mismatch());
        assert!(v0 <= arg0.max_price, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::price_mismatch());
        let v2 = arg0.receive_amount;
        assert!(0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::offer::remaining_amount<T0, T1>(arg1) >= v2, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::insufficient_liquidity());
        let v3 = 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::offer::calc_payment(v2, v0);
        assert!(0x2::balance::value<T1>(&arg0.escrow) >= v3, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::insufficient_escrowed());
        let (v4, v5) = if (v2 == 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::offer::remaining_amount<T0, T1>(arg1)) {
            0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::offer::fill_full<T0, T1>(arg1, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.escrow, v3), arg4), arg3, arg4)
        } else {
            0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::offer::fill_partial<T0, T1>(arg1, v2, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.escrow, v3), arg4), arg3, arg4)
        };
        let (v6, _, _, _, _) = 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::offer::unpack_receipt<T0, T1>(v4, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, arg0.creator);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v5, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::offer::maker<T0, T1>(arg1));
        arg0.status = 1;
        let v11 = 0x2::balance::value<T1>(&arg0.escrow);
        if (v11 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.escrow), arg4), arg0.creator);
        };
        0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::events::emit_intent_executed(0x2::object::uid_to_inner(&arg0.id), 0x2::tx_context::sender(arg4), 0x2::object::id<0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::offer::LiquidityOffer<T0, T1>>(arg1), v2, v3, v0, v11);
    }

    public fun expire_intent<T0, T1>(arg0: &mut ExecutionIntent<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.expiry_timestamp_ms, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::not_yet_expired_intent());
        assert!(arg0.status == 0, 0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::errors::intent_not_pending());
        arg0.status = 3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.escrow), arg2), arg0.creator);
        0xf53c071b6575ee2e5b1b19158acbbf21944aa6474d7b8e688365015295a7c0a7::events::emit_intent_expired(0x2::object::uid_to_inner(&arg0.id), arg0.creator, 0x2::balance::value<T1>(&arg0.escrow));
    }

    public fun intent_price_bounds<T0, T1>(arg0: &ExecutionIntent<T0, T1>) : (u64, u64) {
        (arg0.min_price, arg0.max_price)
    }

    public fun intent_status<T0, T1>(arg0: &ExecutionIntent<T0, T1>) : u8 {
        arg0.status
    }

    public fun max_pay_amount<T0, T1>(arg0: &ExecutionIntent<T0, T1>) : u64 {
        arg0.max_pay_amount
    }

    public fun receive_amount<T0, T1>(arg0: &ExecutionIntent<T0, T1>) : u64 {
        arg0.receive_amount
    }

    public fun status_cancelled() : u8 {
        2
    }

    public fun status_executed() : u8 {
        1
    }

    public fun status_expired() : u8 {
        3
    }

    public fun status_pending() : u8 {
        0
    }

    // decompiled from Move bytecode v6
}

