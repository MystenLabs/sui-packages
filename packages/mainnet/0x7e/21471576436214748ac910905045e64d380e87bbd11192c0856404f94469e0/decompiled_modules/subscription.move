module 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::subscription {
    struct SUBSCRIPTION has drop {
        dummy_field: bool,
    }

    struct SubscriptionStore has key {
        id: 0x2::object::UID,
        version: u64,
        standard_price_usdsui: u64,
        vip_price_usdsui: u64,
        standard_bonus_bps: u64,
        vip_bonus_bps: u64,
        total_passes_minted: u64,
        total_standard_subscriptions: u64,
        total_vip_subscriptions: u64,
        total_upgrades: u64,
        total_renewals: u64,
        total_revenue_usdsui: u64,
        active_standard_count: u64,
        active_vip_count: u64,
        treasury: 0x2::balance::Balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>,
    }

    struct ZenkoPass has key {
        id: 0x2::object::UID,
        account_id: 0x2::object::ID,
        tier: u8,
        expiration: u64,
        renewal_count: u64,
        created_at: u64,
        last_updated: u64,
    }

    struct SubscriptionMinted has copy, drop {
        subscription_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        owner: address,
        tier: u8,
        tier_name: 0x1::string::String,
        price_paid: u64,
        expiration: u64,
    }

    struct SubscriptionRenewed has copy, drop {
        subscription_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        tier: u8,
        tier_name: 0x1::string::String,
        price_paid: u64,
        old_expiration: u64,
        new_expiration: u64,
    }

    struct SubscriptionUpgraded has copy, drop {
        old_subscription_id: 0x2::object::ID,
        new_subscription_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        old_tier: u8,
        new_tier: u8,
        price_paid: u64,
        new_expiration: u64,
    }

    struct PassPriceUpdated has copy, drop {
        tier: u8,
        tier_name: 0x1::string::String,
        old_price: u64,
        new_price: u64,
        updated_by: address,
    }

    struct PassBonusUpdated has copy, drop {
        tier: u8,
        tier_name: 0x1::string::String,
        old_bonus_bps: u64,
        new_bonus_bps: u64,
        updated_by: address,
    }

    struct FreeSubscriptionGranted has copy, drop {
        subscription_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        recipient: address,
        tier: u8,
        tier_name: 0x1::string::String,
        duration_ms: u64,
        granted_by: address,
    }

    struct SubscriptionRevenueWithdrawn has copy, drop {
        withdrawn_by: address,
        amount: u64,
        remaining_balance: u64,
    }

    fun assert_version(arg0: &SubscriptionStore) {
        assert!(arg0.version == 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::config::current_version(), 11);
    }

    public fun calculate_purchase_bonus(arg0: &SubscriptionStore, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::Account, arg2: &ZenkoPass, arg3: u64, arg4: u64) : (u64, u64, u8) {
        if (arg2.account_id != 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::id(arg1)) {
            return (0, 0, 0)
        };
        if (0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::subscription_id(arg1) != 0x1::option::some<0x2::object::ID>(0x2::object::id<ZenkoPass>(arg2))) {
            return (0, 0, 0)
        };
        if (arg2.expiration < arg4) {
            return (0, 0, 0)
        };
        let v0 = if (arg2.tier == 1) {
            arg0.standard_bonus_bps
        } else if (arg2.tier == 2) {
            arg0.vip_bonus_bps
        } else {
            return (0, 0, 0)
        };
        (arg3 * v0 / 10000, v0, arg2.tier)
    }

    fun collect_payment(arg0: &mut 0x2::balance::Balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>, arg1: 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>, arg2: u64) {
        assert!(0x2::coin::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg1) == arg2, 3);
        0x2::coin::put<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(arg0, arg1);
    }

    public fun grant_free(arg0: &mut SubscriptionStore, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::Account, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_operations(arg1, arg6);
        assert_version(arg0);
        assert!(arg4 == 1 || arg4 == 2, 1);
        let v0 = 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::subscription_id(arg3);
        assert!(0x1::option::is_none<0x2::object::ID>(&v0), 2);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::id(arg3);
        let v3 = 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::owner_address(arg3);
        arg0.total_passes_minted = arg0.total_passes_minted + 1;
        if (arg4 == 1) {
            arg0.total_standard_subscriptions = arg0.total_standard_subscriptions + 1;
            arg0.active_standard_count = arg0.active_standard_count + 1;
        } else {
            arg0.total_vip_subscriptions = arg0.total_vip_subscriptions + 1;
            arg0.active_vip_count = arg0.active_vip_count + 1;
        };
        let v4 = ZenkoPass{
            id            : 0x2::object::new(arg6),
            account_id    : v2,
            tier          : arg4,
            expiration    : v1 + arg5,
            renewal_count : 0,
            created_at    : v1,
            last_updated  : v1,
        };
        let v5 = 0x2::object::id<ZenkoPass>(&v4);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::set_subscription(arg3, v5, arg6);
        let v6 = FreeSubscriptionGranted{
            subscription_id : v5,
            account_id      : v2,
            recipient       : v3,
            tier            : arg4,
            tier_name       : tier_name(arg4),
            duration_ms     : arg5,
            granted_by      : 0x2::tx_context::sender(arg6),
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<FreeSubscriptionGranted>(v6);
        0x2::transfer::transfer<ZenkoPass>(v4, v3);
    }

    fun init(arg0: SUBSCRIPTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SUBSCRIPTION>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"tier"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"ZenkoPass {tier}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Premium subscription for the Zenko gaming platform. Earn bonus credits on every purchase."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://zenko.gg/nft/zenkopass/{tier}.png"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{tier}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://zenko.gg"));
        let v5 = 0x2::display::new_with_fields<ZenkoPass>(&v0, v1, v3, arg1);
        0x2::display::update_version<ZenkoPass>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<ZenkoPass>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = SubscriptionStore{
            id                           : 0x2::object::new(arg1),
            version                      : 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::config::current_version(),
            standard_price_usdsui        : 9990000,
            vip_price_usdsui             : 24990000,
            standard_bonus_bps           : 1000,
            vip_bonus_bps                : 3500,
            total_passes_minted          : 0,
            total_standard_subscriptions : 0,
            total_vip_subscriptions      : 0,
            total_upgrades               : 0,
            total_renewals               : 0,
            total_revenue_usdsui         : 0,
            active_standard_count        : 0,
            active_vip_count             : 0,
            treasury                     : 0x2::balance::zero<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(),
        };
        0x2::transfer::share_object<SubscriptionStore>(v6);
    }

    public fun migrate_subscription_store(arg0: &mut SubscriptionStore, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg2: &0x2::tx_context::TxContext) {
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_super_admin(arg1, arg2);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::version::migrate(&mut arg0.version, 0x2::object::id<SubscriptionStore>(arg0));
    }

    public fun mint_and_return(arg0: &mut SubscriptionStore, arg1: &0x2::clock::Clock, arg2: &mut 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::Account, arg3: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::AccountAuth, arg4: 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) : ZenkoPass {
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::verify_auth(arg2, arg3);
        assert_version(arg0);
        mint_pass(arg0, arg1, arg2, arg4, arg5, arg6)
    }

    fun mint_pass(arg0: &mut SubscriptionStore, arg1: &0x2::clock::Clock, arg2: &mut 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::Account, arg3: 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) : ZenkoPass {
        assert!(arg4 == 1 || arg4 == 2, 1);
        let v0 = 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::subscription_id(arg2);
        assert!(0x1::option::is_none<0x2::object::ID>(&v0), 2);
        let (v1, v2, v3) = if (arg4 == 1) {
            arg0.total_standard_subscriptions = arg0.total_standard_subscriptions + 1;
            arg0.active_standard_count = arg0.active_standard_count + 1;
            (arg0.standard_price_usdsui, 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::config::rep_subscribe_standard(), b"subscribe_standard")
        } else {
            arg0.total_vip_subscriptions = arg0.total_vip_subscriptions + 1;
            arg0.active_vip_count = arg0.active_vip_count + 1;
            (arg0.vip_price_usdsui, 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::config::rep_subscribe_vip(), b"subscribe_vip")
        };
        let v4 = 0x2::clock::timestamp_ms(arg1);
        let v5 = 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::id(arg2);
        let v6 = v4 + 2592000000;
        let v7 = &mut arg0.treasury;
        collect_payment(v7, arg3, v1);
        arg0.total_passes_minted = arg0.total_passes_minted + 1;
        arg0.total_revenue_usdsui = arg0.total_revenue_usdsui + v1;
        let v8 = ZenkoPass{
            id            : 0x2::object::new(arg5),
            account_id    : v5,
            tier          : arg4,
            expiration    : v6,
            renewal_count : 0,
            created_at    : v4,
            last_updated  : v4,
        };
        let v9 = 0x2::object::id<ZenkoPass>(&v8);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::set_subscription(arg2, v9, arg5);
        if (v2 > 0) {
            0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::adjust_reputation_(arg2, v2, true, 0x1::string::utf8(v3), arg5);
        };
        let v10 = SubscriptionMinted{
            subscription_id : v9,
            account_id      : v5,
            owner           : 0x2::tx_context::sender(arg5),
            tier            : arg4,
            tier_name       : tier_name(arg4),
            price_paid      : v1,
            expiration      : v6,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<SubscriptionMinted>(v10);
        v8
    }

    public fun renew(arg0: &mut SubscriptionStore, arg1: &0x2::clock::Clock, arg2: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::Account, arg3: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::AccountAuth, arg4: &mut ZenkoPass, arg5: 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>, arg6: &mut 0x2::tx_context::TxContext) {
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::verify_auth(arg2, arg3);
        assert_version(arg0);
        let v0 = 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::id(arg2);
        assert!(arg4.account_id == v0, 7);
        assert!(0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::subscription_id(arg2) == 0x1::option::some<0x2::object::ID>(0x2::object::id<ZenkoPass>(arg4)), 5);
        let v1 = if (arg4.tier == 1) {
            arg0.standard_price_usdsui
        } else {
            assert!(arg4.tier == 2, 1);
            arg0.vip_price_usdsui
        };
        let v2 = 0x2::clock::timestamp_ms(arg1);
        let v3 = arg4.expiration;
        let v4 = if (v3 > v2) {
            v3 + 2592000000
        } else {
            v2 + 2592000000
        };
        let v5 = &mut arg0.treasury;
        collect_payment(v5, arg5, v1);
        arg4.expiration = v4;
        arg4.renewal_count = arg4.renewal_count + 1;
        arg4.last_updated = v2;
        arg0.total_renewals = arg0.total_renewals + 1;
        arg0.total_revenue_usdsui = arg0.total_revenue_usdsui + v1;
        if (arg4.tier == 1) {
            arg0.total_standard_subscriptions = arg0.total_standard_subscriptions + 1;
        } else {
            arg0.total_vip_subscriptions = arg0.total_vip_subscriptions + 1;
        };
        let v6 = SubscriptionRenewed{
            subscription_id : 0x2::object::id<ZenkoPass>(arg4),
            account_id      : v0,
            tier            : arg4.tier,
            tier_name       : tier_name(arg4.tier),
            price_paid      : v1,
            old_expiration  : v3,
            new_expiration  : v4,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<SubscriptionRenewed>(v6);
    }

    public fun set_standard_bonus(arg0: &mut SubscriptionStore, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_admin(arg1, arg3);
        assert!(arg2 <= 10000, 6);
        arg0.standard_bonus_bps = arg2;
        let v0 = PassBonusUpdated{
            tier          : 1,
            tier_name     : 0x1::string::utf8(b"Standard"),
            old_bonus_bps : arg0.standard_bonus_bps,
            new_bonus_bps : arg2,
            updated_by    : 0x2::tx_context::sender(arg3),
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<PassBonusUpdated>(v0);
    }

    public fun set_standard_price(arg0: &mut SubscriptionStore, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_admin(arg1, arg3);
        arg0.standard_price_usdsui = arg2;
        let v0 = PassPriceUpdated{
            tier       : 1,
            tier_name  : 0x1::string::utf8(b"Standard"),
            old_price  : arg0.standard_price_usdsui,
            new_price  : arg2,
            updated_by : 0x2::tx_context::sender(arg3),
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<PassPriceUpdated>(v0);
    }

    public fun set_vip_bonus(arg0: &mut SubscriptionStore, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_admin(arg1, arg3);
        assert!(arg2 <= 10000, 6);
        arg0.vip_bonus_bps = arg2;
        let v0 = PassBonusUpdated{
            tier          : 2,
            tier_name     : 0x1::string::utf8(b"VIP"),
            old_bonus_bps : arg0.vip_bonus_bps,
            new_bonus_bps : arg2,
            updated_by    : 0x2::tx_context::sender(arg3),
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<PassBonusUpdated>(v0);
    }

    public fun set_vip_price(arg0: &mut SubscriptionStore, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_admin(arg1, arg3);
        arg0.vip_price_usdsui = arg2;
        let v0 = PassPriceUpdated{
            tier       : 2,
            tier_name  : 0x1::string::utf8(b"VIP"),
            old_price  : arg0.vip_price_usdsui,
            new_price  : arg2,
            updated_by : 0x2::tx_context::sender(arg3),
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<PassPriceUpdated>(v0);
    }

    fun tier_name(arg0: u8) : 0x1::string::String {
        if (arg0 == 1) {
            0x1::string::utf8(b"Standard")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"VIP")
        } else {
            0x1::string::utf8(b"Unknown")
        }
    }

    public fun transfer_to_owner(arg0: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::Account, arg1: ZenkoPass) {
        assert!(arg1.account_id == 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::id(arg0), 7);
        0x2::transfer::transfer<ZenkoPass>(arg1, 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::owner_address(arg0));
    }

    public fun upgrade_to_vip(arg0: &mut SubscriptionStore, arg1: &0x2::clock::Clock, arg2: &mut 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::Account, arg3: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::AccountAuth, arg4: ZenkoPass, arg5: 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>, arg6: &mut 0x2::tx_context::TxContext) : ZenkoPass {
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::verify_auth(arg2, arg3);
        assert_version(arg0);
        let v0 = 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::id(arg2);
        assert!(arg4.account_id == v0, 7);
        assert!(arg4.tier == 1, 4);
        assert!(0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::subscription_id(arg2) == 0x1::option::some<0x2::object::ID>(0x2::object::id<ZenkoPass>(&arg4)), 5);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg4.expiration > v1, 9);
        let v2 = arg0.vip_price_usdsui - arg0.standard_price_usdsui;
        let v3 = &mut arg0.treasury;
        collect_payment(v3, arg5, v2);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::clear_subscription(arg2, arg6);
        let ZenkoPass {
            id            : v4,
            account_id    : _,
            tier          : _,
            expiration    : _,
            renewal_count : v8,
            created_at    : v9,
            last_updated  : _,
        } = arg4;
        0x2::object::delete(v4);
        let v11 = ZenkoPass{
            id            : 0x2::object::new(arg6),
            account_id    : v0,
            tier          : 2,
            expiration    : v1 + 2592000000,
            renewal_count : v8,
            created_at    : v9,
            last_updated  : v1,
        };
        let v12 = 0x2::object::id<ZenkoPass>(&v11);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::set_subscription(arg2, v12, arg6);
        let v13 = 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::config::rep_subscribe_vip() - 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::config::rep_subscribe_standard();
        if (v13 > 0) {
            0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::account::adjust_reputation_(arg2, v13, true, 0x1::string::utf8(b"subscribe_vip"), arg6);
        };
        arg0.total_upgrades = arg0.total_upgrades + 1;
        arg0.total_vip_subscriptions = arg0.total_vip_subscriptions + 1;
        arg0.total_revenue_usdsui = arg0.total_revenue_usdsui + v2;
        arg0.active_standard_count = arg0.active_standard_count - 1;
        arg0.active_vip_count = arg0.active_vip_count + 1;
        let v14 = SubscriptionUpgraded{
            old_subscription_id : 0x2::object::id<ZenkoPass>(&arg4),
            new_subscription_id : v12,
            account_id          : v0,
            old_tier            : 1,
            new_tier            : 2,
            price_paid          : v2,
            new_expiration      : v11.expiration,
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<SubscriptionUpgraded>(v14);
        v11
    }

    public fun withdraw_subscription_revenue(arg0: &mut SubscriptionStore, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI> {
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_treasury(arg1, arg3);
        assert_version(arg0);
        assert!(0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg0.treasury) >= arg2, 10);
        let v0 = SubscriptionRevenueWithdrawn{
            withdrawn_by      : 0x2::tx_context::sender(arg3),
            amount            : arg2,
            remaining_balance : 0x2::balance::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg0.treasury),
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<SubscriptionRevenueWithdrawn>(v0);
        0x2::coin::from_balance<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(0x2::balance::split<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&mut arg0.treasury, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

