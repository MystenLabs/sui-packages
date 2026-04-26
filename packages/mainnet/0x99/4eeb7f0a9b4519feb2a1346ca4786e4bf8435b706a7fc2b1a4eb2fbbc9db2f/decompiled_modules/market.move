module 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::market {
    struct MARKET has drop {
        dummy_field: bool,
    }

    struct MarketAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MarketConfig has key {
        id: 0x2::object::UID,
        fee_recipient: address,
        platform_fee_bps: u16,
        paused: bool,
    }

    struct KioskRegistry has key {
        id: 0x2::object::UID,
    }

    struct MarketUpgradeState has key {
        id: 0x2::object::UID,
        tracked_package_id: 0x1::option::Option<0x2::object::ID>,
        tracked_upgrade_cap_id: 0x1::option::Option<0x2::object::ID>,
        tracked_upgrade_policy: u8,
        tracked_upgrade_version: u64,
        upgrade_cap_live: bool,
        immutable: bool,
        pending_upgrade: bool,
    }

    struct SoulListing has store, key {
        id: 0x2::object::UID,
        soul_id: 0x2::object::ID,
        state_id: 0x2::object::ID,
        seller: address,
        seller_kiosk_id: 0x2::object::ID,
        price: u64,
        creator: address,
        creator_royalty_bps: u16,
        collection_id: 0x1::option::Option<0x2::object::ID>,
        purchase_cap: 0x1::option::Option<0x2::kiosk::PurchaseCap<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::Soul>>,
        is_active: bool,
    }

    struct CollectionListing has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        right_id: 0x2::object::ID,
        seller: address,
        seller_kiosk_id: 0x2::object::ID,
        price: u64,
        purchase_cap: 0x1::option::Option<0x2::kiosk::PurchaseCap<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollectionRight>>,
        is_active: bool,
    }

    struct PersonalKioskOwnerKey has copy, drop, store {
        owner: address,
    }

    struct JoinedSourceKey has copy, drop, store {
        source_object_id: 0x2::object::ID,
    }

    struct PersonalKioskRegistration has copy, drop, store {
        kiosk_id: 0x2::object::ID,
        kiosk_cap_id: 0x2::object::ID,
    }

    struct SoulMarketProof has drop {
        dummy_field: bool,
    }

    struct CollectionMarketProof has drop {
        dummy_field: bool,
    }

    struct MarketInitialized has copy, drop {
        config_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        soul_policy_id: 0x2::object::ID,
        collection_policy_id: 0x2::object::ID,
        admin: address,
    }

    struct FeeRecipientUpdated has copy, drop {
        fee_recipient: address,
    }

    struct PlatformFeeBpsUpdated has copy, drop {
        fee_bps: u16,
    }

    struct MarketPauseUpdated has copy, drop {
        paused: bool,
    }

    struct PersonalKioskInitialized has copy, drop {
        kiosk_id: 0x2::object::ID,
        kiosk_cap_id: 0x2::object::ID,
        owner: address,
    }

    struct PersonalKioskRegistrationUpdated has copy, drop {
        kiosk_id: 0x2::object::ID,
        kiosk_cap_id: 0x2::object::ID,
        owner: address,
    }

    struct PersonalKioskRebound has copy, drop {
        owner: address,
        old_kiosk_id: 0x2::object::ID,
        old_kiosk_cap_id: 0x2::object::ID,
        new_kiosk_id: 0x2::object::ID,
        new_kiosk_cap_id: 0x2::object::ID,
    }

    struct MarketUpgradeStateInitialized has copy, drop {
        upgrade_state_id: 0x2::object::ID,
    }

    struct MarketUpgradeCapTracked has copy, drop {
        upgrade_state_id: 0x2::object::ID,
        package_id: 0x2::object::ID,
        upgrade_cap_id: 0x2::object::ID,
        policy: u8,
        version: u64,
    }

    struct MarketUpgradeAuthorized has copy, drop {
        upgrade_state_id: 0x2::object::ID,
        package_id: 0x2::object::ID,
        policy: u8,
    }

    struct MarketUpgradeCommitted has copy, drop {
        upgrade_state_id: 0x2::object::ID,
        from_package_id: 0x2::object::ID,
        to_package_id: 0x2::object::ID,
        version: u64,
    }

    struct MarketUpgradesFrozen has copy, drop {
        upgrade_state_id: 0x2::object::ID,
        package_id: 0x2::object::ID,
        version: u64,
    }

    struct SoulMintedToKiosk has copy, drop {
        soul_id: 0x2::object::ID,
        state_id: 0x2::object::ID,
        memory_id: 0x2::object::ID,
        metadata_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        owner: address,
        provenance_kind: u8,
    }

    struct SoulListed has copy, drop {
        listing_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        seller: address,
        kiosk_id: 0x2::object::ID,
        price: u64,
    }

    struct SoulListingCancelled has copy, drop {
        listing_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        seller: address,
    }

    struct SoulPurchased has copy, drop {
        listing_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
        platform_fee: u64,
        creator_royalty: u64,
        collection_royalty: u64,
    }

    struct CollectionMintedToKiosk has copy, drop {
        collection_id: 0x2::object::ID,
        right_id: 0x2::object::ID,
        owner: address,
        kiosk_id: 0x2::object::ID,
        tradeable: bool,
    }

    struct CollectionListed has copy, drop {
        listing_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        right_id: 0x2::object::ID,
        seller: address,
        kiosk_id: 0x2::object::ID,
        price: u64,
    }

    struct CollectionListingCancelled has copy, drop {
        listing_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        seller: address,
    }

    struct CollectionPurchased has copy, drop {
        listing_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        right_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
        platform_fee: u64,
    }

    struct ContentAccessPurchased has copy, drop {
        soul_id: 0x2::object::ID,
        access_list_id: 0x2::object::ID,
        buyer: address,
        price: u64,
        platform_fee: u64,
        payment_recipient: address,
    }

    struct SoulListingDeleted has copy, drop {
        listing_id: 0x2::object::ID,
        soul_id: 0x2::object::ID,
        seller: address,
        deleted_by: address,
    }

    struct CollectionListingDeleted has copy, drop {
        listing_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        seller: address,
        deleted_by: address,
    }

    public fun authorize_upgrade(arg0: &mut MarketUpgradeState, arg1: &MarketAdminCap, arg2: &mut 0x2::package::UpgradeCap, arg3: u8, arg4: vector<u8>) : 0x2::package::UpgradeTicket {
        assert!(!arg0.immutable, 22);
        assert!(arg0.upgrade_cap_live, 20);
        assert!(!arg0.pending_upgrade, 23);
        assert_tracked_upgrade_cap(arg0, 0x2::object::id<0x2::package::UpgradeCap>(arg2));
        let v0 = 0x2::package::authorize_upgrade(arg2, arg3, arg4);
        arg0.pending_upgrade = true;
        let v1 = MarketUpgradeAuthorized{
            upgrade_state_id : 0x2::object::id<MarketUpgradeState>(arg0),
            package_id       : 0x2::package::upgrade_package(arg2),
            policy           : 0x2::package::ticket_policy(&v0),
        };
        0x2::event::emit<MarketUpgradeAuthorized>(v1);
        v0
    }

    public fun commit_upgrade(arg0: &mut MarketUpgradeState, arg1: &MarketAdminCap, arg2: &mut 0x2::package::UpgradeCap, arg3: 0x2::package::UpgradeReceipt) {
        assert!(!arg0.immutable, 22);
        assert!(arg0.upgrade_cap_live, 20);
        assert!(arg0.pending_upgrade, 24);
        assert_tracked_upgrade_cap(arg0, 0x2::object::id<0x2::package::UpgradeCap>(arg2));
        0x2::package::commit_upgrade(arg2, arg3);
        let v0 = 0x2::package::upgrade_package(arg2);
        arg0.tracked_package_id = 0x1::option::some<0x2::object::ID>(v0);
        arg0.tracked_upgrade_policy = 0x2::package::upgrade_policy(arg2);
        arg0.tracked_upgrade_version = 0x2::package::version(arg2);
        arg0.pending_upgrade = false;
        let v1 = MarketUpgradeCommitted{
            upgrade_state_id : 0x2::object::id<MarketUpgradeState>(arg0),
            from_package_id  : *0x1::option::borrow<0x2::object::ID>(&arg0.tracked_package_id),
            to_package_id    : v0,
            version          : arg0.tracked_upgrade_version,
        };
        0x2::event::emit<MarketUpgradeCommitted>(v1);
    }

    fun assert_binding_matches_assets(arg0: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::AssetBinding, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::assets::SoulAssets, arg2: u8) {
        let v0 = *0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::asset_name(arg0);
        let v1 = 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::version_index(arg0);
        assert!(!0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::assets::version_is_deleted(arg1, v0, v1), 26);
        assert!(0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::assets::version_asset_type(arg1, v0, v1) == arg2, 26);
        if (0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::download_policy(arg0) == 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::download_policy_public()) {
            assert!(0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::assets::version_is_public(arg1, v0, v1), 26);
        } else {
            assert!(!0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::assets::version_is_public(arg1, v0, v1), 26);
        };
    }

    fun assert_registered_personal_kiosk(arg0: &KioskRegistry, arg1: address, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        let v0 = borrow_personal_kiosk_registration(arg0, arg1);
        assert!(v0.kiosk_id == arg2, 14);
        assert!(v0.kiosk_cap_id == arg3, 14);
    }

    fun assert_tracked_upgrade_cap(arg0: &MarketUpgradeState, arg1: 0x2::object::ID) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.tracked_upgrade_cap_id), 20);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.tracked_upgrade_cap_id) == arg1, 21);
    }

    fun borrow_personal_kiosk_registration(arg0: &KioskRegistry, arg1: address) : &PersonalKioskRegistration {
        let v0 = PersonalKioskOwnerKey{owner: arg1};
        assert!(0x2::dynamic_field::exists_<PersonalKioskOwnerKey>(&arg0.id, v0), 13);
        0x2::dynamic_field::borrow<PersonalKioskOwnerKey, PersonalKioskRegistration>(&arg0.id, v0)
    }

    fun bps_amount(arg0: u64, arg1: u16) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    public fun buy_collection_right_fixed_price(arg0: &MarketConfig, arg1: &KioskRegistry, arg2: &0x2::transfer_policy::TransferPolicy<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollectionRight>, arg3: &mut 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollection, arg4: &mut 0x2::kiosk::Kiosk, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg7: &mut CollectionListing, arg8: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 11);
        assert!(arg7.is_active, 3);
        assert!(arg7.collection_id == 0x2::object::id<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollection>(arg3), 15);
        assert!(arg7.right_id == 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::right_id(arg3), 16);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg4) == arg7.seller_kiosk_id, 4);
        assert!(0x2::kiosk::owner(arg4) == arg7.seller, 4);
        assert!(0x2::kiosk::has_access(arg5, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg6)), 8);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg5) == 0x2::tx_context::sender(arg9), 8);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::assert_tradeable(arg3);
        let v0 = 0x2::object::id<0x2::kiosk::Kiosk>(arg5);
        assert_registered_personal_kiosk(arg1, 0x2::tx_context::sender(arg9), v0, 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(arg6));
        let (v1, v2, v3) = quote_collection_purchase(arg0, arg7.price);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg8) == v3, 6);
        let v4 = take_collection_purchase_cap(arg7);
        let (v5, v6) = 0x2::kiosk::purchase_with_cap<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollectionRight>(arg4, v4, 0x2::coin::zero<0x2::sui::SUI>(arg9));
        let v7 = v6;
        let v8 = v5;
        assert!(0x2::object::id<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollectionRight>(&v8) == arg7.right_id, 16);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg8, v1, arg9), arg0.fee_recipient);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg8, arg7.seller);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::update_holder(arg3, 0x2::tx_context::sender(arg9), v0);
        0x2::kiosk::lock<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollectionRight>(arg5, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg6), arg2, v8);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollectionRight>(&mut v7, arg5);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::prove<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollectionRight>(arg5, &mut v7);
        let v9 = CollectionMarketProof{dummy_field: false};
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::witness_rule::prove<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollectionRight, CollectionMarketProof>(v9, arg2, &mut v7);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollectionRight>(arg2, v7);
        arg7.is_active = false;
        let v13 = CollectionPurchased{
            listing_id    : 0x2::object::id<CollectionListing>(arg7),
            collection_id : arg7.collection_id,
            right_id      : arg7.right_id,
            seller        : arg7.seller,
            buyer         : 0x2::tx_context::sender(arg9),
            price         : v2,
            platform_fee  : v1,
        };
        0x2::event::emit<CollectionPurchased>(v13);
    }

    public fun buy_soul_fixed_price(arg0: &MarketConfig, arg1: &KioskRegistry, arg2: &0x2::transfer_policy::TransferPolicy<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::Soul>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg6: &mut 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg7: &mut SoulListing, arg8: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = arg7.seller;
        assert!(0x1::option::is_none<0x2::object::ID>(&arg7.collection_id), 15);
        assert!(0x1::option::is_none<0x2::object::ID>(0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::collection_id(arg6)), 15);
        buy_soul_impl(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0, v0, arg9);
    }

    public fun buy_soul_fixed_price_with_collection(arg0: &MarketConfig, arg1: &KioskRegistry, arg2: &0x2::transfer_policy::TransferPolicy<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::Soul>, arg3: &mut 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollection, arg4: &mut 0x2::kiosk::Kiosk, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg7: &mut 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg8: &mut SoulListing, arg9: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollection>(arg3);
        assert!(0x1::option::contains<0x2::object::ID>(&arg8.collection_id, &v0), 15);
        assert!(0x1::option::contains<0x2::object::ID>(0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::collection_id(arg7), &v0), 15);
        buy_soul_impl(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8, arg9, 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::extra_royalty_bps(arg3), 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::current_holder(arg3), arg10);
    }

    fun buy_soul_impl(arg0: &MarketConfig, arg1: &KioskRegistry, arg2: &0x2::transfer_policy::TransferPolicy<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::Soul>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg6: &mut 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg7: &mut SoulListing, arg8: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg9: u16, arg10: address, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 11);
        assert!(arg7.is_active, 3);
        assert!(arg7.state_id == 0x2::object::id<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState>(arg6), 18);
        assert!(arg7.soul_id == 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg6), 18);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg3) == arg7.seller_kiosk_id, 4);
        assert!(0x2::kiosk::owner(arg3) == arg7.seller, 4);
        assert!(0x2::kiosk::has_access(arg4, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg5)), 8);
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::owner(arg4) == 0x2::tx_context::sender(arg11), 8);
        let v0 = 0x2::object::id<0x2::kiosk::Kiosk>(arg4);
        assert_registered_personal_kiosk(arg1, 0x2::tx_context::sender(arg11), v0, 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(arg5));
        let (v1, v2, v3, v4, v5) = quote_soul_purchase(arg0, arg7.price, arg7.creator_royalty_bps, arg9);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg8) == v5, 6);
        let v6 = take_soul_purchase_cap(arg7);
        let (v7, v8) = 0x2::kiosk::purchase_with_cap<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::Soul>(arg3, v6, 0x2::coin::zero<0x2::sui::SUI>(arg11));
        let v9 = v8;
        let v10 = v7;
        assert!(0x2::object::id<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::Soul>(&v10) == arg7.soul_id, 5);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg8, v1, arg11), arg0.fee_recipient);
        };
        if (v3 > 0 && arg7.creator != arg7.seller) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg8, v3, arg11), arg7.creator);
        };
        if (v4 > 0 && arg10 != arg7.seller) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg8, v4, arg11), arg10);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg8, arg7.seller);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::grant::invalidate_all_for_owner_rotation(arg6, 0x2::tx_context::sender(arg11), 0x2::tx_context::sender(arg11));
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::rotate_owner(arg6, 0x2::tx_context::sender(arg11), v0);
        0x2::kiosk::lock<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::Soul>(arg4, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg5), arg2, v10);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::Soul>(&mut v9, arg4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::prove<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::Soul>(arg4, &mut v9);
        let v11 = SoulMarketProof{dummy_field: false};
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::witness_rule::prove<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::Soul, SoulMarketProof>(v11, arg2, &mut v9);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::Soul>(arg2, v9);
        arg7.is_active = false;
        let v15 = SoulPurchased{
            listing_id         : 0x2::object::id<SoulListing>(arg7),
            soul_id            : arg7.soul_id,
            seller             : arg7.seller,
            buyer              : 0x2::tx_context::sender(arg11),
            price              : v2,
            platform_fee       : v1,
            creator_royalty    : v3,
            collection_royalty : v4,
        };
        0x2::event::emit<SoulPurchased>(v15);
    }

    public fun cancel_collection_listing(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg2: &mut CollectionListing) {
        assert!(arg2.is_active, 3);
        assert!(0x2::kiosk::has_access(arg0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg1)), 8);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg0) == arg2.seller_kiosk_id, 4);
        assert!(0x2::kiosk::owner(arg0) == arg2.seller, 8);
        let v0 = take_collection_purchase_cap(arg2);
        0x2::kiosk::return_purchase_cap<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollectionRight>(arg0, v0);
        arg2.is_active = false;
        let v1 = CollectionListingCancelled{
            listing_id    : 0x2::object::id<CollectionListing>(arg2),
            collection_id : arg2.collection_id,
            seller        : arg2.seller,
        };
        0x2::event::emit<CollectionListingCancelled>(v1);
    }

    public fun cancel_soul_listing(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg2: &mut SoulListing) {
        assert!(arg2.is_active, 3);
        assert!(0x2::kiosk::has_access(arg0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg1)), 8);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg0) == arg2.seller_kiosk_id, 4);
        assert!(0x2::kiosk::owner(arg0) == arg2.seller, 8);
        let v0 = take_soul_purchase_cap(arg2);
        0x2::kiosk::return_purchase_cap<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::Soul>(arg0, v0);
        arg2.is_active = false;
        let v1 = SoulListingCancelled{
            listing_id : 0x2::object::id<SoulListing>(arg2),
            soul_id    : arg2.soul_id,
            seller     : arg2.seller,
        };
        0x2::event::emit<SoulListingCancelled>(v1);
    }

    public fun clear_active_sprite(arg0: &mut 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::SoulMetadata, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: &0x2::tx_context::TxContext) {
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::clear_active_sprite(arg0, arg1, arg2);
    }

    public fun clear_active_voice(arg0: &mut 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::SoulMetadata, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: &0x2::tx_context::TxContext) {
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::clear_active_voice(arg0, arg1, arg2);
    }

    public fun create_collection_in_personal_kiosk(arg0: &MarketConfig, arg1: &KioskRegistry, arg2: &0x2::transfer_policy::TransferPolicy<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollectionRight>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u16, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!arg0.paused, 11);
        assert!(0x2::kiosk::has_access(arg3, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg4)), 8);
        let v0 = 0x2::kiosk::owner(arg3);
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg3);
        assert_registered_personal_kiosk(arg1, v0, v1, 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(arg4));
        let (v2, v3) = 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::create(arg5, arg6, arg7, arg8, arg9, v0, v1, arg10);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::object::id<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollection>(&v5);
        0x2::kiosk::lock<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollectionRight>(arg3, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg4), arg2, v4);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::share_collection(v5);
        let v7 = CollectionMintedToKiosk{
            collection_id : v6,
            right_id      : 0x2::object::id<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollectionRight>(&v4),
            owner         : v0,
            kiosk_id      : v1,
            tradeable     : arg9,
        };
        0x2::event::emit<CollectionMintedToKiosk>(v7);
        v6
    }

    fun create_collection_listing(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg2: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollection, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : CollectionListing {
        0x2::kiosk::borrow<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollectionRight>(arg0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg1), arg3);
        CollectionListing{
            id              : 0x2::object::new(arg5),
            collection_id   : 0x2::object::id<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollection>(arg2),
            right_id        : arg3,
            seller          : 0x2::kiosk::owner(arg0),
            seller_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            price           : arg4,
            purchase_cap    : 0x1::option::some<0x2::kiosk::PurchaseCap<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollectionRight>>(0x2::kiosk::list_with_purchase_cap<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollectionRight>(arg0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg1), arg3, 0, arg5)),
            is_active       : true,
        }
    }

    fun create_soul_listing(arg0: &MarketConfig, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg3: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg4: 0x2::object::ID, arg5: u64, arg6: 0x1::option::Option<0x2::object::ID>, arg7: u16, arg8: &mut 0x2::tx_context::TxContext) : SoulListing {
        assert!(arg5 > 0, 1);
        0x2::kiosk::borrow<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::Soul>(arg1, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg2), arg4);
        let (_, _, _, _, _) = quote_soul_purchase(arg0, arg5, 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::creator_royalty_bps(arg3), arg7);
        SoulListing{
            id                  : 0x2::object::new(arg8),
            soul_id             : arg4,
            state_id            : 0x2::object::id<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState>(arg3),
            seller              : 0x2::kiosk::owner(arg1),
            seller_kiosk_id     : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            price               : arg5,
            creator             : 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::state_creator(arg3),
            creator_royalty_bps : 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::creator_royalty_bps(arg3),
            collection_id       : arg6,
            purchase_cap        : 0x1::option::some<0x2::kiosk::PurchaseCap<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::Soul>>(0x2::kiosk::list_with_purchase_cap<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::Soul>(arg1, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg2), arg4, 0, arg8)),
            is_active           : true,
        }
    }

    public fun delete_collection_listing(arg0: CollectionListing, arg1: &0x2::tx_context::TxContext) {
        assert!(!arg0.is_active, 30);
        let CollectionListing {
            id              : v0,
            collection_id   : v1,
            right_id        : _,
            seller          : v3,
            seller_kiosk_id : _,
            price           : _,
            purchase_cap    : v6,
            is_active       : _,
        } = arg0;
        0x1::option::destroy_none<0x2::kiosk::PurchaseCap<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollectionRight>>(v6);
        0x2::object::delete(v0);
        let v8 = CollectionListingDeleted{
            listing_id    : 0x2::object::id<CollectionListing>(&arg0),
            collection_id : v1,
            seller        : v3,
            deleted_by    : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<CollectionListingDeleted>(v8);
    }

    public fun delete_soul_listing(arg0: SoulListing, arg1: &0x2::tx_context::TxContext) {
        assert!(!arg0.is_active, 30);
        let SoulListing {
            id                  : v0,
            soul_id             : v1,
            state_id            : _,
            seller              : v3,
            seller_kiosk_id     : _,
            price               : _,
            creator             : _,
            creator_royalty_bps : _,
            collection_id       : _,
            purchase_cap        : v9,
            is_active           : _,
        } = arg0;
        0x1::option::destroy_none<0x2::kiosk::PurchaseCap<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::Soul>>(v9);
        0x2::object::delete(v0);
        let v11 = SoulListingDeleted{
            listing_id : 0x2::object::id<SoulListing>(&arg0),
            soul_id    : v1,
            seller     : v3,
            deleted_by : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<SoulListingDeleted>(v11);
    }

    public fun ensure_personal_kiosk_registered(arg0: &MarketConfig, arg1: &mut KioskRegistry, arg2: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 11);
        insert_or_assert_personal_kiosk_registration(arg1, 0x2::tx_context::sender(arg3), 0x2::kiosk::kiosk_owner_cap_for(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg2)), 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(arg2));
    }

    public fun fee_recipient(arg0: &MarketConfig) : address {
        arg0.fee_recipient
    }

    public fun freeze_upgrades(arg0: &mut MarketUpgradeState, arg1: &MarketAdminCap, arg2: 0x2::package::UpgradeCap) {
        assert!(!arg0.immutable, 22);
        assert!(arg0.upgrade_cap_live, 20);
        assert!(!arg0.pending_upgrade, 23);
        assert_tracked_upgrade_cap(arg0, 0x2::object::id<0x2::package::UpgradeCap>(&arg2));
        let v0 = 0x2::package::upgrade_package(&arg2);
        let v1 = 0x2::package::version(&arg2);
        0x2::package::make_immutable(arg2);
        arg0.tracked_package_id = 0x1::option::some<0x2::object::ID>(v0);
        arg0.tracked_upgrade_version = v1;
        arg0.upgrade_cap_live = false;
        arg0.immutable = true;
        let v2 = MarketUpgradesFrozen{
            upgrade_state_id : 0x2::object::id<MarketUpgradeState>(arg0),
            package_id       : v0,
            version          : v1,
        };
        0x2::event::emit<MarketUpgradesFrozen>(v2);
    }

    public fun has_tracked_upgrade_cap(arg0: &MarketUpgradeState) : bool {
        0x1::option::is_some<0x2::object::ID>(&arg0.tracked_upgrade_cap_id)
    }

    fun init(arg0: MARKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<MARKET>(arg0, arg1);
        let v1 = 0x2::tx_context::sender(arg1);
        init_impl(v0, v1, arg1);
    }

    fun init_impl(arg0: 0x2::package::Publisher, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::Soul>(&arg0, arg2);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0x2::transfer_policy::new<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollectionRight>(&arg0, arg2);
        let v6 = v5;
        let v7 = v4;
        let v8 = MarketConfig{
            id               : 0x2::object::new(arg2),
            fee_recipient    : arg1,
            platform_fee_bps : 250,
            paused           : false,
        };
        let v9 = KioskRegistry{id: 0x2::object::new(arg2)};
        let v10 = MarketUpgradeState{
            id                      : 0x2::object::new(arg2),
            tracked_package_id      : 0x1::option::none<0x2::object::ID>(),
            tracked_upgrade_cap_id  : 0x1::option::none<0x2::object::ID>(),
            tracked_upgrade_policy  : 0x2::package::compatible_policy(),
            tracked_upgrade_version : 0,
            upgrade_cap_live        : false,
            immutable               : false,
            pending_upgrade         : false,
        };
        let v11 = MarketAdminCap{id: 0x2::object::new(arg2)};
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::Soul>(&mut v3, &v2);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::add<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::Soul>(&mut v3, &v2);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::witness_rule::add<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::Soul, SoulMarketProof>(&mut v3, &v2);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollectionRight>(&mut v7, &v6);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::add<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollectionRight>(&mut v7, &v6);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::witness_rule::add<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollectionRight, CollectionMarketProof>(&mut v7, &v6);
        0x2::transfer::share_object<MarketConfig>(v8);
        0x2::transfer::share_object<KioskRegistry>(v9);
        0x2::transfer::share_object<MarketUpgradeState>(v10);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::Soul>>(v3);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollectionRight>>(v7);
        0x2::transfer::transfer<MarketAdminCap>(v11, arg1);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::Soul>>(v2, arg1);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollectionRight>>(v6, arg1);
        0x2::package::burn_publisher(arg0);
        let v12 = MarketInitialized{
            config_id            : 0x2::object::id<MarketConfig>(&v8),
            registry_id          : 0x2::object::id<KioskRegistry>(&v9),
            soul_policy_id       : 0x2::object::id<0x2::transfer_policy::TransferPolicy<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::Soul>>(&v3),
            collection_policy_id : 0x2::object::id<0x2::transfer_policy::TransferPolicy<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollectionRight>>(&v7),
            admin                : arg1,
        };
        0x2::event::emit<MarketInitialized>(v12);
        let v13 = MarketUpgradeStateInitialized{upgrade_state_id: 0x2::object::id<MarketUpgradeState>(&v10)};
        0x2::event::emit<MarketUpgradeStateInitialized>(v13);
    }

    public fun init_personal_kiosk(arg0: &MarketConfig, arg1: &mut KioskRegistry, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!arg0.paused, 11);
        let (v0, v1) = 0x2::kiosk::new(arg2);
        let v2 = v0;
        let v3 = 0x2::object::id<0x2::kiosk::Kiosk>(&v2);
        let v4 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v2, v1, arg2);
        let v5 = 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(&v4);
        let v6 = 0x2::tx_context::sender(arg2);
        register_personal_kiosk(arg1, v6, v3, v5);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(v4, arg2);
        let v7 = PersonalKioskInitialized{
            kiosk_id     : v3,
            kiosk_cap_id : v5,
            owner        : v6,
        };
        0x2::event::emit<PersonalKioskInitialized>(v7);
        v3
    }

    fun insert_or_assert_personal_kiosk_registration(arg0: &mut KioskRegistry, arg1: address, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        let v0 = PersonalKioskOwnerKey{owner: arg1};
        if (0x2::dynamic_field::exists_<PersonalKioskOwnerKey>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_field::borrow<PersonalKioskOwnerKey, PersonalKioskRegistration>(&arg0.id, v0);
            assert!(v1.kiosk_id == arg2, 14);
            assert!(v1.kiosk_cap_id == arg3, 14);
        } else {
            let v2 = PersonalKioskRegistration{
                kiosk_id     : arg2,
                kiosk_cap_id : arg3,
            };
            0x2::dynamic_field::add<PersonalKioskOwnerKey, PersonalKioskRegistration>(&mut arg0.id, v0, v2);
            let v3 = PersonalKioskRegistrationUpdated{
                kiosk_id     : arg2,
                kiosk_cap_id : arg3,
                owner        : arg1,
            };
            0x2::event::emit<PersonalKioskRegistrationUpdated>(v3);
        };
    }

    public fun list_collection_right_fixed_price(arg0: &MarketConfig, arg1: &KioskRegistry, arg2: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollection, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg5: 0x2::object::ID, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!arg0.paused, 11);
        assert!(arg6 > 0, 1);
        assert!(0x2::kiosk::has_access(arg3, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg4)), 8);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::assert_tradeable(arg2);
        assert!(0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::current_holder(arg2) == 0x2::tx_context::sender(arg7), 8);
        assert!(0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::current_holder_kiosk_id(arg2) == 0x2::object::id<0x2::kiosk::Kiosk>(arg3), 15);
        assert!(arg5 == 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::right_id(arg2), 16);
        let v0 = 0x2::kiosk::owner(arg3);
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg3);
        assert_registered_personal_kiosk(arg1, v0, v1, 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(arg4));
        let v2 = create_collection_listing(arg3, arg4, arg2, arg5, arg6, arg7);
        let v3 = 0x2::object::id<CollectionListing>(&v2);
        0x2::transfer::share_object<CollectionListing>(v2);
        let v4 = CollectionListed{
            listing_id    : v3,
            collection_id : 0x2::object::id<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollection>(arg2),
            right_id      : arg5,
            seller        : v0,
            kiosk_id      : v1,
            price         : arg6,
        };
        0x2::event::emit<CollectionListed>(v4);
        v3
    }

    public fun list_soul_fixed_price(arg0: &MarketConfig, arg1: &KioskRegistry, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg5: 0x2::object::ID, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!arg0.paused, 11);
        assert!(0x2::kiosk::has_access(arg2, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg3)), 8);
        assert!(0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg4) == arg5, 18);
        assert!(0x1::option::is_none<0x2::object::ID>(0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::collection_id(arg4)), 15);
        assert!(0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::current_owner(arg4) == 0x2::tx_context::sender(arg7), 8);
        assert!(0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::current_kiosk_id(arg4) == 0x2::object::id<0x2::kiosk::Kiosk>(arg2), 14);
        let v0 = 0x2::kiosk::owner(arg2);
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg2);
        assert_registered_personal_kiosk(arg1, v0, v1, 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(arg3));
        let v2 = create_soul_listing(arg0, arg2, arg3, arg4, arg5, arg6, 0x1::option::none<0x2::object::ID>(), 0, arg7);
        let v3 = 0x2::object::id<SoulListing>(&v2);
        0x2::transfer::share_object<SoulListing>(v2);
        let v4 = SoulListed{
            listing_id : v3,
            soul_id    : arg5,
            seller     : v0,
            kiosk_id   : v1,
            price      : arg6,
        };
        0x2::event::emit<SoulListed>(v4);
        v3
    }

    public fun list_soul_fixed_price_with_collection(arg0: &MarketConfig, arg1: &KioskRegistry, arg2: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollection, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg5: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg6: 0x2::object::ID, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!arg0.paused, 11);
        assert!(0x2::kiosk::has_access(arg3, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg4)), 8);
        assert!(0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg5) == arg6, 18);
        let v0 = 0x2::object::id<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollection>(arg2);
        assert!(0x1::option::contains<0x2::object::ID>(0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::collection_id(arg5), &v0), 15);
        assert!(0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::current_owner(arg5) == 0x2::tx_context::sender(arg8), 8);
        assert!(0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::current_kiosk_id(arg5) == 0x2::object::id<0x2::kiosk::Kiosk>(arg3), 14);
        let v1 = 0x2::kiosk::owner(arg3);
        let v2 = 0x2::object::id<0x2::kiosk::Kiosk>(arg3);
        assert_registered_personal_kiosk(arg1, v1, v2, 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(arg4));
        let v3 = create_soul_listing(arg0, arg3, arg4, arg5, arg6, arg7, 0x1::option::some<0x2::object::ID>(v0), 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::extra_royalty_bps(arg2), arg8);
        let v4 = 0x2::object::id<SoulListing>(&v3);
        0x2::transfer::share_object<SoulListing>(v3);
        let v5 = SoulListed{
            listing_id : v4,
            soul_id    : arg6,
            seller     : v1,
            kiosk_id   : v2,
            price      : arg7,
        };
        0x2::event::emit<SoulListed>(v5);
        v4
    }

    public fun mint_imported_in_personal_kiosk(arg0: &MarketConfig, arg1: &KioskRegistry, arg2: &0x2::transfer_policy::TransferPolicy<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::Soul>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg9: 0x1::option::Option<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>, arg10: 0x1::option::Option<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>, arg11: 0x1::string::String, arg12: bool, arg13: 0x1::option::Option<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>, arg14: 0x1::string::String, arg15: bool, arg16: u8, arg17: 0x1::option::Option<0x1::string::String>, arg18: 0x1::option::Option<u64>, arg19: 0x1::option::Option<u8>, arg20: 0x1::option::Option<vector<u8>>, arg21: 0x1::option::Option<vector<u8>>, arg22: 0x1::option::Option<0x1::string::String>, arg23: 0x1::option::Option<u64>, arg24: 0x1::option::Option<u8>, arg25: 0x1::option::Option<vector<u8>>, arg26: u64, arg27: u64, arg28: 0x1::option::Option<u64>, arg29: 0x1::string::String, arg30: u16, arg31: &0x2::clock::Clock, arg32: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        mint_soul_in_personal_kiosk_impl(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27, arg28, arg30, 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::provenance_imported(), 0x1::option::some<0x1::string::String>(arg29), arg31, arg32)
    }

    public fun mint_joined_in_personal_kiosk<T0: store + key>(arg0: &MarketConfig, arg1: &mut KioskRegistry, arg2: &0x2::transfer_policy::TransferPolicy<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::Soul>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg5: 0x2::object::ID, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg10: 0x1::option::Option<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>, arg11: 0x1::option::Option<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>, arg12: 0x1::string::String, arg13: bool, arg14: 0x1::option::Option<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>, arg15: 0x1::string::String, arg16: bool, arg17: u8, arg18: 0x1::option::Option<0x1::string::String>, arg19: 0x1::option::Option<u64>, arg20: 0x1::option::Option<u8>, arg21: 0x1::option::Option<vector<u8>>, arg22: 0x1::option::Option<vector<u8>>, arg23: 0x1::option::Option<0x1::string::String>, arg24: 0x1::option::Option<u64>, arg25: 0x1::option::Option<u8>, arg26: 0x1::option::Option<vector<u8>>, arg27: u64, arg28: u64, arg29: 0x1::option::Option<u64>, arg30: 0x1::string::String, arg31: u16, arg32: &0x2::clock::Clock, arg33: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::kiosk::has_item_with_type<T0>(arg3, arg5), 15);
        let v0 = JoinedSourceKey{source_object_id: arg5};
        assert!(!0x2::dynamic_field::exists_<JoinedSourceKey>(&arg1.id, v0), 25);
        0x2::dynamic_field::add<JoinedSourceKey, bool>(&mut arg1.id, v0, true);
        mint_soul_in_personal_kiosk_impl(arg0, arg1, arg2, arg3, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27, arg28, arg29, arg31, 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::provenance_personal_join(), 0x1::option::some<0x1::string::String>(arg30), arg32, arg33)
    }

    public fun mint_native_in_personal_kiosk(arg0: &MarketConfig, arg1: &KioskRegistry, arg2: &0x2::transfer_policy::TransferPolicy<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::Soul>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg9: 0x1::option::Option<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>, arg10: 0x1::option::Option<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>, arg11: 0x1::string::String, arg12: bool, arg13: 0x1::option::Option<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>, arg14: 0x1::string::String, arg15: bool, arg16: u8, arg17: 0x1::option::Option<0x1::string::String>, arg18: 0x1::option::Option<u64>, arg19: 0x1::option::Option<u8>, arg20: 0x1::option::Option<vector<u8>>, arg21: 0x1::option::Option<vector<u8>>, arg22: 0x1::option::Option<0x1::string::String>, arg23: 0x1::option::Option<u64>, arg24: 0x1::option::Option<u8>, arg25: 0x1::option::Option<vector<u8>>, arg26: u64, arg27: u64, arg28: 0x1::option::Option<u64>, arg29: u16, arg30: &0x2::clock::Clock, arg31: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        mint_soul_in_personal_kiosk_impl(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23, arg24, arg25, arg26, arg27, arg28, arg29, 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::provenance_native(), 0x1::option::none<0x1::string::String>(), arg30, arg31)
    }

    fun mint_soul_in_personal_kiosk_impl(arg0: &MarketConfig, arg1: &KioskRegistry, arg2: &0x2::transfer_policy::TransferPolicy<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::Soul>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg9: 0x1::option::Option<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>, arg10: 0x1::option::Option<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>, arg11: 0x1::string::String, arg12: bool, arg13: 0x1::option::Option<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>, arg14: 0x1::string::String, arg15: bool, arg16: u8, arg17: 0x1::option::Option<0x1::string::String>, arg18: 0x1::option::Option<u64>, arg19: 0x1::option::Option<u8>, arg20: 0x1::option::Option<vector<u8>>, arg21: 0x1::option::Option<vector<u8>>, arg22: 0x1::option::Option<0x1::string::String>, arg23: 0x1::option::Option<u64>, arg24: 0x1::option::Option<u8>, arg25: 0x1::option::Option<vector<u8>>, arg26: u64, arg27: u64, arg28: 0x1::option::Option<u64>, arg29: u16, arg30: u8, arg31: 0x1::option::Option<0x1::string::String>, arg32: &0x2::clock::Clock, arg33: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!arg0.paused, 11);
        assert!(0x2::kiosk::has_access(arg3, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg4)), 8);
        let v0 = 0x2::kiosk::owner(arg3);
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg3);
        assert_registered_personal_kiosk(arg1, v0, v1, 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(arg4));
        let v2 = 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::mint(arg5, arg6, arg7, arg8, v0, arg29, arg30, arg31, arg33);
        let v3 = 0x2::object::id<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::Soul>(&v2);
        let v4 = 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::memory::create(v3, arg33);
        let v5 = 0x2::object::id<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::memory::SoulMemory>(&v4);
        let v6 = 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::create_state(v3, v0, arg29, v0, v1, 0x1::option::some<0x2::object::ID>(v5), arg33);
        let v7 = 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::create(v3, arg33);
        let v8 = 0x2::object::id<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::SoulMetadata>(&v7);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::set_metadata_id(&mut v6, v8);
        if (0x1::option::is_some<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg9)) {
            0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::memory::append_founding(&mut v4, v0, 0x1::option::extract<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut arg9), arg32, arg33);
        };
        0x1::option::destroy_none<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(arg9);
        if (0x1::option::is_some<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg10)) {
            let v9 = 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::skills::create(v3, arg33);
            0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::skills::append_initial_version(&mut v9, arg11, arg12, 0x1::option::extract<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut arg10), arg32, arg33);
            0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::set_skills_id(&mut v6, 0x2::object::id<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::skills::SoulSkills>(&v9));
            0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::skills::share_skills(v9);
        };
        0x1::option::destroy_none<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(arg10);
        let v10 = resolve_initial_binding(arg17, arg18, arg19);
        let v11 = resolve_initial_binding(arg22, arg23, arg24);
        if (0x1::option::is_some<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg13)) {
            let v12 = 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::assets::create(v3, arg33);
            0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::assets::append_initial_version(&mut v12, arg14, arg15, arg16, 0x1::option::extract<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut arg13), arg32, arg33);
            if (0x1::option::is_some<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::AssetBinding>(&v10)) {
                let v13 = 0x1::option::extract<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::AssetBinding>(&mut v10);
                assert_binding_matches_assets(&v13, &v12, 0);
                0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::set_active_sprite(&mut v7, &v6, 0x1::option::some<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::AssetBinding>(v13), arg33);
            };
            if (0x1::option::is_some<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::AssetBinding>(&v11)) {
                let v14 = 0x1::option::extract<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::AssetBinding>(&mut v11);
                assert_binding_matches_assets(&v14, &v12, 2);
                0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::set_active_voice(&mut v7, &v6, 0x1::option::some<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::AssetBinding>(v14), arg33);
            };
            0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::set_assets_id(&mut v6, 0x2::object::id<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::assets::SoulAssets>(&v12));
            0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::assets::share_assets(v12);
        } else {
            assert!(0x1::option::is_none<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::AssetBinding>(&v10), 27);
            assert!(0x1::option::is_none<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::AssetBinding>(&v11), 27);
        };
        0x1::option::destroy_none<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(arg13);
        0x1::option::destroy_none<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::AssetBinding>(v10);
        0x1::option::destroy_none<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::AssetBinding>(v11);
        let v15 = 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::content_access::create(v3, 0x2::tx_context::sender(arg33), arg26, arg27, arg28, arg33);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::set_access_list_id(&mut v6, 0x2::object::id<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::content_access::ContentAccessList>(&v15));
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::content_access::share_access_list(v15);
        let v16 = &mut v7;
        upsert_initial_metadata_blobs(v16, &v6, arg20, arg21, arg25, arg33);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::share_metadata(v7);
        0x2::kiosk::lock<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::Soul>(arg3, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg4), arg2, v2);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::emit_created(&v6, arg30);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::share_state(v6);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::memory::share_memory(v4);
        let v17 = SoulMintedToKiosk{
            soul_id         : v3,
            state_id        : 0x2::object::id<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState>(&v6),
            memory_id       : v5,
            metadata_id     : v8,
            kiosk_id        : v1,
            owner           : v0,
            provenance_kind : arg30,
        };
        0x2::event::emit<SoulMintedToKiosk>(v17);
        v3
    }

    public fun paused(arg0: &MarketConfig) : bool {
        arg0.paused
    }

    public fun platform_fee_bps(arg0: &MarketConfig) : u16 {
        arg0.platform_fee_bps
    }

    public fun purchase_content_access(arg0: &MarketConfig, arg1: &mut 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::content_access::ContentAccessList, arg2: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg3: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 11);
        assert!(0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::content_access::soul_id(arg1) == 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg2), 19);
        let v0 = 0x2::object::id<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::content_access::ContentAccessList>(arg1);
        assert!(0x1::option::contains<0x2::object::ID>(0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::access_list_id(arg2), &v0), 29);
        let v1 = 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::content_access::price_atomic(arg1);
        assert!(v1 > 0, 28);
        let (v2, _, v4) = quote_content_access_purchase(arg0, v1);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg3) == v4, 6);
        let v5 = 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::current_owner(arg2);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg3, v2, arg5), arg0.fee_recipient);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg3, v5);
        let v6 = 0x2::tx_context::sender(arg5);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::content_access::record_purchase(arg1, arg2, v6, v1, arg4);
        let v7 = ContentAccessPurchased{
            soul_id           : 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg2),
            access_list_id    : 0x2::object::id<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::content_access::ContentAccessList>(arg1),
            buyer             : v6,
            price             : v1,
            platform_fee      : v2,
            payment_recipient : v5,
        };
        0x2::event::emit<ContentAccessPurchased>(v7);
    }

    public fun quote_collection_purchase(arg0: &MarketConfig, arg1: u64) : (u64, u64, u64) {
        let v0 = bps_amount(arg1, arg0.platform_fee_bps);
        let v1 = (arg1 as u128) + (v0 as u128);
        assert!(v1 <= 18446744073709551615, 9);
        (v0, arg1, (v1 as u64))
    }

    public fun quote_content_access_purchase(arg0: &MarketConfig, arg1: u64) : (u64, u64, u64) {
        let v0 = bps_amount(arg1, arg0.platform_fee_bps);
        let v1 = (arg1 as u128) + (v0 as u128);
        assert!(v1 <= 18446744073709551615, 9);
        (v0, arg1, (v1 as u64))
    }

    public fun quote_soul_purchase(arg0: &MarketConfig, arg1: u64, arg2: u16, arg3: u16) : (u64, u64, u64, u64, u64) {
        assert!((arg0.platform_fee_bps as u64) + (arg2 as u64) + (arg3 as u64) <= (10000 as u64), 10);
        let v0 = bps_amount(arg1, arg0.platform_fee_bps);
        let v1 = bps_amount(arg1, arg2);
        let v2 = bps_amount(arg1, arg3);
        let v3 = (arg1 as u128) + (v0 as u128) + (v1 as u128) + (v2 as u128);
        assert!(v3 <= 18446744073709551615, 9);
        (v0, arg1, v1, v2, (v3 as u64))
    }

    public fun rebind_primary_kiosk(arg0: &MarketConfig, arg1: &mut KioskRegistry, arg2: &0x2::kiosk::Kiosk, arg3: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg4: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 11);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg2);
        let v2 = 0x2::kiosk::kiosk_owner_cap_for(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg3));
        let v3 = 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(arg3);
        assert!(v1 != v2, 33);
        assert!(0x2::kiosk::item_count(arg2) == 0, 31);
        let v4 = PersonalKioskOwnerKey{owner: v0};
        assert!(0x2::dynamic_field::exists_<PersonalKioskOwnerKey>(&arg1.id, v4), 13);
        let v5 = 0x2::dynamic_field::borrow_mut<PersonalKioskOwnerKey, PersonalKioskRegistration>(&mut arg1.id, v4);
        assert!(v5.kiosk_id == v1, 32);
        v5.kiosk_id = v2;
        v5.kiosk_cap_id = v3;
        let v6 = PersonalKioskRebound{
            owner            : v0,
            old_kiosk_id     : v1,
            old_kiosk_cap_id : v5.kiosk_cap_id,
            new_kiosk_id     : v2,
            new_kiosk_cap_id : v3,
        };
        0x2::event::emit<PersonalKioskRebound>(v6);
    }

    public fun register_existing_personal_kiosk(arg0: &MarketConfig, arg1: &mut KioskRegistry, arg2: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 11);
        insert_or_assert_personal_kiosk_registration(arg1, 0x2::tx_context::sender(arg3), 0x2::kiosk::kiosk_owner_cap_for(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg2)), 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(arg2));
    }

    fun register_personal_kiosk(arg0: &mut KioskRegistry, arg1: address, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        let v0 = PersonalKioskOwnerKey{owner: arg1};
        assert!(!0x2::dynamic_field::exists_<PersonalKioskOwnerKey>(&arg0.id, v0), 12);
        let v1 = PersonalKioskRegistration{
            kiosk_id     : arg2,
            kiosk_cap_id : arg3,
        };
        0x2::dynamic_field::add<PersonalKioskOwnerKey, PersonalKioskRegistration>(&mut arg0.id, v0, v1);
    }

    fun resolve_initial_binding(arg0: 0x1::option::Option<0x1::string::String>, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u8>) : 0x1::option::Option<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::AssetBinding> {
        let v0 = 0x1::option::is_some<0x1::string::String>(&arg0);
        let v1 = 0x1::option::is_some<u64>(&arg1);
        let v2 = 0x1::option::is_some<u8>(&arg2);
        let v3 = if (!v0) {
            if (!v1) {
                !v2
            } else {
                false
            }
        } else {
            false
        };
        if (v3) {
            0x1::option::destroy_none<0x1::string::String>(arg0);
            0x1::option::destroy_none<u64>(arg1);
            0x1::option::destroy_none<u8>(arg2);
            return 0x1::option::none<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::AssetBinding>()
        };
        let v4 = if (v0) {
            if (v1) {
                v2
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, 26);
        0x1::option::some<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::AssetBinding>(0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::new_asset_binding(0x1::option::destroy_some<0x1::string::String>(arg0), 0x1::option::destroy_some<u64>(arg1), 0x1::option::destroy_some<u8>(arg2)))
    }

    public fun restrict_upgrade_policy_additive(arg0: &mut MarketUpgradeState, arg1: &MarketAdminCap, arg2: &mut 0x2::package::UpgradeCap) {
        assert!(!arg0.immutable, 22);
        assert!(arg0.upgrade_cap_live, 20);
        assert!(!arg0.pending_upgrade, 23);
        assert_tracked_upgrade_cap(arg0, 0x2::object::id<0x2::package::UpgradeCap>(arg2));
        0x2::package::only_additive_upgrades(arg2);
        arg0.tracked_package_id = 0x1::option::some<0x2::object::ID>(0x2::package::upgrade_package(arg2));
        arg0.tracked_upgrade_policy = 0x2::package::upgrade_policy(arg2);
        arg0.tracked_upgrade_version = 0x2::package::version(arg2);
        let v0 = MarketUpgradeCapTracked{
            upgrade_state_id : 0x2::object::id<MarketUpgradeState>(arg0),
            package_id       : 0x2::package::upgrade_package(arg2),
            upgrade_cap_id   : 0x2::object::id<0x2::package::UpgradeCap>(arg2),
            policy           : arg0.tracked_upgrade_policy,
            version          : 0x2::package::version(arg2),
        };
        0x2::event::emit<MarketUpgradeCapTracked>(v0);
    }

    public fun restrict_upgrade_policy_dep_only(arg0: &mut MarketUpgradeState, arg1: &MarketAdminCap, arg2: &mut 0x2::package::UpgradeCap) {
        assert!(!arg0.immutable, 22);
        assert!(arg0.upgrade_cap_live, 20);
        assert!(!arg0.pending_upgrade, 23);
        assert_tracked_upgrade_cap(arg0, 0x2::object::id<0x2::package::UpgradeCap>(arg2));
        0x2::package::only_dep_upgrades(arg2);
        arg0.tracked_package_id = 0x1::option::some<0x2::object::ID>(0x2::package::upgrade_package(arg2));
        arg0.tracked_upgrade_policy = 0x2::package::upgrade_policy(arg2);
        arg0.tracked_upgrade_version = 0x2::package::version(arg2);
        let v0 = MarketUpgradeCapTracked{
            upgrade_state_id : 0x2::object::id<MarketUpgradeState>(arg0),
            package_id       : 0x2::package::upgrade_package(arg2),
            upgrade_cap_id   : 0x2::object::id<0x2::package::UpgradeCap>(arg2),
            policy           : arg0.tracked_upgrade_policy,
            version          : 0x2::package::version(arg2),
        };
        0x2::event::emit<MarketUpgradeCapTracked>(v0);
    }

    public fun reuse_personal_kiosk(arg0: &KioskRegistry, arg1: 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::kiosk::kiosk_owner_cap_for(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(&arg1));
        assert_registered_personal_kiosk(arg0, 0x2::tx_context::sender(arg2), v0, 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(&arg1));
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(arg1, arg2);
        v0
    }

    public fun set_active_sprite(arg0: &mut 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::SoulMetadata, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::assets::SoulAssets, arg3: 0x1::string::String, arg4: u64, arg5: u8, arg6: &0x2::tx_context::TxContext) {
        let v0 = 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::new_asset_binding(arg3, arg4, arg5);
        assert_binding_matches_assets(&v0, arg2, 0);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::set_active_sprite(arg0, arg1, 0x1::option::some<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::AssetBinding>(v0), arg6);
    }

    public fun set_active_voice(arg0: &mut 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::SoulMetadata, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::assets::SoulAssets, arg3: 0x1::string::String, arg4: u64, arg5: u8, arg6: &0x2::tx_context::TxContext) {
        let v0 = 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::new_asset_binding(arg3, arg4, arg5);
        assert_binding_matches_assets(&v0, arg2, 2);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::set_active_voice(arg0, arg1, 0x1::option::some<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::AssetBinding>(v0), arg6);
    }

    fun take_collection_purchase_cap(arg0: &mut CollectionListing) : 0x2::kiosk::PurchaseCap<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollectionRight> {
        assert!(0x1::option::is_some<0x2::kiosk::PurchaseCap<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollectionRight>>(&arg0.purchase_cap), 7);
        0x1::option::extract<0x2::kiosk::PurchaseCap<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::collection::SoulCollectionRight>>(&mut arg0.purchase_cap)
    }

    fun take_soul_purchase_cap(arg0: &mut SoulListing) : 0x2::kiosk::PurchaseCap<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::Soul> {
        assert!(0x1::option::is_some<0x2::kiosk::PurchaseCap<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::Soul>>(&arg0.purchase_cap), 7);
        0x1::option::extract<0x2::kiosk::PurchaseCap<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::Soul>>(&mut arg0.purchase_cap)
    }

    public fun track_upgrade_cap(arg0: &mut MarketUpgradeState, arg1: &MarketAdminCap, arg2: &0x2::package::UpgradeCap) {
        assert!(!arg0.immutable, 22);
        assert!(!arg0.pending_upgrade, 23);
        let v0 = 0x2::package::upgrade_package(arg2);
        assert!(0x2::object::id_to_address(&v0) != @0x0, 0);
        let v1 = 0x2::object::id<0x2::package::UpgradeCap>(arg2);
        if (0x1::option::is_some<0x2::object::ID>(&arg0.tracked_upgrade_cap_id)) {
            assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.tracked_upgrade_cap_id) == v1, 21);
        };
        arg0.tracked_package_id = 0x1::option::some<0x2::object::ID>(v0);
        arg0.tracked_upgrade_cap_id = 0x1::option::some<0x2::object::ID>(v1);
        arg0.tracked_upgrade_policy = 0x2::package::upgrade_policy(arg2);
        arg0.tracked_upgrade_version = 0x2::package::version(arg2);
        arg0.upgrade_cap_live = true;
        let v2 = MarketUpgradeCapTracked{
            upgrade_state_id : 0x2::object::id<MarketUpgradeState>(arg0),
            package_id       : v0,
            upgrade_cap_id   : v1,
            policy           : arg0.tracked_upgrade_policy,
            version          : arg0.tracked_upgrade_version,
        };
        0x2::event::emit<MarketUpgradeCapTracked>(v2);
    }

    public fun tracked_package_id(arg0: &MarketUpgradeState) : 0x1::option::Option<0x2::object::ID> {
        arg0.tracked_package_id
    }

    public fun tracked_upgrade_policy(arg0: &MarketUpgradeState) : u8 {
        arg0.tracked_upgrade_policy
    }

    public fun tracked_upgrade_version(arg0: &MarketUpgradeState) : u64 {
        arg0.tracked_upgrade_version
    }

    public fun update_fee_recipient(arg0: &mut MarketConfig, arg1: &MarketAdminCap, arg2: address) {
        assert!(arg2 != @0x0, 0);
        arg0.fee_recipient = arg2;
        let v0 = FeeRecipientUpdated{fee_recipient: arg2};
        0x2::event::emit<FeeRecipientUpdated>(v0);
    }

    public fun update_paused(arg0: &mut MarketConfig, arg1: &MarketAdminCap, arg2: bool) {
        arg0.paused = arg2;
        let v0 = MarketPauseUpdated{paused: arg2};
        0x2::event::emit<MarketPauseUpdated>(v0);
    }

    public fun update_platform_fee_bps(arg0: &mut MarketConfig, arg1: &MarketAdminCap, arg2: u16) {
        assert!(arg2 <= 10000, 2);
        arg0.platform_fee_bps = arg2;
        let v0 = PlatformFeeBpsUpdated{fee_bps: arg2};
        0x2::event::emit<PlatformFeeBpsUpdated>(v0);
    }

    public fun upgrade_cap_live(arg0: &MarketUpgradeState) : bool {
        arg0.upgrade_cap_live
    }

    public fun upgrade_pending(arg0: &MarketUpgradeState) : bool {
        arg0.pending_upgrade
    }

    public fun upgrades_immutable(arg0: &MarketUpgradeState) : bool {
        arg0.immutable
    }

    fun upsert_initial_metadata_blob_if_some(arg0: &mut 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::SoulMetadata, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: 0x1::string::String, arg3: 0x1::option::Option<vector<u8>>, arg4: &0x2::tx_context::TxContext) {
        if (0x1::option::is_some<vector<u8>>(&arg3)) {
            0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::upsert_metadata_blob(arg0, arg1, arg2, 0x1::option::destroy_some<vector<u8>>(arg3), arg4);
        } else {
            0x1::option::destroy_none<vector<u8>>(arg3);
        };
    }

    fun upsert_initial_metadata_blobs(arg0: &mut 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::metadata::SoulMetadata, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: 0x1::option::Option<vector<u8>>, arg3: 0x1::option::Option<vector<u8>>, arg4: 0x1::option::Option<vector<u8>>, arg5: &0x2::tx_context::TxContext) {
        upsert_initial_metadata_blob_if_some(arg0, arg1, 0x1::string::utf8(b"sprite.config.v1"), arg2, arg5);
        upsert_initial_metadata_blob_if_some(arg0, arg1, 0x1::string::utf8(b"sprite.mood_map.v1"), arg3, arg5);
        upsert_initial_metadata_blob_if_some(arg0, arg1, 0x1::string::utf8(b"voice.config.v1"), arg4, arg5);
    }

    // decompiled from Move bytecode v7
}

