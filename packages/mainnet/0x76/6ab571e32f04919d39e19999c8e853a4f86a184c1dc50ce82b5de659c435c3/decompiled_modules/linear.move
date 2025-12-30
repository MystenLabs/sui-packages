module 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::linear {
    struct LINEAR has drop {
        dummy_field: bool,
    }

    struct LinearStream<phantom T0> has store, key {
        id: 0x2::object::UID,
        recipient: address,
        total_deposit: u64,
        balance: 0x2::balance::Balance<T0>,
        released: u64,
        start: u64,
        end: u64,
        cliff: 0x1::option::Option<u64>,
        cancelable: bool,
        is_canceled: bool,
    }

    public fun id<T0>(arg0: &LinearStream<T0>) : 0x2::object::ID {
        0x2::object::id<LinearStream<T0>>(arg0)
    }

    public fun claim<T0>(arg0: &mut LinearStream<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.recipient, 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::error::eunauthorized());
        assert!(!arg0.is_canceled, 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::error::ealready_canceled());
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.start, 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::error::estream_not_started());
        let v1 = get_claimable_amount<T0>(arg0, v0);
        assert!(v1 > 0, 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::error::enothing_to_claim());
        let v2 = 0x2::balance::value<T0>(&arg0.balance);
        let v3 = if (v1 > v2) {
            v2
        } else {
            v1
        };
        arg0.released = arg0.released + v3;
        0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::events::emit_tokens_claimed(0x2::object::id<LinearStream<T0>>(arg0), v3, arg0.recipient, arg0.released);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v3), arg2), arg0.recipient);
        if (arg0.released >= arg0.total_deposit) {
            0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::events::emit_stream_completed(0x2::object::id<LinearStream<T0>>(arg0), arg0.released, v0);
        };
    }

    public fun cancel<T0>(arg0: &mut LinearStream<T0>, arg1: 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::cancel_cap::CancelCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::cancel_cap::get_stream_id(&arg1) == 0x2::object::id<LinearStream<T0>>(arg0), 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::error::einvalid_cancel_cap());
        assert!(arg0.cancelable, 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::error::enot_cancelable());
        assert!(!arg0.is_canceled, 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::error::ealready_canceled());
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = get_vested_amount<T0>(arg0, v0);
        let v3 = 0x2::balance::value<T0>(&arg0.balance);
        let v4 = if (v2 > arg0.released) {
            v2 - arg0.released
        } else {
            0
        };
        let v5 = if (v4 > v3) {
            v3
        } else {
            v4
        };
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v5), arg3), arg0.recipient);
        };
        let v6 = 0x2::balance::value<T0>(&arg0.balance);
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v6), arg3), v1);
        };
        arg0.is_canceled = true;
        arg0.released = arg0.released + v5;
        0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::cancel_cap::destroy_cancel_cap(arg1);
        0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::events::emit_stream_canceled(0x2::object::id<LinearStream<T0>>(arg0), v1, arg0.recipient, v5, v6, v0);
    }

    public fun cancelable<T0>(arg0: &LinearStream<T0>) : bool {
        arg0.cancelable
    }

    public fun cliff<T0>(arg0: &LinearStream<T0>) : 0x1::option::Option<u64> {
        arg0.cliff
    }

    public fun end<T0>(arg0: &LinearStream<T0>) : u64 {
        arg0.end
    }

    public fun get_claimable_amount<T0>(arg0: &LinearStream<T0>, arg1: u64) : u64 {
        0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::math::calculate_claimable_amount(get_vested_amount<T0>(arg0, arg1), arg0.released)
    }

    public fun get_vested_amount<T0>(arg0: &LinearStream<T0>, arg1: u64) : u64 {
        if (0x1::option::is_some<u64>(&arg0.cliff)) {
            0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::math::calculate_vested_amount_with_cliff(arg0.total_deposit, arg0.start, *0x1::option::borrow<u64>(&arg0.cliff), arg0.end, arg1)
        } else {
            0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::math::calculate_vested_amount(arg0.total_deposit, arg0.start, arg0.end, arg1)
        }
    }

    fun init(arg0: LINEAR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<LINEAR>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun is_canceled<T0>(arg0: &LinearStream<T0>) : bool {
        arg0.is_canceled
    }

    public fun is_completed<T0>(arg0: &LinearStream<T0>) : bool {
        arg0.released >= arg0.total_deposit
    }

    public(friend) fun new_stream<T0>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: 0x1::option::Option<u64>, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : LinearStream<T0> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(arg3 > arg2, 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::error::einvalid_time_range());
        assert!(v0 > 0, 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::error::einvalid_amount());
        if (0x1::option::is_some<u64>(&arg4)) {
            let v1 = *0x1::option::borrow<u64>(&arg4);
            assert!(v1 >= arg2, 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::error::einvalid_cliff());
            assert!(v1 <= arg3, 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::error::einvalid_cliff());
        };
        LinearStream<T0>{
            id            : 0x2::object::new(arg6),
            recipient     : arg0,
            total_deposit : v0,
            balance       : 0x2::coin::into_balance<T0>(arg1),
            released      : 0,
            start         : arg2,
            end           : arg3,
            cliff         : arg4,
            cancelable    : arg5,
            is_canceled   : false,
        }
    }

    public fun recipient<T0>(arg0: &LinearStream<T0>) : address {
        arg0.recipient
    }

    public fun released<T0>(arg0: &LinearStream<T0>) : u64 {
        arg0.released
    }

    public fun remaining_balance<T0>(arg0: &LinearStream<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun start<T0>(arg0: &LinearStream<T0>) : u64 {
        arg0.start
    }

    public fun strategy_type() : u8 {
        1
    }

    public fun total_deposit<T0>(arg0: &LinearStream<T0>) : u64 {
        arg0.total_deposit
    }

    // decompiled from Move bytecode v6
}

