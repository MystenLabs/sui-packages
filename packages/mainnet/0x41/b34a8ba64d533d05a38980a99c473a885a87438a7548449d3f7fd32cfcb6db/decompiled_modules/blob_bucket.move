module 0x41b34a8ba64d533d05a38980a99c473a885a87438a7548449d3f7fd32cfcb6db::blob_bucket {
    struct ForeignAddress has copy, drop, store {
        chain: u8,
        addr: vector<u8>,
    }

    struct BlobBucket has key {
        id: 0x2::object::UID,
        owner: ForeignAddress,
        wal: 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>,
        pool: 0x1::option::Option<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_pool::StoragePool>,
    }

    public fun addr(arg0: &ForeignAddress) : vector<u8> {
        arg0.addr
    }

    public fun bucket_address(arg0: &BlobBucket) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun certify_blob(arg0: &mut BlobBucket, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: u256, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>) {
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::certify_pooled_blob(arg1, 0x1::option::borrow_mut<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_pool::StoragePool>(&mut arg0.pool), arg2, arg3, arg4, arg5);
    }

    public fun chain(arg0: &ForeignAddress) : u8 {
        arg0.chain
    }

    public fun create(arg0: u8, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg0 == 1 || arg0 == 2, 6);
        let v0 = ForeignAddress{
            chain : arg0,
            addr  : arg1,
        };
        let v1 = BlobBucket{
            id    : 0x2::object::new(arg2),
            owner : v0,
            wal   : 0x2::balance::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(),
            pool  : 0x1::option::none<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_pool::StoragePool>(),
        };
        0x2::transfer::share_object<BlobBucket>(v1);
        0x2::object::id<BlobBucket>(&v1)
    }

    public fun credit<T0>(arg0: &mut BlobBucket, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, T0>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, T0>(arg2, 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1), arg3, arg4, arg5, arg6);
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.wal, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v0));
        (v1, v2)
    }

    public fun credit_and_return_change<T0>(arg0: &mut BlobBucket, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL, T0>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = credit<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v1, 0x2::tx_context::sender(arg6));
    }

    public fun fund_wal(arg0: &mut BlobBucket, arg1: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>) {
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.wal, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg1));
    }

    public fun has_blob(arg0: &BlobBucket, arg1: u256) : bool {
        0x1::option::is_some<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_pool::StoragePool>(&arg0.pool) && 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_pool::contains_blob(0x1::option::borrow<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_pool::StoragePool>(&arg0.pool), arg1)
    }

    public fun owner(arg0: &BlobBucket) : &ForeignAddress {
        &arg0.owner
    }

    public fun register_blob(arg0: &mut BlobBucket, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(arg2);
        let v1 = 0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        let v2 = 0x2::bcs::peel_u8(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        assert!(0x2::bcs::peel_vec_u8(&mut v0) == b"XCHAIN_WALRUS_V1", 8);
        assert!(0x2::bcs::peel_address(&mut v0) == 0x2::object::uid_to_address(&arg0.id), 3);
        assert!(0x2::bcs::peel_u8(&mut v0) == 1, 4);
        assert!(0x2::bcs::peel_u64(&mut v0) > 0x2::clock::timestamp_ms(arg4), 2);
        assert!(verify_owner(&arg0.owner, &arg2, &arg3), 0);
        let v3 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::encoding::encoded_blob_length(v1, v2, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::n_shards(arg1));
        let v4 = 0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::balance::withdraw_all<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.wal), arg5);
        if (0x1::option::is_none<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_pool::StoragePool>(&arg0.pool)) {
            0x1::option::fill<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_pool::StoragePool>(&mut arg0.pool, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::create_storage_pool(arg1, v3, 0x2::bcs::peel_u32(&mut v0), &mut v4, arg5));
        } else {
            let v5 = 0x1::option::borrow_mut<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_pool::StoragePool>(&mut arg0.pool);
            let v6 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_pool::available_encoded_bytes(v5);
            if (v6 < v3) {
                0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::increase_storage_pool_capacity(arg1, v5, v3 - v6, &mut v4);
            };
            let v7 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_pool::end_epoch(v5);
            let v8 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg1) + 0x2::bcs::peel_u32(&mut v0);
            if (v8 > v7) {
                0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::extend_storage_pool(arg1, v5, v8 - v7, &mut v4);
            };
        };
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::register_pooled_blob(arg1, 0x1::option::borrow_mut<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_pool::StoragePool>(&mut arg0.pool), 0x2::bcs::peel_u256(&mut v0), 0x2::bcs::peel_u256(&mut v0), v1, v2, 0x2::bcs::peel_bool(&mut v0), &mut v4, arg5);
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.wal, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v4));
    }

    fun slice(arg0: &vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = b"";
        while (arg1 < arg2) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    fun verify_owner(arg0: &ForeignAddress, arg1: &vector<u8>, arg2: &vector<u8>) : bool {
        if (arg0.chain == 1) {
            let v1 = 0x2::ecdsa_k1::secp256k1_ecrecover(arg2, arg1, 0);
            let v2 = 0x2::ecdsa_k1::decompress_pubkey(&v1);
            let v3 = slice(&v2, 1, 65);
            let v4 = 0x2::hash::keccak256(&v3);
            slice(&v4, 12, 32) == arg0.addr
        } else {
            arg0.chain == 2 && 0x2::ed25519::ed25519_verify(arg2, &arg0.addr, arg1)
        }
    }

    public fun wal_balance(arg0: &BlobBucket) : u64 {
        0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.wal)
    }

    // decompiled from Move bytecode v7
}

