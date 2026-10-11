module 0xc65d0197af771b408332c4acd9c4283e0a220de80767ab9f986c3892126deb68::content {
    struct CONTENT has drop {
        dummy_field: bool,
    }

    struct ContentManager has drop {
        dummy_field: bool,
    }

    struct PolicyRegistry has key {
        id: 0x2::object::UID,
    }

    struct WriteKey has copy, drop, store {
        creator_vault_id: 0x2::object::ID,
    }

    struct ReadKey has copy, drop, store {
        creator_vault_id: 0x2::object::ID,
    }

    struct FanReadKey has copy, drop, store {
        fan_vault_id: 0x2::object::ID,
    }

    struct ContentWrite has key {
        id: 0x2::object::UID,
        creator_vault_id: 0x2::object::ID,
        user_writer: address,
        platform_writer: 0x1::option::Option<address>,
    }

    struct ContentRead has key {
        id: 0x2::object::UID,
        creator_vault_id: 0x2::object::ID,
        reader: address,
    }

    struct FanRead has key {
        id: 0x2::object::UID,
        fan_vault_id: 0x2::object::ID,
        reader: address,
    }

    struct SubscriptionTier has key {
        id: 0x2::object::UID,
        creator_vault_id: 0x2::object::ID,
        name: vector<u8>,
        cover: vector<u8>,
        price: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money,
        duration: 0x1::option::Option<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::calendar::CalendarPeriod>,
        terms_version: u64,
        renewal_price_policy: u8,
        status: u8,
        deactivation_policy: u8,
        archived: bool,
        passes_minted: u64,
        subscribers: 0x2::table::Table<0x2::object::ID, FanState>,
    }

    struct FanState has copy, drop, store {
        active_mandate: 0x1::option::Option<0x2::object::ID>,
        paid_through_ms: u64,
        last_paid: 0x1::option::Option<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>,
        last_terms_version: u64,
        free_member: bool,
        free_since_ms: u64,
    }

    struct SubscriptionMandate has key {
        id: 0x2::object::UID,
        fan_vault_id: 0x2::object::ID,
        spender_cap_id: 0x2::object::ID,
        tier_id: 0x2::object::ID,
        creator_vault_id: 0x2::object::ID,
        fee_policy_id: 0x2::object::ID,
        currency: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
        expires_at_ms: 0x1::option::Option<u64>,
        status: u8,
        schedule_anchor_ms: 0x1::option::Option<u64>,
        next_period_index: u64,
        locked_base_price: 0x1::option::Option<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>,
        locked_terms_version: 0x1::option::Option<u64>,
        max_raw_per_period: u64,
        paused_until_ms: u64,
    }

    struct SubscriptionPass has store, key {
        id: 0x2::object::UID,
        fan_vault_id: 0x2::object::ID,
        tier_id: 0x2::object::ID,
        valid_from_ms: u64,
        valid_until_ms: u64,
        nominal_paid: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money,
        payment_coin_type: 0x1::type_name::TypeName,
        raw_paid: u64,
        rate: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::RateSnapshot,
        tier_terms_version: u64,
        mandate_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct PassKey has copy, drop, store {
        pass_id: 0x2::object::ID,
    }

    struct PurchaseIntent has key {
        id: 0x2::object::UID,
        fan_vault_id: 0x2::object::ID,
        spender_cap_id: 0x2::object::ID,
        product_kind: u8,
        subject_id: 0x2::object::ID,
        terms_version: u64,
        exact_charge: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money,
        creator_vault_id: 0x2::object::ID,
        fee_policy_id: 0x2::object::ID,
        currency: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
        expires_at_ms: u64,
        status: u8,
        max_raw: u64,
    }

    struct ContentPass has store, key {
        id: 0x2::object::UID,
        fan_vault_id: 0x2::object::ID,
        content_id: 0x2::object::ID,
        purchased_at_ms: u64,
        terms_version: u64,
        nominal_paid: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money,
        payment_coin_type: 0x1::type_name::TypeName,
        raw_paid: u64,
        rate: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::RateSnapshot,
        intent_id: 0x2::object::ID,
    }

    struct ContentKey has copy, drop, store {
        content_id: 0x2::object::ID,
    }

    struct Content has key {
        id: 0x2::object::UID,
        creator_vault_id: 0x2::object::ID,
        content_kind: u8,
        access_kind: u8,
        access_methods: u8,
        allowed_tier_ids: vector<0x2::object::ID>,
        one_off_price: 0x1::option::Option<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>,
        terms_version: u64,
        revision_count: u64,
        status: u8,
        latest_revision: 0x1::option::Option<0x2::object::ID>,
        published_revision: 0x1::option::Option<0x2::object::ID>,
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
        blob_object_id: 0x2::object::ID,
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
        total: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money,
        creator_proceeds: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money,
        fee: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money,
    }

    struct PolicyRegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
    }

    struct CreatorInitialized has copy, drop {
        creator_vault_id: 0x2::object::ID,
        content_write_id: 0x2::object::ID,
        content_read_id: 0x2::object::ID,
        financial_owner: address,
        user_writer: address,
        platform_writer: 0x1::option::Option<address>,
        reader: address,
    }

    struct FanInitialized has copy, drop {
        fan_vault_id: 0x2::object::ID,
        fan_read_id: 0x2::object::ID,
        financial_owner: address,
        reader: address,
    }

    struct FanReaderBound has copy, drop {
        fan_vault_id: 0x2::object::ID,
        fan_read_id: 0x2::object::ID,
        reader: address,
    }

    struct FanReaderSet has copy, drop {
        fan_vault_id: 0x2::object::ID,
        previous: address,
        reader: address,
    }

    struct UserWriterSet has copy, drop {
        creator_vault_id: 0x2::object::ID,
        previous: address,
        writer: address,
    }

    struct PlatformWriterSet has copy, drop {
        creator_vault_id: 0x2::object::ID,
        writer: 0x1::option::Option<address>,
    }

    struct ContentReaderSet has copy, drop {
        creator_vault_id: 0x2::object::ID,
        previous: address,
        reader: address,
    }

    struct TierCreated has copy, drop {
        tier_id: 0x2::object::ID,
        creator_vault_id: 0x2::object::ID,
        terms_version: u64,
    }

    struct TierTermsUpdated has copy, drop {
        tier_id: 0x2::object::ID,
        terms_version: u64,
        price: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money,
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
        creator_vault_id: 0x2::object::ID,
    }

    struct ContentCreated has copy, drop {
        content_id: 0x2::object::ID,
        creator_vault_id: 0x2::object::ID,
        content_kind: u8,
        access_kind: u8,
        access_methods: u8,
        terms_version: u64,
    }

    struct ContentTierAdded has copy, drop {
        content_id: 0x2::object::ID,
        creator_vault_id: 0x2::object::ID,
        tier_id: 0x2::object::ID,
    }

    struct ContentTierRemoved has copy, drop {
        content_id: 0x2::object::ID,
        creator_vault_id: 0x2::object::ID,
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
        creator_vault_id: 0x2::object::ID,
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

    struct FeePolicyUpdated has copy, drop {
        policy_id: 0x2::object::ID,
        fee_bps: u64,
        treasury: address,
        mode: u8,
    }

    struct MandateCreated has copy, drop {
        mandate_id: 0x2::object::ID,
        fan_vault_id: 0x2::object::ID,
        tier_id: 0x2::object::ID,
        creator_vault_id: 0x2::object::ID,
        spender_cap_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        max_raw_per_period: u64,
        expires_at_ms: 0x1::option::Option<u64>,
        locked_base_price: 0x1::option::Option<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>,
    }

    struct SubscriptionSettled has copy, drop {
        mandate_id: 0x2::object::ID,
        pass_id: 0x2::object::ID,
        period_index: u64,
        renewal: bool,
    }

    struct PaymentSettled has copy, drop {
        payer_vault_id: 0x2::object::ID,
        creator_vault_id: 0x2::object::ID,
        product_kind: u8,
        subject_id: 0x2::object::ID,
        consent_id: 0x2::object::ID,
        terms_version: u64,
        period_index: u64,
        nominal_currency: 0x1::type_name::TypeName,
        nominal_amount: u64,
        coin_type: 0x1::type_name::TypeName,
        raw_total: u64,
        raw_creator_proceeds: u64,
        raw_fee: u64,
        rate: u64,
        rate_decimals: u8,
        rate_updated_at_ms: u64,
        rate_source: address,
        settled_at_ms: u64,
        result_id: 0x2::object::ID,
    }

    struct MandateCancelled has copy, drop {
        mandate_id: 0x2::object::ID,
        fan_vault_id: 0x2::object::ID,
        tier_id: 0x2::object::ID,
    }

    struct MandatePaused has copy, drop {
        mandate_id: 0x2::object::ID,
        fan_vault_id: 0x2::object::ID,
        tier_id: 0x2::object::ID,
        paused_until_ms: u64,
    }

    struct MandateResumed has copy, drop {
        mandate_id: 0x2::object::ID,
        fan_vault_id: 0x2::object::ID,
        tier_id: 0x2::object::ID,
    }

    struct MandateReconciled has copy, drop {
        mandate_id: 0x2::object::ID,
        status: u8,
    }

    struct MandateClosed has copy, drop {
        mandate_id: 0x2::object::ID,
        spender_cap_id: 0x2::object::ID,
    }

    struct IntentCreated has copy, drop {
        intent_id: 0x2::object::ID,
        fan_vault_id: 0x2::object::ID,
        product_kind: u8,
        subject_id: 0x2::object::ID,
        creator_vault_id: 0x2::object::ID,
        spender_cap_id: 0x2::object::ID,
        terms_version: u64,
        exact_charge: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money,
        coin_type: 0x1::type_name::TypeName,
        max_raw: u64,
        expires_at_ms: u64,
    }

    struct IntentCancelled has copy, drop {
        intent_id: 0x2::object::ID,
        fan_vault_id: 0x2::object::ID,
    }

    struct IntentClosed has copy, drop {
        intent_id: 0x2::object::ID,
        spender_cap_id: 0x2::object::ID,
        status: u8,
    }

    struct IntentConsumed has copy, drop {
        intent_id: 0x2::object::ID,
        product_kind: u8,
        subject_id: 0x2::object::ID,
        pass_id: 0x2::object::ID,
    }

    struct FreeSubscriptionStarted has copy, drop {
        tier_id: 0x2::object::ID,
        fan_vault_id: 0x2::object::ID,
        since_ms: u64,
    }

    struct FreeSubscriptionEnded has copy, drop {
        tier_id: 0x2::object::ID,
        fan_vault_id: 0x2::object::ID,
        by: address,
    }

    public fun active_intent_status() : u8 {
        0
    }

    public fun active_mandate_status() : u8 {
        1
    }

    public fun active_tier_status() : u8 {
        0
    }

    public fun add_content_revision(arg0: &ContentWrite, arg1: &mut Content, arg2: u8, arg3: vector<u8>, arg4: vector<u32>, arg5: vector<vector<u8>>, arg6: vector<vector<u8>>, arg7: vector<0x2::object::ID>, arg8: vector<u64>, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_writer(arg0, arg11);
        assert_content_policy(arg0, arg1);
        assert_content_mutable(arg1);
        let v0 = append_revision(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0x2::transfer::share_object<ContentRevision>(v0);
        0x2::object::id<ContentRevision>(&v0)
    }

    public fun add_content_tier(arg0: &ContentWrite, arg1: &mut Content, arg2: &SubscriptionTier, arg3: &mut 0x2::tx_context::TxContext) {
        assert_writer(arg0, arg3);
        assert_content_policy(arg0, arg1);
        assert_content_mutable(arg1);
        assert!(arg2.creator_vault_id == arg1.creator_vault_id, 13839002892550930459);
        assert!(!arg2.archived, 13838158471915372565);
        assert!(arg2.status == 0, 13844913875654541381);
        let v0 = 0x2::object::id<SubscriptionTier>(arg2);
        assert!(!vector_contains_id(&arg1.allowed_tier_ids, &v0), 13839284384707641373);
        assert!(0x1::vector::length<0x2::object::ID>(&arg1.allowed_tier_ids) < 32, 13839847338956292129);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.allowed_tier_ids, v0);
        let v1 = ContentTierAdded{
            content_id       : 0x2::object::id<Content>(arg1),
            creator_vault_id : arg1.creator_vault_id,
            tier_id          : v0,
        };
        0x2::event::emit<ContentTierAdded>(v1);
    }

    public fun add_published_revision(arg0: &ContentWrite, arg1: &mut Content, arg2: u8, arg3: vector<u8>, arg4: vector<u32>, arg5: vector<vector<u8>>, arg6: vector<vector<u8>>, arg7: vector<0x2::object::ID>, arg8: vector<u64>, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_writer(arg0, arg11);
        assert_content_policy(arg0, arg1);
        assert_content_mutable(arg1);
        let v0 = append_revision(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v1 = &mut v0;
        mark_published(arg1, v1);
        0x2::transfer::share_object<ContentRevision>(v0);
        0x2::object::id<ContentRevision>(&v0)
    }

    public fun additive_fee_mode() : u8 {
        1
    }

    fun append_revision(arg0: &mut Content, arg1: u8, arg2: vector<u8>, arg3: vector<u32>, arg4: vector<vector<u8>>, arg5: vector<vector<u8>>, arg6: vector<0x2::object::ID>, arg7: vector<u64>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : ContentRevision {
        assert!(arg1 == 0 || arg1 == 1, 13840417203807322149);
        let v0 = 0x1::vector::length<u8>(&arg2);
        assert!(v0 > 0, 13841543112304623661);
        assert!(0x1::vector::length<u32>(&arg3) == v0, 13841824591576432687);
        assert!(0x1::vector::length<vector<u8>>(&arg4) == v0, 13841824595871399983);
        assert!(0x1::vector::length<vector<u8>>(&arg5) == v0, 13841824600166367279);
        assert!(0x1::vector::length<0x2::object::ID>(&arg6) == v0, 13841824604461334575);
        assert!(0x1::vector::length<u64>(&arg7) == v0, 13841824608756301871);
        let v1 = arg1 == 0;
        if (v1) {
            assert!(0x1::vector::is_empty<u8>(&arg8), 13842106100913012785);
        } else {
            assert!(!0x1::vector::is_empty<u8>(&arg8), 13842387584479789107);
            assert_creator_seal_id(arg0, &arg8);
        };
        let v2 = 0x1::vector::empty<ContentAsset>();
        let v3 = 0;
        while (v3 < v0) {
            let v4 = *0x1::vector::borrow<vector<u8>>(&arg4, v3);
            if (v1) {
                assert!(0x1::vector::is_empty<u8>(&v4), 13842106143862685745);
            } else {
                assert!(!0x1::vector::is_empty<u8>(&v4), 13842387627429462067);
                assert_creator_seal_id(arg0, &v4);
            };
            let v5 = ContentAsset{
                asset_kind     : *0x1::vector::borrow<u8>(&arg2, v3),
                order_index    : *0x1::vector::borrow<u32>(&arg3, v3),
                seal_id        : v4,
                blob_id        : *0x1::vector::borrow<vector<u8>>(&arg5, v3),
                blob_object_id : *0x1::vector::borrow<0x2::object::ID>(&arg6, v3),
                size_bytes     : *0x1::vector::borrow<u64>(&arg7, v3),
            };
            0x1::vector::push_back<ContentAsset>(&mut v2, v5);
            v3 = v3 + 1;
        };
        let v6 = checked_add(arg0.revision_count, 1);
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

    fun apply_content_policy(arg0: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::CurrencyRegistry, arg1: &mut Content, arg2: u8, arg3: u8, arg4: 0x1::option::Option<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>) {
        let (v0, v1) = normalized_content_policy(arg0, arg2, arg3, arg4);
        if (arg2 == 0 || !has_method(v0, 1)) {
            clear_content_tiers(arg1);
        };
        arg1.access_kind = arg2;
        arg1.access_methods = v0;
        arg1.one_off_price = v1;
    }

    public fun apply_latest_price_policy() : u8 {
        1
    }

    public fun archive_content(arg0: &ContentWrite, arg1: &mut Content, arg2: &mut 0x2::tx_context::TxContext) {
        set_content_status(arg0, arg1, 2, arg2);
    }

    public fun archive_tier(arg0: &ContentWrite, arg1: &mut SubscriptionTier, arg2: &mut 0x2::tx_context::TxContext) {
        assert_lifecycle_authority(arg0, arg2);
        assert_tier_policy(arg0, arg1);
        arg1.status = 1;
        arg1.deactivation_policy = 0;
        arg1.archived = true;
        emit_tier_status(arg1);
    }

    public fun archived_content_status() : u8 {
        2
    }

    fun assert_consented_terms(arg0: &PurchaseIntent, arg1: u64, arg2: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money) {
        let v0 = if (arg0.terms_version == arg1) {
            if (0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_amount(&arg2) == 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_amount(&arg0.exact_charge)) {
                0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_currency(&arg2) == 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_currency(&arg0.exact_charge)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13850266895261499499);
    }

    fun assert_content_for_sale(arg0: &Content) {
        let v0 = if (arg0.status == 1) {
            if (arg0.access_kind == 1) {
                if (has_method(arg0.access_methods, 2)) {
                    0x1::option::is_some<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>(&arg0.one_off_price)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13850829428603355247);
    }

    fun assert_content_mutable(arg0: &Content) {
        assert!(arg0.status != 2, 13841261121931706411);
    }

    fun assert_content_policy(arg0: &ContentWrite, arg1: &Content) {
        assert!(arg1.creator_vault_id == arg0.creator_vault_id, 13838725785555828761);
    }

    fun assert_creator_asset(arg0: &Content, arg1: &ContentRevision, arg2: &vector<u8>) {
        assert!(arg1.access_kind == 1, 13843232503331553337);
        assert!(arg0.status != 2, 13841262182788628523);
        assert!(arg1.content_id == 0x2::object::id<Content>(arg0), 13838728912292020249);
        assert_creator_seal_id(arg0, arg2);
        assert!(revision_has_seal_id(arg1, arg2), 13843513995488264251);
    }

    fun assert_creator_seal_id(arg0: &Content, arg1: &vector<u8>) {
        let v0 = 0x2::object::id_to_bytes(&arg0.creator_vault_id);
        let v1 = 0x1::vector::length<u8>(&v0);
        assert!(0x1::vector::length<u8>(arg1) > v1, 13842669514723164213);
        let v2 = 0;
        while (v2 < v1) {
            assert!(*0x1::vector::borrow<u8>(arg1, v2) == *0x1::vector::borrow<u8>(&v0, v2), 13842669527608066101);
            v2 = v2 + 1;
        };
    }

    fun assert_fan_reader(arg0: &FanRead, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.reader, 13843793567794593853);
    }

    fun assert_fan_session(arg0: &FanRead, arg1: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg2: &0x2::tx_context::TxContext) {
        assert_fan_reader(arg0, arg2);
        assert!(arg0.fan_vault_id == 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg1), 13852802807162994813);
    }

    fun assert_fan_vault(arg0: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: &FanRead) {
        assert_managed(arg0);
        assert!(arg1.fan_vault_id == 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg0), 13852799598822424701);
    }

    fun assert_fee_terms(arg0: u64, arg1: address, arg2: u8) {
        assert!(arg0 <= 3000, 13844357363856834625);
        assert!(arg1 != @0x0, 13836194593823391751);
        assert!(arg2 == 0 || arg2 == 1, 13844357372446769217);
    }

    fun assert_intent_settles<T0>(arg0: &PurchaseIntent, arg1: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg2: &FeePolicy, arg3: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg4: u8, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: &0x2::clock::Clock) {
        assert!(arg0.status == 0, 13849703872293372007);
        assert!(0x2::clock::timestamp_ms(arg7) < arg0.expires_at_ms, 13848015026727288923);
        assert!(arg0.product_kind == arg4 && arg0.subject_id == arg5, 13849422405906464869);
        assert!(arg0.fan_vault_id == 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg1) && arg0.fee_policy_id == 0x2::object::id<FeePolicy>(arg2), 13849422410201432165);
        assert!(arg0.creator_vault_id == 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg3) && arg6 == 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg3), 13849140948109492323);
        assert!(arg0.coin_type == 0x1::type_name::with_defining_ids<T0>(), 13847733581815218265);
    }

    fun assert_lifecycle_authority(arg0: &ContentWrite, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.user_writer, 13835629526450831363);
    }

    fun assert_managed(arg0: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault) {
        assert!(0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::child_manager(arg0) == 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<ContentManager>()), 13845199735792992327);
    }

    fun assert_non_zero(arg0: address) {
        assert!(arg0 != @0x0, 13836192411980005383);
    }

    fun assert_owner_cap(arg0: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::OwnerCap, arg1: 0x2::object::ID) {
        assert!(0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::owner_cap_vault_id(arg0) == arg1, 13835910954183032837);
    }

    fun assert_paid_tier(arg0: &SubscriptionTier) {
        assert!(arg0.status == 0 && !arg0.archived, 13844918320945692741);
        assert!(0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_amount(&arg0.price) > 0 && 0x1::option::is_some<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::calendar::CalendarPeriod>(&arg0.duration), 13837037025889091597);
    }

    fun assert_price_terms(arg0: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money, arg1: &0x1::option::Option<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::calendar::CalendarPeriod>) {
        if (is_free_price(arg0)) {
            assert!(0x1::option::is_none<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::calendar::CalendarPeriod>(arg1), 13851393362104549491);
        } else {
            assert!(0x1::option::is_some<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::calendar::CalendarPeriod>(arg1), 13837038146875555853);
        };
    }

    fun assert_published_asset(arg0: &Content, arg1: &ContentRevision, arg2: &vector<u8>, arg3: u8) {
        assert!(arg0.status != 2, 13841262230033268779);
        assert!(arg1.content_id == 0x2::object::id<Content>(arg0), 13838728959536660505);
        let v0 = if (arg0.status == 1) {
            let v1 = 0x2::object::id<ContentRevision>(arg1);
            if (0x1::option::contains<0x2::object::ID>(&arg0.published_revision, &v1)) {
                arg1.status == 1
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13853084204830425215);
        assert!(arg0.access_kind == 1 && arg1.access_kind == 1, 13843232589230899257);
        assert!(has_method(arg0.access_methods, arg3), 13853365692692168833);
        assert_creator_seal_id(arg0, arg2);
        assert!(revision_has_seal_id(arg1, arg2), 13843514077092642875);
    }

    fun assert_tier_policy(arg0: &ContentWrite, arg1: &SubscriptionTier) {
        assert!(arg1.creator_vault_id == arg0.creator_vault_id, 13838725768375959577);
    }

    fun assert_tier_renewable(arg0: &SubscriptionTier) {
        assert!(!arg0.archived, 13838162951566262293);
        assert!(arg0.status == 0 || arg0.status == 1 && arg0.deactivation_policy == 1, 13844918368190332997);
        assert!(0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_amount(&arg0.price) > 0 && 0x1::option::is_some<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::calendar::CalendarPeriod>(&arg0.duration), 13837037077428699149);
    }

    fun assert_valid_content_status(arg0: u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        };
        assert!(v0, 13837601925757927441);
    }

    fun assert_valid_deactivation_policy(arg0: u8) {
        assert!(arg0 == 1 || arg0 == 2, 13837883370669998099);
    }

    fun assert_valid_display_name(arg0: &vector<u8>) {
        assert!(!0x1::vector::is_empty<u8>(arg0), 13836475918476378121);
        assert!(0x1::vector::length<u8>(arg0) <= 128, 13836757397748187147);
    }

    fun assert_valid_renewal_policy(arg0: u8) {
        assert!(arg0 == 0 || arg0 == 1, 13837320373471674383);
    }

    fun assert_valid_tier_status(arg0: u8) {
        assert!(arg0 == 0 || arg0 == 1, 13837601869923352593);
    }

    fun assert_writer(arg0: &ContentWrite, arg1: &0x2::tx_context::TxContext) {
        assert!(is_writer(arg0, 0x2::tx_context::sender(arg1)), 13835348021409218561);
    }

    public fun bind_fan_vault_reader(arg0: &mut PolicyRegistry, arg1: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg2: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::VaultRole, arg3: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::OwnerCap, arg4: address) : 0x2::object::ID {
        let v0 = 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg1);
        0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::assert_role(arg2, arg1, 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::binding_financial_owner(arg2), 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::fan_role());
        assert_owner_cap(arg3, v0);
        assert_non_zero(arg4);
        let v1 = new_fan_read(arg0, v0, arg4);
        let v2 = 0x2::object::id<FanRead>(&v1);
        let v3 = FanReaderBound{
            fan_vault_id : v0,
            fan_read_id  : v2,
            reader       : arg4,
        };
        0x2::event::emit<FanReaderBound>(v3);
        0x2::transfer::share_object<FanRead>(v1);
        v2
    }

    public fun bio_kind() : u8 {
        2
    }

    public fun borrow_content_pass(arg0: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: 0x2::object::ID) : &ContentPass {
        let v0 = ContentKey{content_id: arg1};
        0x2::dynamic_object_field::borrow<ContentKey, ContentPass>(0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::uid(arg0), v0)
    }

    public fun borrow_subscription_pass(arg0: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: 0x2::object::ID) : &SubscriptionPass {
        let v0 = PassKey{pass_id: arg1};
        0x2::dynamic_object_field::borrow<PassKey, SubscriptionPass>(0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::uid(arg0), v0)
    }

    public fun cancel_free_subscription(arg0: &FanRead, arg1: &mut SubscriptionTier, arg2: &mut 0x2::tx_context::TxContext) {
        assert_fan_reader(arg0, arg2);
        end_free_membership(arg1, arg0.fan_vault_id, arg2);
    }

    public fun cancel_free_subscription_by_creator(arg0: &ContentWrite, arg1: &mut SubscriptionTier, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert_writer(arg0, arg3);
        assert_tier_policy(arg0, arg1);
        end_free_membership(arg1, arg2, arg3);
    }

    public fun cancel_intent(arg0: &mut 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::OwnerCap, arg2: &mut PurchaseIntent, arg3: &mut 0x2::tx_context::TxContext) {
        assert_owner_cap(arg1, 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg0));
        assert!(arg2.fan_vault_id == 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg0), 13849419511098507365);
        assert!(arg2.status != 1, 13849700990370316391);
        if (is_intent_terminal(arg2)) {
            return
        };
        0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::revoke_all_allowances(arg0, arg1, arg2.spender_cap_id, arg3);
        arg2.status = 2;
        let v0 = IntentCancelled{
            intent_id    : 0x2::object::id<PurchaseIntent>(arg2),
            fan_vault_id : arg2.fan_vault_id,
        };
        0x2::event::emit<IntentCancelled>(v0);
    }

    public fun cancel_mandate(arg0: &mut 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::OwnerCap, arg2: &mut SubscriptionMandate, arg3: &mut SubscriptionTier, arg4: &mut 0x2::tx_context::TxContext) {
        assert_owner_cap(arg1, 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg0));
        assert!(arg2.fan_vault_id == 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg0) && arg2.tier_id == 0x2::object::id<SubscriptionTier>(arg3), 13845759662089699403);
        if (is_terminal(arg2)) {
            return
        };
        0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::revoke_all_allowances(arg0, arg1, arg2.spender_cap_id, arg4);
        arg2.status = 2;
        release_active_mandate(arg3, arg2);
        let v0 = MandateCancelled{
            mandate_id   : 0x2::object::id<SubscriptionMandate>(arg2),
            fan_vault_id : arg2.fan_vault_id,
            tier_id      : arg2.tier_id,
        };
        0x2::event::emit<MandateCancelled>(v0);
    }

    public fun cancelled_intent_status() : u8 {
        2
    }

    public fun cancelled_mandate_status() : u8 {
        2
    }

    fun checked_add(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, 13844640050014453827);
        arg0 + arg1
    }

    fun clear_content_tiers(arg0: &mut Content) {
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg0.allowed_tier_ids)) {
            let v0 = ContentTierRemoved{
                content_id       : 0x2::object::id<Content>(arg0),
                creator_vault_id : arg0.creator_vault_id,
                tier_id          : 0x1::vector::pop_back<0x2::object::ID>(&mut arg0.allowed_tier_ids),
            };
            0x2::event::emit<ContentTierRemoved>(v0);
        };
    }

    public fun close_expired_intent(arg0: &mut 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: &mut PurchaseIntent, arg2: 0x2::transfer::Receiving<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fan_vault_id == 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg0), 13849419592702885989);
        let v0 = arg1.status == 0 && 0x2::clock::timestamp_ms(arg3) >= arg1.expires_at_ms;
        assert!(is_intent_terminal(arg1) || v0, 13849982551246504041);
        let v1 = 0x2::transfer::public_receive<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap>(&mut arg1.id, arg2);
        assert!(0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap>(&v1) == arg1.spender_cap_id, 13847167810068021333);
        0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::renounce(arg0, v1, arg4);
        if (v0) {
            arg1.status = 3;
        };
        let v2 = IntentClosed{
            intent_id      : 0x2::object::id<PurchaseIntent>(arg1),
            spender_cap_id : arg1.spender_cap_id,
            status         : arg1.status,
        };
        0x2::event::emit<IntentClosed>(v2);
    }

    public fun close_expired_mandate(arg0: &mut 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: &mut SubscriptionMandate, arg2: &mut SubscriptionTier, arg3: 0x2::transfer::Receiving<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fan_vault_id == 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg0) && arg1.tier_id == 0x2::object::id<SubscriptionTier>(arg2), 13845760014277017675);
        assert!(is_terminal(arg1) || consent_expired(arg1, arg4), 13848574768340402271);
        let v0 = 0x2::transfer::public_receive<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap>(&mut arg1.id, arg3);
        assert!(0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap>(&v0) == arg1.spender_cap_id, 13847167402046128213);
        0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::renounce(arg0, v0, arg5);
        if (!is_terminal(arg1)) {
            arg1.status = 3;
            release_active_mandate(arg2, arg1);
        };
        let v1 = MandateClosed{
            mandate_id     : 0x2::object::id<SubscriptionMandate>(arg1),
            spender_cap_id : arg1.spender_cap_id,
        };
        0x2::event::emit<MandateClosed>(v1);
    }

    fun consent_expired(arg0: &SubscriptionMandate, arg1: &0x2::clock::Clock) : bool {
        0x1::option::is_some<u64>(&arg0.expires_at_ms) && 0x2::clock::timestamp_ms(arg1) >= *0x1::option::borrow<u64>(&arg0.expires_at_ms)
    }

    fun consent_price(arg0: &SubscriptionTier, arg1: 0x2::object::ID, arg2: u64) : (0x1::option::Option<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>, 0x1::option::Option<u64>) {
        if (arg0.renewal_price_policy == 1) {
            return (0x1::option::none<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>(), 0x1::option::none<u64>())
        };
        let v0 = 0x2::table::borrow<0x2::object::ID, FanState>(&arg0.subscribers, arg1);
        if (v0.paid_through_ms > arg2 && 0x1::option::is_some<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>(&v0.last_paid)) {
            (v0.last_paid, 0x1::option::some<u64>(v0.last_terms_version))
        } else {
            (0x1::option::some<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>(arg0.price), 0x1::option::some<u64>(arg0.terms_version))
        }
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

    public fun content_allows_tier(arg0: &Content, arg1: 0x2::object::ID) : bool {
        vector_contains_id(&arg0.allowed_tier_ids, &arg1)
    }

    public fun content_creator_vault_id(arg0: &Content) : 0x2::object::ID {
        arg0.creator_vault_id
    }

    public fun content_latest_revision(arg0: &Content) : 0x1::option::Option<0x2::object::ID> {
        arg0.latest_revision
    }

    public fun content_pass_content_id(arg0: &ContentPass) : 0x2::object::ID {
        arg0.content_id
    }

    public fun content_pass_fan_vault_id(arg0: &ContentPass) : 0x2::object::ID {
        arg0.fan_vault_id
    }

    public fun content_pass_intent_id(arg0: &ContentPass) : 0x2::object::ID {
        arg0.intent_id
    }

    public fun content_pass_nominal_paid(arg0: &ContentPass) : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money {
        arg0.nominal_paid
    }

    public fun content_pass_payment_coin_type(arg0: &ContentPass) : 0x1::type_name::TypeName {
        arg0.payment_coin_type
    }

    public fun content_pass_purchased_at_ms(arg0: &ContentPass) : u64 {
        arg0.purchased_at_ms
    }

    public fun content_pass_rate(arg0: &ContentPass) : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::RateSnapshot {
        arg0.rate
    }

    public fun content_pass_raw_paid(arg0: &ContentPass) : u64 {
        arg0.raw_paid
    }

    public fun content_pass_terms_version(arg0: &ContentPass) : u64 {
        arg0.terms_version
    }

    public fun content_price(arg0: &Content) : 0x1::option::Option<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money> {
        arg0.one_off_price
    }

    public fun content_product_kind() : u8 {
        1
    }

    public fun content_published_revision(arg0: &Content) : 0x1::option::Option<0x2::object::ID> {
        arg0.published_revision
    }

    public fun content_read_address(arg0: 0x2::object::ID, arg1: 0x2::object::ID) : address {
        let v0 = ReadKey{creator_vault_id: arg1};
        0x2::derived_object::derive_address<ReadKey>(arg0, v0)
    }

    public fun content_revision_count(arg0: &Content) : u64 {
        arg0.revision_count
    }

    public fun content_status(arg0: &Content) : u8 {
        arg0.status
    }

    public fun content_terms_version(arg0: &Content) : u64 {
        arg0.terms_version
    }

    public fun content_write_address(arg0: 0x2::object::ID, arg1: 0x2::object::ID) : address {
        let v0 = WriteKey{creator_vault_id: arg1};
        0x2::derived_object::derive_address<WriteKey>(arg0, v0)
    }

    public fun create_content(arg0: &ContentWrite, arg1: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::CurrencyRegistry, arg2: u8, arg3: u8, arg4: u8, arg5: 0x1::option::Option<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_writer(arg0, arg6);
        let v0 = new_content(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::share_object<Content>(v0);
        0x2::object::id<Content>(&v0)
    }

    public fun create_content_and_publish_revision(arg0: &ContentWrite, arg1: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::CurrencyRegistry, arg2: u8, arg3: u8, arg4: u8, arg5: 0x1::option::Option<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>, arg6: vector<u8>, arg7: vector<u32>, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: vector<0x2::object::ID>, arg11: vector<u64>, arg12: vector<u8>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID) {
        assert_writer(arg0, arg14);
        let v0 = new_content(arg0, arg1, arg2, arg3, arg4, arg5, arg14);
        let v1 = &mut v0;
        let v2 = append_revision(v1, arg3, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        let v3 = &mut v0;
        let v4 = &mut v2;
        mark_published(v3, v4);
        0x2::transfer::share_object<ContentRevision>(v2);
        0x2::transfer::share_object<Content>(v0);
        (0x2::object::id<Content>(&v0), 0x2::object::id<ContentRevision>(&v2))
    }

    public fun create_content_purchase_intent<T0>(arg0: &mut 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: &FanRead, arg2: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::OwnerCap, arg3: &FeePolicy, arg4: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::CurrencyRegistry, arg5: &Content, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_content_for_sale(arg5);
        assert!(!has_content_pass(arg0, 0x2::object::id<Content>(arg5)), 13850545252092084333);
        new_intent<T0>(arg0, arg1, arg2, arg3, arg4, 1, 0x2::object::id<Content>(arg5), arg5.terms_version, *0x1::option::borrow<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>(&arg5.one_off_price), arg5.creator_vault_id, arg6, arg7, arg8, arg9)
    }

    public fun create_subscription_mandate<T0>(arg0: &mut 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: &FanRead, arg2: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::OwnerCap, arg3: &FeePolicy, arg4: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::CurrencyRegistry, arg5: &mut SubscriptionTier, arg6: u64, arg7: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::calendar::CalendarPeriod, arg8: 0x1::option::Option<u64>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg0);
        assert_owner_cap(arg2, v0);
        assert_fan_vault(arg0, arg1);
        assert_paid_tier(arg5);
        assert!(arg7 == *0x1::option::borrow<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::calendar::CalendarPeriod>(&arg5.duration), 13854766414672035979);
        if (!0x2::table::contains<0x2::object::ID, FanState>(&arg5.subscribers, v0)) {
            0x2::table::add<0x2::object::ID, FanState>(&mut arg5.subscribers, v0, new_fan_state());
        };
        assert!(0x1::option::is_none<0x2::object::ID>(&0x2::table::borrow<0x2::object::ID, FanState>(&arg5.subscribers, v0).active_mandate), 13845477749026193481);
        let v1 = 0x2::clock::timestamp_ms(arg9);
        let (v2, v3) = consent_price(arg5, v0, v1);
        let v4 = v2;
        let v5 = if (0x1::option::is_some<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>(&v4)) {
            *0x1::option::borrow<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>(&v4)
        } else {
            arg5.price
        };
        let v6 = quote(arg3, v5);
        let (v7, _) = 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::to_coin_units<T0>(arg4, v6.total, arg9);
        assert!(v7 <= arg6, 13847448099633889367);
        let v9 = if (0x1::option::is_some<u64>(&arg8)) {
            *0x1::option::borrow<u64>(&arg8)
        } else {
            18446744073709551615
        };
        let v10 = 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::mint_spender_cap(arg0, arg2, arg10);
        let v11 = 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap>(&v10);
        0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::set_calendar_allowance<T0>(arg0, arg2, v11, arg6, &arg7, v1, v9, arg9, arg10);
        let v12 = SubscriptionMandate{
            id                   : 0x2::object::new(arg10),
            fan_vault_id         : v0,
            spender_cap_id       : v11,
            tier_id              : 0x2::object::id<SubscriptionTier>(arg5),
            creator_vault_id     : arg5.creator_vault_id,
            fee_policy_id        : 0x2::object::id<FeePolicy>(arg3),
            currency             : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_currency(&arg5.price),
            coin_type            : 0x1::type_name::with_defining_ids<T0>(),
            expires_at_ms        : arg8,
            status               : 0,
            schedule_anchor_ms   : 0x1::option::none<u64>(),
            next_period_index    : 0,
            locked_base_price    : v4,
            locked_terms_version : v3,
            max_raw_per_period   : arg6,
            paused_until_ms      : 0,
        };
        let v13 = 0x2::object::id<SubscriptionMandate>(&v12);
        0x2::table::borrow_mut<0x2::object::ID, FanState>(&mut arg5.subscribers, v0).active_mandate = 0x1::option::some<0x2::object::ID>(v13);
        0x2::transfer::public_transfer<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap>(v10, 0x2::object::id_to_address(&v13));
        let v14 = MandateCreated{
            mandate_id         : v13,
            fan_vault_id       : v0,
            tier_id            : 0x2::object::id<SubscriptionTier>(arg5),
            creator_vault_id   : arg5.creator_vault_id,
            spender_cap_id     : v11,
            coin_type          : 0x1::type_name::with_defining_ids<T0>(),
            max_raw_per_period : arg6,
            expires_at_ms      : arg8,
            locked_base_price  : v4,
        };
        0x2::event::emit<MandateCreated>(v14);
        0x2::transfer::share_object<SubscriptionMandate>(v12);
        v13
    }

    public fun create_subscription_purchase_intent<T0>(arg0: &mut 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: &FanRead, arg2: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::OwnerCap, arg3: &FeePolicy, arg4: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::CurrencyRegistry, arg5: &SubscriptionTier, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_paid_tier(arg5);
        new_intent<T0>(arg0, arg1, arg2, arg3, arg4, 0, 0x2::object::id<SubscriptionTier>(arg5), arg5.terms_version, arg5.price, arg5.creator_vault_id, arg6, arg7, arg8, arg9)
    }

    public fun create_tier(arg0: &ContentWrite, arg1: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::CurrencyRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money, arg5: 0x1::option::Option<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::calendar::CalendarPeriod>, arg6: u8, arg7: u8, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_writer(arg0, arg8);
        assert_valid_display_name(&arg2);
        assert_valid_renewal_policy(arg6);
        assert_valid_tier_status(arg7);
        0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::assert_currency(arg1, 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_currency(&arg4));
        assert_price_terms(&arg4, &arg5);
        let v0 = if (arg7 == 0) {
            0
        } else {
            1
        };
        let v1 = SubscriptionTier{
            id                   : 0x2::object::new(arg8),
            creator_vault_id     : arg0.creator_vault_id,
            name                 : arg2,
            cover                : arg3,
            price                : arg4,
            duration             : arg5,
            terms_version        : 1,
            renewal_price_policy : arg6,
            status               : arg7,
            deactivation_policy  : v0,
            archived             : false,
            passes_minted        : 0,
            subscribers          : 0x2::table::new<0x2::object::ID, FanState>(arg8),
        };
        let v2 = 0x2::object::id<SubscriptionTier>(&v1);
        0x2::transfer::share_object<SubscriptionTier>(v1);
        let v3 = TierCreated{
            tier_id          : v2,
            creator_vault_id : arg0.creator_vault_id,
            terms_version    : 1,
        };
        0x2::event::emit<TierCreated>(v3);
        v2
    }

    public fun deactivate_tier(arg0: &ContentWrite, arg1: &mut SubscriptionTier, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert_lifecycle_authority(arg0, arg3);
        assert_tier_policy(arg0, arg1);
        assert!(!arg1.archived, 13838158038123675669);
        assert_valid_deactivation_policy(arg2);
        arg1.status = 1;
        arg1.deactivation_policy = arg2;
        emit_tier_status(arg1);
    }

    public fun delete_tier(arg0: &ContentWrite, arg1: SubscriptionTier, arg2: &mut 0x2::tx_context::TxContext) {
        assert_lifecycle_authority(arg0, arg2);
        assert_tier_policy(arg0, &arg1);
        assert!(arg1.passes_minted == 0, 13838439641949536279);
        assert!(0x2::table::length<0x2::object::ID, FanState>(&arg1.subscribers) == 0, 13848854220387647585);
        let SubscriptionTier {
            id                   : v0,
            creator_vault_id     : v1,
            name                 : _,
            cover                : _,
            price                : _,
            duration             : _,
            terms_version        : _,
            renewal_price_policy : _,
            status               : _,
            deactivation_policy  : _,
            archived             : _,
            passes_minted        : _,
            subscribers          : v12,
        } = arg1;
        0x2::table::destroy_empty<0x2::object::ID, FanState>(v12);
        0x2::object::delete(v0);
        let v13 = TierDeleted{
            tier_id          : 0x2::object::id<SubscriptionTier>(&arg1),
            creator_vault_id : v1,
        };
        0x2::event::emit<TierDeleted>(v13);
    }

    public fun draft_content_status() : u8 {
        0
    }

    public fun draft_revision_status() : u8 {
        0
    }

    fun drop_empty_fan_state(arg0: &mut SubscriptionTier, arg1: 0x2::object::ID) {
        let v0 = 0x2::table::borrow<0x2::object::ID, FanState>(&arg0.subscribers, arg1);
        let v1 = if (v0.paid_through_ms == 0) {
            if (0x1::option::is_none<0x2::object::ID>(&v0.active_mandate)) {
                !v0.free_member
            } else {
                false
            }
        } else {
            false
        };
        if (v1) {
            0x2::table::remove<0x2::object::ID, FanState>(&mut arg0.subscribers, arg1);
        };
    }

    fun emit_intent_settled<T0>(arg0: &PurchaseIntent, arg1: u64, arg2: u64, arg3: u64, arg4: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::RateSnapshot, arg5: u64, arg6: 0x2::object::ID) {
        let v0 = PaymentSettled{
            payer_vault_id       : arg0.fan_vault_id,
            creator_vault_id     : arg0.creator_vault_id,
            product_kind         : arg0.product_kind,
            subject_id           : arg0.subject_id,
            consent_id           : 0x2::object::id<PurchaseIntent>(arg0),
            terms_version        : arg0.terms_version,
            period_index         : 0,
            nominal_currency     : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_currency(&arg0.exact_charge),
            nominal_amount       : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_amount(&arg0.exact_charge),
            coin_type            : 0x1::type_name::with_defining_ids<T0>(),
            raw_total            : arg1,
            raw_creator_proceeds : arg3,
            raw_fee              : arg2,
            rate                 : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::snapshot_rate(arg4),
            rate_decimals        : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::snapshot_rate_decimals(arg4),
            rate_updated_at_ms   : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::snapshot_updated_at_ms(arg4),
            rate_source          : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::snapshot_source(arg4),
            settled_at_ms        : arg5,
            result_id            : arg6,
        };
        0x2::event::emit<PaymentSettled>(v0);
        let v1 = IntentConsumed{
            intent_id    : 0x2::object::id<PurchaseIntent>(arg0),
            product_kind : arg0.product_kind,
            subject_id   : arg0.subject_id,
            pass_id      : arg6,
        };
        0x2::event::emit<IntentConsumed>(v1);
    }

    fun emit_tier_status(arg0: &SubscriptionTier) {
        let v0 = TierStatusChanged{
            tier_id             : 0x2::object::id<SubscriptionTier>(arg0),
            status              : arg0.status,
            deactivation_policy : arg0.deactivation_policy,
            archived            : arg0.archived,
        };
        0x2::event::emit<TierStatusChanged>(v0);
    }

    fun end_free_membership(arg0: &mut SubscriptionTier, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, FanState>(&arg0.subscribers, arg1), 13852237834279714937);
        let v0 = 0x2::object::id<SubscriptionTier>(arg0);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, FanState>(&mut arg0.subscribers, arg1);
        assert!(v1.free_member, 13852237847164616825);
        v1.free_member = false;
        v1.free_since_ms = 0;
        drop_empty_fan_state(arg0, arg1);
        let v2 = FreeSubscriptionEnded{
            tier_id      : v0,
            fan_vault_id : arg1,
            by           : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<FreeSubscriptionEnded>(v2);
    }

    public fun expired_intent_status() : u8 {
        3
    }

    public fun expired_mandate_status() : u8 {
        3
    }

    public fun fan_read_address(arg0: 0x2::object::ID, arg1: 0x2::object::ID) : address {
        let v0 = FanReadKey{fan_vault_id: arg1};
        0x2::derived_object::derive_address<FanReadKey>(arg0, v0)
    }

    public fun fan_read_reader(arg0: &FanRead) : address {
        arg0.reader
    }

    public fun fan_read_vault_id(arg0: &FanRead) : 0x2::object::ID {
        arg0.fan_vault_id
    }

    public fun fee_policy_fee_bps(arg0: &FeePolicy) : u64 {
        arg0.fee_bps
    }

    public fun fee_policy_mode(arg0: &FeePolicy) : u8 {
        arg0.mode
    }

    public fun fee_policy_treasury(arg0: &FeePolicy) : address {
        arg0.treasury
    }

    public fun has_content_pass(arg0: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: 0x2::object::ID) : bool {
        let v0 = ContentKey{content_id: arg1};
        0x2::dynamic_object_field::exists_with_type<ContentKey, ContentPass>(0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::uid(arg0), v0)
    }

    public fun has_creator_policies(arg0: &PolicyRegistry, arg1: 0x2::object::ID) : bool {
        let v0 = WriteKey{creator_vault_id: arg1};
        0x2::derived_object::exists<WriteKey>(&arg0.id, v0)
    }

    public fun has_fan_reader(arg0: &PolicyRegistry, arg1: 0x2::object::ID) : bool {
        let v0 = FanReadKey{fan_vault_id: arg1};
        0x2::derived_object::exists<FanReadKey>(&arg0.id, v0)
    }

    public fun has_free_access(arg0: &SubscriptionTier, arg1: 0x2::object::ID) : bool {
        !arg0.archived && tier_free_member(arg0, arg1)
    }

    fun has_method(arg0: u8, arg1: u8) : bool {
        arg0 & arg1 != 0
    }

    public fun has_subscription_pass(arg0: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: 0x2::object::ID) : bool {
        let v0 = PassKey{pass_id: arg1};
        0x2::dynamic_object_field::exists_with_type<PassKey, SubscriptionPass>(0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::uid(arg0), v0)
    }

    public fun inactive_tier_status() : u8 {
        1
    }

    public fun included_fee_mode() : u8 {
        0
    }

    fun init(arg0: CONTENT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = new_fee_policy(0, v0, 0, arg1);
        0x2::transfer::share_object<FeePolicy>(v1);
        0x2::transfer::public_transfer<FeePolicyAdminCap>(v2, 0x2::tx_context::sender(arg1));
        let v3 = PolicyRegistry{id: 0x2::object::new(arg1)};
        let v4 = PolicyRegistryCreated{registry_id: 0x2::object::id<PolicyRegistry>(&v3)};
        0x2::event::emit<PolicyRegistryCreated>(v4);
        0x2::transfer::share_object<PolicyRegistry>(v3);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<CONTENT>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun initialize_creator(arg0: &mut PolicyRegistry, arg1: &mut 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::VaultRegistry, arg2: address, arg3: address, arg4: 0x1::option::Option<address>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID) {
        assert_non_zero(arg3);
        assert_non_zero(arg5);
        if (0x1::option::is_some<address>(&arg4)) {
            assert_non_zero(*0x1::option::borrow<address>(&arg4));
        };
        let v0 = 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::create_vault<ContentManager>(arg1, 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::creator_role(), arg2, arg6);
        let v1 = WriteKey{creator_vault_id: v0};
        let v2 = ContentWrite{
            id               : 0x2::derived_object::claim<WriteKey>(&mut arg0.id, v1),
            creator_vault_id : v0,
            user_writer      : arg3,
            platform_writer  : arg4,
        };
        let v3 = ReadKey{creator_vault_id: v0};
        let v4 = ContentRead{
            id               : 0x2::derived_object::claim<ReadKey>(&mut arg0.id, v3),
            creator_vault_id : v0,
            reader           : arg5,
        };
        let v5 = 0x2::object::id<ContentWrite>(&v2);
        let v6 = 0x2::object::id<ContentRead>(&v4);
        let v7 = CreatorInitialized{
            creator_vault_id : v0,
            content_write_id : v5,
            content_read_id  : v6,
            financial_owner  : arg2,
            user_writer      : arg3,
            platform_writer  : arg4,
            reader           : arg5,
        };
        0x2::event::emit<CreatorInitialized>(v7);
        0x2::transfer::share_object<ContentWrite>(v2);
        0x2::transfer::share_object<ContentRead>(v4);
        (v0, v5, v6)
    }

    public fun initialize_fan(arg0: &mut PolicyRegistry, arg1: &mut 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::VaultRegistry, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID) {
        assert_non_zero(arg3);
        let v0 = 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::create_vault<ContentManager>(arg1, 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::fan_role(), arg2, arg4);
        let v1 = new_fan_read(arg0, v0, arg3);
        let v2 = 0x2::object::id<FanRead>(&v1);
        let v3 = FanInitialized{
            fan_vault_id    : v0,
            fan_read_id     : v2,
            financial_owner : arg2,
            reader          : arg3,
        };
        0x2::event::emit<FanInitialized>(v3);
        0x2::transfer::share_object<FanRead>(v1);
        (v0, v2)
    }

    public fun intent_coin_type(arg0: &PurchaseIntent) : 0x1::type_name::TypeName {
        arg0.coin_type
    }

    public fun intent_creator_vault_id(arg0: &PurchaseIntent) : 0x2::object::ID {
        arg0.creator_vault_id
    }

    public fun intent_exact_charge(arg0: &PurchaseIntent) : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money {
        arg0.exact_charge
    }

    public fun intent_expires_at_ms(arg0: &PurchaseIntent) : u64 {
        arg0.expires_at_ms
    }

    public fun intent_fan_vault_id(arg0: &PurchaseIntent) : 0x2::object::ID {
        arg0.fan_vault_id
    }

    public fun intent_max_raw(arg0: &PurchaseIntent) : u64 {
        arg0.max_raw
    }

    public fun intent_product_kind(arg0: &PurchaseIntent) : u8 {
        arg0.product_kind
    }

    public fun intent_spender_cap_id(arg0: &PurchaseIntent) : 0x2::object::ID {
        arg0.spender_cap_id
    }

    public fun intent_status(arg0: &PurchaseIntent) : u8 {
        arg0.status
    }

    public fun intent_subject_id(arg0: &PurchaseIntent) : 0x2::object::ID {
        arg0.subject_id
    }

    public fun intent_terms_version(arg0: &PurchaseIntent) : u64 {
        arg0.terms_version
    }

    fun is_free_price(arg0: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money) : bool {
        0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_amount(arg0) == 0
    }

    fun is_intent_terminal(arg0: &PurchaseIntent) : bool {
        arg0.status == 2 || arg0.status == 3
    }

    fun is_terminal(arg0: &SubscriptionMandate) : bool {
        arg0.status == 2 || arg0.status == 3
    }

    public fun is_writer(arg0: &ContentWrite, arg1: address) : bool {
        arg1 == arg0.user_writer || 0x1::option::contains<address>(&arg0.platform_writer, &arg1)
    }

    public fun keep_existing_price_policy() : u8 {
        0
    }

    public fun mandate_creator_vault_id(arg0: &SubscriptionMandate) : 0x2::object::ID {
        arg0.creator_vault_id
    }

    public fun mandate_expires_at_ms(arg0: &SubscriptionMandate) : 0x1::option::Option<u64> {
        arg0.expires_at_ms
    }

    public fun mandate_fan_vault_id(arg0: &SubscriptionMandate) : 0x2::object::ID {
        arg0.fan_vault_id
    }

    public fun mandate_locked_base_price(arg0: &SubscriptionMandate) : 0x1::option::Option<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money> {
        arg0.locked_base_price
    }

    public fun mandate_max_raw_per_period(arg0: &SubscriptionMandate) : u64 {
        arg0.max_raw_per_period
    }

    public fun mandate_next_period_index(arg0: &SubscriptionMandate) : u64 {
        arg0.next_period_index
    }

    public fun mandate_paused_until_ms(arg0: &SubscriptionMandate) : u64 {
        arg0.paused_until_ms
    }

    public fun mandate_schedule_anchor_ms(arg0: &SubscriptionMandate) : 0x1::option::Option<u64> {
        arg0.schedule_anchor_ms
    }

    public fun mandate_spender_cap_id(arg0: &SubscriptionMandate) : 0x2::object::ID {
        arg0.spender_cap_id
    }

    public fun mandate_status(arg0: &SubscriptionMandate) : u8 {
        arg0.status
    }

    public fun mandate_tier_id(arg0: &SubscriptionMandate) : 0x2::object::ID {
        arg0.tier_id
    }

    fun mark_published(arg0: &mut Content, arg1: &mut ContentRevision) {
        assert!(arg1.content_id == 0x2::object::id<Content>(arg0), 13838728620234244121);
        assert!(arg1.status == 0, 13837602724621844497);
        let v0 = 0x2::object::id<ContentRevision>(arg1);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.latest_revision, &v0), 13842950753476804663);
        assert!(arg1.access_kind == arg0.access_kind, 13840417482980196389);
        if (has_method(arg0.access_methods, 1)) {
            assert!(!0x1::vector::is_empty<0x2::object::ID>(&arg0.allowed_tier_ids), 13839573066639605791);
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
            content_id       : 0x2::object::id<Content>(arg0),
            creator_vault_id : arg0.creator_vault_id,
            status           : 1,
        };
        0x2::event::emit<ContentStatusChanged>(v2);
    }

    public fun max_fee_bps() : u64 {
        3000
    }

    fun new_content(arg0: &ContentWrite, arg1: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::CurrencyRegistry, arg2: u8, arg3: u8, arg4: u8, arg5: 0x1::option::Option<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>, arg6: &mut 0x2::tx_context::TxContext) : Content {
        let v0 = if (arg2 == 1) {
            true
        } else if (arg2 == 2) {
            true
        } else {
            arg2 == 3
        };
        assert!(v0, 13840135428182769699);
        let (v1, v2) = normalized_content_policy(arg1, arg3, arg4, arg5);
        let v3 = Content{
            id                 : 0x2::object::new(arg6),
            creator_vault_id   : arg0.creator_vault_id,
            content_kind       : arg2,
            access_kind        : arg3,
            access_methods     : v1,
            allowed_tier_ids   : 0x1::vector::empty<0x2::object::ID>(),
            one_off_price      : v2,
            terms_version      : 1,
            revision_count     : 0,
            status             : 0,
            latest_revision    : 0x1::option::none<0x2::object::ID>(),
            published_revision : 0x1::option::none<0x2::object::ID>(),
        };
        let v4 = ContentCreated{
            content_id       : 0x2::object::id<Content>(&v3),
            creator_vault_id : arg0.creator_vault_id,
            content_kind     : arg2,
            access_kind      : arg3,
            access_methods   : v1,
            terms_version    : 1,
        };
        0x2::event::emit<ContentCreated>(v4);
        v3
    }

    fun new_fan_read(arg0: &mut PolicyRegistry, arg1: 0x2::object::ID, arg2: address) : FanRead {
        let v0 = FanReadKey{fan_vault_id: arg1};
        FanRead{
            id           : 0x2::derived_object::claim<FanReadKey>(&mut arg0.id, v0),
            fan_vault_id : arg1,
            reader       : arg2,
        }
    }

    fun new_fan_state() : FanState {
        FanState{
            active_mandate     : 0x1::option::none<0x2::object::ID>(),
            paid_through_ms    : 0,
            last_paid          : 0x1::option::none<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>(),
            last_terms_version : 0,
            free_member        : false,
            free_since_ms      : 0,
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

    fun new_intent<T0>(arg0: &mut 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: &FanRead, arg2: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::OwnerCap, arg3: &FeePolicy, arg4: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::CurrencyRegistry, arg5: u8, arg6: 0x2::object::ID, arg7: u64, arg8: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money, arg9: 0x2::object::ID, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg0);
        assert_owner_cap(arg2, v0);
        assert_fan_vault(arg0, arg1);
        assert!(arg11 > 0x2::clock::timestamp_ms(arg12), 13851111015249346673);
        let v1 = quote(arg3, arg8);
        let v2 = v1.total;
        let (v3, _) = 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::to_coin_units<T0>(arg4, v2, arg12);
        assert!(v3 <= arg10, 13847451853435306071);
        let v5 = 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::mint_spender_cap(arg0, arg2, arg13);
        let v6 = 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap>(&v5);
        0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::set_allowance<T0>(arg0, arg2, v6, arg10, arg11, 0x1::option::none<u64>(), arg12, arg13);
        let v7 = PurchaseIntent{
            id               : 0x2::object::new(arg13),
            fan_vault_id     : v0,
            spender_cap_id   : v6,
            product_kind     : arg5,
            subject_id       : arg6,
            terms_version    : arg7,
            exact_charge     : v2,
            creator_vault_id : arg9,
            fee_policy_id    : 0x2::object::id<FeePolicy>(arg3),
            currency         : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_currency(&arg8),
            coin_type        : 0x1::type_name::with_defining_ids<T0>(),
            expires_at_ms    : arg11,
            status           : 0,
            max_raw          : arg10,
        };
        let v8 = 0x2::object::id<PurchaseIntent>(&v7);
        0x2::transfer::public_transfer<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap>(v5, 0x2::object::id_to_address(&v8));
        let v9 = IntentCreated{
            intent_id        : v8,
            fan_vault_id     : v0,
            product_kind     : arg5,
            subject_id       : arg6,
            creator_vault_id : arg9,
            spender_cap_id   : v6,
            terms_version    : arg7,
            exact_charge     : v2,
            coin_type        : 0x1::type_name::with_defining_ids<T0>(),
            max_raw          : arg10,
            expires_at_ms    : arg11,
        };
        0x2::event::emit<IntentCreated>(v9);
        0x2::transfer::share_object<PurchaseIntent>(v7);
        v8
    }

    public fun no_deactivation_policy() : u8 {
        0
    }

    fun normalized_content_policy(arg0: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::CurrencyRegistry, arg1: u8, arg2: u8, arg3: 0x1::option::Option<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>) : (u8, 0x1::option::Option<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>) {
        assert!(arg1 == 0 || arg1 == 1, 13840416770015625253);
        if (arg1 == 0) {
            assert!(arg2 == 0 && 0x1::option::is_none<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>(&arg3), 13840698253582401575);
            (0, 0x1::option::none<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>())
        } else {
            assert!(arg2 != 0, 13840979741444145193);
            assert!(arg2 & 3 == arg2, 13840698270762270759);
            let v2 = if (has_method(arg2, 2)) {
                assert!(0x1::option::is_some<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>(&arg3), 13837039104653262861);
                let v3 = 0x1::option::borrow<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>(&arg3);
                assert!(0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_amount(v3) > 0, 13837039113243197453);
                0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::assert_currency(arg0, 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_currency(v3));
                arg3
            } else {
                assert!(0x1::option::is_none<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>(&arg3), 13837039130423066637);
                0x1::option::none<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>()
            };
            (arg2, v2)
        }
    }

    public fun one_off_method() : u8 {
        2
    }

    public fun page_kind() : u8 {
        3
    }

    public fun pass_fan_vault_id(arg0: &SubscriptionPass) : 0x2::object::ID {
        arg0.fan_vault_id
    }

    public fun pass_mandate_id(arg0: &SubscriptionPass) : 0x1::option::Option<0x2::object::ID> {
        arg0.mandate_id
    }

    public fun pass_nominal_paid(arg0: &SubscriptionPass) : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money {
        arg0.nominal_paid
    }

    public fun pass_payment_coin_type(arg0: &SubscriptionPass) : 0x1::type_name::TypeName {
        arg0.payment_coin_type
    }

    public fun pass_rate(arg0: &SubscriptionPass) : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::RateSnapshot {
        arg0.rate
    }

    public fun pass_raw_paid(arg0: &SubscriptionPass) : u64 {
        arg0.raw_paid
    }

    public fun pass_terms_version(arg0: &SubscriptionPass) : u64 {
        arg0.tier_terms_version
    }

    public fun pass_tier_id(arg0: &SubscriptionPass) : 0x2::object::ID {
        arg0.tier_id
    }

    public fun pass_valid_from_ms(arg0: &SubscriptionPass) : u64 {
        arg0.valid_from_ms
    }

    public fun pass_valid_until_ms(arg0: &SubscriptionPass) : u64 {
        arg0.valid_until_ms
    }

    public fun pause_for_new_policy() : u8 {
        1
    }

    public fun pause_mandate(arg0: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::OwnerCap, arg2: &mut SubscriptionMandate, arg3: u64, arg4: &0x2::clock::Clock) {
        assert_owner_cap(arg1, 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg0));
        assert!(arg2.fan_vault_id == 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg0), 13845759769463881803);
        assert!(arg2.status == 1, 13855048447994626189);
        assert!(arg3 > 0x2::clock::timestamp_ms(arg4), 13855329927266435215);
        arg2.paused_until_ms = arg3;
        let v0 = MandatePaused{
            mandate_id      : 0x2::object::id<SubscriptionMandate>(arg2),
            fan_vault_id    : arg2.fan_vault_id,
            tier_id         : arg2.tier_id,
            paused_until_ms : arg3,
        };
        0x2::event::emit<MandatePaused>(v0);
    }

    public fun pending_mandate_status() : u8 {
        0
    }

    public fun post_kind() : u8 {
        1
    }

    public fun public_access() : u8 {
        0
    }

    public fun publish_content_revision(arg0: &ContentWrite, arg1: &mut Content, arg2: &mut ContentRevision, arg3: &mut 0x2::tx_context::TxContext) {
        assert_writer(arg0, arg3);
        assert_content_policy(arg0, arg1);
        assert_content_mutable(arg1);
        mark_published(arg1, arg2);
    }

    public fun published_content_status() : u8 {
        1
    }

    public fun published_revision_status() : u8 {
        1
    }

    public fun purchase_content_access<T0>(arg0: &mut 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: &FeePolicy, arg2: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::CurrencyRegistry, arg3: &mut PurchaseIntent, arg4: &Content, arg5: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg6: 0x2::transfer::Receiving<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::id<Content>(arg4);
        assert_intent_settles<T0>(arg3, arg0, arg1, arg5, 1, v0, arg4.creator_vault_id, arg7);
        assert_content_for_sale(arg4);
        let v1 = *0x1::option::borrow<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>(&arg4.one_off_price);
        let v2 = quote(arg1, v1);
        assert_consented_terms(arg3, arg4.terms_version, v2.total);
        assert!(!has_content_pass(arg0, v0), 13850545647229075565);
        let v3 = 0x2::clock::timestamp_ms(arg7);
        let (v4, v5, v6, v7) = settle_intent<T0>(arg0, arg1, arg2, arg3, arg5, arg6, v1, arg7, arg8);
        let v8 = v7;
        let v9 = ContentPass{
            id                : 0x2::object::new(arg8),
            fan_vault_id      : arg3.fan_vault_id,
            content_id        : v0,
            purchased_at_ms   : v3,
            terms_version     : arg3.terms_version,
            nominal_paid      : arg3.exact_charge,
            payment_coin_type : 0x1::type_name::with_defining_ids<T0>(),
            raw_paid          : v4,
            rate              : v8,
            intent_id         : 0x2::object::id<PurchaseIntent>(arg3),
        };
        let v10 = 0x2::object::id<ContentPass>(&v9);
        let v11 = ContentManager{dummy_field: false};
        let v12 = ContentKey{content_id: v0};
        0x2::dynamic_object_field::add<ContentKey, ContentPass>(0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::uid_mut<ContentManager>(v11, arg0), v12, v9);
        emit_intent_settled<T0>(arg3, v4, v5, v6, &v8, v3, v10);
        v10
    }

    public fun purchase_free_subscription(arg0: &FanRead, arg1: &mut SubscriptionTier, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_fan_reader(arg0, arg3);
        assert!(is_free_price(&arg1.price), 13851671946568401013);
        assert!(arg1.status == 0 && !arg1.archived, 13844916551419166789);
        let v0 = arg0.fan_vault_id;
        let v1 = 0x2::clock::timestamp_ms(arg2);
        if (!0x2::table::contains<0x2::object::ID, FanState>(&arg1.subscribers, v0)) {
            0x2::table::add<0x2::object::ID, FanState>(&mut arg1.subscribers, v0, new_fan_state());
        };
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, FanState>(&mut arg1.subscribers, v0);
        assert!(!v2.free_member, 13851953451610013815);
        v2.free_member = true;
        v2.free_since_ms = v1;
        let v3 = FreeSubscriptionStarted{
            tier_id      : 0x2::object::id<SubscriptionTier>(arg1),
            fan_vault_id : v0,
            since_ms     : v1,
        };
        0x2::event::emit<FreeSubscriptionStarted>(v3);
    }

    public fun purchase_subscription_from_intent<T0>(arg0: &mut 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: &FeePolicy, arg2: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::CurrencyRegistry, arg3: &mut PurchaseIntent, arg4: &mut SubscriptionTier, arg5: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg6: 0x2::transfer::Receiving<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::id<SubscriptionTier>(arg4);
        assert_intent_settles<T0>(arg3, arg0, arg1, arg5, 0, v0, arg4.creator_vault_id, arg7);
        assert_paid_tier(arg4);
        let v1 = arg4.price;
        let v2 = quote(arg1, v1);
        assert_consented_terms(arg3, arg4.terms_version, v2.total);
        let v3 = arg3.fan_vault_id;
        if (!0x2::table::contains<0x2::object::ID, FanState>(&arg4.subscribers, v3)) {
            0x2::table::add<0x2::object::ID, FanState>(&mut arg4.subscribers, v3, new_fan_state());
        };
        let v4 = 0x2::clock::timestamp_ms(arg7);
        assert!(v4 >= 0x2::table::borrow<0x2::object::ID, FanState>(&arg4.subscribers, v3).paid_through_ms, 13846886678688563283);
        let v5 = 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::calendar::derive_window(v4, v4, 0x1::option::borrow<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::calendar::CalendarPeriod>(&arg4.duration));
        let v6 = 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::calendar::window_end_ms(&v5);
        let (v7, v8, v9, v10) = settle_intent<T0>(arg0, arg1, arg2, arg3, arg5, arg6, v1, arg7, arg8);
        let v11 = v10;
        let v12 = SubscriptionPass{
            id                 : 0x2::object::new(arg8),
            fan_vault_id       : v3,
            tier_id            : v0,
            valid_from_ms      : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::calendar::window_start_ms(&v5),
            valid_until_ms     : v6,
            nominal_paid       : arg3.exact_charge,
            payment_coin_type  : 0x1::type_name::with_defining_ids<T0>(),
            raw_paid           : v7,
            rate               : v11,
            tier_terms_version : arg3.terms_version,
            mandate_id         : 0x1::option::none<0x2::object::ID>(),
        };
        let v13 = 0x2::object::id<SubscriptionPass>(&v12);
        let v14 = ContentManager{dummy_field: false};
        let v15 = PassKey{pass_id: v13};
        0x2::dynamic_object_field::add<PassKey, SubscriptionPass>(0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::uid_mut<ContentManager>(v14, arg0), v15, v12);
        arg4.passes_minted = checked_add(arg4.passes_minted, 1);
        let v16 = 0x2::table::borrow_mut<0x2::object::ID, FanState>(&mut arg4.subscribers, v3);
        v16.paid_through_ms = v6;
        v16.last_paid = 0x1::option::some<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>(v1);
        v16.last_terms_version = arg3.terms_version;
        emit_intent_settled<T0>(arg3, v7, v8, v9, &v11, v4, v13);
        v13
    }

    public fun quote(arg0: &FeePolicy, arg1: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money) : SettlementQuote {
        let v0 = 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_amount(&arg1);
        let v1 = 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_currency(&arg1);
        let v2 = (v0 as u128) * (arg0.fee_bps as u128) / (10000 as u128);
        assert!(v2 <= 18446744073709551615, 13844635325550428227);
        let v3 = (v2 as u64);
        if (arg0.mode == 0) {
            SettlementQuote{total: arg1, creator_proceeds: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_from_parts(v0 - v3, v1), fee: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_from_parts(v3, v1)}
        } else {
            SettlementQuote{total: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_from_parts(checked_add(v0, v3), v1), creator_proceeds: arg1, fee: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_from_parts(v3, v1)}
        }
    }

    public fun quote_creator_proceeds(arg0: &SettlementQuote) : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money {
        arg0.creator_proceeds
    }

    public fun quote_fee(arg0: &SettlementQuote) : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money {
        arg0.fee
    }

    public fun quote_total(arg0: &SettlementQuote) : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money {
        arg0.total
    }

    public fun reactivate_tier(arg0: &ContentWrite, arg1: &mut SubscriptionTier, arg2: &mut 0x2::tx_context::TxContext) {
        assert_lifecycle_authority(arg0, arg2);
        assert_tier_policy(arg0, arg1);
        assert!(!arg1.archived, 13838158081073348629);
        arg1.status = 0;
        arg1.deactivation_policy = 0;
        emit_tier_status(arg1);
    }

    public fun read_creator_vault_id(arg0: &ContentRead) : 0x2::object::ID {
        arg0.creator_vault_id
    }

    public fun read_reader(arg0: &ContentRead) : address {
        arg0.reader
    }

    public fun reconcile_mandate<T0>(arg0: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: &mut SubscriptionMandate, arg2: &mut SubscriptionTier, arg3: &0x2::clock::Clock) {
        assert!(arg1.fan_vault_id == 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg0) && arg1.tier_id == 0x2::object::id<SubscriptionTier>(arg2), 13845759915492769867);
        assert!(arg1.coin_type == 0x1::type_name::with_defining_ids<T0>(), 13847730244625629273);
        if (is_terminal(arg1)) {
            return
        };
        let v0 = consent_expired(arg1, arg3);
        assert!(v0 || !0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::contains<T0>(arg0, arg1.spender_cap_id), 13848293211759181917);
        let v1 = if (v0) {
            3
        } else {
            2
        };
        arg1.status = v1;
        release_active_mandate(arg2, arg1);
        let v2 = MandateReconciled{
            mandate_id : 0x2::object::id<SubscriptionMandate>(arg1),
            status     : arg1.status,
        };
        0x2::event::emit<MandateReconciled>(v2);
    }

    fun release_active_mandate(arg0: &mut SubscriptionTier, arg1: &SubscriptionMandate) {
        if (!0x2::table::contains<0x2::object::ID, FanState>(&arg0.subscribers, arg1.fan_vault_id)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, FanState>(&mut arg0.subscribers, arg1.fan_vault_id);
        let v1 = &v0.active_mandate;
        let v2 = 0x2::object::id<SubscriptionMandate>(arg1);
        if (0x1::option::contains<0x2::object::ID>(v1, &v2)) {
            v0.active_mandate = 0x1::option::none<0x2::object::ID>();
        };
        drop_empty_fan_state(arg0, arg1.fan_vault_id);
    }

    public fun remove_content_tier(arg0: &ContentWrite, arg1: &mut Content, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert_writer(arg0, arg3);
        assert_content_policy(arg0, arg1);
        assert_content_mutable(arg1);
        let v0 = &mut arg1.allowed_tier_ids;
        assert!(vector_remove_id(v0, &arg2), 13839565906929123359);
        let v1 = ContentTierRemoved{
            content_id       : 0x2::object::id<Content>(arg1),
            creator_vault_id : arg1.creator_vault_id,
            tier_id          : arg2,
        };
        0x2::event::emit<ContentTierRemoved>(v1);
    }

    public fun renew_subscription<T0>(arg0: &mut 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: &FeePolicy, arg2: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::CurrencyRegistry, arg3: &mut SubscriptionMandate, arg4: &mut SubscriptionTier, arg5: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg6: 0x2::transfer::Receiving<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg3.status == 1, 13846322539028938831);
        assert!(arg3.next_period_index == arg7, 13846604018300747857);
        assert_tier_renewable(arg4);
        settle_period<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, true, arg8, arg9)
    }

    public fun resume_mandate(arg0: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::OwnerCap, arg2: &mut SubscriptionMandate) {
        assert_owner_cap(arg1, 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg0));
        assert!(arg2.fan_vault_id == 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg0), 13845759838183358539);
        if (arg2.paused_until_ms == 0) {
            return
        };
        arg2.paused_until_ms = 0;
        let v0 = MandateResumed{
            mandate_id   : 0x2::object::id<SubscriptionMandate>(arg2),
            fan_vault_id : arg2.fan_vault_id,
            tier_id      : arg2.tier_id,
        };
        0x2::event::emit<MandateResumed>(v0);
    }

    public fun revision_asset_blob_object_id(arg0: &ContentRevision, arg1: u64) : 0x2::object::ID {
        0x1::vector::borrow<ContentAsset>(&arg0.assets, arg1).blob_object_id
    }

    public fun revision_asset_count(arg0: &ContentRevision) : u64 {
        0x1::vector::length<ContentAsset>(&arg0.assets)
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

    public fun revision_content_id(arg0: &ContentRevision) : 0x2::object::ID {
        arg0.content_id
    }

    fun revision_has_seal_id(arg0: &ContentRevision, arg1: &vector<u8>) : bool {
        arg0.seal_id == *arg1 || revision_contains_seal_id(arg0, arg1)
    }

    public fun revision_number(arg0: &ContentRevision) : u64 {
        arg0.revision_number
    }

    public fun revision_status(arg0: &ContentRevision) : u8 {
        arg0.status
    }

    public fun revoke_platform_writer(arg0: &mut ContentWrite, arg1: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::OwnerCap) {
        assert_owner_cap(arg1, arg0.creator_vault_id);
        arg0.platform_writer = 0x1::option::none<address>();
        let v0 = PlatformWriterSet{
            creator_vault_id : arg0.creator_vault_id,
            writer           : 0x1::option::none<address>(),
        };
        0x2::event::emit<PlatformWriterSet>(v0);
    }

    entry fun seal_approve_content_access(arg0: vector<u8>, arg1: &Content, arg2: &ContentRevision, arg3: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg4: &FanRead, arg5: &0x2::tx_context::TxContext) {
        assert_fan_session(arg4, arg3, arg5);
        assert_published_asset(arg1, arg2, &arg0, 2);
        let v0 = 0x2::object::id<Content>(arg1);
        assert!(has_content_pass(arg3, v0), 13853642851226878083);
        let v1 = borrow_content_pass(arg3, v0);
        assert!(v1.fan_vault_id == 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg3) && v1.content_id == v0, 13853924334793654405);
    }

    entry fun seal_approve_creator(arg0: vector<u8>, arg1: &Content, arg2: &ContentRevision, arg3: &ContentRead, arg4: &0x2::tx_context::TxContext) {
        assert!(arg3.creator_vault_id == arg1.creator_vault_id, 13844072508740730943);
        assert!(0x2::tx_context::sender(arg4) == arg3.reader, 13843791038058856509);
        assert_creator_asset(arg1, arg2, &arg0);
    }

    entry fun seal_approve_free(arg0: vector<u8>, arg1: &Content, arg2: &ContentRevision, arg3: &FanRead, arg4: &SubscriptionTier, arg5: &0x2::tx_context::TxContext) {
        assert_fan_reader(arg3, arg5);
        assert_published_asset(arg1, arg2, &arg0, 1);
        assert!(content_allows_tier(arg1, 0x2::object::id<SubscriptionTier>(arg4)), 13839569183989170207);
        assert!(has_free_access(arg4, arg3.fan_vault_id), 13854487362056749193);
    }

    entry fun seal_approve_subscription(arg0: vector<u8>, arg1: &Content, arg2: &ContentRevision, arg3: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg4: &FanRead, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_fan_session(arg4, arg3, arg7);
        assert_published_asset(arg1, arg2, &arg0, 1);
        assert!(has_subscription_pass(arg3, arg5), 13853642761032564867);
        let v0 = borrow_subscription_pass(arg3, arg5);
        assert!(v0.fan_vault_id == 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg3), 13853924244599341189);
        assert!(content_allows_tier(arg1, v0.tier_id), 13839569025075380255);
        assert!(subscription_pass_active(v0, arg6), 13854205728166117511);
    }

    public fun seal_gated_access() : u8 {
        1
    }

    public fun set_content_reader(arg0: &mut ContentRead, arg1: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::OwnerCap, arg2: address) {
        assert_owner_cap(arg1, arg0.creator_vault_id);
        assert_non_zero(arg2);
        arg0.reader = arg2;
        let v0 = ContentReaderSet{
            creator_vault_id : arg0.creator_vault_id,
            previous         : arg0.reader,
            reader           : arg2,
        };
        0x2::event::emit<ContentReaderSet>(v0);
    }

    public fun set_content_status(arg0: &ContentWrite, arg1: &mut Content, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert_lifecycle_authority(arg0, arg3);
        assert_content_policy(arg0, arg1);
        assert_content_mutable(arg1);
        assert_valid_content_status(arg2);
        assert!(arg2 != arg1.status, 13837595659400642577);
        if (arg2 == 1) {
            assert!(0x1::option::is_some<0x2::object::ID>(&arg1.published_revision), 13852513837468221563);
        };
        arg1.status = arg2;
        let v0 = ContentStatusChanged{
            content_id       : 0x2::object::id<Content>(arg1),
            creator_vault_id : arg1.creator_vault_id,
            status           : arg2,
        };
        0x2::event::emit<ContentStatusChanged>(v0);
    }

    public fun set_fan_vault_reader(arg0: &mut FanRead, arg1: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::OwnerCap, arg2: address) {
        assert_owner_cap(arg1, arg0.fan_vault_id);
        assert_non_zero(arg2);
        arg0.reader = arg2;
        let v0 = FanReaderSet{
            fan_vault_id : arg0.fan_vault_id,
            previous     : arg0.reader,
            reader       : arg2,
        };
        0x2::event::emit<FanReaderSet>(v0);
    }

    public fun set_platform_writer(arg0: &mut ContentWrite, arg1: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::OwnerCap, arg2: address) {
        assert_owner_cap(arg1, arg0.creator_vault_id);
        assert_non_zero(arg2);
        arg0.platform_writer = 0x1::option::some<address>(arg2);
        let v0 = PlatformWriterSet{
            creator_vault_id : arg0.creator_vault_id,
            writer           : 0x1::option::some<address>(arg2),
        };
        0x2::event::emit<PlatformWriterSet>(v0);
    }

    public fun set_user_writer(arg0: &mut ContentWrite, arg1: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::OwnerCap, arg2: address) {
        assert_owner_cap(arg1, arg0.creator_vault_id);
        assert_non_zero(arg2);
        arg0.user_writer = arg2;
        let v0 = UserWriterSet{
            creator_vault_id : arg0.creator_vault_id,
            previous         : arg0.user_writer,
            writer           : arg2,
        };
        0x2::event::emit<UserWriterSet>(v0);
    }

    fun settle_intent<T0>(arg0: &mut 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: &FeePolicy, arg2: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::CurrencyRegistry, arg3: &mut PurchaseIntent, arg4: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg5: 0x2::transfer::Receiving<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap>, arg6: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::RateSnapshot) {
        let v0 = 0x2::transfer::public_receive<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap>(&mut arg3.id, arg5);
        assert!(0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap>(&v0) == arg3.spender_cap_id, 13847170756415586389);
        let v1 = quote(arg1, arg6);
        let (v2, v3) = 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::to_coin_units<T0>(arg2, v1.total, arg7);
        let (v4, _) = 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::to_coin_units<T0>(arg2, v1.fee, arg7);
        assert!(v2 <= arg3.max_raw, 13847452248572297303);
        let v6 = v2 - v4;
        let v7 = 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::spend<T0>(arg0, &v0, v2, arg7, arg8);
        if (v4 > 0) {
            0x2::balance::send_funds<T0>(0x2::balance::split<T0>(&mut v7, v4), arg1.treasury);
        };
        if (v6 > 0) {
            0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::deposit_balance<T0>(arg4, v7, arg8);
        } else {
            0x2::balance::destroy_zero<T0>(v7);
        };
        0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::renounce(arg0, v0, arg8);
        arg3.status = 1;
        (v2, v4, v6, v3)
    }

    fun settle_period<T0>(arg0: &mut 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: &FeePolicy, arg2: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::CurrencyRegistry, arg3: &mut SubscriptionMandate, arg4: &mut SubscriptionTier, arg5: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg6: 0x2::transfer::Receiving<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap>, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg0);
        let v1 = 0x2::object::id<SubscriptionMandate>(arg3);
        assert!(arg3.fan_vault_id == v0 && arg3.tier_id == 0x2::object::id<SubscriptionTier>(arg4), 13845764021481504843);
        assert!(arg3.fee_policy_id == 0x2::object::id<FeePolicy>(arg1), 13845764025776472139);
        assert!(arg3.creator_vault_id == 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg5) && arg4.creator_vault_id == 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg5), 13849141729793540195);
        assert!(arg3.coin_type == 0x1::type_name::with_defining_ids<T0>(), 13847734359204298841);
        assert!(!consent_expired(arg3, arg8), 13848015838476107867);
        assert!(0x2::table::contains<0x2::object::ID, FanState>(&arg4.subscribers, v0), 13845764042956341323);
        let v2 = 0x2::clock::timestamp_ms(arg8);
        assert!(v2 >= arg3.paused_until_ms, 13855615675735736465);
        let v3 = 0x2::table::borrow<0x2::object::ID, FanState>(&arg4.subscribers, v0).paid_through_ms;
        assert!(0x1::option::contains<0x2::object::ID>(&0x2::table::borrow<0x2::object::ID, FanState>(&arg4.subscribers, v0).active_mandate, &v1), 13845764060136210507);
        assert!(v2 >= v3, 13846889964338544723);
        let v4 = 0x2::transfer::public_receive<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap>(&mut arg3.id, arg6);
        assert!(0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap>(&v4) == arg3.spender_cap_id, 13847171452200288341);
        let (v5, v6) = if (arg4.renewal_price_policy == 1) {
            (arg4.terms_version, arg4.price)
        } else {
            let (v7, v8) = if (!arg7 && 0x1::option::is_some<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>(&arg3.locked_base_price)) {
                (*0x1::option::borrow<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>(&arg3.locked_base_price), *0x1::option::borrow<u64>(&arg3.locked_terms_version))
            } else if (arg7 && 0x1::option::is_some<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>(&0x2::table::borrow<0x2::object::ID, FanState>(&arg4.subscribers, v0).last_paid)) {
                let v9 = 0x2::table::borrow<0x2::object::ID, FanState>(&arg4.subscribers, v0);
                (*0x1::option::borrow<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>(&v9.last_paid), v9.last_terms_version)
            } else {
                (arg4.price, arg4.terms_version)
            };
            (v8, v7)
        };
        let v10 = quote(arg1, v6);
        let (v11, v12) = 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::to_coin_units<T0>(arg2, v10.total, arg8);
        let v13 = v12;
        let (v14, _) = 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::to_coin_units<T0>(arg2, v10.fee, arg8);
        assert!(v11 <= arg3.max_raw_per_period, 13847453004486541399);
        let v16 = v11 - v14;
        let v17 = if (arg7) {
            *0x1::option::borrow<u64>(&arg3.schedule_anchor_ms)
        } else {
            v2
        };
        let v18 = v17;
        let v19 = 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::calendar::derive_window(v17, v2, 0x1::option::borrow<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::calendar::CalendarPeriod>(&arg4.duration));
        if (0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::calendar::window_start_ms(&v19) < v3) {
            v18 = v3;
            v19 = 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::calendar::derive_window(v3, v2, 0x1::option::borrow<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::calendar::CalendarPeriod>(&arg4.duration));
        };
        if (!arg7 || v18 != v17) {
            0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::shift_calendar_anchor<T0>(arg0, &v4, v18, arg8, arg9);
            arg3.schedule_anchor_ms = 0x1::option::some<u64>(v18);
        };
        let v20 = 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::calendar::window_end_ms(&v19);
        assert!(v20 > v3, 13846890161907040339);
        let v21 = 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::spend<T0>(arg0, &v4, v11, arg8, arg9);
        if (v14 > 0) {
            0x2::balance::send_funds<T0>(0x2::balance::split<T0>(&mut v21, v14), arg1.treasury);
        };
        if (v16 > 0) {
            0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::deposit_balance<T0>(arg5, v21, arg9);
        } else {
            0x2::balance::destroy_zero<T0>(v21);
        };
        let v22 = SubscriptionPass{
            id                 : 0x2::object::new(arg9),
            fan_vault_id       : v0,
            tier_id            : 0x2::object::id<SubscriptionTier>(arg4),
            valid_from_ms      : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::calendar::window_start_ms(&v19),
            valid_until_ms     : v20,
            nominal_paid       : v10.total,
            payment_coin_type  : 0x1::type_name::with_defining_ids<T0>(),
            raw_paid           : v11,
            rate               : v13,
            tier_terms_version : v5,
            mandate_id         : 0x1::option::some<0x2::object::ID>(v1),
        };
        let v23 = 0x2::object::id<SubscriptionPass>(&v22);
        let v24 = ContentManager{dummy_field: false};
        let v25 = PassKey{pass_id: v23};
        0x2::dynamic_object_field::add<PassKey, SubscriptionPass>(0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::uid_mut<ContentManager>(v24, arg0), v25, v22);
        arg4.passes_minted = checked_add(arg4.passes_minted, 1);
        let v26 = 0x2::table::borrow_mut<0x2::object::ID, FanState>(&mut arg4.subscribers, v0);
        v26.paid_through_ms = v20;
        v26.last_paid = 0x1::option::some<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>(v6);
        v26.last_terms_version = v5;
        if (!arg7) {
            arg3.status = 1;
        };
        let v27 = arg3.next_period_index;
        arg3.next_period_index = checked_add(v27, 1);
        let v28 = PaymentSettled{
            payer_vault_id       : v0,
            creator_vault_id     : arg3.creator_vault_id,
            product_kind         : 0,
            subject_id           : 0x2::object::id<SubscriptionTier>(arg4),
            consent_id           : v1,
            terms_version        : v5,
            period_index         : v27,
            nominal_currency     : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_currency(&v10.total),
            nominal_amount       : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_amount(&v10.total),
            coin_type            : 0x1::type_name::with_defining_ids<T0>(),
            raw_total            : v11,
            raw_creator_proceeds : v16,
            raw_fee              : v14,
            rate                 : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::snapshot_rate(&v13),
            rate_decimals        : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::snapshot_rate_decimals(&v13),
            rate_updated_at_ms   : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::snapshot_updated_at_ms(&v13),
            rate_source          : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::snapshot_source(&v13),
            settled_at_ms        : v2,
            result_id            : v23,
        };
        0x2::event::emit<PaymentSettled>(v28);
        let v29 = SubscriptionSettled{
            mandate_id   : v1,
            pass_id      : v23,
            period_index : v27,
            renewal      : arg7,
        };
        0x2::event::emit<SubscriptionSettled>(v29);
        0x2::transfer::public_transfer<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap>(v4, 0x2::object::id_to_address(&v1));
        v23
    }

    public fun start_paid_subscription<T0>(arg0: &mut 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: &FeePolicy, arg2: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::CurrencyRegistry, arg3: &mut SubscriptionMandate, arg4: &mut SubscriptionTier, arg5: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg6: 0x2::transfer::Receiving<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg3.status == 0, 13846040978152751181);
        assert!(arg7 == 0 && arg3.next_period_index == 0, 13846603932401401937);
        assert_paid_tier(arg4);
        settle_period<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, false, arg8, arg9)
    }

    public fun stop_for_all_policy() : u8 {
        2
    }

    public fun subscription_method() : u8 {
        1
    }

    public fun subscription_pass_active(arg0: &SubscriptionPass, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        arg0.valid_from_ms <= v0 && v0 < arg0.valid_until_ms
    }

    public fun subscription_product_kind() : u8 {
        0
    }

    public fun tier_active_mandate(arg0: &SubscriptionTier, arg1: 0x2::object::ID) : 0x1::option::Option<0x2::object::ID> {
        if (!0x2::table::contains<0x2::object::ID, FanState>(&arg0.subscribers, arg1)) {
            return 0x1::option::none<0x2::object::ID>()
        };
        0x2::table::borrow<0x2::object::ID, FanState>(&arg0.subscribers, arg1).active_mandate
    }

    public fun tier_creator_vault_id(arg0: &SubscriptionTier) : 0x2::object::ID {
        arg0.creator_vault_id
    }

    public fun tier_deactivation_policy(arg0: &SubscriptionTier) : u8 {
        arg0.deactivation_policy
    }

    public fun tier_duration(arg0: &SubscriptionTier) : 0x1::option::Option<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::calendar::CalendarPeriod> {
        arg0.duration
    }

    public fun tier_free_member(arg0: &SubscriptionTier, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, FanState>(&arg0.subscribers, arg1) && 0x2::table::borrow<0x2::object::ID, FanState>(&arg0.subscribers, arg1).free_member
    }

    public fun tier_free_since_ms(arg0: &SubscriptionTier, arg1: 0x2::object::ID) : u64 {
        if (tier_free_member(arg0, arg1)) {
            0x2::table::borrow<0x2::object::ID, FanState>(&arg0.subscribers, arg1).free_since_ms
        } else {
            0
        }
    }

    public fun tier_has_fan_state(arg0: &SubscriptionTier, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, FanState>(&arg0.subscribers, arg1)
    }

    public fun tier_is_archived(arg0: &SubscriptionTier) : bool {
        arg0.archived
    }

    public fun tier_is_free(arg0: &SubscriptionTier) : bool {
        is_free_price(&arg0.price)
    }

    public fun tier_last_paid(arg0: &SubscriptionTier, arg1: 0x2::object::ID) : 0x1::option::Option<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money> {
        if (!0x2::table::contains<0x2::object::ID, FanState>(&arg0.subscribers, arg1)) {
            return 0x1::option::none<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>()
        };
        0x2::table::borrow<0x2::object::ID, FanState>(&arg0.subscribers, arg1).last_paid
    }

    public fun tier_paid_through_ms(arg0: &SubscriptionTier, arg1: 0x2::object::ID) : u64 {
        if (!0x2::table::contains<0x2::object::ID, FanState>(&arg0.subscribers, arg1)) {
            return 0
        };
        0x2::table::borrow<0x2::object::ID, FanState>(&arg0.subscribers, arg1).paid_through_ms
    }

    public fun tier_passes_minted(arg0: &SubscriptionTier) : u64 {
        arg0.passes_minted
    }

    public fun tier_price(arg0: &SubscriptionTier) : 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money {
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

    public fun update_content_terms(arg0: &ContentWrite, arg1: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::CurrencyRegistry, arg2: &mut Content, arg3: u8, arg4: u8, arg5: 0x1::option::Option<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money>, arg6: &mut 0x2::tx_context::TxContext) {
        assert_writer(arg0, arg6);
        assert_content_policy(arg0, arg2);
        assert_content_mutable(arg2);
        apply_content_policy(arg1, arg2, arg3, arg4, arg5);
        arg2.terms_version = checked_add(arg2.terms_version, 1);
        let v0 = ContentTermsUpdated{
            content_id     : 0x2::object::id<Content>(arg2),
            access_kind    : arg2.access_kind,
            access_methods : arg2.access_methods,
            terms_version  : arg2.terms_version,
        };
        0x2::event::emit<ContentTermsUpdated>(v0);
    }

    public fun update_fee_policy(arg0: &mut FeePolicy, arg1: &FeePolicyAdminCap, arg2: u64, arg3: address, arg4: u8) {
        assert!(arg1.policy_id == 0x2::object::id<FeePolicy>(arg0), 13844353794739011649);
        assert_fee_terms(arg2, arg3, arg4);
        arg0.fee_bps = arg2;
        arg0.treasury = arg3;
        arg0.mode = arg4;
        let v0 = FeePolicyUpdated{
            policy_id : 0x2::object::id<FeePolicy>(arg0),
            fee_bps   : arg2,
            treasury  : arg3,
            mode      : arg4,
        };
        0x2::event::emit<FeePolicyUpdated>(v0);
    }

    public fun update_tier_display(arg0: &ContentWrite, arg1: &mut SubscriptionTier, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_writer(arg0, arg4);
        assert_tier_policy(arg0, arg1);
        assert!(!arg1.archived, 13838157986584068117);
        assert_valid_display_name(&arg2);
        arg1.name = arg2;
        arg1.cover = arg3;
        let v0 = TierDisplayUpdated{
            tier_id : 0x2::object::id<SubscriptionTier>(arg1),
            name    : arg1.name,
            cover   : arg1.cover,
        };
        0x2::event::emit<TierDisplayUpdated>(v0);
    }

    public fun update_tier_terms(arg0: &ContentWrite, arg1: &mut SubscriptionTier, arg2: 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::Money, arg3: 0x1::option::Option<0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::calendar::CalendarPeriod>, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        assert_writer(arg0, arg5);
        assert_tier_policy(arg0, arg1);
        assert!(!arg1.archived, 13838157836260212757);
        assert_valid_renewal_policy(arg4);
        assert!(0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_currency(&arg2) == 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing::money_currency(&arg1.price), 13837031944942780429);
        assert!(is_free_price(&arg2) == is_free_price(&arg1.price), 13851387177351643251);
        assert_price_terms(&arg2, &arg3);
        if (arg3 != arg1.duration) {
            assert!(arg1.passes_minted == 0 && 0x2::table::length<0x2::object::ID, FanState>(&arg1.subscribers) == 0, 13855890811340849299);
        };
        arg1.price = arg2;
        arg1.duration = arg3;
        arg1.renewal_price_policy = arg4;
        arg1.terms_version = checked_add(arg1.terms_version, 1);
        let v0 = TierTermsUpdated{
            tier_id              : 0x2::object::id<SubscriptionTier>(arg1),
            terms_version        : arg1.terms_version,
            price                : arg2,
            renewal_price_policy : arg4,
        };
        0x2::event::emit<TierTermsUpdated>(v0);
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

    public fun write_creator_vault_id(arg0: &ContentWrite) : 0x2::object::ID {
        arg0.creator_vault_id
    }

    public fun write_platform_writer(arg0: &ContentWrite) : 0x1::option::Option<address> {
        arg0.platform_writer
    }

    public fun write_user_writer(arg0: &ContentWrite) : address {
        arg0.user_writer
    }

    // decompiled from Move bytecode v7
}

