module 0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::dapp_posting {
    struct PostingTreasuryConfig has key {
        id: 0x2::object::UID,
        pm_pool_address: address,
        foundation_address: address,
        walrus_storage_fund_address: address,
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

    struct CreatorYesBought has copy, drop {
        dapp_id: vector<u8>,
        creator: address,
        amount: u64,
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
            id                          : 0x2::object::new(arg0),
            pm_pool_address             : 0x2::tx_context::sender(arg0),
            foundation_address          : @0x875c645ad7ebf67f9a793b374d298394b6848d5b40a13cfa9bd00cab73f45a48,
            walrus_storage_fund_address : 0x2::tx_context::sender(arg0),
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

    public fun post_dapp(arg0: &mut DappRegistry, arg1: &mut PostingFeePool, arg2: &PostingTreasuryConfig, arg3: &0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::governance::GovernanceConfig, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<vector<u8>>, arg10: vector<u64>, arg11: vector<vector<u8>>, arg12: vector<u8>, arg13: 0x2::coin::Coin<0x2::sui::SUI>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg15);
        let v1 = 0x1::vector::length<u8>(&arg4);
        assert!(v1 > 0, 1);
        assert!(v1 <= 2048, 8);
        let v2 = 0x1::vector::length<u8>(&arg6);
        assert!(v2 > 0, 6);
        assert!(v2 <= 2048, 8);
        assert!(0x1::vector::length<vector<u8>>(&arg9) > 0, 7);
        assert!(0x1::vector::length<vector<u8>>(&arg9) <= 64, 8);
        assert!(0x1::vector::length<u64>(&arg10) == 0x1::vector::length<vector<u8>>(&arg9), 8);
        assert!(0x1::vector::length<u8>(&arg5) <= 2048, 8);
        assert!(0x1::vector::length<u8>(&arg7) <= 2048, 8);
        assert!(0x1::vector::length<u8>(&arg8) <= 8192, 8);
        assert!(0x1::vector::length<vector<u8>>(&arg11) <= 64, 8);
        assert!(0x1::vector::length<u8>(&arg12) <= 2048, 8);
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg10)) {
            v3 = v3 + *0x1::vector::borrow<u64>(&arg10, v4);
            v4 = v4 + 1;
        };
        let v5 = v3 * 10000000 * 730 / 1073741824 * 365;
        let v6 = v5 * 2 + 0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::governance::get_votable_fee(arg3);
        let v7 = if (v6 < 1000000000) {
            1000000000
        } else {
            v6
        };
        let v8 = 0x2::coin::value<0x2::sui::SUI>(&arg13);
        assert!(v8 >= v7, 3);
        assert!(v8 <= 10000000000, 14);
        let v9 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v9, 0x2::bcs::to_bytes<address>(&v0));
        0x1::vector::append<u8>(&mut v9, arg6);
        let v10 = 0x2::hash::keccak256(&v9);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.claimed, v10), 9);
        0x2::table::add<vector<u8>, bool>(&mut arg0.claimed, v10, true);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg13));
        arg1.total_collected = arg1.total_collected + v8;
        let v11 = if (v5 > v8) {
            v8
        } else {
            v5
        };
        let v12 = v8 - v11;
        if (v11 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v11), arg15), arg2.walrus_storage_fund_address);
        };
        let v13 = if (v12 > 0) {
            let v14 = v12 / 2;
            let v15 = v12 - v14;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v14), arg15), arg2.foundation_address);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v15), arg15), arg2.pm_pool_address);
            v15
        } else {
            0
        };
        let v16 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v16, 0x2::bcs::to_bytes<address>(&v0));
        0x1::vector::append<u8>(&mut v16, arg6);
        let v17 = 0x2::clock::timestamp_ms(arg14);
        0x1::vector::append<u8>(&mut v16, 0x2::bcs::to_bytes<u64>(&v17));
        let v18 = 0x2::hash::keccak256(&v16);
        let v19 = DappRecord{
            owner        : v0,
            posted_at_ms : 0x2::clock::timestamp_ms(arg14),
            muted        : false,
        };
        0x2::table::add<vector<u8>, DappRecord>(&mut arg0.records, v18, v19);
        let v20 = DappPosted{
            dapp_id     : v18,
            name        : arg4,
            description : arg5,
            owner       : v0,
            permlink    : arg6,
            version     : arg7,
            manifest    : arg8,
            blob_ids    : arg9,
            tags        : arg11,
            category    : arg12,
            posting_fee : v8,
            timestamp   : 0x2::clock::timestamp_ms(arg14),
        };
        0x2::event::emit<DappPosted>(v20);
        let v21 = PredictionMarketTriggered{
            dapp_id                  : v18,
            posting_fee_contribution : v13,
            triggered_by             : v0,
        };
        0x2::event::emit<PredictionMarketTriggered>(v21);
        let v22 = CreatorYesBought{
            dapp_id : v18,
            creator : v0,
            amount  : v13,
        };
        0x2::event::emit<CreatorYesBought>(v22);
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

    public fun update_dapp_metadata(arg0: &mut DappRegistry, arg1: &0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::governance::GovernanceConfig, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<vector<u8>>, arg8: vector<vector<u8>>, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<vector<u8>, DappRecord>(&arg0.records, arg2), 11);
        let v0 = 0x2::table::borrow<vector<u8>, DappRecord>(&arg0.records, arg2);
        assert!(v0.owner == 0x2::tx_context::sender(arg11), 12);
        let v1 = 0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::governance::get_pm_duration(arg1);
        let v2 = if (v1 > 259200000) {
            v1
        } else {
            259200000
        };
        assert!(0x2::clock::timestamp_ms(arg10) >= v0.posted_at_ms + v2, 13);
        assert!(0x1::vector::length<u8>(&arg3) > 0 && 0x1::vector::length<u8>(&arg3) <= 2048, 1);
        assert!(0x1::vector::length<u8>(&arg4) <= 2048, 8);
        assert!(0x1::vector::length<u8>(&arg5) <= 2048, 8);
        assert!(0x1::vector::length<u8>(&arg6) <= 8192, 8);
        assert!(0x1::vector::length<vector<u8>>(&arg7) > 0 && 0x1::vector::length<vector<u8>>(&arg7) <= 64, 7);
        assert!(0x1::vector::length<vector<u8>>(&arg8) <= 64, 8);
        assert!(0x1::vector::length<u8>(&arg9) <= 2048, 8);
        let v3 = DappMetadataUpdated{
            dapp_id       : arg2,
            owner         : v0.owner,
            name          : arg3,
            description   : arg4,
            version       : arg5,
            manifest      : arg6,
            blob_ids      : arg7,
            tags          : arg8,
            category      : arg9,
            updated_at_ms : 0x2::clock::timestamp_ms(arg10),
        };
        0x2::event::emit<DappMetadataUpdated>(v3);
    }

    public fun withdraw_posting_fees(arg0: &mut PostingFeePool, arg1: &PostingTreasuryConfig, arg2: u64, arg3: address, arg4: &PostingAdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg2, 3);
        assert!(arg3 == arg1.pm_pool_address || arg3 == arg1.foundation_address, 10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg2), arg5), arg3);
    }

    // decompiled from Move bytecode v6
}

