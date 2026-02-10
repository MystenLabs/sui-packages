module 0x96c3394544fca6ecca6142fb5d6e9b7276d8084566c34ebfa0c22cbd72bfe877::dapp_posting {
    struct PostingTreasuryConfig has key {
        id: 0x2::object::UID,
        pm_pool_address: address,
        foundation_address: address,
    }

    struct PostingFeePool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_collected: u64,
    }

    struct PostingAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DappPosted has copy, drop {
        dapp_id: vector<u8>,
        name: vector<u8>,
        description: vector<u8>,
        owner: address,
        permlink: vector<u8>,
        version: vector<u8>,
        manifest: vector<u8>,
        blob_ids: vector<vector<u8>>,
        tags: vector<vector<u8>>,
        category: vector<u8>,
        posting_fee: u64,
        timestamp: u64,
    }

    struct PredictionMarketTriggered has copy, drop {
        dapp_id: vector<u8>,
        posting_fee_contribution: u64,
        triggered_by: address,
    }

    struct PMFeeRecipientUpdated has copy, drop {
        old_pm_pool: address,
        new_pm_pool: address,
    }

    struct DappRecord has drop, store {
        owner: address,
        posted_at_ms: u64,
        muted: bool,
    }

    struct DappRegistry has key {
        id: 0x2::object::UID,
        claimed: 0x2::table::Table<vector<u8>, bool>,
        records: 0x2::table::Table<vector<u8>, DappRecord>,
    }

    struct DappMuteUpdated has copy, drop {
        dapp_id: vector<u8>,
        muted: bool,
        owner: address,
    }

    struct DappMetadataUpdated has copy, drop {
        dapp_id: vector<u8>,
        owner: address,
        name: vector<u8>,
        description: vector<u8>,
        version: vector<u8>,
        manifest: vector<u8>,
        blob_ids: vector<vector<u8>>,
        tags: vector<vector<u8>>,
        category: vector<u8>,
        updated_at_ms: u64,
    }

    public fun get_pool_balance(arg0: &PostingFeePool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_total_collected(arg0: &PostingFeePool) : u64 {
        arg0.total_collected
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PostingAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PostingAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = PostingTreasuryConfig{
            id                 : 0x2::object::new(arg0),
            pm_pool_address    : 0x2::tx_context::sender(arg0),
            foundation_address : @0x875c645ad7ebf67f9a793b374d298394b6848d5b40a13cfa9bd00cab73f45a48,
        };
        0x2::transfer::share_object<PostingTreasuryConfig>(v1);
        let v2 = PostingFeePool{
            id              : 0x2::object::new(arg0),
            balance         : 0x2::balance::zero<0x2::sui::SUI>(),
            total_collected : 0,
        };
        0x2::transfer::share_object<PostingFeePool>(v2);
        let v3 = DappRegistry{
            id      : 0x2::object::new(arg0),
            claimed : 0x2::table::new<vector<u8>, bool>(arg0),
            records : 0x2::table::new<vector<u8>, DappRecord>(arg0),
        };
        0x2::transfer::share_object<DappRegistry>(v3);
    }

    public fun is_muted(arg0: &DappRegistry, arg1: vector<u8>) : bool {
        if (!0x2::table::contains<vector<u8>, DappRecord>(&arg0.records, arg1)) {
            return false
        };
        0x2::table::borrow<vector<u8>, DappRecord>(&arg0.records, arg1).muted
    }

    public fun post_dapp(arg0: &mut DappRegistry, arg1: &mut PostingFeePool, arg2: &PostingTreasuryConfig, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: vector<u8>, arg11: 0x2::coin::Coin<0x2::sui::SUI>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg13);
        let v1 = 0x1::vector::length<u8>(&arg3);
        assert!(v1 > 0, 1);
        assert!(v1 <= 2048, 8);
        let v2 = 0x1::vector::length<u8>(&arg5);
        assert!(v2 > 0, 6);
        assert!(v2 <= 2048, 8);
        assert!(0x1::vector::length<vector<u8>>(&arg8) > 0, 7);
        assert!(0x1::vector::length<vector<u8>>(&arg8) <= 64, 8);
        assert!(0x1::vector::length<u8>(&arg4) <= 2048, 8);
        assert!(0x1::vector::length<u8>(&arg6) <= 2048, 8);
        assert!(0x1::vector::length<u8>(&arg7) <= 8192, 8);
        assert!(0x1::vector::length<vector<u8>>(&arg9) <= 64, 8);
        assert!(0x1::vector::length<u8>(&arg10) <= 2048, 8);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg11);
        assert!(v3 >= 1000000, 3);
        assert!(v3 <= 10000000000, 14);
        let v4 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<address>(&v0));
        0x1::vector::append<u8>(&mut v4, arg5);
        let v5 = 0x2::hash::keccak256(&v4);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.claimed, v5), 9);
        0x2::table::add<vector<u8>, bool>(&mut arg0.claimed, v5, true);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg11));
        arg1.total_collected = arg1.total_collected + v3;
        let v6 = v3 / 2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v6), arg13), arg2.pm_pool_address);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v3 - v6), arg13), arg2.foundation_address);
        let v7 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v7, 0x2::bcs::to_bytes<address>(&v0));
        0x1::vector::append<u8>(&mut v7, arg5);
        let v8 = 0x2::clock::timestamp_ms(arg12);
        0x1::vector::append<u8>(&mut v7, 0x2::bcs::to_bytes<u64>(&v8));
        let v9 = 0x2::hash::keccak256(&v7);
        let v10 = DappRecord{
            owner        : v0,
            posted_at_ms : 0x2::clock::timestamp_ms(arg12),
            muted        : false,
        };
        0x2::table::add<vector<u8>, DappRecord>(&mut arg0.records, v9, v10);
        let v11 = DappPosted{
            dapp_id     : v9,
            name        : arg3,
            description : arg4,
            owner       : v0,
            permlink    : arg5,
            version     : arg6,
            manifest    : arg7,
            blob_ids    : arg8,
            tags        : arg9,
            category    : arg10,
            posting_fee : v3,
            timestamp   : 0x2::clock::timestamp_ms(arg12),
        };
        0x2::event::emit<DappPosted>(v11);
        let v12 = PredictionMarketTriggered{
            dapp_id                  : v9,
            posting_fee_contribution : v3 / 2,
            triggered_by             : v0,
        };
        0x2::event::emit<PredictionMarketTriggered>(v12);
    }

    public fun set_fee_recipients(arg0: &mut PostingTreasuryConfig, arg1: address, arg2: &PostingAdminCap) {
        arg0.pm_pool_address = arg1;
        let v0 = PMFeeRecipientUpdated{
            old_pm_pool : arg0.pm_pool_address,
            new_pm_pool : arg1,
        };
        0x2::event::emit<PMFeeRecipientUpdated>(v0);
    }

    public fun set_muted(arg0: &mut DappRegistry, arg1: vector<u8>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<vector<u8>, DappRecord>(&arg0.records, arg1), 11);
        let v0 = 0x2::table::borrow_mut<vector<u8>, DappRecord>(&mut arg0.records, arg1);
        assert!(v0.owner == 0x2::tx_context::sender(arg3), 12);
        v0.muted = arg2;
        let v1 = DappMuteUpdated{
            dapp_id : arg1,
            muted   : arg2,
            owner   : v0.owner,
        };
        0x2::event::emit<DappMuteUpdated>(v1);
    }

    public fun update_dapp_metadata(arg0: &mut DappRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<vector<u8>>, arg7: vector<vector<u8>>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<vector<u8>, DappRecord>(&arg0.records, arg1), 11);
        let v0 = 0x2::table::borrow<vector<u8>, DappRecord>(&arg0.records, arg1);
        assert!(v0.owner == 0x2::tx_context::sender(arg10), 12);
        assert!(0x2::clock::timestamp_ms(arg9) >= v0.posted_at_ms + 259200000, 13);
        assert!(0x1::vector::length<u8>(&arg2) > 0 && 0x1::vector::length<u8>(&arg2) <= 2048, 1);
        assert!(0x1::vector::length<u8>(&arg3) <= 2048, 8);
        assert!(0x1::vector::length<u8>(&arg4) <= 2048, 8);
        assert!(0x1::vector::length<u8>(&arg5) <= 8192, 8);
        assert!(0x1::vector::length<vector<u8>>(&arg6) > 0 && 0x1::vector::length<vector<u8>>(&arg6) <= 64, 7);
        assert!(0x1::vector::length<vector<u8>>(&arg7) <= 64, 8);
        assert!(0x1::vector::length<u8>(&arg8) <= 2048, 8);
        let v1 = DappMetadataUpdated{
            dapp_id       : arg1,
            owner         : v0.owner,
            name          : arg2,
            description   : arg3,
            version       : arg4,
            manifest      : arg5,
            blob_ids      : arg6,
            tags          : arg7,
            category      : arg8,
            updated_at_ms : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<DappMetadataUpdated>(v1);
    }

    public fun withdraw_posting_fees(arg0: &mut PostingFeePool, arg1: &PostingTreasuryConfig, arg2: u64, arg3: address, arg4: &PostingAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg2, 3);
        assert!(arg3 == arg1.pm_pool_address || arg3 == arg1.foundation_address, 10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg2), arg5), arg3);
    }

    // decompiled from Move bytecode v6
}

