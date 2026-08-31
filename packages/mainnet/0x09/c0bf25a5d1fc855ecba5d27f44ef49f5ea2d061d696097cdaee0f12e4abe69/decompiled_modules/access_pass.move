module 0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::access_pass {
    struct ACCESS_PASS has drop {
        dummy_field: bool,
    }

    struct AccessPass has store, key {
        id: 0x2::object::UID,
        vessel_id: 0x2::object::ID,
        owner: address,
        tier: u8,
        date_key_ms: u64,
        date_window_start_ms: u64,
        date_window_end_ms: u64,
        guest_capacity: u8,
        price_usdc: u64,
        redeemed: bool,
        redeemed_at_ms: 0x1::option::Option<u64>,
        refunded: bool,
        refunded_at_ms: 0x1::option::Option<u64>,
        metadata_cid: 0x1::option::Option<0x1::string::String>,
        created_at_ms: u64,
    }

    struct PurchaseEvent has copy, drop {
        pass_id: 0x2::object::ID,
        vessel_id: 0x2::object::ID,
        guest: address,
        tier: u8,
        date_key_ms: u64,
        price_usdc: u64,
        owner_share: u64,
        platform_share: u64,
        timestamp_ms: u64,
    }

    struct RedemptionEvent has copy, drop {
        pass_id: 0x2::object::ID,
        vessel_id: 0x2::object::ID,
        redeemed_by: address,
        timestamp_ms: u64,
    }

    struct RefundEvent has copy, drop {
        pass_id: 0x2::object::ID,
        vessel_id: 0x2::object::ID,
        refunded_to: address,
        amount: u64,
        timestamp_ms: u64,
    }

    fun compute_price_after_auto(arg0: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::availability_calendar::AvailabilityCalendar, arg1: u8, arg2: u64, arg3: u64) : u64 {
        let v0 = 0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::availability_calendar::get_tier_price(arg0, arg1);
        let v1 = 0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::availability_calendar::compute_auto_discount(arg0, v0, 0, arg2, arg3);
        if (v1 >= v0) {
            0
        } else {
            v0 - v1
        }
    }

    fun do_mint<T0>(arg0: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::payment_policy::PaymentPolicy, arg1: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity, arg2: &mut 0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::availability_calendar::AvailabilityCalendar, arg3: u8, arg4: u64, arg5: u8, arg6: u64, arg7: &mut 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::payment_policy::assert_coin_allowed<T0>(arg0);
        assert!(0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::vessel_is_active(arg1), 303);
        assert!(0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::availability_calendar::calendar_vessel_id(arg2) == 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg1), 300);
        let v0 = if (arg3 == 0) {
            true
        } else if (arg3 == 1) {
            true
        } else {
            arg3 == 2
        };
        assert!(v0, 301);
        assert!(0x2::coin::value<T0>(arg7) >= arg6, 302);
        0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::availability_calendar::record_purchase(arg2, arg4, arg3);
        let v1 = arg6 * 0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::payment_policy::platform_fee_bps(arg0) / 10000;
        let v2 = arg6 - v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg7, v2, arg9), 0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::vessel_owner(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg7, v1, arg9), 0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::payment_policy::treasury(arg0));
        let (v3, v4) = tier_to_window(arg4, arg3);
        let v5 = 0x2::clock::timestamp_ms(arg8);
        let v6 = 0x2::tx_context::sender(arg9);
        let v7 = AccessPass{
            id                   : 0x2::object::new(arg9),
            vessel_id            : 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg1),
            owner                : v6,
            tier                 : arg3,
            date_key_ms          : arg4,
            date_window_start_ms : v3,
            date_window_end_ms   : v4,
            guest_capacity       : arg5,
            price_usdc           : arg6,
            redeemed             : false,
            redeemed_at_ms       : 0x1::option::none<u64>(),
            refunded             : false,
            refunded_at_ms       : 0x1::option::none<u64>(),
            metadata_cid         : 0x1::option::none<0x1::string::String>(),
            created_at_ms        : v5,
        };
        let v8 = PurchaseEvent{
            pass_id        : 0x2::object::id<AccessPass>(&v7),
            vessel_id      : 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg1),
            guest          : v6,
            tier           : arg3,
            date_key_ms    : arg4,
            price_usdc     : arg6,
            owner_share    : v2,
            platform_share : v1,
            timestamp_ms   : v5,
        };
        0x2::event::emit<PurchaseEvent>(v8);
        0x2::transfer::public_transfer<AccessPass>(v7, v6);
    }

    fun init(arg0: ACCESS_PASS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<ACCESS_PASS>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun init_display(arg0: &mut 0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Norell's Shell Access Pass - Tier {tier} - {date_key_ms}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"On-chain access ticket"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ahoi.xyz/api/ticket-art/{vessel_id}/{tier}/{date_key_ms}.svg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://ahoi.xyz/tickets"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://norells.shell"));
        let v4 = 0x2::display::new_with_fields<AccessPass>(arg0, v0, v2, arg1);
        0x2::display::update_version<AccessPass>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<AccessPass>>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun mint_access_pass(arg0: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity, arg1: &mut 0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::availability_calendar::AvailabilityCalendar, arg2: u8, arg3: u64, arg4: u8, arg5: &mut 0x2::coin::Coin<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::test_usdc::TEST_USDC>, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        abort 311
    }

    public fun mint_access_pass_v2<T0>(arg0: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity, arg1: &mut 0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::availability_calendar::AvailabilityCalendar, arg2: u8, arg3: u64, arg4: u8, arg5: &mut 0x2::coin::Coin<T0>, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        abort 311
    }

    public fun mint_access_pass_v3<T0>(arg0: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::payment_policy::PaymentPolicy, arg1: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity, arg2: &mut 0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::availability_calendar::AvailabilityCalendar, arg3: u8, arg4: u64, arg5: u8, arg6: &mut 0x2::coin::Coin<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg3 == 0) {
            true
        } else if (arg3 == 1) {
            true
        } else {
            arg3 == 2
        };
        assert!(v0, 301);
        assert!(0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::availability_calendar::calendar_vessel_id(arg2) == 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg1), 300);
        let v1 = compute_price_after_auto(arg2, arg3, arg4, 0x2::clock::timestamp_ms(arg7));
        do_mint<T0>(arg0, arg1, arg2, arg3, arg4, arg5, v1, arg6, arg7, arg8);
    }

    public fun mint_access_pass_with_promo(arg0: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity, arg1: &mut 0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::availability_calendar::AvailabilityCalendar, arg2: &mut 0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::promo_codes::PromoCode, arg3: vector<u8>, arg4: u8, arg5: u64, arg6: u8, arg7: &mut 0x2::coin::Coin<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::test_usdc::TEST_USDC>, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        abort 311
    }

    public fun mint_access_pass_with_promo_v2<T0>(arg0: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity, arg1: &mut 0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::availability_calendar::AvailabilityCalendar, arg2: &mut 0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::promo_codes::PromoCode, arg3: vector<u8>, arg4: u8, arg5: u64, arg6: u8, arg7: &mut 0x2::coin::Coin<T0>, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        abort 311
    }

    public fun mint_access_pass_with_promo_v3<T0>(arg0: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::payment_policy::PaymentPolicy, arg1: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity, arg2: &mut 0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::availability_calendar::AvailabilityCalendar, arg3: &mut 0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::promo_codes::PromoCode, arg4: vector<u8>, arg5: u8, arg6: u64, arg7: u8, arg8: &mut 0x2::coin::Coin<T0>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg5 == 0) {
            true
        } else if (arg5 == 1) {
            true
        } else {
            arg5 == 2
        };
        assert!(v0, 301);
        assert!(0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::availability_calendar::calendar_vessel_id(arg2) == 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg1), 300);
        let v1 = 0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::promo_codes::consume_promo(arg3, 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg1), arg4, arg5, compute_price_after_auto(arg2, arg5, arg6, 0x2::clock::timestamp_ms(arg9)), arg9);
        do_mint<T0>(arg0, arg1, arg2, arg5, arg6, arg7, v1, arg8, arg9, arg10);
    }

    public fun pass_created_at_ms(arg0: &AccessPass) : u64 {
        arg0.created_at_ms
    }

    public fun pass_date_key_ms(arg0: &AccessPass) : u64 {
        arg0.date_key_ms
    }

    public fun pass_guest_capacity(arg0: &AccessPass) : u8 {
        arg0.guest_capacity
    }

    public fun pass_metadata_cid(arg0: &AccessPass) : 0x1::option::Option<0x1::string::String> {
        arg0.metadata_cid
    }

    public fun pass_owner(arg0: &AccessPass) : address {
        arg0.owner
    }

    public fun pass_price(arg0: &AccessPass) : u64 {
        arg0.price_usdc
    }

    public fun pass_redeemed(arg0: &AccessPass) : bool {
        arg0.redeemed
    }

    public fun pass_redeemed_at_ms(arg0: &AccessPass) : 0x1::option::Option<u64> {
        arg0.redeemed_at_ms
    }

    public fun pass_refunded(arg0: &AccessPass) : bool {
        arg0.refunded
    }

    public fun pass_refunded_at_ms(arg0: &AccessPass) : 0x1::option::Option<u64> {
        arg0.refunded_at_ms
    }

    public fun pass_tier(arg0: &AccessPass) : u8 {
        arg0.tier
    }

    public fun pass_vessel_id(arg0: &AccessPass) : 0x2::object::ID {
        arg0.vessel_id
    }

    public fun pass_window(arg0: &AccessPass) : (u64, u64) {
        (arg0.date_window_start_ms, arg0.date_window_end_ms)
    }

    public fun redeem_pass(arg0: &mut AccessPass, arg1: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::OwnerCapability, arg2: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::owner_cap_vessel_id(arg1) == 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg2), 308);
        assert!(arg0.vessel_id == 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg2), 307);
        assert!(!arg0.redeemed, 304);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg0.date_window_start_ms, 305);
        assert!(v0 <= arg0.date_window_end_ms, 306);
        arg0.redeemed = true;
        arg0.redeemed_at_ms = 0x1::option::some<u64>(v0);
        let v1 = RedemptionEvent{
            pass_id      : 0x2::object::id<AccessPass>(arg0),
            vessel_id    : arg0.vessel_id,
            redeemed_by  : 0x2::tx_context::sender(arg4),
            timestamp_ms : v0,
        };
        0x2::event::emit<RedemptionEvent>(v1);
    }

    public fun refund_pass(arg0: &mut AccessPass, arg1: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::OwnerCapability, arg2: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity, arg3: 0x2::coin::Coin<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::test_usdc::TEST_USDC>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        abort 311
    }

    public fun refund_pass_v2<T0>(arg0: &mut AccessPass, arg1: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::OwnerCapability, arg2: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        abort 311
    }

    public fun refund_pass_with_capacity(arg0: &mut AccessPass, arg1: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::OwnerCapability, arg2: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity, arg3: &mut 0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::availability_calendar::AvailabilityCalendar, arg4: 0x2::coin::Coin<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::test_usdc::TEST_USDC>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        abort 311
    }

    public fun refund_pass_with_capacity_v2<T0>(arg0: &mut AccessPass, arg1: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::OwnerCapability, arg2: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity, arg3: &mut 0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::availability_calendar::AvailabilityCalendar, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        abort 311
    }

    public fun refund_pass_with_capacity_v3<T0>(arg0: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::payment_policy::PaymentPolicy, arg1: &mut AccessPass, arg2: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::OwnerCapability, arg3: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity, arg4: &mut 0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::availability_calendar::AvailabilityCalendar, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::payment_policy::assert_coin_allowed<T0>(arg0);
        assert!(0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::owner_cap_vessel_id(arg2) == 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg3), 308);
        assert!(arg1.vessel_id == 0x2::object::id<0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::VesselIdentity>(arg3), 307);
        assert!(0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::availability_calendar::calendar_vessel_id(arg4) == arg1.vessel_id, 300);
        assert!(!arg1.redeemed, 304);
        assert!(!arg1.refunded, 309);
        assert!(0x2::coin::value<T0>(&arg5) == arg1.price_usdc, 310);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg5, arg1.owner);
        arg1.refunded = true;
        arg1.refunded_at_ms = 0x1::option::some<u64>(v0);
        0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::availability_calendar::record_refund(arg4, arg1.date_key_ms);
        let v1 = RefundEvent{
            pass_id      : 0x2::object::id<AccessPass>(arg1),
            vessel_id    : arg1.vessel_id,
            refunded_to  : arg1.owner,
            amount       : 0x2::coin::value<T0>(&arg5),
            timestamp_ms : v0,
        };
        0x2::event::emit<RefundEvent>(v1);
    }

    public fun set_pass_metadata_cid(arg0: &mut AccessPass, arg1: &0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::OwnerCapability, arg2: vector<u8>) {
        assert!(0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::vessel_identity::owner_cap_vessel_id(arg1) == arg0.vessel_id, 308);
        arg0.metadata_cid = 0x1::option::some<0x1::string::String>(0x1::string::utf8(arg2));
    }

    fun tier_to_window(arg0: u64, arg1: u8) : (u64, u64) {
        if (arg1 == 0) {
            (arg0, arg0 + 86400000)
        } else if (arg1 == 1) {
            let v2 = arg0 + 8 * 3600000;
            (v2, v2 + 4 * 3600000)
        } else {
            assert!(arg1 == 2, 301);
            let v3 = arg0 + 18 * 3600000;
            (v3, v3 + 3 * 3600000)
        }
    }

    // decompiled from Move bytecode v7
}

