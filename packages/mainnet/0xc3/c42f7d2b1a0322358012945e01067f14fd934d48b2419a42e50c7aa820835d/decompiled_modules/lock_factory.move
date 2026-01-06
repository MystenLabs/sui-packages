module 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::lock_factory {
    public fun create_dynamic_stream<T0>(arg0: &0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::version::VersionRegistry, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: u64, arg4: vector<0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::types::Segment>, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::version::check_version(arg0);
        assert!(0x1::vector::length<0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::types::Segment>(&arg4) <= 100, 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::error::etoo_many_segments());
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::error::einvalid_amount());
        let v1 = 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::dynamic::new_stream<T0>(arg2, arg1, arg3, arg4, arg5, arg6);
        let v2 = 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::dynamic::id<T0>(&v1);
        let v3 = 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::dynamic::segments<T0>(&v1);
        0x2::transfer::public_share_object<0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::dynamic::DynamicStream<T0>>(v1);
        let v4 = 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::cancel_cap::new_cancel_cap(v2, arg6);
        0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::events::emit_stream_created(v2, 0x2::object::id<0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::cancel_cap::CancelCap>(&v4), arg2, 0x2::tx_context::sender(arg6), v0, arg3, 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::types::segment_timestamp(0x1::vector::borrow<0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::types::Segment>(v3, 0x1::vector::length<0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::types::Segment>(v3) - 1)), 0x1::option::none<u64>(), 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::dynamic::strategy_type(), 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::version::get_version(arg0), 0x1::option::none<vector<0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::types::Tranche>>(), 0x1::option::some<vector<0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::types::Segment>>(*v3), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())));
        0x2::transfer::public_transfer<0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::cancel_cap::CancelCap>(v4, 0x2::tx_context::sender(arg6));
    }

    public fun create_linear_stream<T0>(arg0: &0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::version::VersionRegistry, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: u64, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::version::check_version(arg0);
        assert!(arg4 > arg3, 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::error::einvalid_time_range());
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::error::einvalid_amount());
        let v1 = 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::linear::new_stream<T0>(arg2, arg1, arg3, arg4, arg5, arg6, arg7);
        let v2 = 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::linear::id<T0>(&v1);
        0x2::transfer::public_share_object<0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::linear::LinearStream<T0>>(v1);
        let v3 = 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::cancel_cap::new_cancel_cap(v2, arg7);
        0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::events::emit_stream_created(v2, 0x2::object::id<0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::cancel_cap::CancelCap>(&v3), arg2, 0x2::tx_context::sender(arg7), v0, arg3, arg4, arg5, 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::linear::strategy_type(), 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::version::get_version(arg0), 0x1::option::none<vector<0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::types::Tranche>>(), 0x1::option::none<vector<0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::types::Segment>>(), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())));
        0x2::transfer::public_transfer<0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::cancel_cap::CancelCap>(v3, 0x2::tx_context::sender(arg7));
    }

    public fun create_lock_object_stream<T0: store + key>(arg0: &0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::global_config::GlobalConfig, arg1: &0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::version::VersionRegistry, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: T0, arg5: address, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::version::check_version(arg1);
        let v0 = 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::global_config::get_lock_fee(arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v0, 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::error::einvalid_amount());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v0, arg7), 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::global_config::get_fee_recipient(arg0));
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg6 > v1, 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::error::einvalid_unlock_time());
        let v2 = 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::lock_object::new_locked_object<T0>(arg5, arg4, arg6, v1, arg7);
        0x2::transfer::public_share_object<0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::lock_object::LockedObject<T0>>(v2);
        0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::events::emit_object_locked(0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::lock_object::id<T0>(&v2), 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::lock_object::get_locked_object_id<T0>(&v2), 0x2::tx_context::sender(arg7), arg5, arg6, 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::version::get_version(arg1), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())));
    }

    public fun create_tranched_stream<T0>(arg0: &0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::version::VersionRegistry, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: vector<0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::types::Tranche>, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::version::check_version(arg0);
        assert!(0x1::vector::length<0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::types::Tranche>(&arg3) <= 100, 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::error::etoo_many_segments());
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::error::einvalid_amount());
        let v1 = 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::tranched::new_stream<T0>(arg2, arg1, arg3, arg4, arg5);
        let v2 = 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::tranched::id<T0>(&v1);
        let v3 = 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::cancel_cap::new_cancel_cap(v2, arg5);
        let v4 = 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::tranched::tranches<T0>(&v1);
        0x2::transfer::public_share_object<0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::tranched::TranchedStream<T0>>(v1);
        0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::events::emit_stream_created(v2, 0x2::object::id<0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::cancel_cap::CancelCap>(&v3), arg2, 0x2::tx_context::sender(arg5), v0, 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::types::tranche_timestamp(0x1::vector::borrow<0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::types::Tranche>(v4, 0)), 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::types::tranche_timestamp(0x1::vector::borrow<0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::types::Tranche>(v4, 0x1::vector::length<0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::types::Tranche>(v4) - 1)), 0x1::option::none<u64>(), 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::tranched::strategy_type(), 0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::version::get_version(arg0), 0x1::option::some<vector<0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::types::Tranche>>(*v4), 0x1::option::none<vector<0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::types::Segment>>(), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())));
        0x2::transfer::public_transfer<0xc3c42f7d2b1a0322358012945e01067f14fd934d48b2419a42e50c7aa820835d::cancel_cap::CancelCap>(v3, 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

