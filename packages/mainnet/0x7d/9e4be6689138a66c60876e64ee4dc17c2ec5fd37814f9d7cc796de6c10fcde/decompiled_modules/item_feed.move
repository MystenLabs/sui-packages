module 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item_feed {
    struct FeedableAbility has store, key {
        id: 0x2::object::UID,
        stomach: 0x2::balance::Balance<0x2::sui::SUI>,
        last_feed: u64,
    }

    struct FeedKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun feed_suifren<T0>(arg0: &mut 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::assert_latest(arg2);
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::events::emit_pet_feed_event(0x2::object::id<0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0>>(arg0));
        let v0 = 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::uid_mut<T0>(arg0);
        let v1 = FeedKey{dummy_field: false};
        if (!0x2::dynamic_object_field::exists_<FeedKey>(v0, v1)) {
            let v2 = FeedKey{dummy_field: false};
            let v3 = FeedableAbility{
                id        : 0x2::object::new(arg3),
                stomach   : 0x2::balance::zero<0x2::sui::SUI>(),
                last_feed : 0,
            };
            0x2::dynamic_object_field::add<FeedKey, FeedableAbility>(v0, v2, v3);
        };
        let v4 = FeedKey{dummy_field: false};
        let v5 = 0x2::dynamic_object_field::borrow_mut<FeedKey, FeedableAbility>(v0, v4);
        assert!(0x2::tx_context::epoch(arg3) > v5.last_feed, 101);
        v5.last_feed = 0x2::tx_context::epoch(arg3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == 1000000000, 102);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v5.stomach) <= 100000000000, 103);
        0x2::coin::put<0x2::sui::SUI>(&mut v5.stomach, arg1);
    }

    // decompiled from Move bytecode v6
}

