module 0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::like {
    entry fun like(arg0: &mut 0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::MemeNFT, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: u32, arg3: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg4: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::object::id<0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::MemeNFT>(arg0);
        let v2 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg4);
        let v3 = 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>())));
        assert!(v2 >= 1000, 1);
        apply_like(arg0, v0, arg5);
        0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::fund_blob(arg0, arg3);
        0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::extend_blob(arg0, arg1, arg2, arg5);
        let v4 = 0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::parent_hierarchy(arg0);
        let v5 = 0x1::vector::length<0x2::object::ID>(v4);
        if (v5 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(arg4, 0x2::object::id_to_address(&v1));
            0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::meme_events::emit_tip_received(v1, v0, v2, v3, true, 0x2::tx_context::epoch(arg5));
        } else {
            let v6 = if (v5 > 0) {
                v2 / 2 / v5
            } else {
                0
            };
            let v7 = 0;
            let v8 = 0;
            while (v7 < v5) {
                let v9 = *0x1::vector::borrow<0x2::object::ID>(v4, v7);
                if (v6 > 0) {
                    assert!(0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg4) >= v6, 2);
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(0x2::coin::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg4, v6, arg5), 0x2::object::id_to_address(&v9));
                    v8 = v8 + v6;
                    0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::meme_events::emit_tip_received(v9, v0, v6, v3, false, 0x2::tx_context::epoch(arg5));
                };
                v7 = v7 + 1;
            };
            let v10 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(arg4, 0x2::object::id_to_address(&v1));
            0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::meme_events::emit_tip_received(v1, v0, v10, v3, true, 0x2::tx_context::epoch(arg5));
            0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::meme_events::emit_tip_distributed(v1, v2, v10, v5, v6, v3, 0x2::tx_context::epoch(arg5));
        };
        emit_like_event(v1, v0, 0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::likes(arg0), 0x2::tx_context::epoch(arg5));
    }

    fun apply_like(arg0: &mut 0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::MemeNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::is_liked_by(arg0, arg1), 0);
        0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::increment_likes(arg0);
        0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::add_liker(arg0, arg1, arg2);
    }

    public fun can_like(arg0: &0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::MemeNFT, arg1: address) : bool {
        !0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::is_liked_by(arg0, arg1)
    }

    fun emit_like_event(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::meme_events::emit_meme_nft_liked(arg0, arg1, arg2, arg3);
    }

    public fun get_likes_count(arg0: &0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::MemeNFT) : u64 {
        0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::likes(arg0)
    }

    public fun has_liked(arg0: &0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::MemeNFT, arg1: address) : bool {
        0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::is_liked_by(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

