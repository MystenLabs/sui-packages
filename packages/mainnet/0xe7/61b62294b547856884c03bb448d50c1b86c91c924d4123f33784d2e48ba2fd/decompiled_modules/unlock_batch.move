module 0xe761b62294b547856884c03bb448d50c1b86c91c924d4123f33784d2e48ba2fd::unlock_batch {
    struct OrderBatchedItemUnlocked has copy, drop {
        hash: address,
        vaa_sequence: u64,
        item_index: u16,
    }

    struct UnlockBatchReceipt {
        vaa_sequence: u64,
        unlock_batch_msg: 0xe761b62294b547856884c03bb448d50c1b86c91c924d4123f33784d2e48ba2fd::unlock_batch_message::UnlockBatchMessage,
    }

    public fun complete_unlock_batch(arg0: UnlockBatchReceipt) {
        let UnlockBatchReceipt {
            vaa_sequence     : _,
            unlock_batch_msg : v1,
        } = arg0;
        let v2 = 0xe761b62294b547856884c03bb448d50c1b86c91c924d4123f33784d2e48ba2fd::unlock_batch_message::unpack(v1);
        while (0x1::vector::length<0xe761b62294b547856884c03bb448d50c1b86c91c924d4123f33784d2e48ba2fd::unlock_batch_message::UnlockBatchMessageItem>(&v2) > 0) {
            let (_, _, _, _) = 0xe761b62294b547856884c03bb448d50c1b86c91c924d4123f33784d2e48ba2fd::unlock_batch_message::unpack_item(0x1::vector::pop_back<0xe761b62294b547856884c03bb448d50c1b86c91c924d4123f33784d2e48ba2fd::unlock_batch_message::UnlockBatchMessageItem>(&mut v2));
        };
        0x1::vector::destroy_empty<0xe761b62294b547856884c03bb448d50c1b86c91c924d4123f33784d2e48ba2fd::unlock_batch_message::UnlockBatchMessageItem>(v2);
    }

    public fun prepare_unlock_batch(arg0: &0xe761b62294b547856884c03bb448d50c1b86c91c924d4123f33784d2e48ba2fd::state::State, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA) : UnlockBatchReceipt {
        let (v0, v1, v2) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(arg1);
        0xe761b62294b547856884c03bb448d50c1b86c91c924d4123f33784d2e48ba2fd::state::verify_swift_emitter(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v1), v0);
        UnlockBatchReceipt{
            vaa_sequence     : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::sequence(&arg1),
            unlock_batch_msg : 0xe761b62294b547856884c03bb448d50c1b86c91c924d4123f33784d2e48ba2fd::unlock_batch_message::deserialize(v2),
        }
    }

    public fun unlock_batch_item<T0>(arg0: &mut 0xe761b62294b547856884c03bb448d50c1b86c91c924d4123f33784d2e48ba2fd::state::State, arg1: 0xe761b62294b547856884c03bb448d50c1b86c91c924d4123f33784d2e48ba2fd::state::LockedFunds<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: UnlockBatchReceipt, arg4: u16, arg5: &mut 0x2::tx_context::TxContext) : UnlockBatchReceipt {
        let (v0, v1, v2, v3) = 0xe761b62294b547856884c03bb448d50c1b86c91c924d4123f33784d2e48ba2fd::unlock_batch_message::get_item(&arg3.unlock_batch_msg, arg4);
        assert!(v1 == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 0);
        assert!(0xe761b62294b547856884c03bb448d50c1b86c91c924d4123f33784d2e48ba2fd::state::has_source_order(arg0, v0), 1);
        assert!(0xe761b62294b547856884c03bb448d50c1b86c91c924d4123f33784d2e48ba2fd::state::get_source_order_status(arg0, v0) == 0xe761b62294b547856884c03bb448d50c1b86c91c924d4123f33784d2e48ba2fd::state::source_order_status_created(), 2);
        assert!(0xe761b62294b547856884c03bb448d50c1b86c91c924d4123f33784d2e48ba2fd::state::get_source_order_token_in(arg0, v0) == v2, 3);
        let v4 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg2);
        assert!(v2 == 0x2::object::id_to_address(&v4), 5);
        assert!(0xe761b62294b547856884c03bb448d50c1b86c91c924d4123f33784d2e48ba2fd::state::get_source_order_locked_funds_id(arg0, v0) == 0x2::object::id<0xe761b62294b547856884c03bb448d50c1b86c91c924d4123f33784d2e48ba2fd::state::LockedFunds<T0>>(&arg1), 4);
        0xe761b62294b547856884c03bb448d50c1b86c91c924d4123f33784d2e48ba2fd::state::unlock_source_order<T0>(arg0, arg1, v0, v3, arg5);
        let v5 = OrderBatchedItemUnlocked{
            hash         : v0,
            vaa_sequence : arg3.vaa_sequence,
            item_index   : arg4,
        };
        0x2::event::emit<OrderBatchedItemUnlocked>(v5);
        arg3
    }

    // decompiled from Move bytecode v6
}

