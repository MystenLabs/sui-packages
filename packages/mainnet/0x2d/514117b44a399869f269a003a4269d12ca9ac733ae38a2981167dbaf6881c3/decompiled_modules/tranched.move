module 0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::tranched {
    struct TRANCHED has drop {
        dummy_field: bool,
    }

    struct TranchedStream<phantom T0> has store, key {
        id: 0x2::object::UID,
        recipient: address,
        total_deposit: u64,
        balance: 0x2::balance::Balance<T0>,
        released: u64,
        tranches: vector<0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::types::Tranche>,
        cancelable: bool,
        is_canceled: bool,
    }

    public fun id<T0>(arg0: &TranchedStream<T0>) : 0x2::object::ID {
        0x2::object::id<TranchedStream<T0>>(arg0)
    }

    public fun claim<T0>(arg0: &mut TranchedStream<T0>, arg1: &0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::global_config::GlobalConfig, arg2: &0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::version::VersionRegistry, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.recipient, 0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::error::eunauthorized());
        assert!(!arg0.is_canceled, 0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::error::ealready_canceled());
        0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::version::check_version(arg2);
        let v0 = 0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::global_config::get_claim_fee(arg1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v0, 0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::error::einsufficient_claim_fee());
        let v1 = 0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::global_config::get_fee_recipient(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v0, arg5), v1);
        if (0x2::coin::value<0x2::sui::SUI>(&arg4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg4);
        };
        0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::events::emit_fee_collected(v0, v1, 0x1::option::some<0x2::object::ID>(0x2::object::id<TranchedStream<T0>>(arg0)));
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = get_claimable_amount<T0>(arg0, v2);
        assert!(v3 > 0, 0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::error::enothing_to_claim());
        let v4 = 0x2::balance::value<T0>(&arg0.balance);
        let v5 = if (v3 > v4) {
            v4
        } else {
            v3
        };
        assert!(v5 <= 18446744073709551615 - arg0.released, 0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::error::eoverflow());
        arg0.released = arg0.released + v5;
        0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::events::emit_tokens_claimed(0x2::object::id<TranchedStream<T0>>(arg0), v5, arg0.recipient, arg0.released);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v5), arg5), arg0.recipient);
        if (arg0.released >= arg0.total_deposit) {
            0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::events::emit_stream_completed(0x2::object::id<TranchedStream<T0>>(arg0), arg0.released, v2);
        };
    }

    public fun cancel<T0>(arg0: &mut TranchedStream<T0>, arg1: 0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::cancel_cap::CancelCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::cancel_cap::get_stream_id(&arg1) == 0x2::object::id<TranchedStream<T0>>(arg0), 0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::error::einvalid_cancel_cap());
        assert!(arg0.cancelable, 0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::error::enot_cancelable());
        assert!(!arg0.is_canceled, 0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::error::ealready_canceled());
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = get_vested_amount<T0>(arg0, v0);
        let v3 = if (v2 > arg0.released) {
            v2 - arg0.released
        } else {
            0
        };
        let v4 = 0x2::balance::value<T0>(&arg0.balance);
        let v5 = if (v3 > v4) {
            v4
        } else {
            v3
        };
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v5), arg3), arg0.recipient);
        };
        let v6 = 0x2::balance::value<T0>(&arg0.balance);
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v6), arg3), v1);
        };
        arg0.is_canceled = true;
        assert!(v5 <= 18446744073709551615 - arg0.released, 0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::error::eoverflow());
        arg0.released = arg0.released + v5;
        0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::cancel_cap::destroy_cancel_cap(arg1);
        0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::events::emit_stream_canceled(0x2::object::id<TranchedStream<T0>>(arg0), v1, arg0.recipient, v5, v6, v0);
    }

    public fun cancelable<T0>(arg0: &TranchedStream<T0>) : bool {
        arg0.cancelable
    }

    public fun get_claimable_amount<T0>(arg0: &TranchedStream<T0>, arg1: u64) : u64 {
        0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::math::calculate_claimable_amount(get_vested_amount<T0>(arg0, arg1), arg0.released)
    }

    public fun get_vested_amount<T0>(arg0: &TranchedStream<T0>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::types::Tranche>(&arg0.tranches)) {
            let v2 = 0x1::vector::borrow<0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::types::Tranche>(&arg0.tranches, v1);
            if (arg1 >= 0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::types::tranche_timestamp(v2)) {
                v0 = v0 + 0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::types::tranche_amount(v2);
                v1 = v1 + 1;
            } else {
                break
            };
        };
        if (v0 > arg0.total_deposit) {
            arg0.total_deposit
        } else {
            v0
        }
    }

    fun init(arg0: TRANCHED, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<TRANCHED>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun is_canceled<T0>(arg0: &TranchedStream<T0>) : bool {
        arg0.is_canceled
    }

    public fun is_completed<T0>(arg0: &TranchedStream<T0>) : bool {
        arg0.released >= arg0.total_deposit
    }

    public(friend) fun new_stream<T0>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: vector<0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::types::Tranche>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : TranchedStream<T0> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::error::einvalid_amount());
        assert!(!0x1::vector::is_empty<0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::types::Tranche>(&arg2), 0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::error::eempty_tranches());
        let v1 = 0;
        let v2 = 0;
        while (v1 < 0x1::vector::length<0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::types::Tranche>(&arg2)) {
            let v3 = 0x1::vector::borrow<0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::types::Tranche>(&arg2, v1);
            assert!(0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::types::tranche_timestamp(v3) >= 0, 0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::error::etimestamps_not_sorted());
            v2 = v2 + (0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::types::tranche_amount(v3) as u128);
            v1 = v1 + 1;
        };
        assert!(v2 > 0, 0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::error::einvalid_amount());
        assert!(v2 <= 18446744073709551615, 0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::error::eoverflow());
        let v4 = (v2 as u64);
        assert!(v4 <= v0, 0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::error::etotal_amount_mismatch());
        let v5 = v0 - v4;
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v5, arg4), 0x2::tx_context::sender(arg4));
        };
        TranchedStream<T0>{
            id            : 0x2::object::new(arg4),
            recipient     : arg0,
            total_deposit : v4,
            balance       : 0x2::coin::into_balance<T0>(arg1),
            released      : 0,
            tranches      : arg2,
            cancelable    : arg3,
            is_canceled   : false,
        }
    }

    public fun recipient<T0>(arg0: &TranchedStream<T0>) : address {
        arg0.recipient
    }

    public fun released<T0>(arg0: &TranchedStream<T0>) : u64 {
        arg0.released
    }

    public fun remaining_balance<T0>(arg0: &TranchedStream<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun strategy_type() : u8 {
        2
    }

    public fun total_deposit<T0>(arg0: &TranchedStream<T0>) : u64 {
        arg0.total_deposit
    }

    public fun tranches<T0>(arg0: &TranchedStream<T0>) : &vector<0x2d514117b44a399869f269a003a4269d12ca9ac733ae38a2981167dbaf6881c3::types::Tranche> {
        &arg0.tranches
    }

    // decompiled from Move bytecode v6
}

