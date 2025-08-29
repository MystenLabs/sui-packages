module 0xd7c343dcd827710ee392602f95e16a98dc76ba9abe13eafb4ebb03232b60a9b3::omg_protocol {
    struct OMG_PROTOCOL has drop {
        dummy_field: bool,
    }

    struct Campaign has store {
        name: vector<u8>,
        description: vector<u8>,
        deposit_start_time: u64,
        deposit_end_time: u64,
        campaign_length: u64,
        launch_time: u64,
        money_collected: bool,
        total_shares: u64,
        last_updated: u64,
        campaign_admin: address,
        reward_rate: u64,
        total_cap: u64,
        per_address_cap: u64,
        omg_usd_reserves: 0x2::balance::Balance<OMG_PROTOCOL>,
        balances: 0x2::table::Table<address, u64>,
        borrowed_amount: u64,
        repaid: bool,
    }

    struct WrapperState has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<OMG_PROTOCOL>,
        usdc_reserves: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        total_wrapped: u64,
        admin: address,
        campaigns: vector<Campaign>,
    }

    struct WrapEvent has copy, drop {
        user: address,
        amount: u64,
        timestamp: u64,
    }

    struct UnwrapEvent has copy, drop {
        user: address,
        amount: u64,
        timestamp: u64,
    }

    struct RewardMintCap has store, key {
        id: 0x2::object::UID,
    }

    entry fun borrow_usdt(arg0: &mut WrapperState, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == 0x1::vector::borrow<Campaign>(&arg0.campaigns, arg1).campaign_admin, 3);
        assert!(arg1 < 0x1::vector::length<Campaign>(&arg0.campaigns), 2);
        let v1 = 0x1::vector::borrow_mut<Campaign>(&mut arg0.campaigns, arg1);
        assert!(!v1.money_collected, 6);
        v1.money_collected = true;
        assert!(0x2::clock::timestamp_ms(arg2) >= v1.deposit_end_time, 5);
        let v2 = 0x2::balance::value<OMG_PROTOCOL>(&v1.omg_usd_reserves);
        v1.borrowed_amount = v2;
        v1.repaid = false;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_reserves, v2), arg3), v0);
    }

    entry fun define_campaign(arg0: &mut WrapperState, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg8) == arg0.admin, 3);
        let v0 = Campaign{
            name               : arg1,
            description        : arg2,
            deposit_start_time : arg3,
            deposit_end_time   : arg4,
            campaign_length    : arg7,
            launch_time        : 0,
            money_collected    : false,
            total_shares       : 0,
            last_updated       : 0,
            campaign_admin     : arg5,
            reward_rate        : arg6,
            total_cap          : 0,
            per_address_cap    : 0,
            omg_usd_reserves   : 0x2::balance::zero<OMG_PROTOCOL>(),
            balances           : 0x2::table::new<address, u64>(arg8),
            borrowed_amount    : 0,
            repaid             : false,
        };
        0x1::vector::push_back<Campaign>(&mut arg0.campaigns, v0);
    }

    entry fun define_campaign_with_caps(arg0: &mut WrapperState, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg10) == arg0.admin, 3);
        let v0 = Campaign{
            name               : arg1,
            description        : arg2,
            deposit_start_time : arg3,
            deposit_end_time   : arg4,
            campaign_length    : arg7,
            launch_time        : 0,
            money_collected    : false,
            total_shares       : 0,
            last_updated       : 0,
            campaign_admin     : arg5,
            reward_rate        : arg6,
            total_cap          : arg8,
            per_address_cap    : arg9,
            omg_usd_reserves   : 0x2::balance::zero<OMG_PROTOCOL>(),
            balances           : 0x2::table::new<address, u64>(arg10),
            borrowed_amount    : 0,
            repaid             : false,
        };
        0x1::vector::push_back<Campaign>(&mut arg0.campaigns, v0);
    }

    entry fun disable_rewards(arg0: RewardMintCap) {
        let RewardMintCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun get_campaign_admin(arg0: &WrapperState, arg1: u64) : address {
        assert!(arg1 < 0x1::vector::length<Campaign>(&arg0.campaigns), 2);
        0x1::vector::borrow<Campaign>(&arg0.campaigns, arg1).campaign_admin
    }

    public fun get_campaign_borrowed_amount(arg0: &WrapperState, arg1: u64) : u64 {
        assert!(arg1 < 0x1::vector::length<Campaign>(&arg0.campaigns), 2);
        0x1::vector::borrow<Campaign>(&arg0.campaigns, arg1).borrowed_amount
    }

    public fun get_campaign_caps(arg0: &WrapperState, arg1: u64) : (u64, u64) {
        assert!(arg1 < 0x1::vector::length<Campaign>(&arg0.campaigns), 2);
        let v0 = 0x1::vector::borrow<Campaign>(&arg0.campaigns, arg1);
        (v0.total_cap, v0.per_address_cap)
    }

    public fun get_campaign_count(arg0: &WrapperState) : u64 {
        0x1::vector::length<Campaign>(&arg0.campaigns)
    }

    public fun get_campaign_deposit_window(arg0: &WrapperState, arg1: u64) : (u64, u64) {
        assert!(arg1 < 0x1::vector::length<Campaign>(&arg0.campaigns), 2);
        let v0 = 0x1::vector::borrow<Campaign>(&arg0.campaigns, arg1);
        (v0.deposit_start_time, v0.deposit_end_time)
    }

    public fun get_campaign_last_updated(arg0: &WrapperState, arg1: u64) : u64 {
        assert!(arg1 < 0x1::vector::length<Campaign>(&arg0.campaigns), 2);
        0x1::vector::borrow<Campaign>(&arg0.campaigns, arg1).last_updated
    }

    public fun get_campaign_launch_time(arg0: &WrapperState, arg1: u64) : u64 {
        assert!(arg1 < 0x1::vector::length<Campaign>(&arg0.campaigns), 2);
        0x1::vector::borrow<Campaign>(&arg0.campaigns, arg1).launch_time
    }

    public fun get_campaign_length(arg0: &WrapperState, arg1: u64) : u64 {
        assert!(arg1 < 0x1::vector::length<Campaign>(&arg0.campaigns), 2);
        0x1::vector::borrow<Campaign>(&arg0.campaigns, arg1).campaign_length
    }

    public fun get_campaign_money_collected(arg0: &WrapperState, arg1: u64) : bool {
        assert!(arg1 < 0x1::vector::length<Campaign>(&arg0.campaigns), 2);
        0x1::vector::borrow<Campaign>(&arg0.campaigns, arg1).money_collected
    }

    public fun get_campaign_repaid(arg0: &WrapperState, arg1: u64) : bool {
        assert!(arg1 < 0x1::vector::length<Campaign>(&arg0.campaigns), 2);
        0x1::vector::borrow<Campaign>(&arg0.campaigns, arg1).repaid
    }

    public fun get_campaign_required_repay_amount(arg0: &WrapperState, arg1: u64) : u64 {
        get_campaign_reserves(arg0, arg1)
    }

    public fun get_campaign_reserves(arg0: &WrapperState, arg1: u64) : u64 {
        assert!(arg1 < 0x1::vector::length<Campaign>(&arg0.campaigns), 2);
        0x2::balance::value<OMG_PROTOCOL>(&0x1::vector::borrow<Campaign>(&arg0.campaigns, arg1).omg_usd_reserves)
    }

    public fun get_campaign_reward_rate(arg0: &WrapperState, arg1: u64) : u64 {
        assert!(arg1 < 0x1::vector::length<Campaign>(&arg0.campaigns), 2);
        0x1::vector::borrow<Campaign>(&arg0.campaigns, arg1).reward_rate
    }

    public fun get_campaign_status(arg0: &WrapperState, arg1: u64) : (bool, bool) {
        assert!(arg1 < 0x1::vector::length<Campaign>(&arg0.campaigns), 2);
        let v0 = 0x1::vector::borrow<Campaign>(&arg0.campaigns, arg1);
        (v0.money_collected, v0.repaid)
    }

    public fun get_campaign_total_shares(arg0: &WrapperState, arg1: u64) : u64 {
        assert!(arg1 < 0x1::vector::length<Campaign>(&arg0.campaigns), 2);
        0x1::vector::borrow<Campaign>(&arg0.campaigns, arg1).total_shares
    }

    public fun get_total_wrapped(arg0: &WrapperState) : u64 {
        arg0.total_wrapped
    }

    public fun get_usdc_reserves(arg0: &WrapperState) : u64 {
        0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.usdc_reserves)
    }

    public fun get_user_shares(arg0: &WrapperState, arg1: u64, arg2: address) : u64 {
        assert!(arg1 < 0x1::vector::length<Campaign>(&arg0.campaigns), 2);
        let v0 = 0x1::vector::borrow<Campaign>(&arg0.campaigns, arg1);
        if (0x2::table::contains<address, u64>(&v0.balances, arg2)) {
            *0x2::table::borrow<address, u64>(&v0.balances, arg2)
        } else {
            0
        }
    }

    public fun get_user_withdrawable_amount(arg0: &WrapperState, arg1: u64, arg2: address) : u64 {
        assert!(arg1 < 0x1::vector::length<Campaign>(&arg0.campaigns), 2);
        let v0 = 0x1::vector::borrow<Campaign>(&arg0.campaigns, arg1);
        if (!0x2::table::contains<address, u64>(&v0.balances, arg2)) {
            return 0
        };
        let v1 = *0x2::table::borrow<address, u64>(&v0.balances, arg2);
        let v2 = v0.total_shares;
        if (v2 == 0) {
            0
        } else if (v1 == v2) {
            0x2::balance::value<OMG_PROTOCOL>(&v0.omg_usd_reserves)
        } else {
            v1 * 0x2::balance::value<OMG_PROTOCOL>(&v0.omg_usd_reserves) / v2
        }
    }

    fun init(arg0: OMG_PROTOCOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OMG_PROTOCOL>(arg0, 6, b"OMGUSD", b"OMG USD", b"OMG USD token for OMG ecosystem", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = WrapperState{
            id            : 0x2::object::new(arg1),
            treasury_cap  : v0,
            usdc_reserves : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            total_wrapped : 0,
            admin         : 0x2::tx_context::sender(arg1),
            campaigns     : 0x1::vector::empty<Campaign>(),
        };
        let v3 = RewardMintCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<WrapperState>(v2);
        0x2::transfer::public_transfer<RewardMintCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OMG_PROTOCOL>>(v1);
    }

    entry fun launch_campaign(arg0: &mut WrapperState, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == 0x1::vector::borrow<Campaign>(&arg0.campaigns, arg1).campaign_admin, 3);
        assert!(arg1 < 0x1::vector::length<Campaign>(&arg0.campaigns), 2);
        let v0 = 0x1::vector::borrow_mut<Campaign>(&mut arg0.campaigns, arg1);
        assert!(v0.launch_time == 0, 2);
        assert!(v0.money_collected, 6);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 >= v0.deposit_end_time, 5);
        v0.launch_time = v1;
        v0.reward_rate = arg2;
    }

    entry fun lock_omg_usd(arg0: &mut WrapperState, arg1: u64, arg2: 0x2::coin::Coin<OMG_PROTOCOL>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1 < 0x1::vector::length<Campaign>(&arg0.campaigns), 2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x1::vector::borrow<Campaign>(&arg0.campaigns, arg1);
        assert!(v0 >= v1.deposit_start_time, 5);
        assert!(v0 <= v1.deposit_end_time, 5);
        let v2 = 0x2::coin::value<OMG_PROTOCOL>(&arg2);
        assert!(v2 > 0, 2);
        let v3 = 0x2::tx_context::sender(arg4);
        let v4 = 0x1::vector::borrow<Campaign>(&arg0.campaigns, arg1);
        if (v4.total_cap > 0) {
            assert!(v4.total_shares + v2 <= v4.total_cap, 12);
        };
        if (v4.per_address_cap > 0) {
            let v5 = if (0x2::table::contains<address, u64>(&v4.balances, v3)) {
                *0x2::table::borrow<address, u64>(&v4.balances, v3)
            } else {
                0
            };
            assert!(v5 + v2 <= v4.per_address_cap, 13);
        };
        0x2::balance::join<OMG_PROTOCOL>(&mut 0x1::vector::borrow_mut<Campaign>(&mut arg0.campaigns, arg1).omg_usd_reserves, 0x2::coin::into_balance<OMG_PROTOCOL>(arg2));
        0x1::vector::borrow_mut<Campaign>(&mut arg0.campaigns, arg1).total_shares = 0x1::vector::borrow<Campaign>(&arg0.campaigns, arg1).total_shares + v2;
        if (0x2::table::contains<address, u64>(&0x1::vector::borrow<Campaign>(&arg0.campaigns, arg1).balances, v3)) {
            0x2::table::add<address, u64>(&mut 0x1::vector::borrow_mut<Campaign>(&mut arg0.campaigns, arg1).balances, v3, v2 + 0x2::table::remove<address, u64>(&mut 0x1::vector::borrow_mut<Campaign>(&mut arg0.campaigns, arg1).balances, v3));
        } else {
            0x2::table::add<address, u64>(&mut 0x1::vector::borrow_mut<Campaign>(&mut arg0.campaigns, arg1).balances, v3, v2);
        };
    }

    entry fun payback_usdc(arg0: &mut WrapperState, arg1: u64, arg2: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1 < 0x1::vector::length<Campaign>(&arg0.campaigns), 2);
        let v0 = 0x1::vector::borrow_mut<Campaign>(&mut arg0.campaigns, arg1);
        assert!(0x2::tx_context::sender(arg3) == v0.campaign_admin, 3);
        assert!(v0.borrowed_amount > 0, 2);
        assert!(!v0.repaid, 10);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg2) == 0x2::balance::value<OMG_PROTOCOL>(&v0.omg_usd_reserves), 11);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_reserves, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2));
        v0.repaid = true;
    }

    entry fun rescue_coin<T0>(arg0: &WrapperState, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg2);
    }

    entry fun transfer_reward_cap(arg0: RewardMintCap, arg1: address) {
        0x2::transfer::public_transfer<RewardMintCap>(arg0, arg1);
    }

    entry fun unwrap_usdc(arg0: &mut WrapperState, arg1: 0x2::coin::Coin<OMG_PROTOCOL>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<OMG_PROTOCOL>(&arg1);
        assert!(v0 > 0, 2);
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.usdc_reserves) >= v0, 4);
        let v1 = 0x2::tx_context::sender(arg2);
        0x2::coin::burn<OMG_PROTOCOL>(&mut arg0.treasury_cap, arg1);
        arg0.total_wrapped = arg0.total_wrapped - v0;
        let v2 = UnwrapEvent{
            user      : v1,
            amount    : v0,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<UnwrapEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_reserves, v0), arg2), v1);
    }

    entry fun update_admin(arg0: &mut WrapperState, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3);
        arg0.admin = arg1;
    }

    entry fun update_campaign_admin(arg0: &mut WrapperState, arg1: u64, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 3);
        assert!(arg1 < 0x1::vector::length<Campaign>(&arg0.campaigns), 2);
        0x1::vector::borrow_mut<Campaign>(&mut arg0.campaigns, arg1).campaign_admin = arg2;
    }

    entry fun update_campaign_rewards(arg0: &mut WrapperState, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == 0x1::vector::borrow<Campaign>(&arg0.campaigns, arg1).campaign_admin, 3);
        assert!(arg1 < 0x1::vector::length<Campaign>(&arg0.campaigns), 2);
        update_campaign_rewards_(arg0, arg1, arg2, arg3);
    }

    fun update_campaign_rewards_(arg0: &mut WrapperState, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow_mut<Campaign>(&mut arg0.campaigns, arg1);
        assert!(v0.launch_time > 0, 2);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 >= v0.launch_time, 5);
        let v2 = v1 - v0.last_updated;
        let v3 = v2;
        if (v1 > v0.launch_time + v0.campaign_length) {
            v3 = v0.launch_time + v0.campaign_length - v0.last_updated;
        } else {
            assert!(v2 > 86400000, 2);
        };
        if (v3 == 0) {
            return
        };
        let v4 = v3 * v0.reward_rate * 0x2::balance::value<OMG_PROTOCOL>(&v0.omg_usd_reserves) / 1000000;
        if (v4 == 0) {
            return
        };
        arg0.total_wrapped = arg0.total_wrapped + v4;
        0x2::balance::join<OMG_PROTOCOL>(&mut v0.omg_usd_reserves, 0x2::coin::into_balance<OMG_PROTOCOL>(0x2::coin::mint<OMG_PROTOCOL>(&mut arg0.treasury_cap, v4, arg3)));
        v0.last_updated = v1;
    }

    entry fun update_reward_rate(arg0: &mut WrapperState, arg1: &RewardMintCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == 0x1::vector::borrow<Campaign>(&arg0.campaigns, arg2).campaign_admin, 3);
        assert!(arg2 < 0x1::vector::length<Campaign>(&arg0.campaigns), 2);
        update_campaign_rewards_(arg0, arg2, arg4, arg5);
        0x1::vector::borrow_mut<Campaign>(&mut arg0.campaigns, arg2).reward_rate = arg3;
    }

    entry fun withdraw_omg_usd(arg0: &mut WrapperState, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1 < 0x1::vector::length<Campaign>(&arg0.campaigns), 2);
        let v1 = 0x1::vector::borrow_mut<Campaign>(&mut arg0.campaigns, arg1);
        assert!(v1.money_collected, 2);
        assert!(0x2::clock::timestamp_ms(arg2) >= v1.launch_time + v1.campaign_length, 7);
        assert!(v1.repaid, 9);
        assert!(0x2::table::contains<address, u64>(&v1.balances, v0), 8);
        let v2 = 0x2::table::remove<address, u64>(&mut v1.balances, v0);
        let v3 = v1.total_shares;
        let v4 = if (v2 == v3) {
            0x2::balance::value<OMG_PROTOCOL>(&v1.omg_usd_reserves)
        } else {
            v2 * 0x2::balance::value<OMG_PROTOCOL>(&v1.omg_usd_reserves) / v3
        };
        v1.total_shares = v1.total_shares - v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<OMG_PROTOCOL>>(0x2::coin::from_balance<OMG_PROTOCOL>(0x2::balance::split<OMG_PROTOCOL>(&mut v1.omg_usd_reserves, v4), arg3), v0);
    }

    entry fun wrap_usdc(arg0: &mut WrapperState, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1);
        assert!(v0 > 0, 2);
        let v1 = 0x2::tx_context::sender(arg2);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.usdc_reserves, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1));
        arg0.total_wrapped = arg0.total_wrapped + v0;
        let v2 = WrapEvent{
            user      : v1,
            amount    : v0,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<WrapEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<OMG_PROTOCOL>>(0x2::coin::mint<OMG_PROTOCOL>(&mut arg0.treasury_cap, v0, arg2), v1);
    }

    // decompiled from Move bytecode v6
}

