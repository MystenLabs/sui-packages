module 0x420134f4b7d7673ab56b800b1abaaf6e70772dc18006249ca78d5c8cfdb4848e::revenue_pool {
    struct RevenuePool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        operator_fee_bps: u64,
        total_collected: u64,
        operator_share: u64,
        creator_share: u64,
        pending_distribution: u64,
        last_distribution_epoch: u64,
        platform_wallet: address,
    }

    struct UploaderAccount has store, key {
        id: 0x2::object::UID,
        creator: address,
        total_streams: u64,
        total_watch_time: u64,
        weighted_score: u64,
        lifetime_earnings: u64,
        pending_earnings: u64,
        registration_epoch: u64,
        is_active: bool,
    }

    struct UploaderRegistered has copy, drop {
        account_id: 0x2::object::ID,
        creator: address,
        timestamp: u64,
    }

    struct RevenueCollected has copy, drop {
        amount: u64,
        operator_amount: u64,
        creator_amount: u64,
    }

    struct RewardDistributed has copy, drop {
        uploader_id: 0x2::object::ID,
        amount: u64,
        epoch: u64,
    }

    struct EarningsClaimed has copy, drop {
        uploader_id: 0x2::object::ID,
        creator: address,
        amount: u64,
    }

    public fun calculate_uploader_share(arg0: &UploaderAccount, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        arg0.weighted_score * arg2 / arg1
    }

    public entry fun claim_earnings(arg0: &mut RevenuePool, arg1: &mut UploaderAccount, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.creator == 0x2::tx_context::sender(arg2), 103);
        let v0 = arg1.pending_earnings;
        assert!(v0 > 0, 100);
        arg1.pending_earnings = 0;
        let v1 = EarningsClaimed{
            uploader_id : 0x2::object::uid_to_inner(&arg1.id),
            creator     : arg1.creator,
            amount      : v0,
        };
        0x2::event::emit<EarningsClaimed>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v0), arg2), arg1.creator);
    }

    public fun collect_fees(arg0: &mut RevenuePool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = v0 * arg0.operator_fee_bps / 10000;
        let v2 = v0 - v1;
        arg0.total_collected = arg0.total_collected + v0;
        arg0.operator_share = arg0.operator_share + v1;
        arg0.creator_share = arg0.creator_share + v2;
        arg0.pending_distribution = arg0.pending_distribution + v2;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v3 = RevenueCollected{
            amount          : v0,
            operator_amount : v1,
            creator_amount  : v2,
        };
        0x2::event::emit<RevenueCollected>(v3);
    }

    public entry fun distribute_reward(arg0: &mut RevenuePool, arg1: &mut UploaderAccount, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 101);
        assert!(arg2 <= arg0.pending_distribution, 102);
        arg0.pending_distribution = arg0.pending_distribution - arg2;
        arg1.pending_earnings = arg1.pending_earnings + arg2;
        arg1.lifetime_earnings = arg1.lifetime_earnings + arg2;
        arg1.weighted_score = 0;
        arg0.last_distribution_epoch = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v0 = RewardDistributed{
            uploader_id : 0x2::object::uid_to_inner(&arg1.id),
            amount      : arg2,
            epoch       : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<RewardDistributed>(v0);
    }

    fun get_completion_multiplier(arg0: u64) : u64 {
        if (arg0 >= 80) {
            150
        } else if (arg0 >= 50) {
            125
        } else {
            100
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RevenuePool{
            id                      : 0x2::object::new(arg0),
            balance                 : 0x2::balance::zero<0x2::sui::SUI>(),
            operator_fee_bps        : 3000,
            total_collected         : 0,
            operator_share          : 0,
            creator_share           : 0,
            pending_distribution    : 0,
            last_distribution_epoch : 0,
            platform_wallet         : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<RevenuePool>(v0);
    }

    public entry fun register_uploader(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = UploaderAccount{
            id                 : v0,
            creator            : 0x2::tx_context::sender(arg0),
            total_streams      : 0,
            total_watch_time   : 0,
            weighted_score     : 0,
            lifetime_earnings  : 0,
            pending_earnings   : 0,
            registration_epoch : 0x2::tx_context::epoch_timestamp_ms(arg0),
            is_active          : true,
        };
        let v2 = UploaderRegistered{
            account_id : 0x2::object::uid_to_inner(&v0),
            creator    : 0x2::tx_context::sender(arg0),
            timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg0),
        };
        0x2::event::emit<UploaderRegistered>(v2);
        0x2::transfer::transfer<UploaderAccount>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun update_stream_metrics(arg0: &mut RevenuePool, arg1: &mut UploaderAccount, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.creator == 0x2::tx_context::sender(arg4), 103);
        let v0 = if (arg3 > 0) {
            arg2 * 100 / arg3
        } else {
            0
        };
        assert!(v0 <= 100, 104);
        arg1.total_streams = arg1.total_streams + 1;
        arg1.total_watch_time = arg1.total_watch_time + arg2;
        arg1.weighted_score = arg1.weighted_score + arg2 * get_completion_multiplier(v0) / 100;
    }

    public entry fun withdraw_operator_share(arg0: &mut RevenuePool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.platform_wallet, 103);
        assert!(arg1 <= arg0.operator_share, 102);
        arg0.operator_share = arg0.operator_share - arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), arg2), arg0.platform_wallet);
    }

    // decompiled from Move bytecode v6
}

