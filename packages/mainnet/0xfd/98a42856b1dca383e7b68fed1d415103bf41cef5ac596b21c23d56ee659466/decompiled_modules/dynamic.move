module 0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::dynamic {
    struct DYNAMIC has drop {
        dummy_field: bool,
    }

    struct DynamicStream<phantom T0> has store, key {
        id: 0x2::object::UID,
        recipient: address,
        total_deposit: u64,
        balance: 0x2::balance::Balance<T0>,
        released: u64,
        start_time: u64,
        segments: vector<0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::types::Segment>,
        cancelable: bool,
        is_canceled: bool,
    }

    public fun id<T0>(arg0: &DynamicStream<T0>) : 0x2::object::ID {
        0x2::object::id<DynamicStream<T0>>(arg0)
    }

    public fun claim<T0>(arg0: &mut DynamicStream<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.recipient, 0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::error::eunauthorized());
        assert!(!arg0.is_canceled, 0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::error::ealready_canceled());
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = get_claimable_amount<T0>(arg0, v0);
        assert!(v1 > 0, 0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::error::enothing_to_claim());
        let v2 = 0x2::balance::value<T0>(&arg0.balance);
        let v3 = if (v1 > v2) {
            v2
        } else {
            v1
        };
        arg0.released = arg0.released + v3;
        0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::events::emit_tokens_claimed(0x2::object::id<DynamicStream<T0>>(arg0), v3, arg0.recipient, arg0.released);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v3), arg2), arg0.recipient);
        if (arg0.released >= arg0.total_deposit) {
            0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::events::emit_stream_completed(0x2::object::id<DynamicStream<T0>>(arg0), arg0.released, v0);
        };
    }

    public fun cancel<T0>(arg0: &mut DynamicStream<T0>, arg1: 0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::cancel_cap::CancelCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::cancel_cap::get_stream_id(&arg1) == 0x2::object::id<DynamicStream<T0>>(arg0), 0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::error::einvalid_cancel_cap());
        assert!(arg0.cancelable, 0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::error::enot_cancelable());
        assert!(!arg0.is_canceled, 0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::error::ealready_canceled());
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
        arg0.released = arg0.released + v5;
        0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::cancel_cap::destroy_cancel_cap(arg1);
        0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::events::emit_stream_canceled(0x2::object::id<DynamicStream<T0>>(arg0), v1, arg0.recipient, v5, v6, v0);
    }

    public fun cancelable<T0>(arg0: &DynamicStream<T0>) : bool {
        arg0.cancelable
    }

    public fun get_claimable_amount<T0>(arg0: &DynamicStream<T0>, arg1: u64) : u64 {
        0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::math::calculate_claimable_amount(get_vested_amount<T0>(arg0, arg1), arg0.released)
    }

    public fun get_vested_amount<T0>(arg0: &DynamicStream<T0>, arg1: u64) : u64 {
        if (arg1 < arg0.start_time) {
            return 0
        };
        let v0 = 0;
        let v1 = arg0.start_time;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::types::Segment>(&arg0.segments)) {
            let v3 = 0x1::vector::borrow<0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::types::Segment>(&arg0.segments, v2);
            let v4 = 0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::types::segment_timestamp(v3);
            let v5 = 0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::types::segment_amount(v3);
            if (arg1 >= v4) {
                v0 = v0 + v5;
                v1 = v4;
                v2 = v2 + 1;
                continue
            };
            let v6 = v4 - v1;
            if (v6 == 0) {
                break
            } else {
                v0 = v0 + 0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::math_fixed::mul_div_down(0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::math_fixed::pow(0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::math_fixed::div_down(arg1 - v1, v6), 0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::types::segment_exponent(v3)), v5);
                break
            };
        };
        if (v0 > arg0.total_deposit) {
            arg0.total_deposit
        } else {
            v0
        }
    }

    fun init(arg0: DYNAMIC, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<DYNAMIC>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun is_canceled<T0>(arg0: &DynamicStream<T0>) : bool {
        arg0.is_canceled
    }

    public fun is_completed<T0>(arg0: &DynamicStream<T0>) : bool {
        arg0.released >= arg0.total_deposit
    }

    public(friend) fun new_stream<T0>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: vector<0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::types::Segment>, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : DynamicStream<T0> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::error::einvalid_amount());
        assert!(!0x1::vector::is_empty<0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::types::Segment>(&arg3), 0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::error::eempty_tranches());
        let v1 = 0;
        let v2 = 0;
        while (v1 < 0x1::vector::length<0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::types::Segment>(&arg3)) {
            let v3 = 0x1::vector::borrow<0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::types::Segment>(&arg3, v1);
            assert!(0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::types::segment_timestamp(v3) > arg2, 0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::error::etimestamps_not_sorted());
            assert!(0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::types::segment_exponent(v3) % 0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::math_fixed::wad() == 0, 0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::error::eodd_exponent());
            v2 = v2 + (0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::types::segment_amount(v3) as u128);
            v1 = v1 + 1;
        };
        assert!(v2 > 0, 0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::error::einvalid_amount());
        let v4 = (v2 as u64);
        assert!(v4 <= v0, 0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::error::etotal_amount_mismatch());
        let v5 = v0 - v4;
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v5, arg5), 0x2::tx_context::sender(arg5));
        };
        DynamicStream<T0>{
            id            : 0x2::object::new(arg5),
            recipient     : arg0,
            total_deposit : v4,
            balance       : 0x2::coin::into_balance<T0>(arg1),
            released      : 0,
            start_time    : arg2,
            segments      : arg3,
            cancelable    : arg4,
            is_canceled   : false,
        }
    }

    public fun recipient<T0>(arg0: &DynamicStream<T0>) : address {
        arg0.recipient
    }

    public fun released<T0>(arg0: &DynamicStream<T0>) : u64 {
        arg0.released
    }

    public fun remaining_balance<T0>(arg0: &DynamicStream<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun segments<T0>(arg0: &DynamicStream<T0>) : &vector<0xfd98a42856b1dca383e7b68fed1d415103bf41cef5ac596b21c23d56ee659466::types::Segment> {
        &arg0.segments
    }

    public fun start_time<T0>(arg0: &DynamicStream<T0>) : u64 {
        arg0.start_time
    }

    public fun strategy_type() : u8 {
        3
    }

    public fun total_deposit<T0>(arg0: &DynamicStream<T0>) : u64 {
        arg0.total_deposit
    }

    // decompiled from Move bytecode v6
}

