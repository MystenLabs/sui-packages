module 0xa884fdd0bce1fb69f9c1032eaeff0891292df5dc199aa832aa45953e9c2d9c2d::premium_subscription {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SubscriptionNFT has store, key {
        id: 0x2::object::UID,
        tier: u8,
        expires_at: u64,
        user_address: address,
        issued_at: u64,
        auto_renew: bool,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        owner: address,
        total_revenue: u64,
        total_subscriptions: u64,
    }

    struct PricingConfig has key {
        id: 0x2::object::UID,
        pro_monthly: u64,
        pro_yearly: u64,
        team_monthly: u64,
        team_yearly: u64,
        enterprise_monthly: u64,
        enterprise_yearly: u64,
    }

    struct SubscriptionPurchased has copy, drop {
        nft_id: 0x2::object::ID,
        buyer: address,
        tier: u8,
        duration_months: u8,
        amount_paid: u64,
        expires_at: u64,
        timestamp: u64,
    }

    struct SubscriptionRenewed has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        tier: u8,
        new_expiry: u64,
        amount_paid: u64,
        timestamp: u64,
    }

    struct SubscriptionCancelled has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        tier: u8,
        timestamp: u64,
    }

    struct PricingUpdated has copy, drop {
        tier: u8,
        duration_months: u8,
        old_price: u64,
        new_price: u64,
        timestamp: u64,
    }

    struct FundsWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
        timestamp: u64,
    }

    public entry fun cancel_subscription(arg0: SubscriptionNFT, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.user_address == 0x2::tx_context::sender(arg2), 3);
        let v0 = SubscriptionCancelled{
            nft_id    : 0x2::object::id<SubscriptionNFT>(&arg0),
            owner     : 0x2::tx_context::sender(arg2),
            tier      : arg0.tier,
            timestamp : 0x2::clock::timestamp_ms(arg1) / 1000,
        };
        0x2::event::emit<SubscriptionCancelled>(v0);
        let SubscriptionNFT {
            id           : v1,
            tier         : _,
            expires_at   : _,
            user_address : _,
            issued_at    : _,
            auto_renew   : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    public fun get_all_pricing(arg0: &PricingConfig) : (u64, u64, u64, u64, u64, u64) {
        (arg0.pro_monthly, arg0.pro_yearly, arg0.team_monthly, arg0.team_yearly, arg0.enterprise_monthly, arg0.enterprise_yearly)
    }

    public fun get_days_remaining(arg0: &SubscriptionNFT, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        if (arg0.expires_at <= v0) {
            0
        } else {
            (arg0.expires_at - v0) / 86400
        }
    }

    public fun get_details(arg0: &SubscriptionNFT) : (u8, u64, address, u64, bool) {
        (arg0.tier, arg0.expires_at, arg0.user_address, arg0.issued_at, arg0.auto_renew)
    }

    public fun get_expiry(arg0: &SubscriptionNFT) : u64 {
        arg0.expires_at
    }

    public fun get_price(arg0: &PricingConfig, arg1: u8, arg2: u8) : u64 {
        if (arg1 == 1) {
            if (arg2 == 1) {
                arg0.pro_monthly
            } else {
                arg0.pro_yearly
            }
        } else if (arg1 == 2) {
            if (arg2 == 1) {
                arg0.team_monthly
            } else {
                arg0.team_yearly
            }
        } else if (arg2 == 1) {
            arg0.enterprise_monthly
        } else {
            arg0.enterprise_yearly
        }
    }

    public fun get_tier(arg0: &SubscriptionNFT) : u8 {
        arg0.tier
    }

    public fun get_treasury_balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_treasury_stats(arg0: &Treasury) : (u64, u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.balance), arg0.total_revenue, arg0.total_subscriptions)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Treasury{
            id                  : 0x2::object::new(arg0),
            balance             : 0x2::balance::zero<0x2::sui::SUI>(),
            owner               : 0x2::tx_context::sender(arg0),
            total_revenue       : 0,
            total_subscriptions : 0,
        };
        0x2::transfer::share_object<Treasury>(v1);
        let v2 = PricingConfig{
            id                 : 0x2::object::new(arg0),
            pro_monthly        : 10000000000,
            pro_yearly         : 100000000000,
            team_monthly       : 50000000000,
            team_yearly        : 500000000000,
            enterprise_monthly : 200000000000,
            enterprise_yearly  : 2000000000000,
        };
        0x2::transfer::share_object<PricingConfig>(v2);
    }

    public fun is_active(arg0: &SubscriptionNFT, arg1: &0x2::clock::Clock) : bool {
        arg0.expires_at > 0x2::clock::timestamp_ms(arg1) / 1000
    }

    public entry fun purchase_subscription(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: u8, arg3: &mut Treasury, arg4: &PricingConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 1 && arg1 <= 3, 0);
        assert!(arg2 == 1 || arg2 == 12, 1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 >= get_price(arg4, arg1, arg2), 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg3.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
        arg3.total_revenue = arg3.total_revenue + v0;
        arg3.total_subscriptions = arg3.total_subscriptions + 1;
        let v1 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let v2 = v1 + (arg2 as u64) * 2592000;
        let v3 = SubscriptionNFT{
            id           : 0x2::object::new(arg6),
            tier         : arg1,
            expires_at   : v2,
            user_address : 0x2::tx_context::sender(arg6),
            issued_at    : v1,
            auto_renew   : false,
        };
        let v4 = SubscriptionPurchased{
            nft_id          : 0x2::object::id<SubscriptionNFT>(&v3),
            buyer           : 0x2::tx_context::sender(arg6),
            tier            : arg1,
            duration_months : arg2,
            amount_paid     : v0,
            expires_at      : v2,
            timestamp       : v1,
        };
        0x2::event::emit<SubscriptionPurchased>(v4);
        0x2::transfer::transfer<SubscriptionNFT>(v3, 0x2::tx_context::sender(arg6));
    }

    public entry fun renew_subscription(arg0: &mut SubscriptionNFT, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u8, arg3: &mut Treasury, arg4: &PricingConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.user_address == 0x2::tx_context::sender(arg6), 3);
        assert!(arg2 == 1 || arg2 == 12, 1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= get_price(arg4, arg0.tier, arg2), 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg3.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg3.total_revenue = arg3.total_revenue + v0;
        let v1 = 0x2::clock::timestamp_ms(arg5) / 1000;
        if (arg0.expires_at < v1) {
            arg0.expires_at = v1 + (arg2 as u64) * 2592000;
        } else {
            arg0.expires_at = arg0.expires_at + (arg2 as u64) * 2592000;
        };
        let v2 = SubscriptionRenewed{
            nft_id      : 0x2::object::id<SubscriptionNFT>(arg0),
            owner       : 0x2::tx_context::sender(arg6),
            tier        : arg0.tier,
            new_expiry  : arg0.expires_at,
            amount_paid : v0,
            timestamp   : v1,
        };
        0x2::event::emit<SubscriptionRenewed>(v2);
    }

    public entry fun set_auto_renew(arg0: &mut SubscriptionNFT, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.user_address == 0x2::tx_context::sender(arg2), 3);
        arg0.auto_renew = arg1;
    }

    public entry fun transfer_admin(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public entry fun update_pricing(arg0: &AdminCap, arg1: &mut PricingConfig, arg2: u8, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock) {
        assert!(arg2 >= 1 && arg2 <= 3, 0);
        assert!(arg3 == 1 || arg3 == 12, 1);
        if (arg2 == 1) {
            if (arg3 == 1) {
                arg1.pro_monthly = arg4;
            } else {
                arg1.pro_yearly = arg4;
            };
        } else if (arg2 == 2) {
            if (arg3 == 1) {
                arg1.team_monthly = arg4;
            } else {
                arg1.team_yearly = arg4;
            };
        } else if (arg3 == 1) {
            arg1.enterprise_monthly = arg4;
        } else {
            arg1.enterprise_yearly = arg4;
        };
        let v0 = PricingUpdated{
            tier            : arg2,
            duration_months : arg3,
            old_price       : get_price(arg1, arg2, arg3),
            new_price       : arg4,
            timestamp       : 0x2::clock::timestamp_ms(arg5) / 1000,
        };
        0x2::event::emit<PricingUpdated>(v0);
    }

    public entry fun withdraw_funds(arg0: &AdminCap, arg1: &mut Treasury, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.owner;
        let v1 = FundsWithdrawn{
            amount    : arg2,
            recipient : v0,
            timestamp : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<FundsWithdrawn>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, arg2, arg4), v0);
    }

    // decompiled from Move bytecode v6
}

