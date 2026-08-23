module 0xad5b69eb9f658281116e1294aec185309da8e49666d88969d03482481473ee34::content {
    struct CONTENT has drop {
        dummy_field: bool,
    }

    struct ContentSpendScope has drop {
        private: bool,
    }

    struct CreatorAccount has key {
        id: 0x2::object::UID,
        primary_address: address,
        payout_address: address,
        decrypt_authorized: 0x2::vec_set::VecSet<address>,
    }

    struct CreatorCap has key {
        id: 0x2::object::UID,
        account_id: 0x2::object::ID,
    }

    struct AccountCap has key {
        id: 0x2::object::UID,
        account_id: 0x2::object::ID,
    }

    struct CurrentPassRef has copy, drop, store {
        pass_id: 0x2::object::ID,
        expires_at_ms: 0x1::option::Option<u64>,
    }

    struct SubscriptionTier has key {
        id: 0x2::object::UID,
        creator_id: 0x2::object::ID,
        name: vector<u8>,
        cover: vector<u8>,
        price: 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money,
        duration: 0x1::option::Option<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::CalendarPeriod>,
        accepted_assets: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        terms_version: u64,
        renewal_price_policy: u8,
        status: u8,
        deactivation_policy: u8,
        archived: bool,
        passes_minted: u64,
        active_mandates: 0x2::table::Table<address, 0x2::object::ID>,
        current_passes: 0x2::table::Table<address, CurrentPassRef>,
    }

    struct Content has key {
        id: 0x2::object::UID,
        creator_id: 0x2::object::ID,
        content_kind: u8,
        access_kind: u8,
        access_methods: u8,
        allowed_tier_ids: vector<0x2::object::ID>,
        one_off_price: 0x1::option::Option<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money>,
        accepted_assets: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        terms_version: u64,
        revision_count: u64,
        status: u8,
        latest_revision: 0x1::option::Option<0x2::object::ID>,
        published_revision: 0x1::option::Option<0x2::object::ID>,
        entitlements: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct ContentRevision has key {
        id: 0x2::object::UID,
        content_id: 0x2::object::ID,
        revision_number: u64,
        access_kind: u8,
        seal_id: vector<u8>,
        assets: vector<ContentAsset>,
        created_at_ms: u64,
        status: u8,
    }

    struct ContentAsset has drop, store {
        asset_kind: u8,
        order_index: u32,
        seal_id: vector<u8>,
        blob_id: vector<u8>,
        blob_owner_id: address,
        size_bytes: u64,
    }

    struct FeePolicy has key {
        id: 0x2::object::UID,
        fee_bps: u64,
        treasury: address,
        mode: u8,
    }

    struct FeePolicyAdminCap has store, key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
    }

    struct SettlementQuote has copy, drop, store {
        total: 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money,
        creator_proceeds: 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money,
        fee: 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money,
    }

    struct PurchaseIntent has key {
        id: 0x2::object::UID,
        buyer: address,
        product_kind: u8,
        subject_id: 0x2::object::ID,
        terms_version: u64,
        exact_charge: 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money,
        authorization_id: 0x2::object::ID,
        expires_at_ms: u64,
        status: u8,
    }

    struct SubscriptionMandate has key {
        id: 0x2::object::UID,
        subscriber: address,
        tier_id: 0x2::object::ID,
        authorization_id: 0x2::object::ID,
        locked_base_price: 0x1::option::Option<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money>,
        locked_terms_version: 0x1::option::Option<u64>,
        schedule_anchor_ms: 0x1::option::Option<u64>,
        next_due_index: u64,
        current_pass_id: 0x1::option::Option<0x2::object::ID>,
        replay_index: u64,
        status: u8,
    }

    struct SubscriptionPass has key {
        id: 0x2::object::UID,
        subscriber: address,
        tier_id: 0x2::object::ID,
        started_at_ms: u64,
        expires_at_ms: 0x1::option::Option<u64>,
        nominal_paid: 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money,
        payment_coin_type: 0x1::option::Option<0x1::type_name::TypeName>,
        tier_terms_version: u64,
    }

    struct ContentAccessPass has key {
        id: 0x2::object::UID,
        owner: address,
        content_id: 0x2::object::ID,
        purchased_at_ms: u64,
        terms_version: u64,
    }

    struct ContentSubscriptionCard has key {
        id: 0x2::object::UID,
        subscriber: address,
        tier_id: 0x2::object::ID,
        pass_id: 0x2::object::ID,
        mandate_id: 0x1::option::Option<0x2::object::ID>,
        created_at_ms: u64,
    }

    struct ContentSpendingPermissionCard has key {
        id: 0x2::object::UID,
        authorization_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        grantor: address,
        pair_kind: u8,
        paired_consent_id: 0x2::object::ID,
        authorization_mode: u8,
        currency: 0x1::type_name::TypeName,
        nominal_maximum: u64,
        calendar_period: 0x1::option::Option<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::CalendarPeriod>,
        grant_anchor_ms: u64,
        overall_expiry_ms: 0x1::option::Option<u64>,
        executors: vector<address>,
        initial_asset_type: 0x1::type_name::TypeName,
    }

    struct PaymentSettled has copy, drop {
        payer: address,
        authorization_id: 0x2::object::ID,
        product_kind: u8,
        subject_id: 0x2::object::ID,
        consent_id: 0x2::object::ID,
        terms_version: u64,
        replay_key: u64,
        nominal_currency: 0x1::type_name::TypeName,
        nominal_amount: u64,
        coin_type: 0x1::type_name::TypeName,
        raw_total: u64,
        raw_creator_proceeds: u64,
        raw_fee: u64,
        settled_at_ms: u64,
        result_id: 0x2::object::ID,
    }

    struct CreatorCreated has copy, drop {
        account_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        account_cap_id: 0x2::object::ID,
        payout: address,
    }

    struct CreatorCapTransferred has copy, drop {
        account_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct AccountCapTransferred has copy, drop {
        account_id: 0x2::object::ID,
        account_cap_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    struct CreatorPayoutUpdated has copy, drop {
        account_id: 0x2::object::ID,
        payout: address,
    }

    struct DecryptAuthorizedChanged has copy, drop {
        account_id: 0x2::object::ID,
        delegate: address,
        authorized: bool,
    }

    struct TierCreated has copy, drop {
        tier_id: 0x2::object::ID,
        creator_id: 0x2::object::ID,
        terms_version: u64,
    }

    struct TierTermsUpdated has copy, drop {
        tier_id: 0x2::object::ID,
        terms_version: u64,
        price: 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money,
        renewal_price_policy: u8,
    }

    struct TierDisplayUpdated has copy, drop {
        tier_id: 0x2::object::ID,
        name: vector<u8>,
        cover: vector<u8>,
    }

    struct TierStatusChanged has copy, drop {
        tier_id: 0x2::object::ID,
        status: u8,
        deactivation_policy: u8,
        archived: bool,
    }

    struct TierDeleted has copy, drop {
        tier_id: 0x2::object::ID,
        creator_id: 0x2::object::ID,
    }

    struct ContentCreated has copy, drop {
        content_id: 0x2::object::ID,
        creator_id: 0x2::object::ID,
        content_kind: u8,
        access_kind: u8,
        access_methods: u8,
        terms_version: u64,
    }

    struct ContentTierAdded has copy, drop {
        content_id: 0x2::object::ID,
        creator_id: 0x2::object::ID,
        tier_id: 0x2::object::ID,
    }

    struct ContentTierRemoved has copy, drop {
        content_id: 0x2::object::ID,
        creator_id: 0x2::object::ID,
        tier_id: 0x2::object::ID,
    }

    struct ContentTermsUpdated has copy, drop {
        content_id: 0x2::object::ID,
        access_kind: u8,
        access_methods: u8,
        terms_version: u64,
    }

    struct ContentStatusChanged has copy, drop {
        content_id: 0x2::object::ID,
        creator_id: 0x2::object::ID,
        status: u8,
    }

    struct RevisionCreated has copy, drop {
        revision_id: 0x2::object::ID,
        content_id: 0x2::object::ID,
        revision_number: u64,
        seal_id: vector<u8>,
        asset_count: u64,
    }

    struct RevisionPublished has copy, drop {
        revision_id: 0x2::object::ID,
        content_id: 0x2::object::ID,
        revision_number: u64,
    }

    struct IntentCreated has copy, drop {
        intent_id: 0x2::object::ID,
        authorization_id: 0x2::object::ID,
        subject_id: 0x2::object::ID,
    }

    struct MandateCreated has copy, drop {
        mandate_id: 0x2::object::ID,
        authorization_id: 0x2::object::ID,
        tier_id: 0x2::object::ID,
        subscriber: address,
    }

    struct PermissionCardCreated has copy, drop {
        card_id: 0x2::object::ID,
        authorization_id: 0x2::object::ID,
        paired_consent_id: 0x2::object::ID,
    }

    struct SubscriptionCardCreated has copy, drop {
        card_id: 0x2::object::ID,
        tier_id: 0x2::object::ID,
        pass_id: 0x2::object::ID,
        subscriber: address,
    }

    struct SubscriptionSettled has copy, drop {
        mandate_id: 0x1::option::Option<0x2::object::ID>,
        pass_id: 0x2::object::ID,
        replay_key: u64,
        renewal: bool,
    }

    struct ContentAccessSettled has copy, drop {
        intent_id: 0x2::object::ID,
        pass_id: 0x2::object::ID,
    }

    struct MandateCancelled has copy, drop {
        mandate_id: 0x2::object::ID,
        authorization_id: 0x2::object::ID,
    }

    struct SubscriptionPassExpirationShortened has copy, drop {
        pass_id: 0x2::object::ID,
        subscriber: address,
        previous_expires_at_ms: 0x1::option::Option<u64>,
        new_expires_at_ms: u64,
    }

    public fun active_intent_status() : u8 {
        0
    }

    public fun active_mandate_status() : u8 {
        1
    }

    public fun add_content_asset<T0>(arg0: &CreatorAccount, arg1: &CreatorCap, arg2: &0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::CurrencyRegistry, arg3: &mut Content) {
        assert_creator(arg0, arg1);
        assert!(arg3.creator_id == 0x2::object::id<CreatorAccount>(arg0), 7);
        assert_content_mutable(arg3);
        assert!(0x1::option::is_some<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money>(&arg3.one_off_price), 4);
        assert!(0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::is_asset_enabled<T0>(arg2, 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::money_currency(0x1::option::borrow<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money>(&arg3.one_off_price))), 5);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg3.accepted_assets, &v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg3.accepted_assets, v0);
            arg3.terms_version = checked_add(arg3.terms_version, 1, 10);
        };
    }

    public fun add_content_revision(arg0: &CreatorCap, arg1: &mut Content, arg2: u8, arg3: vector<u8>, arg4: vector<u32>, arg5: vector<vector<u8>>, arg6: vector<vector<u8>>, arg7: vector<address>, arg8: vector<u64>, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_content_auth(arg0, arg1);
        assert_content_mutable(arg1);
        let v0 = append_revision(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0x2::transfer::share_object<ContentRevision>(v0);
        0x2::object::id<ContentRevision>(&v0)
    }

    public fun add_content_tier(arg0: &CreatorAccount, arg1: &CreatorCap, arg2: &mut Content, arg3: &SubscriptionTier) {
        assert_creator(arg0, arg1);
        assert!(arg2.creator_id == 0x2::object::id<CreatorAccount>(arg0), 7);
        assert_content_mutable(arg2);
        assert!(arg3.creator_id == arg2.creator_id, 53);
        assert!(arg3.status == 0 && !arg3.archived, 39);
        let v0 = 0x2::object::id<SubscriptionTier>(arg3);
        assert!(!vector_contains_id(&arg2.allowed_tier_ids, &v0), 40);
        assert!(0x1::vector::length<0x2::object::ID>(&arg2.allowed_tier_ids) < 32, 42);
        0x1::vector::push_back<0x2::object::ID>(&mut arg2.allowed_tier_ids, v0);
        let v1 = ContentTierAdded{
            content_id : 0x2::object::id<Content>(arg2),
            creator_id : arg2.creator_id,
            tier_id    : v0,
        };
        0x2::event::emit<ContentTierAdded>(v1);
    }

    public fun add_decrypt_authorized(arg0: &mut CreatorAccount, arg1: &AccountCap, arg2: address) {
        assert_account_auth(arg1, arg0);
        assert!(arg2 != @0x0, 2);
        if (!0x2::vec_set::contains<address>(&arg0.decrypt_authorized, &arg2)) {
            0x2::vec_set::insert<address>(&mut arg0.decrypt_authorized, arg2);
            let v0 = DecryptAuthorizedChanged{
                account_id : 0x2::object::id<CreatorAccount>(arg0),
                delegate   : arg2,
                authorized : true,
            };
            0x2::event::emit<DecryptAuthorizedChanged>(v0);
        };
    }

    public fun add_published_revision(arg0: &CreatorCap, arg1: &mut Content, arg2: u8, arg3: vector<u8>, arg4: vector<u32>, arg5: vector<vector<u8>>, arg6: vector<vector<u8>>, arg7: vector<address>, arg8: vector<u64>, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_content_auth(arg0, arg1);
        assert_content_mutable(arg1);
        let v0 = append_revision(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v1 = &mut v0;
        mark_published(arg1, v1);
        0x2::transfer::share_object<ContentRevision>(v0);
        0x2::object::id<ContentRevision>(&v0)
    }

    public fun add_revision(arg0: &CreatorCap, arg1: &mut Content, arg2: u8, arg3: vector<u8>, arg4: vector<u32>, arg5: vector<vector<u8>>, arg6: vector<vector<u8>>, arg7: vector<address>, arg8: vector<u64>, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        add_content_revision(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    public fun add_tier_asset<T0>(arg0: &CreatorAccount, arg1: &CreatorCap, arg2: &0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::CurrencyRegistry, arg3: &mut SubscriptionTier) {
        assert_creator(arg0, arg1);
        assert!(arg3.creator_id == 0x2::object::id<CreatorAccount>(arg0), 7);
        assert!(!arg3.archived, 39);
        assert!(0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::is_asset_enabled<T0>(arg2, 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::money_currency(&arg3.price)), 5);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg3.accepted_assets, &v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg3.accepted_assets, v0);
        };
    }

    public fun additive_fee_mode() : u8 {
        1
    }

    fun append_revision(arg0: &mut Content, arg1: u8, arg2: vector<u8>, arg3: vector<u32>, arg4: vector<vector<u8>>, arg5: vector<vector<u8>>, arg6: vector<address>, arg7: vector<u64>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : ContentRevision {
        assert!(arg1 == 0 || arg1 == 1, 32);
        let v0 = 0x1::vector::length<u8>(&arg2);
        assert!(v0 > 0, 43);
        assert!(0x1::vector::length<u32>(&arg3) == v0, 30);
        assert!(0x1::vector::length<vector<u8>>(&arg4) == v0, 30);
        assert!(0x1::vector::length<vector<u8>>(&arg5) == v0, 30);
        assert!(0x1::vector::length<address>(&arg6) == v0, 30);
        assert!(0x1::vector::length<u64>(&arg7) == v0, 30);
        let v1 = arg1 == 0;
        if (v1) {
            assert!(0x1::vector::is_empty<u8>(&arg8), 44);
        } else {
            assert!(!0x1::vector::is_empty<u8>(&arg8), 45);
        };
        let v2 = 0x1::vector::empty<ContentAsset>();
        let v3 = 0;
        while (v3 < v0) {
            let v4 = *0x1::vector::borrow<vector<u8>>(&arg4, v3);
            if (v1) {
                assert!(0x1::vector::is_empty<u8>(&v4), 44);
            } else {
                assert!(!0x1::vector::is_empty<u8>(&v4), 45);
            };
            let v5 = ContentAsset{
                asset_kind    : *0x1::vector::borrow<u8>(&arg2, v3),
                order_index   : *0x1::vector::borrow<u32>(&arg3, v3),
                seal_id       : v4,
                blob_id       : *0x1::vector::borrow<vector<u8>>(&arg5, v3),
                blob_owner_id : *0x1::vector::borrow<address>(&arg6, v3),
                size_bytes    : *0x1::vector::borrow<u64>(&arg7, v3),
            };
            0x1::vector::push_back<ContentAsset>(&mut v2, v5);
            v3 = v3 + 1;
        };
        let v6 = checked_add(arg0.revision_count, 1, 10);
        let v7 = ContentRevision{
            id              : 0x2::object::new(arg10),
            content_id      : 0x2::object::id<Content>(arg0),
            revision_number : v6,
            access_kind     : arg1,
            seal_id         : arg8,
            assets          : v2,
            created_at_ms   : 0x2::clock::timestamp_ms(arg9),
            status          : 0,
        };
        let v8 = 0x2::object::id<ContentRevision>(&v7);
        arg0.revision_count = v6;
        arg0.latest_revision = 0x1::option::some<0x2::object::ID>(v8);
        let v9 = RevisionCreated{
            revision_id     : v8,
            content_id      : 0x2::object::id<Content>(arg0),
            revision_number : v6,
            seal_id         : v7.seal_id,
            asset_count     : v0,
        };
        0x2::event::emit<RevisionCreated>(v9);
        v7
    }

    fun apply_content_policy<T0>(arg0: &mut Content, arg1: &0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::CurrencyRegistry, arg2: u8, arg3: u8, arg4: 0x1::option::Option<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money>) {
        let (v0, v1, v2) = normalized_content_policy<T0>(arg1, arg2, arg3, arg4);
        if (arg2 == 0 || !has_method(v0, 1)) {
            clear_content_tiers(arg0);
        };
        arg0.access_kind = arg2;
        arg0.access_methods = v0;
        arg0.one_off_price = v1;
        arg0.accepted_assets = v2;
    }

    public fun archive_content(arg0: &CreatorCap, arg1: &mut Content) {
        set_content_status(arg0, arg1, 2);
    }

    public fun archive_tier(arg0: &CreatorAccount, arg1: &CreatorCap, arg2: &mut SubscriptionTier) {
        assert_creator(arg0, arg1);
        assert!(arg2.creator_id == 0x2::object::id<CreatorAccount>(arg0), 7);
        arg2.status = 1;
        arg2.deactivation_policy = 0;
        arg2.archived = true;
        let v0 = TierStatusChanged{
            tier_id             : 0x2::object::id<SubscriptionTier>(arg2),
            status              : arg2.status,
            deactivation_policy : arg2.deactivation_policy,
            archived            : true,
        };
        0x2::event::emit<TierStatusChanged>(v0);
    }

    fun assert_account_auth(arg0: &AccountCap, arg1: &CreatorAccount) {
        assert!(arg0.account_id == 0x2::object::id<CreatorAccount>(arg1), 1);
    }

    fun assert_content_accepts<T0>(arg0: &Content) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.accepted_assets, &v0), 5);
    }

    fun assert_content_auth(arg0: &CreatorCap, arg1: &Content) {
        assert!(arg0.account_id == arg1.creator_id, 1);
    }

    fun assert_content_mutable(arg0: &Content) {
        assert!(arg0.status != 2, 58);
    }

    fun assert_content_purchasable<T0>(arg0: &Content, arg1: &0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::CurrencyRegistry) {
        assert!(arg0.status == 1 && 0x1::option::is_some<0x2::object::ID>(&arg0.published_revision), 6);
        assert!(arg0.access_kind == 1, 34);
        assert!(has_method(arg0.access_methods, 2), 35);
        assert!(0x1::option::is_some<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money>(&arg0.one_off_price), 4);
        assert_content_accepts<T0>(arg0);
        assert!(0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::is_asset_enabled<T0>(arg1, 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::money_currency(0x1::option::borrow<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money>(&arg0.one_off_price))), 5);
    }

    fun assert_content_recurring_authorization(arg0: &0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::SpendingAuthorization) {
        assert!(0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::authorization_scope(arg0) == 0x1::type_name::with_defining_ids<ContentSpendScope>(), 24);
        assert!(0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::authorization_mode(arg0) == 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::calendar_recurring_mode(), 25);
        assert!(0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::authorization_is_active(arg0), 29);
    }

    fun assert_creator(arg0: &CreatorAccount, arg1: &CreatorCap) {
        assert!(arg1.account_id == 0x2::object::id<CreatorAccount>(arg0), 1);
    }

    fun assert_creator_asset(arg0: &Content, arg1: &ContentRevision, arg2: &vector<u8>) {
        assert!(arg1.access_kind == 1, 34);
        assert!(arg0.status != 2, 58);
        assert!(arg1.content_id == 0x2::object::id<Content>(arg0), 7);
        assert!(revision_contains_seal_id(arg1, arg2), 47);
    }

    fun assert_current_subscription_pass(arg0: &SubscriptionTier, arg1: &SubscriptionPass) {
        assert!(0x2::table::contains<address, CurrentPassRef>(&arg0.current_passes, arg1.subscriber), 56);
        assert!(0x2::table::borrow<address, CurrentPassRef>(&arg0.current_passes, arg1.subscriber).pass_id == 0x2::object::id<SubscriptionPass>(arg1), 56);
    }

    fun assert_fee_terms(arg0: u64, arg1: address, arg2: u8) {
        assert!(arg0 <= 10000, 9);
        assert!(arg1 != @0x0, 2);
        assert!(arg2 == 0 || arg2 == 1, 9);
    }

    fun assert_intent(arg0: &PurchaseIntent, arg1: &0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::SpendingAuthorization, arg2: u8, arg3: 0x2::object::ID, arg4: u64, arg5: &0x2::clock::Clock) {
        assert!(arg0.status == 0, 12);
        assert!(0x2::clock::timestamp_ms(arg5) < arg0.expires_at_ms, 13);
        assert!(arg0.product_kind == arg2 && arg0.subject_id == arg3, 7);
        assert!(arg0.terms_version == arg4, 8);
        assert!(arg0.authorization_id == 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::authorization_id(arg1), 14);
        assert!(arg0.buyer == 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::authorization_grantor(arg1), 11);
        assert!(0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::authorization_scope(arg1) == 0x1::type_name::with_defining_ids<ContentSpendScope>(), 24);
        assert!(0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::authorization_mode(arg1) == 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::single_use_mode(), 25);
    }

    fun assert_paid_tier<T0>(arg0: &SubscriptionTier, arg1: &0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::CurrencyRegistry) {
        assert!(arg0.status == 0 && !arg0.archived, 6);
        assert!(0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::money_amount(&arg0.price) > 0, 6);
        assert!(0x1::option::is_some<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::CalendarPeriod>(&arg0.duration), 4);
        assert_tier_accepts<T0>(arg0);
        assert!(0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::is_asset_enabled<T0>(arg1, 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::money_currency(&arg0.price)), 5);
    }

    fun assert_published_asset(arg0: &Content, arg1: &ContentRevision, arg2: &vector<u8>) {
        assert!(arg0.access_kind == 1, 34);
        assert!(arg0.status != 2, 58);
        assert!(arg1.content_id == 0x2::object::id<Content>(arg0), 7);
        let v0 = 0x2::object::id<ContentRevision>(arg1);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.published_revision, &v0), 50);
        assert!(arg1.status == 1, 50);
        assert!(revision_contains_seal_id(arg1, arg2), 47);
    }

    fun assert_tier_accepts<T0>(arg0: &SubscriptionTier) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.accepted_assets, &v0), 5);
    }

    fun assert_tier_renewable<T0>(arg0: &SubscriptionTier, arg1: &0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::CurrencyRegistry) {
        assert!(!arg0.archived, 39);
        assert!(arg0.status == 0 || arg0.status == 1 && arg0.deactivation_policy == 1, 6);
        assert!(0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::money_amount(&arg0.price) > 0 && 0x1::option::is_some<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::CalendarPeriod>(&arg0.duration), 4);
        assert_tier_accepts<T0>(arg0);
        assert!(0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::is_asset_enabled<T0>(arg1, 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::money_currency(&arg0.price)), 5);
    }

    fun assert_valid_content_status(arg0: u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        };
        assert!(v0, 27);
    }

    fun assert_valid_deactivation_policy(arg0: u8) {
        assert!(arg0 == 1 || arg0 == 2, 37);
    }

    fun assert_valid_display_name(arg0: &vector<u8>) {
        assert!(!0x1::vector::is_empty<u8>(arg0), 3);
        assert!(0x1::vector::length<u8>(arg0) <= 128, 59);
    }

    fun assert_valid_renewal_policy(arg0: u8) {
        assert!(arg0 == 0 || arg0 == 1, 36);
    }

    fun assert_valid_tier_status(arg0: u8) {
        assert!(arg0 == 0 || arg0 == 1, 27);
    }

    public fun cancel_free_subscription(arg0: &mut SubscriptionTier, arg1: &mut SubscriptionPass, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.subscriber == 0x2::tx_context::sender(arg3), 48);
        shorten_current_free_pass(arg0, arg1, 0x2::clock::timestamp_ms(arg2));
    }

    public fun cancel_free_subscription_by_creator(arg0: &CreatorCap, arg1: &mut SubscriptionTier, arg2: &mut SubscriptionPass, arg3: &0x2::clock::Clock) {
        assert!(arg0.account_id == arg1.creator_id, 1);
        shorten_current_free_pass(arg1, arg2, 0x2::clock::timestamp_ms(arg3));
    }

    public fun cancel_intent(arg0: &mut 0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault, arg1: &0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::OwnerCap, arg2: &mut 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::SpendingAuthorization, arg3: &mut PurchaseIntent, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.buyer == 0x2::tx_context::sender(arg4), 11);
        if (arg3.status != 0) {
            return
        };
        assert!(arg3.authorization_id == 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::authorization_id(arg2), 14);
        arg3.status = 2;
        0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::revoke(arg0, arg1, arg2, arg4);
    }

    public fun cancel_mandate(arg0: &mut 0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault, arg1: &0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::OwnerCap, arg2: &mut 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::SpendingAuthorization, arg3: &mut SubscriptionMandate, arg4: &mut SubscriptionTier, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg3.subscriber == v0, 11);
        assert!(arg3.authorization_id == 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::authorization_id(arg2), 14);
        assert!(arg3.tier_id == 0x2::object::id<SubscriptionTier>(arg4), 7);
        if (arg3.status == 2) {
            return
        };
        assert!(0x2::table::contains<address, 0x2::object::ID>(&arg4.active_mandates, v0), 7);
        assert!(*0x2::table::borrow<address, 0x2::object::ID>(&arg4.active_mandates, v0) == 0x2::object::id<SubscriptionMandate>(arg3), 7);
        0x2::table::remove<address, 0x2::object::ID>(&mut arg4.active_mandates, v0);
        arg3.status = 2;
        0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::revoke(arg0, arg1, arg2, arg5);
        let v1 = MandateCancelled{
            mandate_id       : 0x2::object::id<SubscriptionMandate>(arg3),
            authorization_id : arg3.authorization_id,
        };
        0x2::event::emit<MandateCancelled>(v1);
    }

    public fun cancelled_mandate_status() : u8 {
        2
    }

    fun checked_add(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, arg2);
        arg0 + arg1
    }

    fun clear_content_tiers(arg0: &mut Content) {
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg0.allowed_tier_ids)) {
            let v0 = ContentTierRemoved{
                content_id : 0x2::object::id<Content>(arg0),
                creator_id : arg0.creator_id,
                tier_id    : 0x1::vector::pop_back<0x2::object::ID>(&mut arg0.allowed_tier_ids),
            };
            0x2::event::emit<ContentTierRemoved>(v0);
        };
    }

    public fun close_expired_intent(arg0: &mut 0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault, arg1: &mut 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::SpendingAuthorization, arg2: &mut PurchaseIntent, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg2.status != 0) {
            return
        };
        assert!(arg2.authorization_id == 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::authorization_id(arg1), 14);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg2.expires_at_ms, 13);
        arg2.status = 3;
        0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::close_expired(arg0, arg1, arg3, arg4);
    }

    public fun consumed_intent_status() : u8 {
        1
    }

    public fun content_access_kind(arg0: &Content) : u8 {
        arg0.access_kind
    }

    public fun content_access_methods(arg0: &Content) : u8 {
        arg0.access_methods
    }

    public fun content_allowed_tier_count(arg0: &Content) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.allowed_tier_ids)
    }

    public fun content_price(arg0: &Content) : 0x1::option::Option<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money> {
        arg0.one_off_price
    }

    public fun content_terms_version(arg0: &Content) : u64 {
        arg0.terms_version
    }

    public fun create_content<T0>(arg0: &CreatorAccount, arg1: &CreatorCap, arg2: &0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::CurrencyRegistry, arg3: u8, arg4: u8, arg5: u8, arg6: 0x1::option::Option<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_creator(arg0, arg1);
        let v0 = new_content<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = 0x2::object::id<Content>(&v0);
        0x2::transfer::share_object<Content>(v0);
        let v2 = ContentCreated{
            content_id     : v1,
            creator_id     : 0x2::object::id<CreatorAccount>(arg0),
            content_kind   : arg3,
            access_kind    : arg4,
            access_methods : arg5,
            terms_version  : 1,
        };
        0x2::event::emit<ContentCreated>(v2);
        v1
    }

    public fun create_content_and_publish_revision<T0>(arg0: &CreatorAccount, arg1: &CreatorCap, arg2: &0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::CurrencyRegistry, arg3: u8, arg4: u8, arg5: u8, arg6: 0x1::option::Option<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money>, arg7: vector<u8>, arg8: vector<u32>, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: vector<address>, arg12: vector<u64>, arg13: vector<u8>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID) {
        assert_creator(arg0, arg1);
        let v0 = new_content<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg15);
        let v1 = 0x2::object::id<Content>(&v0);
        let v2 = ContentCreated{
            content_id     : v1,
            creator_id     : 0x2::object::id<CreatorAccount>(arg0),
            content_kind   : arg3,
            access_kind    : arg4,
            access_methods : arg5,
            terms_version  : 1,
        };
        0x2::event::emit<ContentCreated>(v2);
        let v3 = &mut v0;
        let v4 = append_revision(v3, arg4, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
        let v5 = &mut v0;
        let v6 = &mut v4;
        mark_published(v5, v6);
        0x2::transfer::share_object<ContentRevision>(v4);
        0x2::transfer::share_object<Content>(v0);
        (v1, 0x2::object::id<ContentRevision>(&v4))
    }

    public fun create_creator(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg0);
        register_creator_delegated(v0, v0, arg0)
    }

    fun create_subscription_card(arg0: address, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::option::Option<0x2::object::ID>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = ContentSubscriptionCard{
            id            : 0x2::object::new(arg5),
            subscriber    : arg0,
            tier_id       : arg1,
            pass_id       : arg2,
            mandate_id    : arg3,
            created_at_ms : arg4,
        };
        let v1 = 0x2::object::id<ContentSubscriptionCard>(&v0);
        0x2::transfer::transfer<ContentSubscriptionCard>(v0, arg0);
        let v2 = SubscriptionCardCreated{
            card_id    : v1,
            tier_id    : arg1,
            pass_id    : arg2,
            subscriber : arg0,
        };
        0x2::event::emit<SubscriptionCardCreated>(v2);
        v1
    }

    public fun create_subscription_mandate<T0>(arg0: &mut 0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault, arg1: &0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::OwnerCap, arg2: &0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::CurrencyRegistry, arg3: &mut SubscriptionTier, arg4: 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money, arg5: 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::CalendarPeriod, arg6: 0x1::option::Option<u64>, arg7: vector<address>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID) {
        let v0 = 0x2::tx_context::sender(arg9);
        assert_paid_tier<T0>(arg3, arg2);
        assert!(0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::money_currency(&arg4) == 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::money_currency(&arg3.price), 61);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg3.active_mandates, v0), 18);
        assert!(0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::is_asset_enabled<T0>(arg2, 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::money_currency(&arg4)), 5);
        let v1 = ContentSpendScope{private: true};
        let v2 = 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::grant_calendar_recurring<T0, ContentSpendScope>(arg0, arg1, arg2, v1, arg4, arg5, arg6, arg7, arg8, arg9);
        let v3 = 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::authorization_id(&v2);
        let v4 = SubscriptionMandate{
            id                   : 0x2::object::new(arg9),
            subscriber           : v0,
            tier_id              : 0x2::object::id<SubscriptionTier>(arg3),
            authorization_id     : v3,
            locked_base_price    : 0x1::option::none<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money>(),
            locked_terms_version : 0x1::option::none<u64>(),
            schedule_anchor_ms   : 0x1::option::none<u64>(),
            next_due_index       : 0,
            current_pass_id      : 0x1::option::none<0x2::object::ID>(),
            replay_index         : 0,
            status               : 0,
        };
        let v5 = 0x2::object::id<SubscriptionMandate>(&v4);
        let v6 = permission_card(&v2, 1, v5, 0x1::type_name::with_defining_ids<T0>(), arg9);
        let v7 = 0x2::object::id<ContentSpendingPermissionCard>(&v6);
        0x2::table::add<address, 0x2::object::ID>(&mut arg3.active_mandates, v0, v5);
        0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::share_authorization(v2);
        0x2::transfer::share_object<SubscriptionMandate>(v4);
        0x2::transfer::transfer<ContentSpendingPermissionCard>(v6, 0x2::tx_context::sender(arg9));
        let v8 = MandateCreated{
            mandate_id       : v5,
            authorization_id : v3,
            tier_id          : 0x2::object::id<SubscriptionTier>(arg3),
            subscriber       : v0,
        };
        0x2::event::emit<MandateCreated>(v8);
        let v9 = PermissionCardCreated{
            card_id           : v7,
            authorization_id  : v3,
            paired_consent_id : v5,
        };
        0x2::event::emit<PermissionCardCreated>(v9);
        (v3, v5, v7)
    }

    public fun create_tier<T0>(arg0: &CreatorAccount, arg1: &CreatorCap, arg2: &0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::CurrencyRegistry, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money, arg6: 0x1::option::Option<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::CalendarPeriod>, arg7: u8, arg8: u8, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_creator(arg0, arg1);
        assert_valid_display_name(&arg3);
        assert_valid_renewal_policy(arg7);
        assert_valid_tier_status(arg8);
        assert!(0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::is_asset_enabled<T0>(arg2, 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::money_currency(&arg5)), 5);
        if (0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::money_amount(&arg5) > 0) {
            assert!(0x1::option::is_some<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::CalendarPeriod>(&arg6), 4);
        };
        let v0 = 0x2::vec_set::empty<0x1::type_name::TypeName>();
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0, 0x1::type_name::with_defining_ids<T0>());
        let v1 = if (arg8 == 0) {
            0
        } else {
            1
        };
        let v2 = SubscriptionTier{
            id                   : 0x2::object::new(arg9),
            creator_id           : 0x2::object::id<CreatorAccount>(arg0),
            name                 : arg3,
            cover                : arg4,
            price                : arg5,
            duration             : arg6,
            accepted_assets      : v0,
            terms_version        : 1,
            renewal_price_policy : arg7,
            status               : arg8,
            deactivation_policy  : v1,
            archived             : false,
            passes_minted        : 0,
            active_mandates      : 0x2::table::new<address, 0x2::object::ID>(arg9),
            current_passes       : 0x2::table::new<address, CurrentPassRef>(arg9),
        };
        let v3 = 0x2::object::id<SubscriptionTier>(&v2);
        0x2::transfer::share_object<SubscriptionTier>(v2);
        let v4 = TierCreated{
            tier_id       : v3,
            creator_id    : 0x2::object::id<CreatorAccount>(arg0),
            terms_version : 1,
        };
        0x2::event::emit<TierCreated>(v4);
        v3
    }

    public fun creator_payout(arg0: &CreatorAccount) : address {
        arg0.payout_address
    }

    public fun creator_primary(arg0: &CreatorAccount) : address {
        arg0.primary_address
    }

    public fun deactivate_tier(arg0: &CreatorAccount, arg1: &CreatorCap, arg2: &mut SubscriptionTier, arg3: u8) {
        assert_creator(arg0, arg1);
        assert!(arg2.creator_id == 0x2::object::id<CreatorAccount>(arg0), 7);
        assert!(!arg2.archived, 39);
        assert_valid_deactivation_policy(arg3);
        arg2.status = 1;
        arg2.deactivation_policy = arg3;
        let v0 = TierStatusChanged{
            tier_id             : 0x2::object::id<SubscriptionTier>(arg2),
            status              : arg2.status,
            deactivation_policy : arg3,
            archived            : false,
        };
        0x2::event::emit<TierStatusChanged>(v0);
    }

    public fun delete_permission_card(arg0: ContentSpendingPermissionCard, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.grantor == 0x2::tx_context::sender(arg1), 26);
        let ContentSpendingPermissionCard {
            id                 : v0,
            authorization_id   : _,
            vault_id           : _,
            grantor            : _,
            pair_kind          : _,
            paired_consent_id  : _,
            authorization_mode : _,
            currency           : _,
            nominal_maximum    : _,
            calendar_period    : _,
            grant_anchor_ms    : _,
            overall_expiry_ms  : _,
            executors          : _,
            initial_asset_type : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun delete_subscription_card(arg0: ContentSubscriptionCard, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.subscriber == 0x2::tx_context::sender(arg1), 26);
        let ContentSubscriptionCard {
            id            : v0,
            subscriber    : _,
            tier_id       : _,
            pass_id       : _,
            mandate_id    : _,
            created_at_ms : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun delete_tier(arg0: &CreatorAccount, arg1: &CreatorCap, arg2: SubscriptionTier) {
        assert_creator(arg0, arg1);
        assert!(arg2.creator_id == 0x2::object::id<CreatorAccount>(arg0), 7);
        assert!(arg2.passes_minted == 0, 38);
        let SubscriptionTier {
            id                   : v0,
            creator_id           : _,
            name                 : _,
            cover                : _,
            price                : _,
            duration             : _,
            accepted_assets      : _,
            terms_version        : _,
            renewal_price_policy : _,
            status               : _,
            deactivation_policy  : _,
            archived             : _,
            passes_minted        : _,
            active_mandates      : v13,
            current_passes       : v14,
        } = arg2;
        0x2::table::destroy_empty<address, 0x2::object::ID>(v13);
        0x2::table::destroy_empty<address, CurrentPassRef>(v14);
        0x2::object::delete(v0);
        let v15 = TierDeleted{
            tier_id    : 0x2::object::id<SubscriptionTier>(&arg2),
            creator_id : arg2.creator_id,
        };
        0x2::event::emit<TierDeleted>(v15);
    }

    fun emit_payment_settled<T0>(arg0: address, arg1: 0x2::object::ID, arg2: u8, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: 0x2::object::ID) {
        assert!(arg9 <= 18446744073709551615 - arg10, 10);
        assert!(arg9 + arg10 == arg8, 9);
        let v0 = PaymentSettled{
            payer                : arg0,
            authorization_id     : arg1,
            product_kind         : arg2,
            subject_id           : arg3,
            consent_id           : arg4,
            terms_version        : arg5,
            replay_key           : arg6,
            nominal_currency     : 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::money_currency(&arg7),
            nominal_amount       : 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::money_amount(&arg7),
            coin_type            : 0x1::type_name::with_defining_ids<T0>(),
            raw_total            : arg8,
            raw_creator_proceeds : arg9,
            raw_fee              : arg10,
            settled_at_ms        : arg11,
            result_id            : arg12,
        };
        0x2::event::emit<PaymentSettled>(v0);
    }

    fun grant_intent<T0>(arg0: &mut 0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault, arg1: &0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::OwnerCap, arg2: &0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::CurrencyRegistry, arg3: u8, arg4: 0x2::object::ID, arg5: u64, arg6: 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money, arg7: u64, arg8: vector<address>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID) {
        let v0 = ContentSpendScope{private: true};
        let v1 = 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::grant_single_use<T0, ContentSpendScope>(arg0, arg1, arg2, v0, arg6, arg7, arg8, arg9, arg10);
        let v2 = 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::authorization_id(&v1);
        let v3 = PurchaseIntent{
            id               : 0x2::object::new(arg10),
            buyer            : 0x2::tx_context::sender(arg10),
            product_kind     : arg3,
            subject_id       : arg4,
            terms_version    : arg5,
            exact_charge     : arg6,
            authorization_id : v2,
            expires_at_ms    : arg7,
            status           : 0,
        };
        let v4 = 0x2::object::id<PurchaseIntent>(&v3);
        let v5 = permission_card(&v1, 0, v4, 0x1::type_name::with_defining_ids<T0>(), arg10);
        let v6 = 0x2::object::id<ContentSpendingPermissionCard>(&v5);
        0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::share_authorization(v1);
        0x2::transfer::share_object<PurchaseIntent>(v3);
        0x2::transfer::transfer<ContentSpendingPermissionCard>(v5, 0x2::tx_context::sender(arg10));
        let v7 = IntentCreated{
            intent_id        : v4,
            authorization_id : v2,
            subject_id       : arg4,
        };
        0x2::event::emit<IntentCreated>(v7);
        let v8 = PermissionCardCreated{
            card_id           : v6,
            authorization_id  : v2,
            paired_consent_id : v4,
        };
        0x2::event::emit<PermissionCardCreated>(v8);
        (v2, v4, v6)
    }

    public fun grant_one_off_content_purchase<T0>(arg0: &mut 0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault, arg1: &0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::OwnerCap, arg2: &0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::CurrencyRegistry, arg3: &FeePolicy, arg4: &Content, arg5: u64, arg6: vector<address>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID) {
        assert_content_purchasable<T0>(arg4, arg2);
        let v0 = quote(arg3, *0x1::option::borrow<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money>(&arg4.one_off_price));
        grant_intent<T0>(arg0, arg1, arg2, 1, 0x2::object::id<Content>(arg4), arg4.terms_version, v0.total, arg5, arg6, arg7, arg8)
    }

    public fun grant_one_off_subscription_purchase<T0>(arg0: &mut 0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault, arg1: &0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::OwnerCap, arg2: &0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::CurrencyRegistry, arg3: &FeePolicy, arg4: &SubscriptionTier, arg5: u64, arg6: vector<address>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID) {
        assert_paid_tier<T0>(arg4, arg2);
        let v0 = quote(arg3, arg4.price);
        grant_intent<T0>(arg0, arg1, arg2, 0, 0x2::object::id<SubscriptionTier>(arg4), arg4.terms_version, v0.total, arg5, arg6, arg7, arg8)
    }

    fun has_method(arg0: u8, arg1: u8) : bool {
        arg0 & arg1 != 0
    }

    public fun included_fee_mode() : u8 {
        0
    }

    fun init(arg0: CONTENT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = new_fee_policy(0, v0, 0, arg1);
        0x2::transfer::share_object<FeePolicy>(v1);
        0x2::transfer::public_transfer<FeePolicyAdminCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<CONTENT>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    fun install_current_pass(arg0: &mut SubscriptionTier, arg1: address, arg2: 0x2::object::ID, arg3: 0x1::option::Option<u64>, arg4: u64) {
        if (0x2::table::contains<address, CurrentPassRef>(&arg0.current_passes, arg1)) {
            let v0 = 0x2::table::borrow<address, CurrentPassRef>(&arg0.current_passes, arg1).expires_at_ms;
            assert!(0x1::option::is_some<u64>(&v0), 22);
            assert!(*0x1::option::borrow<u64>(&v0) <= arg4, 22);
            0x2::table::remove<address, CurrentPassRef>(&mut arg0.current_passes, arg1);
        };
        let v1 = CurrentPassRef{
            pass_id       : arg2,
            expires_at_ms : arg3,
        };
        0x2::table::add<address, CurrentPassRef>(&mut arg0.current_passes, arg1, v1);
    }

    public fun intent_authorization_id(arg0: &PurchaseIntent) : 0x2::object::ID {
        arg0.authorization_id
    }

    public fun intent_status(arg0: &PurchaseIntent) : u8 {
        arg0.status
    }

    public fun is_decrypt_authorized(arg0: &CreatorAccount, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.decrypt_authorized, &arg1)
    }

    public fun mandate_current_pass(arg0: &SubscriptionMandate) : 0x1::option::Option<0x2::object::ID> {
        arg0.current_pass_id
    }

    public fun mandate_locked_base_price(arg0: &SubscriptionMandate) : 0x1::option::Option<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money> {
        arg0.locked_base_price
    }

    public fun mandate_replay_index(arg0: &SubscriptionMandate) : u64 {
        arg0.replay_index
    }

    public fun mandate_status(arg0: &SubscriptionMandate) : u8 {
        arg0.status
    }

    fun mark_published(arg0: &mut Content, arg1: &mut ContentRevision) {
        assert!(arg1.content_id == 0x2::object::id<Content>(arg0), 7);
        assert!(arg1.status == 0, 27);
        let v0 = 0x2::object::id<ContentRevision>(arg1);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.latest_revision, &v0), 46);
        assert!(arg1.access_kind == arg0.access_kind, 32);
        if (has_method(arg0.access_methods, 1)) {
            assert!(!0x1::vector::is_empty<0x2::object::ID>(&arg0.allowed_tier_ids), 41);
        };
        arg1.status = 1;
        arg0.published_revision = 0x1::option::some<0x2::object::ID>(0x2::object::id<ContentRevision>(arg1));
        arg0.status = 1;
        let v1 = RevisionPublished{
            revision_id     : 0x2::object::id<ContentRevision>(arg1),
            content_id      : 0x2::object::id<Content>(arg0),
            revision_number : arg1.revision_number,
        };
        0x2::event::emit<RevisionPublished>(v1);
        let v2 = ContentStatusChanged{
            content_id : 0x2::object::id<Content>(arg0),
            creator_id : arg0.creator_id,
            status     : 1,
        };
        0x2::event::emit<ContentStatusChanged>(v2);
    }

    fun new_content<T0>(arg0: &CreatorAccount, arg1: &0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::CurrencyRegistry, arg2: u8, arg3: u8, arg4: u8, arg5: 0x1::option::Option<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money>, arg6: &mut 0x2::tx_context::TxContext) : Content {
        let v0 = if (arg2 == 1) {
            true
        } else if (arg2 == 2) {
            true
        } else {
            arg2 == 3
        };
        assert!(v0, 31);
        let (v1, v2, v3) = normalized_content_policy<T0>(arg1, arg3, arg4, arg5);
        Content{
            id                 : 0x2::object::new(arg6),
            creator_id         : 0x2::object::id<CreatorAccount>(arg0),
            content_kind       : arg2,
            access_kind        : arg3,
            access_methods     : v1,
            allowed_tier_ids   : 0x1::vector::empty<0x2::object::ID>(),
            one_off_price      : v2,
            accepted_assets    : v3,
            terms_version      : 1,
            revision_count     : 0,
            status             : 0,
            latest_revision    : 0x1::option::none<0x2::object::ID>(),
            published_revision : 0x1::option::none<0x2::object::ID>(),
            entitlements       : 0x2::table::new<address, 0x2::object::ID>(arg6),
        }
    }

    fun new_fee_policy(arg0: u64, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : (FeePolicy, FeePolicyAdminCap) {
        assert_fee_terms(arg0, arg1, arg2);
        let v0 = FeePolicy{
            id       : 0x2::object::new(arg3),
            fee_bps  : arg0,
            treasury : arg1,
            mode     : arg2,
        };
        let v1 = FeePolicyAdminCap{
            id        : 0x2::object::new(arg3),
            policy_id : 0x2::object::id<FeePolicy>(&v0),
        };
        (v0, v1)
    }

    fun normalized_content_policy<T0>(arg0: &0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::CurrencyRegistry, arg1: u8, arg2: u8, arg3: 0x1::option::Option<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money>) : (u8, 0x1::option::Option<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money>, 0x2::vec_set::VecSet<0x1::type_name::TypeName>) {
        assert!(arg1 == 0 || arg1 == 1, 32);
        let v0 = 0x2::vec_set::empty<0x1::type_name::TypeName>();
        if (arg1 == 0) {
            assert!(arg2 == 0 && 0x1::option::is_none<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money>(&arg3), 57);
            (0, 0x1::option::none<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money>(), v0)
        } else {
            assert!(arg2 != 0, 33);
            assert!(arg2 & 3 == arg2, 57);
            let (v3, v0) = if (has_method(arg2, 2)) {
                assert!(0x1::option::is_some<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money>(&arg3), 4);
                let v4 = 0x1::option::borrow<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money>(&arg3);
                assert!(0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::money_amount(v4) > 0, 4);
                assert!(0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::is_asset_enabled<T0>(arg0, 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::money_currency(v4)), 5);
                0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0, 0x1::type_name::with_defining_ids<T0>());
                (arg3, v0)
            } else {
                assert!(0x1::option::is_none<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money>(&arg3), 4);
                (0x1::option::none<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money>(), v0)
            };
            (arg2, v3, v0)
        }
    }

    public fun pending_mandate_status() : u8 {
        0
    }

    public fun permission_authorization_id(arg0: &ContentSpendingPermissionCard) : 0x2::object::ID {
        arg0.authorization_id
    }

    fun permission_card(arg0: &0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::SpendingAuthorization, arg1: u8, arg2: 0x2::object::ID, arg3: 0x1::type_name::TypeName, arg4: &mut 0x2::tx_context::TxContext) : ContentSpendingPermissionCard {
        ContentSpendingPermissionCard{
            id                 : 0x2::object::new(arg4),
            authorization_id   : 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::authorization_id(arg0),
            vault_id           : 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::authorization_vault_id(arg0),
            grantor            : 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::authorization_grantor(arg0),
            pair_kind          : arg1,
            paired_consent_id  : arg2,
            authorization_mode : 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::authorization_mode(arg0),
            currency           : 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::authorization_currency(arg0),
            nominal_maximum    : 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::authorization_max_amount(arg0),
            calendar_period    : 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::authorization_period(arg0),
            grant_anchor_ms    : 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::authorization_anchor_ms(arg0),
            overall_expiry_ms  : 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::authorization_expiry(arg0),
            executors          : 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::authorization_executors(arg0),
            initial_asset_type : arg3,
        }
    }

    public fun publish_content_revision(arg0: &CreatorCap, arg1: &mut Content, arg2: &mut ContentRevision) {
        assert_content_auth(arg0, arg1);
        assert_content_mutable(arg1);
        assert!(arg2.content_id == 0x2::object::id<Content>(arg1), 7);
        mark_published(arg1, arg2);
    }

    public fun publish_revision(arg0: &CreatorCap, arg1: &mut Content, arg2: &mut ContentRevision) {
        publish_content_revision(arg0, arg1, arg2);
    }

    public fun purchase_content_access<T0>(arg0: &mut 0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault, arg1: &0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::CurrencyRegistry, arg2: &FeePolicy, arg3: &mut 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::SpendingAuthorization, arg4: &mut PurchaseIntent, arg5: &mut Content, arg6: &CreatorAccount, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_intent(arg4, arg3, 1, 0x2::object::id<Content>(arg5), arg5.terms_version, arg7);
        assert!(arg5.creator_id == 0x2::object::id<CreatorAccount>(arg6), 7);
        assert_content_purchasable<T0>(arg5, arg1);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg5.entitlements, arg4.buyer), 22);
        let v0 = quote(arg2, *0x1::option::borrow<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money>(&arg5.one_off_price));
        assert!(v0.total == arg4.exact_charge, 8);
        let v1 = ContentSpendScope{private: true};
        let (v2, v3, v4) = route_settlement<T0>(arg1, arg2, arg6, v0, 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::spend<T0, ContentSpendScope>(arg0, arg1, arg3, v1, v0.total, arg7, arg8));
        arg4.status = 1;
        let v5 = ContentAccessPass{
            id              : 0x2::object::new(arg8),
            owner           : arg4.buyer,
            content_id      : 0x2::object::id<Content>(arg5),
            purchased_at_ms : 0x2::clock::timestamp_ms(arg7),
            terms_version   : arg5.terms_version,
        };
        let v6 = 0x2::object::id<ContentAccessPass>(&v5);
        0x2::table::add<address, 0x2::object::ID>(&mut arg5.entitlements, arg4.buyer, v6);
        0x2::transfer::transfer<ContentAccessPass>(v5, arg4.buyer);
        emit_payment_settled<T0>(arg4.buyer, arg4.authorization_id, 1, 0x2::object::id<Content>(arg5), 0x2::object::id<PurchaseIntent>(arg4), arg5.terms_version, 0, v0.total, v2, v3, v4, 0x2::clock::timestamp_ms(arg7), v6);
        let v7 = ContentAccessSettled{
            intent_id : 0x2::object::id<PurchaseIntent>(arg4),
            pass_id   : v6,
        };
        0x2::event::emit<ContentAccessSettled>(v7);
        v6
    }

    public fun purchase_free_subscription(arg0: &mut SubscriptionTier, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.status == 0 && !arg0.archived, 6);
        assert!(0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::money_amount(&arg0.price) == 0, 4);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = if (0x1::option::is_some<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::CalendarPeriod>(&arg0.duration)) {
            let v3 = 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::derive_window(v1, v1, 0x1::option::borrow<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::CalendarPeriod>(&arg0.duration));
            0x1::option::some<u64>(0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::window_end_ms(&v3))
        } else {
            0x1::option::none<u64>()
        };
        let v4 = SubscriptionPass{
            id                 : 0x2::object::new(arg2),
            subscriber         : v0,
            tier_id            : 0x2::object::id<SubscriptionTier>(arg0),
            started_at_ms      : v1,
            expires_at_ms      : v2,
            nominal_paid       : arg0.price,
            payment_coin_type  : 0x1::option::none<0x1::type_name::TypeName>(),
            tier_terms_version : arg0.terms_version,
        };
        let v5 = 0x2::object::id<SubscriptionPass>(&v4);
        arg0.passes_minted = checked_add(arg0.passes_minted, 1, 10);
        install_current_pass(arg0, v0, v5, v2, v1);
        0x2::transfer::share_object<SubscriptionPass>(v4);
        create_subscription_card(v0, 0x2::object::id<SubscriptionTier>(arg0), v5, 0x1::option::none<0x2::object::ID>(), v1, arg2);
        let v6 = SubscriptionSettled{
            mandate_id : 0x1::option::none<0x2::object::ID>(),
            pass_id    : v5,
            replay_key : 0,
            renewal    : false,
        };
        0x2::event::emit<SubscriptionSettled>(v6);
        v5
    }

    public fun purchase_subscription_from_intent<T0>(arg0: &mut 0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault, arg1: &0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::CurrencyRegistry, arg2: &FeePolicy, arg3: &mut 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::SpendingAuthorization, arg4: &mut PurchaseIntent, arg5: &mut SubscriptionTier, arg6: &CreatorAccount, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_intent(arg4, arg3, 0, 0x2::object::id<SubscriptionTier>(arg5), arg5.terms_version, arg7);
        assert!(arg5.creator_id == 0x2::object::id<CreatorAccount>(arg6), 7);
        assert_paid_tier<T0>(arg5, arg1);
        let v0 = quote(arg2, arg5.price);
        assert!(v0.total == arg4.exact_charge, 8);
        let v1 = ContentSpendScope{private: true};
        let (v2, v3, v4) = route_settlement<T0>(arg1, arg2, arg6, v0, 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::spend<T0, ContentSpendScope>(arg0, arg1, arg3, v1, v0.total, arg7, arg8));
        arg4.status = 1;
        let v5 = 0x2::clock::timestamp_ms(arg7);
        let v6 = 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::derive_window(v5, v5, 0x1::option::borrow<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::CalendarPeriod>(&arg5.duration));
        let v7 = 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::window_end_ms(&v6);
        let v8 = SubscriptionPass{
            id                 : 0x2::object::new(arg8),
            subscriber         : arg4.buyer,
            tier_id            : 0x2::object::id<SubscriptionTier>(arg5),
            started_at_ms      : v5,
            expires_at_ms      : 0x1::option::some<u64>(v7),
            nominal_paid       : v0.total,
            payment_coin_type  : 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T0>()),
            tier_terms_version : arg5.terms_version,
        };
        let v9 = 0x2::object::id<SubscriptionPass>(&v8);
        arg5.passes_minted = checked_add(arg5.passes_minted, 1, 10);
        install_current_pass(arg5, arg4.buyer, v9, 0x1::option::some<u64>(v7), v5);
        0x2::transfer::share_object<SubscriptionPass>(v8);
        create_subscription_card(arg4.buyer, 0x2::object::id<SubscriptionTier>(arg5), v9, 0x1::option::none<0x2::object::ID>(), v5, arg8);
        emit_payment_settled<T0>(arg4.buyer, arg4.authorization_id, 0, 0x2::object::id<SubscriptionTier>(arg5), 0x2::object::id<PurchaseIntent>(arg4), arg5.terms_version, 0, v0.total, v2, v3, v4, v5, v9);
        let v10 = SubscriptionSettled{
            mandate_id : 0x1::option::none<0x2::object::ID>(),
            pass_id    : v9,
            replay_key : 0,
            renewal    : false,
        };
        0x2::event::emit<SubscriptionSettled>(v10);
        v9
    }

    public fun quote(arg0: &FeePolicy, arg1: 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money) : SettlementQuote {
        let v0 = 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::money_amount(&arg1);
        let v1 = 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::money_currency(&arg1);
        let v2 = (v0 as u128) * (arg0.fee_bps as u128) / (10000 as u128);
        assert!(v2 <= 18446744073709551615, 10);
        let v3 = (v2 as u64);
        if (arg0.mode == 0) {
            SettlementQuote{total: arg1, creator_proceeds: 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::money_from_parts(v0 - v3, v1), fee: 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::money_from_parts(v3, v1)}
        } else {
            SettlementQuote{total: 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::money_from_parts(checked_add(v0, v3, 10), v1), creator_proceeds: arg1, fee: 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::money_from_parts(v3, v1)}
        }
    }

    public fun quote_creator_proceeds(arg0: &SettlementQuote) : 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money {
        arg0.creator_proceeds
    }

    public fun quote_fee(arg0: &SettlementQuote) : 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money {
        arg0.fee
    }

    public fun quote_total(arg0: &SettlementQuote) : 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money {
        arg0.total
    }

    public fun reactivate_tier(arg0: &CreatorAccount, arg1: &CreatorCap, arg2: &mut SubscriptionTier) {
        assert_creator(arg0, arg1);
        assert!(arg2.creator_id == 0x2::object::id<CreatorAccount>(arg0), 7);
        assert!(!arg2.archived, 39);
        arg2.status = 0;
        arg2.deactivation_policy = 0;
        let v0 = TierStatusChanged{
            tier_id             : 0x2::object::id<SubscriptionTier>(arg2),
            status              : arg2.status,
            deactivation_policy : arg2.deactivation_policy,
            archived            : false,
        };
        0x2::event::emit<TierStatusChanged>(v0);
    }

    public fun register_content_scope(arg0: &mut 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::CurrencyRegistry, arg1: &0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::CurrencyRegistryAdminCap) {
        let v0 = ContentSpendScope{private: true};
        0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::register_scope<ContentSpendScope>(arg0, arg1, v0);
    }

    public fun register_creator_delegated(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg0 != @0x0, 2);
        assert!(arg1 != @0x0, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v1, v0);
        if (arg1 != v0) {
            0x2::vec_set::insert<address>(&mut v1, arg1);
        };
        let v2 = CreatorAccount{
            id                 : 0x2::object::new(arg2),
            primary_address    : v0,
            payout_address     : v0,
            decrypt_authorized : v1,
        };
        let v3 = 0x2::object::id<CreatorAccount>(&v2);
        let v4 = CreatorCap{
            id         : 0x2::object::new(arg2),
            account_id : v3,
        };
        let v5 = AccountCap{
            id         : 0x2::object::new(arg2),
            account_id : v3,
        };
        0x2::transfer::share_object<CreatorAccount>(v2);
        0x2::transfer::transfer<CreatorCap>(v4, arg0);
        0x2::transfer::transfer<AccountCap>(v5, v0);
        let v6 = CreatorCreated{
            account_id     : v3,
            cap_id         : 0x2::object::id<CreatorCap>(&v4),
            account_cap_id : 0x2::object::id<AccountCap>(&v5),
            payout         : v0,
        };
        0x2::event::emit<CreatorCreated>(v6);
        v3
    }

    public fun remove_content_tier(arg0: &CreatorAccount, arg1: &CreatorCap, arg2: &mut Content, arg3: 0x2::object::ID) {
        assert_creator(arg0, arg1);
        assert!(arg2.creator_id == 0x2::object::id<CreatorAccount>(arg0), 7);
        assert_content_mutable(arg2);
        let v0 = &mut arg2.allowed_tier_ids;
        assert!(vector_remove_id(v0, &arg3), 41);
        let v1 = ContentTierRemoved{
            content_id : 0x2::object::id<Content>(arg2),
            creator_id : arg2.creator_id,
            tier_id    : arg3,
        };
        0x2::event::emit<ContentTierRemoved>(v1);
    }

    public fun remove_decrypt_authorized(arg0: &mut CreatorAccount, arg1: &AccountCap, arg2: address) {
        assert_account_auth(arg1, arg0);
        assert!(arg2 != arg0.primary_address, 60);
        if (0x2::vec_set::contains<address>(&arg0.decrypt_authorized, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg0.decrypt_authorized, &arg2);
            let v0 = DecryptAuthorizedChanged{
                account_id : 0x2::object::id<CreatorAccount>(arg0),
                delegate   : arg2,
                authorized : false,
            };
            0x2::event::emit<DecryptAuthorizedChanged>(v0);
        };
    }

    public fun renew_subscription<T0>(arg0: &mut 0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault, arg1: &0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::CurrencyRegistry, arg2: &FeePolicy, arg3: &mut 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::SpendingAuthorization, arg4: &mut SubscriptionMandate, arg5: &mut SubscriptionTier, arg6: &CreatorAccount, arg7: &mut SubscriptionPass, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        validate_mandate(arg4, arg3, arg5);
        assert!(arg4.status == 1, 17);
        assert!(arg4.replay_index == arg8, 20);
        let v0 = 0x2::object::id<SubscriptionPass>(arg7);
        assert!(0x1::option::contains<0x2::object::ID>(&arg4.current_pass_id, &v0), 21);
        assert!(arg7.subscriber == arg4.subscriber && arg7.tier_id == 0x2::object::id<SubscriptionTier>(arg5), 21);
        assert_current_subscription_pass(arg5, arg7);
        assert!(arg5.creator_id == 0x2::object::id<CreatorAccount>(arg6), 7);
        assert_tier_renewable<T0>(arg5, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg9);
        let v2 = *0x1::option::borrow<u64>(&arg7.expires_at_ms);
        assert!(v1 >= v2, 19);
        let (v3, v4) = if (0x1::option::is_some<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money>(&arg4.locked_base_price)) {
            (*0x1::option::borrow<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money>(&arg4.locked_base_price), *0x1::option::borrow<u64>(&arg4.locked_terms_version))
        } else {
            let v4 = arg5.terms_version;
            (arg5.price, v4)
        };
        let v5 = quote(arg2, v3);
        let v6 = ContentSpendScope{private: true};
        let (v7, v8, v9) = route_settlement<T0>(arg1, arg2, arg6, v5, 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::spend<T0, ContentSpendScope>(arg0, arg1, arg3, v6, v5.total, arg9, arg10));
        let v10 = if (v1 > v2) {
            arg4.schedule_anchor_ms = 0x1::option::some<u64>(v1);
            v1
        } else {
            *0x1::option::borrow<u64>(&arg4.schedule_anchor_ms)
        };
        let v11 = 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::derive_window(v10, v1, 0x1::option::borrow<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::CalendarPeriod>(&arg5.duration));
        let v12 = 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::window_end_ms(&v11);
        arg7.started_at_ms = v1;
        arg7.expires_at_ms = 0x1::option::some<u64>(v12);
        arg7.nominal_paid = v5.total;
        arg7.payment_coin_type = 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T0>());
        arg7.tier_terms_version = v4;
        update_current_pass_expiry(arg5, arg7, v12);
        arg4.next_due_index = checked_add(arg4.next_due_index, 1, 10);
        arg4.replay_index = checked_add(arg4.replay_index, 1, 10);
        emit_payment_settled<T0>(arg4.subscriber, arg4.authorization_id, 0, 0x2::object::id<SubscriptionTier>(arg5), 0x2::object::id<SubscriptionMandate>(arg4), v4, arg8, v5.total, v7, v8, v9, v1, 0x2::object::id<SubscriptionPass>(arg7));
        let v13 = SubscriptionSettled{
            mandate_id : 0x1::option::some<0x2::object::ID>(0x2::object::id<SubscriptionMandate>(arg4)),
            pass_id    : 0x2::object::id<SubscriptionPass>(arg7),
            replay_key : arg8,
            renewal    : true,
        };
        0x2::event::emit<SubscriptionSettled>(v13);
        0x2::object::id<SubscriptionPass>(arg7)
    }

    public fun reset_tier_assets<T0>(arg0: &CreatorAccount, arg1: &CreatorCap, arg2: &0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::CurrencyRegistry, arg3: &mut SubscriptionTier) {
        assert_creator(arg0, arg1);
        assert!(arg3.creator_id == 0x2::object::id<CreatorAccount>(arg0), 7);
        assert!(!arg3.archived, 39);
        assert!(0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::is_asset_enabled<T0>(arg2, 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::money_currency(&arg3.price)), 5);
        let v0 = 0x2::vec_set::empty<0x1::type_name::TypeName>();
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0, 0x1::type_name::with_defining_ids<T0>());
        arg3.accepted_assets = v0;
    }

    fun revision_contains_seal_id(arg0: &ContentRevision, arg1: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ContentAsset>(&arg0.assets)) {
            if (0x1::vector::borrow<ContentAsset>(&arg0.assets, v0).seal_id == *arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun route_settlement<T0>(arg0: &0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::CurrencyRegistry, arg1: &FeePolicy, arg2: &CreatorAccount, arg3: SettlementQuote, arg4: 0x2::balance::Balance<T0>) : (u64, u64, u64) {
        let v0 = 0x2::balance::value<T0>(&arg4);
        let v1 = 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::raw_amount<T0>(arg0, &arg3.creator_proceeds);
        let v2 = 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::raw_amount<T0>(arg0, &arg3.fee);
        assert!(v1 <= 18446744073709551615 - v2, 10);
        assert!(v1 + v2 == v0, 9);
        if (v2 > 0) {
            0x2::balance::send_funds<T0>(0x2::balance::split<T0>(&mut arg4, v2), arg1.treasury);
        };
        0x2::balance::send_funds<T0>(arg4, arg2.payout_address);
        (v0, v1, v2)
    }

    entry fun seal_approve_content_access(arg0: vector<u8>, arg1: &Content, arg2: &ContentRevision, arg3: &ContentAccessPass, arg4: &0x2::tx_context::TxContext) {
        assert_published_asset(arg1, arg2, &arg0);
        assert!(has_method(arg1.access_methods, 2), 35);
        assert!(arg3.owner == 0x2::tx_context::sender(arg4), 51);
        assert!(arg3.content_id == 0x2::object::id<Content>(arg1), 52);
    }

    entry fun seal_approve_creator_delegate(arg0: vector<u8>, arg1: &Content, arg2: &ContentRevision, arg3: &CreatorAccount, arg4: &0x2::tx_context::TxContext) {
        assert_creator_asset(arg1, arg2, &arg0);
        assert!(arg1.creator_id == 0x2::object::id<CreatorAccount>(arg3), 7);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg3.decrypt_authorized, &v0), 54);
    }

    entry fun seal_approve_owner(arg0: vector<u8>, arg1: &Content, arg2: &ContentRevision, arg3: &AccountCap) {
        assert_creator_asset(arg1, arg2, &arg0);
        assert!(arg3.account_id == arg1.creator_id, 1);
    }

    entry fun seal_approve_subscription(arg0: vector<u8>, arg1: &Content, arg2: &ContentRevision, arg3: &SubscriptionPass, arg4: &SubscriptionTier, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_published_asset(arg1, arg2, &arg0);
        assert!(has_method(arg1.access_methods, 1), 35);
        assert!(arg3.subscriber == 0x2::tx_context::sender(arg6), 48);
        assert!(vector_contains_id(&arg1.allowed_tier_ids, &arg3.tier_id), 41);
        assert!(0x2::object::id<SubscriptionTier>(arg4) == arg3.tier_id, 21);
        assert_current_subscription_pass(arg4, arg3);
        if (0x1::option::is_some<u64>(&arg3.expires_at_ms)) {
            assert!(0x2::clock::timestamp_ms(arg5) < *0x1::option::borrow<u64>(&arg3.expires_at_ms), 49);
        };
    }

    public fun set_content_payout<T0>(arg0: &CreatorAccount, arg1: &CreatorCap, arg2: &0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::CurrencyRegistry, arg3: &mut Content, arg4: u8, arg5: u8, arg6: 0x1::option::Option<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money>) {
        update_content_terms<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun set_content_status(arg0: &CreatorCap, arg1: &mut Content, arg2: u8) {
        assert_content_auth(arg0, arg1);
        assert_content_mutable(arg1);
        assert_valid_content_status(arg2);
        arg1.status = arg2;
        let v0 = ContentStatusChanged{
            content_id : 0x2::object::id<Content>(arg1),
            creator_id : arg1.creator_id,
            status     : arg2,
        };
        0x2::event::emit<ContentStatusChanged>(v0);
    }

    public fun set_creator_payout(arg0: &mut CreatorAccount, arg1: &AccountCap, arg2: address) {
        assert_account_auth(arg1, arg0);
        assert!(arg2 != @0x0, 2);
        arg0.payout_address = arg2;
        let v0 = CreatorPayoutUpdated{
            account_id : 0x2::object::id<CreatorAccount>(arg0),
            payout     : arg2,
        };
        0x2::event::emit<CreatorPayoutUpdated>(v0);
    }

    public fun set_tier_active(arg0: &CreatorAccount, arg1: &CreatorCap, arg2: &mut SubscriptionTier, arg3: bool) {
        if (arg3) {
            reactivate_tier(arg0, arg1, arg2);
        } else {
            deactivate_tier(arg0, arg1, arg2, 1);
        };
    }

    fun shorten_current_free_pass(arg0: &mut SubscriptionTier, arg1: &mut SubscriptionPass, arg2: u64) {
        assert!(0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::money_amount(&arg1.nominal_paid) == 0, 55);
        assert!(arg1.tier_id == 0x2::object::id<SubscriptionTier>(arg0), 21);
        if (!0x2::table::contains<address, CurrentPassRef>(&arg0.current_passes, arg1.subscriber)) {
            return
        };
        assert!(0x2::table::borrow<address, CurrentPassRef>(&arg0.current_passes, arg1.subscriber).pass_id == 0x2::object::id<SubscriptionPass>(arg1), 56);
        let v0 = arg1.expires_at_ms;
        let v1 = if (0x1::option::is_some<u64>(&v0) && *0x1::option::borrow<u64>(&v0) < arg2) {
            *0x1::option::borrow<u64>(&v0)
        } else {
            arg2
        };
        arg1.expires_at_ms = 0x1::option::some<u64>(v1);
        0x2::table::borrow_mut<address, CurrentPassRef>(&mut arg0.current_passes, arg1.subscriber).expires_at_ms = 0x1::option::some<u64>(v1);
        let v2 = SubscriptionPassExpirationShortened{
            pass_id                : 0x2::object::id<SubscriptionPass>(arg1),
            subscriber             : arg1.subscriber,
            previous_expires_at_ms : v0,
            new_expires_at_ms      : v1,
        };
        0x2::event::emit<SubscriptionPassExpirationShortened>(v2);
    }

    public fun start_paid_subscription<T0>(arg0: &mut 0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault::Vault, arg1: &0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::CurrencyRegistry, arg2: &FeePolicy, arg3: &mut 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::SpendingAuthorization, arg4: &mut SubscriptionMandate, arg5: &mut SubscriptionTier, arg6: &CreatorAccount, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        validate_mandate(arg4, arg3, arg5);
        assert!(arg4.status == 0, 17);
        assert!(arg7 == 0 && arg4.replay_index == 0, 20);
        assert!(arg5.creator_id == 0x2::object::id<CreatorAccount>(arg6), 7);
        assert_paid_tier<T0>(arg5, arg1);
        let v0 = quote(arg2, arg5.price);
        let v1 = ContentSpendScope{private: true};
        let (v2, v3, v4) = route_settlement<T0>(arg1, arg2, arg6, v0, 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::spend<T0, ContentSpendScope>(arg0, arg1, arg3, v1, v0.total, arg8, arg9));
        let v5 = 0x2::clock::timestamp_ms(arg8);
        let v6 = 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::derive_window(v5, v5, 0x1::option::borrow<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::CalendarPeriod>(&arg5.duration));
        let v7 = 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::window_end_ms(&v6);
        let v8 = SubscriptionPass{
            id                 : 0x2::object::new(arg9),
            subscriber         : arg4.subscriber,
            tier_id            : 0x2::object::id<SubscriptionTier>(arg5),
            started_at_ms      : v5,
            expires_at_ms      : 0x1::option::some<u64>(v7),
            nominal_paid       : v0.total,
            payment_coin_type  : 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T0>()),
            tier_terms_version : arg5.terms_version,
        };
        let v9 = 0x2::object::id<SubscriptionPass>(&v8);
        arg5.passes_minted = checked_add(arg5.passes_minted, 1, 10);
        install_current_pass(arg5, arg4.subscriber, v9, 0x1::option::some<u64>(v7), v5);
        if (arg5.renewal_price_policy == 0) {
            arg4.locked_base_price = 0x1::option::some<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money>(arg5.price);
            arg4.locked_terms_version = 0x1::option::some<u64>(arg5.terms_version);
        } else {
            arg4.locked_base_price = 0x1::option::none<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money>();
            arg4.locked_terms_version = 0x1::option::none<u64>();
        };
        arg4.schedule_anchor_ms = 0x1::option::some<u64>(v5);
        arg4.next_due_index = 1;
        arg4.current_pass_id = 0x1::option::some<0x2::object::ID>(v9);
        arg4.replay_index = 1;
        arg4.status = 1;
        0x2::transfer::share_object<SubscriptionPass>(v8);
        create_subscription_card(arg4.subscriber, 0x2::object::id<SubscriptionTier>(arg5), v9, 0x1::option::some<0x2::object::ID>(0x2::object::id<SubscriptionMandate>(arg4)), v5, arg9);
        emit_payment_settled<T0>(arg4.subscriber, arg4.authorization_id, 0, 0x2::object::id<SubscriptionTier>(arg5), 0x2::object::id<SubscriptionMandate>(arg4), arg5.terms_version, arg7, v0.total, v2, v3, v4, v5, v9);
        let v10 = SubscriptionSettled{
            mandate_id : 0x1::option::some<0x2::object::ID>(0x2::object::id<SubscriptionMandate>(arg4)),
            pass_id    : v9,
            replay_key : arg7,
            renewal    : false,
        };
        0x2::event::emit<SubscriptionSettled>(v10);
        v9
    }

    public fun subscription_card_created_at_ms(arg0: &ContentSubscriptionCard) : u64 {
        arg0.created_at_ms
    }

    public fun subscription_card_mandate_id(arg0: &ContentSubscriptionCard) : 0x1::option::Option<0x2::object::ID> {
        arg0.mandate_id
    }

    public fun subscription_card_pass_id(arg0: &ContentSubscriptionCard) : 0x2::object::ID {
        arg0.pass_id
    }

    public fun subscription_card_subscriber(arg0: &ContentSubscriptionCard) : address {
        arg0.subscriber
    }

    public fun subscription_card_tier_id(arg0: &ContentSubscriptionCard) : 0x2::object::ID {
        arg0.tier_id
    }

    public fun subscription_pass_nominal_paid(arg0: &SubscriptionPass) : 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money {
        arg0.nominal_paid
    }

    public fun subscription_pass_terms_version(arg0: &SubscriptionPass) : u64 {
        arg0.tier_terms_version
    }

    public fun tier_creator_id(arg0: &SubscriptionTier) : 0x2::object::ID {
        arg0.creator_id
    }

    public fun tier_deactivation_policy(arg0: &SubscriptionTier) : u8 {
        arg0.deactivation_policy
    }

    public fun tier_duration(arg0: &SubscriptionTier) : 0x1::option::Option<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::CalendarPeriod> {
        arg0.duration
    }

    public fun tier_is_archived(arg0: &SubscriptionTier) : bool {
        arg0.archived
    }

    public fun tier_price(arg0: &SubscriptionTier) : 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money {
        arg0.price
    }

    public fun tier_renewal_price_policy(arg0: &SubscriptionTier) : u8 {
        arg0.renewal_price_policy
    }

    public fun tier_status(arg0: &SubscriptionTier) : u8 {
        arg0.status
    }

    public fun tier_terms_version(arg0: &SubscriptionTier) : u64 {
        arg0.terms_version
    }

    public fun transfer_account_cap(arg0: AccountCap, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 2);
        let v0 = AccountCapTransferred{
            account_id     : arg0.account_id,
            account_cap_id : 0x2::object::id<AccountCap>(&arg0),
            from           : 0x2::tx_context::sender(arg2),
            to             : arg1,
        };
        0x2::event::emit<AccountCapTransferred>(v0);
        0x2::transfer::transfer<AccountCap>(arg0, arg1);
    }

    public fun transfer_creator_cap(arg0: CreatorCap, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 2);
        let v0 = CreatorCapTransferred{
            account_id : arg0.account_id,
            cap_id     : 0x2::object::id<CreatorCap>(&arg0),
            from       : 0x2::tx_context::sender(arg2),
            to         : arg1,
        };
        0x2::event::emit<CreatorCapTransferred>(v0);
        0x2::transfer::transfer<CreatorCap>(arg0, arg1);
    }

    public fun update_content_terms<T0>(arg0: &CreatorAccount, arg1: &CreatorCap, arg2: &0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::CurrencyRegistry, arg3: &mut Content, arg4: u8, arg5: u8, arg6: 0x1::option::Option<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money>) {
        assert_creator(arg0, arg1);
        assert!(arg3.creator_id == 0x2::object::id<CreatorAccount>(arg0), 7);
        assert_content_mutable(arg3);
        apply_content_policy<T0>(arg3, arg2, arg4, arg5, arg6);
        arg3.terms_version = checked_add(arg3.terms_version, 1, 10);
        let v0 = ContentTermsUpdated{
            content_id     : 0x2::object::id<Content>(arg3),
            access_kind    : arg3.access_kind,
            access_methods : arg3.access_methods,
            terms_version  : arg3.terms_version,
        };
        0x2::event::emit<ContentTermsUpdated>(v0);
    }

    fun update_current_pass_expiry(arg0: &mut SubscriptionTier, arg1: &SubscriptionPass, arg2: u64) {
        assert!(0x2::table::contains<address, CurrentPassRef>(&arg0.current_passes, arg1.subscriber), 56);
        let v0 = 0x2::table::borrow_mut<address, CurrentPassRef>(&mut arg0.current_passes, arg1.subscriber);
        assert!(v0.pass_id == 0x2::object::id<SubscriptionPass>(arg1), 56);
        v0.expires_at_ms = 0x1::option::some<u64>(arg2);
    }

    public fun update_fee_policy(arg0: &mut FeePolicy, arg1: &FeePolicyAdminCap, arg2: u64, arg3: address, arg4: u8) {
        assert!(arg1.policy_id == 0x2::object::id<FeePolicy>(arg0), 9);
        assert_fee_terms(arg2, arg3, arg4);
        arg0.fee_bps = arg2;
        arg0.treasury = arg3;
        arg0.mode = arg4;
    }

    public fun update_tier_display(arg0: &CreatorAccount, arg1: &CreatorCap, arg2: &mut SubscriptionTier, arg3: vector<u8>, arg4: vector<u8>) {
        assert_creator(arg0, arg1);
        assert!(arg2.creator_id == 0x2::object::id<CreatorAccount>(arg0), 7);
        assert!(!arg2.archived, 39);
        assert_valid_display_name(&arg3);
        arg2.name = arg3;
        arg2.cover = arg4;
        let v0 = TierDisplayUpdated{
            tier_id : 0x2::object::id<SubscriptionTier>(arg2),
            name    : arg2.name,
            cover   : arg2.cover,
        };
        0x2::event::emit<TierDisplayUpdated>(v0);
    }

    public fun update_tier_terms(arg0: &CreatorAccount, arg1: &CreatorCap, arg2: &mut SubscriptionTier, arg3: 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::Money, arg4: 0x1::option::Option<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::CalendarPeriod>, arg5: u8) {
        assert_creator(arg0, arg1);
        assert!(arg2.creator_id == 0x2::object::id<CreatorAccount>(arg0), 7);
        assert!(!arg2.archived, 39);
        assert_valid_renewal_policy(arg5);
        assert!(0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::money_currency(&arg3) == 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::money_currency(&arg2.price), 4);
        if (0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::money_amount(&arg3) > 0) {
            assert!(0x1::option::is_some<0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::calendar::CalendarPeriod>(&arg4), 4);
        };
        arg2.price = arg3;
        arg2.duration = arg4;
        arg2.renewal_price_policy = arg5;
        arg2.terms_version = checked_add(arg2.terms_version, 1, 10);
        let v0 = TierTermsUpdated{
            tier_id              : 0x2::object::id<SubscriptionTier>(arg2),
            terms_version        : arg2.terms_version,
            price                : arg3,
            renewal_price_policy : arg5,
        };
        0x2::event::emit<TierTermsUpdated>(v0);
    }

    fun validate_mandate(arg0: &SubscriptionMandate, arg1: &0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::SpendingAuthorization, arg2: &SubscriptionTier) {
        assert!(arg0.tier_id == 0x2::object::id<SubscriptionTier>(arg2), 7);
        assert!(arg0.authorization_id == 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::authorization_id(arg1), 14);
        assert!(arg0.subscriber == 0x42d6060d778c96855c121b7f01bb0363c52a56f836ee1a9e1c64db77ed66a586::billing::authorization_grantor(arg1), 11);
        assert_content_recurring_authorization(arg1);
    }

    fun vector_contains_id(arg0: &vector<0x2::object::ID>, arg1: &0x2::object::ID) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            if (0x1::vector::borrow<0x2::object::ID>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun vector_remove_id(arg0: &mut vector<0x2::object::ID>, arg1: &0x2::object::ID) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            if (0x1::vector::borrow<0x2::object::ID>(arg0, v0) == arg1) {
                0x1::vector::swap_remove<0x2::object::ID>(arg0, v0);
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    // decompiled from Move bytecode v7
}

