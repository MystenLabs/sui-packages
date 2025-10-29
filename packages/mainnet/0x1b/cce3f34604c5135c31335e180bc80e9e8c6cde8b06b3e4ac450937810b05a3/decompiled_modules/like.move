module 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::like {
    entry fun like(arg0: &mut 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg1: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg0);
        let v2 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg1);
        assert!(v2 >= 2000, 3);
        assert!(0x1::vector::length<0x2::object::ID>(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::parent_hierarchy(arg0)) == 0, 1);
        apply_like(arg0, v0, arg2);
        let v3 = v2 / 2;
        0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::fund_blob(arg0, 0x2::coin::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg1, v3, arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(arg1, 0x2::object::id_to_address(&v1));
        0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::meme_events::emit_tip_received(v1, v0, v2 - v3, 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>()))), true, 0x2::tx_context::epoch(arg2));
        emit_like_event(v1, v0, 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::likes(arg0), 0x2::tx_context::epoch(arg2));
    }

    fun apply_like(arg0: &mut 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::is_liked_by(arg0, arg1), 0);
        0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::increment_likes(arg0);
        0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::add_liker(arg0, arg1, arg2);
    }

    public fun can_like(arg0: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg1: address) : bool {
        !0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::is_liked_by(arg0, arg1)
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
                0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::meme_events::emit_tip_received(v3, arg4, v1, arg5, false, 0x2::tx_context::epoch(arg6));
                v2 = v2 + 1;
            };
            let v4 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg1);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(arg1, 0x2::object::id_to_address(&arg0));
            0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::meme_events::emit_tip_received(arg0, arg4, v4, arg5, true, 0x2::tx_context::epoch(arg6));
            0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::meme_events::emit_tip_distributed(arg0, arg2, v4, v0, v1, arg5, 0x2::tx_context::epoch(arg6));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(arg1, 0x2::object::id_to_address(&arg0));
            0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::meme_events::emit_tip_received(arg0, arg4, arg2, arg5, true, 0x2::tx_context::epoch(arg6));
        };
    }

    fun emit_like_event(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::meme_events::emit_meme_nft_liked(arg0, arg1, arg2, arg3);
    }

    public fun get_likes_count(arg0: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT) : u64 {
        0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::likes(arg0)
    }

    public fun has_liked(arg0: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg1: address) : bool {
        0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::is_liked_by(arg0, arg1)
    }

    entry fun like_with_1_parent(arg0: &mut 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg1: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg2: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg0);
        let v2 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg3);
        assert!(v2 >= 2000, 3);
        let v3 = 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::parent_hierarchy(arg0);
        assert!(0x1::vector::length<0x2::object::ID>(v3) == 1, 1);
        let v4 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg1);
        assert!(v4 == *0x1::vector::borrow<0x2::object::ID>(v3, 0), 2);
        apply_like(arg0, v0, arg4);
        let v5 = v2 / 2;
        0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::fund_blob(arg0, 0x2::coin::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg3, v5, arg4));
        let v6 = 0x1::vector::empty<0x2::object::ID>();
        if (0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg2) < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg1))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v6, v4);
        };
        distribute_tips(v1, arg3, v2 - v5, v6, v0, 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>()))), arg4);
        emit_like_event(v1, v0, 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::likes(arg0), 0x2::tx_context::epoch(arg4));
    }

    entry fun like_with_2_parents(arg0: &mut 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg1: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg2: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg3: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg4: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg0);
        let v2 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg4);
        assert!(v2 >= 2000, 3);
        let v3 = 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::parent_hierarchy(arg0);
        assert!(0x1::vector::length<0x2::object::ID>(v3) == 2, 1);
        let v4 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg1);
        let v5 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg2);
        assert!(v4 == *0x1::vector::borrow<0x2::object::ID>(v3, 0), 2);
        assert!(v5 == *0x1::vector::borrow<0x2::object::ID>(v3, 1), 2);
        apply_like(arg0, v0, arg5);
        let v6 = v2 / 2;
        0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::fund_blob(arg0, 0x2::coin::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg4, v6, arg5));
        let v7 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg3);
        let v8 = 0x1::vector::empty<0x2::object::ID>();
        if (v7 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg1))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v8, v4);
        };
        if (v7 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg2))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v8, v5);
        };
        distribute_tips(v1, arg4, v2 - v6, v8, v0, 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>()))), arg5);
        emit_like_event(v1, v0, 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::likes(arg0), 0x2::tx_context::epoch(arg5));
    }

    entry fun like_with_3_parents(arg0: &mut 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg1: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg2: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg3: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg4: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg5: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg0);
        let v2 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg5);
        assert!(v2 >= 2000, 3);
        let v3 = 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::parent_hierarchy(arg0);
        assert!(0x1::vector::length<0x2::object::ID>(v3) == 3, 1);
        let v4 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg1);
        let v5 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg2);
        let v6 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg3);
        assert!(v4 == *0x1::vector::borrow<0x2::object::ID>(v3, 0), 2);
        assert!(v5 == *0x1::vector::borrow<0x2::object::ID>(v3, 1), 2);
        assert!(v6 == *0x1::vector::borrow<0x2::object::ID>(v3, 2), 2);
        apply_like(arg0, v0, arg6);
        let v7 = v2 / 2;
        0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::fund_blob(arg0, 0x2::coin::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg5, v7, arg6));
        let v8 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg4);
        let v9 = 0x1::vector::empty<0x2::object::ID>();
        if (v8 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg1))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v9, v4);
        };
        if (v8 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg2))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v9, v5);
        };
        if (v8 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg3))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v9, v6);
        };
        distribute_tips(v1, arg5, v2 - v7, v9, v0, 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>()))), arg6);
        emit_like_event(v1, v0, 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::likes(arg0), 0x2::tx_context::epoch(arg6));
    }

    entry fun like_with_4_parents(arg0: &mut 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg1: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg2: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg3: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg4: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg5: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg6: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg0);
        let v2 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg6);
        assert!(v2 >= 2000, 3);
        let v3 = 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::parent_hierarchy(arg0);
        assert!(0x1::vector::length<0x2::object::ID>(v3) == 4, 1);
        let v4 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg1);
        let v5 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg2);
        let v6 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg3);
        let v7 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg4);
        assert!(v4 == *0x1::vector::borrow<0x2::object::ID>(v3, 0), 2);
        assert!(v5 == *0x1::vector::borrow<0x2::object::ID>(v3, 1), 2);
        assert!(v6 == *0x1::vector::borrow<0x2::object::ID>(v3, 2), 2);
        assert!(v7 == *0x1::vector::borrow<0x2::object::ID>(v3, 3), 2);
        apply_like(arg0, v0, arg7);
        let v8 = v2 / 2;
        0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::fund_blob(arg0, 0x2::coin::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg6, v8, arg7));
        let v9 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg5);
        let v10 = 0x1::vector::empty<0x2::object::ID>();
        if (v9 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg1))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v10, v4);
        };
        if (v9 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg2))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v10, v5);
        };
        if (v9 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg3))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v10, v6);
        };
        if (v9 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg4))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v10, v7);
        };
        distribute_tips(v1, arg6, v2 - v8, v10, v0, 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>()))), arg7);
        emit_like_event(v1, v0, 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::likes(arg0), 0x2::tx_context::epoch(arg7));
    }

    entry fun like_with_5_parents(arg0: &mut 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg1: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg2: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg3: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg4: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg5: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg6: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg7: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg0);
        let v2 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg7);
        assert!(v2 >= 2000, 3);
        let v3 = 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::parent_hierarchy(arg0);
        assert!(0x1::vector::length<0x2::object::ID>(v3) == 5, 1);
        let v4 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg1);
        let v5 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg2);
        let v6 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg3);
        let v7 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg4);
        let v8 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg5);
        assert!(v4 == *0x1::vector::borrow<0x2::object::ID>(v3, 0), 2);
        assert!(v5 == *0x1::vector::borrow<0x2::object::ID>(v3, 1), 2);
        assert!(v6 == *0x1::vector::borrow<0x2::object::ID>(v3, 2), 2);
        assert!(v7 == *0x1::vector::borrow<0x2::object::ID>(v3, 3), 2);
        assert!(v8 == *0x1::vector::borrow<0x2::object::ID>(v3, 4), 2);
        apply_like(arg0, v0, arg8);
        let v9 = v2 / 2;
        0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::fund_blob(arg0, 0x2::coin::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg7, v9, arg8));
        let v10 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg6);
        let v11 = 0x1::vector::empty<0x2::object::ID>();
        if (v10 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg1))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v11, v4);
        };
        if (v10 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg2))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v11, v5);
        };
        if (v10 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg3))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v11, v6);
        };
        if (v10 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg4))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v11, v7);
        };
        if (v10 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg5))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v11, v8);
        };
        distribute_tips(v1, arg7, v2 - v9, v11, v0, 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>()))), arg8);
        emit_like_event(v1, v0, 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::likes(arg0), 0x2::tx_context::epoch(arg8));
    }

    entry fun like_with_6_parents(arg0: &mut 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg1: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg2: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg3: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg4: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg5: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg6: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg7: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg8: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg0);
        let v2 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg8);
        assert!(v2 >= 2000, 3);
        let v3 = 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::parent_hierarchy(arg0);
        assert!(0x1::vector::length<0x2::object::ID>(v3) == 6, 1);
        let v4 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg1);
        let v5 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg2);
        let v6 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg3);
        let v7 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg4);
        let v8 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg5);
        let v9 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg6);
        assert!(v4 == *0x1::vector::borrow<0x2::object::ID>(v3, 0), 2);
        assert!(v5 == *0x1::vector::borrow<0x2::object::ID>(v3, 1), 2);
        assert!(v6 == *0x1::vector::borrow<0x2::object::ID>(v3, 2), 2);
        assert!(v7 == *0x1::vector::borrow<0x2::object::ID>(v3, 3), 2);
        assert!(v8 == *0x1::vector::borrow<0x2::object::ID>(v3, 4), 2);
        assert!(v9 == *0x1::vector::borrow<0x2::object::ID>(v3, 5), 2);
        apply_like(arg0, v0, arg9);
        let v10 = v2 / 2;
        0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::fund_blob(arg0, 0x2::coin::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg8, v10, arg9));
        let v11 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg7);
        let v12 = 0x1::vector::empty<0x2::object::ID>();
        if (v11 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg1))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v12, v4);
        };
        if (v11 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg2))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v12, v5);
        };
        if (v11 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg3))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v12, v6);
        };
        if (v11 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg4))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v12, v7);
        };
        if (v11 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg5))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v12, v8);
        };
        if (v11 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg6))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v12, v9);
        };
        distribute_tips(v1, arg8, v2 - v10, v12, v0, 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>()))), arg9);
        emit_like_event(v1, v0, 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::likes(arg0), 0x2::tx_context::epoch(arg9));
    }

    entry fun like_with_7_parents(arg0: &mut 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg1: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg2: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg3: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg4: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg5: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg6: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg7: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg8: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg9: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg0);
        let v2 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg9);
        assert!(v2 >= 2000, 3);
        let v3 = 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::parent_hierarchy(arg0);
        assert!(0x1::vector::length<0x2::object::ID>(v3) == 7, 1);
        let v4 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg1);
        let v5 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg2);
        let v6 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg3);
        let v7 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg4);
        let v8 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg5);
        let v9 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg6);
        let v10 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg7);
        assert!(v4 == *0x1::vector::borrow<0x2::object::ID>(v3, 0), 2);
        assert!(v5 == *0x1::vector::borrow<0x2::object::ID>(v3, 1), 2);
        assert!(v6 == *0x1::vector::borrow<0x2::object::ID>(v3, 2), 2);
        assert!(v7 == *0x1::vector::borrow<0x2::object::ID>(v3, 3), 2);
        assert!(v8 == *0x1::vector::borrow<0x2::object::ID>(v3, 4), 2);
        assert!(v9 == *0x1::vector::borrow<0x2::object::ID>(v3, 5), 2);
        assert!(v10 == *0x1::vector::borrow<0x2::object::ID>(v3, 6), 2);
        apply_like(arg0, v0, arg10);
        let v11 = v2 / 2;
        0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::fund_blob(arg0, 0x2::coin::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg9, v11, arg10));
        let v12 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg8);
        let v13 = 0x1::vector::empty<0x2::object::ID>();
        if (v12 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg1))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v13, v4);
        };
        if (v12 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg2))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v13, v5);
        };
        if (v12 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg3))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v13, v6);
        };
        if (v12 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg4))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v13, v7);
        };
        if (v12 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg5))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v13, v8);
        };
        if (v12 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg6))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v13, v9);
        };
        if (v12 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg7))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v13, v10);
        };
        distribute_tips(v1, arg9, v2 - v11, v13, v0, 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>()))), arg10);
        emit_like_event(v1, v0, 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::likes(arg0), 0x2::tx_context::epoch(arg10));
    }

    entry fun like_with_8_parents(arg0: &mut 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg1: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg2: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg3: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg4: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg5: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg6: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg7: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg8: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg9: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg10: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg0);
        let v2 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg10);
        assert!(v2 >= 2000, 3);
        let v3 = 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::parent_hierarchy(arg0);
        assert!(0x1::vector::length<0x2::object::ID>(v3) == 8, 1);
        let v4 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg1);
        let v5 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg2);
        let v6 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg3);
        let v7 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg4);
        let v8 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg5);
        let v9 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg6);
        let v10 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg7);
        let v11 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg8);
        assert!(v4 == *0x1::vector::borrow<0x2::object::ID>(v3, 0), 2);
        assert!(v5 == *0x1::vector::borrow<0x2::object::ID>(v3, 1), 2);
        assert!(v6 == *0x1::vector::borrow<0x2::object::ID>(v3, 2), 2);
        assert!(v7 == *0x1::vector::borrow<0x2::object::ID>(v3, 3), 2);
        assert!(v8 == *0x1::vector::borrow<0x2::object::ID>(v3, 4), 2);
        assert!(v9 == *0x1::vector::borrow<0x2::object::ID>(v3, 5), 2);
        assert!(v10 == *0x1::vector::borrow<0x2::object::ID>(v3, 6), 2);
        assert!(v11 == *0x1::vector::borrow<0x2::object::ID>(v3, 7), 2);
        apply_like(arg0, v0, arg11);
        let v12 = v2 / 2;
        0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::fund_blob(arg0, 0x2::coin::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg10, v12, arg11));
        let v13 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg9);
        let v14 = 0x1::vector::empty<0x2::object::ID>();
        if (v13 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg1))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v14, v4);
        };
        if (v13 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg2))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v14, v5);
        };
        if (v13 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg3))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v14, v6);
        };
        if (v13 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg4))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v14, v7);
        };
        if (v13 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg5))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v14, v8);
        };
        if (v13 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg6))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v14, v9);
        };
        if (v13 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg7))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v14, v10);
        };
        if (v13 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg8))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v14, v11);
        };
        distribute_tips(v1, arg10, v2 - v12, v14, v0, 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>()))), arg11);
        emit_like_event(v1, v0, 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::likes(arg0), 0x2::tx_context::epoch(arg11));
    }

    entry fun like_with_9_parents(arg0: &mut 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg1: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg2: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg3: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg4: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg5: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg6: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg7: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg8: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg9: &0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT, arg10: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg11: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg12);
        let v1 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg0);
        let v2 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg11);
        assert!(v2 >= 2000, 3);
        let v3 = 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::parent_hierarchy(arg0);
        assert!(0x1::vector::length<0x2::object::ID>(v3) == 9, 1);
        let v4 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg1);
        let v5 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg2);
        let v6 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg3);
        let v7 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg4);
        let v8 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg5);
        let v9 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg6);
        let v10 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg7);
        let v11 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg8);
        let v12 = 0x2::object::id<0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::MemeNFT>(arg9);
        assert!(v4 == *0x1::vector::borrow<0x2::object::ID>(v3, 0), 2);
        assert!(v5 == *0x1::vector::borrow<0x2::object::ID>(v3, 1), 2);
        assert!(v6 == *0x1::vector::borrow<0x2::object::ID>(v3, 2), 2);
        assert!(v7 == *0x1::vector::borrow<0x2::object::ID>(v3, 3), 2);
        assert!(v8 == *0x1::vector::borrow<0x2::object::ID>(v3, 4), 2);
        assert!(v9 == *0x1::vector::borrow<0x2::object::ID>(v3, 5), 2);
        assert!(v10 == *0x1::vector::borrow<0x2::object::ID>(v3, 6), 2);
        assert!(v11 == *0x1::vector::borrow<0x2::object::ID>(v3, 7), 2);
        assert!(v12 == *0x1::vector::borrow<0x2::object::ID>(v3, 8), 2);
        apply_like(arg0, v0, arg12);
        let v13 = v2 / 2;
        0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::fund_blob(arg0, 0x2::coin::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg11, v13, arg12));
        let v14 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg10);
        let v15 = 0x1::vector::empty<0x2::object::ID>();
        if (v14 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg1))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v15, v4);
        };
        if (v14 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg2))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v15, v5);
        };
        if (v14 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg3))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v15, v6);
        };
        if (v14 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg4))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v15, v7);
        };
        if (v14 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg5))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v15, v8);
        };
        if (v14 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg6))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v15, v9);
        };
        if (v14 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg7))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v15, v10);
        };
        if (v14 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg8))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v15, v11);
        };
        if (v14 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::blob(arg9))) {
            0x1::vector::push_back<0x2::object::ID>(&mut v15, v12);
        };
        distribute_tips(v1, arg11, v2 - v13, v15, v0, 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>()))), arg12);
        emit_like_event(v1, v0, 0x1bcce3f34604c5135c31335e180bc80e9e8c6cde8b06b3e4ac450937810b05a3::nft::likes(arg0), 0x2::tx_context::epoch(arg12));
    }

    // decompiled from Move bytecode v6
}

