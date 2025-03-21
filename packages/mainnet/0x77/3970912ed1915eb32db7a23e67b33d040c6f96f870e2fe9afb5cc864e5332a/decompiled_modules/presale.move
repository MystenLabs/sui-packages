module 0x773970912ed1915eb32db7a23e67b33d040c6f96f870e2fe9afb5cc864e5332a::presale {
    struct VolumeBonus has drop, store {
        min_amount: u64,
        max_amount: u64,
        bonus_rate: u64,
    }

    struct PresaleConfig<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        token_price: u64,
        max_tokens: u128,
        start_time: u64,
        end_time: u64,
        collected_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        token_balance: 0x2::balance::Balance<T0>,
        total_sold: u128,
        token_name: 0x1::string::String,
        token_symbol: 0x1::string::String,
        min_purchase_amount: u64,
        max_purchase_amount: u64,
        referral_rate: u64,
        referral_rewards: 0x2::table::Table<address, u128>,
        referral_stats: 0x2::table::Table<address, vector<ReferralInfo>>,
        early_investor_bonus_rate: u64,
        early_investor_count: u64,
        current_investor_count: u64,
        early_investors: 0x2::table::Table<address, bool>,
        volume_bonuses: vector<VolumeBonus>,
        total_bonus_tokens: u128,
        total_referrals: u64,
        total_referral_purchase: u64,
        total_referral_reward: u128,
        unique_referred_count: u64,
    }

    struct UserPurchase<phantom T0> has key {
        id: 0x2::object::UID,
        user: address,
        amount: u128,
        bonus_amount: u128,
    }

    struct ReferralRewardEvent has copy, drop {
        referrer: address,
        buyer: address,
        amount: u128,
    }

    struct BonusRewardEvent has copy, drop {
        user: address,
        amount: u128,
        bonus_type: u8,
    }

    struct ReferralTrackingEvent has copy, drop {
        referrer: address,
        referred_user: address,
        purchase_amount: u64,
        reward_amount: u128,
        timestamp: u64,
        total_referred_count: u64,
    }

    struct DetailedReferralStats has copy, drop {
        total_referrals: u64,
        unique_referred: u64,
        referrers_count: u64,
        total_purchase: u64,
        total_reward: u128,
    }

    struct ReferralInfo has copy, drop, store {
        referred_user: address,
        purchase_amount: u64,
        reward_amount: u128,
        timestamp: u64,
    }

    struct EarlyInvestorsEvent has copy, drop {
        early_investors: vector<address>,
        count: u64,
        max_count: u64,
        remaining: u64,
        bonus_rate: u64,
    }

    public entry fun add_tokens<T0>(arg0: &mut PresaleConfig<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        0x2::balance::join<T0>(&mut arg0.token_balance, 0x2::coin::into_balance<T0>(arg1));
        arg0.max_tokens = arg0.max_tokens + (0x2::coin::value<T0>(&arg1) as u128);
    }

    public entry fun buy_tokens<T0>(arg0: &mut PresaleConfig<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.start_time > 0 && arg0.end_time > 0, 7);
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        assert!(v0 >= arg0.start_time, 1);
        assert!(v0 <= arg0.end_time, 2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v2 = 0x2::tx_context::sender(arg3);
        assert!(v1 >= arg0.min_purchase_amount, 8);
        assert!(v1 <= arg0.max_purchase_amount, 8);
        let v3 = (v1 as u128) * (arg0.token_price as u128) / (1000000000 as u128);
        let v4 = 0;
        if (0x2::table::length<address, bool>(&arg0.early_investors) < arg0.early_investor_count && !0x2::table::contains<address, bool>(&arg0.early_investors, v2)) {
            let v5 = v3 * (arg0.early_investor_bonus_rate as u128) / (10000 as u128);
            v4 = v5;
            0x2::table::add<address, bool>(&mut arg0.early_investors, v2, true);
            let v6 = BonusRewardEvent{
                user       : v2,
                amount     : v5,
                bonus_type : 1,
            };
            0x2::event::emit<BonusRewardEvent>(v6);
        } else if (0x2::table::contains<address, bool>(&arg0.early_investors, v2)) {
            let v7 = v3 * (arg0.early_investor_bonus_rate as u128) / (10000 as u128);
            v4 = v7;
            let v8 = BonusRewardEvent{
                user       : v2,
                amount     : v7,
                bonus_type : 1,
            };
            0x2::event::emit<BonusRewardEvent>(v8);
        };
        let v9 = 0;
        let v10 = 0;
        while (v10 < 0x1::vector::length<VolumeBonus>(&arg0.volume_bonuses)) {
            let v11 = 0x1::vector::borrow<VolumeBonus>(&arg0.volume_bonuses, v10);
            if (v1 >= v11.min_amount && v1 <= v11.max_amount) {
                let v12 = v3 * (v11.bonus_rate as u128) / (10000 as u128);
                v9 = v12;
                let v13 = BonusRewardEvent{
                    user       : v2,
                    amount     : v12,
                    bonus_type : 2,
                };
                0x2::event::emit<BonusRewardEvent>(v13);
                break
            };
            v10 = v10 + 1;
        };
        let v14 = v4 + v9;
        assert!(v3 + v14 <= (0x2::balance::value<T0>(&arg0.token_balance) as u128) - arg0.total_sold - arg0.total_bonus_tokens, 6);
        assert!(arg0.total_sold + v3 <= arg0.max_tokens, 3);
        let v15 = UserPurchase<T0>{
            id           : 0x2::object::new(arg3),
            user         : v2,
            amount       : v3,
            bonus_amount : v14,
        };
        arg0.total_sold = arg0.total_sold + v3;
        arg0.total_bonus_tokens = arg0.total_bonus_tokens + v14;
        arg0.current_investor_count = arg0.current_investor_count + 1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.collected_sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        0x2::transfer::transfer<UserPurchase<T0>>(v15, v2);
    }

    public entry fun buy_tokens_with_referral<T0>(arg0: &mut PresaleConfig<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.start_time > 0 && arg0.end_time > 0, 7);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = v0 / 1000;
        assert!(v1 >= arg0.start_time, 1);
        assert!(v1 <= arg0.end_time, 2);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v3 = 0x2::tx_context::sender(arg4);
        assert!(v3 != arg2, 13);
        assert!(v2 >= arg0.min_purchase_amount, 8);
        assert!(v2 <= arg0.max_purchase_amount, 8);
        let v4 = (v2 as u128) * (arg0.token_price as u128) / (1000000000 as u128);
        let v5 = v4 * (arg0.referral_rate as u128) / (10000 as u128);
        let v6 = 0;
        if (0x2::table::length<address, bool>(&arg0.early_investors) < arg0.early_investor_count && !0x2::table::contains<address, bool>(&arg0.early_investors, v3)) {
            let v7 = v4 * (arg0.early_investor_bonus_rate as u128) / (10000 as u128);
            v6 = v7;
            0x2::table::add<address, bool>(&mut arg0.early_investors, v3, true);
            let v8 = BonusRewardEvent{
                user       : v3,
                amount     : v7,
                bonus_type : 1,
            };
            0x2::event::emit<BonusRewardEvent>(v8);
        } else if (0x2::table::contains<address, bool>(&arg0.early_investors, v3)) {
            let v9 = v4 * (arg0.early_investor_bonus_rate as u128) / (10000 as u128);
            v6 = v9;
            let v10 = BonusRewardEvent{
                user       : v3,
                amount     : v9,
                bonus_type : 1,
            };
            0x2::event::emit<BonusRewardEvent>(v10);
        };
        let v11 = 0;
        let v12 = 0;
        while (v12 < 0x1::vector::length<VolumeBonus>(&arg0.volume_bonuses)) {
            let v13 = 0x1::vector::borrow<VolumeBonus>(&arg0.volume_bonuses, v12);
            if (v2 >= v13.min_amount && v2 <= v13.max_amount) {
                let v14 = v4 * (v13.bonus_rate as u128) / (10000 as u128);
                v11 = v14;
                let v15 = BonusRewardEvent{
                    user       : v3,
                    amount     : v14,
                    bonus_type : 2,
                };
                0x2::event::emit<BonusRewardEvent>(v15);
                break
            };
            v12 = v12 + 1;
        };
        let v16 = v6 + v11;
        assert!(v4 + v5 + v16 <= (0x2::balance::value<T0>(&arg0.token_balance) as u128) - arg0.total_sold - arg0.total_bonus_tokens, 6);
        assert!(arg0.total_sold + v4 <= arg0.max_tokens, 3);
        let v17 = UserPurchase<T0>{
            id           : 0x2::object::new(arg4),
            user         : v3,
            amount       : v4,
            bonus_amount : v16,
        };
        arg0.total_sold = arg0.total_sold + v4;
        arg0.total_bonus_tokens = arg0.total_bonus_tokens + v16;
        arg0.current_investor_count = arg0.current_investor_count + 1;
        if (0x2::table::contains<address, u128>(&arg0.referral_rewards, arg2)) {
            0x2::table::remove<address, u128>(&mut arg0.referral_rewards, arg2);
            0x2::table::add<address, u128>(&mut arg0.referral_rewards, arg2, *0x2::table::borrow<address, u128>(&arg0.referral_rewards, arg2) + v5);
        } else {
            0x2::table::add<address, u128>(&mut arg0.referral_rewards, arg2, v5);
        };
        let v18 = ReferralInfo{
            referred_user   : v3,
            purchase_amount : v2,
            reward_amount   : v5,
            timestamp       : v0,
        };
        if (0x2::table::contains<address, vector<ReferralInfo>>(&arg0.referral_stats, arg2)) {
            0x1::vector::push_back<ReferralInfo>(0x2::table::borrow_mut<address, vector<ReferralInfo>>(&mut arg0.referral_stats, arg2), v18);
        } else {
            let v19 = 0x1::vector::empty<ReferralInfo>();
            0x1::vector::push_back<ReferralInfo>(&mut v19, v18);
            0x2::table::add<address, vector<ReferralInfo>>(&mut arg0.referral_stats, arg2, v19);
        };
        arg0.total_referrals = arg0.total_referrals + 1;
        arg0.total_referral_purchase = arg0.total_referral_purchase + v2;
        arg0.total_referral_reward = arg0.total_referral_reward + v5;
        let v20 = true;
        if (0x2::table::contains<address, vector<ReferralInfo>>(&arg0.referral_stats, arg2)) {
            let v21 = 0x2::table::borrow<address, vector<ReferralInfo>>(&arg0.referral_stats, arg2);
            let v22 = 0;
            while (v22 < 0x1::vector::length<ReferralInfo>(v21) - 1) {
                if (0x1::vector::borrow<ReferralInfo>(v21, v22).referred_user == v3) {
                    v20 = false;
                    break
                };
                v22 = v22 + 1;
            };
        };
        if (v20) {
            arg0.unique_referred_count = arg0.unique_referred_count + 1;
        };
        let v23 = ReferralRewardEvent{
            referrer : arg2,
            buyer    : v3,
            amount   : v5,
        };
        0x2::event::emit<ReferralRewardEvent>(v23);
        let v24 = ReferralTrackingEvent{
            referrer             : arg2,
            referred_user        : v3,
            purchase_amount      : v2,
            reward_amount        : v5,
            timestamp            : v0,
            total_referred_count : get_unique_referral_count<T0>(arg0, arg2),
        };
        0x2::event::emit<ReferralTrackingEvent>(v24);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.collected_sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        0x2::transfer::transfer<UserPurchase<T0>>(v17, v3);
    }

    fun check_presale_ended<T0>(arg0: &PresaleConfig<T0>, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 > arg0.end_time, 5);
    }

    public entry fun claim_referral_rewards<T0>(arg0: &mut PresaleConfig<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        check_presale_ended<T0>(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u128>(&arg0.referral_rewards, v0), 5);
        let v1 = *0x2::table::borrow<address, u128>(&arg0.referral_rewards, v0);
        assert!(v1 > 0, 5);
        0x2::table::remove<address, u128>(&mut arg0.referral_rewards, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_balance, safe_u128_to_u64(v1)), arg2), v0);
    }

    public entry fun claim_tokens<T0>(arg0: &mut PresaleConfig<T0>, arg1: UserPurchase<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        check_presale_ended<T0>(arg0, arg2);
        assert!(arg1.user == 0x2::tx_context::sender(arg3), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_balance, safe_u128_to_u64(arg1.amount + arg1.bonus_amount)), arg3), arg1.user);
        let UserPurchase {
            id           : v0,
            user         : _,
            amount       : _,
            bonus_amount : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public entry fun create_presale<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<VolumeBonus>();
        let v1 = VolumeBonus{
            min_amount : 20 * 1000000000,
            max_amount : 40 * 1000000000,
            bonus_rate : 500,
        };
        0x1::vector::push_back<VolumeBonus>(&mut v0, v1);
        let v2 = VolumeBonus{
            min_amount : 41 * 1000000000,
            max_amount : 60 * 1000000000,
            bonus_rate : 1000,
        };
        0x1::vector::push_back<VolumeBonus>(&mut v0, v2);
        let v3 = VolumeBonus{
            min_amount : 61 * 1000000000,
            max_amount : 100 * 1000000000,
            bonus_rate : 1500,
        };
        0x1::vector::push_back<VolumeBonus>(&mut v0, v3);
        let v4 = PresaleConfig<T0>{
            id                        : 0x2::object::new(arg4),
            owner                     : 0x2::tx_context::sender(arg4),
            token_price               : arg3,
            max_tokens                : (0x2::coin::value<T0>(&arg0) as u128),
            start_time                : 0,
            end_time                  : 0,
            collected_sui             : 0x2::balance::zero<0x2::sui::SUI>(),
            token_balance             : 0x2::coin::into_balance<T0>(arg0),
            total_sold                : 0,
            token_name                : 0x1::string::utf8(arg1),
            token_symbol              : 0x1::string::utf8(arg2),
            min_purchase_amount       : 1000000000 / 100,
            max_purchase_amount       : 100 * 1000000000,
            referral_rate             : 300,
            referral_rewards          : 0x2::table::new<address, u128>(arg4),
            referral_stats            : 0x2::table::new<address, vector<ReferralInfo>>(arg4),
            early_investor_bonus_rate : 1000,
            early_investor_count      : 30,
            current_investor_count    : 0,
            early_investors           : 0x2::table::new<address, bool>(arg4),
            volume_bonuses            : v0,
            total_bonus_tokens        : 0,
            total_referrals           : 0,
            total_referral_purchase   : 0,
            total_referral_reward     : 0,
            unique_referred_count     : 0,
        };
        0x2::transfer::share_object<PresaleConfig<T0>>(v4);
    }

    public fun emit_early_investors_event<T0>(arg0: &PresaleConfig<T0>) {
        let v0 = 0x2::table::length<address, bool>(&arg0.early_investors);
        let v1 = if (arg0.early_investor_count > v0) {
            arg0.early_investor_count - v0
        } else {
            0
        };
        let v2 = EarlyInvestorsEvent{
            early_investors : 0x1::vector::empty<address>(),
            count           : v0,
            max_count       : arg0.early_investor_count,
            remaining       : v1,
            bonus_rate      : arg0.early_investor_bonus_rate,
        };
        0x2::event::emit<EarlyInvestorsEvent>(v2);
    }

    public fun get_detailed_referral_stats<T0>(arg0: &PresaleConfig<T0>) : DetailedReferralStats {
        DetailedReferralStats{
            total_referrals : arg0.total_referrals,
            unique_referred : arg0.unique_referred_count,
            referrers_count : 0x2::table::length<address, vector<ReferralInfo>>(&arg0.referral_stats),
            total_purchase  : arg0.total_referral_purchase,
            total_reward    : arg0.total_referral_reward,
        }
    }

    public fun get_early_investors_count<T0>(arg0: &PresaleConfig<T0>) : u64 {
        0x2::table::length<address, bool>(&arg0.early_investors)
    }

    public fun get_presale_info<T0>(arg0: &PresaleConfig<T0>) : (u128, u128, u64, u64, u64, u64, u64, u64, u128) {
        (arg0.max_tokens, arg0.total_sold, arg0.token_price, arg0.start_time, arg0.end_time, arg0.min_purchase_amount, arg0.max_purchase_amount, arg0.current_investor_count, arg0.total_bonus_tokens)
    }

    public fun get_presale_state<T0>(arg0: &PresaleConfig<T0>, arg1: &0x2::clock::Clock) : u8 {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        if (arg0.start_time == 0 || arg0.end_time == 0) {
            0
        } else if (v0 < arg0.start_time) {
            1
        } else if (v0 > arg0.end_time) {
            3
        } else {
            2
        }
    }

    public fun get_referral_count<T0>(arg0: &PresaleConfig<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, vector<ReferralInfo>>(&arg0.referral_stats, arg1)) {
            0x1::vector::length<ReferralInfo>(0x2::table::borrow<address, vector<ReferralInfo>>(&arg0.referral_stats, arg1))
        } else {
            0
        }
    }

    public fun get_referral_total_purchase<T0>(arg0: &PresaleConfig<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, vector<ReferralInfo>>(&arg0.referral_stats, arg1)) {
            let v1 = 0x2::table::borrow<address, vector<ReferralInfo>>(&arg0.referral_stats, arg1);
            let v2 = 0;
            let v3 = 0;
            while (v3 < 0x1::vector::length<ReferralInfo>(v1)) {
                v2 = v2 + 0x1::vector::borrow<ReferralInfo>(v1, v3).purchase_amount;
                v3 = v3 + 1;
            };
            v2
        } else {
            0
        }
    }

    public fun get_referral_total_reward<T0>(arg0: &PresaleConfig<T0>, arg1: address) : u128 {
        if (0x2::table::contains<address, u128>(&arg0.referral_rewards, arg1)) {
            *0x2::table::borrow<address, u128>(&arg0.referral_rewards, arg1)
        } else {
            0
        }
    }

    public fun get_unique_referral_count<T0>(arg0: &PresaleConfig<T0>, arg1: address) : u64 {
        let v0 = get_unique_referred_users<T0>(arg0, arg1);
        0x1::vector::length<address>(&v0)
    }

    public fun get_unique_referred_users<T0>(arg0: &PresaleConfig<T0>, arg1: address) : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        if (0x2::table::contains<address, vector<ReferralInfo>>(&arg0.referral_stats, arg1)) {
            let v1 = 0x2::table::borrow<address, vector<ReferralInfo>>(&arg0.referral_stats, arg1);
            let v2 = 0;
            while (v2 < 0x1::vector::length<ReferralInfo>(v1)) {
                let v3 = 0x1::vector::borrow<ReferralInfo>(v1, v2).referred_user;
                let v4 = false;
                let v5 = 0;
                while (v5 < 0x1::vector::length<address>(&v0)) {
                    if (*0x1::vector::borrow<address>(&v0, v5) == v3) {
                        v4 = true;
                        break
                    };
                    v5 = v5 + 1;
                };
                if (!v4) {
                    0x1::vector::push_back<address>(&mut v0, v3);
                };
                v2 = v2 + 1;
            };
        };
        v0
    }

    public fun is_early_investor<T0>(arg0: &PresaleConfig<T0>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.early_investors, arg1)
    }

    fun safe_u128_to_u64(arg0: u128) : u64 {
        assert!(arg0 <= (18446744073709551615 as u128), 12);
        (arg0 as u64)
    }

    public entry fun set_early_investor_bonus<T0>(arg0: &mut PresaleConfig<T0>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        assert!(arg1 <= 10000, 10);
        arg0.early_investor_bonus_rate = arg1;
        arg0.early_investor_count = arg2;
    }

    public entry fun set_presale_times<T0>(arg0: &mut PresaleConfig<T0>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        assert!(arg1 < arg2, 3);
        arg0.start_time = arg1;
        arg0.end_time = arg2;
    }

    public entry fun set_purchase_limits<T0>(arg0: &mut PresaleConfig<T0>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        assert!(arg1 < arg2, 3);
        arg0.min_purchase_amount = arg1;
        arg0.max_purchase_amount = arg2;
    }

    public entry fun set_referral_rate<T0>(arg0: &mut PresaleConfig<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert!(arg1 <= 1000, 9);
        arg0.referral_rate = arg1;
    }

    public entry fun set_token_price<T0>(arg0: &mut PresaleConfig<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        arg0.token_price = arg1;
    }

    public entry fun set_volume_bonuses<T0>(arg0: &mut PresaleConfig<T0>, arg1: vector<u64>, arg2: vector<u64>, arg3: vector<u64>, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 0);
        let v0 = 0x1::vector::length<u64>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 11);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 11);
        arg0.volume_bonuses = 0x1::vector::empty<VolumeBonus>();
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u64>(&arg1, v1);
            let v3 = *0x1::vector::borrow<u64>(&arg2, v1);
            let v4 = *0x1::vector::borrow<u64>(&arg3, v1);
            assert!(v2 < v3, 11);
            assert!(v4 <= 10000, 10);
            let v5 = VolumeBonus{
                min_amount : v2,
                max_amount : v3,
                bonus_rate : v4,
            };
            0x1::vector::push_back<VolumeBonus>(&mut arg0.volume_bonuses, v5);
            v1 = v1 + 1;
        };
    }

    public entry fun withdraw_sui<T0>(arg0: &mut PresaleConfig<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.collected_sui);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.collected_sui, v0), arg1), arg0.owner);
        };
    }

    public entry fun withdraw_unsold_tokens<T0>(arg0: &mut PresaleConfig<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        check_presale_ended<T0>(arg0, arg1);
        let v0 = (0x2::balance::value<T0>(&arg0.token_balance) as u128);
        let v1 = arg0.total_sold + arg0.total_bonus_tokens + arg0.total_referral_reward;
        assert!(v0 >= v1, 3);
        let v2 = safe_u128_to_u64(v0 - v1);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_balance, v2), arg2), arg0.owner);
        };
    }

    // decompiled from Move bytecode v6
}

