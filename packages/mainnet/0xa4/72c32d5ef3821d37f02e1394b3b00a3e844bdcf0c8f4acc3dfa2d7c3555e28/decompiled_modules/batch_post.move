module 0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::batch_post {
    struct BatchUnlockPosted has copy, drop {
        compact: bool,
        orders: vector<address>,
    }

    public fun post_batch(arg0: &mut 0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::state::State, arg1: vector<address>, arg2: bool) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::MessageTicket {
        0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::state::assert_valid_version(arg0);
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 > 0, 0);
        let (v1, v2, v3, v4, v5, v6, v7, v8) = 0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::state::get_fulfilled_dest_order(arg0, *0x1::vector::borrow<address>(&arg1, 0));
        let v9 = 0x1::vector::empty<0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::unlock_batch_message::UnlockBatchMessageItem>();
        0x1::vector::push_back<0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::unlock_batch_message::UnlockBatchMessageItem>(&mut v9, 0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::unlock_batch_message::new_item(*0x1::vector::borrow<address>(&arg1, 0), v1, v2, v3, v4, v5, v6, v7, v8));
        let v10 = 1;
        while (v10 < v0) {
            let (v11, v12, v13, v14, v15, v16, v17, v18) = 0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::state::get_fulfilled_dest_order(arg0, *0x1::vector::borrow<address>(&arg1, v10));
            assert!(v11 == v1, 0);
            0x1::vector::push_back<0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::unlock_batch_message::UnlockBatchMessageItem>(&mut v9, 0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::unlock_batch_message::new_item(*0x1::vector::borrow<address>(&arg1, v10), v11, v12, v13, v14, v15, v16, v17, v18));
            v10 = v10 + 1;
        };
        let v19 = if (arg2) {
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::state::borrow_mut_emitter_cap(arg0), 0, 0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::unlock_batch_message_compact::serialize(0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::unlock_batch_message::new(v9)))
        } else {
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::state::borrow_mut_emitter_cap(arg0), 0, 0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::unlock_batch_message::serialize(0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::unlock_batch_message::new(v9)))
        };
        let v20 = BatchUnlockPosted{
            compact : false,
            orders  : arg1,
        };
        0x2::event::emit<BatchUnlockPosted>(v20);
        v19
    }

    // decompiled from Move bytecode v6
}

