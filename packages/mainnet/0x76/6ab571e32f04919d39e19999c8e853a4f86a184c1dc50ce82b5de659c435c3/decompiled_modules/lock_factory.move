module 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::lock_factory {
    struct LockFactory has key {
        id: 0x2::object::UID,
        fee_rate: u64,
        fee_recipient: address,
        lock_fee: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun calculate_fee(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public fun create_dynamic_stream<T0>(arg0: &mut LockFactory, arg1: &0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::version::VersionRegistry, arg2: 0x2::coin::Coin<T0>, arg3: address, arg4: u64, arg5: vector<0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::types::Segment>, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::version::check_version(arg1);
        assert!(0x1::vector::length<0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::types::Segment>(&arg5) <= 100, 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::error::etoo_many_segments());
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::error::einvalid_amount());
        let v1 = calculate_fee(v0, arg0.fee_rate);
        let (v2, arg2) = if (v1 > 0) {
            (0x2::coin::split<T0>(&mut arg2, v1, arg7), arg2)
        } else {
            (0x2::coin::zero<T0>(arg7), arg2)
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, arg0.fee_recipient);
            0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::events::emit_fee_collected(v1, arg0.fee_recipient, 0x1::option::none<0x2::object::ID>());
        } else {
            0x2::coin::destroy_zero<T0>(v2);
        };
        let v3 = 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::dynamic::new_stream<T0>(arg3, arg2, arg4, arg5, arg6, arg7);
        let v4 = 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::dynamic::id<T0>(&v3);
        let v5 = 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::dynamic::segments<T0>(&v3);
        0x2::transfer::public_share_object<0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::dynamic::DynamicStream<T0>>(v3);
        let v6 = 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::cancel_cap::new_cancel_cap(v4, arg7);
        0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::events::emit_stream_created(v4, 0x2::object::id<0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::cancel_cap::CancelCap>(&v6), arg3, 0x2::tx_context::sender(arg7), v0 - v1, arg4, 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::types::segment_timestamp(0x1::vector::borrow<0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::types::Segment>(v5, 0x1::vector::length<0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::types::Segment>(v5) - 1)), 0x1::option::none<u64>(), 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::dynamic::strategy_type(), 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::version::get_version(arg1), 0x1::option::none<vector<0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::types::Tranche>>(), 0x1::option::some<vector<0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::types::Segment>>(*v5));
        0x2::transfer::public_transfer<0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::cancel_cap::CancelCap>(v6, 0x2::tx_context::sender(arg7));
    }

    public fun create_linear_stream<T0>(arg0: &mut LockFactory, arg1: &0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::version::VersionRegistry, arg2: 0x2::coin::Coin<T0>, arg3: address, arg4: u64, arg5: u64, arg6: 0x1::option::Option<u64>, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::version::check_version(arg1);
        assert!(arg5 > arg4, 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::error::einvalid_time_range());
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::error::einvalid_amount());
        let v1 = calculate_fee(v0, arg0.fee_rate);
        let (v2, arg2) = if (v1 > 0) {
            (0x2::coin::split<T0>(&mut arg2, v1, arg8), arg2)
        } else {
            (0x2::coin::zero<T0>(arg8), arg2)
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, arg0.fee_recipient);
            0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::events::emit_fee_collected(v1, arg0.fee_recipient, 0x1::option::none<0x2::object::ID>());
        } else {
            0x2::coin::destroy_zero<T0>(v2);
        };
        let v3 = 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::linear::new_stream<T0>(arg3, arg2, arg4, arg5, arg6, arg7, arg8);
        let v4 = 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::linear::id<T0>(&v3);
        0x2::transfer::public_share_object<0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::linear::LinearStream<T0>>(v3);
        let v5 = 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::cancel_cap::new_cancel_cap(v4, arg8);
        0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::events::emit_stream_created(v4, 0x2::object::id<0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::cancel_cap::CancelCap>(&v5), arg3, 0x2::tx_context::sender(arg8), v0 - v1, arg4, arg5, arg6, 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::linear::strategy_type(), 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::version::get_version(arg1), 0x1::option::none<vector<0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::types::Tranche>>(), 0x1::option::none<vector<0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::types::Segment>>());
        0x2::transfer::public_transfer<0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::cancel_cap::CancelCap>(v5, 0x2::tx_context::sender(arg8));
    }

    public fun create_lock_object_stream<T0: store + key>(arg0: &mut LockFactory, arg1: &0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::version::VersionRegistry, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: T0, arg5: address, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::version::check_version(arg1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= arg0.lock_fee, 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::error::einvalid_amount());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, arg0.lock_fee, arg7), arg0.fee_recipient);
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg6 > v0, 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::error::einvalid_unlock_time());
        let v1 = 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::lock_object::new_locked_object<T0>(arg5, arg4, arg6, v0, arg7);
        0x2::transfer::public_share_object<0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::lock_object::LockedObject<T0>>(v1);
        0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::events::emit_object_locked(0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::lock_object::id<T0>(&v1), 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::lock_object::get_locked_object_id<T0>(&v1), 0x2::tx_context::sender(arg7), arg5, arg6, 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::version::get_version(arg1));
    }

    public fun create_tranched_stream<T0>(arg0: &mut LockFactory, arg1: &0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::version::VersionRegistry, arg2: 0x2::coin::Coin<T0>, arg3: address, arg4: vector<0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::types::Tranche>, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::version::check_version(arg1);
        assert!(0x1::vector::length<0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::types::Tranche>(&arg4) <= 100, 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::error::etoo_many_segments());
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::error::einvalid_amount());
        let v1 = calculate_fee(v0, arg0.fee_rate);
        let (v2, arg2) = if (v1 > 0) {
            (0x2::coin::split<T0>(&mut arg2, v1, arg6), arg2)
        } else {
            (0x2::coin::zero<T0>(arg6), arg2)
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, arg0.fee_recipient);
            0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::events::emit_fee_collected(v1, arg0.fee_recipient, 0x1::option::none<0x2::object::ID>());
        } else {
            0x2::coin::destroy_zero<T0>(v2);
        };
        let v3 = 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::tranched::new_stream<T0>(arg3, arg2, arg4, arg5, arg6);
        let v4 = 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::tranched::id<T0>(&v3);
        let v5 = 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::cancel_cap::new_cancel_cap(v4, arg6);
        let v6 = 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::tranched::tranches<T0>(&v3);
        0x2::transfer::public_share_object<0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::tranched::TranchedStream<T0>>(v3);
        0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::events::emit_stream_created(v4, 0x2::object::id<0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::cancel_cap::CancelCap>(&v5), arg3, 0x2::tx_context::sender(arg6), v0 - v1, 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::types::tranche_timestamp(0x1::vector::borrow<0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::types::Tranche>(v6, 0)), 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::types::tranche_timestamp(0x1::vector::borrow<0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::types::Tranche>(v6, 0x1::vector::length<0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::types::Tranche>(v6) - 1)), 0x1::option::none<u64>(), 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::tranched::strategy_type(), 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::version::get_version(arg1), 0x1::option::some<vector<0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::types::Tranche>>(*v6), 0x1::option::none<vector<0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::types::Segment>>());
        0x2::transfer::public_transfer<0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::cancel_cap::CancelCap>(v5, 0x2::tx_context::sender(arg6));
    }

    public fun get_fee_rate(arg0: &LockFactory) : u64 {
        arg0.fee_rate
    }

    public fun get_fee_recipient(arg0: &LockFactory) : address {
        arg0.fee_recipient
    }

    public fun get_lock_fee(arg0: &LockFactory) : u64 {
        arg0.lock_fee
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = LockFactory{
            id            : 0x2::object::new(arg0),
            fee_rate      : 10,
            fee_recipient : v0,
            lock_fee      : 100000000,
        };
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, v0);
        0x2::transfer::share_object<LockFactory>(v1);
    }

    public fun update_fee_rate(arg0: &mut LockFactory, arg1: &mut AdminCap, arg2: u64) {
        assert!(arg2 <= 10000, 0x766ab571e32f04919d39e19999c8e853a4f86a184c1dc50ce82b5de659c435c3::error::einvalid_fee_rate());
        arg0.fee_rate = arg2;
    }

    public fun update_fee_recipient(arg0: &mut LockFactory, arg1: &mut AdminCap, arg2: address) {
        arg0.fee_recipient = arg2;
    }

    public fun update_lock_fee(arg0: &mut LockFactory, arg1: &mut AdminCap, arg2: u64) {
        arg0.lock_fee = arg2;
    }

    // decompiled from Move bytecode v6
}

