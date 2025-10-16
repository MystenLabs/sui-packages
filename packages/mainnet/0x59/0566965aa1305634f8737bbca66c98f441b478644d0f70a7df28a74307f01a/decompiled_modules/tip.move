module 0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::tip {
    public entry fun withdraw(arg0: &mut 0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::MemeNFT, arg1: &0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::capability::CreatorCap, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::id<0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::MemeNFT>(arg0);
        let v2 = 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>())));
        assert!(0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::capability::verify_creator_cap(arg1, v1), 1);
        let v3 = 0x2::transfer::public_receive<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::get_uid_mut(arg0), arg2);
        let v4 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&v3);
        let v5 = 0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::blob_funds_value(arg0);
        let v6 = v4;
        if (v5 > 0) {
            let v7 = 0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::extract_blob_funds(arg0, v5, arg3);
            0x2::coin::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut v3, v7);
            v6 = v4 + 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&v7);
        };
        if (v4 > 0) {
            0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::meme_events::emit_tip_withdrawn(v1, v0, v4, v2, 0x2::tx_context::epoch(arg3));
        };
        if (v5 > 0) {
            0x1::string::append(&mut v2, 0x1::string::utf8(b"_BLOB_FUNDS"));
            0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::meme_events::emit_tip_withdrawn(v1, v0, v5, v2, 0x2::tx_context::epoch(arg3));
        };
        if (v6 > 0) {
            0x590566965aa1305634f8737bbca66c98f441b478644d0f70a7df28a74307f01a::nft::add_tip_amount(arg0, v6);
        };
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(v3, v0);
        } else {
            0x2::coin::destroy_zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v3);
        };
    }

    // decompiled from Move bytecode v6
}

