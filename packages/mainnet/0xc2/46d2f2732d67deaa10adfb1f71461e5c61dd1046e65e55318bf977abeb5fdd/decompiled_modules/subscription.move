module 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::subscription {
    struct UserSubscription has store, key {
        id: 0x2::object::UID,
        user: address,
        subscription_type: u8,
        start_date: u64,
        end_date: u64,
        is_active: bool,
        created_at: u64,
        last_updated: u64,
    }

    struct SubscriptionConfig has key {
        id: 0x2::object::UID,
        basic_monthly_price: u64,
        basic_yearly_price: u64,
        pro_monthly_price: u64,
        pro_yearly_price: u64,
        admin: address,
    }

    struct SubscriptionRegistry has key {
        id: 0x2::object::UID,
        user_subscriptions: 0x2::table::Table<address, 0x2::object::ID>,
        active_subscriptions_count: 0x2::table::Table<u8, u64>,
    }

    struct SubscriptionAdminCap has store, key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
    }

    struct SubscriptionCreated has copy, drop {
        subscription_id: 0x2::object::ID,
        user: address,
        subscription_type: u8,
        start_date: u64,
        end_date: u64,
    }

    struct SubscriptionUpgraded has copy, drop {
        subscription_id: 0x2::object::ID,
        user: address,
        old_type: u8,
        new_type: u8,
        timestamp: u64,
    }

    struct AttendeeCountUpdated has copy, drop {
        subscription_id: 0x2::object::ID,
        user: address,
        total_attendees_served: u64,
        timestamp: u64,
    }

    struct SubscriptionExpired has copy, drop {
        subscription_id: 0x2::object::ID,
        user: address,
        subscription_type: u8,
        timestamp: u64,
    }

    public fun can_add_attendees(arg0: &UserSubscription, arg1: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::OrganizerProfile, arg2: u64, arg3: &0x2::clock::Clock) : bool {
        if (!arg0.is_active) {
            return false
        };
        if (arg0.end_date > 0 && 0x2::clock::timestamp_ms(arg3) > arg0.end_date) {
            return false
        };
        if (arg0.subscription_type == 0) {
            let (_, _, v2, _) = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_organizer_stats(arg1);
            return v2 + arg2 <= 501
        };
        true
    }

    public fun create_free_subscription(arg0: address, arg1: &0x2::clock::Clock, arg2: &mut SubscriptionRegistry, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg2.user_subscriptions, arg0), 304);
        let v0 = UserSubscription{
            id                : 0x2::object::new(arg3),
            user              : arg0,
            subscription_type : 0,
            start_date        : 0x2::clock::timestamp_ms(arg1),
            end_date          : 0,
            is_active         : true,
            created_at        : 0x2::clock::timestamp_ms(arg1),
            last_updated      : 0x2::clock::timestamp_ms(arg1),
        };
        let v1 = 0x2::object::id<UserSubscription>(&v0);
        0x2::table::add<address, 0x2::object::ID>(&mut arg2.user_subscriptions, arg0, v1);
        let v2 = 0x2::table::borrow_mut<u8, u64>(&mut arg2.active_subscriptions_count, 0);
        *v2 = *v2 + 1;
        let v3 = SubscriptionCreated{
            subscription_id   : v1,
            user              : arg0,
            subscription_type : 0,
            start_date        : v0.start_date,
            end_date          : 0,
        };
        0x2::event::emit<SubscriptionCreated>(v3);
        0x2::transfer::share_object<UserSubscription>(v0);
        v1
    }

    public fun expire_subscription(arg0: &mut UserSubscription, arg1: &mut SubscriptionRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg0.end_date > 0 && v0 > arg0.end_date, 301);
        assert!(arg0.is_active, 301);
        arg0.is_active = false;
        arg0.last_updated = v0;
        let v1 = 0x2::table::borrow_mut<u8, u64>(&mut arg1.active_subscriptions_count, arg0.subscription_type);
        *v1 = *v1 - 1;
        let v2 = SubscriptionExpired{
            subscription_id   : 0x2::object::id<UserSubscription>(arg0),
            user              : arg0.user,
            subscription_type : arg0.subscription_type,
            timestamp         : v0,
        };
        0x2::event::emit<SubscriptionExpired>(v2);
    }

    public fun get_attendee_count(arg0: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::OrganizerProfile) : u64 {
        let (_, _, v2, _) = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_organizer_stats(arg0);
        v2
    }

    public fun get_pricing(arg0: &SubscriptionConfig) : (u64, u64, u64, u64) {
        (arg0.basic_monthly_price, arg0.basic_yearly_price, arg0.pro_monthly_price, arg0.pro_yearly_price)
    }

    public fun get_remaining_attendees(arg0: &UserSubscription, arg1: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::OrganizerProfile) : u64 {
        if (arg0.subscription_type == 0) {
            let (_, _, v3, _) = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_organizer_stats(arg1);
            if (v3 >= 501) {
                0
            } else {
                501 - v3
            }
        } else {
            18446744073709551615
        }
    }

    public fun get_subscription_details(arg0: &UserSubscription) : (address, u8, u64, u64, bool) {
        (arg0.user, arg0.subscription_type, arg0.start_date, arg0.end_date, arg0.is_active)
    }

    public fun get_subscription_status(arg0: &UserSubscription, arg1: &0x2::clock::Clock) : (bool, bool) {
        let v0 = arg0.end_date == 0 && false || 0x2::clock::timestamp_ms(arg1) > arg0.end_date;
        (arg0.is_active, v0)
    }

    public fun get_subscription_type(arg0: &UserSubscription) : u8 {
        arg0.subscription_type
    }

    public fun get_subscription_type_name(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Free")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Basic")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Pro")
        } else {
            0x1::string::utf8(b"Unknown")
        }
    }

    public fun get_user_subscription_id(arg0: &SubscriptionRegistry, arg1: address) : 0x2::object::ID {
        *0x2::table::borrow<address, 0x2::object::ID>(&arg0.user_subscriptions, arg1)
    }

    public fun has_subscription(arg0: &SubscriptionRegistry, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.user_subscriptions, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = SubscriptionConfig{
            id                  : 0x2::object::new(arg0),
            basic_monthly_price : 10000000000,
            basic_yearly_price  : 100000000000,
            pro_monthly_price   : 25000000000,
            pro_yearly_price    : 250000000000,
            admin               : v0,
        };
        let v2 = SubscriptionAdminCap{
            id        : 0x2::object::new(arg0),
            config_id : 0x2::object::id<SubscriptionConfig>(&v1),
        };
        let v3 = SubscriptionRegistry{
            id                         : 0x2::object::new(arg0),
            user_subscriptions         : 0x2::table::new<address, 0x2::object::ID>(arg0),
            active_subscriptions_count : 0x2::table::new<u8, u64>(arg0),
        };
        0x2::table::add<u8, u64>(&mut v3.active_subscriptions_count, 0, 0);
        0x2::table::add<u8, u64>(&mut v3.active_subscriptions_count, 1, 0);
        0x2::table::add<u8, u64>(&mut v3.active_subscriptions_count, 2, 0);
        0x2::transfer::transfer<SubscriptionAdminCap>(v2, v0);
        0x2::transfer::share_object<SubscriptionConfig>(v1);
        0x2::transfer::share_object<SubscriptionRegistry>(v3);
    }

    public fun should_pay_platform_fee(arg0: &UserSubscription) : bool {
        arg0.subscription_type == 1 || arg0.subscription_type == 0
    }

    public fun subscribe_basic(arg0: &mut UserSubscription, arg1: bool, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &SubscriptionConfig, arg4: &mut SubscriptionRegistry, arg5: &mut 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::platform_treasury::PlatformTreasury, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg0.user == 0x2::tx_context::sender(arg7), 300);
        let v0 = if (arg1) {
            arg3.basic_yearly_price
        } else {
            arg3.basic_monthly_price
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v0, 303);
        let v1 = if (arg1) {
            31536000000
        } else {
            2592000000
        };
        0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::platform_treasury::deposit_platform_fee(arg5, arg2, 0x1::string::utf8(b"subscription"), arg6, arg7);
        upgrade_subscription(arg0, 1, 0x2::clock::timestamp_ms(arg6) + v1, arg4, arg6)
    }

    public fun subscribe_pro(arg0: &mut UserSubscription, arg1: bool, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &SubscriptionConfig, arg4: &mut SubscriptionRegistry, arg5: &mut 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::platform_treasury::PlatformTreasury, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg0.user == 0x2::tx_context::sender(arg7), 300);
        let v0 = if (arg1) {
            arg3.pro_yearly_price
        } else {
            arg3.pro_monthly_price
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v0, 303);
        let v1 = if (arg1) {
            31536000000
        } else {
            2592000000
        };
        0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::platform_treasury::deposit_platform_fee(arg5, arg2, 0x1::string::utf8(b"subscription"), arg6, arg7);
        upgrade_subscription(arg0, 2, 0x2::clock::timestamp_ms(arg6) + v1, arg4, arg6)
    }

    public fun track_attendee_update(arg0: &mut UserSubscription, arg1: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::OrganizerProfile, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 301);
        let (_, _, v2, _) = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_organizer_stats(arg1);
        if (arg0.subscription_type == 0) {
            assert!(v2 <= 501, 302);
        };
        arg0.last_updated = 0x2::clock::timestamp_ms(arg2);
        let v4 = AttendeeCountUpdated{
            subscription_id        : 0x2::object::id<UserSubscription>(arg0),
            user                   : arg0.user,
            total_attendees_served : v2,
            timestamp              : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<AttendeeCountUpdated>(v4);
    }

    public fun update_pricing(arg0: &mut SubscriptionConfig, arg1: &SubscriptionAdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg6), 300);
        assert!(arg1.config_id == 0x2::object::id<SubscriptionConfig>(arg0), 300);
        arg0.basic_monthly_price = arg2;
        arg0.basic_yearly_price = arg3;
        arg0.pro_monthly_price = arg4;
        arg0.pro_yearly_price = arg5;
    }

    fun upgrade_subscription(arg0: &mut UserSubscription, arg1: u8, arg2: u64, arg3: &mut SubscriptionRegistry, arg4: &0x2::clock::Clock) : 0x2::object::ID {
        let v0 = arg0.subscription_type;
        let v1 = 0x2::object::id<UserSubscription>(arg0);
        let v2 = 0x2::table::borrow_mut<u8, u64>(&mut arg3.active_subscriptions_count, v0);
        *v2 = *v2 - 1;
        let v3 = 0x2::table::borrow_mut<u8, u64>(&mut arg3.active_subscriptions_count, arg1);
        *v3 = *v3 + 1;
        arg0.subscription_type = arg1;
        arg0.end_date = arg2;
        arg0.is_active = true;
        arg0.last_updated = 0x2::clock::timestamp_ms(arg4);
        let v4 = SubscriptionUpgraded{
            subscription_id : v1,
            user            : arg0.user,
            old_type        : v0,
            new_type        : arg1,
            timestamp       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<SubscriptionUpgraded>(v4);
        v1
    }

    // decompiled from Move bytecode v6
}

