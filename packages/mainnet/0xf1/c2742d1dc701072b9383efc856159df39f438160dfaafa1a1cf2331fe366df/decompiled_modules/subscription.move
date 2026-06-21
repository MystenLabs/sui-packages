module 0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::subscription {
    struct Tier<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        storage_limit: u64,
        price_per_month: u64,
        max_files: u64,
        max_shares: u64,
        max_file_size: u64,
        max_storage_epochs: u64,
        features: u64,
        active: bool,
        sort_order: u64,
        treasury: 0x2::balance::Balance<T0>,
    }

    struct UserSubscription has store, key {
        id: 0x2::object::UID,
        tier_id: address,
        tier_name: vector<u8>,
        storage_limit_display: vector<u8>,
        start_time_ms: u64,
        end_time_ms: u64,
        storage_used: u64,
        storage_limit: u64,
        file_count: u64,
        max_files: u64,
        share_count: u64,
        max_shares: u64,
        max_file_size: u64,
        max_storage_epochs: u64,
        features: u64,
        promo_applied: address,
        auto_renew: bool,
    }

    struct PromoCode has store, key {
        id: 0x2::object::UID,
        code_hash: vector<u8>,
        discount_bps: u64,
        max_uses: u64,
        uses_count: u64,
        valid_until_ms: u64,
        applicable_tiers: vector<address>,
        active: bool,
    }

    struct TierCreatedEvent has copy, drop {
        tier_id: address,
        name: vector<u8>,
        price_per_month: u64,
    }

    struct TierUpdatedEvent has copy, drop {
        tier_id: address,
    }

    struct SubscriptionCreatedEvent has copy, drop {
        user: address,
        tier_id: address,
        end_time_ms: u64,
    }

    struct SubscriptionRenewedEvent has copy, drop {
        user: address,
        tier_id: address,
        new_end_time_ms: u64,
    }

    struct PromoCodeUsedEvent has copy, drop {
        user: address,
        promo_id: address,
        discount_bps: u64,
    }

    struct SubscriptionCancelledEvent has copy, drop {
        user: address,
        previous_tier_id: address,
    }

    public fun assert_active(arg0: &UserSubscription, arg1: &0x2::clock::Clock) {
        assert!(is_active(arg0, arg1), 103);
    }

    public fun assert_can_share(arg0: &UserSubscription, arg1: &0x2::clock::Clock) {
        assert!(is_active(arg0, arg1), 103);
        assert!(arg0.share_count < arg0.max_shares, 106);
    }

    public fun assert_can_upload(arg0: &UserSubscription, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(is_active(arg0, arg2), 103);
        assert!(arg1 <= arg0.max_file_size, 113);
        assert!(arg0.storage_used + arg1 <= arg0.storage_limit, 104);
        assert!(arg0.file_count < arg0.max_files, 105);
    }

    public fun cancel_subscription(arg0: &0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::SystemConfig, arg1: &mut UserSubscription, arg2: &0x2::tx_context::TxContext) {
        0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::assert_not_paused(arg0);
        arg1.tier_id = @0x0;
        arg1.tier_name = b"Free";
        arg1.storage_limit_display = b"1 GB";
        arg1.end_time_ms = 0;
        arg1.storage_limit = 1073741824;
        arg1.max_files = 25;
        arg1.max_shares = 0;
        arg1.max_file_size = 209715200;
        arg1.max_storage_epochs = 1;
        arg1.features = 0;
        arg1.promo_applied = @0x0;
        arg1.auto_renew = false;
        let v0 = SubscriptionCancelledEvent{
            user             : 0x2::tx_context::sender(arg2),
            previous_tier_id : arg1.tier_id,
        };
        0x2::event::emit<SubscriptionCancelledEvent>(v0);
    }

    public fun create_free_subscription(arg0: &0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::SystemConfig, arg1: &mut 0x2::tx_context::TxContext) : UserSubscription {
        0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::assert_not_paused(arg0);
        UserSubscription{
            id                    : 0x2::object::new(arg1),
            tier_id               : @0x0,
            tier_name             : b"Free",
            storage_limit_display : b"1 GB",
            start_time_ms         : 0,
            end_time_ms           : 0,
            storage_used          : 0,
            storage_limit         : 1073741824,
            file_count            : 0,
            max_files             : 25,
            share_count           : 0,
            max_shares            : 0,
            max_file_size         : 209715200,
            max_storage_epochs    : 1,
            features              : 0,
            promo_applied         : @0x0,
            auto_renew            : false,
        }
    }

    public fun create_promo_code(arg0: &0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::AdminCap, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: vector<address>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = PromoCode{
            id               : 0x2::object::new(arg6),
            code_hash        : 0x2::hash::keccak256(&arg1),
            discount_bps     : arg2,
            max_uses         : arg3,
            uses_count       : 0,
            valid_until_ms   : arg4,
            applicable_tiers : arg5,
            active           : true,
        };
        0x2::transfer::share_object<PromoCode>(v0);
    }

    public fun create_tier<T0>(arg0: &0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::AdminCap, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = Tier<T0>{
            id                 : 0x2::object::new(arg10),
            name               : arg1,
            storage_limit      : arg2,
            price_per_month    : arg3,
            max_files          : arg4,
            max_shares         : arg5,
            max_file_size      : arg6,
            max_storage_epochs : arg7,
            features           : arg8,
            active             : true,
            sort_order         : arg9,
            treasury           : 0x2::balance::zero<T0>(),
        };
        let v1 = TierCreatedEvent{
            tier_id         : 0x2::object::id_address<Tier<T0>>(&v0),
            name            : v0.name,
            price_per_month : arg3,
        };
        0x2::event::emit<TierCreatedEvent>(v1);
        0x2::transfer::share_object<Tier<T0>>(v0);
    }

    public fun deactivate_promo(arg0: &0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::AdminCap, arg1: &mut PromoCode) {
        arg1.active = false;
    }

    public fun file_count(arg0: &UserSubscription) : u64 {
        arg0.file_count
    }

    public fun has_feature<T0>(arg0: &Tier<T0>, arg1: u64) : bool {
        arg0.features & arg1 != 0
    }

    public fun is_active(arg0: &UserSubscription, arg1: &0x2::clock::Clock) : bool {
        if (arg0.tier_id == @0x0) {
            return true
        };
        arg0.end_time_ms > 0x2::clock::timestamp_ms(arg1)
    }

    public fun is_free_tier(arg0: &UserSubscription) : bool {
        arg0.tier_id == @0x0
    }

    public fun max_files(arg0: &UserSubscription) : u64 {
        arg0.max_files
    }

    public fun max_shares(arg0: &UserSubscription) : u64 {
        arg0.max_shares
    }

    public(friend) fun record_delete(arg0: &mut UserSubscription, arg1: u64) {
        if (arg0.file_count > 0) {
            arg0.file_count = arg0.file_count - 1;
        };
        if (arg0.storage_used >= arg1) {
            arg0.storage_used = arg0.storage_used - arg1;
        } else {
            arg0.storage_used = 0;
        };
    }

    public(friend) fun record_share(arg0: &mut UserSubscription) {
        arg0.share_count = arg0.share_count + 1;
    }

    public(friend) fun record_unshare(arg0: &mut UserSubscription) {
        if (arg0.share_count > 0) {
            arg0.share_count = arg0.share_count - 1;
        };
    }

    public(friend) fun record_upload(arg0: &mut UserSubscription, arg1: u64) {
        arg0.file_count = arg0.file_count + 1;
        arg0.storage_used = arg0.storage_used + arg1;
    }

    public fun renew<T0>(arg0: &0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::SystemConfig, arg1: &mut UserSubscription, arg2: &mut Tier<T0>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::assert_not_paused(arg0);
        assert!(arg2.active, 101);
        assert!(arg4 > 0 && arg4 <= 12, 112);
        assert!(arg1.tier_id == 0x2::object::id_address<Tier<T0>>(arg2), 100);
        let v0 = arg2.price_per_month * arg4;
        assert!(0x2::coin::value<T0>(&arg3) == v0, 102);
        let v1 = 0x2::coin::into_balance<T0>(arg3);
        let v2 = v0 * 0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::fee_bps(arg0) / 10000;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1, v2), arg6), 0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::fee_recipient(arg0));
        };
        0x2::balance::join<T0>(&mut arg2.treasury, v1);
        let v3 = 0x2::clock::timestamp_ms(arg5);
        let v4 = if (arg1.end_time_ms > v3) {
            arg1.end_time_ms
        } else {
            v3
        };
        arg1.end_time_ms = v4 + arg4 * 2592000000;
        let v5 = SubscriptionRenewedEvent{
            user            : 0x2::tx_context::sender(arg6),
            tier_id         : 0x2::object::id_address<Tier<T0>>(arg2),
            new_end_time_ms : arg1.end_time_ms,
        };
        0x2::event::emit<SubscriptionRenewedEvent>(v5);
    }

    public fun set_tier_active<T0>(arg0: &0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::AdminCap, arg1: &mut Tier<T0>, arg2: bool) {
        arg1.active = arg2;
        let v0 = TierUpdatedEvent{tier_id: 0x2::object::id_address<Tier<T0>>(arg1)};
        0x2::event::emit<TierUpdatedEvent>(v0);
    }

    public fun share_count(arg0: &UserSubscription) : u64 {
        arg0.share_count
    }

    public fun storage_limit(arg0: &UserSubscription) : u64 {
        arg0.storage_limit
    }

    public fun storage_used(arg0: &UserSubscription) : u64 {
        arg0.storage_used
    }

    public fun sub_features(arg0: &UserSubscription) : u64 {
        arg0.features
    }

    public fun sub_max_file_size(arg0: &UserSubscription) : u64 {
        arg0.max_file_size
    }

    public fun sub_max_files(arg0: &UserSubscription) : u64 {
        arg0.max_files
    }

    public fun sub_max_shares(arg0: &UserSubscription) : u64 {
        arg0.max_shares
    }

    public fun sub_max_storage_epochs(arg0: &UserSubscription) : u64 {
        arg0.max_storage_epochs
    }

    public fun sub_storage_limit(arg0: &UserSubscription) : u64 {
        arg0.storage_limit
    }

    public fun subscribe<T0>(arg0: &0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::SystemConfig, arg1: &mut Tier<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : UserSubscription {
        0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::assert_not_paused(arg0);
        assert!(arg1.active, 101);
        assert!(arg3 > 0 && arg3 <= 12, 112);
        let v0 = arg1.price_per_month * arg3;
        assert!(0x2::coin::value<T0>(&arg2) == v0, 102);
        let v1 = 0x2::coin::into_balance<T0>(arg2);
        let v2 = v0 * 0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::fee_bps(arg0) / 10000;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1, v2), arg5), 0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::fee_recipient(arg0));
        };
        0x2::balance::join<T0>(&mut arg1.treasury, v1);
        let v3 = 0x2::clock::timestamp_ms(arg4);
        let v4 = v3 + arg3 * 2592000000;
        let v5 = UserSubscription{
            id                    : 0x2::object::new(arg5),
            tier_id               : 0x2::object::id_address<Tier<T0>>(arg1),
            tier_name             : arg1.name,
            storage_limit_display : b"",
            start_time_ms         : v3,
            end_time_ms           : v4,
            storage_used          : 0,
            storage_limit         : arg1.storage_limit,
            file_count            : 0,
            max_files             : arg1.max_files,
            share_count           : 0,
            max_shares            : arg1.max_shares,
            max_file_size         : arg1.max_file_size,
            max_storage_epochs    : arg1.max_storage_epochs,
            features              : arg1.features,
            promo_applied         : @0x0,
            auto_renew            : false,
        };
        let v6 = SubscriptionCreatedEvent{
            user        : 0x2::tx_context::sender(arg5),
            tier_id     : 0x2::object::id_address<Tier<T0>>(arg1),
            end_time_ms : v4,
        };
        0x2::event::emit<SubscriptionCreatedEvent>(v6);
        v5
    }

    public fun subscribe_with_promo<T0>(arg0: &0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::SystemConfig, arg1: &mut Tier<T0>, arg2: &mut PromoCode, arg3: vector<u8>, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : UserSubscription {
        0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::assert_not_paused(arg0);
        assert!(arg1.active, 101);
        assert!(arg5 > 0 && arg5 <= 12, 112);
        assert!(arg2.active, 107);
        assert!(0x2::hash::keccak256(&arg3) == arg2.code_hash, 107);
        assert!(arg2.uses_count < arg2.max_uses, 109);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        if (arg2.valid_until_ms > 0) {
            assert!(v0 < arg2.valid_until_ms, 108);
        };
        if (!0x1::vector::is_empty<address>(&arg2.applicable_tiers)) {
            let v1 = 0x2::object::id_address<Tier<T0>>(arg1);
            assert!(0x1::vector::contains<address>(&arg2.applicable_tiers, &v1), 107);
        };
        let v2 = arg1.price_per_month * arg5;
        let v3 = v2 - v2 * arg2.discount_bps / 10000;
        assert!(0x2::coin::value<T0>(&arg4) == v3, 102);
        let v4 = 0x2::coin::into_balance<T0>(arg4);
        let v5 = v3 * 0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::fee_bps(arg0) / 10000;
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v4, v5), arg7), 0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::fee_recipient(arg0));
        };
        0x2::balance::join<T0>(&mut arg1.treasury, v4);
        arg2.uses_count = arg2.uses_count + 1;
        let v6 = v0 + arg5 * 2592000000;
        let v7 = UserSubscription{
            id                    : 0x2::object::new(arg7),
            tier_id               : 0x2::object::id_address<Tier<T0>>(arg1),
            tier_name             : arg1.name,
            storage_limit_display : b"",
            start_time_ms         : v0,
            end_time_ms           : v6,
            storage_used          : 0,
            storage_limit         : arg1.storage_limit,
            file_count            : 0,
            max_files             : arg1.max_files,
            share_count           : 0,
            max_shares            : arg1.max_shares,
            max_file_size         : arg1.max_file_size,
            max_storage_epochs    : arg1.max_storage_epochs,
            features              : arg1.features,
            promo_applied         : 0x2::object::id_address<PromoCode>(arg2),
            auto_renew            : false,
        };
        let v8 = SubscriptionCreatedEvent{
            user        : 0x2::tx_context::sender(arg7),
            tier_id     : 0x2::object::id_address<Tier<T0>>(arg1),
            end_time_ms : v6,
        };
        0x2::event::emit<SubscriptionCreatedEvent>(v8);
        let v9 = PromoCodeUsedEvent{
            user         : 0x2::tx_context::sender(arg7),
            promo_id     : 0x2::object::id_address<PromoCode>(arg2),
            discount_bps : arg2.discount_bps,
        };
        0x2::event::emit<PromoCodeUsedEvent>(v9);
        v7
    }

    public fun tier_id(arg0: &UserSubscription) : address {
        arg0.tier_id
    }

    public fun tier_name(arg0: &UserSubscription) : &vector<u8> {
        &arg0.tier_name
    }

    public fun update_promo_discount(arg0: &0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::AdminCap, arg1: &mut PromoCode, arg2: u64) {
        arg1.discount_bps = arg2;
    }

    public fun update_promo_max_uses(arg0: &0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::AdminCap, arg1: &mut PromoCode, arg2: u64) {
        arg1.max_uses = arg2;
    }

    public fun update_tier_features<T0>(arg0: &0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::AdminCap, arg1: &mut Tier<T0>, arg2: u64) {
        arg1.features = arg2;
        let v0 = TierUpdatedEvent{tier_id: 0x2::object::id_address<Tier<T0>>(arg1)};
        0x2::event::emit<TierUpdatedEvent>(v0);
    }

    public fun update_tier_file_size<T0>(arg0: &0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::AdminCap, arg1: &mut Tier<T0>, arg2: u64) {
        arg1.max_file_size = arg2;
        let v0 = TierUpdatedEvent{tier_id: 0x2::object::id_address<Tier<T0>>(arg1)};
        0x2::event::emit<TierUpdatedEvent>(v0);
    }

    public fun update_tier_limits<T0>(arg0: &0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::AdminCap, arg1: &mut Tier<T0>, arg2: u64, arg3: u64, arg4: u64) {
        arg1.storage_limit = arg2;
        arg1.max_files = arg3;
        arg1.max_shares = arg4;
        let v0 = TierUpdatedEvent{tier_id: 0x2::object::id_address<Tier<T0>>(arg1)};
        0x2::event::emit<TierUpdatedEvent>(v0);
    }

    public fun update_tier_name<T0>(arg0: &0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::AdminCap, arg1: &mut Tier<T0>, arg2: vector<u8>) {
        arg1.name = arg2;
        let v0 = TierUpdatedEvent{tier_id: 0x2::object::id_address<Tier<T0>>(arg1)};
        0x2::event::emit<TierUpdatedEvent>(v0);
    }

    public fun update_tier_price<T0>(arg0: &0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::AdminCap, arg1: &mut Tier<T0>, arg2: u64) {
        arg1.price_per_month = arg2;
        let v0 = TierUpdatedEvent{tier_id: 0x2::object::id_address<Tier<T0>>(arg1)};
        0x2::event::emit<TierUpdatedEvent>(v0);
    }

    public fun update_tier_storage_epochs<T0>(arg0: &0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::AdminCap, arg1: &mut Tier<T0>, arg2: u64) {
        arg1.max_storage_epochs = arg2;
        let v0 = TierUpdatedEvent{tier_id: 0x2::object::id_address<Tier<T0>>(arg1)};
        0x2::event::emit<TierUpdatedEvent>(v0);
    }

    public fun withdraw_tier_treasury<T0>(arg0: &0xf1c2742d1dc701072b9383efc856159df39f438160dfaafa1a1cf2331fe366df::admin::AdminCap, arg1: &mut Tier<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.treasury, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

