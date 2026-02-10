module 0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::ad_payments {
    struct CampaignEscrow has key {
        id: 0x2::object::UID,
        campaign_id: 0x2::object::ID,
        advertiser: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_deposited: u64,
        total_withdrawn: u64,
        locked_until: u64,
        is_finalized: bool,
        paused: bool,
    }

    struct RevenuePool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_collected: u64,
        last_distribution: u64,
        paused: bool,
        creator: address,
        governance_config_id: 0x1::option::Option<0x2::object::ID>,
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

    struct FundsAddedToEscrow has copy, drop {
        escrow_id: 0x2::object::ID,
        amount: u64,
        advertiser: address,
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
        gateway_share: u64,
        foundation_share: u64,
        creator_share: u64,
        pm_pool_share: u64,
        pm_status: u8,
    }

    struct CreatorPMEscrow has key {
        id: 0x2::object::UID,
        dapp_id: vector<u8>,
        creator: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_escrowed: u64,
        resolved: bool,
    }

    struct CreatorEscrowCreated has copy, drop {
        escrow_id: 0x2::object::ID,
        dapp_id: vector<u8>,
        creator: address,
    }

    struct CreatorEscrowResolved has copy, drop {
        escrow_id: 0x2::object::ID,
        dapp_id: vector<u8>,
        pm_passed: bool,
        amount: u64,
        recipient: address,
    }

    struct RevenuePoolPaused has copy, drop {
        pool_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct RevenuePoolUnpaused has copy, drop {
        pool_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    public fun add_funds(arg0: &mut CampaignEscrow, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.advertiser, 1);
        assert!(!arg0.is_finalized, 6);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        arg0.total_deposited = arg0.total_deposited + v0;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = FundsAddedToEscrow{
            escrow_id  : 0x2::object::uid_to_inner(&arg0.id),
            amount     : v0,
            advertiser : arg0.advertiser,
        };
        0x2::event::emit<FundsAddedToEscrow>(v1);
    }

    public fun create_creator_escrow(arg0: vector<u8>, arg1: address, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = CreatorEscrowCreated{
            escrow_id : v1,
            dapp_id   : arg0,
            creator   : arg1,
        };
        0x2::event::emit<CreatorEscrowCreated>(v2);
        let v3 = CreatorPMEscrow{
            id             : v0,
            dapp_id        : arg0,
            creator        : arg1,
            balance        : 0x2::balance::zero<0x2::sui::SUI>(),
            total_escrowed : 0,
            resolved       : false,
        };
        0x2::transfer::share_object<CreatorPMEscrow>(v3);
        v1
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
            paused          : false,
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

    public fun distribute_revenue(arg0: &mut RevenuePool, arg1: &0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::governance::GovernanceConfig, arg2: u64, arg3: u8, arg4: address, arg5: address, arg6: &0x2::clock::Clock, arg7: &AdminCap, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 9);
        assert!(arg3 <= 2, 17);
        assert!(arg3 != 0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::governance::pm_status_failed(), 15);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg2, 3);
        let (v0, v1, v2) = if (arg3 == 0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::governance::pm_status_active()) {
            let _ = 0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::governance::get_pm_gateway_pct(arg1);
            (0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::governance::get_pm_foundation_pct(arg1), 0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::governance::get_pm_creator_pct(arg1), 0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::governance::get_pm_pool_pct(arg1))
        } else {
            let _ = 0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::governance::get_post_gateway_pct(arg1);
            (0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::governance::get_post_foundation_pct(arg1), 0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::governance::get_post_creator_pct(arg1), 0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::governance::get_post_pm_pct(arg1))
        };
        let v4 = arg2 * v0 / 100;
        let v5 = arg2 * v1 / 100;
        let v6 = arg2 * v2 / 100;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v4), arg8), arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v5), arg8), arg0.creator);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg2 - v4 - v5 - v6), arg8), arg0.creator);
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v6), arg8), arg5);
        };
        arg0.last_distribution = 0x2::clock::timestamp_ms(arg6);
        let v7 = RevenueDistributed{
            pool_id          : 0x2::object::uid_to_inner(&arg0.id),
            creator_share    : v5,
            pm_share         : v6,
            foundation_share : v4,
        };
        0x2::event::emit<RevenueDistributed>(v7);
    }

    public entry fun distribute_revenue_entry(arg0: &mut RevenuePool, arg1: &0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::governance::GovernanceConfig, arg2: u64, arg3: u8, arg4: address, arg5: address, arg6: &0x2::clock::Clock, arg7: &AdminCap, arg8: &mut 0x2::tx_context::TxContext) {
        distribute_revenue(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun finalize_escrow(arg0: &mut CampaignEscrow, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_finalized, 6);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance), arg2), arg0.advertiser);
        };
        let v1 = EscrowRefunded{
            escrow_id  : 0x2::object::uid_to_inner(&arg0.id),
            advertiser : arg0.advertiser,
            amount     : v0,
        };
        0x2::event::emit<EscrowRefunded>(v1);
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
            id                   : 0x2::object::new(arg0),
            balance              : 0x2::balance::zero<0x2::sui::SUI>(),
            total_collected      : 0,
            last_distribution    : 0,
            paused               : false,
            creator              : 0x2::tx_context::sender(arg0),
            governance_config_id : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::share_object<RevenuePool>(v1);
    }

    public fun is_escrow_paused(arg0: &CampaignEscrow) : bool {
        arg0.paused
    }

    public fun is_finalized(arg0: &CampaignEscrow) : bool {
        arg0.is_finalized
    }

    public fun is_paused(arg0: &RevenuePool) : bool {
        arg0.paused
    }

    public fun is_unlocked(arg0: &CampaignEscrow, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.locked_until
    }

    public fun pause_escrow(arg0: &mut CampaignEscrow, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.advertiser, 1);
        assert!(!arg0.is_finalized, 6);
        arg0.paused = true;
    }

    public fun pause_revenue_pool(arg0: &mut RevenuePool, arg1: &AdminCap, arg2: &0x2::clock::Clock) {
        arg0.paused = true;
        let v0 = RevenuePoolPaused{
            pool_id      : 0x2::object::id<RevenuePool>(arg0),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<RevenuePoolPaused>(v0);
    }

    public fun refund_escrow(arg0: &mut CampaignEscrow, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.advertiser, 1);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.locked_until, 2);
        assert!(!arg0.is_finalized, 6);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance), arg2), arg0.advertiser);
        };
        let v1 = EscrowRefunded{
            escrow_id  : 0x2::object::uid_to_inner(&arg0.id),
            advertiser : arg0.advertiser,
            amount     : v0,
        };
        0x2::event::emit<EscrowRefunded>(v1);
        arg0.is_finalized = true;
    }

    public fun resolve_escrow_failure(arg0: &mut CreatorPMEscrow, arg1: address, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.resolved, 16);
        arg0.resolved = true;
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance), arg3), arg1);
        };
        let v1 = CreatorEscrowResolved{
            escrow_id : 0x2::object::id<CreatorPMEscrow>(arg0),
            dapp_id   : arg0.dapp_id,
            pm_passed : false,
            amount    : v0,
            recipient : arg1,
        };
        0x2::event::emit<CreatorEscrowResolved>(v1);
    }

    public fun resolve_escrow_success(arg0: &mut CreatorPMEscrow, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.resolved, 16);
        arg0.resolved = true;
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance), arg2), arg0.creator);
        };
        let v1 = CreatorEscrowResolved{
            escrow_id : 0x2::object::id<CreatorPMEscrow>(arg0),
            dapp_id   : arg0.dapp_id,
            pm_passed : true,
            amount    : v0,
            recipient : arg0.creator,
        };
        0x2::event::emit<CreatorEscrowResolved>(v1);
    }

    public fun set_governance_config(arg0: &mut RevenuePool, arg1: &0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::governance::GovernanceConfig, arg2: &AdminCap) {
        arg0.governance_config_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::governance::GovernanceConfig>(arg1));
    }

    public fun unpause_escrow(arg0: &mut CampaignEscrow, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.advertiser, 1);
        arg0.paused = false;
    }

    public fun unpause_revenue_pool(arg0: &mut RevenuePool, arg1: &AdminCap, arg2: &0x2::clock::Clock) {
        arg0.paused = false;
        let v0 = RevenuePoolUnpaused{
            pool_id      : 0x2::object::id<RevenuePool>(arg0),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<RevenuePoolUnpaused>(v0);
    }

    public fun walrus_drawdown(arg0: &mut RevenuePool, arg1: &0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::governance::GovernanceConfig, arg2: &mut CreatorPMEscrow, arg3: vector<vector<u8>>, arg4: vector<vector<vector<u8>>>, arg5: vector<vector<u8>>, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: u64, arg10: u8, arg11: address, arg12: address, arg13: address, arg14: address, arg15: u64, arg16: &0x2::clock::Clock, arg17: &AdminCap, arg18: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 9);
        assert!(arg10 <= 2, 17);
        assert!(arg10 != 0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::governance::pm_status_failed(), 15);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg15, 3);
        assert!(arg15 >= 100000, 13);
        assert!(arg15 > 0, 5);
        assert!(0x1::vector::length<vector<u8>>(&arg3) <= 100, 10);
        assert!(0x1::vector::length<u8>(&arg6) <= 64, 11);
        assert!(0x1::vector::length<vector<u8>>(&arg3) > 0, 7);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg6)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg6, v1));
            v1 = v1 + 1;
        };
        let v2 = 0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::merkle_verifier::create_merkle_root(v0, arg7, arg8, arg9);
        assert!(0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::merkle_verifier::verify_batch_ad_views(&v2, arg3, arg4, arg5), 8);
        let (v3, v4, v5) = if (arg10 == 0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::governance::pm_status_active()) {
            let _ = 0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::governance::get_pm_gateway_pct(arg1);
            (0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::governance::get_pm_foundation_pct(arg1), 0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::governance::get_pm_creator_pct(arg1), 0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::governance::get_pm_pool_pct(arg1))
        } else {
            let _ = 0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::governance::get_post_gateway_pct(arg1);
            (0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::governance::get_post_foundation_pct(arg1), 0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::governance::get_post_creator_pct(arg1), 0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::governance::get_post_pm_pct(arg1))
        };
        let v7 = arg15 * v3 / 100;
        let v8 = arg15 * v4 / 100;
        let v9 = arg15 * v5 / 100;
        let v10 = arg15 - v7 - v8 - v9;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v10), arg18), arg14);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v7), arg18), arg13);
        if (arg10 == 0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::governance::pm_status_active()) {
            if (v8 > 0) {
                0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v8));
                arg2.total_escrowed = arg2.total_escrowed + v8;
            };
        } else if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v8), arg18), arg12);
        };
        if (v9 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v9), arg18), arg11);
        };
        arg0.last_distribution = 0x2::clock::timestamp_ms(arg16);
        let v11 = WalrusDrawdown{
            pool_id          : 0x2::object::uid_to_inner(&arg0.id),
            walrus_provider  : arg14,
            content_id       : arg6,
            amount           : arg15,
            gateway_share    : v10,
            foundation_share : v7,
            creator_share    : v8,
            pm_pool_share    : v9,
            pm_status        : arg10,
        };
        0x2::event::emit<WalrusDrawdown>(v11);
    }

    public entry fun walrus_drawdown_entry(arg0: &mut RevenuePool, arg1: &0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::governance::GovernanceConfig, arg2: &mut CreatorPMEscrow, arg3: vector<vector<u8>>, arg4: vector<vector<vector<u8>>>, arg5: vector<vector<u8>>, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: u64, arg10: u8, arg11: address, arg12: address, arg13: address, arg14: address, arg15: u64, arg16: &0x2::clock::Clock, arg17: &AdminCap, arg18: &mut 0x2::tx_context::TxContext) {
        walrus_drawdown(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
    }

    public fun withdraw_for_impression(arg0: &mut CampaignEscrow, arg1: u64, arg2: &mut RevenuePool, arg3: vector<vector<u8>>, arg4: vector<vector<vector<u8>>>, arg5: vector<vector<u8>>, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: u64, arg10: &AdminCap) : bool {
        assert!(!arg2.paused, 9);
        assert!(!arg0.paused, 14);
        if (arg0.is_finalized) {
            return false
        };
        assert!(arg1 >= 100000, 12);
        assert!(arg1 > 0, 5);
        let v0 = 0x1::vector::length<vector<u8>>(&arg3);
        assert!(v0 <= 100, 10);
        assert!(v0 > 0, 7);
        assert!(0x1::vector::length<u8>(&arg6) <= 64, 11);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&arg6)) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&arg6, v2));
            v2 = v2 + 1;
        };
        let v3 = 0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::merkle_verifier::create_merkle_root(v1, arg7, arg8, arg9);
        assert!(0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::merkle_verifier::verify_batch_ad_views(&v3, arg3, arg4, arg5), 8);
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.balance) < arg1) {
            return false
        };
        arg0.total_withdrawn = arg0.total_withdrawn + arg1;
        arg2.total_collected = arg2.total_collected + arg1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1));
        let v4 = FundsWithdrawn{
            escrow_id : 0x2::object::uid_to_inner(&arg0.id),
            amount    : arg1,
            remaining : 0x2::balance::value<0x2::sui::SUI>(&arg0.balance),
        };
        0x2::event::emit<FundsWithdrawn>(v4);
        let v5 = TransferredToPool{
            escrow_id : 0x2::object::uid_to_inner(&arg0.id),
            pool_id   : 0x2::object::uid_to_inner(&arg2.id),
            amount    : arg1,
        };
        0x2::event::emit<TransferredToPool>(v5);
        true
    }

    // decompiled from Move bytecode v6
}

