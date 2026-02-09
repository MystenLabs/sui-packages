module 0xdd3ba042c03854131831a0d301960be2d7aba1d9528344610b9fa9bd960cdb2f::dapp_posting {
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

    public fun get_pool_balance(arg0: &PostingFeePool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_total_collected(arg0: &PostingFeePool) : u64 {
        arg0.total_collected
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PostingAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PostingAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = PostingFeePool{
            id              : 0x2::object::new(arg0),
            balance         : 0x2::balance::zero<0x2::sui::SUI>(),
            total_collected : 0,
        };
        0x2::transfer::share_object<PostingFeePool>(v1);
    }

    public fun post_dapp(arg0: &mut PostingFeePool, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<vector<u8>>, arg7: vector<vector<u8>>, arg8: vector<u8>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: address, arg11: address, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg13);
        assert!(0x1::vector::length<u8>(&arg1) > 0, 1);
        assert!(0x1::vector::length<u8>(&arg3) > 0, 6);
        assert!(0x1::vector::length<vector<u8>>(&arg6) > 0, 7);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg9);
        assert!(v1 >= 1000000, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg9, v1 / 2, arg13), arg10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg9, arg11);
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<address>(&v0));
        0x1::vector::append<u8>(&mut v2, arg3);
        let v3 = 0x2::clock::timestamp_ms(arg12);
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<u64>(&v3));
        let v4 = 0x2::hash::keccak256(&v2);
        let v5 = 0x1::vector::empty<u8>();
        let v6 = 0;
        while (v6 < 32 && v6 < 0x1::vector::length<u8>(&v4)) {
            0x1::vector::push_back<u8>(&mut v5, *0x1::vector::borrow<u8>(&v4, v6));
            v6 = v6 + 1;
        };
        while (v6 < 32) {
            0x1::vector::push_back<u8>(&mut v5, 0);
            v6 = v6 + 1;
        };
        let v7 = DappPosted{
            dapp_id     : v5,
            name        : arg1,
            description : arg2,
            owner       : v0,
            permlink    : arg3,
            version     : arg4,
            manifest    : arg5,
            blob_ids    : arg6,
            tags        : arg7,
            category    : arg8,
            posting_fee : v1,
            timestamp   : 0x2::clock::timestamp_ms(arg12),
        };
        0x2::event::emit<DappPosted>(v7);
        let v8 = PredictionMarketTriggered{
            dapp_id                  : v5,
            posting_fee_contribution : v1 / 2,
            triggered_by             : v0,
        };
        0x2::event::emit<PredictionMarketTriggered>(v8);
    }

    public fun withdraw_posting_fees(arg0: &mut PostingFeePool, arg1: u64, arg2: address, arg3: &PostingAdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg1, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), arg4), arg2);
    }

    // decompiled from Move bytecode v6
}

