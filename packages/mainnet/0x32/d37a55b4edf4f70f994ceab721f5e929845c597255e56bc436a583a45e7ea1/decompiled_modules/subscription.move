module 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::subscription {
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
    }

    struct ZenkoPass has store, key {
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
        timestamp: u64,
    }

    struct SubscriptionRenewed has copy, drop {
        subscription_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        tier: u8,
        tier_name: 0x1::string::String,
        price_paid: u64,
        old_expiration: u64,
        new_expiration: u64,
        timestamp: u64,
    }

    struct SubscriptionUpgraded has copy, drop {
        old_subscription_id: 0x2::object::ID,
        new_subscription_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        old_tier: u8,
        new_tier: u8,
        price_paid: u64,
        new_expiration: u64,
        timestamp: u64,
    }

    struct BonusCreditsApplied has copy, drop {
        account_id: 0x2::object::ID,
        pass_tier: u8,
        purchase_amount: u64,
        bonus_amount: u64,
        bonus_percentage: u64,
        timestamp: u64,
    }

    struct PassPriceUpdated has copy, drop {
        tier: u8,
        tier_name: 0x1::string::String,
        old_price: u64,
        new_price: u64,
        updated_by: address,
        timestamp: u64,
    }

    struct PassBonusUpdated has copy, drop {
        tier: u8,
        tier_name: 0x1::string::String,
        old_bonus_bps: u64,
        new_bonus_bps: u64,
        updated_by: address,
        timestamp: u64,
    }

    struct FreeSubscriptionGranted has copy, drop {
        subscription_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        recipient: address,
        tier: u8,
        tier_name: 0x1::string::String,
        duration_ms: u64,
        granted_by: address,
        timestamp: u64,
    }

    public fun subscription_id(arg0: &ZenkoPass) : 0x2::object::ID {
        0x2::object::id<ZenkoPass>(arg0)
    }

    public fun bonus_percentages(arg0: &SubscriptionStore) : (u64, u64) {
        (arg0.standard_bonus_bps, arg0.vip_bonus_bps)
    }

    public fun calculate_purchase_bonus(arg0: &SubscriptionStore, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account, arg2: &ZenkoPass, arg3: u64, arg4: u64) : (u64, u64, u8) {
        if (arg2.account_id != 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::id(arg1)) {
            return (0, 0, 0)
        };
        if (0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::subscription_id(arg1) != 0x1::option::some<0x2::object::ID>(0x2::object::id<ZenkoPass>(arg2))) {
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

    public fun check_subscription_status(arg0: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account, arg1: &ZenkoPass, arg2: u64) : (bool, u8, u64) {
        let v0 = 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::subscription_id(arg0);
        if (0x1::option::is_none<0x2::object::ID>(&v0)) {
            return (false, 0, 0)
        };
        if (*0x1::option::borrow<0x2::object::ID>(&v0) != 0x2::object::id<ZenkoPass>(arg1)) {
            return (false, 0, 0)
        };
        if (arg1.account_id != 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::id(arg0)) {
            return (false, 0, 0)
        };
        if (arg1.expiration < arg2) {
            return (false, arg1.tier, 0)
        };
        (true, arg1.tier, arg1.expiration - arg2)
    }

    public fun created_at(arg0: &ZenkoPass) : u64 {
        arg0.created_at
    }

    public(friend) fun emit_bonus_applied_event(arg0: 0x2::object::ID, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = BonusCreditsApplied{
            account_id       : arg0,
            pass_tier        : arg1,
            purchase_amount  : arg2,
            bonus_amount     : arg3,
            bonus_percentage : arg4,
            timestamp        : arg5,
        };
        0x2::event::emit<BonusCreditsApplied>(v0);
    }

    public fun expiration(arg0: &ZenkoPass) : u64 {
        arg0.expiration
    }

    public fun grant_free(arg0: &mut SubscriptionStore, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg2: &mut 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account, arg3: u8, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_operations(arg1, arg5);
        assert!(arg3 == 1 || arg3 == 2, 1);
        let v0 = 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::subscription_id(arg2);
        assert!(0x1::option::is_none<0x2::object::ID>(&v0), 2);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg5);
        let v2 = 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::id(arg2);
        let v3 = 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::owner_address(arg2);
        arg0.total_passes_minted = arg0.total_passes_minted + 1;
        if (arg3 == 1) {
            arg0.total_standard_subscriptions = arg0.total_standard_subscriptions + 1;
            arg0.active_standard_count = arg0.active_standard_count + 1;
        } else {
            arg0.total_vip_subscriptions = arg0.total_vip_subscriptions + 1;
            arg0.active_vip_count = arg0.active_vip_count + 1;
        };
        let v4 = ZenkoPass{
            id            : 0x2::object::new(arg5),
            account_id    : v2,
            tier          : arg3,
            expiration    : v1 + arg4,
            renewal_count : 0,
            created_at    : v1,
            last_updated  : v1,
        };
        let v5 = 0x2::object::id<ZenkoPass>(&v4);
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::set_subscription(arg2, v5, arg5);
        let v6 = FreeSubscriptionGranted{
            subscription_id : v5,
            account_id      : v2,
            recipient       : v3,
            tier            : arg3,
            tier_name       : tier_name(arg3),
            duration_ms     : arg4,
            granted_by      : 0x2::tx_context::sender(arg5),
            timestamp       : v1,
        };
        0x2::event::emit<FreeSubscriptionGranted>(v6);
        0x2::transfer::public_transfer<ZenkoPass>(v4, v3);
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
            version                      : 1,
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
        };
        0x2::transfer::share_object<SubscriptionStore>(v6);
    }

    public fun is_active(arg0: &ZenkoPass, arg1: u64) : bool {
        arg0.expiration >= arg1
    }

    public fun last_updated(arg0: &ZenkoPass) : u64 {
        arg0.last_updated
    }

    public fun mint_standard(arg0: &mut SubscriptionStore, arg1: &0x2::clock::Clock, arg2: &mut 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account, arg3: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::AccountAuth, arg4: 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>, arg5: &mut 0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::verify_auth(arg2, arg3);
        let v0 = 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::subscription_id(arg2);
        assert!(0x1::option::is_none<0x2::object::ID>(&v0), 2);
        let v1 = arg0.standard_price_usdsui;
        assert!(0x2::coin::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg4) >= v1, 3);
        let v2 = 0x2::clock::timestamp_ms(arg1);
        let v3 = 0x2::tx_context::sender(arg5);
        let v4 = 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::id(arg2);
        let v5 = v2 + 2592000000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>>(arg4, @0x0);
        arg0.total_passes_minted = arg0.total_passes_minted + 1;
        arg0.total_standard_subscriptions = arg0.total_standard_subscriptions + 1;
        arg0.total_revenue_usdsui = arg0.total_revenue_usdsui + v1;
        arg0.active_standard_count = arg0.active_standard_count + 1;
        let v6 = ZenkoPass{
            id            : 0x2::object::new(arg5),
            account_id    : v4,
            tier          : 1,
            expiration    : v5,
            renewal_count : 0,
            created_at    : v2,
            last_updated  : v2,
        };
        let v7 = 0x2::object::id<ZenkoPass>(&v6);
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::set_subscription(arg2, v7, arg5);
        let v8 = 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::config::rep_subscribe_standard();
        if (v8 > 0) {
            0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::adjust_reputation_(arg2, v8, true, 0x1::string::utf8(b"subscribe_standard"), arg5);
        };
        let v9 = SubscriptionMinted{
            subscription_id : v7,
            account_id      : v4,
            owner           : v3,
            tier            : 1,
            tier_name       : 0x1::string::utf8(b"Standard"),
            price_paid      : v1,
            expiration      : v5,
            timestamp       : v2,
        };
        0x2::event::emit<SubscriptionMinted>(v9);
        0x2::transfer::public_transfer<ZenkoPass>(v6, v3);
    }

    public fun mint_vip(arg0: &mut SubscriptionStore, arg1: &0x2::clock::Clock, arg2: &mut 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account, arg3: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::AccountAuth, arg4: 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>, arg5: &mut 0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::verify_auth(arg2, arg3);
        let v0 = 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::subscription_id(arg2);
        assert!(0x1::option::is_none<0x2::object::ID>(&v0), 2);
        let v1 = arg0.vip_price_usdsui;
        assert!(0x2::coin::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg4) >= v1, 3);
        let v2 = 0x2::clock::timestamp_ms(arg1);
        let v3 = 0x2::tx_context::sender(arg5);
        let v4 = 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::id(arg2);
        let v5 = v2 + 2592000000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>>(arg4, @0x0);
        arg0.total_passes_minted = arg0.total_passes_minted + 1;
        arg0.total_vip_subscriptions = arg0.total_vip_subscriptions + 1;
        arg0.total_revenue_usdsui = arg0.total_revenue_usdsui + v1;
        arg0.active_vip_count = arg0.active_vip_count + 1;
        let v6 = ZenkoPass{
            id            : 0x2::object::new(arg5),
            account_id    : v4,
            tier          : 2,
            expiration    : v5,
            renewal_count : 0,
            created_at    : v2,
            last_updated  : v2,
        };
        let v7 = 0x2::object::id<ZenkoPass>(&v6);
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::set_subscription(arg2, v7, arg5);
        let v8 = 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::config::rep_subscribe_vip();
        if (v8 > 0) {
            0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::adjust_reputation_(arg2, v8, true, 0x1::string::utf8(b"subscribe_vip"), arg5);
        };
        let v9 = SubscriptionMinted{
            subscription_id : v7,
            account_id      : v4,
            owner           : v3,
            tier            : 2,
            tier_name       : 0x1::string::utf8(b"VIP"),
            price_paid      : v1,
            expiration      : v5,
            timestamp       : v2,
        };
        0x2::event::emit<SubscriptionMinted>(v9);
        0x2::transfer::public_transfer<ZenkoPass>(v6, v3);
    }

    public fun renew(arg0: &mut SubscriptionStore, arg1: &0x2::clock::Clock, arg2: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account, arg3: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::AccountAuth, arg4: &mut ZenkoPass, arg5: 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>, arg6: &mut 0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::verify_auth(arg2, arg3);
        let v0 = 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::id(arg2);
        assert!(arg4.account_id == v0, 7);
        assert!(0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::subscription_id(arg2) == 0x1::option::some<0x2::object::ID>(0x2::object::id<ZenkoPass>(arg4)), 5);
        let v1 = if (arg4.tier == 1) {
            arg0.standard_price_usdsui
        } else {
            assert!(arg4.tier == 2, 1);
            arg0.vip_price_usdsui
        };
        assert!(0x2::coin::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg5) >= v1, 3);
        let v2 = 0x2::clock::timestamp_ms(arg1);
        let v3 = arg4.expiration;
        let v4 = if (v3 > v2) {
            v3 + 2592000000
        } else {
            v2 + 2592000000
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>>(arg5, @0x0);
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
        let v5 = SubscriptionRenewed{
            subscription_id : 0x2::object::id<ZenkoPass>(arg4),
            account_id      : v0,
            tier            : arg4.tier,
            tier_name       : tier_name(arg4.tier),
            price_paid      : v1,
            old_expiration  : v3,
            new_expiration  : v4,
            timestamp       : v2,
        };
        0x2::event::emit<SubscriptionRenewed>(v5);
    }

    public fun renewal_count(arg0: &ZenkoPass) : u64 {
        arg0.renewal_count
    }

    public fun set_standard_bonus(arg0: &mut SubscriptionStore, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_admin(arg1, arg3);
        assert!(arg2 <= 10000, 6);
        arg0.standard_bonus_bps = arg2;
        let v0 = PassBonusUpdated{
            tier          : 1,
            tier_name     : 0x1::string::utf8(b"Standard"),
            old_bonus_bps : arg0.standard_bonus_bps,
            new_bonus_bps : arg2,
            updated_by    : 0x2::tx_context::sender(arg3),
            timestamp     : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<PassBonusUpdated>(v0);
    }

    public fun set_standard_price(arg0: &mut SubscriptionStore, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_admin(arg1, arg3);
        arg0.standard_price_usdsui = arg2;
        let v0 = PassPriceUpdated{
            tier       : 1,
            tier_name  : 0x1::string::utf8(b"Standard"),
            old_price  : arg0.standard_price_usdsui,
            new_price  : arg2,
            updated_by : 0x2::tx_context::sender(arg3),
            timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<PassPriceUpdated>(v0);
    }

    public fun set_vip_bonus(arg0: &mut SubscriptionStore, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_admin(arg1, arg3);
        assert!(arg2 <= 10000, 6);
        arg0.vip_bonus_bps = arg2;
        let v0 = PassBonusUpdated{
            tier          : 2,
            tier_name     : 0x1::string::utf8(b"VIP"),
            old_bonus_bps : arg0.vip_bonus_bps,
            new_bonus_bps : arg2,
            updated_by    : 0x2::tx_context::sender(arg3),
            timestamp     : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<PassBonusUpdated>(v0);
    }

    public fun set_vip_price(arg0: &mut SubscriptionStore, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_admin(arg1, arg3);
        arg0.vip_price_usdsui = arg2;
        let v0 = PassPriceUpdated{
            tier       : 2,
            tier_name  : 0x1::string::utf8(b"VIP"),
            old_price  : arg0.vip_price_usdsui,
            new_price  : arg2,
            updated_by : 0x2::tx_context::sender(arg3),
            timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<PassPriceUpdated>(v0);
    }

    public fun store_stats(arg0: &SubscriptionStore) : (u64, u64, u64, u64, u64, u64, u64, u64) {
        (arg0.total_passes_minted, arg0.total_standard_subscriptions, arg0.total_vip_subscriptions, arg0.total_upgrades, arg0.total_renewals, arg0.total_revenue_usdsui, arg0.active_standard_count, arg0.active_vip_count)
    }

    public fun subscription_account_id(arg0: &ZenkoPass) : 0x2::object::ID {
        arg0.account_id
    }

    public fun subscription_duration_ms() : u64 {
        2592000000
    }

    public fun subscription_prices(arg0: &SubscriptionStore) : (u64, u64) {
        (arg0.standard_price_usdsui, arg0.vip_price_usdsui)
    }

    public fun tier(arg0: &ZenkoPass) : u8 {
        arg0.tier
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

    public fun tier_standard() : u8 {
        1
    }

    public fun tier_vip() : u8 {
        2
    }

    public fun time_remaining(arg0: &ZenkoPass, arg1: u64) : u64 {
        if (arg0.expiration >= arg1) {
            arg0.expiration - arg1
        } else {
            0
        }
    }

    public fun upgrade_to_vip(arg0: &mut SubscriptionStore, arg1: &0x2::clock::Clock, arg2: &mut 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account, arg3: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::AccountAuth, arg4: ZenkoPass, arg5: 0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>, arg6: &mut 0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::verify_auth(arg2, arg3);
        let v0 = 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::id(arg2);
        assert!(arg4.account_id == v0, 7);
        assert!(arg4.tier == 1, 4);
        assert!(0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::subscription_id(arg2) == 0x1::option::some<0x2::object::ID>(0x2::object::id<ZenkoPass>(&arg4)), 5);
        let v1 = arg0.vip_price_usdsui - arg0.standard_price_usdsui;
        assert!(0x2::coin::value<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>(&arg5) >= v1, 3);
        let v2 = 0x2::clock::timestamp_ms(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI>>(arg5, @0x0);
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::clear_subscription(arg2, arg6);
        let ZenkoPass {
            id            : v3,
            account_id    : _,
            tier          : _,
            expiration    : _,
            renewal_count : v7,
            created_at    : v8,
            last_updated  : _,
        } = arg4;
        0x2::object::delete(v3);
        let v10 = ZenkoPass{
            id            : 0x2::object::new(arg6),
            account_id    : v0,
            tier          : 2,
            expiration    : v2 + 2592000000,
            renewal_count : v7,
            created_at    : v8,
            last_updated  : v2,
        };
        let v11 = 0x2::object::id<ZenkoPass>(&v10);
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::set_subscription(arg2, v11, arg6);
        let v12 = 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::config::rep_subscribe_vip() - 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::config::rep_subscribe_standard();
        if (v12 > 0) {
            0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::adjust_reputation_(arg2, v12, true, 0x1::string::utf8(b"subscribe_vip"), arg6);
        };
        arg0.total_upgrades = arg0.total_upgrades + 1;
        arg0.total_vip_subscriptions = arg0.total_vip_subscriptions + 1;
        arg0.total_revenue_usdsui = arg0.total_revenue_usdsui + v1;
        arg0.active_standard_count = arg0.active_standard_count - 1;
        arg0.active_vip_count = arg0.active_vip_count + 1;
        let v13 = SubscriptionUpgraded{
            old_subscription_id : 0x2::object::id<ZenkoPass>(&arg4),
            new_subscription_id : v11,
            account_id          : v0,
            old_tier            : 1,
            new_tier            : 2,
            price_paid          : v1,
            new_expiration      : v10.expiration,
            timestamp           : v2,
        };
        0x2::event::emit<SubscriptionUpgraded>(v13);
        0x2::transfer::public_transfer<ZenkoPass>(v10, 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v7
}

