module 0xbfec5551574d258bc49e67898126130c26ea6f8f7fb2193981e758fa2b9e0bfe::batch_post {
    struct BatchUnlockPosted has copy, drop {
        orders: vector<address>,
    }

    public fun post_batch(arg0: &mut 0xbfec5551574d258bc49e67898126130c26ea6f8f7fb2193981e758fa2b9e0bfe::state::State, arg1: vector<address>) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::MessageTicket {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 > 0, 0);
        let (v1, v2, v3) = 0xbfec5551574d258bc49e67898126130c26ea6f8f7fb2193981e758fa2b9e0bfe::state::get_finalized_dest_order(arg0, *0x1::vector::borrow<address>(&arg1, 0));
        let v4 = 0x1::vector::empty<0xbfec5551574d258bc49e67898126130c26ea6f8f7fb2193981e758fa2b9e0bfe::unlock_batch_message::UnlockBatchMessageItem>();
        0x1::vector::push_back<0xbfec5551574d258bc49e67898126130c26ea6f8f7fb2193981e758fa2b9e0bfe::unlock_batch_message::UnlockBatchMessageItem>(&mut v4, 0xbfec5551574d258bc49e67898126130c26ea6f8f7fb2193981e758fa2b9e0bfe::unlock_batch_message::new_item(*0x1::vector::borrow<address>(&arg1, 0), v1, v2, v3));
        let v5 = 1;
        while (v5 < v0) {
            let (v6, v7, v8) = 0xbfec5551574d258bc49e67898126130c26ea6f8f7fb2193981e758fa2b9e0bfe::state::get_finalized_dest_order(arg0, *0x1::vector::borrow<address>(&arg1, v5));
            0x1::vector::push_back<0xbfec5551574d258bc49e67898126130c26ea6f8f7fb2193981e758fa2b9e0bfe::unlock_batch_message::UnlockBatchMessageItem>(&mut v4, 0xbfec5551574d258bc49e67898126130c26ea6f8f7fb2193981e758fa2b9e0bfe::unlock_batch_message::new_item(*0x1::vector::borrow<address>(&arg1, v5), v6, v7, v8));
            v5 = v5 + 1;
        };
        let v9 = BatchUnlockPosted{orders: arg1};
        0x2::event::emit<BatchUnlockPosted>(v9);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(0xbfec5551574d258bc49e67898126130c26ea6f8f7fb2193981e758fa2b9e0bfe::state::borrow_mut_emitter_cap(arg0), 0, 0xbfec5551574d258bc49e67898126130c26ea6f8f7fb2193981e758fa2b9e0bfe::unlock_batch_message::serialize(0xbfec5551574d258bc49e67898126130c26ea6f8f7fb2193981e758fa2b9e0bfe::unlock_batch_message::new(v4)))
    }

    // decompiled from Move bytecode v6
}

