module 0xe5bda0278568aa03390e8809fe9fadaf21a2b47756c8baa5eb36c7a72677db9a::tip {
    public fun withdraw(arg0: &mut 0xe5bda0278568aa03390e8809fe9fadaf21a2b47756c8baa5eb36c7a72677db9a::nft::MemeNFT, arg1: &0xe5bda0278568aa03390e8809fe9fadaf21a2b47756c8baa5eb36c7a72677db9a::capability::CreatorCap, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::id<0xe5bda0278568aa03390e8809fe9fadaf21a2b47756c8baa5eb36c7a72677db9a::nft::MemeNFT>(arg0);
        assert!(0xe5bda0278568aa03390e8809fe9fadaf21a2b47756c8baa5eb36c7a72677db9a::capability::verify_creator_cap(arg1, v1), 1);
        let v2 = 0x2::transfer::public_receive<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(0xe5bda0278568aa03390e8809fe9fadaf21a2b47756c8baa5eb36c7a72677db9a::nft::get_uid_mut(arg0), arg2);
        let v3 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&v2);
        if (v3 > 0) {
            0xe5bda0278568aa03390e8809fe9fadaf21a2b47756c8baa5eb36c7a72677db9a::meme_events::emit_tip_withdrawn(v1, v0, v3, 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>()))), 0x2::tx_context::epoch(arg3));
            0xe5bda0278568aa03390e8809fe9fadaf21a2b47756c8baa5eb36c7a72677db9a::nft::add_tip_amount(arg0, v3);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(v2, v0);
        } else {
            0x2::coin::destroy_zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v2);
        };
    }

    public fun withdraw_blob_fund(arg0: &mut 0xe5bda0278568aa03390e8809fe9fadaf21a2b47756c8baa5eb36c7a72677db9a::nft::MemeNFT, arg1: &0xe5bda0278568aa03390e8809fe9fadaf21a2b47756c8baa5eb36c7a72677db9a::capability::CreatorCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::object::id<0xe5bda0278568aa03390e8809fe9fadaf21a2b47756c8baa5eb36c7a72677db9a::nft::MemeNFT>(arg0);
        assert!(0xe5bda0278568aa03390e8809fe9fadaf21a2b47756c8baa5eb36c7a72677db9a::capability::verify_creator_cap(arg1, v1), 2);
        let v2 = 0xe5bda0278568aa03390e8809fe9fadaf21a2b47756c8baa5eb36c7a72677db9a::nft::blob_funds_value(arg0);
        assert!(v2 > 0, 2);
        let v3 = 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>())));
        0x1::string::append(&mut v3, 0x1::string::utf8(b"_BLOB_FUNDS"));
        0xe5bda0278568aa03390e8809fe9fadaf21a2b47756c8baa5eb36c7a72677db9a::meme_events::emit_tip_withdrawn(v1, v0, v2, v3, 0x2::tx_context::epoch(arg2));
        0xe5bda0278568aa03390e8809fe9fadaf21a2b47756c8baa5eb36c7a72677db9a::nft::add_tip_amount(arg0, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(0xe5bda0278568aa03390e8809fe9fadaf21a2b47756c8baa5eb36c7a72677db9a::nft::extract_blob_funds(arg0, v2, arg2), v0);
    }

    // decompiled from Move bytecode v6
}

