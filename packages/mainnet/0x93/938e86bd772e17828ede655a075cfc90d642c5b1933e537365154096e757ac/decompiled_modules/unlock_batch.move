module 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::unlock_batch {
    struct BatchedUnlockPrepared has copy, drop {
        vaa_sequence: u64,
        orders: vector<address>,
    }

    struct OrderBatchedItemUnlocked has copy, drop {
        hash: address,
        vaa_sequence: u64,
        item_index: u16,
    }

    struct UnlockBatchReceipt {
        vaa_sequence: u64,
        emitter_chain: u16,
        unlock_batch_msg: 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::unlock_batch_message::UnlockBatchMessage,
    }

    public fun complete_unlock_batch(arg0: UnlockBatchReceipt) {
        let UnlockBatchReceipt {
            vaa_sequence     : _,
            emitter_chain    : _,
            unlock_batch_msg : v2,
        } = arg0;
        let v3 = 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::unlock_batch_message::unpack(v2);
        while (0x1::vector::length<0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::unlock_batch_message::UnlockBatchMessageItem>(&v3) > 0) {
            let (_, _, _, _, _, _, _, _, _) = 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::unlock_batch_message::unpack_item(0x1::vector::pop_back<0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::unlock_batch_message::UnlockBatchMessageItem>(&mut v3));
        };
        0x1::vector::destroy_empty<0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::unlock_batch_message::UnlockBatchMessageItem>(v3);
    }

    public fun prepare_unlock_batch(arg0: &0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::State, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA, arg2: vector<u8>) : UnlockBatchReceipt {
        0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::assert_valid_version(arg0);
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::sequence(&arg1);
        let (v1, v2, v3) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(arg1);
        0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::verify_swift_emitter(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v2), v1);
        let v4 = 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::unlock_batch_message_compact::deserialize(v3, arg2);
        let v5 = BatchedUnlockPrepared{
            vaa_sequence : v0,
            orders       : 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::unlock_batch_message::get_items_hashes(&v4),
        };
        0x2::event::emit<BatchedUnlockPrepared>(v5);
        UnlockBatchReceipt{
            vaa_sequence     : v0,
            emitter_chain    : v1,
            unlock_batch_msg : v4,
        }
    }

    public fun prepare_unlock_batch_compact(arg0: &0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::State, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA) : UnlockBatchReceipt {
        0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::assert_valid_version(arg0);
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::sequence(&arg1);
        let (v1, v2, v3) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(arg1);
        0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::verify_swift_emitter(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_address(v2), v1);
        let v4 = 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::unlock_batch_message::deserialize(v3);
        let v5 = BatchedUnlockPrepared{
            vaa_sequence : v0,
            orders       : 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::unlock_batch_message::get_items_hashes(&v4),
        };
        0x2::event::emit<BatchedUnlockPrepared>(v5);
        UnlockBatchReceipt{
            vaa_sequence     : v0,
            emitter_chain    : v1,
            unlock_batch_msg : v4,
        }
    }

    public fun unlock_batch_item<T0>(arg0: &mut 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::State, arg1: &0x677adf24b59cdc1208799ff862414e530bebc58100b53528f8753ff3642a11bd::state::FeeManagerState, arg2: 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::SourceLockedFunds<T0>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: UnlockBatchReceipt, arg5: u16, arg6: &mut 0x2::tx_context::TxContext) : UnlockBatchReceipt {
        0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::assert_valid_version(arg0);
        let (v0, v1, v2, v3, v4, v5, v6, _, _) = 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::unlock_batch_message::get_item(&arg4.unlock_batch_msg, arg5);
        assert!(v1 == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::chain_id(), 0);
        assert!(0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::has_source_order(arg0, v0), 1);
        assert!(0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::get_source_order_status(arg0, v0) == 0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::source_order_status_created(), 2);
        assert!(0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::get_source_order_token_in(arg0, v0) == v2, 3);
        assert!(0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::get_source_order_chain_dest(arg0, v0) == arg4.emitter_chain, 0);
        let v9 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg3);
        assert!(v2 == 0x2::object::id_to_address(&v9), 5);
        assert!(0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::get_source_order_locked_funds_id(arg0, v0) == 0x2::object::id<0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::SourceLockedFunds<T0>>(&arg2), 4);
        0x93938e86bd772e17828ede655a075cfc90d642c5b1933e537365154096e757ac::state::unlock_source_order<T0>(arg0, arg1, arg2, v0, v3, v4, v5, v6, arg6);
        let v10 = OrderBatchedItemUnlocked{
            hash         : v0,
            vaa_sequence : arg4.vaa_sequence,
            item_index   : arg5,
        };
        0x2::event::emit<OrderBatchedItemUnlocked>(v10);
        arg4
    }

    // decompiled from Move bytecode v6
}

