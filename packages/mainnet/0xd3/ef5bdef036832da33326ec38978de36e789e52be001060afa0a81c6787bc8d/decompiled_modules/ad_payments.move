module 0xd3ef5bdef036832da33326ec38978de36e789e52be001060afa0a81c6787bc8d::ad_payments {
    struct CampaignEscrow has key {
        id: 0x2::object::UID,
        campaign_id: 0x2::object::ID,
        advertiser: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_deposited: u64,
        total_withdrawn: u64,
        locked_until: u64,
        is_finalized: bool,
    }

    struct RevenuePool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_collected: u64,
        last_distribution: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct EscrowCreated has copy, drop {
        escrow_id: 0x2::object::ID,
        campaign_id: 0x2::object::ID,
        advertiser: address,
        amount: u64,
        locked_until: u64,
    }

    struct FundsWithdrawn has copy, drop {
        escrow_id: 0x2::object::ID,
        amount: u64,
        remaining: u64,
    }

    struct EscrowRefunded has copy, drop {
        escrow_id: 0x2::object::ID,
        advertiser: address,
        amount: u64,
    }

    struct TransferredToPool has copy, drop {
        escrow_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct RevenueDistributed has copy, drop {
        pool_id: 0x2::object::ID,
        creator_share: u64,
        pm_share: u64,
        foundation_share: u64,
    }

    struct WalrusDrawdown has copy, drop {
        pool_id: 0x2::object::ID,
        walrus_provider: address,
        content_id: vector<u8>,
        amount: u64,
        walrus_share: u64,
        foundation_share: u64,
        pm_or_creator_share: u64,
        recipient: address,
        pm_active: bool,
    }

    public fun add_funds(arg0: &mut CampaignEscrow, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.advertiser, 1);
        assert!(!arg0.is_finalized, 6);
        arg0.total_deposited = arg0.total_deposited + 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun create_escrow(arg0: 0x2::object::ID, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 5);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::clock::timestamp_ms(arg3) + arg2;
        let v3 = 0x2::object::new(arg4);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = CampaignEscrow{
            id              : v3,
            campaign_id     : arg0,
            advertiser      : v1,
            balance         : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            total_deposited : v0,
            total_withdrawn : 0,
            locked_until    : v2,
            is_finalized    : false,
        };
        let v6 = EscrowCreated{
            escrow_id    : v4,
            campaign_id  : arg0,
            advertiser   : v1,
            amount       : v0,
            locked_until : v2,
        };
        0x2::event::emit<EscrowCreated>(v6);
        0x2::transfer::share_object<CampaignEscrow>(v5);
        v4
    }

    public fun distribute_revenue(arg0: &mut RevenuePool, arg1: address, arg2: address, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &AdminCap, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg4, 3);
        let v0 = arg4 * 50 / 100;
        let v1 = arg4 * 30 / 100;
        let v2 = arg4 - v0 - v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v0), arg7), arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v1), arg7), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v2), arg7), arg3);
        arg0.last_distribution = 0x2::clock::timestamp_ms(arg5);
        let v3 = RevenueDistributed{
            pool_id          : 0x2::object::uid_to_inner(&arg0.id),
            creator_share    : v0,
            pm_share         : v2,
            foundation_share : v1,
        };
        0x2::event::emit<RevenueDistributed>(v3);
    }

    public entry fun distribute_revenue_entry(arg0: &mut RevenuePool, arg1: address, arg2: address, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &AdminCap, arg7: &mut 0x2::tx_context::TxContext) {
        distribute_revenue(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun finalize_escrow(arg0: &mut CampaignEscrow, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_finalized, 6);
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.balance) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance), arg2), arg0.advertiser);
        };
        arg0.is_finalized = true;
    }

    public fun get_advertiser(arg0: &CampaignEscrow) : address {
        arg0.advertiser
    }

    public fun get_balance(arg0: &CampaignEscrow) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_campaign_id(arg0: &CampaignEscrow) : 0x2::object::ID {
        arg0.campaign_id
    }

    public fun get_pool_balance(arg0: &RevenuePool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_total_collected(arg0: &RevenuePool) : u64 {
        arg0.total_collected
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = RevenuePool{
            id                : 0x2::object::new(arg0),
            balance           : 0x2::balance::zero<0x2::sui::SUI>(),
            total_collected   : 0,
            last_distribution : 0,
        };
        0x2::transfer::share_object<RevenuePool>(v1);
    }

    public fun is_finalized(arg0: &CampaignEscrow) : bool {
        arg0.is_finalized
    }

    public fun is_unlocked(arg0: &CampaignEscrow, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.locked_until
    }

    public fun refund_escrow(arg0: &mut CampaignEscrow, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.advertiser, 1);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.locked_until, 2);
        assert!(!arg0.is_finalized, 6);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance), arg2), arg0.advertiser);
            let v1 = EscrowRefunded{
                escrow_id  : 0x2::object::uid_to_inner(&arg0.id),
                advertiser : arg0.advertiser,
                amount     : v0,
            };
            0x2::event::emit<EscrowRefunded>(v1);
        };
        arg0.is_finalized = true;
    }

    public fun walrus_drawdown(arg0: &mut RevenuePool, arg1: vector<vector<u8>>, arg2: vector<u8>, arg3: bool, arg4: address, arg5: address, arg6: address, arg7: address, arg8: u64, arg9: &0x2::clock::Clock, arg10: &AdminCap, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg8, 3);
        assert!(arg8 > 0, 5);
        let v0 = 0x1::vector::length<vector<u8>>(&arg1);
        assert!(v0 > 0, 7);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<vector<u8>>(&arg1, v1);
            assert!(0x1::vector::length<u8>(&v2) > 0, 7);
            v1 = v1 + 1;
        };
        let v3 = arg8 * 10 / 100;
        let v4 = arg8 - v3;
        let v5 = v4 * 10 / 100;
        let v6 = v4 - v5;
        let v7 = if (arg3) {
            arg4
        } else {
            arg5
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v3), arg11), arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v5), arg11), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v6), arg11), v7);
        arg0.last_distribution = 0x2::clock::timestamp_ms(arg9);
        let v8 = WalrusDrawdown{
            pool_id             : 0x2::object::uid_to_inner(&arg0.id),
            walrus_provider     : arg7,
            content_id          : arg2,
            amount              : arg8,
            walrus_share        : v3,
            foundation_share    : v5,
            pm_or_creator_share : v6,
            recipient           : v7,
            pm_active           : arg3,
        };
        0x2::event::emit<WalrusDrawdown>(v8);
    }

    public entry fun walrus_drawdown_entry(arg0: &mut RevenuePool, arg1: vector<vector<u8>>, arg2: vector<u8>, arg3: bool, arg4: address, arg5: address, arg6: address, arg7: address, arg8: u64, arg9: &0x2::clock::Clock, arg10: &AdminCap, arg11: &mut 0x2::tx_context::TxContext) {
        walrus_drawdown(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun withdraw_for_impression(arg0: &mut CampaignEscrow, arg1: u64, arg2: &mut RevenuePool, arg3: &AdminCap) : bool {
        if (arg0.is_finalized) {
            return false
        };
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.balance) < arg1) {
            return false
        };
        arg0.total_withdrawn = arg0.total_withdrawn + arg1;
        arg2.total_collected = arg2.total_collected + arg1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1));
        let v0 = FundsWithdrawn{
            escrow_id : 0x2::object::uid_to_inner(&arg0.id),
            amount    : arg1,
            remaining : 0x2::balance::value<0x2::sui::SUI>(&arg0.balance),
        };
        0x2::event::emit<FundsWithdrawn>(v0);
        let v1 = TransferredToPool{
            escrow_id : 0x2::object::uid_to_inner(&arg0.id),
            pool_id   : 0x2::object::uid_to_inner(&arg2.id),
            amount    : arg1,
        };
        0x2::event::emit<TransferredToPool>(v1);
        true
    }

    // decompiled from Move bytecode v6
}

