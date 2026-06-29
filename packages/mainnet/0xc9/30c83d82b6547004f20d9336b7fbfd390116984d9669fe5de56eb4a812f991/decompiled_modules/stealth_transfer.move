module 0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::stealth_transfer {
    struct PrivateSendCompleted has copy, drop {
        relayed: bool,
        recipient: address,
        announcement_id: u64,
        net_amount: u64,
        fee: u64,
        timestamp_ms: u64,
    }

    public fun direct_send(arg0: &0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::privacy_receipt::ReceiptCap, arg1: &mut 0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::stealth_address_registry::Registry, arg2: &mut 0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::view_tag_index::ViewTagIndex, arg3: &mut 0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::announcement_indexer::AnnouncementIndexer, arg4: address, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) > 0, 1);
        assert!(arg4 != @0x0, 2);
        let v0 = 0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::stealth_address_registry::announcement_count(arg1);
        0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::stealth_address_registry::announce(arg12, arg1, arg6, arg7, arg8, arg11);
        0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::view_tag_index::record(arg2, arg7, v0);
        0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::announcement_indexer::advance_cursor(arg3, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, arg4);
        0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::privacy_receipt::issue(arg0, arg4, arg9, arg10, v0, 0x2::clock::timestamp_ms(arg11), arg12);
        let v1 = PrivateSendCompleted{
            relayed         : false,
            recipient       : arg4,
            announcement_id : v0,
            net_amount      : 0x2::coin::value<0x2::sui::SUI>(&arg5),
            fee             : 0,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg11),
        };
        0x2::event::emit<PrivateSendCompleted>(v1);
    }

    public fun relayed_send(arg0: &0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::privacy_relayer::RelayerCap, arg1: &0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::privacy_receipt::ReceiptCap, arg2: &mut 0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::privacy_relayer::RelayerState, arg3: &mut 0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::stealth_address_registry::Registry, arg4: &mut 0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::view_tag_index::ViewTagIndex, arg5: &mut 0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::announcement_indexer::AnnouncementIndexer, arg6: address, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: vector<u8>, arg9: u8, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<u8>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg7) > 0, 1);
        assert!(arg6 != @0x0, 2);
        let v0 = 0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::stealth_address_registry::announcement_count(arg3);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v1, arg9);
        0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::stealth_address_registry::announce(arg14, arg3, arg8, v1, arg10, arg13);
        0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::view_tag_index::record(arg4, v1, v0);
        0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::announcement_indexer::advance_cursor(arg5, v0);
        0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::privacy_relayer::relay(arg0, arg2, arg6, b"", arg9, arg7, arg13, arg14);
        let v2 = 0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::privacy_relayer::total_relayed(arg2) - 0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::privacy_relayer::total_relayed(arg2);
        0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::privacy_receipt::issue(arg1, arg6, arg11, arg12, v0, 0x2::clock::timestamp_ms(arg13), arg14);
        let v3 = PrivateSendCompleted{
            relayed         : true,
            recipient       : arg6,
            announcement_id : v0,
            net_amount      : v2,
            fee             : 0x2::coin::value<0x2::sui::SUI>(&arg7) - v2,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg13),
        };
        0x2::event::emit<PrivateSendCompleted>(v3);
    }

    // decompiled from Move bytecode v7
}

