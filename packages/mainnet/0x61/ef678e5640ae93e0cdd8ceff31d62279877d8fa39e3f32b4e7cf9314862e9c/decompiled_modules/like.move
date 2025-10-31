module 0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::like {
    public fun like(arg0: &mut 0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT, arg1: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let (v1, v2, v3, v4) = prepare_like_transaction(arg0, 0, arg1, arg2);
        let v5 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(v4, 0x2::object::id_to_address(&v5));
        0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::meme_events::emit_tip_received(v5, v0, v2, v3, true, 0x2::tx_context::epoch(arg2));
        emit_like_event(v5, v0, 0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::likes(arg0), 0x2::tx_context::epoch(arg2));
    }

    fun apply_like(arg0: &mut 0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::is_liked_by(arg0, arg1), 0);
        0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::increment_likes(arg0);
        0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::add_liker(arg0, arg1, arg2);
    }

    public fun can_like(arg0: &0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT, arg1: address) : bool {
        !0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::is_liked_by(arg0, arg1)
    }

    fun distribute_tips(arg0: 0x2::object::ID, arg1: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg2: u64, arg3: vector<0x2::object::ID>, arg4: address, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg3);
        if (v0 > 0) {
            let v1 = arg2 / 2 / v0;
            let v2 = 0;
            while (v2 < v0) {
                let v3 = *0x1::vector::borrow<0x2::object::ID>(&arg3, v2);
                assert!(0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg1) >= v1, 4);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(0x2::coin::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg1, v1, arg6), 0x2::object::id_to_address(&v3));
                0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::meme_events::emit_tip_received(v3, arg4, v1, arg5, false, 0x2::tx_context::epoch(arg6));
                v2 = v2 + 1;
            };
            let v4 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg1);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(arg1, 0x2::object::id_to_address(&arg0));
            0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::meme_events::emit_tip_received(arg0, arg4, v4, arg5, true, 0x2::tx_context::epoch(arg6));
            0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::meme_events::emit_tip_distributed(arg0, arg2, v4, v0, v1, arg5, 0x2::tx_context::epoch(arg6));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(arg1, 0x2::object::id_to_address(&arg0));
            0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::meme_events::emit_tip_received(arg0, arg4, arg2, arg5, true, 0x2::tx_context::epoch(arg6));
        };
    }

    fun emit_like_event(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::meme_events::emit_meme_nft_liked(arg0, arg1, arg2, arg3);
    }

    public fun get_likes_count(arg0: &0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT) : u64 {
        0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::likes(arg0)
    }

    public fun has_liked(arg0: &0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT, arg1: address) : bool {
        0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::is_liked_by(arg0, arg1)
    }

    public fun like_with_1_parent(arg0: &mut 0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT, arg1: &0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT, arg2: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let (v1, v2, v3, v4) = prepare_like_transaction(arg0, 1, arg3, arg4);
        let v5 = 0x2::object::id<0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT>(arg1);
        assert!(v5 == *0x1::vector::borrow<0x2::object::ID>(0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::parent_hierarchy(arg0), 0), 2);
        let v6 = 0x1::vector::empty<0x2::object::ID>();
        if (0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg2) < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::blob(arg1))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v6, v5);
        };
        distribute_tips(v1, v4, v2, v6, v0, v3, arg4);
        emit_like_event(v1, v0, 0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::likes(arg0), 0x2::tx_context::epoch(arg4));
    }

    public fun like_with_2_parents(arg0: &mut 0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT, arg1: &0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT, arg2: &0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT, arg3: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg4: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let (v1, v2, v3, v4) = prepare_like_transaction(arg0, 2, arg4, arg5);
        let v5 = 0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::parent_hierarchy(arg0);
        let v6 = 0x2::object::id<0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT>(arg1);
        let v7 = 0x2::object::id<0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT>(arg2);
        assert!(v6 == *0x1::vector::borrow<0x2::object::ID>(v5, 0), 2);
        assert!(v7 == *0x1::vector::borrow<0x2::object::ID>(v5, 1), 2);
        let v8 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg3);
        let v9 = 0x1::vector::empty<0x2::object::ID>();
        if (v8 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::blob(arg1))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v9, v6);
        };
        if (v8 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::blob(arg2))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v9, v7);
        };
        distribute_tips(v1, v4, v2, v9, v0, v3, arg5);
        emit_like_event(v1, v0, 0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::likes(arg0), 0x2::tx_context::epoch(arg5));
    }

    public fun like_with_3_parents(arg0: &mut 0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT, arg1: &0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT, arg2: &0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT, arg3: &0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT, arg4: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg5: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let (v1, v2, v3, v4) = prepare_like_transaction(arg0, 3, arg5, arg6);
        let v5 = 0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::parent_hierarchy(arg0);
        let v6 = 0x2::object::id<0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT>(arg1);
        let v7 = 0x2::object::id<0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT>(arg2);
        let v8 = 0x2::object::id<0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT>(arg3);
        assert!(v6 == *0x1::vector::borrow<0x2::object::ID>(v5, 0), 2);
        assert!(v7 == *0x1::vector::borrow<0x2::object::ID>(v5, 1), 2);
        assert!(v8 == *0x1::vector::borrow<0x2::object::ID>(v5, 2), 2);
        let v9 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg4);
        let v10 = 0x1::vector::empty<0x2::object::ID>();
        if (v9 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::blob(arg1))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v10, v6);
        };
        if (v9 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::blob(arg2))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v10, v7);
        };
        if (v9 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::blob(arg3))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v10, v8);
        };
        distribute_tips(v1, v4, v2, v10, v0, v3, arg6);
        emit_like_event(v1, v0, 0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::likes(arg0), 0x2::tx_context::epoch(arg6));
    }

    public fun like_with_4_parents(arg0: &mut 0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT, arg1: &0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT, arg2: &0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT, arg3: &0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT, arg4: &0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT, arg5: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg6: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let (v1, v2, v3, v4) = prepare_like_transaction(arg0, 4, arg6, arg7);
        let v5 = 0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::parent_hierarchy(arg0);
        let v6 = 0x2::object::id<0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT>(arg1);
        let v7 = 0x2::object::id<0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT>(arg2);
        let v8 = 0x2::object::id<0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT>(arg3);
        let v9 = 0x2::object::id<0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT>(arg4);
        assert!(v6 == *0x1::vector::borrow<0x2::object::ID>(v5, 0), 2);
        assert!(v7 == *0x1::vector::borrow<0x2::object::ID>(v5, 1), 2);
        assert!(v8 == *0x1::vector::borrow<0x2::object::ID>(v5, 2), 2);
        assert!(v9 == *0x1::vector::borrow<0x2::object::ID>(v5, 3), 2);
        let v10 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg5);
        let v11 = 0x1::vector::empty<0x2::object::ID>();
        if (v10 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::blob(arg1))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v11, v6);
        };
        if (v10 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::blob(arg2))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v11, v7);
        };
        if (v10 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::blob(arg3))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v11, v8);
        };
        if (v10 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::blob(arg4))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v11, v9);
        };
        distribute_tips(v1, v4, v2, v11, v0, v3, arg7);
        emit_like_event(v1, v0, 0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::likes(arg0), 0x2::tx_context::epoch(arg7));
    }

    public fun like_with_5_parents(arg0: &mut 0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT, arg1: &0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT, arg2: &0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT, arg3: &0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT, arg4: &0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT, arg5: &0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT, arg6: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg7: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let (v1, v2, v3, v4) = prepare_like_transaction(arg0, 5, arg7, arg8);
        let v5 = 0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::parent_hierarchy(arg0);
        let v6 = 0x2::object::id<0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT>(arg1);
        let v7 = 0x2::object::id<0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT>(arg2);
        let v8 = 0x2::object::id<0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT>(arg3);
        let v9 = 0x2::object::id<0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT>(arg4);
        let v10 = 0x2::object::id<0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT>(arg5);
        assert!(v6 == *0x1::vector::borrow<0x2::object::ID>(v5, 0), 2);
        assert!(v7 == *0x1::vector::borrow<0x2::object::ID>(v5, 1), 2);
        assert!(v8 == *0x1::vector::borrow<0x2::object::ID>(v5, 2), 2);
        assert!(v9 == *0x1::vector::borrow<0x2::object::ID>(v5, 3), 2);
        assert!(v10 == *0x1::vector::borrow<0x2::object::ID>(v5, 4), 2);
        let v11 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg6);
        let v12 = 0x1::vector::empty<0x2::object::ID>();
        if (v11 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::blob(arg1))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v12, v6);
        };
        if (v11 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::blob(arg2))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v12, v7);
        };
        if (v11 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::blob(arg3))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v12, v8);
        };
        if (v11 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::blob(arg4))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v12, v9);
        };
        if (v11 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::blob(arg5))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v12, v10);
        };
        distribute_tips(v1, v4, v2, v12, v0, v3, arg8);
        emit_like_event(v1, v0, 0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::likes(arg0), 0x2::tx_context::epoch(arg8));
    }

    fun prepare_like_transaction(arg0: &mut 0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT, arg1: u64, arg2: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, u64, 0x1::string::String, 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::id<0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::MemeNFT>(arg0);
        let v2 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg2);
        assert!(v2 >= 2000, 3);
        assert!(0x1::vector::length<0x2::object::ID>(0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::parent_hierarchy(arg0)) == arg1, 1);
        apply_like(arg0, v0, arg3);
        let v3 = v2 / 2;
        0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft::fund_blob(arg0, 0x2::coin::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg2, v3, arg3));
        (v1, v2 - v3, 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>()))), arg2)
    }

    // decompiled from Move bytecode v6
}

