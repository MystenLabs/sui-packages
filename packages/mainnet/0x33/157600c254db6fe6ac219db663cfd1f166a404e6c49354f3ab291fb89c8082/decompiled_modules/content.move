module 0x33157600c254db6fe6ac219db663cfd1f166a404e6c49354f3ab291fb89c8082::content {
    struct CreatorAccount has key {
        id: 0x2::object::UID,
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

    struct SettlementCap has store, key {
        id: 0x2::object::UID,
    }

    struct Content has key {
        id: 0x2::object::UID,
        creator_id: 0x2::object::ID,
        content_kind: u8,
        access_kind: u8,
        access_methods: u8,
        allowed_tier_ids: vector<0x2::object::ID>,
        one_off_price: u64,
        one_off_accepted_coin_types: vector<vector<u8>>,
        status: u8,
        revision_count: u64,
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
        blob_owner_id: address,
        size_bytes: u64,
    }

    struct SubscriptionTier has key {
        id: 0x2::object::UID,
        creator_id: 0x2::object::ID,
        name: vector<u8>,
        cover: vector<u8>,
        price: u64,
        accepted_coin_types: vector<vector<u8>>,
        duration: 0x1::option::Option<TierDuration>,
        terms_version: u64,
        renewal_price_policy: u8,
        status: u8,
        deactivation_policy: u8,
        passes_minted: u64,
        current_passes: 0x2::table::Table<address, CurrentSubscriptionPass>,
    }

    struct TierDuration has copy, drop, store {
        count: u64,
        unit: u8,
    }

    struct CurrentSubscriptionPass has drop, store {
        pass_id: 0x2::object::ID,
        expires_at_ms: 0x1::option::Option<u64>,
    }

    struct SubscriptionPass has key {
        id: 0x2::object::UID,
        subscriber: address,
        tier_id: 0x2::object::ID,
        started_at_ms: u64,
        expires_at_ms: 0x1::option::Option<u64>,
        price_paid: u64,
        payment_coin_type: vector<u8>,
        tier_terms_version: u64,
    }

    struct ContentAccessPass has key {
        id: 0x2::object::UID,
        owner: address,
        content_id: 0x2::object::ID,
        purchased_at_ms: u64,
    }

    struct CreatorRegistered has copy, drop {
        account_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        account_cap_id: 0x2::object::ID,
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

    struct CreatorAccountPayoutUpdated has copy, drop {
        account_id: 0x2::object::ID,
        payout_address: address,
    }

    struct DecryptAuthorizedChanged has copy, drop {
        account_id: 0x2::object::ID,
        addr: address,
        authorized: bool,
    }

    struct ContentCreated has copy, drop {
        content_id: 0x2::object::ID,
        creator_id: 0x2::object::ID,
        content_kind: u8,
        access_kind: u8,
        access_methods: u8,
        one_off_price: u64,
        one_off_accepted_coin_types: vector<vector<u8>>,
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

    struct RevisionAdded has copy, drop {
        revision_id: 0x2::object::ID,
        content_id: 0x2::object::ID,
        creator_id: 0x2::object::ID,
        revision_number: u64,
        seal_id: vector<u8>,
        asset_count: u64,
    }

    struct RevisionPublished has copy, drop {
        revision_id: 0x2::object::ID,
        content_id: 0x2::object::ID,
        creator_id: 0x2::object::ID,
        revision_number: u64,
    }

    struct ContentStatusChanged has copy, drop {
        content_id: 0x2::object::ID,
        creator_id: 0x2::object::ID,
        status: u8,
    }

    struct TierPublished has copy, drop {
        tier_id: 0x2::object::ID,
        creator_id: 0x2::object::ID,
        name: vector<u8>,
        cover: vector<u8>,
        price: u64,
        accepted_coin_types: vector<vector<u8>>,
        duration_count: 0x1::option::Option<u64>,
        duration_unit: 0x1::option::Option<u8>,
        terms_version: u64,
        renewal_price_policy: u8,
        status: u8,
    }

    struct TierTermsUpdated has copy, drop {
        tier_id: 0x2::object::ID,
        price: u64,
        accepted_coin_types: vector<vector<u8>>,
        duration_count: 0x1::option::Option<u64>,
        duration_unit: 0x1::option::Option<u8>,
        terms_version: u64,
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
    }

    struct TierDeleted has copy, drop {
        tier_id: 0x2::object::ID,
        creator_id: 0x2::object::ID,
    }

    struct SubscriptionPassMinted has copy, drop {
        pass_id: 0x2::object::ID,
        subscriber: address,
        tier_id: 0x2::object::ID,
        started_at_ms: u64,
        expires_at_ms: 0x1::option::Option<u64>,
        price_paid: u64,
        payment_coin_type: vector<u8>,
        tier_terms_version: u64,
    }

    struct SubscriptionRenewed has copy, drop {
        pass_id: 0x2::object::ID,
        price_charged: u64,
        payment_coin_type: vector<u8>,
        tier_terms_version: u64,
        new_expires_at_ms: u64,
    }

    struct SubscriptionPassExpirationShortened has copy, drop {
        pass_id: 0x2::object::ID,
        subscriber: address,
        previous_expires_at_ms: 0x1::option::Option<u64>,
        new_expires_at_ms: u64,
    }

    struct ContentAccessPassMinted has copy, drop {
        pass_id: 0x2::object::ID,
        buyer: address,
        content_id: 0x2::object::ID,
        creator_id: 0x2::object::ID,
    }

    struct ContentPayoutUpdated has copy, drop {
        content_id: 0x2::object::ID,
        one_off_price: u64,
        one_off_accepted_coin_types: vector<vector<u8>>,
    }

    struct ContentAccessChanged has copy, drop {
        content_id: 0x2::object::ID,
        creator_id: 0x2::object::ID,
        previous_access_kind: u8,
        access_kind: u8,
        access_methods: u8,
        one_off_price: u64,
        one_off_accepted_coin_types: vector<vector<u8>>,
    }

    fun activate_access_policy(arg0: &mut Content, arg1: u8, arg2: u8, arg3: u64, arg4: vector<vector<u8>>) {
        let v0 = arg0.access_kind;
        let (v1, v2, v3) = normalized_access_policy(arg1, arg2, arg3, arg4);
        if (arg1 == 0 || !has_method(v1, 1)) {
            clear_content_tiers(arg0);
        } else {
            assert!(!0x1::vector::is_empty<0x2::object::ID>(&arg0.allowed_tier_ids), 43);
        };
        arg0.access_kind = arg1;
        arg0.access_methods = v1;
        arg0.one_off_price = v2;
        arg0.one_off_accepted_coin_types = v3;
        let v4 = ContentAccessChanged{
            content_id                  : 0x2::object::id<Content>(arg0),
            creator_id                  : arg0.creator_id,
            previous_access_kind        : v0,
            access_kind                 : arg1,
            access_methods              : arg0.access_methods,
            one_off_price               : arg0.one_off_price,
            one_off_accepted_coin_types : arg0.one_off_accepted_coin_types,
        };
        0x2::event::emit<ContentAccessChanged>(v4);
    }

    public fun add_content_tier(arg0: &CreatorCap, arg1: &CreatorAccount, arg2: &mut Content, arg3: &SubscriptionTier) {
        assert_creator_auth(arg0, arg1);
        assert_creator_owns(arg1, arg2.creator_id);
        assert!(arg3.creator_id == arg2.creator_id, 36);
        assert!(arg3.status == 0, 44);
        let v0 = 0x2::object::id<SubscriptionTier>(arg3);
        assert!(!vector_contains_id(&arg2.allowed_tier_ids, &v0), 26);
        assert!(0x1::vector::length<0x2::object::ID>(&arg2.allowed_tier_ids) < 32, 25);
        0x1::vector::push_back<0x2::object::ID>(&mut arg2.allowed_tier_ids, v0);
        let v1 = ContentTierAdded{
            content_id : 0x2::object::id<Content>(arg2),
            creator_id : arg2.creator_id,
            tier_id    : v0,
        };
        0x2::event::emit<ContentTierAdded>(v1);
    }

    public fun add_decrypt_authorized(arg0: &CreatorCap, arg1: &mut CreatorAccount, arg2: address) {
        assert!(arg0.account_id == 0x2::object::id<CreatorAccount>(arg1), 12);
        if (!0x2::vec_set::contains<address>(&arg1.decrypt_authorized, &arg2)) {
            0x2::vec_set::insert<address>(&mut arg1.decrypt_authorized, arg2);
            let v0 = DecryptAuthorizedChanged{
                account_id : 0x2::object::id<CreatorAccount>(arg1),
                addr       : arg2,
                authorized : true,
            };
            0x2::event::emit<DecryptAuthorizedChanged>(v0);
        };
    }

    public fun add_published_revision(arg0: &CreatorCap, arg1: &mut Content, arg2: u8, arg3: u8, arg4: u64, arg5: vector<vector<u8>>, arg6: vector<u8>, arg7: vector<u32>, arg8: vector<vector<u8>>, arg9: vector<vector<u8>>, arg10: vector<address>, arg11: vector<u64>, arg12: vector<u8>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert_content_auth(arg0, arg1);
        let v0 = append_revision(arg1, arg2, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        activate_access_policy(arg1, arg2, arg3, arg4, arg5);
        let v1 = &mut v0;
        mark_published(arg1, v1);
        0x2::transfer::share_object<ContentRevision>(v0);
    }

    public fun add_revision(arg0: &CreatorCap, arg1: &mut Content, arg2: u8, arg3: vector<u8>, arg4: vector<u32>, arg5: vector<vector<u8>>, arg6: vector<vector<u8>>, arg7: vector<address>, arg8: vector<u64>, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert_content_auth(arg0, arg1);
        0x2::transfer::share_object<ContentRevision>(append_revision(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11));
    }

    fun append_revision(arg0: &mut Content, arg1: u8, arg2: vector<u8>, arg3: vector<u32>, arg4: vector<vector<u8>>, arg5: vector<vector<u8>>, arg6: vector<address>, arg7: vector<u64>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : ContentRevision {
        assert!(arg1 == 0 || arg1 == 1, 17);
        let v0 = 0x1::vector::length<u8>(&arg2);
        assert!(v0 > 0, 27);
        assert!(0x1::vector::length<u32>(&arg3) == v0, 15);
        assert!(0x1::vector::length<vector<u8>>(&arg4) == v0, 15);
        assert!(0x1::vector::length<vector<u8>>(&arg5) == v0, 15);
        assert!(0x1::vector::length<address>(&arg6) == v0, 15);
        assert!(0x1::vector::length<u64>(&arg7) == v0, 15);
        let v1 = 0x1::vector::empty<ContentAsset>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<vector<u8>>(&arg4, v2);
            if (arg1 == 0) {
                assert!(0x1::vector::is_empty<u8>(&v3), 28);
            } else {
                assert!(!0x1::vector::is_empty<u8>(&v3), 29);
            };
            let v4 = ContentAsset{
                asset_kind    : *0x1::vector::borrow<u8>(&arg2, v2),
                order_index   : *0x1::vector::borrow<u32>(&arg3, v2),
                seal_id       : v3,
                blob_id       : *0x1::vector::borrow<vector<u8>>(&arg5, v2),
                blob_owner_id : *0x1::vector::borrow<address>(&arg6, v2),
                size_bytes    : *0x1::vector::borrow<u64>(&arg7, v2),
            };
            0x1::vector::push_back<ContentAsset>(&mut v1, v4);
            v2 = v2 + 1;
        };
        arg0.revision_count = arg0.revision_count + 1;
        let v5 = arg0.revision_count;
        let v6 = ContentRevision{
            id              : 0x2::object::new(arg10),
            content_id      : 0x2::object::id<Content>(arg0),
            revision_number : v5,
            access_kind     : arg1,
            seal_id         : arg8,
            assets          : v1,
            created_at_ms   : 0x2::clock::timestamp_ms(arg9),
            status          : 0,
        };
        let v7 = 0x2::object::id<ContentRevision>(&v6);
        arg0.latest_revision = 0x1::option::some<0x2::object::ID>(v7);
        let v8 = RevisionAdded{
            revision_id     : v7,
            content_id      : 0x2::object::id<Content>(arg0),
            creator_id      : arg0.creator_id,
            revision_number : v5,
            seal_id         : v6.seal_id,
            asset_count     : v0,
        };
        0x2::event::emit<RevisionAdded>(v8);
        v6
    }

    public fun archive_content(arg0: &CreatorCap, arg1: &mut Content) {
        set_content_status(arg0, arg1, 2);
    }

    public fun archive_tier(arg0: &CreatorCap, arg1: &CreatorAccount, arg2: &mut SubscriptionTier) {
        assert_creator_auth(arg0, arg1);
        assert_creator_owns(arg1, arg2.creator_id);
        arg2.status = 1;
        arg2.deactivation_policy = 0;
        let v0 = TierStatusChanged{
            tier_id : 0x2::object::id<SubscriptionTier>(arg2),
            status  : 1,
        };
        0x2::event::emit<TierStatusChanged>(v0);
    }

    fun assert_account_auth(arg0: &AccountCap, arg1: &CreatorAccount) {
        assert!(arg0.account_id == 0x2::object::id<CreatorAccount>(arg1), 12);
    }

    fun assert_coin_type_accepted<T0>(arg0: &vector<vector<u8>>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(arg0)) {
            if (*0x1::vector::borrow<vector<u8>>(arg0, v0) == coin_type_bytes<T0>()) {
                return
            };
            v0 = v0 + 1;
        };
        abort 21
    }

    fun assert_coin_type_matches<T0>(arg0: &vector<u8>) {
        assert!(coin_type_bytes<T0>() == *arg0, 21);
    }

    fun assert_content_auth(arg0: &CreatorCap, arg1: &Content) {
        assert!(arg0.account_id == arg1.creator_id, 12);
    }

    fun assert_creator_asset(arg0: &Content, arg1: &ContentRevision, arg2: &vector<u8>) {
        assert!(arg1.access_kind == 1, 19);
        assert!(arg0.status != 2, 14);
        assert!(arg1.content_id == 0x2::object::id<Content>(arg0), 13);
        assert!(revision_contains_seal_id(arg1, arg2), 1);
    }

    fun assert_creator_auth(arg0: &CreatorCap, arg1: &CreatorAccount) {
        assert!(arg0.account_id == 0x2::object::id<CreatorAccount>(arg1), 12);
    }

    fun assert_creator_owns(arg0: &CreatorAccount, arg1: 0x2::object::ID) {
        assert!(0x2::object::id<CreatorAccount>(arg0) == arg1, 3);
    }

    fun assert_current_subscription_pass(arg0: &SubscriptionTier, arg1: &SubscriptionPass) {
        assert!(0x2::table::contains<address, CurrentSubscriptionPass>(&arg0.current_passes, arg1.subscriber), 56);
        let v0 = 0x2::table::borrow<address, CurrentSubscriptionPass>(&arg0.current_passes, arg1.subscriber);
        assert!(v0.pass_id == 0x2::object::id<SubscriptionPass>(arg1), 56);
        assert!(v0.expires_at_ms == arg1.expires_at_ms, 56);
    }

    fun assert_published_asset(arg0: &Content, arg1: &ContentRevision, arg2: &vector<u8>) {
        assert!(arg0.access_kind == 1, 19);
        assert!(arg0.status != 2, 14);
        assert!(arg1.content_id == 0x2::object::id<Content>(arg0), 13);
        let v0 = 0x2::object::id<ContentRevision>(arg1);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.published_revision, &v0), 5);
        assert!(arg1.status == 1, 5);
        assert!(revision_contains_seal_id(arg1, arg2), 1);
    }

    fun assert_tier_can_renew(arg0: &SubscriptionTier) {
        assert!(arg0.status == 0 || arg0.status == 1 && arg0.deactivation_policy == 1, 7);
    }

    fun assert_valid_accepted_coin_types(arg0: &vector<vector<u8>>) {
        let v0 = 0x1::vector::length<vector<u8>>(arg0);
        assert!(v0 > 0, 41);
        assert!(v0 <= 8, 42);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = v1 + 1;
            while (v2 < v0) {
                assert!(0x1::vector::borrow<vector<u8>>(arg0, v1) != 0x1::vector::borrow<vector<u8>>(arg0, v2), 45);
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
    }

    fun assert_valid_content_status(arg0: u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        };
        assert!(v0, 30);
    }

    fun assert_valid_deactivation_policy(arg0: u8) {
        assert!(arg0 == 1 || arg0 == 2, 57);
    }

    fun assert_valid_display_name(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) > 0, 50);
        assert!(0x1::vector::length<u8>(arg0) <= 128, 24);
    }

    fun assert_valid_renewal_policy(arg0: u8) {
        assert!(arg0 == 0 || arg0 == 1, 22);
    }

    fun assert_valid_tier_status(arg0: u8) {
        assert!(arg0 == 0 || arg0 == 1, 23);
    }

    fun checked_add_ms(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, 46);
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

    fun coin_type_bytes<T0>() : vector<u8> {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        *0x1::ascii::as_bytes(&v0)
    }

    public fun content_access_purchase_terms<T0>(arg0: &Content, arg1: &CreatorAccount) : (u64, address) {
        assert!(arg0.access_kind == 1, 19);
        assert!(arg0.status != 2, 14);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.published_revision), 35);
        assert!(has_method(arg0.access_methods, 2), 20);
        assert!(arg0.one_off_price > 0, 11);
        assert_creator_owns(arg1, arg0.creator_id);
        assert_coin_type_accepted<T0>(&arg0.one_off_accepted_coin_types);
        (arg0.one_off_price, arg1.payout_address)
    }

    public fun content_one_off_price(arg0: &Content) : u64 {
        arg0.one_off_price
    }

    public fun create_content(arg0: &CreatorCap, arg1: &CreatorAccount, arg2: u8, arg3: u8, arg4: u8, arg5: u64, arg6: vector<vector<u8>>, arg7: &mut 0x2::tx_context::TxContext) {
        assert_creator_auth(arg0, arg1);
        let v0 = new_content(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = ContentCreated{
            content_id                  : 0x2::object::id<Content>(&v0),
            creator_id                  : v0.creator_id,
            content_kind                : arg2,
            access_kind                 : arg3,
            access_methods              : v0.access_methods,
            one_off_price               : v0.one_off_price,
            one_off_accepted_coin_types : v0.one_off_accepted_coin_types,
        };
        0x2::event::emit<ContentCreated>(v1);
        0x2::transfer::share_object<Content>(v0);
    }

    public fun create_content_and_publish_revision(arg0: &CreatorCap, arg1: &CreatorAccount, arg2: u8, arg3: u8, arg4: u8, arg5: u64, arg6: vector<vector<u8>>, arg7: vector<u8>, arg8: vector<u32>, arg9: vector<vector<u8>>, arg10: vector<vector<u8>>, arg11: vector<address>, arg12: vector<u64>, arg13: vector<u8>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        assert_creator_auth(arg0, arg1);
        let v0 = new_content(arg1, arg2, arg3, arg4, arg5, arg6, arg15);
        let v1 = ContentCreated{
            content_id                  : 0x2::object::id<Content>(&v0),
            creator_id                  : v0.creator_id,
            content_kind                : arg2,
            access_kind                 : arg3,
            access_methods              : v0.access_methods,
            one_off_price               : v0.one_off_price,
            one_off_accepted_coin_types : v0.one_off_accepted_coin_types,
        };
        0x2::event::emit<ContentCreated>(v1);
        let v2 = &mut v0;
        let v3 = append_revision(v2, arg3, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
        let v4 = &mut v0;
        let v5 = &mut v3;
        mark_published(v4, v5);
        0x2::transfer::share_object<ContentRevision>(v3);
        0x2::transfer::share_object<Content>(v0);
    }

    public fun create_tier(arg0: &CreatorCap, arg1: &CreatorAccount, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: vector<vector<u8>>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u8>, arg8: u8, arg9: u8, arg10: &mut 0x2::tx_context::TxContext) {
        assert_creator_auth(arg0, arg1);
        assert_valid_display_name(&arg2);
        assert_valid_renewal_policy(arg8);
        assert_valid_tier_status(arg9);
        let v0 = validated_tier_duration(arg4, &arg5, arg6, arg7);
        let (v1, v2) = duration_parts(&v0);
        let v3 = if (arg9 == 0) {
            0
        } else {
            1
        };
        let v4 = 0x2::object::id<CreatorAccount>(arg1);
        let v5 = SubscriptionTier{
            id                   : 0x2::object::new(arg10),
            creator_id           : v4,
            name                 : arg2,
            cover                : arg3,
            price                : arg4,
            accepted_coin_types  : arg5,
            duration             : v0,
            terms_version        : 1,
            renewal_price_policy : arg8,
            status               : arg9,
            deactivation_policy  : v3,
            passes_minted        : 0,
            current_passes       : 0x2::table::new<address, CurrentSubscriptionPass>(arg10),
        };
        let v6 = TierPublished{
            tier_id              : 0x2::object::id<SubscriptionTier>(&v5),
            creator_id           : v4,
            name                 : v5.name,
            cover                : v5.cover,
            price                : arg4,
            accepted_coin_types  : v5.accepted_coin_types,
            duration_count       : v1,
            duration_unit        : v2,
            terms_version        : 1,
            renewal_price_policy : arg8,
            status               : arg9,
        };
        0x2::event::emit<TierPublished>(v6);
        0x2::transfer::share_object<SubscriptionTier>(v5);
    }

    public fun deactivate_tier(arg0: &CreatorCap, arg1: &CreatorAccount, arg2: &mut SubscriptionTier, arg3: u8) {
        assert_creator_auth(arg0, arg1);
        assert_creator_owns(arg1, arg2.creator_id);
        assert_valid_deactivation_policy(arg3);
        arg2.status = 1;
        arg2.deactivation_policy = arg3;
        let v0 = TierStatusChanged{
            tier_id : 0x2::object::id<SubscriptionTier>(arg2),
            status  : 1,
        };
        0x2::event::emit<TierStatusChanged>(v0);
    }

    public fun delete_tier(arg0: &CreatorCap, arg1: &CreatorAccount, arg2: SubscriptionTier) {
        assert_creator_auth(arg0, arg1);
        assert_creator_owns(arg1, arg2.creator_id);
        assert!(arg2.passes_minted == 0, 52);
        let SubscriptionTier {
            id                   : v0,
            creator_id           : _,
            name                 : _,
            cover                : _,
            price                : _,
            accepted_coin_types  : _,
            duration             : _,
            terms_version        : _,
            renewal_price_policy : _,
            status               : _,
            deactivation_policy  : _,
            passes_minted        : _,
            current_passes       : v12,
        } = arg2;
        0x2::table::destroy_empty<address, CurrentSubscriptionPass>(v12);
        0x2::object::delete(v0);
        let v13 = TierDeleted{
            tier_id    : 0x2::object::id<SubscriptionTier>(&arg2),
            creator_id : arg2.creator_id,
        };
        0x2::event::emit<TierDeleted>(v13);
    }

    fun duration_ms(arg0: &TierDuration) : u64 {
        let v0 = if (arg0.unit == 1) {
            86400000
        } else if (arg0.unit == 2) {
            2592000000
        } else {
            assert!(arg0.unit == 3, 46);
            31536000000
        };
        assert!(arg0.count <= 315360000000 / v0, 46);
        arg0.count * v0
    }

    fun duration_parts(arg0: &0x1::option::Option<TierDuration>) : (0x1::option::Option<u64>, 0x1::option::Option<u8>) {
        if (0x1::option::is_some<TierDuration>(arg0)) {
            let v2 = 0x1::option::borrow<TierDuration>(arg0);
            (0x1::option::some<u64>(v2.count), 0x1::option::some<u8>(v2.unit))
        } else {
            (0x1::option::none<u64>(), 0x1::option::none<u8>())
        }
    }

    public fun expire_free_subscription_pass(arg0: &SettlementCap, arg1: &mut SubscriptionTier, arg2: &mut SubscriptionPass, arg3: &0x2::clock::Clock) {
        assert!(arg2.price_paid == 0, 53);
        shorten_current_subscription_pass_expiration(arg1, arg2, 0x2::clock::timestamp_ms(arg3));
    }

    fun has_method(arg0: u8, arg1: u8) : bool {
        arg0 & arg1 != 0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SettlementCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SettlementCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun mark_published(arg0: &mut Content, arg1: &mut ContentRevision) {
        assert!(arg1.status == 0, 58);
        let v0 = 0x2::object::id<ContentRevision>(arg1);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.latest_revision, &v0), 59);
        if (has_method(arg0.access_methods, 1)) {
            assert!(!0x1::vector::is_empty<0x2::object::ID>(&arg0.allowed_tier_ids), 43);
        };
        arg1.status = 1;
        let v1 = 0x2::object::id<ContentRevision>(arg1);
        arg0.published_revision = 0x1::option::some<0x2::object::ID>(v1);
        arg0.status = 1;
        let v2 = RevisionPublished{
            revision_id     : v1,
            content_id      : 0x2::object::id<Content>(arg0),
            creator_id      : arg0.creator_id,
            revision_number : arg1.revision_number,
        };
        0x2::event::emit<RevisionPublished>(v2);
        let v3 = ContentStatusChanged{
            content_id : 0x2::object::id<Content>(arg0),
            creator_id : arg0.creator_id,
            status     : 1,
        };
        0x2::event::emit<ContentStatusChanged>(v3);
    }

    fun mint_content_access_pass<T0>(arg0: address, arg1: &Content, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = ContentAccessPass{
            id              : 0x2::object::new(arg3),
            owner           : arg0,
            content_id      : 0x2::object::id<Content>(arg1),
            purchased_at_ms : 0x2::clock::timestamp_ms(arg2),
        };
        let v1 = 0x2::object::id<ContentAccessPass>(&v0);
        let v2 = ContentAccessPassMinted{
            pass_id    : v1,
            buyer      : arg0,
            content_id : v0.content_id,
            creator_id : arg1.creator_id,
        };
        0x2::event::emit<ContentAccessPassMinted>(v2);
        0x2::transfer::transfer<ContentAccessPass>(v0, arg0);
        v1
    }

    fun mint_subscription_pass<T0>(arg0: address, arg1: &mut SubscriptionTier, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (0x2::table::contains<address, CurrentSubscriptionPass>(&arg1.current_passes, arg0)) {
            let v1 = 0x2::table::borrow<address, CurrentSubscriptionPass>(&arg1.current_passes, arg0);
            assert!(0x1::option::is_some<u64>(&v1.expires_at_ms) && *0x1::option::borrow<u64>(&v1.expires_at_ms) <= v0, 55);
            0x2::table::remove<address, CurrentSubscriptionPass>(&mut arg1.current_passes, arg0);
        };
        let v2 = if (0x1::option::is_some<TierDuration>(&arg1.duration)) {
            0x1::option::some<u64>(checked_add_ms(v0, duration_ms(0x1::option::borrow<TierDuration>(&arg1.duration))))
        } else {
            assert!(arg1.price == 0, 46);
            0x1::option::none<u64>()
        };
        let v3 = SubscriptionPass{
            id                 : 0x2::object::new(arg3),
            subscriber         : arg0,
            tier_id            : 0x2::object::id<SubscriptionTier>(arg1),
            started_at_ms      : v0,
            expires_at_ms      : v2,
            price_paid         : arg1.price,
            payment_coin_type  : coin_type_bytes<T0>(),
            tier_terms_version : arg1.terms_version,
        };
        arg1.passes_minted = arg1.passes_minted + 1;
        let v4 = 0x2::object::id<SubscriptionPass>(&v3);
        let v5 = CurrentSubscriptionPass{
            pass_id       : v4,
            expires_at_ms : v2,
        };
        0x2::table::add<address, CurrentSubscriptionPass>(&mut arg1.current_passes, arg0, v5);
        let v6 = SubscriptionPassMinted{
            pass_id            : v4,
            subscriber         : arg0,
            tier_id            : v3.tier_id,
            started_at_ms      : v3.started_at_ms,
            expires_at_ms      : v3.expires_at_ms,
            price_paid         : v3.price_paid,
            payment_coin_type  : v3.payment_coin_type,
            tier_terms_version : v3.tier_terms_version,
        };
        0x2::event::emit<SubscriptionPassMinted>(v6);
        0x2::transfer::share_object<SubscriptionPass>(v3);
        v4
    }

    fun new_content(arg0: &CreatorAccount, arg1: u8, arg2: u8, arg3: u8, arg4: u64, arg5: vector<vector<u8>>, arg6: &mut 0x2::tx_context::TxContext) : Content {
        assert!(arg1 >= 1 && arg1 <= 3, 16);
        let (v0, v1, v2) = normalized_access_policy(arg2, arg3, arg4, arg5);
        Content{
            id                          : 0x2::object::new(arg6),
            creator_id                  : 0x2::object::id<CreatorAccount>(arg0),
            content_kind                : arg1,
            access_kind                 : arg2,
            access_methods              : v0,
            allowed_tier_ids            : 0x1::vector::empty<0x2::object::ID>(),
            one_off_price               : v1,
            one_off_accepted_coin_types : v2,
            status                      : 0,
            revision_count              : 0,
            latest_revision             : 0x1::option::none<0x2::object::ID>(),
            published_revision          : 0x1::option::none<0x2::object::ID>(),
        }
    }

    fun normalized_access_policy(arg0: u8, arg1: u8, arg2: u64, arg3: vector<vector<u8>>) : (u8, u64, vector<vector<u8>>) {
        assert!(arg0 == 0 || arg0 == 1, 17);
        if (arg0 == 0) {
            (0, 0, vector[])
        } else {
            assert!(arg1 != 0, 18);
            assert!(arg1 & 3 == arg1, 31);
            let (v3, v4) = if (has_method(arg1, 2)) {
                assert!(arg2 > 0, 38);
                assert_valid_accepted_coin_types(&arg3);
                (arg2, arg3)
            } else {
                (0, vector[])
            };
            (arg1, v3, v4)
        }
    }

    public fun publish_revision(arg0: &CreatorCap, arg1: &mut Content, arg2: &mut ContentRevision, arg3: u8, arg4: u64, arg5: vector<vector<u8>>) {
        assert_content_auth(arg0, arg1);
        assert!(arg2.content_id == 0x2::object::id<Content>(arg1), 13);
        activate_access_policy(arg1, arg2.access_kind, arg3, arg4, arg5);
        mark_published(arg1, arg2);
    }

    public fun reactivate_tier(arg0: &CreatorCap, arg1: &CreatorAccount, arg2: &mut SubscriptionTier) {
        assert_creator_auth(arg0, arg1);
        assert_creator_owns(arg1, arg2.creator_id);
        arg2.status = 0;
        arg2.deactivation_policy = 0;
        let v0 = TierStatusChanged{
            tier_id : 0x2::object::id<SubscriptionTier>(arg2),
            status  : 0,
        };
        0x2::event::emit<TierStatusChanged>(v0);
    }

    public fun register_creator(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CreatorAccount{
            id                 : 0x2::object::new(arg0),
            payout_address     : 0x2::tx_context::sender(arg0),
            decrypt_authorized : 0x2::vec_set::empty<address>(),
        };
        let v1 = 0x2::object::id<CreatorAccount>(&v0);
        let v2 = CreatorCap{
            id         : 0x2::object::new(arg0),
            account_id : v1,
        };
        let v3 = AccountCap{
            id         : 0x2::object::new(arg0),
            account_id : v1,
        };
        let v4 = CreatorRegistered{
            account_id     : v1,
            cap_id         : 0x2::object::id<CreatorCap>(&v2),
            account_cap_id : 0x2::object::id<AccountCap>(&v3),
        };
        0x2::event::emit<CreatorRegistered>(v4);
        0x2::transfer::share_object<CreatorAccount>(v0);
        0x2::transfer::transfer<CreatorCap>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<AccountCap>(v3, 0x2::tx_context::sender(arg0));
    }

    public fun register_creator_delegated(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CreatorAccount{
            id                 : 0x2::object::new(arg2),
            payout_address     : 0x2::tx_context::sender(arg2),
            decrypt_authorized : 0x2::vec_set::empty<address>(),
        };
        let v1 = 0x2::object::id<CreatorAccount>(&v0);
        0x2::vec_set::insert<address>(&mut v0.decrypt_authorized, arg1);
        let v2 = CreatorCap{
            id         : 0x2::object::new(arg2),
            account_id : v1,
        };
        let v3 = AccountCap{
            id         : 0x2::object::new(arg2),
            account_id : v1,
        };
        let v4 = CreatorRegistered{
            account_id     : v1,
            cap_id         : 0x2::object::id<CreatorCap>(&v2),
            account_cap_id : 0x2::object::id<AccountCap>(&v3),
        };
        0x2::event::emit<CreatorRegistered>(v4);
        let v5 = DecryptAuthorizedChanged{
            account_id : v1,
            addr       : arg1,
            authorized : true,
        };
        0x2::event::emit<DecryptAuthorizedChanged>(v5);
        let v6 = CreatorCapTransferred{
            account_id : v1,
            cap_id     : 0x2::object::id<CreatorCap>(&v2),
            from       : 0x2::tx_context::sender(arg2),
            to         : arg0,
        };
        0x2::event::emit<CreatorCapTransferred>(v6);
        0x2::transfer::share_object<CreatorAccount>(v0);
        0x2::transfer::transfer<AccountCap>(v3, 0x2::tx_context::sender(arg2));
        0x2::transfer::transfer<CreatorCap>(v2, arg0);
    }

    public fun remove_content_tier(arg0: &CreatorCap, arg1: &CreatorAccount, arg2: &mut Content, arg3: 0x2::object::ID) {
        assert_creator_auth(arg0, arg1);
        assert_creator_owns(arg1, arg2.creator_id);
        let v0 = &mut arg2.allowed_tier_ids;
        assert!(vector_remove_id(v0, &arg3), 32);
        let v1 = ContentTierRemoved{
            content_id : 0x2::object::id<Content>(arg2),
            creator_id : arg2.creator_id,
            tier_id    : arg3,
        };
        0x2::event::emit<ContentTierRemoved>(v1);
    }

    public fun remove_decrypt_authorized(arg0: &CreatorCap, arg1: &mut CreatorAccount, arg2: address) {
        assert!(arg0.account_id == 0x2::object::id<CreatorAccount>(arg1), 12);
        if (0x2::vec_set::contains<address>(&arg1.decrypt_authorized, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg1.decrypt_authorized, &arg2);
            let v0 = DecryptAuthorizedChanged{
                account_id : 0x2::object::id<CreatorAccount>(arg1),
                addr       : arg2,
                authorized : false,
            };
            0x2::event::emit<DecryptAuthorizedChanged>(v0);
        };
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

    entry fun seal_approve_content_access(arg0: vector<u8>, arg1: &Content, arg2: &ContentRevision, arg3: &ContentAccessPass, arg4: &0x2::tx_context::TxContext) {
        assert_published_asset(arg1, arg2, &arg0);
        assert!(has_method(arg1.access_methods, 2), 20);
        assert!(arg3.owner == 0x2::tx_context::sender(arg4), 9);
        assert!(arg3.content_id == 0x2::object::id<Content>(arg1), 10);
    }

    entry fun seal_approve_creator_delegate(arg0: vector<u8>, arg1: &Content, arg2: &ContentRevision, arg3: &CreatorAccount, arg4: &0x2::tx_context::TxContext) {
        assert_creator_asset(arg1, arg2, &arg0);
        assert!(arg1.creator_id == 0x2::object::id<CreatorAccount>(arg3), 3);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg3.decrypt_authorized, &v0), 48);
    }

    entry fun seal_approve_owner(arg0: vector<u8>, arg1: &Content, arg2: &ContentRevision, arg3: &AccountCap) {
        assert_creator_asset(arg1, arg2, &arg0);
        assert!(arg3.account_id == arg1.creator_id, 12);
    }

    entry fun seal_approve_subscription(arg0: vector<u8>, arg1: &Content, arg2: &ContentRevision, arg3: &SubscriptionPass, arg4: &SubscriptionTier, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_published_asset(arg1, arg2, &arg0);
        assert!(has_method(arg1.access_methods, 1), 20);
        assert!(arg3.subscriber == 0x2::tx_context::sender(arg6), 2);
        assert!(vector_contains_id(&arg1.allowed_tier_ids, &arg3.tier_id), 6);
        assert!(0x2::object::id<SubscriptionTier>(arg4) == arg3.tier_id, 34);
        assert_current_subscription_pass(arg4, arg3);
        if (0x1::option::is_some<u64>(&arg3.expires_at_ms)) {
            assert!(0x2::clock::timestamp_ms(arg5) < *0x1::option::borrow<u64>(&arg3.expires_at_ms), 4);
        };
    }

    public fun set_content_payout(arg0: &CreatorCap, arg1: &mut Content, arg2: u64, arg3: vector<vector<u8>>) {
        assert_content_auth(arg0, arg1);
        assert!(arg1.access_kind == 1, 40);
        assert!(has_method(arg1.access_methods, 2), 20);
        assert!(arg2 > 0, 38);
        assert_valid_accepted_coin_types(&arg3);
        arg1.one_off_price = arg2;
        arg1.one_off_accepted_coin_types = arg3;
        let v0 = ContentPayoutUpdated{
            content_id                  : 0x2::object::id<Content>(arg1),
            one_off_price               : arg2,
            one_off_accepted_coin_types : arg3,
        };
        0x2::event::emit<ContentPayoutUpdated>(v0);
    }

    public fun set_content_status(arg0: &CreatorCap, arg1: &mut Content, arg2: u8) {
        assert_content_auth(arg0, arg1);
        assert_valid_content_status(arg2);
        arg1.status = arg2;
        let v0 = ContentStatusChanged{
            content_id : 0x2::object::id<Content>(arg1),
            creator_id : arg1.creator_id,
            status     : arg2,
        };
        0x2::event::emit<ContentStatusChanged>(v0);
    }

    public fun set_creator_payout(arg0: &AccountCap, arg1: &mut CreatorAccount, arg2: address) {
        assert_account_auth(arg0, arg1);
        arg1.payout_address = arg2;
        let v0 = CreatorAccountPayoutUpdated{
            account_id     : 0x2::object::id<CreatorAccount>(arg1),
            payout_address : arg2,
        };
        0x2::event::emit<CreatorAccountPayoutUpdated>(v0);
    }

    public fun settle_content_access_purchase<T0>(arg0: &SettlementCap, arg1: address, arg2: &Content, arg3: &CreatorAccount, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1) = content_access_purchase_terms<T0>(arg2, arg3);
        assert!(0x2::coin::value<T0>(&arg4) == v0, 51);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, v1);
        mint_content_access_pass<T0>(arg1, arg2, arg5, arg6)
    }

    public fun settle_subscription_purchase<T0>(arg0: &SettlementCap, arg1: address, arg2: &mut SubscriptionTier, arg3: &CreatorAccount, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, _, v2) = subscription_purchase_terms<T0>(arg2, arg3);
        assert!(0x2::coin::value<T0>(&arg4) + arg5 == v0, 51);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, v2);
        mint_subscription_pass<T0>(arg1, arg2, arg6, arg7)
    }

    fun shorten_current_subscription_pass_expiration(arg0: &mut SubscriptionTier, arg1: &mut SubscriptionPass, arg2: u64) {
        assert!(arg1.tier_id == 0x2::object::id<SubscriptionTier>(arg0), 34);
        assert_current_subscription_pass(arg0, arg1);
        let v0 = arg1.expires_at_ms;
        let v1 = if (0x1::option::is_some<u64>(&v0)) {
            let v2 = *0x1::option::borrow<u64>(&v0);
            if (v2 < arg2) {
                v2
            } else {
                arg2
            }
        } else {
            arg2
        };
        arg1.expires_at_ms = 0x1::option::some<u64>(v1);
        0x2::table::borrow_mut<address, CurrentSubscriptionPass>(&mut arg0.current_passes, arg1.subscriber).expires_at_ms = arg1.expires_at_ms;
        let v3 = SubscriptionPassExpirationShortened{
            pass_id                : 0x2::object::id<SubscriptionPass>(arg1),
            subscriber             : arg1.subscriber,
            previous_expires_at_ms : v0,
            new_expires_at_ms      : v1,
        };
        0x2::event::emit<SubscriptionPassExpirationShortened>(v3);
    }

    public fun shorten_free_subscription_expiration(arg0: &SettlementCap, arg1: &mut SubscriptionTier, arg2: &mut SubscriptionPass, arg3: &0x2::clock::Clock) {
        expire_free_subscription_pass(arg0, arg1, arg2, arg3);
    }

    public fun subscription_purchase_terms<T0>(arg0: &SubscriptionTier, arg1: &CreatorAccount) : (u64, u64, address) {
        assert!(arg0.status == 0, 7);
        assert_creator_owns(arg1, arg0.creator_id);
        assert_coin_type_accepted<T0>(&arg0.accepted_coin_types);
        (arg0.price, arg0.terms_version, arg1.payout_address)
    }

    public fun tier_price(arg0: &SubscriptionTier) : u64 {
        arg0.price
    }

    public fun transfer_account_cap(arg0: AccountCap, arg1: address, arg2: &0x2::tx_context::TxContext) {
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
        let v0 = CreatorCapTransferred{
            account_id : arg0.account_id,
            cap_id     : 0x2::object::id<CreatorCap>(&arg0),
            from       : 0x2::tx_context::sender(arg2),
            to         : arg1,
        };
        0x2::event::emit<CreatorCapTransferred>(v0);
        0x2::transfer::transfer<CreatorCap>(arg0, arg1);
    }

    public fun update_tier_display(arg0: &CreatorCap, arg1: &CreatorAccount, arg2: &mut SubscriptionTier, arg3: vector<u8>, arg4: vector<u8>) {
        assert_creator_auth(arg0, arg1);
        assert_creator_owns(arg1, arg2.creator_id);
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

    public fun update_tier_terms(arg0: &CreatorCap, arg1: &CreatorAccount, arg2: &mut SubscriptionTier, arg3: u64, arg4: vector<vector<u8>>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u8>, arg7: u8) {
        assert_creator_auth(arg0, arg1);
        assert_creator_owns(arg1, arg2.creator_id);
        assert_valid_renewal_policy(arg7);
        let v0 = validated_tier_duration(arg3, &arg4, arg5, arg6);
        let (v1, v2) = duration_parts(&v0);
        arg2.price = arg3;
        arg2.accepted_coin_types = arg4;
        arg2.duration = v0;
        arg2.renewal_price_policy = arg7;
        arg2.terms_version = arg2.terms_version + 1;
        let v3 = TierTermsUpdated{
            tier_id              : 0x2::object::id<SubscriptionTier>(arg2),
            price                : arg3,
            accepted_coin_types  : arg2.accepted_coin_types,
            duration_count       : v1,
            duration_unit        : v2,
            terms_version        : arg2.terms_version,
            renewal_price_policy : arg7,
        };
        0x2::event::emit<TierTermsUpdated>(v3);
    }

    fun validated_tier_duration(arg0: u64, arg1: &vector<vector<u8>>, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u8>) : 0x1::option::Option<TierDuration> {
        assert_valid_accepted_coin_types(arg1);
        assert!(0x1::option::is_some<u64>(&arg2) == 0x1::option::is_some<u8>(&arg3), 54);
        if (0x1::option::is_none<u64>(&arg2)) {
            assert!(arg0 == 0, 46);
            0x1::option::none<TierDuration>()
        } else {
            let v1 = TierDuration{
                count : 0x1::option::destroy_some<u64>(arg2),
                unit  : 0x1::option::destroy_some<u8>(arg3),
            };
            assert!(v1.count > 0, 46);
            let v2 = duration_ms(&v1);
            assert!(v2 > 0, 46);
            assert!(v2 <= 315360000000, 46);
            0x1::option::some<TierDuration>(v1)
        }
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

