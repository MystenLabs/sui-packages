module 0xa55da33f92dc59fcf429bd5fbc506dfe454a3ca41073a2aeb5c70afb3aa9d1f6::affiliate_system {
    struct AFFILIATE_SYSTEM has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct NftCounterCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry<phantom T0> has key {
        id: 0x2::object::UID,
        affiliate_rates: vector<u64>,
        slush_wallet: address,
        treasury_wallet: address,
        team_wallet: address,
        ops_wallet: address,
        profiles: 0x2::table::Table<address, Profile>,
        treasury_balance: 0x2::balance::Balance<T0>,
        gold_wallet_balance: 0x2::balance::Balance<T0>,
        silver_wallet_balance: 0x2::balance::Balance<T0>,
        current_month: u64,
        month_start_time: u64,
        silver_month_accumulated: u64,
        gold_month_accumulated: u64,
        monthly_rewards: 0x2::table::Table<u64, MonthlyRewards>,
        paused: bool,
        total_sales: u64,
        total_distributed: u64,
        total_silver_nfts: u64,
        total_gold_nfts: u64,
    }

    struct MonthlyRewards has store {
        month: u64,
        silver_total: u64,
        gold_total: u64,
        silver_nft_count: u64,
        gold_nft_count: u64,
        silver_rewards_per_nft: u64,
        gold_rewards_per_nft: u64,
        finalized: bool,
    }

    struct Profile has store {
        referrer: address,
        total_earned: u64,
        total_referrals: u64,
        registered_at: u64,
        last_claimed_silver_month: u64,
        last_claimed_gold_month: u64,
        silver_nft_count: u64,
        gold_nft_count: u64,
    }

    struct UserRegistered has copy, drop {
        user: address,
        referrer: address,
        timestamp: u64,
    }

    struct FundsDeposited has copy, drop {
        amount: u64,
        depositor: address,
        new_balance: u64,
    }

    struct PayoutExecuted has copy, drop {
        buyer: address,
        sale_amount: u64,
        affiliate_payouts: vector<AffiliatePayout>,
        fixed_payouts: vector<FixedPayout>,
        gold_accumulated: u64,
        silver_accumulated: u64,
        total_distributed: u64,
    }

    struct AffiliatePayout has copy, drop, store {
        recipient: address,
        level: u8,
        amount: u64,
    }

    struct FixedPayout has copy, drop, store {
        recipient: address,
        wallet_type: u8,
        amount: u64,
    }

    struct MonthFinalized has copy, drop {
        month: u64,
        silver_total: u64,
        gold_total: u64,
        silver_nft_count: u64,
        gold_nft_count: u64,
        silver_rewards_per_nft: u64,
        gold_rewards_per_nft: u64,
    }

    struct RewardsClaimed has copy, drop {
        user: address,
        nft_type: u8,
        months_claimed: vector<u64>,
        total_amount: u64,
    }

    public fun admin_set_nft_counts<T0>(arg0: &AdminCap, arg1: &mut Registry<T0>, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, Profile>(&arg1.profiles, arg2)) {
            let v0 = Profile{
                referrer                  : @0x0,
                total_earned              : 0,
                total_referrals           : 0,
                registered_at             : 0x2::tx_context::epoch_timestamp_ms(arg5),
                last_claimed_silver_month : 0,
                last_claimed_gold_month   : 0,
                silver_nft_count          : 0,
                gold_nft_count            : 0,
            };
            0x2::table::add<address, Profile>(&mut arg1.profiles, arg2, v0);
        };
        let v1 = 0x2::table::borrow_mut<address, Profile>(&mut arg1.profiles, arg2);
        arg1.total_silver_nfts = arg1.total_silver_nfts - v1.silver_nft_count + arg3;
        arg1.total_gold_nfts = arg1.total_gold_nfts - v1.gold_nft_count + arg4;
        v1.silver_nft_count = arg3;
        v1.gold_nft_count = arg4;
    }

    public fun admin_set_total_nft_counts<T0>(arg0: &AdminCap, arg1: &mut Registry<T0>, arg2: u64, arg3: u64) {
        arg1.total_silver_nfts = arg2;
        arg1.total_gold_nfts = arg3;
    }

    public fun claim_gold_rewards<T0>(arg0: &mut Registry<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, Profile>(&arg0.profiles, v0), 6);
        let v1 = 0x2::table::borrow<address, Profile>(&arg0.profiles, v0).gold_nft_count;
        assert!(v1 > 0, 8);
        assert!(0x2::table::contains<u64, MonthlyRewards>(&arg0.monthly_rewards, arg1), 13);
        let v2 = 0x2::table::borrow_mut<address, Profile>(&mut arg0.profiles, v0);
        assert!(arg1 > v2.last_claimed_gold_month, 14);
        let v3 = 0x2::table::borrow<u64, MonthlyRewards>(&arg0.monthly_rewards, arg1).gold_rewards_per_nft * v1;
        assert!(v3 > 0, 9);
        assert!(0x2::balance::value<T0>(&arg0.gold_wallet_balance) >= v3, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.gold_wallet_balance, v3), arg2), v0);
        v2.last_claimed_gold_month = arg1;
        let v4 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v4, arg1);
        let v5 = RewardsClaimed{
            user           : v0,
            nft_type       : 1,
            months_claimed : v4,
            total_amount   : v3,
        };
        0x2::event::emit<RewardsClaimed>(v5);
    }

    public fun claim_silver_rewards<T0>(arg0: &mut Registry<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, Profile>(&arg0.profiles, v0), 6);
        let v1 = 0x2::table::borrow<address, Profile>(&arg0.profiles, v0).silver_nft_count;
        assert!(v1 > 0, 8);
        assert!(0x2::table::contains<u64, MonthlyRewards>(&arg0.monthly_rewards, arg1), 13);
        let v2 = 0x2::table::borrow_mut<address, Profile>(&mut arg0.profiles, v0);
        assert!(arg1 > v2.last_claimed_silver_month, 14);
        let v3 = 0x2::table::borrow<u64, MonthlyRewards>(&arg0.monthly_rewards, arg1).silver_rewards_per_nft * v1;
        assert!(v3 > 0, 9);
        assert!(0x2::balance::value<T0>(&arg0.silver_wallet_balance) >= v3, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.silver_wallet_balance, v3), arg2), v0);
        v2.last_claimed_silver_month = arg1;
        let v4 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v4, arg1);
        let v5 = RewardsClaimed{
            user           : v0,
            nft_type       : 0,
            months_claimed : v4,
            total_amount   : v3,
        };
        0x2::event::emit<RewardsClaimed>(v5);
    }

    public fun deposit_funds<T0>(arg0: &mut Registry<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.treasury_balance, 0x2::coin::into_balance<T0>(arg1));
        let v0 = FundsDeposited{
            amount      : 0x2::coin::value<T0>(&arg1),
            depositor   : 0x2::tx_context::sender(arg2),
            new_balance : 0x2::balance::value<T0>(&arg0.treasury_balance),
        };
        0x2::event::emit<FundsDeposited>(v0);
    }

    public fun emergency_withdraw<T0>(arg0: &AdminCap, arg1: &mut Registry<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg1.treasury_balance) >= arg2, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.treasury_balance, arg2), arg4), arg3);
    }

    public fun finalize_month<T0>(arg0: &mut Registry<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg1);
        let v1 = get_month_from_timestamp(v0);
        assert!(v1 > arg0.current_month, 10);
        assert!(!0x2::table::contains<u64, MonthlyRewards>(&arg0.monthly_rewards, arg0.current_month), 11);
        let v2 = arg0.total_silver_nfts;
        let v3 = arg0.total_gold_nfts;
        let v4 = if (v2 > 0) {
            arg0.silver_month_accumulated / v2
        } else {
            0
        };
        let v5 = if (v3 > 0) {
            arg0.gold_month_accumulated / v3
        } else {
            0
        };
        let v6 = MonthlyRewards{
            month                  : arg0.current_month,
            silver_total           : arg0.silver_month_accumulated,
            gold_total             : arg0.gold_month_accumulated,
            silver_nft_count       : v2,
            gold_nft_count         : v3,
            silver_rewards_per_nft : v4,
            gold_rewards_per_nft   : v5,
            finalized              : true,
        };
        0x2::table::add<u64, MonthlyRewards>(&mut arg0.monthly_rewards, arg0.current_month, v6);
        let v7 = MonthFinalized{
            month                  : arg0.current_month,
            silver_total           : arg0.silver_month_accumulated,
            gold_total             : arg0.gold_month_accumulated,
            silver_nft_count       : v2,
            gold_nft_count         : v3,
            silver_rewards_per_nft : v4,
            gold_rewards_per_nft   : v5,
        };
        0x2::event::emit<MonthFinalized>(v7);
        arg0.current_month = v1;
        arg0.month_start_time = v0;
        arg0.silver_month_accumulated = 0;
        arg0.gold_month_accumulated = 0;
    }

    public fun get_affiliate_rates<T0>(arg0: &Registry<T0>) : vector<u64> {
        arg0.affiliate_rates
    }

    public fun get_current_month<T0>(arg0: &Registry<T0>) : u64 {
        arg0.current_month
    }

    public fun get_gold_pool_balance<T0>(arg0: &Registry<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.gold_wallet_balance)
    }

    public fun get_last_claimed_months<T0>(arg0: &Registry<T0>, arg1: address) : (u64, u64) {
        assert!(0x2::table::contains<address, Profile>(&arg0.profiles, arg1), 6);
        let v0 = 0x2::table::borrow<address, Profile>(&arg0.profiles, arg1);
        (v0.last_claimed_silver_month, v0.last_claimed_gold_month)
    }

    fun get_month_from_timestamp(arg0: u64) : u64 {
        let v0 = arg0 / 86400000;
        (1970 + v0 / 365) * 100 + v0 % 365 / 30 + 1
    }

    public fun get_monthly_rewards<T0>(arg0: &Registry<T0>, arg1: u64) : (u64, u64, u64, u64, u64, u64, bool) {
        assert!(0x2::table::contains<u64, MonthlyRewards>(&arg0.monthly_rewards, arg1), 13);
        let v0 = 0x2::table::borrow<u64, MonthlyRewards>(&arg0.monthly_rewards, arg1);
        (v0.silver_rewards_per_nft, v0.gold_rewards_per_nft, v0.silver_total, v0.gold_total, v0.silver_nft_count, v0.gold_nft_count, v0.finalized)
    }

    public fun get_profile<T0>(arg0: &Registry<T0>, arg1: address) : (address, u64, u64, u64) {
        assert!(0x2::table::contains<address, Profile>(&arg0.profiles, arg1), 6);
        let v0 = 0x2::table::borrow<address, Profile>(&arg0.profiles, arg1);
        (v0.referrer, v0.total_earned, v0.total_referrals, v0.registered_at)
    }

    public fun get_silver_pool_balance<T0>(arg0: &Registry<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.silver_wallet_balance)
    }

    public fun get_stats<T0>(arg0: &Registry<T0>) : (u64, u64, bool) {
        (arg0.total_sales, arg0.total_distributed, arg0.paused)
    }

    public fun get_total_nft_counts<T0>(arg0: &Registry<T0>) : (u64, u64) {
        (arg0.total_silver_nfts, arg0.total_gold_nfts)
    }

    public fun get_treasury_balance<T0>(arg0: &Registry<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.treasury_balance)
    }

    public fun get_user_nft_counts<T0>(arg0: &Registry<T0>, arg1: address) : (u64, u64) {
        if (!0x2::table::contains<address, Profile>(&arg0.profiles, arg1)) {
            return (0, 0)
        };
        let v0 = 0x2::table::borrow<address, Profile>(&arg0.profiles, arg1);
        (v0.silver_nft_count, v0.gold_nft_count)
    }

    public fun increment_nft_count<T0>(arg0: &NftCounterCap, arg1: &mut Registry<T0>, arg2: address, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, Profile>(&arg1.profiles, arg2)) {
            let v0 = Profile{
                referrer                  : @0x0,
                total_earned              : 0,
                total_referrals           : 0,
                registered_at             : 0x2::tx_context::epoch_timestamp_ms(arg4),
                last_claimed_silver_month : 0,
                last_claimed_gold_month   : 0,
                silver_nft_count          : 0,
                gold_nft_count            : 0,
            };
            0x2::table::add<address, Profile>(&mut arg1.profiles, arg2, v0);
        };
        let v1 = 0x2::table::borrow_mut<address, Profile>(&mut arg1.profiles, arg2);
        if (arg3 == 0) {
            v1.silver_nft_count = v1.silver_nft_count + 1;
            arg1.total_silver_nfts = arg1.total_silver_nfts + 1;
        } else {
            assert!(arg3 == 1, 15);
            v1.gold_nft_count = v1.gold_nft_count + 1;
            arg1.total_gold_nfts = arg1.total_gold_nfts + 1;
        };
    }

    fun init(arg0: AFFILIATE_SYSTEM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = NftCounterCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<NftCounterCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun init_registry<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, 2500);
        0x1::vector::push_back<u64>(&mut v0, 1000);
        0x1::vector::push_back<u64>(&mut v0, 750);
        0x1::vector::push_back<u64>(&mut v0, 500);
        0x1::vector::push_back<u64>(&mut v0, 250);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg0);
        let v2 = Registry<T0>{
            id                       : 0x2::object::new(arg0),
            affiliate_rates          : v0,
            slush_wallet             : @0x471eb35b113b5e76797d266870585b8d98897bc3260c06723d8fd984d0f007cd,
            treasury_wallet          : @0xc4c4fc159c4b71a6dbbab5cefcf96e704c21cc4ef3d10dcdd8ef736d40c95940,
            team_wallet              : @0x26260fc2a4e6c16b2f2ade21060339a5edb1f6fca671705985e2949268369f43,
            ops_wallet               : @0x8e9d3694f494a0da57fd189697e03bd33e7b9ee615fb15735ee58eacba753091,
            profiles                 : 0x2::table::new<address, Profile>(arg0),
            treasury_balance         : 0x2::balance::zero<T0>(),
            gold_wallet_balance      : 0x2::balance::zero<T0>(),
            silver_wallet_balance    : 0x2::balance::zero<T0>(),
            current_month            : get_month_from_timestamp(v1),
            month_start_time         : v1,
            silver_month_accumulated : 0,
            gold_month_accumulated   : 0,
            monthly_rewards          : 0x2::table::new<u64, MonthlyRewards>(arg0),
            paused                   : false,
            total_sales              : 0,
            total_distributed        : 0,
            total_silver_nfts        : 0,
            total_gold_nfts          : 0,
        };
        0x2::transfer::share_object<Registry<T0>>(v2);
    }

    public fun is_registered<T0>(arg0: &Registry<T0>, arg1: address) : bool {
        0x2::table::contains<address, Profile>(&arg0.profiles, arg1)
    }

    public fun payout_sale<T0>(arg0: &mut Registry<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 3);
        assert!(arg1 > 0, 7);
        assert!(0x2::table::contains<address, Profile>(&arg0.profiles, arg2), 6);
        assert!(0x2::balance::value<T0>(&arg0.treasury_balance) >= arg1, 2);
        let v0 = 0x1::vector::empty<AffiliatePayout>();
        let v1 = 0x1::vector::empty<FixedPayout>();
        let v2 = 0;
        let v3 = 0;
        let v4 = arg2;
        let v5 = 1;
        while (v5 <= 5) {
            v4 = 0x2::table::borrow<address, Profile>(&arg0.profiles, v4).referrer;
            let v6 = arg1 * *0x1::vector::borrow<u64>(&arg0.affiliate_rates, (v5 as u64) - 1) / 10000;
            if (v4 == @0x0) {
                v3 = v3 + v6;
                v5 = v5 + 1;
                continue
            };
            if (v6 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.treasury_balance, v6), arg3), v4);
                let v7 = 0x2::table::borrow_mut<address, Profile>(&mut arg0.profiles, v4);
                v7.total_earned = v7.total_earned + v6;
                let v8 = AffiliatePayout{
                    recipient : v4,
                    level     : v5,
                    amount    : v6,
                };
                0x1::vector::push_back<AffiliatePayout>(&mut v0, v8);
                v2 = v2 + v6;
            };
            v5 = v5 + 1;
        };
        let v9 = arg1 * 1000 / 10000;
        0x2::balance::join<T0>(&mut arg0.gold_wallet_balance, 0x2::balance::split<T0>(&mut arg0.treasury_balance, v9));
        arg0.gold_month_accumulated = arg0.gold_month_accumulated + v9;
        let v10 = arg1 * 500 / 10000;
        0x2::balance::join<T0>(&mut arg0.silver_wallet_balance, 0x2::balance::split<T0>(&mut arg0.treasury_balance, v10));
        arg0.silver_month_accumulated = arg0.silver_month_accumulated + v10;
        let v11 = v2 + v9 + v10;
        v2 = v11;
        let v12 = arg1 * 2000 / 10000;
        let v13 = v12;
        if (v3 > 0) {
            v13 = v12 + v3;
        };
        if (v13 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.treasury_balance, v13), arg3), arg0.treasury_wallet);
            let v14 = FixedPayout{
                recipient   : arg0.treasury_wallet,
                wallet_type : 1,
                amount      : v13,
            };
            0x1::vector::push_back<FixedPayout>(&mut v1, v14);
            v2 = v11 + v13;
        };
        let v15 = arg1 * 1000 / 10000;
        if (v15 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.treasury_balance, v15), arg3), arg0.team_wallet);
            let v16 = FixedPayout{
                recipient   : arg0.team_wallet,
                wallet_type : 2,
                amount      : v15,
            };
            0x1::vector::push_back<FixedPayout>(&mut v1, v16);
            v2 = v2 + v15;
        };
        let v17 = arg1 * 500 / 10000;
        if (v17 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.treasury_balance, v17), arg3), arg0.ops_wallet);
            let v18 = FixedPayout{
                recipient   : arg0.ops_wallet,
                wallet_type : 3,
                amount      : v17,
            };
            0x1::vector::push_back<FixedPayout>(&mut v1, v18);
            v2 = v2 + v17;
        };
        arg0.total_sales = arg0.total_sales + 1;
        arg0.total_distributed = arg0.total_distributed + v2;
        let v19 = PayoutExecuted{
            buyer              : arg2,
            sale_amount        : arg1,
            affiliate_payouts  : v0,
            fixed_payouts      : v1,
            gold_accumulated   : v9,
            silver_accumulated : v10,
            total_distributed  : v2,
        };
        0x2::event::emit<PayoutExecuted>(v19);
    }

    public fun register<T0>(arg0: &mut Registry<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        assert!(!0x2::table::contains<address, Profile>(&arg0.profiles, v0), 5);
        if (arg1 != @0x0) {
            assert!(0x2::table::contains<address, Profile>(&arg0.profiles, arg1), 4);
            let v2 = 0x2::table::borrow_mut<address, Profile>(&mut arg0.profiles, arg1);
            v2.total_referrals = v2.total_referrals + 1;
        };
        let v3 = Profile{
            referrer                  : arg1,
            total_earned              : 0,
            total_referrals           : 0,
            registered_at             : v1,
            last_claimed_silver_month : 0,
            last_claimed_gold_month   : 0,
            silver_nft_count          : 0,
            gold_nft_count            : 0,
        };
        0x2::table::add<address, Profile>(&mut arg0.profiles, v0, v3);
        let v4 = UserRegistered{
            user      : v0,
            referrer  : arg1,
            timestamp : v1,
        };
        0x2::event::emit<UserRegistered>(v4);
    }

    public fun register_if_not_exists<T0>(arg0: &mut Registry<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (0x2::table::contains<address, Profile>(&arg0.profiles, v0)) {
            return
        };
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        if (arg1 != @0x0) {
            assert!(0x2::table::contains<address, Profile>(&arg0.profiles, arg1), 4);
            let v2 = 0x2::table::borrow_mut<address, Profile>(&mut arg0.profiles, arg1);
            v2.total_referrals = v2.total_referrals + 1;
        };
        let v3 = Profile{
            referrer                  : arg1,
            total_earned              : 0,
            total_referrals           : 0,
            registered_at             : v1,
            last_claimed_silver_month : 0,
            last_claimed_gold_month   : 0,
            silver_nft_count          : 0,
            gold_nft_count            : 0,
        };
        0x2::table::add<address, Profile>(&mut arg0.profiles, v0, v3);
        let v4 = UserRegistered{
            user      : v0,
            referrer  : arg1,
            timestamp : v1,
        };
        0x2::event::emit<UserRegistered>(v4);
    }

    public entry fun register_user<T0>(arg0: &mut Registry<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        register_if_not_exists<T0>(arg0, arg1, arg2);
    }

    public fun set_pause<T0>(arg0: &AdminCap, arg1: &mut Registry<T0>, arg2: bool) {
        arg1.paused = arg2;
    }

    public fun update_affiliate_rates<T0>(arg0: &AdminCap, arg1: &mut Registry<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert!(arg2 + arg3 + arg4 + arg5 + arg6 <= 5000, 12);
        *0x1::vector::borrow_mut<u64>(&mut arg1.affiliate_rates, 0) = arg2;
        *0x1::vector::borrow_mut<u64>(&mut arg1.affiliate_rates, 1) = arg3;
        *0x1::vector::borrow_mut<u64>(&mut arg1.affiliate_rates, 2) = arg4;
        *0x1::vector::borrow_mut<u64>(&mut arg1.affiliate_rates, 3) = arg5;
        *0x1::vector::borrow_mut<u64>(&mut arg1.affiliate_rates, 4) = arg6;
    }

    // decompiled from Move bytecode v6
}

