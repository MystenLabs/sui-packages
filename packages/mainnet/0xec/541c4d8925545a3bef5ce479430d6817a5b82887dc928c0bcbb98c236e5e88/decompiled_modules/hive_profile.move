module 0xec541c4d8925545a3bef5ce479430d6817a5b82887dc928c0bcbb98c236e5e88::hive_profile {
    struct HIVE_PROFILE has drop {
        dummy_field: bool,
    }

    struct ProfileDofOwnershipCapability has store, key {
        id: 0x2::object::UID,
        supported_dof: 0x1::ascii::String,
        only_owner_can_add_dof: bool,
        only_owner_can_mut_dof: bool,
        only_owner_can_remove_dof: bool,
    }

    struct AdminDofOwnershipCapability has store, key {
        id: 0x2::object::UID,
        dof_identifier: 0x1::ascii::String,
    }

    struct HiveProfileMappingStore has key {
        id: 0x2::object::UID,
        owner_to_profile_mapping: 0x2::linked_table::LinkedTable<address, address>,
        username_to_profile_mapping: 0x2::linked_table::LinkedTable<0x1::ascii::String, address>,
        username_to_comp_profile_mapping: 0x2::linked_table::LinkedTable<0x1::ascii::String, address>,
        profile_to_creator_kiosk_mapping: 0x2::linked_table::LinkedTable<address, vector<address>>,
        dof_identifiers_to_cap_mapping: 0x2::linked_table::LinkedTable<0x1::ascii::String, address>,
        module_version: u64,
    }

    struct HiveManager has store, key {
        id: 0x2::object::UID,
        hive_profile: HiveProfile,
        config_params: ConfigParams,
        active_assets: u64,
        locked_assets: u64,
        max_assets_limit: u64,
        assets_to_profile_mapping: 0x2::linked_table::LinkedTable<u64, address>,
        active_power: u128,
        supported_lockup_durations: 0x2::table::Table<u8, u64>,
        royalty: Royalty,
        gems_royalty: SubscriptionRoyalty,
        buidlers_royalty: 0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>,
        creator_royalties: 0x2::linked_table::LinkedTable<address, 0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>,
        keeper_accounts: 0x2::linked_table::LinkedTable<address, bool>,
        module_version: u64,
    }

    struct HiveDisperser has store, key {
        id: 0x2::object::UID,
        incoming_gems_for_assets: 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::HiveGems,
        gems_for_assets: 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::HiveGems,
        global_dispersal_index: u256,
        module_version: u64,
    }

    struct HSuiDisperser<phantom T0> has store, key {
        id: 0x2::object::UID,
        incoming_hsui_for_assets: 0x2::balance::Balance<T0>,
        hsui_for_assets: 0x2::balance::Balance<T0>,
        global_dispersal_index: u256,
        module_version: u64,
    }

    struct HiveProfile has store, key {
        id: 0x2::object::UID,
        username: 0x1::ascii::String,
        bio: 0x1::string::String,
        lead_genai_asset: 0x1::option::Option<0x2::url::Url>,
        creation_timestamp: u64,
        owner: address,
        is_composable_profile: bool,
        subscriptions: 0x2::table::Table<u8, u64>,
        followers_list: 0x2::linked_table::LinkedTable<address, SubscriptionRecord>,
        following_list: 0x2::linked_table::LinkedTable<address, SubscriptionRecord>,
        available_gems: 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::HiveGems,
        available_hsui: 0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>,
        hive_assets: 0x2::linked_table::LinkedTable<u64, HiveAsset>,
        incoming_bids: 0x2::linked_table::LinkedTable<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>,
        borrow_records: 0x2::linked_table::LinkedTable<u64, BorrowRecord>,
        listing_records: 0x2::linked_table::LinkedTable<u64, ListingRecord>,
        bid_records: 0x2::linked_table::LinkedTable<u64, BidRecord>,
        lend_records: 0x2::linked_table::LinkedTable<u64, LendRecord>,
        supported_dofs: vector<0x1::ascii::String>,
        module_version: u64,
    }

    struct MarketPlace<phantom T0> has store, key {
        id: 0x2::object::UID,
        active_listings: 0x2::linked_table::LinkedTable<u64, Listing>,
        available_bids: 0x2::linked_table::LinkedTable<u64, vector<Bid<T0>>>,
        processed_listings: 0x2::linked_table::LinkedTable<u64, ExecutedListing<T0>>,
        module_version: u64,
    }

    struct CreatorHiveKiosk has store, key {
        id: 0x2::object::UID,
        creator_profile: address,
        init_hive_gems: u64,
        aesthetic: 0x1::string::String,
        type: 0x1::string::String,
        img_url: 0x2::url::Url,
        traits_list: vector<0x1::string::String>,
        max_assets_limit: u64,
        krafted_assets: u64,
        base_price: u64,
        curve_a: u64,
        prompts_list: vector<vector<0x1::string::String>>,
        url_list: vector<0x1::string::String>,
        names_list: vector<0x1::string::String>,
        krafted_versions_map: 0x2::linked_table::LinkedTable<u64, address>,
        followers_only: bool,
        followers_discount: u64,
        available_upgrades: 0x2::linked_table::LinkedTable<u64, vector<AssetUpgrade>>,
        module_version: u64,
    }

    struct HiveAsset has store, key {
        id: 0x2::object::UID,
        version: u64,
        power: u64,
        creator_profile: address,
        name: 0x1::string::String,
        img_url: 0x2::url::Url,
        aesthetic: 0x1::string::String,
        type: 0x1::string::String,
        prompts: 0x2::linked_table::LinkedTable<0x1::string::String, 0x1::string::String>,
        is_borrowed: bool,
        is_staked: bool,
        lockup_duration: u8,
        unlock_timestamp: u64,
        available_gems: 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::HiveGems,
        claim_index: u256,
        gems_claim_index: u256,
        total_hsui_claimed: u64,
        total_gems_claimed: u64,
        active_skins: 0x2::linked_table::LinkedTable<0x1::string::String, SkinRecord>,
    }

    struct Royalty has copy, store {
        numerator: u64,
        denominator: u64,
        assets_dispersal_percent: u64,
        creators_royalty_percent: u64,
    }

    struct SubscriptionRoyalty has copy, store {
        numerator: u64,
        denominator: u64,
        treasury_percent: u64,
        burn_percent: u64,
    }

    struct ConfigParams has copy, store {
        max_bids_per_asset: u64,
        min_sui_bid_allowed: u64,
        profile_kraft_fees_sui: u64,
        social_fee_gems: u64,
    }

    struct AssetUpgrade has store {
        upgrade_price: u64,
        followers_only: bool,
        followers_discount: u64,
        upgrade_img_url: 0x2::url::Url,
        upgrade_traits_list: vector<0x1::string::String>,
        upgrade_prompts: 0x2::table::Table<0x1::string::String, 0x1::string::String>,
    }

    struct PublicKraftConfig has store, key {
        id: 0x2::object::UID,
        start_time: u64,
        per_user_limit: u64,
        available_assets_to_kraft: u64,
        krafts_processed: u64,
        address_list: 0x2::linked_table::LinkedTable<address, u64>,
    }

    struct WhitelistKraftConfig has store, key {
        id: 0x2::object::UID,
        start_time: u64,
        end_time: u64,
        allow_followers: bool,
        per_follower_limit: u64,
        whitelisted_addresses: 0x2::linked_table::LinkedTable<address, u64>,
        available_assets_to_kraft: u64,
        krafts_processed: u64,
        base_price: u64,
        curve_a: u64,
    }

    struct SkinRecord has store {
        public_skin_kraft_enabled: bool,
        only_followers_allowed: bool,
        followers_discount: u64,
        royalty_fee_percent: u64,
        total_gems_ported: u64,
        total_skins_krafted: u64,
    }

    struct SubscriptionRecord has copy, store {
        follower: address,
        following: address,
        is_active: bool,
        init_timestamp: u64,
        subscription_type: u64,
        subscription_cost: u64,
        next_payment_timestamp: u64,
        total_paid: u64,
        switch_to_plan: 0x1::option::Option<u64>,
        switch_to_plan_price: 0x1::option::Option<u64>,
    }

    struct Listing has store {
        listed_by_profile: address,
        hive_asset: HiveAsset,
        followers_only: bool,
        followers_discount: u64,
        min_sui_price: u64,
        is_sale_listing: bool,
        instant_sale: bool,
        highest_bid_sale: bool,
        lockup_duration: u8,
        start_sec: u64,
        expiration_sec: u64,
    }

    struct ExecutedListing<phantom T0> has store {
        listed_by_profile: address,
        hive_asset: 0x1::option::Option<HiveAsset>,
        version: u64,
        was_sale_listing: bool,
        balance: 0x1::option::Option<0x2::balance::Balance<T0>>,
        bidder_profile: address,
        executed_price_in_hsui: u64,
        executed_price_in_sui: u64,
        borrow_period_start_sec: u64,
        borrow_period_end_sec: u64,
    }

    struct Bid<phantom T0> has store {
        bidder_profile: address,
        balance: 0x2::balance::Balance<T0>,
        offer_hsui_price: u64,
        expiration_sec: u64,
        is_listing_live: bool,
        is_valid: bool,
    }

    struct ListingRecord has store {
        version: u64,
        followers_only: bool,
        followers_discount: u64,
        min_sui_price: u64,
        is_sale_listing: bool,
        instant_sale: bool,
        highest_bid_sale: bool,
        lockup_duration: u8,
        start_sec: u64,
        expiration_sec: u64,
    }

    struct BidRecord has store {
        version: u64,
        offer_hsui_price: u64,
        expiration_sec: u64,
        is_asset_listed: bool,
    }

    struct LendRecord has store {
        borrower: address,
        version: u64,
        lend_price_sui: u64,
        start_sec: u64,
        lockup_duration: u8,
        expiration_sec: u64,
    }

    struct BorrowRecord has store {
        owner: address,
        borrow_price_sui: u64,
        start_sec: u64,
        lockup_duration: u8,
        expiration_sec: u64,
    }

    struct DofAccessCapKrafted has copy, drop {
        capability_addr: address,
        dof_identifer: 0x1::ascii::String,
        only_owner_can_add_dof: bool,
        only_owner_can_mut_dof: bool,
        only_owner_can_remove_dof: bool,
    }

    struct HiveKioskInitialized has copy, drop {
        kiosk_addr: address,
        creator_profile: address,
        post_number: u64,
        aesthetic: 0x1::string::String,
        type: 0x1::string::String,
        img_url: 0x1::string::String,
        init_hive_gems: u64,
        max_assets_limit: u64,
        base_price: u64,
        curve_a: u64,
    }

    struct TraitsSetInHiveKiosk has copy, drop {
        creator_profile: address,
        post_number: u64,
        aesthetic: 0x1::string::String,
        type: 0x1::string::String,
        traits_list: vector<0x1::string::String>,
    }

    struct PublicKraftInitialized has copy, drop {
        aesthetic: 0x1::string::String,
        type: 0x1::string::String,
        creator_profile: address,
        post_number: u64,
        creator_profile_username: 0x1::ascii::String,
        start_time: u64,
        per_user_limit: u64,
        available_assets_to_kraft: u64,
    }

    struct WhitelistKraftInitialized has copy, drop {
        aesthetic: 0x1::string::String,
        type: 0x1::string::String,
        creator_profile: address,
        post_number: u64,
        creator_profile_username: 0x1::ascii::String,
        start_time: u64,
        end_time: u64,
        allow_followers: bool,
        per_follower_limit: u64,
        base_price: u64,
        curve_a: u64,
        available_assets_to_kraft: u64,
    }

    struct AddedToWhitelist has copy, drop {
        aesthetic: 0x1::string::String,
        type: 0x1::string::String,
        creator_profile: address,
        post_number: u64,
        wl_profiles: vector<address>,
        kraft_limit: u64,
    }

    struct KraftYieldHarvested has copy, drop {
        sui_yield: u64,
        receiver: address,
    }

    struct RoyaltyCollectedForCreator has copy, drop {
        creator_profile: address,
        username: 0x1::ascii::String,
        hsui_collected: u64,
    }

    struct ProfileConfigParamsUpdated has copy, drop {
        max_bids_per_asset: u64,
        min_sui_bid_allowed: u64,
        profile_kraft_fees_sui: u64,
        social_fee_gems: u64,
    }

    struct KraftRoyaltyUpdated has copy, drop {
        royalty_num: u64,
        royalty_denom: u64,
        assets_dispersal_percent: u64,
        creators_royalty_percent: u64,
        gems_royalty_num: u64,
        gems_royalty_denom: u64,
        gems_treasury_percent: u64,
        gems_burn_percent: u64,
    }

    struct TotalActivePowerUpdated has copy, drop {
        new_total_active_power: u128,
        total_staked_assets: u64,
    }

    struct HiveAssetStaked has copy, drop {
        username: 0x1::ascii::String,
        profile_addr: address,
        version: u64,
        duration: u8,
        new_asset_power: u64,
        unlock_timestamp: u64,
    }

    struct HiveAssetUnstaked has copy, drop {
        profile_addr: address,
        version: u64,
    }

    struct NewSkinForAsset has copy, drop {
        version: u64,
        skin_type: 0x1::string::String,
        only_followers_allowed: bool,
        followers_discount: u64,
        public_skin_kraft_enabled: bool,
        royalty_fee_percent: u64,
    }

    struct NewSkinForCardKrafted has copy, drop {
        krafted_by_profile: address,
        krafter_username: 0x1::ascii::String,
        owner_profile: address,
        owner_username: 0x1::ascii::String,
        version: u64,
        skin_type: 0x1::string::String,
        skin_price: u64,
        royalty_earned_by_owner: u64,
        skins_krafted_for_type_by_asset: u64,
        total_royalty_amt: u64,
        treasury_amt: u64,
        gems_burnt: u64,
    }

    struct HiveGemsPortedToSkin has copy, drop {
        ported_by_profile: address,
        ported_by_username: 0x1::ascii::String,
        version: u64,
        skin_type: 0x1::string::String,
        gems_ported: u64,
    }

    struct SkinRoyaltyCommissionUpdated has copy, drop {
        version: u64,
        skin_type: 0x1::string::String,
        royalty_fee_percent: u64,
    }

    struct SkinFollowerPermissionsUpdated has copy, drop {
        version: u64,
        skin_type: 0x1::string::String,
        only_followers_allowed: bool,
        followers_discount: u64,
    }

    struct SkinPublicKraftPermissionsUpdated has copy, drop {
        version: u64,
        skin_type: 0x1::string::String,
        public_kraft_enabled: bool,
    }

    struct HSuiAddedForHarvest has copy, drop {
        yield_added: u64,
    }

    struct HiveAddedForHarvest has copy, drop {
        yield_added: u64,
    }

    struct GemAddedToProfile has copy, drop {
        username: 0x1::ascii::String,
        profile_addr: address,
        deposited_gems: u64,
    }

    struct CardPowerUpdated has copy, drop {
        version: u64,
        add_power: u64,
        new_asset_power: u64,
    }

    struct HiveGemsDepositedIntoAsset has copy, drop {
        profile: address,
        version: u64,
        gems_deposited: u64,
    }

    struct HiveProfileKrafted has copy, drop {
        name: 0x1::string::String,
        bio: 0x1::string::String,
        new_profile_addr: address,
        krafter: address,
        fee: u64,
        is_composable_profile: bool,
    }

    struct NewHiveAssetKrafted has copy, drop {
        id: 0x2::object::ID,
        krafter_profile_addr: address,
        krafter: address,
        aesthetic: 0x1::string::String,
        type: 0x1::string::String,
        name: 0x1::string::String,
        version: u64,
        img_url: 0x1::string::String,
        genesis_hivegems: u64,
        power: u64,
        price: u64,
        traits_list: vector<0x1::string::String>,
        prompts_list: vector<0x1::string::String>,
    }

    struct DegenHiveYieldHarvested has copy, drop {
        harvester_profile: address,
        username: 0x1::ascii::String,
        hsui_harvested: u64,
        gems_harvested: u64,
    }

    struct BidMarkedInvalid has copy, drop {
        version: u64,
        bidder_profile: address,
    }

    struct NewListing has copy, drop {
        listed_by_profile: address,
        followers_only: bool,
        followers_discount: u64,
        version: u64,
        min_sui_price: u64,
        is_sale_listing: bool,
        instant_sale: bool,
        highest_bid_sale: bool,
        lockup_duration: u8,
        start_sec: u64,
        expiration_sec: u64,
    }

    struct ListingUpdated has copy, drop {
        listed_by_profile: address,
        version: u64,
        min_sui_price: u64,
        lockup_duration: u8,
        start_sec: u64,
        expiration_sec: u64,
    }

    struct ListingCanceled has copy, drop {
        listed_by_profile: address,
        version: u64,
    }

    struct ListingExpired has copy, drop {
        listed_by_profile: address,
        version: u64,
    }

    struct BidPlaced has copy, drop {
        bidder_profile: address,
        username: 0x1::ascii::String,
        version: u64,
        offer_hsui_price: u64,
        expiration_sec: u64,
        is_asset_listed: bool,
    }

    struct BidDestroyed has copy, drop {
        asset_version: u64,
        bidder_profile: address,
    }

    struct ListingDestroyed has copy, drop {
        version: u64,
        listed_by_profile: address,
    }

    struct SaleExecuted has copy, drop {
        version: u64,
        buyer_profile: address,
        seller_profile: address,
        price_paid_hsui: u64,
        price_paid_sui: u64,
    }

    struct RoyaltyProcessed has copy, drop {
        total_royalty_amt: u64,
        hive_dispersal_amt: u64,
        creator_royalty_amt: u64,
        accrued_to_fee_cap_holder: u64,
    }

    struct BidModified has copy, drop {
        version: u64,
        bidder_profile: address,
        offer_hsui_price: u64,
        expiration_sec: u64,
    }

    struct BidCanceled has copy, drop {
        version: u64,
        bidder_profile: address,
    }

    struct BidExpired has copy, drop {
        version: u64,
        bidder_profile: address,
    }

    struct ExecutedListingDestroyed has copy, drop {
        version: u64,
        executed_price_in_hsui: u64,
        executed_price_in_sui: u64,
        listed_by_profile: address,
    }

    struct HiveAssetBorrowed has copy, drop {
        version: u64,
        borrower: address,
        lender: address,
        borrow_price_sui: u64,
        lockup_duration: u8,
        borrow_start_sec: u64,
        borrow_exp_sec: u64,
    }

    struct ReturnBorrowedHiveAsset has copy, drop {
        version: u64,
        owner: address,
        borrower: address,
    }

    struct HighestBidListingUnsold has copy, drop {
        version: u64,
        listed_by_profile: address,
    }

    struct HiveGemsTransfered has copy, drop {
        from_username: 0x1::ascii::String,
        to_username: 0x1::ascii::String,
        from_profile_addr: address,
        to_profile_addr: address,
        gems_transferred: u64,
    }

    struct HiveAssetTransfered has copy, drop {
        version: u64,
        from_profile: address,
        to_profile: address,
    }

    struct HarvestRewardsForAsset has copy, drop {
        version: u64,
        hsui_harvested: u64,
        gems_harvested: u64,
    }

    struct DepositHSuiForProfile has copy, drop {
        profile_addr: address,
        hsui_deposited: u64,
        depositor_addr: address,
    }

    struct GemWithdrawnFromProfile has copy, drop {
        username: 0x1::ascii::String,
        profile_addr: address,
        withdrawn_gems: u64,
    }

    struct UserNameUpdated has copy, drop {
        profile_addr: address,
        prev_username: 0x1::string::String,
        new_username: 0x1::string::String,
    }

    struct SubscribedToProfile has copy, drop {
        follower_profile_addr: address,
        profile_followed_addr: address,
        follower_username: 0x1::string::String,
        followed_username: 0x1::string::String,
        subscription_type: u64,
        subscription_cost: u64,
        next_payment_timestamp: u64,
    }

    struct SubscriptionPaymentProcessed has copy, drop {
        follower_profile_addr: address,
        profile_followed_addr: address,
        subscription_type: u64,
        subscription_cost: u64,
        total_royalty_amt: u64,
        treasury_amt: u64,
        gems_burnt: u64,
    }

    struct SubscriptionSwitchedToNewPlan has copy, drop {
        follower_profile_addr: address,
        profile_followed_addr: address,
        follower_username: 0x1::string::String,
        followed_username: 0x1::string::String,
        new_subscription_type: u8,
        new_subscription_cost: u64,
    }

    struct ProfileUnfollowed has copy, drop {
        follower_profile_addr: address,
        profile_unfollowed_addr: address,
        follower_username: 0x1::string::String,
        unfollowed_username: 0x1::string::String,
    }

    struct SubscriptionPlanUpdated has copy, drop {
        profile_addr: address,
        username: 0x1::string::String,
        new_one_month_sub_cost: u64,
        new_three_month_sub_cost: u64,
        new_one_year_sub_cost: u64,
    }

    struct HiveAssetUpgraded has copy, drop {
        version: u64,
        hive_kiosk: address,
        new_img_url: 0x1::string::String,
        upgrade_price: u64,
        total_royalty_amt: u64,
        treasury_amt: u64,
        gems_burnt: u64,
    }

    struct RemovedUpgradeForVersion has copy, drop {
        creator_profile_addr: address,
        post_number: u64,
        aesthetic: 0x1::string::String,
        type: 0x1::string::String,
        version: u64,
        upgrade_index: u64,
    }

    struct AddedNewUpgradeForVersion has copy, drop {
        profile_addr: address,
        aesthetic: 0x1::string::String,
        type: 0x1::string::String,
        post_number: u64,
        version: u64,
        new_img_url: 0x1::string::String,
        upgrade_traits_list: vector<0x1::string::String>,
        upgrade_prompts_list: vector<0x1::string::String>,
    }

    struct KioskOwnershipTransferred has copy, drop {
        aesthetic: 0x1::string::String,
        type: 0x1::string::String,
        creator_profile: address,
        creator_profile_username: 0x1::ascii::String,
        new_creator_profile: address,
        new_creator_profile_username: 0x1::ascii::String,
        kiosk: address,
    }

    struct BioUpdated has copy, drop {
        profile_addr: address,
        username: 0x1::string::String,
        new_bio: 0x1::string::String,
    }

    struct LeadGenAiAssetSet has copy, drop {
        profile_addr: address,
        username: 0x1::string::String,
        new_lead_url: 0x1::string::String,
    }

    public entry fun accept_bid(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &0xe0e81e85d25c7f0ce1de241f82139208838e3f5e656cce7059f6525b116a69f4::hsui_vault::HSuiVault, arg3: &mut HSuiDisperser<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg4: &mut MarketPlace<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg5: &mut HiveProfile, arg6: &mut HiveProfile, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg3.module_version == 0 && arg4.module_version == 0, 1079);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg0);
        authority_check(arg5, v0);
        assert!(0x2::linked_table::contains<u64, ListingRecord>(&arg5.listing_records, arg7), 1045);
        let v2 = 0x2::linked_table::remove<u64, ListingRecord>(&mut arg5.listing_records, arg7);
        assert!(v2.expiration_sec > v1, 1032);
        let (_, _, _, _, _, _, _, _, _, _) = destroy_listing_record(v2);
        let v13 = 0x2::linked_table::remove<u64, BidRecord>(&mut arg6.bid_records, arg7);
        assert!(v13.expiration_sec > v1, 1071);
        let (_, _, _, _) = destroy_bid_record(v13);
        let v18 = 0x2::balance::zero<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>();
        let v19 = &mut v18;
        let (v20, v21) = execute_sale(arg1, arg2, arg4, arg3, arg7, true, arg6.owner, 0, v19);
        let v22 = v21;
        0x2::balance::join<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut arg5.available_hsui, 0x1::option::extract<0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&mut v22.balance));
        update_asset_ownership(arg1, arg7, 0x2::object::uid_to_address(&arg6.id));
        deposit_hive_asset(arg6, v20);
        let (_, v24, _, _, v27, _, _, _, _, _) = destroy_executed_listing<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(v22);
        0x1::option::destroy_none<HiveAsset>(v24);
        0x1::option::destroy_none<0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(v27);
        0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::coin_helper::destroy_or_transfer_balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(v18, v0, arg8);
    }

    public entry fun accept_direct_bid(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &0xe0e81e85d25c7f0ce1de241f82139208838e3f5e656cce7059f6525b116a69f4::hsui_vault::HSuiVault, arg3: &mut HSuiDisperser<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg4: &mut HiveDisperser, arg5: &mut HiveProfile, arg6: &mut HiveProfile, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg3.module_version == 0 && arg4.module_version == 0, 1079);
        let v0 = 0x2::object::uid_to_address(&arg6.id);
        let v1 = 0x2::object::uid_to_address(&arg5.id);
        assert!(arg5.is_composable_profile || arg5.owner == 0x2::tx_context::sender(arg8), 1057);
        assert!(0x2::linked_table::contains<u64, HiveAsset>(&arg5.hive_assets, arg7), 1064);
        assert!(0x2::linked_table::contains<u64, BidRecord>(&arg6.bid_records, arg7), 1033);
        let v2 = 0x2::linked_table::remove<u64, BidRecord>(&mut arg6.bid_records, arg7);
        assert!(v2.expiration_sec > 0x2::clock::timestamp_ms(arg0), 1071);
        let (v3, v4) = withdraw_hive_asset(arg0, arg1, arg3, arg4, arg5, arg7, false);
        let v5 = v3;
        0x2::balance::join<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut arg5.available_hsui, v4);
        let v6 = 0;
        let v7 = v6;
        let v8 = 0x2::balance::zero<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>();
        let v9 = 0x2::linked_table::remove<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(&mut arg5.incoming_bids, arg7);
        let v10 = 0;
        while (v10 < 0x1::vector::length<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&v9)) {
            let v11 = 0x1::vector::borrow_mut<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&mut v9, v10);
            if (v11.bidder_profile == v0) {
                let v12 = 0x1::vector::remove<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&mut v9, v10);
                assert!(v12.is_valid, 1072);
                let (v13, _, v15, _, _, _) = destroy_bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(v12, arg7);
                if (v6 == 0) {
                    v7 = v15;
                };
                0x2::balance::join<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut v8, v13);
                break
            };
            v11.is_valid = false;
            v10 = v10 + 1;
        };
        0x2::linked_table::push_back<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(&mut arg5.incoming_bids, arg7, v9);
        let (_, _, _, _) = destroy_bid_record(v2);
        let v23 = v8;
        v8 = process_royalty(v23, arg1, arg3, v5.creator_profile);
        0x2::balance::join<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut arg5.available_hsui, v8);
        update_asset_ownership(arg1, arg7, v0);
        deposit_hive_asset(arg6, v5);
        let v24 = SaleExecuted{
            version         : arg7,
            buyer_profile   : v0,
            seller_profile  : v1,
            price_paid_hsui : v7,
            price_paid_sui  : 0xe0e81e85d25c7f0ce1de241f82139208838e3f5e656cce7059f6525b116a69f4::hsui_vault::get_sui_by_hsui(arg2, v7),
        };
        0x2::event::emit<SaleExecuted>(v24);
    }

    public fun add_asset_upgrade_to_kiosk(arg0: &0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::config::HiveEntryCap, arg1: &mut HiveProfile, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: bool, arg7: u64, arg8: u64, arg9: 0x1::string::String, arg10: vector<0x1::string::String>, arg11: vector<0x1::string::String>, arg12: &mut 0x2::tx_context::TxContext) {
        authority_check(arg1, 0x2::tx_context::sender(arg12));
        assert!(arg7 < 100, 1104);
        let v0 = get_kiosk_storage_identifier(arg3, arg4);
        let v1 = remove_from_profile<CreatorHiveKiosk>(arg1, v0);
        assert!(0x2::linked_table::contains<u64, address>(&v1.krafted_versions_map, arg5), 1079);
        assert!(0x1::vector::length<0x1::string::String>(&arg10) < 5 && 0x1::vector::length<0x1::string::String>(&arg10) == 0x1::vector::length<0x1::string::String>(&arg11), 1051);
        let v2 = AssetUpgrade{
            upgrade_price       : arg8,
            followers_only      : arg6,
            followers_discount  : arg7,
            upgrade_img_url     : 0x2::url::new_unsafe(0x1::string::to_ascii(arg9)),
            upgrade_traits_list : arg10,
            upgrade_prompts     : 0x2::table::new<0x1::string::String, 0x1::string::String>(arg12),
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(&arg10)) {
            0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v2.upgrade_prompts, *0x1::vector::borrow<0x1::string::String>(&arg10, v3), *0x1::vector::borrow<0x1::string::String>(&arg11, v3));
            v3 = v3 + 1;
        };
        if (!0x2::linked_table::contains<u64, vector<AssetUpgrade>>(&v1.available_upgrades, arg5)) {
            let v4 = 0x1::vector::empty<AssetUpgrade>();
            0x1::vector::push_back<AssetUpgrade>(&mut v4, v2);
            0x2::linked_table::push_back<u64, vector<AssetUpgrade>>(&mut v1.available_upgrades, arg5, v4);
        } else {
            let v5 = 0x2::linked_table::remove<u64, vector<AssetUpgrade>>(&mut v1.available_upgrades, arg5);
            assert!(0x1::vector::length<AssetUpgrade>(&v5) < 10, 1098);
            0x1::vector::push_back<AssetUpgrade>(&mut v5, v2);
            0x2::linked_table::push_back<u64, vector<AssetUpgrade>>(&mut v1.available_upgrades, arg5, v5);
        };
        let v6 = AddedNewUpgradeForVersion{
            profile_addr         : 0x2::object::uid_to_address(&arg1.id),
            aesthetic            : arg3,
            type                 : arg4,
            post_number          : arg2,
            version              : arg5,
            new_img_url          : arg9,
            upgrade_traits_list  : arg10,
            upgrade_prompts_list : arg11,
        };
        0x2::event::emit<AddedNewUpgradeForVersion>(v6);
        add_to_profile<CreatorHiveKiosk>(arg1, v0, v1);
    }

    fun add_bid_record_to_profile(arg0: &mut HiveProfile, arg1: u64, arg2: BidRecord) {
        0x2::linked_table::push_back<u64, BidRecord>(&mut arg0.bid_records, arg1, arg2);
    }

    fun add_bid_to_table(arg0: &mut 0x2::linked_table::LinkedTable<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>, arg1: u64, arg2: Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg3: u64) {
        if (0x2::linked_table::contains<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(arg0, arg1)) {
            let v0 = 0x2::linked_table::borrow_mut<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(arg0, arg1);
            assert!(0x1::vector::length<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(v0) < arg3, 1078);
            0x1::vector::push_back<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(v0, arg2);
        } else {
            let v1 = 0x1::vector::empty<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>();
            0x1::vector::push_back<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&mut v1, arg2);
            0x2::linked_table::push_back<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(arg0, arg1, v1);
        };
    }

    fun add_to_profile<T0: store + key>(arg0: &mut HiveProfile, arg1: 0x1::ascii::String, arg2: T0) {
        let (v0, _) = 0x1::vector::index_of<0x1::ascii::String>(&arg0.supported_dofs, &arg1);
        assert!(v0, 1115);
        0x1::vector::push_back<0x1::ascii::String>(&mut arg0.supported_dofs, arg1);
        0x2::dynamic_object_field::add<0x1::ascii::String, T0>(&mut arg0.id, arg1, arg2);
    }

    public fun add_to_whitelist(arg0: &0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::config::DegenHiveDeployerCap, arg1: &mut HiveProfile, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: vector<address>, arg7: u64) {
        let v0 = 0x1::string::from_ascii(get_kiosk_storage_identifier(arg3, arg4));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"::WHITELISTED_KRAFT_CONFIG"));
        let v1 = remove_from_profile<WhitelistKraftConfig>(arg1, 0x1::string::to_ascii(v0));
        assert!(v1.end_time > 0x2::clock::timestamp_ms(arg5), 1007);
        assert!(arg7 > 0, 1068);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg6)) {
            let v3 = *0x1::vector::borrow<address>(&arg6, v2);
            if (!0x2::linked_table::contains<address, u64>(&v1.whitelisted_addresses, v3)) {
                0x2::linked_table::push_back<address, u64>(&mut v1.whitelisted_addresses, v3, arg7);
            } else {
                *0x2::linked_table::borrow_mut<address, u64>(&mut v1.whitelisted_addresses, v3) = arg7;
            };
            v2 = v2 + 1;
        };
        let v4 = AddedToWhitelist{
            aesthetic       : arg3,
            type            : arg4,
            creator_profile : 0x2::object::uid_to_address(&arg1.id),
            post_number     : arg2,
            wl_profiles     : arg6,
            kraft_limit     : arg7,
        };
        0x2::event::emit<AddedToWhitelist>(v4);
        add_to_profile<WhitelistKraftConfig>(arg1, 0x1::string::to_ascii(v0), v1);
    }

    fun authority_check(arg0: &HiveProfile, arg1: address) {
        assert!(arg0.is_composable_profile || arg0.owner == arg1, 1057);
    }

    public fun borrow_from_profile<T0: store + key>(arg0: &HiveProfile, arg1: 0x1::ascii::String) : &T0 {
        0x2::dynamic_object_field::borrow<0x1::ascii::String, T0>(&arg0.id, arg1)
    }

    public entry fun borrow_hive_asset(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut HiveManager, arg3: &mut 0xe0e81e85d25c7f0ce1de241f82139208838e3f5e656cce7059f6525b116a69f4::hsui_vault::HSuiVault, arg4: &mut HSuiDisperser<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg5: &mut MarketPlace<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg6: &mut HiveProfile, arg7: &mut HiveProfile, arg8: u64, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.module_version == 0 && arg4.module_version == 0 && arg5.module_version == 0, 1079);
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x2::object::uid_to_address(&arg7.id);
        let v2 = 0x2::tx_context::sender(arg10);
        authority_check(arg6, v2);
        assert!(0x2::linked_table::contains<u64, ListingRecord>(&arg7.listing_records, arg8), 1070);
        let v3 = 0x2::linked_table::remove<u64, ListingRecord>(&mut arg7.listing_records, arg8);
        assert!(v3.expiration_sec > v0, 1032);
        assert!(!v3.is_sale_listing, 1047);
        let v4 = 0;
        if (v3.followers_only) {
            assert!(0x2::linked_table::contains<address, SubscriptionRecord>(&arg6.following_list, v1), 1090);
            let v5 = 0x2::linked_table::borrow<address, SubscriptionRecord>(&arg6.following_list, v1);
            assert!(0x2::clock::timestamp_ms(arg0) < v5.next_payment_timestamp && v5.is_active, 1088);
            v4 = v3.followers_discount;
        };
        let v6 = v3.lockup_duration;
        let v7 = 0x2::clock::timestamp_ms(arg0);
        let v8 = v0 + 259200000 + (v6 as u64) * 2592000000;
        let v9 = v3.min_sui_price - (0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::math::mul_div_u128((v3.min_sui_price as u128), (v4 as u128), (1000000000000000000 as u128)) as u64);
        let (_, _, _, _, _, _, _, _, _, _) = destroy_listing_record(v3);
        let v20 = 0x2::coin::into_balance<0x2::sui::SUI>(arg9);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v20) >= v9, 1058);
        let v21 = 0xe0e81e85d25c7f0ce1de241f82139208838e3f5e656cce7059f6525b116a69f4::hsui_vault::stake_sui_request(arg1, arg3, 0x2::balance::split<0x2::sui::SUI>(&mut v20, v9), 0x1::option::none<address>(), arg10);
        let v22 = &mut v21;
        let (v23, v24) = execute_sale(arg2, arg3, arg5, arg4, arg8, false, v2, 0x2::balance::value<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&v21), v22);
        let v25 = v24;
        let v26 = v23;
        0x2::balance::join<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut arg7.available_hsui, 0x1::option::extract<0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&mut v25.balance));
        let v27 = BorrowRecord{
            owner            : arg7.owner,
            borrow_price_sui : v9,
            start_sec        : v7,
            lockup_duration  : (v6 as u8),
            expiration_sec   : v8,
        };
        v26.is_borrowed = true;
        deposit_hive_asset(arg6, v26);
        0x2::linked_table::push_back<u64, BorrowRecord>(&mut arg6.borrow_records, arg8, v27);
        let v28 = LendRecord{
            borrower        : v2,
            version         : arg8,
            lend_price_sui  : v9,
            start_sec       : v7,
            lockup_duration : (v6 as u8),
            expiration_sec  : v8,
        };
        0x2::linked_table::push_back<u64, LendRecord>(&mut arg7.lend_records, arg8, v28);
        let (_, v30, _, _, v33, _, _, _, _, _) = destroy_executed_listing<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(v25);
        0x1::option::destroy_none<HiveAsset>(v30);
        0x1::option::destroy_none<0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(v33);
        let v39 = HiveAssetBorrowed{
            version          : arg8,
            borrower         : v2,
            lender           : arg7.owner,
            borrow_price_sui : v9,
            lockup_duration  : v6,
            borrow_start_sec : v7,
            borrow_exp_sec   : v8,
        };
        0x2::event::emit<HiveAssetBorrowed>(v39);
        0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v20, v2, arg10);
        0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::coin_helper::destroy_or_transfer_balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(v21, v2, arg10);
    }

    fun borrow_mut_from_profile<T0: store + key>(arg0: &mut HiveProfile, arg1: 0x1::ascii::String) : &mut T0 {
        0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, T0>(&mut arg0.id, arg1)
    }

    fun calc_next_payment_timestamp(arg0: u64, arg1: u8) : u64 {
        if (arg1 == 1) {
            arg0 + 2592000000
        } else if (arg1 == 3) {
            arg0 + 3 * 2592000000
        } else {
            assert!(arg1 == 12, 1091);
            arg0 + 12 * 2592000000
        }
    }

    fun calc_voting_power(arg0: u64, arg1: u64) : u64 {
        0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::math::mul_div(arg0, arg1, 1000)
    }

    public entry fun calculate_kraft_price(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = arg1 + arg2 * ((pow_approx((arg3 as u128), 2, 3) / 1000000000000) as u64);
        v0 - (0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::math::mul_div_u256((v0 as u256), (arg0 as u256), (100 as u256)) as u64)
    }

    public entry fun calculate_pow(arg0: u128, arg1: u128, arg2: u128, arg3: u128) : u128 {
        let v0 = (arg0 as u256) * (1000000000000000000 as u256) / (arg1 as u256);
        let v1 = (arg2 as u256) * (1000000000000000000 as u256) / (arg3 as u256);
        if (v1 == 0) {
            return (1000000000000000000 as u128)
        };
        if (v0 == 0) {
            return (v0 as u128)
        };
        let v2 = v1 / (1000000000000000000 as u256);
        let v3 = v1 % (1000000000000000000 as u256);
        let v4 = v0;
        if (v2 == 0) {
            v4 = (1000000000000000000 as u256);
        } else {
            let v5 = 1;
            while (v5 < (v2 as u128)) {
                let v6 = v4 * v0;
                v4 = v6 / (1000000000000000000 as u256);
                v5 = v5 + 1;
            };
        };
        if (v3 == 0) {
            return (v4 as u128)
        };
        ((v4 * pow_approx_frac(v0, (v3 as u128), 1000000000000000) / (1000000000000000000 as u256)) as u128)
    }

    public entry fun cancel_bid(arg0: &mut MarketPlace<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg1: &mut HiveProfile, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 1079);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        authority_check(arg1, v0);
        let (_, _, _, _) = destroy_bid_record(0x2::linked_table::remove<u64, BidRecord>(&mut arg1.bid_records, arg2));
        let v6 = 0x2::linked_table::remove<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(&mut arg0.available_bids, arg2);
        let v7 = &mut v6;
        0x2::linked_table::push_back<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(&mut arg0.available_bids, arg2, v6);
        let v8 = BidCanceled{
            version        : arg2,
            bidder_profile : v1,
        };
        0x2::event::emit<BidCanceled>(v8);
        0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::coin_helper::destroy_or_transfer_balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(destroy_bid_among_bids(v7, v1, false, arg2), v0, arg3);
    }

    public entry fun cancel_direct_bid(arg0: &mut HiveProfile, arg1: &mut HiveProfile, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 1079);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        authority_check(arg1, v0);
        let (_, _, _, _) = destroy_bid_record(0x2::linked_table::remove<u64, BidRecord>(&mut arg1.bid_records, arg2));
        let v6 = 0x2::linked_table::remove<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(&mut arg0.incoming_bids, arg2);
        let v7 = &mut v6;
        0x2::linked_table::push_back<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(&mut arg0.incoming_bids, arg2, v6);
        let v8 = BidCanceled{
            version        : arg2,
            bidder_profile : v1,
        };
        0x2::event::emit<BidCanceled>(v8);
        0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::coin_helper::destroy_or_transfer_balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(destroy_bid_among_bids(v7, v1, false, arg2), v0, arg3);
    }

    public entry fun cancel_listing(arg0: &mut MarketPlace<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg1: &mut HiveProfile, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 1079);
        authority_check(arg1, 0x2::tx_context::sender(arg3));
        assert!(0x2::linked_table::contains<u64, ListingRecord>(&arg1.listing_records, arg2), 1037);
        let v0 = 0x2::linked_table::remove<u64, Listing>(&mut arg0.active_listings, arg2);
        let v1 = ListingCanceled{
            listed_by_profile : v0.listed_by_profile,
            version           : arg2,
        };
        0x2::event::emit<ListingCanceled>(v1);
        let (v2, _, _, _, _, _, _, _, _, _, _) = destroy_listing(v0);
        let (_, _, _, _, _, _, _, _, _, _) = destroy_listing_record(0x2::linked_table::remove<u64, ListingRecord>(&mut arg1.listing_records, arg2));
        deposit_hive_asset(arg1, v2);
        mark_marketplace_bids_as_invalid(arg0, arg2);
    }

    fun claim_accrued_rewards_for_asset(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &mut HSuiDisperser<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg3: &mut HiveDisperser, arg4: &mut HiveAsset) : (0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::HiveGems, 0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, bool) {
        let v0 = false;
        let v1 = v0;
        if (arg4.is_staked) {
            let v5 = compute_harvest_by_gems(arg2.global_dispersal_index, arg4.claim_index, arg4.power);
            let v6 = compute_harvest_by_gems(arg3.global_dispersal_index, arg4.gems_claim_index, arg4.power);
            let v7 = HarvestRewardsForAsset{
                version        : arg4.version,
                hsui_harvested : v5,
                gems_harvested : v6,
            };
            0x2::event::emit<HarvestRewardsForAsset>(v7);
            arg4.claim_index = arg2.global_dispersal_index;
            arg4.gems_claim_index = arg3.global_dispersal_index;
            arg4.total_hsui_claimed = arg4.total_hsui_claimed + v5;
            arg4.total_gems_claimed = arg4.total_gems_claimed + v6;
            if (arg4.unlock_timestamp < 0x2::clock::timestamp_ms(arg0)) {
                unstake_hive_asset(arg1, arg4);
                v1 = true;
            };
            (0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::split(&mut arg3.gems_for_assets, v6), 0x2::balance::split<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut arg2.hsui_for_assets, v5), v1)
        } else {
            (0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::zero(), 0x2::balance::zero<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(), v0)
        }
    }

    fun compute_harvest_by_gems(arg0: u256, arg1: u256, arg2: u64) : u64 {
        ((((arg0 - arg1) as u256) * (arg2 as u256) / (1000000000000000000 as u256)) as u64)
    }

    fun create_bid(arg0: address, arg1: u64, arg2: 0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg3: u64, arg4: bool) : Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI> {
        Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>{
            bidder_profile   : arg0,
            balance          : arg2,
            offer_hsui_price : arg1,
            expiration_sec   : arg3,
            is_listing_live  : arg4,
            is_valid         : true,
        }
    }

    fun create_bid_record(arg0: u64, arg1: u64, arg2: u64, arg3: bool) : BidRecord {
        BidRecord{
            version          : arg0,
            offer_hsui_price : arg1,
            expiration_sec   : arg2,
            is_asset_listed  : arg3,
        }
    }

    public fun deposit_gems_for_hive(arg0: &mut HiveDisperser, arg1: 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::HiveGems) {
        let v0 = HiveAddedForHarvest{yield_added: 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::value(&arg1)};
        0x2::event::emit<HiveAddedForHarvest>(v0);
        0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::join(&mut arg0.incoming_gems_for_assets, arg1);
    }

    public fun deposit_gems_in_profile(arg0: &mut HiveProfile, arg1: 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::HiveGems) {
        let v0 = GemAddedToProfile{
            username       : arg0.username,
            profile_addr   : 0x2::object::uid_to_address(&arg0.id),
            deposited_gems : 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::value(&arg1),
        };
        0x2::event::emit<GemAddedToProfile>(v0);
        0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::join(&mut arg0.available_gems, arg1);
    }

    public fun deposit_gems_with_manager_profile(arg0: &mut HiveManager, arg1: 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::HiveGems) {
        let v0 = &mut arg0.hive_profile;
        deposit_gems_in_profile(v0, arg1);
    }

    fun deposit_hive_asset(arg0: &mut HiveProfile, arg1: HiveAsset) {
        assert!(0x2::linked_table::length<u64, HiveAsset>(&arg0.hive_assets) + 0x2::linked_table::length<u64, ListingRecord>(&arg0.listing_records) + 0x2::linked_table::length<u64, LendRecord>(&arg0.lend_records) < 25, 1020);
        0x2::linked_table::push_back<u64, HiveAsset>(&mut arg0.hive_assets, arg1.version, arg1);
    }

    public fun deposit_hsui_for_hive<T0>(arg0: &mut HSuiDisperser<T0>, arg1: 0x2::balance::Balance<T0>) {
        let v0 = HSuiAddedForHarvest{yield_added: 0x2::balance::value<T0>(&arg1)};
        0x2::event::emit<HSuiAddedForHarvest>(v0);
        0x2::balance::join<T0>(&mut arg0.incoming_hsui_for_assets, arg1);
    }

    public fun deposit_hsui_for_profile(arg0: &mut HiveProfile, arg1: 0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 1079);
        0x2::balance::join<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut arg0.available_hsui, arg1);
        let v0 = DepositHSuiForProfile{
            profile_addr   : 0x2::object::uid_to_address(&arg0.id),
            hsui_deposited : 0x2::balance::value<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&arg1),
            depositor_addr : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<DepositHSuiForProfile>(v0);
    }

    fun destroy_bid<T0>(arg0: Bid<T0>, arg1: u64) : (0x2::balance::Balance<T0>, address, u64, u64, bool, bool) {
        let Bid {
            bidder_profile   : v0,
            balance          : v1,
            offer_hsui_price : v2,
            expiration_sec   : v3,
            is_listing_live  : v4,
            is_valid         : v5,
        } = arg0;
        let v6 = BidDestroyed{
            asset_version  : arg1,
            bidder_profile : v0,
        };
        0x2::event::emit<BidDestroyed>(v6);
        (v1, v0, v2, v3, v4, v5)
    }

    fun destroy_bid_among_bids(arg0: &mut vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>, arg1: address, arg2: bool, arg3: u64) : 0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI> {
        let v0 = 0x2::balance::zero<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(arg0)) {
            if (0x1::vector::borrow<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(arg0, v1).bidder_profile == arg1) {
                let v2 = 0x1::vector::remove<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(arg0, v1);
                if (arg2) {
                    assert!(!v2.is_valid, 1075);
                };
                let (v3, _, _, _, _, _) = destroy_bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(v2, arg3);
                0x2::balance::join<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut v0, v3);
                return v0
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun destroy_bid_record(arg0: BidRecord) : (u64, u64, u64, bool) {
        let BidRecord {
            version          : v0,
            offer_hsui_price : v1,
            expiration_sec   : v2,
            is_asset_listed  : v3,
        } = arg0;
        (v0, v1, v2, v3)
    }

    fun destroy_borrow_record(arg0: BorrowRecord) : (address, u8, u64, u64, u64) {
        let BorrowRecord {
            owner            : v0,
            borrow_price_sui : v1,
            start_sec        : v2,
            lockup_duration  : v3,
            expiration_sec   : v4,
        } = arg0;
        (v0, v3, v1, v2, v4)
    }

    fun destroy_executed_listing<T0>(arg0: ExecutedListing<T0>) : (address, 0x1::option::Option<HiveAsset>, u64, bool, 0x1::option::Option<0x2::balance::Balance<T0>>, address, u64, u64, u64, u64) {
        let ExecutedListing {
            listed_by_profile       : v0,
            hive_asset              : v1,
            version                 : v2,
            was_sale_listing        : v3,
            balance                 : v4,
            bidder_profile          : v5,
            executed_price_in_hsui  : v6,
            executed_price_in_sui   : v7,
            borrow_period_start_sec : v8,
            borrow_period_end_sec   : v9,
        } = arg0;
        let v10 = ExecutedListingDestroyed{
            version                : v2,
            executed_price_in_hsui : v6,
            executed_price_in_sui  : v7,
            listed_by_profile      : v0,
        };
        0x2::event::emit<ExecutedListingDestroyed>(v10);
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9)
    }

    fun destroy_lend_record(arg0: LendRecord) : (address, u64, u64, u64, u8, u64) {
        let LendRecord {
            borrower        : v0,
            version         : v1,
            lend_price_sui  : v2,
            start_sec       : v3,
            lockup_duration : v4,
            expiration_sec  : v5,
        } = arg0;
        (v0, v1, v2, v3, v4, v5)
    }

    fun destroy_listing(arg0: Listing) : (HiveAsset, address, bool, u64, u64, bool, bool, bool, u8, u64, u64) {
        let Listing {
            listed_by_profile  : v0,
            hive_asset         : v1,
            followers_only     : v2,
            followers_discount : v3,
            min_sui_price      : v4,
            is_sale_listing    : v5,
            instant_sale       : v6,
            highest_bid_sale   : v7,
            lockup_duration    : v8,
            start_sec          : v9,
            expiration_sec     : v10,
        } = arg0;
        let v11 = v1;
        let v12 = ListingDestroyed{
            version           : v11.version,
            listed_by_profile : v0,
        };
        0x2::event::emit<ListingDestroyed>(v12);
        (v11, v0, v2, v3, v4, v5, v6, v7, v8, v9, v10)
    }

    fun destroy_listing_record(arg0: ListingRecord) : (u64, bool, u64, u64, bool, bool, bool, u8, u64, u64) {
        let ListingRecord {
            version            : v0,
            followers_only     : v1,
            followers_discount : v2,
            min_sui_price      : v3,
            is_sale_listing    : v4,
            instant_sale       : v5,
            highest_bid_sale   : v6,
            lockup_duration    : v7,
            start_sec          : v8,
            expiration_sec     : v9,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9)
    }

    public fun does_user_own_profile(arg0: &HiveProfileMappingStore, arg1: address) : (bool, address) {
        let v0 = 0x2::linked_table::contains<address, address>(&arg0.owner_to_profile_mapping, arg1);
        let v1 = if (v0) {
            *0x2::linked_table::borrow<address, address>(&arg0.owner_to_profile_mapping, arg1)
        } else {
            @0x0
        };
        (v0, v1)
    }

    public fun entry_add_to_profile<T0: store + key>(arg0: &ProfileDofOwnershipCapability, arg1: &mut HiveProfile, arg2: T0, arg3: &0x2::tx_context::TxContext) {
        if (arg0.only_owner_can_add_dof) {
            authority_check(arg1, 0x2::tx_context::sender(arg3));
        };
        assert!(!0x1::vector::contains<0x1::ascii::String>(&arg1.supported_dofs, &arg0.supported_dof), 1111);
        0x1::vector::push_back<0x1::ascii::String>(&mut arg1.supported_dofs, arg0.supported_dof);
        0x2::dynamic_object_field::add<0x1::ascii::String, T0>(&mut arg1.id, arg0.supported_dof, arg2);
    }

    public fun entry_borrow_mut_from_profile<T0: store + key>(arg0: &ProfileDofOwnershipCapability, arg1: &mut HiveProfile, arg2: &0x2::tx_context::TxContext) : &mut T0 {
        if (arg0.only_owner_can_mut_dof) {
            authority_check(arg1, 0x2::tx_context::sender(arg2));
        };
        0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, T0>(&mut arg1.id, arg0.supported_dof)
    }

    public fun entry_kraft_dof_access_cap(arg0: &mut 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::config::HiveDaoCapability, arg1: &mut HiveProfileMappingStore, arg2: 0x1::ascii::String, arg3: bool, arg4: bool, arg5: bool, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<ProfileDofOwnershipCapability>(internal_kraft_dof_access_cap(arg1, arg2, arg3, arg4, arg5, arg7), arg6);
    }

    public fun entry_manager_add_to_profile<T0: store + key>(arg0: &AdminDofOwnershipCapability, arg1: &mut HiveManager, arg2: T0) {
        assert!(!0x1::vector::contains<0x1::ascii::String>(&arg1.hive_profile.supported_dofs, &arg0.dof_identifier), 1111);
        0x2::dynamic_object_field::add<0x1::ascii::String, T0>(&mut arg1.hive_profile.id, arg0.dof_identifier, arg2);
    }

    public fun entry_manager_borrow_mut_from_profile<T0: store + key>(arg0: &AdminDofOwnershipCapability, arg1: &mut HiveManager) : &mut T0 {
        0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, T0>(&mut arg1.hive_profile.id, arg0.dof_identifier)
    }

    public fun entry_manager_remove_from_profile<T0: store + key>(arg0: &AdminDofOwnershipCapability, arg1: &mut HiveManager) : T0 {
        0x2::dynamic_object_field::remove<0x1::ascii::String, T0>(&mut arg1.hive_profile.id, arg0.dof_identifier)
    }

    public fun entry_remove_from_profile<T0: store + key>(arg0: &ProfileDofOwnershipCapability, arg1: &mut HiveProfile, arg2: &0x2::tx_context::TxContext) : T0 {
        if (arg0.only_owner_can_remove_dof) {
            authority_check(arg1, 0x2::tx_context::sender(arg2));
        };
        0x2::dynamic_object_field::remove<0x1::ascii::String, T0>(&mut arg1.id, arg0.supported_dof)
    }

    fun execute_public_kraft(arg0: &0x2::clock::Clock, arg1: u64, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0xe0e81e85d25c7f0ce1de241f82139208838e3f5e656cce7059f6525b116a69f4::hsui_vault::HSuiVault, arg4: &mut HiveManager, arg5: &mut CreatorHiveKiosk, arg6: &mut PublicKraftConfig, arg7: &mut HiveProfile, arg8: 0x2::balance::Balance<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x2::object::uid_to_address(&arg7.id);
        let v1 = 1;
        let v2 = 0x2::clock::timestamp_ms(arg0);
        let v3 = calculate_kraft_price(arg1, arg5.base_price, arg5.curve_a, arg5.krafted_assets);
        assert!(v2 >= arg6.start_time, 1008);
        assert!(arg6.available_assets_to_kraft >= arg6.krafts_processed + v1, 1018);
        if (!0x2::linked_table::contains<address, u64>(&arg6.address_list, v0)) {
            0x2::linked_table::push_back<address, u64>(&mut arg6.address_list, v0, 0);
        };
        let v4 = 0x2::linked_table::borrow_mut<address, u64>(&mut arg6.address_list, v0);
        assert!(arg6.per_user_limit >= *v4 + v1, 1018);
        *v4 = *v4 + v1;
        arg6.krafts_processed = arg6.krafts_processed + v1;
        arg5.krafted_assets = arg5.krafted_assets + v1;
        let v5 = 0x2::tx_context::sender(arg9);
        let (v6, v7, _, _) = internal_kraft_hiveverse_asset(arg7, arg2, arg3, v5, v2, arg4, arg5, arg8, v3, arg9);
        deposit_hive_asset(arg7, v7);
        v6
    }

    fun execute_sale(arg0: &mut HiveManager, arg1: &0xe0e81e85d25c7f0ce1de241f82139208838e3f5e656cce7059f6525b116a69f4::hsui_vault::HSuiVault, arg2: &mut MarketPlace<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg3: &mut HSuiDisperser<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg4: u64, arg5: bool, arg6: address, arg7: u64, arg8: &mut 0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>) : (HiveAsset, ExecutedListing<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>) {
        let (v0, v1, _, _, _, v5, _, _, _, _, _) = destroy_listing(0x2::linked_table::remove<u64, Listing>(&mut arg2.active_listings, arg4));
        let v11 = v0;
        assert!(v1 != arg6, 1062);
        if (v5 && 0x2::linked_table::contains<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(&mut arg2.available_bids, arg4)) {
            let v12 = 0x2::linked_table::remove<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(&mut arg2.available_bids, arg4);
            let v13 = 0;
            while (v13 < 0x1::vector::length<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&v12)) {
                let v14 = 0x1::vector::borrow_mut<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&mut v12, v13);
                v14.is_listing_live = false;
                v14.is_valid = false;
                let v15 = BidMarkedInvalid{
                    version        : arg4,
                    bidder_profile : v14.bidder_profile,
                };
                0x2::event::emit<BidMarkedInvalid>(v15);
                if (arg5 && v14.bidder_profile == arg6) {
                    let (v16, _, v18, _, _, _) = destroy_bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(0x1::vector::remove<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&mut v12, v13), arg4);
                    if (arg7 == 0) {
                        arg7 = v18;
                    };
                    0x2::balance::join<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(arg8, v16);
                    break
                };
                v13 = v13 + 1;
            };
            0x2::linked_table::push_back<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(&mut arg2.available_bids, arg4, v12);
        };
        let v22 = 0xe0e81e85d25c7f0ce1de241f82139208838e3f5e656cce7059f6525b116a69f4::hsui_vault::get_sui_by_hsui(arg1, arg7);
        let v23 = ExecutedListing<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>{
            listed_by_profile       : v1,
            hive_asset              : 0x1::option::none<HiveAsset>(),
            version                 : arg4,
            was_sale_listing        : v5,
            balance                 : 0x1::option::some<0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(process_royalty(0x2::balance::split<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(arg8, arg7), arg0, arg3, v11.creator_profile)),
            bidder_profile          : arg6,
            executed_price_in_hsui  : arg7,
            executed_price_in_sui   : v22,
            borrow_period_start_sec : 0,
            borrow_period_end_sec   : 0,
        };
        let v24 = SaleExecuted{
            version         : arg4,
            buyer_profile   : arg6,
            seller_profile  : v1,
            price_paid_hsui : arg7,
            price_paid_sui  : v22,
        };
        0x2::event::emit<SaleExecuted>(v24);
        (v11, v23)
    }

    fun execute_whitelisted_kraft(arg0: bool, arg1: &mut CreatorHiveKiosk, arg2: &0x2::clock::Clock, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xe0e81e85d25c7f0ce1de241f82139208838e3f5e656cce7059f6525b116a69f4::hsui_vault::HSuiVault, arg5: &mut HiveManager, arg6: &mut WhitelistKraftConfig, arg7: &mut HiveProfile, arg8: 0x2::balance::Balance<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x2::object::uid_to_address(&arg7.id);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = calculate_kraft_price(0, arg6.base_price, arg6.curve_a, arg1.krafted_assets);
        let v3 = 1;
        assert!(v1 >= arg6.start_time && v1 < arg6.end_time, 1008);
        assert!(arg6.available_assets_to_kraft >= arg6.krafts_processed + v3, 1018);
        if (!0x2::linked_table::contains<address, u64>(&arg6.whitelisted_addresses, v0)) {
            assert!(arg0 && arg6.allow_followers, 1010);
            0x2::linked_table::push_back<address, u64>(&mut arg6.whitelisted_addresses, v0, arg6.per_follower_limit);
        };
        let v4 = *0x2::linked_table::borrow<address, u64>(&mut arg6.whitelisted_addresses, v0);
        assert!(v3 <= v4, 1014);
        *0x2::linked_table::borrow_mut<address, u64>(&mut arg6.whitelisted_addresses, v0) = v4 - v3;
        arg6.krafts_processed = arg6.krafts_processed + v3;
        arg1.krafted_assets = arg1.krafted_assets + v3;
        let v5 = 0x2::tx_context::sender(arg9);
        let (v6, v7, _, _) = internal_kraft_hiveverse_asset(arg7, arg3, arg4, v5, v1, arg5, arg1, arg8, v2, arg9);
        deposit_hive_asset(arg7, v7);
        v6
    }

    public fun exists_for_profile(arg0: &HiveProfile, arg1: 0x1::ascii::String) : bool {
        0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, arg1)
    }

    fun extract_collected_creator_royalty(arg0: &mut HiveManager, arg1: &mut HiveProfile) : 0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI> {
        let v0 = 0x2::object::uid_to_address(&arg1.id);
        if (!0x2::linked_table::contains<address, 0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&arg0.creator_royalties, v0)) {
            0x2::balance::zero<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>()
        } else {
            let v2 = 0x2::balance::withdraw_all<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(0x2::linked_table::borrow_mut<address, 0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&mut arg0.creator_royalties, v0));
            let v3 = RoyaltyCollectedForCreator{
                creator_profile : v0,
                username        : arg1.username,
                hsui_collected  : 0x2::balance::value<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&v2),
            };
            0x2::event::emit<RoyaltyCollectedForCreator>(v3);
            v2
        }
    }

    public fun follow_profile(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &mut HiveProfile, arg3: &mut HiveProfile, arg4: &mut HiveDisperser, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        authority_check(arg2, 0x2::tx_context::sender(arg6));
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x2::object::uid_to_address(&arg3.id);
        let v2 = 0x2::object::uid_to_address(&arg2.id);
        assert!(v1 != v2, 1087);
        let v3 = *0x2::table::borrow<u8, u64>(&arg3.subscriptions, (arg5 as u8));
        let v4 = calc_next_payment_timestamp(v0, (arg5 as u8));
        if (!0x2::linked_table::contains<address, SubscriptionRecord>(&arg2.following_list, v1)) {
            let v5 = SubscriptionRecord{
                follower               : v2,
                following              : v1,
                is_active              : true,
                init_timestamp         : 0x2::clock::timestamp_ms(arg0),
                subscription_type      : arg5,
                subscription_cost      : v3,
                next_payment_timestamp : v4,
                total_paid             : v3,
                switch_to_plan         : 0x1::option::none<u64>(),
                switch_to_plan_price   : 0x1::option::none<u64>(),
            };
            0x2::linked_table::push_back<address, SubscriptionRecord>(&mut arg2.following_list, v1, v5);
            0x2::linked_table::push_back<address, SubscriptionRecord>(&mut arg3.followers_list, v2, v5);
        } else {
            let v6 = 0x2::linked_table::borrow_mut<address, SubscriptionRecord>(&mut arg2.following_list, v1);
            let v7 = 0x2::linked_table::borrow_mut<address, SubscriptionRecord>(&mut arg3.followers_list, v2);
            if (v6.is_active) {
                return
            };
            assert!(v0 > v6.next_payment_timestamp, 1096);
            v6.subscription_type = arg5;
            v6.subscription_cost = v3;
            v6.next_payment_timestamp = v4;
            v6.total_paid = v6.total_paid + v3;
            v6.is_active = true;
            v7.subscription_type = arg5;
            v7.subscription_cost = v3;
            v7.next_payment_timestamp = v4;
            v7.total_paid = v7.total_paid + v3;
            v7.is_active = true;
        };
        0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::join(&mut arg3.available_gems, internal_process_subscription_payment(arg1, arg4, v2, v1, 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::split(&mut arg2.available_gems, v3), arg5, v3));
        let v8 = SubscribedToProfile{
            follower_profile_addr  : v2,
            profile_followed_addr  : v1,
            follower_username      : 0x1::string::from_ascii(arg2.username),
            followed_username      : 0x1::string::from_ascii(arg3.username),
            subscription_type      : arg5,
            subscription_cost      : v3,
            next_payment_timestamp : v4,
        };
        0x2::event::emit<SubscribedToProfile>(v8);
    }

    public(friend) fun friend_kraft_dof_access_cap(arg0: &mut HiveProfileMappingStore, arg1: 0x1::ascii::String, arg2: bool, arg3: bool, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : ProfileDofOwnershipCapability {
        internal_kraft_dof_access_cap(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun get_accrued_harvest_for_asset(arg0: &HiveManager, arg1: &HSuiDisperser<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg2: &HiveDisperser, arg3: &HiveProfile, arg4: u64) : (u64, u64) {
        let v0 = 0x2::linked_table::borrow<u64, HiveAsset>(&arg3.hive_assets, arg4);
        if (arg0.active_power == 0 || !v0.is_staked) {
            return (0, 0)
        };
        (compute_harvest_by_gems(arg1.global_dispersal_index + 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::math::mul_div_u256((0x2::balance::value<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&arg1.incoming_hsui_for_assets) as u256), (1000000000000000000 as u256), (arg0.active_power as u256)), v0.claim_index, v0.power), compute_harvest_by_gems(arg2.global_dispersal_index + 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::math::mul_div_u256((0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::value(&arg2.incoming_gems_for_assets) as u256), (1000000000000000000 as u256), (arg0.active_power as u256)), v0.gems_claim_index, v0.power))
    }

    public fun get_active_power(arg0: &HiveManager) : u128 {
        arg0.active_power
    }

    public fun get_admin_hive_profile_info(arg0: &HiveManager) : (address, 0x1::string::String) {
        (0x2::object::uid_to_address(&arg0.hive_profile.id), 0x1::string::from_ascii(arg0.hive_profile.username))
    }

    public fun get_all_creators_and_kiosks_count(arg0: &HiveProfileMappingStore, arg1: 0x1::option::Option<address>, arg2: u64) : (vector<address>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = if (0x1::option::is_some<address>(&arg1)) {
            0x1::option::some<address>(*0x1::option::borrow<address>(&arg1))
        } else {
            *0x2::linked_table::front<address, vector<address>>(&arg0.profile_to_creator_kiosk_mapping)
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<address>(&v3) && v4 < arg2) {
            let v5 = 0x1::option::borrow<address>(&v3);
            0x1::vector::push_back<address>(&mut v0, *v5);
            0x1::vector::push_back<u64>(&mut v1, 0x1::vector::length<address>(0x2::linked_table::borrow<address, vector<address>>(&arg0.profile_to_creator_kiosk_mapping, *v5)));
            v3 = *0x2::linked_table::next<address, vector<address>>(&arg0.profile_to_creator_kiosk_mapping, *v5);
            v4 = v4 + 1;
        };
        (v0, v1, 0x2::linked_table::length<address, vector<address>>(&arg0.profile_to_creator_kiosk_mapping))
    }

    public fun get_all_dof_identifers_and_caps(arg0: &HiveProfileMappingStore, arg1: 0x1::option::Option<0x1::ascii::String>, arg2: u64) : (vector<0x1::ascii::String>, vector<address>, u64) {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = 0x1::vector::empty<address>();
        let v2 = if (0x1::option::is_some<0x1::ascii::String>(&arg1)) {
            0x1::option::some<0x1::ascii::String>(*0x1::option::borrow<0x1::ascii::String>(&arg1))
        } else {
            *0x2::linked_table::front<0x1::ascii::String, address>(&arg0.dof_identifiers_to_cap_mapping)
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<0x1::ascii::String>(&v3) && v4 < arg2) {
            let v5 = 0x1::option::borrow<0x1::ascii::String>(&v3);
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, *v5);
            0x1::vector::push_back<address>(&mut v1, *0x2::linked_table::borrow<0x1::ascii::String, address>(&arg0.dof_identifiers_to_cap_mapping, *v5));
            v3 = *0x2::linked_table::next<0x1::ascii::String, address>(&arg0.dof_identifiers_to_cap_mapping, *v5);
            v4 = v4 + 1;
        };
        (v0, v1, 0x2::linked_table::length<0x1::ascii::String, address>(&arg0.dof_identifiers_to_cap_mapping))
    }

    public fun get_all_owners_and_profiles_list(arg0: &HiveProfileMappingStore, arg1: 0x1::option::Option<address>, arg2: u64) : (vector<address>, vector<address>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<address>();
        let v2 = if (0x1::option::is_some<address>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<address, address>(&arg0.owner_to_profile_mapping)
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<address>(&v3) && v4 < arg2) {
            let v5 = 0x1::option::borrow<address>(&v3);
            0x1::vector::push_back<address>(&mut v0, *v5);
            0x1::vector::push_back<address>(&mut v1, *0x2::linked_table::borrow<address, address>(&arg0.owner_to_profile_mapping, *v5));
            v3 = *0x2::linked_table::next<address, address>(&arg0.owner_to_profile_mapping, *v5);
            v4 = v4 + 1;
        };
        (v0, v1, 0x2::linked_table::length<address, address>(&arg0.owner_to_profile_mapping))
    }

    public fun get_all_usernames_and_comp_profiles_list(arg0: &HiveProfileMappingStore, arg1: 0x1::option::Option<0x1::string::String>, arg2: u64) : (vector<0x1::ascii::String>, vector<address>, u64) {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = 0x1::vector::empty<address>();
        let v2 = if (0x1::option::is_some<0x1::string::String>(&arg1)) {
            0x1::option::some<0x1::ascii::String>(0x1::string::to_ascii(*0x1::option::borrow<0x1::string::String>(&arg1)))
        } else {
            *0x2::linked_table::front<0x1::ascii::String, address>(&arg0.username_to_comp_profile_mapping)
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<0x1::ascii::String>(&v3) && v4 < arg2) {
            let v5 = 0x1::option::borrow<0x1::ascii::String>(&v3);
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, *v5);
            0x1::vector::push_back<address>(&mut v1, *0x2::linked_table::borrow<0x1::ascii::String, address>(&arg0.username_to_comp_profile_mapping, *v5));
            v3 = *0x2::linked_table::next<0x1::ascii::String, address>(&arg0.username_to_comp_profile_mapping, *v5);
            v4 = v4 + 1;
        };
        (v0, v1, 0x2::linked_table::length<0x1::ascii::String, address>(&arg0.username_to_comp_profile_mapping))
    }

    public fun get_all_usernames_and_profiles_list(arg0: &HiveProfileMappingStore, arg1: 0x1::option::Option<0x1::string::String>, arg2: u64) : (vector<0x1::ascii::String>, vector<address>, u64) {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = 0x1::vector::empty<address>();
        let v2 = if (0x1::option::is_some<0x1::string::String>(&arg1)) {
            0x1::option::some<0x1::ascii::String>(0x1::string::to_ascii(*0x1::option::borrow<0x1::string::String>(&arg1)))
        } else {
            *0x2::linked_table::front<0x1::ascii::String, address>(&arg0.username_to_profile_mapping)
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<0x1::ascii::String>(&v3) && v4 < arg2) {
            let v5 = 0x1::option::borrow<0x1::ascii::String>(&v3);
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, *v5);
            0x1::vector::push_back<address>(&mut v1, *0x2::linked_table::borrow<0x1::ascii::String, address>(&arg0.username_to_profile_mapping, *v5));
            v3 = *0x2::linked_table::next<0x1::ascii::String, address>(&arg0.username_to_profile_mapping, *v5);
            v4 = v4 + 1;
        };
        (v0, v1, 0x2::linked_table::length<0x1::ascii::String, address>(&arg0.username_to_profile_mapping))
    }

    public fun get_asset_owner_profile(arg0: &HiveManager, arg1: u64) : address {
        *0x2::linked_table::borrow<u64, address>(&arg0.assets_to_profile_mapping, arg1)
    }

    public fun get_asset_profile_owners_list(arg0: &HiveManager, arg1: 0x1::option::Option<u64>, arg2: u64) : (vector<u64>, vector<address>, u64) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<address>();
        let v2 = if (0x1::option::is_some<u64>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<u64, address>(&arg0.assets_to_profile_mapping)
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<u64>(&v3) && v4 < arg2) {
            let v5 = 0x1::option::borrow<u64>(&v3);
            0x1::vector::push_back<u64>(&mut v0, *v5);
            0x1::vector::push_back<address>(&mut v1, *0x2::linked_table::borrow<u64, address>(&arg0.assets_to_profile_mapping, *v5));
            v3 = *0x2::linked_table::next<u64, address>(&arg0.assets_to_profile_mapping, *v5);
            v4 = v4 + 1;
        };
        (v0, v1, 0x2::linked_table::length<u64, address>(&arg0.assets_to_profile_mapping))
    }

    public fun get_asset_upgrade_info(arg0: &HiveProfile, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64) : (u64, bool, u64, 0x1::ascii::String, vector<0x1::string::String>, vector<0x1::string::String>) {
        let v0 = 0x1::vector::borrow<AssetUpgrade>(0x2::linked_table::borrow<u64, vector<AssetUpgrade>>(&borrow_from_profile<CreatorHiveKiosk>(arg0, get_kiosk_storage_identifier(arg1, arg2)).available_upgrades, arg3), arg4);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&v0.upgrade_traits_list)) {
            0x1::vector::push_back<0x1::string::String>(&mut v1, *0x2::table::borrow<0x1::string::String, 0x1::string::String>(&v0.upgrade_prompts, *0x1::vector::borrow<0x1::string::String>(&v0.upgrade_traits_list, v2)));
            v2 = v2 + 1;
        };
        (v0.upgrade_price, v0.followers_only, v0.followers_discount, 0x2::url::inner_url(&v0.upgrade_img_url), v0.upgrade_traits_list, v1)
    }

    public fun get_asset_upgrades_for_version(arg0: &HiveProfile, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64) : (vector<u64>, vector<u64>, vector<bool>, vector<u64>, vector<0x1::ascii::String>) {
        let v0 = 0x2::linked_table::borrow<u64, vector<AssetUpgrade>>(&borrow_from_profile<CreatorHiveKiosk>(arg0, get_kiosk_storage_identifier(arg1, arg2)).available_upgrades, arg3);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<bool>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<0x1::ascii::String>();
        let v6 = 0;
        while (v6 < 0x1::vector::length<AssetUpgrade>(v0)) {
            let v7 = 0x1::vector::borrow<AssetUpgrade>(v0, v6);
            0x1::vector::push_back<u64>(&mut v1, v6);
            0x1::vector::push_back<u64>(&mut v2, v7.upgrade_price);
            0x1::vector::push_back<bool>(&mut v3, v7.followers_only);
            0x1::vector::push_back<u64>(&mut v4, v7.followers_discount);
            0x1::vector::push_back<0x1::ascii::String>(&mut v5, 0x2::url::inner_url(&v7.upgrade_img_url));
            v6 = v6 + 1;
        };
        (v1, v2, v3, v4, v5)
    }

    public fun get_available_gems_in_profile(arg0: &HiveProfile) : u64 {
        0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::value(&arg0.available_gems)
    }

    public fun get_available_harvest_for_profile(arg0: &HiveManager, arg1: &HSuiDisperser<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg2: &HiveDisperser, arg3: &HiveProfile) : (u64, u64) {
        if (arg0.active_power == 0) {
            return (0, 0)
        };
        let v0 = 0;
        let v1 = 0;
        let v2 = *0x2::linked_table::front<u64, HiveAsset>(&arg3.hive_assets);
        while (0x1::option::is_some<u64>(&v2)) {
            let v3 = 0x1::option::borrow<u64>(&v2);
            let v4 = 0x2::linked_table::borrow<u64, HiveAsset>(&arg3.hive_assets, *v3);
            v0 = v0 + compute_harvest_by_gems(arg1.global_dispersal_index + 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::math::mul_div_u256((0x2::balance::value<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&arg1.incoming_hsui_for_assets) as u256), (1000000000000000000 as u256), (arg0.active_power as u256)), v4.claim_index, v4.power);
            v1 = v1 + compute_harvest_by_gems(arg2.global_dispersal_index + 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::math::mul_div_u256((0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::value(&arg2.incoming_gems_for_assets) as u256), (1000000000000000000 as u256), (arg0.active_power as u256)), v4.gems_claim_index, v4.power);
            v2 = *0x2::linked_table::next<u64, HiveAsset>(&arg3.hive_assets, *v3);
        };
        (v1, v0 + 0x2::balance::value<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&arg3.available_hsui))
    }

    public fun get_bid_record(arg0: &HiveProfile, arg1: u64) : (u64, u64, u64, bool) {
        let v0 = 0x2::linked_table::borrow<u64, BidRecord>(&arg0.bid_records, arg1);
        (v0.version, v0.offer_hsui_price, v0.expiration_sec, v0.is_asset_listed)
    }

    public fun get_bids_for_asset(arg0: &HiveProfile, arg1: u64, arg2: 0x1::option::Option<u64>, arg3: u64) : (vector<address>, vector<u64>, vector<u64>, vector<bool>, vector<bool>, u64) {
        let v0 = 0x2::linked_table::borrow<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(&arg0.incoming_bids, arg1);
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<bool>();
        let v5 = 0x1::vector::empty<bool>();
        let v6 = if (0x1::option::is_some<u64>(&arg2)) {
            0x1::option::extract<u64>(&mut arg2)
        } else {
            0
        };
        while (v6 < arg3 && v6 < 0x1::vector::length<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(v0)) {
            let v7 = 0x1::vector::borrow<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(v0, v6);
            0x1::vector::push_back<address>(&mut v1, v7.bidder_profile);
            0x1::vector::push_back<u64>(&mut v2, v7.offer_hsui_price);
            0x1::vector::push_back<u64>(&mut v3, v7.expiration_sec);
            0x1::vector::push_back<bool>(&mut v4, v7.is_listing_live);
            0x1::vector::push_back<bool>(&mut v5, v7.is_valid);
            v6 = v6 + 1;
        };
        (v1, v2, v3, v4, v5, 0x1::vector::length<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(v0))
    }

    public fun get_bids_for_listing(arg0: &MarketPlace<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg1: u64, arg2: 0x1::option::Option<u64>, arg3: u64) : (vector<address>, vector<u64>, vector<u64>, vector<bool>, vector<bool>, u64) {
        let v0 = 0x2::linked_table::borrow<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(&arg0.available_bids, arg1);
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<bool>();
        let v5 = 0x1::vector::empty<bool>();
        let v6 = if (0x1::option::is_some<u64>(&arg2)) {
            0x1::option::extract<u64>(&mut arg2)
        } else {
            0
        };
        while (v6 < arg3 && v6 < 0x1::vector::length<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(v0)) {
            let v7 = 0x1::vector::borrow<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(v0, v6);
            0x1::vector::push_back<address>(&mut v1, v7.bidder_profile);
            0x1::vector::push_back<u64>(&mut v2, v7.offer_hsui_price);
            0x1::vector::push_back<u64>(&mut v3, v7.expiration_sec);
            0x1::vector::push_back<bool>(&mut v4, v7.is_listing_live);
            0x1::vector::push_back<bool>(&mut v5, v7.is_valid);
            v6 = v6 + 1;
        };
        (v1, v2, v3, v4, v5, 0x1::vector::length<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(v0))
    }

    public fun get_borrow_record(arg0: &HiveProfile, arg1: u64) : (0x1::string::String, u8, u64, u64, u64) {
        let v0 = 0x2::linked_table::borrow<u64, BorrowRecord>(&arg0.borrow_records, arg1);
        (0x2::address::to_string(v0.owner), v0.lockup_duration, v0.borrow_price_sui, v0.start_sec, v0.expiration_sec)
    }

    public fun get_creator_royalties_list(arg0: &HiveManager, arg1: 0x1::option::Option<address>, arg2: u64) : (vector<address>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = if (0x1::option::is_some<address>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<address, 0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&arg0.creator_royalties)
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<address>(&v3) && v4 < arg2) {
            let v5 = 0x1::option::borrow<address>(&v3);
            0x1::vector::push_back<address>(&mut v0, *v5);
            0x1::vector::push_back<u64>(&mut v1, 0x2::balance::value<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(0x2::linked_table::borrow<address, 0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&arg0.creator_royalties, *v5)));
            v3 = *0x2::linked_table::next<address, 0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&arg0.creator_royalties, *v5);
            v4 = v4 + 1;
        };
        (v0, v1, 0x2::linked_table::length<address, 0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&arg0.creator_royalties))
    }

    public fun get_creator_royalty(arg0: &HiveManager, arg1: address) : u64 {
        0x2::balance::value<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(0x2::linked_table::borrow<address, 0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&arg0.creator_royalties, arg1))
    }

    public fun get_executed_listing_info(arg0: &MarketPlace<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg1: u64) : (0x1::string::String, bool, bool, bool, u64, 0x1::string::String, u64, u64, u64, u64) {
        let v0 = 0x2::linked_table::borrow<u64, ExecutedListing<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&arg0.processed_listings, arg1);
        let v1 = 0x1::option::is_some<0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&v0.balance);
        let v2 = 0;
        if (v1) {
            v2 = 0x2::balance::value<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(0x1::option::borrow<0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&v0.balance));
        };
        (0x2::address::to_string(v0.listed_by_profile), 0x1::option::is_some<HiveAsset>(&v0.hive_asset), v1, v0.was_sale_listing, v2, 0x2::address::to_string(v0.bidder_profile), v0.executed_price_in_hsui, v0.executed_price_in_sui, v0.borrow_period_start_sec, v0.borrow_period_end_sec)
    }

    public fun get_executed_listings_list(arg0: &MarketPlace<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg1: 0x1::option::Option<u64>, arg2: u64) : (vector<u64>, u64) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = if (0x1::option::is_some<u64>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<u64, ExecutedListing<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&arg0.processed_listings)
        };
        let v2 = v1;
        let v3 = 0;
        while (0x1::option::is_some<u64>(&v2) && v3 < arg2) {
            let v4 = 0x1::option::borrow<u64>(&v2);
            0x1::vector::push_back<u64>(&mut v0, *v4);
            v2 = *0x2::linked_table::next<u64, ExecutedListing<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&arg0.processed_listings, *v4);
            v3 = v3 + 1;
        };
        (v0, 0x2::linked_table::length<u64, ExecutedListing<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&arg0.processed_listings))
    }

    public fun get_follower_subscription_info(arg0: &HiveProfile, arg1: address) : (bool, u64, u64, u64, u64, u64, u64, u64) {
        if (0x2::linked_table::contains<address, SubscriptionRecord>(&arg0.followers_list, arg1)) {
            let v8 = 0x2::linked_table::borrow<address, SubscriptionRecord>(&arg0.followers_list, arg1);
            let v9 = 0;
            let v10 = 0;
            if (0x1::option::is_some<u64>(&v8.switch_to_plan)) {
                v9 = *0x1::option::borrow<u64>(&v8.switch_to_plan);
            };
            if (0x1::option::is_some<u64>(&v8.switch_to_plan_price)) {
                v10 = *0x1::option::borrow<u64>(&v8.switch_to_plan_price);
            };
            (v8.is_active, v8.init_timestamp, v8.subscription_type, v8.subscription_cost, v8.next_payment_timestamp, v8.total_paid, v9, v10)
        } else {
            (false, 0, 0, 0, 0, 0, 0, 0)
        }
    }

    public fun get_followers_and_following_length(arg0: &HiveProfile) : (u64, u64) {
        (0x2::linked_table::length<address, SubscriptionRecord>(&arg0.followers_list), 0x2::linked_table::length<address, SubscriptionRecord>(&arg0.following_list))
    }

    public fun get_followers_list(arg0: &HiveProfile, arg1: 0x1::option::Option<address>, arg2: u64) : (vector<address>, vector<bool>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<bool>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 0x1::vector::empty<u64>();
        let v8 = 0x1::vector::empty<u64>();
        let v9 = if (0x1::option::is_some<address>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<address, SubscriptionRecord>(&arg0.followers_list)
        };
        let v10 = v9;
        let v11 = 0;
        while (0x1::option::is_some<address>(&v10) && v11 < arg2) {
            let v12 = 0x1::option::borrow<address>(&v10);
            let v13 = 0x2::linked_table::borrow<address, SubscriptionRecord>(&arg0.followers_list, *v12);
            0x1::vector::push_back<address>(&mut v0, *v12);
            0x1::vector::push_back<bool>(&mut v1, v13.is_active);
            0x1::vector::push_back<u64>(&mut v2, v13.init_timestamp);
            0x1::vector::push_back<u64>(&mut v3, v13.subscription_type);
            0x1::vector::push_back<u64>(&mut v4, v13.subscription_cost);
            0x1::vector::push_back<u64>(&mut v5, v13.next_payment_timestamp);
            0x1::vector::push_back<u64>(&mut v6, v13.total_paid);
            if (0x1::option::is_some<u64>(&v13.switch_to_plan)) {
                0x1::vector::push_back<u64>(&mut v7, *0x1::option::borrow<u64>(&v13.switch_to_plan));
            } else {
                0x1::vector::push_back<u64>(&mut v7, 0);
            };
            if (0x1::option::is_some<u64>(&v13.switch_to_plan_price)) {
                0x1::vector::push_back<u64>(&mut v8, *0x1::option::borrow<u64>(&v13.switch_to_plan_price));
            } else {
                0x1::vector::push_back<u64>(&mut v8, 0);
            };
            v10 = *0x2::linked_table::next<address, SubscriptionRecord>(&arg0.followers_list, *v12);
            v11 = v11 + 1;
        };
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, 0x2::linked_table::length<address, SubscriptionRecord>(&arg0.followers_list))
    }

    public fun get_following_list(arg0: &HiveProfile, arg1: 0x1::option::Option<address>, arg2: u64) : (vector<address>, vector<bool>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<bool>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 0x1::vector::empty<u64>();
        let v8 = 0x1::vector::empty<u64>();
        let v9 = if (0x1::option::is_some<address>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<address, SubscriptionRecord>(&arg0.following_list)
        };
        let v10 = v9;
        let v11 = 0;
        while (0x1::option::is_some<address>(&v10) && v11 < arg2) {
            let v12 = 0x1::option::borrow<address>(&v10);
            let v13 = 0x2::linked_table::borrow<address, SubscriptionRecord>(&arg0.following_list, *v12);
            0x1::vector::push_back<address>(&mut v0, *v12);
            0x1::vector::push_back<bool>(&mut v1, v13.is_active);
            0x1::vector::push_back<u64>(&mut v2, v13.init_timestamp);
            0x1::vector::push_back<u64>(&mut v3, v13.subscription_type);
            0x1::vector::push_back<u64>(&mut v4, v13.subscription_cost);
            0x1::vector::push_back<u64>(&mut v5, v13.next_payment_timestamp);
            0x1::vector::push_back<u64>(&mut v6, v13.total_paid);
            if (0x1::option::is_some<u64>(&v13.switch_to_plan)) {
                0x1::vector::push_back<u64>(&mut v7, *0x1::option::borrow<u64>(&v13.switch_to_plan));
            } else {
                0x1::vector::push_back<u64>(&mut v7, 0);
            };
            if (0x1::option::is_some<u64>(&v13.switch_to_plan_price)) {
                0x1::vector::push_back<u64>(&mut v8, *0x1::option::borrow<u64>(&v13.switch_to_plan_price));
            } else {
                0x1::vector::push_back<u64>(&mut v8, 0);
            };
            v10 = *0x2::linked_table::next<address, SubscriptionRecord>(&arg0.following_list, *v12);
            v11 = v11 + 1;
        };
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, 0x2::linked_table::length<address, SubscriptionRecord>(&arg0.following_list))
    }

    public fun get_following_subscription_info(arg0: &HiveProfile, arg1: address) : (bool, u64, u64, u64, u64, u64, u64, u64) {
        if (0x2::linked_table::contains<address, SubscriptionRecord>(&arg0.following_list, arg1)) {
            let v8 = 0x2::linked_table::borrow<address, SubscriptionRecord>(&arg0.following_list, arg1);
            let v9 = 0;
            let v10 = 0;
            if (0x1::option::is_some<u64>(&v8.switch_to_plan)) {
                v9 = *0x1::option::borrow<u64>(&v8.switch_to_plan);
            };
            if (0x1::option::is_some<u64>(&v8.switch_to_plan_price)) {
                v10 = *0x1::option::borrow<u64>(&v8.switch_to_plan_price);
            };
            (v8.is_active, v8.init_timestamp, v8.subscription_type, v8.subscription_cost, v8.next_payment_timestamp, v8.total_paid, v9, v10)
        } else {
            (false, 0, 0, 0, 0, 0, 0, 0)
        }
    }

    public fun get_gems_royalty_info(arg0: &HiveManager) : (u64, u64, u64, u64) {
        (arg0.royalty.numerator, arg0.royalty.denominator, arg0.royalty.assets_dispersal_percent, arg0.royalty.assets_dispersal_percent)
    }

    public fun get_harvest_by_assets(arg0: &HiveManager, arg1: &HSuiDisperser<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg2: &HiveDisperser, arg3: &HiveProfile) : (u64, vector<u64>, u64, vector<u64>) {
        if (arg0.active_power == 0) {
            return (0, 0x1::vector::empty<u64>(), 0, 0x1::vector::empty<u64>())
        };
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = *0x2::linked_table::front<u64, HiveAsset>(&arg3.hive_assets);
        while (0x1::option::is_some<u64>(&v4)) {
            let v5 = 0x1::option::borrow<u64>(&v4);
            let v6 = 0x2::linked_table::borrow<u64, HiveAsset>(&arg3.hive_assets, *v5);
            let v7 = 0;
            let v8 = 0;
            if (v6.is_staked) {
                v7 = compute_harvest_by_gems(arg1.global_dispersal_index + 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::math::mul_div_u256((0x2::balance::value<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&arg1.incoming_hsui_for_assets) as u256), (1000000000000000000 as u256), (arg0.active_power as u256)), v6.claim_index, v6.power);
                v8 = compute_harvest_by_gems(arg2.global_dispersal_index + 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::math::mul_div_u256((0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::value(&arg2.incoming_gems_for_assets) as u256), (1000000000000000000 as u256), (arg0.active_power as u256)), v6.gems_claim_index, v6.power);
            };
            v0 = v0 + v7;
            v1 = v1 + v8;
            0x1::vector::push_back<u64>(&mut v2, v7);
            0x1::vector::push_back<u64>(&mut v3, v8);
            v4 = *0x2::linked_table::next<u64, HiveAsset>(&arg3.hive_assets, *v5);
        };
        (v0, v2, v1, v3)
    }

    public fun get_hive_disperser_info(arg0: &HiveDisperser) : (u64, u64, u256) {
        (0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::value(&arg0.incoming_gems_for_assets), 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::value(&arg0.gems_for_assets), arg0.global_dispersal_index)
    }

    public fun get_hive_manager_info(arg0: &HiveManager) : (address, u64, u64, u64, u128, u64, u64) {
        (0x2::object::uid_to_address(&arg0.hive_profile.id), arg0.active_assets, arg0.locked_assets, arg0.max_assets_limit, arg0.active_power, 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::value(&arg0.hive_profile.available_gems), 0x2::balance::value<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&arg0.buidlers_royalty))
    }

    public fun get_hive_manager_params_info(arg0: &HiveManager) : (u64, u64, u64, u64) {
        (arg0.config_params.max_bids_per_asset, arg0.config_params.min_sui_bid_allowed, arg0.config_params.profile_kraft_fees_sui, arg0.config_params.social_fee_gems)
    }

    public fun get_hivecard_info(arg0: &HiveProfile, arg1: u64) : (0x1::string::String, u64, u64, u64, u256, u256, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, u64, u64, bool, bool, u8, u64, address) {
        let v0 = 0x2::linked_table::borrow<u64, HiveAsset>(&arg0.hive_assets, arg1);
        (0x2::address::to_string(0x2::object::uid_to_address(&v0.id)), v0.version, v0.power, 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::value(&v0.available_gems), v0.claim_index, v0.gems_claim_index, v0.name, 0x1::string::from_ascii(0x2::url::inner_url(&v0.img_url)), v0.aesthetic, v0.type, v0.total_hsui_claimed, v0.total_gems_claimed, v0.is_borrowed, v0.is_staked, v0.lockup_duration, v0.unlock_timestamp, v0.creator_profile)
    }

    public fun get_hivekiosk_info(arg0: &HiveProfile, arg1: 0x1::string::String, arg2: 0x1::string::String) : (0x1::string::String, u64, 0x1::ascii::String, vector<0x1::string::String>, u64, u64, u64, u64, bool, u64, u64) {
        let v0 = borrow_from_profile<CreatorHiveKiosk>(arg0, get_kiosk_storage_identifier(arg1, arg2));
        (0x2::address::to_string(0x2::object::uid_to_address(&v0.id)), v0.init_hive_gems, 0x2::url::inner_url(&v0.img_url), v0.traits_list, v0.max_assets_limit, v0.krafted_assets, v0.base_price, v0.curve_a, v0.followers_only, v0.followers_discount, v0.module_version)
    }

    public fun get_hsui_disperser_info<T0>(arg0: &HSuiDisperser<T0>) : (u64, u64, u256) {
        (0x2::balance::value<T0>(&arg0.incoming_hsui_for_assets), 0x2::balance::value<T0>(&arg0.hsui_for_assets), arg0.global_dispersal_index)
    }

    fun get_kiosk_storage_identifier(arg0: 0x1::string::String, arg1: 0x1::string::String) : 0x1::ascii::String {
        let v0 = 0x1::string::utf8(b"creator_kiosk");
        0x1::string::append(&mut v0, 0x1::string::utf8(b"::"));
        0x1::string::append(&mut v0, arg0);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"::"));
        0x1::string::append(&mut v0, arg1);
        0x1::string::to_ascii(v0)
    }

    public fun get_kiosks_list_for_creator(arg0: &HiveProfileMappingStore, arg1: address) : vector<address> {
        *0x2::linked_table::borrow<address, vector<address>>(&arg0.profile_to_creator_kiosk_mapping, arg1)
    }

    public fun get_krafted_versions_for_kiosk(arg0: &HiveProfile, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::option::Option<u64>, arg4: u64) : vector<u64> {
        let v0 = borrow_from_profile<CreatorHiveKiosk>(arg0, get_kiosk_storage_identifier(arg1, arg2));
        let v1 = 0x1::vector::empty<u64>();
        let v2 = if (0x1::option::is_some<u64>(&arg3)) {
            arg3
        } else {
            *0x2::linked_table::front<u64, address>(&v0.krafted_versions_map)
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<u64>(&v3) && v4 < arg4) {
            let v5 = 0x1::option::borrow<u64>(&v3);
            0x1::vector::push_back<u64>(&mut v1, *v5);
            v3 = *0x2::linked_table::next<u64, address>(&v0.krafted_versions_map, *v5);
            v4 = v4 + 1;
        };
        v1
    }

    public fun get_lend_record(arg0: &HiveProfile, arg1: u64) : (0x1::string::String, u64, u64, u64, u64) {
        let v0 = 0x2::linked_table::borrow<u64, LendRecord>(&arg0.lend_records, arg1);
        (0x2::address::to_string(v0.borrower), v0.version, v0.lend_price_sui, v0.start_sec, v0.expiration_sec)
    }

    public fun get_listed_assets_in_marketplace(arg0: &MarketPlace<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg1: 0x1::option::Option<u64>, arg2: u64) : (vector<u64>, u64) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = if (0x1::option::is_some<u64>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<u64, Listing>(&arg0.active_listings)
        };
        let v2 = v1;
        let v3 = 0;
        while (0x1::option::is_some<u64>(&v2) && v3 < arg2) {
            let v4 = 0x1::option::borrow<u64>(&v2);
            0x1::vector::push_back<u64>(&mut v0, *v4);
            v2 = *0x2::linked_table::next<u64, Listing>(&arg0.active_listings, *v4);
            v3 = v3 + 1;
        };
        (v0, 0x2::linked_table::length<u64, Listing>(&arg0.active_listings))
    }

    public fun get_listing_from_marketplace(arg0: &MarketPlace<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg1: u64) : (0x1::string::String, bool, u64, u64, bool, bool, bool, u8, u64, u64) {
        let v0 = 0x2::linked_table::borrow<u64, Listing>(&arg0.active_listings, arg1);
        (0x2::address::to_string(v0.listed_by_profile), v0.followers_only, v0.followers_discount, v0.min_sui_price, v0.is_sale_listing, v0.instant_sale, v0.highest_bid_sale, v0.lockup_duration, v0.start_sec, v0.expiration_sec)
    }

    public fun get_listing_record(arg0: &HiveProfile, arg1: u64) : (bool, u64, u64, bool, bool, bool, u8, u64, u64) {
        let v0 = 0x2::linked_table::borrow<u64, ListingRecord>(&arg0.listing_records, arg1);
        (v0.followers_only, v0.followers_discount, v0.min_sui_price, v0.is_sale_listing, v0.instant_sale, v0.highest_bid_sale, v0.lockup_duration, v0.start_sec, v0.expiration_sec)
    }

    public fun get_prices_for_public_hive_asset_krafts(arg0: &0x2::clock::Clock, arg1: &mut HiveProfile, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: u64) : (u64, vector<u64>, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = get_kiosk_storage_identifier(arg2, arg3);
        let v2 = borrow_from_profile<CreatorHiveKiosk>(arg1, v1);
        let v3 = false;
        let v4 = 0;
        if (0x2::linked_table::contains<address, SubscriptionRecord>(&arg1.followers_list, arg4)) {
            let v5 = 0x2::linked_table::borrow<address, SubscriptionRecord>(&arg1.followers_list, arg4);
            if (v0 < v5.next_payment_timestamp && v5.is_active) {
                v3 = true;
                v4 = v2.followers_discount;
            };
        };
        if (v2.followers_only && !v3) {
            return (0, 0x1::vector::empty<u64>(), 0)
        };
        let v6 = 0;
        let v7 = 0x1::vector::empty<u64>();
        let v8 = 0x1::string::from_ascii(v1);
        0x1::string::append(&mut v8, 0x1::string::utf8(b"::PUBLIC_KRAFT_CONFIG"));
        let v9 = borrow_from_profile<PublicKraftConfig>(arg1, 0x1::string::to_ascii(v8));
        if (v0 < v9.start_time) {
            v6 = v9.start_time - v0;
        };
        let v10 = if (0x2::linked_table::contains<address, u64>(&v9.address_list, arg4)) {
            v9.per_user_limit - *0x2::linked_table::borrow<address, u64>(&v9.address_list, arg4)
        } else {
            v9.per_user_limit
        };
        if (v9.available_assets_to_kraft - v9.krafts_processed < v10) {
            v10 = v9.available_assets_to_kraft - v9.krafts_processed;
        };
        if (v10 > v2.max_assets_limit - v2.krafted_assets) {
            v10 = v2.max_assets_limit - v2.krafted_assets;
        };
        let v11 = v2.krafted_assets;
        let v12 = 0;
        while (v12 < arg5) {
            let v13 = calculate_kraft_price(v4, v2.base_price, v2.curve_a, v11);
            v11 = v11 + 1;
            0x1::vector::push_back<u64>(&mut v7, v13);
            v12 = v12 + 1;
        };
        (v6, v7, v10)
    }

    public fun get_prices_for_wl_hive_asset_krafts(arg0: &0x2::clock::Clock, arg1: &HiveProfile, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address) : (u64, vector<u64>, u64, bool) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = borrow_from_profile<CreatorHiveKiosk>(arg1, get_kiosk_storage_identifier(arg2, arg3));
        let v2 = false;
        if (0x2::linked_table::contains<address, SubscriptionRecord>(&arg1.followers_list, arg4)) {
            let v3 = 0x2::linked_table::borrow<address, SubscriptionRecord>(&arg1.followers_list, arg4);
            if (v0 < v3.next_payment_timestamp && v3.is_active) {
                v2 = true;
            };
        };
        if (v1.followers_only && !v2) {
            return (0, 0x1::vector::empty<u64>(), 0, false)
        };
        let v4 = 0;
        let v5 = v4;
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 0x1::string::from_ascii(get_kiosk_storage_identifier(arg2, arg3));
        0x1::string::append(&mut v7, 0x1::string::utf8(b"::WHITELISTED_KRAFT_CONFIG"));
        let v8 = borrow_from_profile<WhitelistKraftConfig>(arg1, 0x1::string::to_ascii(v7));
        let v9 = 0x2::linked_table::contains<address, u64>(&v8.whitelisted_addresses, arg4);
        if (v0 < v8.start_time) {
            v5 = v8.start_time - v0;
        } else if (v8.end_time < v0) {
            return (v4, v6, 0, false)
        };
        let v10 = if (v9) {
            *0x2::linked_table::borrow<address, u64>(&v8.whitelisted_addresses, arg4)
        } else if (v8.allow_followers && v2) {
            v8.per_follower_limit
        } else {
            return (v5, v6, 0, v9)
        };
        if (v8.available_assets_to_kraft - v8.krafts_processed < v10) {
            v10 = v8.available_assets_to_kraft - v8.krafts_processed;
        };
        if (v10 > v1.max_assets_limit - v1.krafted_assets) {
            v10 = v1.max_assets_limit - v1.krafted_assets;
        };
        let v11 = 0;
        while (v11 < v10) {
            0x1::vector::push_back<u64>(&mut v6, calculate_kraft_price(0, v8.base_price, v8.curve_a, v1.krafted_assets));
            v11 = v11 + 1;
        };
        (v5, v6, v10, v9)
    }

    public fun get_profile_bio(arg0: &HiveProfile) : 0x1::string::String {
        arg0.bio
    }

    public fun get_profile_dof_capability_identifier(arg0: &ProfileDofOwnershipCapability) : 0x1::ascii::String {
        arg0.supported_dof
    }

    public fun get_profile_for_username(arg0: &HiveProfileMappingStore, arg1: 0x1::string::String) : (bool, address) {
        let v0 = 0x1::string::to_ascii(arg1);
        let v1 = 0x2::linked_table::contains<0x1::ascii::String, address>(&arg0.username_to_profile_mapping, v0);
        let v2 = if (v1) {
            *0x2::linked_table::borrow<0x1::ascii::String, address>(&arg0.username_to_profile_mapping, v0)
        } else {
            @0x0
        };
        (v1, v2)
    }

    public fun get_profile_info(arg0: &HiveProfile) : (0x1::string::String, u64, 0x1::string::String, bool, u64, vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = *0x2::linked_table::front<u64, HiveAsset>(&arg0.hive_assets);
        while (0x1::option::is_some<u64>(&v5)) {
            0x1::vector::push_back<u64>(&mut v0, *0x1::option::borrow<u64>(&v5));
            let v6 = 0x2::linked_table::next<u64, HiveAsset>(&arg0.hive_assets, *0x1::option::borrow<u64>(&v5));
            v5 = *v6;
        };
        let v7 = *0x2::linked_table::front<u64, BorrowRecord>(&arg0.borrow_records);
        while (0x1::option::is_some<u64>(&v7)) {
            0x1::vector::push_back<u64>(&mut v1, *0x1::option::borrow<u64>(&v7));
            let v8 = 0x2::linked_table::next<u64, BorrowRecord>(&arg0.borrow_records, *0x1::option::borrow<u64>(&v7));
            v7 = *v8;
        };
        let v9 = *0x2::linked_table::front<u64, ListingRecord>(&arg0.listing_records);
        while (0x1::option::is_some<u64>(&v9)) {
            0x1::vector::push_back<u64>(&mut v2, *0x1::option::borrow<u64>(&v9));
            let v10 = 0x2::linked_table::next<u64, ListingRecord>(&arg0.listing_records, *0x1::option::borrow<u64>(&v9));
            v9 = *v10;
        };
        let v11 = *0x2::linked_table::front<u64, BidRecord>(&arg0.bid_records);
        while (0x1::option::is_some<u64>(&v11)) {
            0x1::vector::push_back<u64>(&mut v3, *0x1::option::borrow<u64>(&v11));
            let v12 = 0x2::linked_table::next<u64, BidRecord>(&arg0.bid_records, *0x1::option::borrow<u64>(&v11));
            v11 = *v12;
        };
        let v13 = *0x2::linked_table::front<u64, LendRecord>(&arg0.lend_records);
        while (0x1::option::is_some<u64>(&v13)) {
            0x1::vector::push_back<u64>(&mut v4, *0x1::option::borrow<u64>(&v13));
            let v14 = 0x2::linked_table::next<u64, LendRecord>(&arg0.lend_records, *0x1::option::borrow<u64>(&v13));
            v13 = *v14;
        };
        (0x1::string::from_ascii(arg0.username), arg0.creation_timestamp, 0x2::address::to_string(arg0.owner), arg0.is_composable_profile, 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::value(&arg0.available_gems), v0, v1, v2, v3, v4, 0x2::balance::value<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&arg0.available_hsui))
    }

    public fun get_profile_meta_info(arg0: &HiveProfile) : (address, 0x1::string::String, bool, address) {
        (0x2::object::uid_to_address(&arg0.id), 0x1::string::from_ascii(arg0.username), arg0.is_composable_profile, arg0.owner)
    }

    public fun get_profile_owner(arg0: &HiveProfile) : address {
        arg0.owner
    }

    public fun get_profile_username(arg0: &HiveProfile) : 0x1::string::String {
        0x1::string::from_ascii(arg0.username)
    }

    public fun get_prompts_for_hive_asset(arg0: &HiveProfile, arg1: u64) : (vector<0x1::string::String>, vector<0x1::string::String>) {
        let v0 = 0x2::linked_table::borrow<u64, HiveAsset>(&arg0.hive_assets, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = *0x2::linked_table::front<0x1::string::String, 0x1::string::String>(&v0.prompts);
        let v4 = 0;
        while (v4 < 0x2::linked_table::length<0x1::string::String, 0x1::string::String>(&v0.prompts)) {
            let v5 = 0x1::option::borrow<0x1::string::String>(&v3);
            0x1::vector::push_back<0x1::string::String>(&mut v1, *v5);
            0x1::vector::push_back<0x1::string::String>(&mut v2, *0x2::linked_table::borrow<0x1::string::String, 0x1::string::String>(&v0.prompts, *v5));
            v4 = v4 + 1;
        };
        (v1, v2)
    }

    public fun get_public_kraft_config_info(arg0: &HiveProfile, arg1: 0x1::string::String, arg2: 0x1::string::String) : (u64, u64, u64, u64) {
        let v0 = 0x1::string::from_ascii(get_kiosk_storage_identifier(arg1, arg2));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"::PUBLIC_KRAFT_CONFIG"));
        let v1 = borrow_from_profile<PublicKraftConfig>(arg0, 0x1::string::to_ascii(v0));
        (v1.start_time, v1.per_user_limit, v1.available_assets_to_kraft, v1.krafts_processed)
    }

    public fun get_royalty_info(arg0: &HiveManager) : (u64, u64, u64, u64) {
        (arg0.gems_royalty.numerator, arg0.gems_royalty.denominator, arg0.gems_royalty.treasury_percent, arg0.gems_royalty.burn_percent)
    }

    public fun get_skins_info_for_asset(arg0: &HiveProfile, arg1: u64, arg2: 0x1::option::Option<0x1::string::String>, arg3: u64) : (vector<0x1::string::String>, vector<bool>, vector<bool>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, u64) {
        let v0 = 0x2::linked_table::borrow<u64, HiveAsset>(&arg0.hive_assets, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0x1::vector::empty<bool>();
        let v3 = 0x1::vector::empty<bool>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 0x1::vector::empty<u64>();
        let v8 = if (0x1::option::is_some<0x1::string::String>(&arg2)) {
            arg2
        } else {
            *0x2::linked_table::front<0x1::string::String, SkinRecord>(&v0.active_skins)
        };
        let v9 = v8;
        let v10 = 0;
        while (0x1::option::is_some<0x1::string::String>(&v9) && v10 < arg3) {
            let v11 = 0x1::option::borrow<0x1::string::String>(&v9);
            let v12 = 0x2::linked_table::borrow<0x1::string::String, SkinRecord>(&v0.active_skins, *v11);
            0x1::vector::push_back<0x1::string::String>(&mut v1, *v11);
            0x1::vector::push_back<bool>(&mut v2, v12.public_skin_kraft_enabled);
            0x1::vector::push_back<bool>(&mut v3, v12.only_followers_allowed);
            0x1::vector::push_back<u64>(&mut v4, v12.followers_discount);
            0x1::vector::push_back<u64>(&mut v5, v12.royalty_fee_percent);
            0x1::vector::push_back<u64>(&mut v6, v12.total_gems_ported);
            0x1::vector::push_back<u64>(&mut v7, v12.total_skins_krafted);
            v9 = *0x2::linked_table::next<0x1::string::String, SkinRecord>(&v0.active_skins, *v11);
            v10 = v10 + 1;
        };
        (v1, v2, v3, v4, v5, v6, v7, 0x2::linked_table::length<0x1::string::String, SkinRecord>(&v0.active_skins))
    }

    public fun get_voting_power_for_profile(arg0: &0x2::clock::Clock, arg1: &HiveProfile) : u64 {
        let v0 = 0;
        let v1 = *0x2::linked_table::front<u64, HiveAsset>(&arg1.hive_assets);
        while (0x1::option::is_some<u64>(&v1)) {
            let v2 = 0x1::option::borrow<u64>(&v1);
            let v3 = 0x2::linked_table::borrow<u64, HiveAsset>(&arg1.hive_assets, *v2);
            if (v3.is_staked && v3.unlock_timestamp > 0x2::clock::timestamp_ms(arg0)) {
                v0 = v0 + v3.power;
            };
            v1 = *0x2::linked_table::next<u64, HiveAsset>(&arg1.hive_assets, *v2);
        };
        v0
    }

    public fun get_whitelisted_kraft_config_info(arg0: &HiveProfile, arg1: 0x1::string::String, arg2: 0x1::string::String) : (u64, u64, bool, u64, u64, u64, u64, u64) {
        let v0 = 0x1::string::from_ascii(get_kiosk_storage_identifier(arg1, arg2));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"::WHITELISTED_KRAFT_CONFIG"));
        let v1 = borrow_from_profile<WhitelistKraftConfig>(arg0, 0x1::string::to_ascii(v0));
        (v1.start_time, v1.end_time, v1.allow_followers, v1.per_follower_limit, v1.available_assets_to_kraft, v1.krafts_processed, v1.base_price, v1.curve_a)
    }

    public entry fun handle_expired_listings(arg0: &0x2::clock::Clock, arg1: &mut MarketPlace<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg2: &mut HiveProfile, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 1079);
        let v0 = *0x2::linked_table::front<u64, ListingRecord>(&arg2.listing_records);
        while (0x1::option::is_some<u64>(&v0)) {
            let v1 = *0x1::option::borrow<u64>(&v0);
            let v2 = 0x2::linked_table::borrow<u64, ListingRecord>(&arg2.listing_records, v1);
            v0 = *0x2::linked_table::next<u64, ListingRecord>(&arg2.listing_records, v1);
            if (v2.expiration_sec > 0x2::clock::timestamp_ms(arg0) || v2.highest_bid_sale) {
                continue
            };
            let v3 = 0x2::linked_table::remove<u64, Listing>(&mut arg1.active_listings, v1);
            let v4 = ListingExpired{
                listed_by_profile : v3.listed_by_profile,
                version           : v1,
            };
            0x2::event::emit<ListingExpired>(v4);
            let (v5, _, _, _, _, _, _, _, _, _, _) = destroy_listing(v3);
            let (_, _, _, _, _, _, _, _, _, _) = destroy_listing_record(0x2::linked_table::remove<u64, ListingRecord>(&mut arg2.listing_records, v1));
            deposit_hive_asset(arg2, v5);
            mark_marketplace_bids_as_invalid(arg1, v1);
        };
    }

    public entry fun handle_expired_marketplace_bids_for_profile(arg0: &0x2::clock::Clock, arg1: &mut MarketPlace<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg2: &mut HiveProfile, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 1079);
        let v0 = 0x2::object::uid_to_address(&arg2.id);
        let v1 = *0x2::linked_table::front<u64, BidRecord>(&arg2.bid_records);
        while (0x1::option::is_some<u64>(&v1)) {
            let v2 = *0x1::option::borrow<u64>(&v1);
            let v3 = 0x2::linked_table::borrow<u64, BidRecord>(&mut arg2.bid_records, v2);
            v1 = *0x2::linked_table::next<u64, BidRecord>(&arg2.bid_records, v2);
            if (v3.is_asset_listed && v3.expiration_sec < 0x2::clock::timestamp_ms(arg0)) {
                let v4 = 0x2::linked_table::borrow_mut<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(&mut arg1.available_bids, v2);
                0x2::balance::join<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut arg2.available_hsui, destroy_bid_among_bids(v4, v0, false, v2));
                let v5 = BidExpired{
                    version        : v2,
                    bidder_profile : v0,
                };
                0x2::event::emit<BidExpired>(v5);
                let (_, _, _, _) = destroy_bid_record(0x2::linked_table::remove<u64, BidRecord>(&mut arg2.bid_records, v2));
            };
        };
    }

    public entry fun handle_invalid_direct_bid(arg0: &0x2::clock::Clock, arg1: &mut HiveProfile, arg2: &mut HiveProfile, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 1079);
        let v0 = 0x2::object::uid_to_address(&arg2.id);
        let v1 = 0x2::linked_table::remove<u64, BidRecord>(&mut arg2.bid_records, arg3);
        let v2 = 0x2::linked_table::remove<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(&mut arg1.incoming_bids, arg3);
        let v3 = &mut v2;
        let (_, _, _, _) = destroy_bid_record(v1);
        0x2::linked_table::push_back<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(&mut arg1.incoming_bids, arg3, v2);
        0x2::balance::join<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut arg2.available_hsui, destroy_bid_among_bids(v3, v0, v1.expiration_sec >= 0x2::clock::timestamp_ms(arg0), arg3));
        let v8 = BidExpired{
            version        : arg3,
            bidder_profile : v0,
        };
        0x2::event::emit<BidExpired>(v8);
    }

    public fun handle_processed_listing(arg0: &mut HiveManager, arg1: &mut MarketPlace<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg2: &mut HiveProfile, arg3: &mut HiveProfile, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 1079);
        assert!(0x2::linked_table::contains<u64, ListingRecord>(&arg2.listing_records, arg4), 1050);
        assert!(0x2::linked_table::contains<u64, ExecutedListing<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&arg1.processed_listings, arg4), 1059);
        let (v0, v1, _, _, v4, v5, _, _, _, _) = destroy_executed_listing<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(0x2::linked_table::remove<u64, ExecutedListing<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&mut arg1.processed_listings, arg4));
        let v10 = v4;
        let v11 = v1;
        assert!(v0 == 0x2::object::uid_to_address(&arg2.id), 1050);
        if (0x1::option::is_some<0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&v10)) {
            0x2::balance::join<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut arg2.available_hsui, 0x1::option::destroy_some<0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(v10));
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(v10);
        };
        if (v5 != v0) {
            assert!(v5 == 0x2::object::uid_to_address(&arg3.id), 1061);
        };
        if (0x2::linked_table::contains<u64, BidRecord>(&arg3.bid_records, arg4)) {
            let (_, _, _, _) = destroy_bid_record(0x2::linked_table::remove<u64, BidRecord>(&mut arg3.bid_records, arg4));
        };
        if (0x1::option::is_some<HiveAsset>(&v11)) {
            update_asset_ownership(arg0, arg4, 0x2::object::uid_to_address(&arg3.id));
            deposit_hive_asset(arg3, 0x1::option::extract<HiveAsset>(&mut v11));
        };
        let (_, _, _, _, _, _, _, _, _, _) = destroy_listing_record(0x2::linked_table::remove<u64, ListingRecord>(&mut arg2.listing_records, arg4));
        0x1::option::destroy_none<HiveAsset>(v11);
    }

    public fun harvest_hive_rewards(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &mut HSuiDisperser<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg3: &mut HiveDisperser, arg4: &mut HiveProfile, arg5: &mut 0x2::tx_context::TxContext) : (0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::HiveGems, 0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0 && arg3.module_version == 0 && arg4.module_version == 0, 1079);
        authority_check(arg4, 0x2::tx_context::sender(arg5));
        increment_global_index(arg1, arg2);
        increment_gems_global_index(arg1, arg3);
        let v0 = 0x2::balance::zero<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>();
        let v1 = 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::zero();
        let v2 = extract_collected_creator_royalty(arg1, arg4);
        0x2::balance::join<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut v0, v2);
        let v3 = *0x2::linked_table::front<u64, HiveAsset>(&arg4.hive_assets);
        while (0x1::option::is_some<u64>(&v3)) {
            let v4 = 0x1::option::borrow<u64>(&v3);
            let v5 = 0x2::linked_table::borrow_mut<u64, HiveAsset>(&mut arg4.hive_assets, *v4);
            let (v6, v7, v8) = claim_accrued_rewards_for_asset(arg0, arg1, arg2, arg3, v5);
            0x2::balance::join<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut v0, v7);
            0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::join(&mut v1, v6);
            if (v8) {
                let v9 = HiveAssetUnstaked{
                    profile_addr : 0x2::object::uid_to_address(&arg4.id),
                    version      : *v4,
                };
                0x2::event::emit<HiveAssetUnstaked>(v9);
            };
            v3 = *0x2::linked_table::next<u64, HiveAsset>(&arg4.hive_assets, *v4);
        };
        0x2::balance::join<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut v0, 0x2::balance::withdraw_all<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut arg4.available_hsui));
        let v10 = DegenHiveYieldHarvested{
            harvester_profile : 0x2::object::uid_to_address(&arg4.id),
            username          : arg4.username,
            hsui_harvested    : 0x2::balance::value<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&v0),
            gems_harvested    : 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::value(&v1),
        };
        0x2::event::emit<DegenHiveYieldHarvested>(v10);
        (v1, v0)
    }

    public entry fun harvest_hive_rewards_and_transfer(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &mut HSuiDisperser<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg3: &mut HiveDisperser, arg4: &mut HiveProfile, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = harvest_hive_rewards(arg0, arg1, arg2, arg3, arg4, arg5);
        0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::join(&mut arg4.available_gems, v0);
        0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::coin_helper::destroy_or_transfer_balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(v1, 0x2::tx_context::sender(arg5), arg5);
    }

    public entry fun harvest_royalty_yield_for_builders(arg0: &0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::config::BuidlersRoyaltyCollectionAbility, arg1: &mut HiveManager, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 1079);
        let v0 = 0x2::balance::withdraw_all<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut arg1.buidlers_royalty);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(0x2::coin::from_balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(v0, arg3), arg2);
        let v1 = KraftYieldHarvested{
            sui_yield : 0x2::balance::value<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&v0),
            receiver  : arg2,
        };
        0x2::event::emit<KraftYieldHarvested>(v1);
    }

    public fun id_for_dof_of_profile(arg0: &HiveProfile, arg1: 0x1::ascii::String) : 0x1::option::Option<0x2::object::ID> {
        0x2::dynamic_object_field::id<0x1::ascii::String>(&arg0.id, arg1)
    }

    public entry fun increment_config(arg0: &mut HiveManager) {
        assert!(arg0.module_version < 0, 1080);
        arg0.module_version = 0;
    }

    fun increment_gems_global_index(arg0: &HiveManager, arg1: &mut HiveDisperser) {
        let v0 = 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::value(&arg1.incoming_gems_for_assets);
        if (arg0.active_power == 0 || v0 == 0) {
            return
        };
        arg1.global_dispersal_index = arg1.global_dispersal_index + 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::math::mul_div_u256((v0 as u256), (1000000000000000000 as u256), (arg0.active_power as u256));
        0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::join(&mut arg1.gems_for_assets, 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::withdraw_all(&mut arg1.incoming_gems_for_assets));
    }

    fun increment_global_index(arg0: &HiveManager, arg1: &mut HSuiDisperser<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>) {
        let v0 = 0x2::balance::value<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&arg1.incoming_hsui_for_assets);
        if (arg0.active_power == 0 || v0 == 0) {
            return
        };
        arg1.global_dispersal_index = arg1.global_dispersal_index + 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::math::mul_div_u256((v0 as u256), (1000000000000000000 as u256), (arg0.active_power as u256));
        0x2::balance::join<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut arg1.hsui_for_assets, 0x2::balance::withdraw_all<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut arg1.incoming_hsui_for_assets));
    }

    public entry fun increment_hive_dispenser(arg0: &mut HiveDisperser) {
        assert!(arg0.module_version < 0, 1080);
        arg0.module_version = 0;
    }

    public entry fun increment_hive_kiosk(arg0: &mut CreatorHiveKiosk) {
        assert!(arg0.module_version < 0, 1080);
        arg0.module_version = 0;
    }

    public entry fun increment_hsui_dispenser(arg0: &mut HSuiDisperser<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>) {
        assert!(arg0.module_version < 0, 1080);
        arg0.module_version = 0;
    }

    public entry fun increment_marketplace(arg0: &mut MarketPlace<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>) {
        assert!(arg0.module_version < 0, 1080);
        arg0.module_version = 0;
    }

    public entry fun increment_profile(arg0: &mut HiveProfile, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 1057);
        assert!(arg0.module_version < 0, 1080);
        arg0.module_version = 0;
    }

    public entry fun increment_profile_ids_store(arg0: &mut HiveProfileMappingStore) {
        assert!(arg0.module_version < 0, 1080);
        arg0.module_version = 0;
    }

    public fun infuse_gems_into_asset(arg0: &0x2::clock::Clock, arg1: &0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::config::HiveDaoCapability, arg2: &mut HiveManager, arg3: &mut HSuiDisperser<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg4: &mut HiveDisperser, arg5: &mut HiveProfile, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert!(arg2.module_version == 0 && arg3.module_version == 0 && arg4.module_version == 0, 1079);
        authority_check(arg5, 0x2::tx_context::sender(arg8));
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x2::linked_table::borrow_mut<u64, HiveAsset>(&mut arg5.hive_assets, arg7);
        let v3 = v2.power;
        increment_global_index(arg2, arg3);
        increment_gems_global_index(arg2, arg4);
        let (v4, v5, v6) = claim_accrued_rewards_for_asset(arg0, arg2, arg3, arg4, v2);
        0x2::balance::join<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut arg5.available_hsui, v5);
        0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::join(&mut arg5.available_gems, v4);
        if (v6) {
            let v7 = HiveAssetUnstaked{
                profile_addr : 0x2::object::uid_to_address(&arg5.id),
                version      : arg7,
            };
            0x2::event::emit<HiveAssetUnstaked>(v7);
            v1 = v3;
        };
        if (v2.is_staked && v2.unlock_timestamp > 0x2::clock::timestamp_ms(arg0)) {
            let v8 = calc_voting_power(arg6, *0x2::table::borrow<u8, u64>(&arg2.supported_lockup_durations, v2.lockup_duration));
            v0 = v8;
            v2.power = v2.power + v8;
            arg2.active_power = arg2.active_power + (v8 as u128);
            let v9 = TotalActivePowerUpdated{
                new_total_active_power : arg2.active_power,
                total_staked_assets    : arg2.locked_assets,
            };
            0x2::event::emit<TotalActivePowerUpdated>(v9);
            let v10 = CardPowerUpdated{
                version         : arg7,
                add_power       : v8,
                new_asset_power : v2.power,
            };
            0x2::event::emit<CardPowerUpdated>(v10);
        };
        0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::join(&mut v2.available_gems, 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::split(&mut arg5.available_gems, arg6));
        let v11 = HiveGemsDepositedIntoAsset{
            profile        : 0x2::object::uid_to_address(&arg5.id),
            version        : arg7,
            gems_deposited : arg6,
        };
        0x2::event::emit<HiveGemsDepositedIntoAsset>(v11);
        (v0, v1)
    }

    fun init(arg0: HIVE_PROFILE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = HiveProfileMappingStore{
            id                               : 0x2::object::new(arg1),
            owner_to_profile_mapping         : 0x2::linked_table::new<address, address>(arg1),
            username_to_profile_mapping      : 0x2::linked_table::new<0x1::ascii::String, address>(arg1),
            username_to_comp_profile_mapping : 0x2::linked_table::new<0x1::ascii::String, address>(arg1),
            profile_to_creator_kiosk_mapping : 0x2::linked_table::new<address, vector<address>>(arg1),
            dof_identifiers_to_cap_mapping   : 0x2::linked_table::new<0x1::ascii::String, address>(arg1),
            module_version                   : 0,
        };
        0x2::transfer::share_object<HiveProfileMappingStore>(v0);
        let v1 = HiveDisperser{
            id                       : 0x2::object::new(arg1),
            incoming_gems_for_assets : 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::zero(),
            gems_for_assets          : 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::zero(),
            global_dispersal_index   : 0,
            module_version           : 0,
        };
        0x2::transfer::share_object<HiveDisperser>(v1);
        let v2 = HSuiDisperser<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>{
            id                       : 0x2::object::new(arg1),
            incoming_hsui_for_assets : 0x2::balance::zero<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(),
            hsui_for_assets          : 0x2::balance::zero<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(),
            global_dispersal_index   : 0,
            module_version           : 0,
        };
        0x2::transfer::share_object<HSuiDisperser<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(v2);
        let v3 = MarketPlace<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>{
            id                 : 0x2::object::new(arg1),
            active_listings    : 0x2::linked_table::new<u64, Listing>(arg1),
            available_bids     : 0x2::linked_table::new<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(arg1),
            processed_listings : 0x2::linked_table::new<u64, ExecutedListing<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(arg1),
            module_version     : 0,
        };
        0x2::transfer::share_object<MarketPlace<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(v3);
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"username"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"bio"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"owner"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"is_composable_profile"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Website"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"version"));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"DegenHive - HiveProfile"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"HIVE-PROFILE -::- THE IDENTITY BLOCK OF DEGNENHIVE's SOCIAL-GRAPH."));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{username}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{bio}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{owner}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{is_composable_profile}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://www.app.degenhive.ai/profile"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"{module_version}"));
        let v8 = 0x2::package::claim<HIVE_PROFILE>(arg0, arg1);
        let v9 = 0x2::display::new_with_fields<HiveProfile>(&v8, v4, v6, arg1);
        0x2::display::update_version<HiveProfile>(&mut v9);
        let v10 = 0x1::vector::empty<0x1::string::String>();
        let v11 = &mut v10;
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"Collection Info"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"img_url"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"version"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"power"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"aesthetic"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"type"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"creator_profile"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"is_staked"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"is_borrowed"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"total_hsui_claimed"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"total_gems_claimed"));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"Website"));
        let v12 = 0x1::vector::empty<0x1::string::String>();
        let v13 = &mut v12;
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"Represents a GenAI Asset in the DegenHive Ecosystem. Exists within HiveProfile and can be traded / lent among users"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"{version}"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"{power}"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"{aesthetic}"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"{type}"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"{creator_profile}"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"{is_staked}"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"is_borrowed"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"{total_hsui_claimed}"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"{total_gems_claimed}"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"https://www.app.degenhive.ai/hiveverse"));
        let v14 = 0x2::display::new_with_fields<HiveAsset>(&v8, v10, v12, arg1);
        0x2::display::update_version<HiveAsset>(&mut v14);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v8, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<HiveProfile>>(v9, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<HiveAsset>>(v14, 0x2::tx_context::sender(arg1));
    }

    public fun initialize_public_kraft(arg0: &0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::config::DegenHiveDeployerCap, arg1: &0x2::clock::Clock, arg2: &mut HiveProfile, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = get_kiosk_storage_identifier(arg3, arg4);
        assert!(borrow_from_profile<CreatorHiveKiosk>(arg2, v0).max_assets_limit >= arg7, 1107);
        assert!(arg5 >= 0x2::clock::timestamp_ms(arg1), 1002);
        let v1 = PublicKraftConfig{
            id                        : 0x2::object::new(arg9),
            start_time                : arg5,
            per_user_limit            : arg6,
            available_assets_to_kraft : arg7,
            krafts_processed          : 0,
            address_list              : 0x2::linked_table::new<address, u64>(arg9),
        };
        let v2 = 0x1::string::from_ascii(v0);
        0x1::string::append(&mut v2, 0x1::string::utf8(b"::PUBLIC_KRAFT_CONFIG"));
        0x2::dynamic_object_field::add<0x1::string::String, PublicKraftConfig>(&mut arg2.id, v2, v1);
        let v3 = PublicKraftInitialized{
            aesthetic                 : arg3,
            type                      : arg4,
            creator_profile           : 0x2::object::uid_to_address(&arg2.id),
            post_number               : arg8,
            creator_profile_username  : arg2.username,
            start_time                : arg5,
            per_user_limit            : arg6,
            available_assets_to_kraft : arg7,
        };
        0x2::event::emit<PublicKraftInitialized>(v3);
    }

    public fun initialize_skin_for_asset(arg0: &0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::config::HiveDaoCapability, arg1: &mut HiveProfile, arg2: u64, arg3: 0x1::string::String, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 1079);
        let v0 = SkinRecord{
            public_skin_kraft_enabled : arg4,
            only_followers_allowed    : arg5,
            followers_discount        : arg6,
            royalty_fee_percent       : arg7,
            total_gems_ported         : 0,
            total_skins_krafted       : 0,
        };
        0x2::linked_table::push_back<0x1::string::String, SkinRecord>(&mut 0x2::linked_table::borrow_mut<u64, HiveAsset>(&mut arg1.hive_assets, arg2).active_skins, arg3, v0);
        let v1 = NewSkinForAsset{
            version                   : arg2,
            skin_type                 : arg3,
            only_followers_allowed    : arg5,
            followers_discount        : arg6,
            public_skin_kraft_enabled : arg4,
            royalty_fee_percent       : arg7,
        };
        0x2::event::emit<NewSkinForAsset>(v1);
    }

    public fun initialize_whitelisted_kraft(arg0: &0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::config::DegenHiveDeployerCap, arg1: &0x2::clock::Clock, arg2: &mut HiveProfile, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 >= 0x2::clock::timestamp_ms(arg1) && arg6 < arg7, 1002);
        let v0 = WhitelistKraftConfig{
            id                        : 0x2::object::new(arg13),
            start_time                : arg6,
            end_time                  : arg7,
            allow_followers           : arg8,
            per_follower_limit        : arg9,
            whitelisted_addresses     : 0x2::linked_table::new<address, u64>(arg13),
            available_assets_to_kraft : arg12,
            krafts_processed          : 0,
            base_price                : arg10,
            curve_a                   : arg11,
        };
        let v1 = 0x1::string::from_ascii(get_kiosk_storage_identifier(arg4, arg5));
        0x1::string::append(&mut v1, 0x1::string::utf8(b"::WHITELISTED_KRAFT_CONFIG"));
        0x2::dynamic_object_field::add<0x1::string::String, WhitelistKraftConfig>(&mut arg2.id, v1, v0);
        let v2 = WhitelistKraftInitialized{
            aesthetic                 : arg4,
            type                      : arg5,
            creator_profile           : 0x2::object::uid_to_address(&arg2.id),
            post_number               : arg3,
            creator_profile_username  : arg2.username,
            start_time                : arg6,
            end_time                  : arg7,
            allow_followers           : arg8,
            per_follower_limit        : arg9,
            base_price                : arg10,
            curve_a                   : arg11,
            available_assets_to_kraft : arg12,
        };
        0x2::event::emit<WhitelistKraftInitialized>(v2);
    }

    public fun insert_types_attributes_in_record(arg0: &0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::config::DegenHiveDeployerCap, arg1: &mut HiveProfile, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<vector<0x1::string::String>>, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>) {
        let v0 = get_kiosk_storage_identifier(arg2, arg3);
        let v1 = remove_from_profile<CreatorHiveKiosk>(arg1, v0);
        let v2 = 0;
        assert!(0x1::vector::length<vector<0x1::string::String>>(&arg4) == 0x1::vector::length<0x1::string::String>(&arg5), 1055);
        assert!(0x1::vector::length<vector<0x1::string::String>>(&arg4) == 0x1::vector::length<0x1::string::String>(&arg6), 1066);
        while (v2 < 0x1::vector::length<vector<0x1::string::String>>(&arg4)) {
            let v3 = 0x1::vector::borrow<vector<0x1::string::String>>(&arg4, v2);
            let v4 = 0x1::vector::borrow<0x1::string::String>(&arg5, v2);
            let v5 = 0x1::vector::borrow<0x1::string::String>(&arg6, v2);
            let v6 = *v3;
            assert!(0x1::vector::length<0x1::string::String>(&v6) == 0x1::vector::length<0x1::string::String>(&v1.traits_list), 1051);
            0x1::vector::push_back<vector<0x1::string::String>>(&mut v1.prompts_list, *v3);
            0x1::vector::push_back<0x1::string::String>(&mut v1.url_list, *v4);
            0x1::vector::push_back<0x1::string::String>(&mut v1.names_list, *v5);
            v2 = v2 + 1;
        };
        add_to_profile<CreatorHiveKiosk>(arg1, v0, v1);
    }

    fun internal_kraft_dof_access_cap(arg0: &mut HiveProfileMappingStore, arg1: 0x1::ascii::String, arg2: bool, arg3: bool, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : ProfileDofOwnershipCapability {
        let v0 = ProfileDofOwnershipCapability{
            id                        : 0x2::object::new(arg5),
            supported_dof             : arg1,
            only_owner_can_add_dof    : arg2,
            only_owner_can_mut_dof    : arg3,
            only_owner_can_remove_dof : arg4,
        };
        assert!(!0x2::linked_table::contains<0x1::ascii::String, address>(&arg0.dof_identifiers_to_cap_mapping, arg1), 1112);
        0x2::linked_table::push_back<0x1::ascii::String, address>(&mut arg0.dof_identifiers_to_cap_mapping, arg1, 0x2::object::uid_to_address(&v0.id));
        let v1 = DofAccessCapKrafted{
            capability_addr           : 0x2::object::uid_to_address(&v0.id),
            dof_identifer             : arg1,
            only_owner_can_add_dof    : arg2,
            only_owner_can_mut_dof    : arg3,
            only_owner_can_remove_dof : arg4,
        };
        0x2::event::emit<DofAccessCapKrafted>(v1);
        v0
    }

    fun internal_kraft_hive_profile(arg0: &0x2::clock::Clock, arg1: bool, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: u64, arg6: u64, arg7: u64, arg8: &mut HiveProfileMappingStore, arg9: &mut HiveManager, arg10: &mut HSuiDisperser<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg11: 0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg12: &mut 0x2::tx_context::TxContext) : HiveProfile {
        let v0 = 0x2::object::new(arg12);
        let v1 = 0x2::object::uid_to_address(&v0);
        assert!(0x1::string::length(&arg3) <= 150, 1105);
        assert!(is_valid_profile_name(arg2), 1084);
        let v2 = 0x1::string::to_ascii(arg2);
        assert!(!0x2::linked_table::contains<0x1::ascii::String, address>(&arg8.username_to_profile_mapping, v2), 1083);
        0x2::linked_table::push_back<0x1::ascii::String, address>(&mut arg8.username_to_profile_mapping, v2, v1);
        if (!arg1) {
            assert!(!0x2::linked_table::contains<address, address>(&arg8.owner_to_profile_mapping, arg4), 1056);
            0x2::linked_table::push_back<address, address>(&mut arg8.owner_to_profile_mapping, arg4, v1);
        } else {
            arg4 = @0x0;
            0x2::linked_table::push_back<0x1::ascii::String, address>(&mut arg8.username_to_comp_profile_mapping, v2, v1);
        };
        0x2::balance::join<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut arg9.buidlers_royalty, 0x2::balance::split<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut arg11, 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::math::mul_div(0x2::balance::value<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&arg11), 50, 100)));
        deposit_hsui_for_hive<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(arg10, arg11);
        let v3 = 0x2::table::new<u8, u64>(arg12);
        0x2::table::add<u8, u64>(&mut v3, 1, arg5);
        0x2::table::add<u8, u64>(&mut v3, 3, arg6);
        0x2::table::add<u8, u64>(&mut v3, 12, arg7);
        let v4 = HiveProfileKrafted{
            name                  : arg2,
            bio                   : arg3,
            new_profile_addr      : v1,
            krafter               : arg4,
            fee                   : arg9.config_params.profile_kraft_fees_sui,
            is_composable_profile : arg1,
        };
        0x2::event::emit<HiveProfileKrafted>(v4);
        let v5 = HiveProfile{
            id                    : v0,
            username              : v2,
            bio                   : arg3,
            lead_genai_asset      : 0x1::option::none<0x2::url::Url>(),
            creation_timestamp    : 0x2::clock::timestamp_ms(arg0),
            owner                 : arg4,
            is_composable_profile : arg1,
            subscriptions         : v3,
            followers_list        : 0x2::linked_table::new<address, SubscriptionRecord>(arg12),
            following_list        : 0x2::linked_table::new<address, SubscriptionRecord>(arg12),
            available_gems        : 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::zero(),
            available_hsui        : 0x2::balance::zero<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(),
            hive_assets           : 0x2::linked_table::new<u64, HiveAsset>(arg12),
            incoming_bids         : 0x2::linked_table::new<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(arg12),
            borrow_records        : 0x2::linked_table::new<u64, BorrowRecord>(arg12),
            listing_records       : 0x2::linked_table::new<u64, ListingRecord>(arg12),
            bid_records           : 0x2::linked_table::new<u64, BidRecord>(arg12),
            lend_records          : 0x2::linked_table::new<u64, LendRecord>(arg12),
            supported_dofs        : 0x1::vector::empty<0x1::ascii::String>(),
            module_version        : 0,
        };
        let v6 = &mut v5;
        let v7 = &mut arg9.hive_profile;
        make_forever_follower(0x2::clock::timestamp_ms(arg0), v6, v7);
        v5
    }

    fun internal_kraft_hiveverse_asset(arg0: &mut HiveProfile, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xe0e81e85d25c7f0ce1de241f82139208838e3f5e656cce7059f6525b116a69f4::hsui_vault::HSuiVault, arg3: address, arg4: u64, arg5: &mut HiveManager, arg6: &mut CreatorHiveKiosk, arg7: 0x2::balance::Balance<0x2::sui::SUI>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, HiveAsset, vector<0x1::string::String>, vector<0x1::string::String>) {
        let v0 = arg6.creator_profile;
        let v1 = 0x2::object::uid_to_address(&arg0.id);
        let v2 = 0xe0e81e85d25c7f0ce1de241f82139208838e3f5e656cce7059f6525b116a69f4::hsui_vault::stake_sui_request(arg1, arg2, 0x2::balance::split<0x2::sui::SUI>(&mut arg7, arg8), 0x1::option::none<address>(), arg9);
        if (!0x2::linked_table::contains<address, 0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&arg5.creator_royalties, v0)) {
            0x2::linked_table::push_back<address, 0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&mut arg5.creator_royalties, v0, 0x2::balance::zero<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>());
        };
        0x2::balance::join<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(0x2::linked_table::borrow_mut<address, 0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&mut arg5.creator_royalties, v0), 0x2::balance::split<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut v2, (0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::math::mul_div_u256((0x2::balance::value<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&v2) as u256), (30 as u256), (100 as u256)) as u64)));
        0x2::balance::join<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut arg5.buidlers_royalty, v2);
        assert!(arg5.active_assets + 1 <= arg5.max_assets_limit, 1049);
        let v3 = 0x1::vector::length<0x1::string::String>(&arg6.names_list);
        let v4 = if (v3 == 0) {
            0
        } else {
            arg4 % v3
        };
        let v5 = 0x1::vector::remove<vector<0x1::string::String>>(&mut arg6.prompts_list, v4);
        let v6 = 0x1::vector::remove<0x1::string::String>(&mut arg6.url_list, v4);
        let v7 = 0x2::linked_table::new<0x1::string::String, 0x1::string::String>(arg9);
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = 0x1::vector::empty<0x1::string::String>();
        let v10 = 0;
        while (v10 < 0x1::vector::length<0x1::string::String>(&arg6.traits_list)) {
            let v11 = 0x1::vector::borrow<0x1::string::String>(&arg6.traits_list, v10);
            let v12 = 0x1::vector::borrow<0x1::string::String>(&v5, v10);
            0x2::linked_table::push_back<0x1::string::String, 0x1::string::String>(&mut v7, *v11, *v12);
            0x1::vector::push_back<0x1::string::String>(&mut v8, *v11);
            0x1::vector::push_back<0x1::string::String>(&mut v9, *v12);
            v10 = v10 + 1;
        };
        let v13 = &mut arg5.hive_profile;
        let v14 = withdraw_gems_from_profile(v13, arg6.init_hive_gems, arg9);
        let v15 = HiveAsset{
            id                 : 0x2::object::new(arg9),
            version            : arg5.active_assets + 1,
            power              : 0,
            creator_profile    : v0,
            name               : 0x1::vector::remove<0x1::string::String>(&mut arg6.names_list, v4),
            img_url            : 0x2::url::new_unsafe(0x1::string::to_ascii(v6)),
            aesthetic          : arg6.aesthetic,
            type               : arg6.type,
            prompts            : v7,
            is_borrowed        : false,
            is_staked          : false,
            lockup_duration    : 0,
            unlock_timestamp   : 0,
            available_gems     : v14,
            claim_index        : 0,
            gems_claim_index   : 0,
            total_hsui_claimed : 0,
            total_gems_claimed : 0,
            active_skins       : 0x2::linked_table::new<0x1::string::String, SkinRecord>(arg9),
        };
        0x2::linked_table::push_back<u64, address>(&mut arg6.krafted_versions_map, v15.version, v1);
        update_asset_ownership(arg5, v15.version, v1);
        let v16 = NewHiveAssetKrafted{
            id                   : 0x2::object::uid_to_inner(&v15.id),
            krafter_profile_addr : v1,
            krafter              : arg3,
            aesthetic            : v15.aesthetic,
            type                 : v15.type,
            name                 : v15.name,
            version              : v15.version,
            img_url              : v6,
            genesis_hivegems     : 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::value(&v15.available_gems),
            power                : v15.power,
            price                : arg8,
            traits_list          : v8,
            prompts_list         : v9,
        };
        0x2::event::emit<NewHiveAssetKrafted>(v16);
        arg5.active_assets = arg5.active_assets + 1;
        (arg7, v15, v8, v9)
    }

    fun internal_process_subscription_payment(arg0: &mut HiveManager, arg1: &mut HiveDisperser, arg2: address, arg3: address, arg4: 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::HiveGems, arg5: u64, arg6: u64) : 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::HiveGems {
        increment_gems_global_index(arg0, arg1);
        let (v0, v1, v2, v3) = process_gems_royalty(arg0, arg4, arg1);
        let v4 = SubscriptionPaymentProcessed{
            follower_profile_addr : arg2,
            profile_followed_addr : arg3,
            subscription_type     : arg5,
            subscription_cost     : arg6,
            total_royalty_amt     : v1,
            treasury_amt          : v2,
            gems_burnt            : v3,
        };
        0x2::event::emit<SubscriptionPaymentProcessed>(v4);
        v0
    }

    public fun is_asset_listing_executed(arg0: &MarketPlace<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg1: u64) : bool {
        0x2::linked_table::contains<u64, ExecutedListing<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&arg0.processed_listings, arg1)
    }

    public fun is_hive_asset_listed(arg0: &MarketPlace<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg1: u64) : bool {
        0x2::linked_table::contains<u64, Listing>(&arg0.active_listings, arg1)
    }

    public fun is_keeper_account(arg0: &HiveManager, arg1: address) : bool {
        *0x2::linked_table::borrow<address, bool>(&arg0.keeper_accounts, arg1)
    }

    public fun is_usable_profile_name(arg0: &HiveProfileMappingStore, arg1: 0x1::string::String) : bool {
        let v0 = 0x1::string::to_ascii(arg1);
        (0x2::linked_table::contains<0x1::ascii::String, address>(&arg0.username_to_profile_mapping, v0) || 0x2::linked_table::contains<0x1::ascii::String, address>(&arg0.username_to_comp_profile_mapping, v0)) && false || is_valid_profile_name(arg1)
    }

    fun is_valid_profile_char(arg0: u8) : bool {
        arg0 >= 65 && arg0 <= 90 || arg0 >= 97 && arg0 <= 122 || arg0 >= 48 && arg0 <= 57 || arg0 == 95 || arg0 == 45
    }

    public fun is_valid_profile_name(arg0: 0x1::string::String) : bool {
        let v0 = 0x1::string::to_ascii(arg0);
        if (0x1::ascii::length(&v0) > 15) {
            return false
        };
        let v1 = 0x1::ascii::as_bytes(&v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(v1)) {
            if (!is_valid_profile_char(*0x1::vector::borrow<u8>(v1, v2))) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    public fun kraft_hive_assets_and_return_sui(arg0: &0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::config::HiveEntryCap, arg1: &0x2::clock::Clock, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0xe0e81e85d25c7f0ce1de241f82139208838e3f5e656cce7059f6525b116a69f4::hsui_vault::HSuiVault, arg4: &mut HiveManager, arg5: &mut HiveProfile, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut HiveProfile, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        authority_check(arg8, 0x2::tx_context::sender(arg12));
        let v0 = kraft_hive_assets_loop(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        0x2::coin::from_balance<0x2::sui::SUI>(v0, arg12)
    }

    fun kraft_hive_assets_loop(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xe0e81e85d25c7f0ce1de241f82139208838e3f5e656cce7059f6525b116a69f4::hsui_vault::HSuiVault, arg3: &mut HiveManager, arg4: &mut HiveProfile, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut HiveProfile, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = get_kiosk_storage_identifier(arg5, arg6);
        let v1 = remove_from_profile<CreatorHiveKiosk>(arg4, v0);
        let v2 = 0x2::object::uid_to_address(&arg7.id);
        assert!(arg9 + arg10 <= 0x1::vector::length<0x1::string::String>(&v1.names_list), 1082);
        let v3 = false;
        let v4 = 0;
        if (0x2::linked_table::contains<address, SubscriptionRecord>(&arg4.followers_list, v2)) {
            let v5 = 0x2::linked_table::borrow<address, SubscriptionRecord>(&arg4.followers_list, v2);
            if (0x2::clock::timestamp_ms(arg0) < v5.next_payment_timestamp && v5.is_active) {
                v3 = true;
                v4 = v1.followers_discount;
            };
        };
        if (v1.followers_only) {
            assert!(v3, 1106);
        };
        let v6 = 0;
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(arg8);
        while (v6 < arg9) {
            let v8 = 0x1::string::from_ascii(v0);
            0x1::string::append(&mut v8, 0x1::string::utf8(b"::WHITELISTED_KRAFT_CONFIG"));
            let v9 = borrow_mut_from_profile<WhitelistKraftConfig>(arg4, 0x1::string::to_ascii(v8));
            let v10 = &mut v1;
            v7 = execute_whitelisted_kraft(v3, v10, arg0, arg1, arg2, arg3, v9, arg7, v7, arg11);
            v6 = v6 + 1;
        };
        v6 = 0;
        while (v6 < arg10) {
            let v11 = 0x1::string::from_ascii(v0);
            0x1::string::append(&mut v11, 0x1::string::utf8(b"::PUBLIC_KRAFT_CONFIG"));
            let v12 = borrow_mut_from_profile<PublicKraftConfig>(arg4, 0x1::string::to_ascii(v11));
            let v13 = &mut v1;
            v7 = execute_public_kraft(arg0, v4, arg1, arg2, arg3, v13, v12, arg7, v7, arg11);
            v6 = v6 + 1;
        };
        add_to_profile<CreatorHiveKiosk>(arg4, v0, v1);
        v7
    }

    public fun kraft_hive_profile_and_return_sui<T0: store + key>(arg0: &ProfileDofOwnershipCapability, arg1: &0x2::clock::Clock, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0xe0e81e85d25c7f0ce1de241f82139208838e3f5e656cce7059f6525b116a69f4::hsui_vault::HSuiVault, arg4: &mut HiveProfileMappingStore, arg5: &mut HiveManager, arg6: &mut HSuiDisperser<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: T0, arg11: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg4.module_version == 0 && arg5.module_version == 0 && arg6.module_version == 0, 1079);
        let (v0, v1) = stake_sui_for_hsui(arg2, arg3, 0x2::coin::into_balance<0x2::sui::SUI>(arg7), arg5.config_params.profile_kraft_fees_sui, arg11);
        let v2 = 0x2::tx_context::sender(arg11);
        let v3 = internal_kraft_hive_profile(arg1, false, arg8, arg9, v2, 0, 0, 0, arg4, arg5, arg6, v1, arg11);
        let v4 = &mut v3;
        entry_add_to_profile<T0>(arg0, v4, arg10, arg11);
        0x2::transfer::share_object<HiveProfile>(v3);
        v0
    }

    public fun kraft_new_skin_for_asset(arg0: &0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::config::HiveDaoCapability, arg1: &0x2::clock::Clock, arg2: &mut HiveManager, arg3: &mut HiveDisperser, arg4: &mut HiveProfile, arg5: &mut HiveProfile, arg6: u64, arg7: 0x1::string::String, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : (0x1::string::String, 0x1::string::String, u64, 0x1::string::String, 0x1::string::String, vector<0x1::string::String>, vector<0x1::string::String>, u64) {
        assert!(arg3.module_version == 0 && arg5.module_version == 0 && arg4.module_version == 0, 1079);
        let v0 = 0x2::object::uid_to_address(&arg4.id);
        let v1 = 0x2::linked_table::borrow_mut<u64, HiveAsset>(&mut arg5.hive_assets, arg6);
        let v2 = 0x2::linked_table::borrow_mut<0x1::string::String, SkinRecord>(&mut v1.active_skins, arg7);
        if (!v2.public_skin_kraft_enabled && !v2.only_followers_allowed) {
            assert!(arg5.is_composable_profile || arg5.owner == 0x2::tx_context::sender(arg10), 1057);
        };
        let v3 = false;
        let v4 = 0;
        if (v2.only_followers_allowed && 0x2::linked_table::contains<address, SubscriptionRecord>(&arg5.followers_list, v0)) {
            let v5 = 0x2::linked_table::borrow<address, SubscriptionRecord>(&arg5.followers_list, v0);
            if (0x2::clock::timestamp_ms(arg1) < v5.next_payment_timestamp && v5.is_active) {
                v3 = true;
                v4 = v2.followers_discount;
            };
        };
        if (v2.only_followers_allowed) {
            assert!(v3, 1113);
        };
        assert!(v2.total_skins_krafted < arg8, 1079);
        v2.total_skins_krafted = v2.total_skins_krafted + 1;
        let v6 = arg9 - (0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::math::mul_div_u128((arg9 as u128), (v4 as u128), (100 as u128)) as u64);
        let v7 = withdraw_gems_from_profile(arg4, v6, arg10);
        let (v8, v9, v10, v11) = process_gems_royalty(arg2, v7, arg3);
        let v12 = v8;
        if (v2.royalty_fee_percent > 0) {
            let v13 = (0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::math::mul_div_u128((v6 as u128), (v2.royalty_fee_percent as u128), (100 as u128)) as u64);
            0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::join(&mut arg5.available_gems, 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::split(&mut v12, v13));
            let v14 = GemAddedToProfile{
                username       : arg5.username,
                profile_addr   : 0x2::object::uid_to_address(&arg5.id),
                deposited_gems : v13,
            };
            0x2::event::emit<GemAddedToProfile>(v14);
        };
        deposit_gems_for_hive(arg3, v12);
        let v15 = 0x1::vector::empty<0x1::string::String>();
        let v16 = 0x1::vector::empty<0x1::string::String>();
        let v17 = *0x2::linked_table::front<0x1::string::String, 0x1::string::String>(&v1.prompts);
        let v18 = 0;
        while (v18 < 0x2::linked_table::length<0x1::string::String, 0x1::string::String>(&v1.prompts)) {
            let v19 = 0x1::option::borrow<0x1::string::String>(&v17);
            0x1::vector::push_back<0x1::string::String>(&mut v15, *v19);
            0x1::vector::push_back<0x1::string::String>(&mut v16, *0x2::linked_table::borrow<0x1::string::String, 0x1::string::String>(&v1.prompts, *v19));
            v18 = v18 + 1;
        };
        let v20 = NewSkinForCardKrafted{
            krafted_by_profile              : v0,
            krafter_username                : arg4.username,
            owner_profile                   : 0x2::object::uid_to_address(&arg5.id),
            owner_username                  : arg5.username,
            version                         : arg6,
            skin_type                       : arg7,
            skin_price                      : v6,
            royalty_earned_by_owner         : 0,
            skins_krafted_for_type_by_asset : v2.total_skins_krafted,
            total_royalty_amt               : v9,
            treasury_amt                    : v10,
            gems_burnt                      : v11,
        };
        0x2::event::emit<NewSkinForCardKrafted>(v20);
        (v1.aesthetic, v1.type, v1.version, v1.name, 0x1::string::from_ascii(0x2::url::inner_url(&v1.img_url)), v15, v16, v1.power)
    }

    public fun kraft_owned_hive_profile(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xe0e81e85d25c7f0ce1de241f82139208838e3f5e656cce7059f6525b116a69f4::hsui_vault::HSuiVault, arg3: &mut HiveProfileMappingStore, arg4: &mut HiveManager, arg5: &mut HSuiDisperser<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) : (HiveProfile, 0x2::balance::Balance<0x2::sui::SUI>) {
        let (v0, v1) = stake_sui_for_hsui(arg1, arg2, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg4.config_params.profile_kraft_fees_sui, arg9);
        let v2 = 0x2::tx_context::sender(arg9);
        (internal_kraft_hive_profile(arg0, true, arg7, arg8, v2, 0, 0, 0, arg3, arg4, arg5, v1, arg9), v0)
    }

    public fun lock_hivecard(arg0: &0x2::clock::Clock, arg1: &0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::config::HiveDaoCapability, arg2: &mut HiveManager, arg3: &mut HSuiDisperser<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg4: &mut HiveDisperser, arg5: &mut HiveProfile, arg6: u64, arg7: u8, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg2.module_version == 0 && arg3.module_version == 0 && arg4.module_version == 0 && arg5.module_version == 0, 1079);
        authority_check(arg5, 0x2::tx_context::sender(arg8));
        let v0 = 0x2::clock::timestamp_ms(arg0);
        assert!(0x2::table::contains<u8, u64>(&arg2.supported_lockup_durations, arg7), 1088);
        let v1 = *0x2::table::borrow<u8, u64>(&arg2.supported_lockup_durations, arg7);
        let (v2, v3) = withdraw_hive_asset(arg0, arg2, arg3, arg4, arg5, arg6, false);
        let v4 = v2;
        0x2::balance::join<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut arg5.available_hsui, v3);
        assert!(!v4.is_staked, 1082);
        if (v4.is_borrowed) {
            let v5 = 0x2::linked_table::borrow<u64, BorrowRecord>(&arg5.borrow_records, arg6);
            assert!(v5.lockup_duration == arg7, 1088);
            assert!(v5.start_sec + 259200000 > v0, 1083);
        };
        v4.is_staked = true;
        let v6 = calc_voting_power(0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::value(&v4.available_gems), v1);
        v4.power = v6;
        v4.unlock_timestamp = v0 + (arg7 as u64) * 2592000000;
        v4.lockup_duration = arg7;
        arg2.locked_assets = arg2.locked_assets + 1;
        arg2.active_power = arg2.active_power + (v4.power as u128);
        v4.claim_index = arg3.global_dispersal_index;
        v4.gems_claim_index = arg4.global_dispersal_index;
        let v7 = TotalActivePowerUpdated{
            new_total_active_power : arg2.active_power,
            total_staked_assets    : arg2.locked_assets,
        };
        0x2::event::emit<TotalActivePowerUpdated>(v7);
        let v8 = HiveAssetStaked{
            username         : arg5.username,
            profile_addr     : 0x2::object::uid_to_address(&arg5.id),
            version          : arg6,
            duration         : arg7,
            new_asset_power  : v4.power,
            unlock_timestamp : v4.unlock_timestamp,
        };
        0x2::event::emit<HiveAssetStaked>(v8);
        if (0x2::linked_table::contains<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(&mut arg5.incoming_bids, arg6)) {
            let v9 = 0x2::linked_table::borrow_mut<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(&mut arg5.incoming_bids, arg6);
            let v10 = 0;
            while (v10 < 0x1::vector::length<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(v9)) {
                let v11 = 0x1::vector::borrow_mut<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(v9, v10);
                v11.is_valid = false;
                let v12 = BidMarkedInvalid{
                    version        : arg6,
                    bidder_profile : v11.bidder_profile,
                };
                0x2::event::emit<BidMarkedInvalid>(v12);
                v10 = v10 + 1;
            };
        };
        deposit_hive_asset(arg5, v4);
        v6
    }

    public entry fun make_bid_with_hsui(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &0xe0e81e85d25c7f0ce1de241f82139208838e3f5e656cce7059f6525b116a69f4::hsui_vault::HSuiVault, arg3: &mut HSuiDisperser<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg4: &mut MarketPlace<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg5: &mut HiveProfile, arg6: 0x2::coin::Coin<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg3.module_version == 0 && arg4.module_version == 0, 1079);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::object::uid_to_address(&arg5.id);
        authority_check(arg5, v0);
        let v2 = 0xe0e81e85d25c7f0ce1de241f82139208838e3f5e656cce7059f6525b116a69f4::hsui_vault::get_sui_by_hsui(arg2, arg8);
        assert!(v2 >= arg1.config_params.min_sui_bid_allowed, 1040);
        let v3 = 0x2::clock::timestamp_ms(arg0);
        let v4 = 0x2::linked_table::borrow<u64, Listing>(&arg4.active_listings, arg7);
        assert!(v4.start_sec < v3, 1031);
        assert!(v4.expiration_sec > v3, 1032);
        assert!(v4.is_sale_listing, 1042);
        let v5 = v4.min_sui_price;
        let v6 = v5;
        if (v4.followers_only) {
            assert!(0x2::linked_table::contains<address, SubscriptionRecord>(&arg5.following_list, v4.listed_by_profile), 1090);
            let v7 = 0x2::linked_table::borrow<address, SubscriptionRecord>(&arg5.following_list, v4.listed_by_profile);
            assert!(0x2::clock::timestamp_ms(arg0) < v7.next_payment_timestamp && v7.is_active, 1088);
            v6 = v5 - v5 * v4.followers_discount / 100;
        };
        assert!(v3 < arg9 && arg9 - v3 < 7776000000, 1030);
        let v8 = 0x2::coin::into_balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(arg6);
        if (v4.instant_sale && v2 >= v6) {
            let v9 = &mut v8;
            let (v10, v11) = execute_sale(arg1, arg2, arg4, arg3, arg7, false, v1, arg8, v9);
            update_asset_ownership(arg1, arg7, v1);
            deposit_hive_asset(arg5, v10);
            0x2::linked_table::push_back<u64, ExecutedListing<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&mut arg4.processed_listings, arg7, v11);
        } else {
            let v12 = BidPlaced{
                bidder_profile   : v1,
                username         : arg5.username,
                version          : arg7,
                offer_hsui_price : arg8,
                expiration_sec   : arg9,
                is_asset_listed  : true,
            };
            0x2::event::emit<BidPlaced>(v12);
            let v13 = &mut arg4.available_bids;
            add_bid_to_table(v13, arg7, create_bid(v1, arg8, 0x2::balance::split<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut v8, arg8), arg9, true), arg1.config_params.max_bids_per_asset);
            add_bid_record_to_profile(arg5, arg7, create_bid_record(arg7, arg8, arg9, true));
        };
        0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::coin_helper::destroy_or_transfer_balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(v8, v0, arg10);
    }

    public entry fun make_bid_with_sui(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xe0e81e85d25c7f0ce1de241f82139208838e3f5e656cce7059f6525b116a69f4::hsui_vault::HSuiVault, arg3: &mut HiveManager, arg4: &mut HSuiDisperser<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg5: &mut MarketPlace<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg6: &mut HiveProfile, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg7);
        let v1 = 0xe0e81e85d25c7f0ce1de241f82139208838e3f5e656cce7059f6525b116a69f4::hsui_vault::stake_sui_request(arg1, arg2, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg9), 0x1::option::none<address>(), arg11);
        let v2 = 0x2::coin::from_balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(v1, arg11);
        make_bid_with_hsui(arg0, arg3, arg2, arg4, arg5, arg6, v2, arg8, 0x2::balance::value<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&v1), arg10, arg11);
        0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg11), arg11);
    }

    public entry fun make_direct_bid_with_hsui(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &0xe0e81e85d25c7f0ce1de241f82139208838e3f5e656cce7059f6525b116a69f4::hsui_vault::HSuiVault, arg3: &mut HiveProfile, arg4: &mut HiveProfile, arg5: 0x2::coin::Coin<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 1079);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::object::uid_to_address(&arg4.id);
        authority_check(arg4, v0);
        assert!(0xe0e81e85d25c7f0ce1de241f82139208838e3f5e656cce7059f6525b116a69f4::hsui_vault::get_sui_by_hsui(arg2, arg7) >= arg1.config_params.min_sui_bid_allowed, 1040);
        let v2 = 0x2::linked_table::borrow<u64, HiveAsset>(&arg3.hive_assets, arg6);
        assert!(!v2.is_borrowed, 1046);
        assert!(!v2.is_staked, 1053);
        let v3 = 0x2::clock::timestamp_ms(arg0);
        assert!(v3 < arg8 && arg8 - v3 < 7776000000, 1030);
        let v4 = 0x2::coin::into_balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(arg5);
        let v5 = &mut arg3.incoming_bids;
        add_bid_to_table(v5, arg6, create_bid(v1, arg7, 0x2::balance::split<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut v4, arg7), arg8, false), arg1.config_params.max_bids_per_asset);
        add_bid_record_to_profile(arg4, arg6, create_bid_record(arg6, arg7, arg8, false));
        0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::coin_helper::destroy_or_transfer_balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(v4, v0, arg9);
        let v6 = BidPlaced{
            bidder_profile   : v1,
            username         : arg4.username,
            version          : arg6,
            offer_hsui_price : arg7,
            expiration_sec   : arg8,
            is_asset_listed  : false,
        };
        0x2::event::emit<BidPlaced>(v6);
    }

    public entry fun make_direct_bid_with_sui(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xe0e81e85d25c7f0ce1de241f82139208838e3f5e656cce7059f6525b116a69f4::hsui_vault::HSuiVault, arg3: &mut HiveManager, arg4: &mut HiveProfile, arg5: &mut HiveProfile, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg6);
        let v1 = 0xe0e81e85d25c7f0ce1de241f82139208838e3f5e656cce7059f6525b116a69f4::hsui_vault::stake_sui_request(arg1, arg2, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg8), 0x1::option::none<address>(), arg10);
        let v2 = 0x2::coin::from_balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(v1, arg10);
        make_direct_bid_with_hsui(arg0, arg3, arg2, arg4, arg5, v2, arg7, 0x2::balance::value<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&v1), arg9, arg10);
        0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg10), arg10);
    }

    public(friend) fun make_forever_follower(arg0: u64, arg1: &mut HiveProfile, arg2: &mut HiveProfile) {
        let v0 = 0x2::object::uid_to_address(&arg1.id);
        let v1 = 0x2::object::uid_to_address(&arg2.id);
        if (0x2::linked_table::contains<address, SubscriptionRecord>(&arg1.following_list, v1)) {
            return
        };
        let v2 = SubscriptionRecord{
            follower               : v0,
            following              : v1,
            is_active              : true,
            init_timestamp         : arg0,
            subscription_type      : (12 as u64),
            subscription_cost      : 0,
            next_payment_timestamp : arg0 + 31104000000000,
            total_paid             : 0,
            switch_to_plan         : 0x1::option::none<u64>(),
            switch_to_plan_price   : 0x1::option::none<u64>(),
        };
        0x2::linked_table::push_back<address, SubscriptionRecord>(&mut arg1.following_list, v1, v2);
        0x2::linked_table::push_back<address, SubscriptionRecord>(&mut arg2.followers_list, v0, v2);
    }

    public entry fun make_listing(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &mut MarketPlace<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg3: &mut HSuiDisperser<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg4: &mut HiveDisperser, arg5: &mut HiveProfile, arg6: u64, arg7: bool, arg8: u64, arg9: u64, arg10: bool, arg11: bool, arg12: bool, arg13: u8, arg14: u64, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0 && arg4.module_version == 0 && arg3.module_version == 0 && arg5.module_version == 0, 1079);
        let v0 = 0x2::object::uid_to_address(&arg5.id);
        authority_check(arg5, 0x2::tx_context::sender(arg16));
        assert!(arg14 > 0x2::clock::timestamp_ms(arg0) && arg15 > arg14 && arg15 - arg14 < 7776000000, 1002);
        assert!(arg8 < 100, 1109);
        if (!arg10) {
            assert!(0x2::table::contains<u8, u64>(&arg1.supported_lockup_durations, arg13), 1088);
            assert!(!arg11 && !arg12, 1110);
        } else {
            assert!(arg11 || arg12, 1078);
            if (arg11) {
                assert!(!arg12, 1078);
            } else {
                assert!(arg12, 1078);
            };
        };
        let (v1, v2) = withdraw_hive_asset(arg0, arg1, arg3, arg4, arg5, arg6, false);
        let v3 = v1;
        0x2::balance::join<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut arg5.available_hsui, v2);
        assert!(!v3.is_borrowed, 1046);
        if (0x2::linked_table::contains<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(&mut arg5.incoming_bids, arg6)) {
            let v4 = 0x2::linked_table::borrow_mut<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(&mut arg5.incoming_bids, arg6);
            let v5 = 0;
            while (v5 < 0x1::vector::length<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(v4)) {
                let v6 = 0x1::vector::borrow_mut<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(v4, v5);
                v6.is_valid = false;
                let v7 = BidMarkedInvalid{
                    version        : arg6,
                    bidder_profile : v6.bidder_profile,
                };
                0x2::event::emit<BidMarkedInvalid>(v7);
                v5 = v5 + 1;
            };
        };
        let v8 = Listing{
            listed_by_profile  : v0,
            hive_asset         : v3,
            followers_only     : arg7,
            followers_discount : arg8,
            min_sui_price      : arg9,
            is_sale_listing    : arg10,
            instant_sale       : arg11,
            highest_bid_sale   : arg12,
            lockup_duration    : arg13,
            start_sec          : arg14,
            expiration_sec     : arg15,
        };
        let v9 = ListingRecord{
            version            : arg6,
            followers_only     : arg7,
            followers_discount : arg8,
            min_sui_price      : arg9,
            is_sale_listing    : arg10,
            instant_sale       : arg11,
            highest_bid_sale   : arg12,
            lockup_duration    : arg13,
            start_sec          : arg14,
            expiration_sec     : arg15,
        };
        let v10 = NewListing{
            listed_by_profile  : v0,
            followers_only     : arg7,
            followers_discount : arg8,
            version            : arg6,
            min_sui_price      : arg9,
            is_sale_listing    : arg10,
            instant_sale       : arg11,
            highest_bid_sale   : arg12,
            lockup_duration    : arg13,
            start_sec          : arg14,
            expiration_sec     : arg15,
        };
        0x2::event::emit<NewListing>(v10);
        0x2::linked_table::push_back<u64, ListingRecord>(&mut arg5.listing_records, arg6, v9);
        0x2::linked_table::push_back<u64, Listing>(&mut arg2.active_listings, arg6, v8);
    }

    fun mark_marketplace_bids_as_invalid(arg0: &mut MarketPlace<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg1: u64) {
        if (0x2::linked_table::contains<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(&arg0.available_bids, arg1)) {
            let v0 = 0x2::linked_table::remove<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(&mut arg0.available_bids, arg1);
            let v1 = 0;
            while (v1 < 0x1::vector::length<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&v0)) {
                let v2 = 0x1::vector::borrow_mut<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&mut v0, v1);
                v2.is_listing_live = false;
                v2.is_valid = false;
                let v3 = BidMarkedInvalid{
                    version        : arg1,
                    bidder_profile : v2.bidder_profile,
                };
                0x2::event::emit<BidMarkedInvalid>(v3);
                v1 = v1 + 1;
            };
            0x2::linked_table::push_back<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(&mut arg0.available_bids, arg1, v0);
        };
    }

    public entry fun modify_bid(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &0xe0e81e85d25c7f0ce1de241f82139208838e3f5e656cce7059f6525b116a69f4::hsui_vault::HSuiVault, arg3: &mut HSuiDisperser<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg4: &mut MarketPlace<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg5: &mut HiveProfile, arg6: 0x2::coin::Coin<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg3.module_version == 0 && arg4.module_version == 0, 1079);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::object::uid_to_address(&arg5.id);
        authority_check(arg5, v0);
        assert!(0x2::linked_table::contains<u64, BidRecord>(&arg5.bid_records, arg7), 1026);
        let v2 = 0x2::clock::timestamp_ms(arg0);
        let v3 = 0x2::linked_table::borrow<u64, Listing>(&arg4.active_listings, arg7);
        assert!(v3.start_sec < v2, 1031);
        assert!(v3.expiration_sec > v2, 1032);
        let v4 = v3.min_sui_price;
        let v5 = v4;
        if (v3.followers_only) {
            assert!(0x2::linked_table::contains<address, SubscriptionRecord>(&arg5.following_list, v3.listed_by_profile), 1090);
            let v6 = 0x2::linked_table::borrow<address, SubscriptionRecord>(&arg5.following_list, v3.listed_by_profile);
            assert!(0x2::clock::timestamp_ms(arg0) < v6.next_payment_timestamp && v6.is_active, 1088);
            v5 = v4 - v4 * v3.followers_discount / 100;
        };
        assert!(0x2::linked_table::borrow<u64, BidRecord>(&arg5.bid_records, arg7).expiration_sec > v2, 1071);
        let v7 = 0x2::coin::into_balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(arg6);
        if (v3.instant_sale && 0xe0e81e85d25c7f0ce1de241f82139208838e3f5e656cce7059f6525b116a69f4::hsui_vault::get_sui_by_hsui(arg2, arg8) >= v5) {
            let v8 = &mut v7;
            let (v9, v10) = execute_sale(arg1, arg2, arg4, arg3, arg7, true, v1, arg8, v8);
            update_asset_ownership(arg1, arg7, v1);
            deposit_hive_asset(arg5, v9);
            0x2::linked_table::push_back<u64, ExecutedListing<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&mut arg4.processed_listings, arg7, v10);
        } else {
            let v11 = 0x2::linked_table::borrow_mut<u64, BidRecord>(&mut arg5.bid_records, arg7);
            update_bid_record(v11, arg8, arg9, v2);
            let v12 = BidModified{
                version          : arg7,
                bidder_profile   : v1,
                offer_hsui_price : arg8,
                expiration_sec   : arg9,
            };
            0x2::event::emit<BidModified>(v12);
            let v13 = 0x2::linked_table::remove<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(&mut arg4.available_bids, arg7);
            let v14 = &mut v13;
            let v15 = &mut v7;
            update_bid_among_bids(v14, v1, arg8, arg9, v15, true, arg7);
            0x2::linked_table::push_back<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(&mut arg4.available_bids, arg7, v13);
        };
        0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::coin_helper::destroy_or_transfer_balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(v7, v0, arg10);
    }

    public entry fun modify_direct_bid(arg0: &0x2::clock::Clock, arg1: &mut HiveProfile, arg2: &mut HiveProfile, arg3: 0x2::coin::Coin<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0, 1079);
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x2::coin::into_balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(arg3);
        let v2 = 0x2::tx_context::sender(arg7);
        let v3 = 0x2::object::uid_to_address(&arg2.id);
        authority_check(arg2, v2);
        assert!(0x2::linked_table::contains<u64, BidRecord>(&arg2.bid_records, arg4), 1026);
        assert!(0x2::linked_table::contains<u64, HiveAsset>(&arg1.hive_assets, arg4), 1065);
        let v4 = 0x2::linked_table::borrow_mut<u64, BidRecord>(&mut arg2.bid_records, arg4);
        assert!(v4.expiration_sec > v0, 1071);
        update_bid_record(v4, arg5, arg6, v0);
        let v5 = 0x2::linked_table::remove<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(&mut arg1.incoming_bids, arg4);
        let v6 = &mut v5;
        let v7 = &mut v1;
        update_bid_among_bids(v6, v3, arg5, arg6, v7, false, arg4);
        0x2::linked_table::push_back<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(&mut arg1.incoming_bids, arg4, v5);
        let v8 = BidModified{
            version          : arg4,
            bidder_profile   : v3,
            offer_hsui_price : arg5,
            expiration_sec   : arg6,
        };
        0x2::event::emit<BidModified>(v8);
        0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::coin_helper::destroy_or_transfer_balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(v1, v2, arg7);
    }

    public fun onboard_creator_with_kiosk(arg0: &0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::config::DegenHiveDeployerCap, arg1: &mut HiveProfileMappingStore, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut HiveProfile, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg11);
        let v1 = 0x2::object::uid_to_address(&v0);
        let v2 = 0x2::object::uid_to_address(&arg4.id);
        let v3 = CreatorHiveKiosk{
            id                   : v0,
            creator_profile      : v2,
            init_hive_gems       : arg6,
            aesthetic            : arg2,
            type                 : arg3,
            img_url              : 0x2::url::new_unsafe(0x1::string::to_ascii(arg5)),
            traits_list          : 0x1::vector::empty<0x1::string::String>(),
            max_assets_limit     : arg7,
            krafted_assets       : 0,
            base_price           : arg8,
            curve_a              : arg9,
            prompts_list         : 0x1::vector::empty<vector<0x1::string::String>>(),
            url_list             : 0x1::vector::empty<0x1::string::String>(),
            names_list           : 0x1::vector::empty<0x1::string::String>(),
            krafted_versions_map : 0x2::linked_table::new<u64, address>(arg11),
            followers_only       : false,
            followers_discount   : 0,
            available_upgrades   : 0x2::linked_table::new<u64, vector<AssetUpgrade>>(arg11),
            module_version       : 0,
        };
        let v4 = HiveKioskInitialized{
            kiosk_addr       : v1,
            creator_profile  : v2,
            post_number      : arg10,
            aesthetic        : arg2,
            type             : arg3,
            img_url          : arg5,
            init_hive_gems   : arg6,
            max_assets_limit : arg7,
            base_price       : arg8,
            curve_a          : arg9,
        };
        0x2::event::emit<HiveKioskInitialized>(v4);
        0x2::dynamic_object_field::add<0x1::ascii::String, CreatorHiveKiosk>(&mut arg4.id, get_kiosk_storage_identifier(arg2, arg3), v3);
        if (0x2::linked_table::contains<address, vector<address>>(&arg1.profile_to_creator_kiosk_mapping, v2)) {
            0x1::vector::push_back<address>(0x2::linked_table::borrow_mut<address, vector<address>>(&mut arg1.profile_to_creator_kiosk_mapping, v2), v1);
        } else {
            let v5 = 0x1::vector::empty<address>();
            0x1::vector::push_back<address>(&mut v5, v1);
            0x2::linked_table::push_back<address, vector<address>>(&mut arg1.profile_to_creator_kiosk_mapping, v2, v5);
        };
    }

    public fun port_gems_via_asset(arg0: &0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::config::HiveDaoCapability, arg1: &0x2::clock::Clock, arg2: &mut HiveManager, arg3: &mut HSuiDisperser<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg4: &mut HiveDisperser, arg5: &mut HiveProfile, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (u64, 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::HiveGems) {
        assert!(arg2.module_version == 0 && arg3.module_version == 0 && arg5.module_version == 0, 1079);
        authority_check(arg5, 0x2::tx_context::sender(arg9));
        increment_global_index(arg2, arg3);
        increment_gems_global_index(arg2, arg4);
        let v0 = 0x2::linked_table::borrow_mut<u64, HiveAsset>(&mut arg5.hive_assets, arg7);
        let v1 = 0;
        let v2 = v0.power;
        assert!(0x2::linked_table::contains<0x1::string::String, SkinRecord>(&v0.active_skins, arg6), 1077);
        let (v3, v4, v5) = claim_accrued_rewards_for_asset(arg1, arg2, arg3, arg4, v0);
        0x2::balance::join<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut arg5.available_hsui, v4);
        0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::join(&mut arg5.available_gems, v3);
        if (v5) {
            let v6 = HiveAssetUnstaked{
                profile_addr : 0x2::object::uid_to_address(&arg5.id),
                version      : arg7,
            };
            0x2::event::emit<HiveAssetUnstaked>(v6);
            v1 = v2;
        };
        let v7 = 0x2::linked_table::borrow_mut<0x1::string::String, SkinRecord>(&mut v0.active_skins, arg6);
        let v8 = 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::split(&mut v0.available_gems, arg8);
        v7.total_gems_ported = v7.total_gems_ported + arg8;
        if (v0.is_staked && v0.power > 0) {
            let v9 = calc_voting_power(arg8, *0x2::table::borrow<u8, u64>(&arg2.supported_lockup_durations, v0.lockup_duration));
            v1 = v9;
            v0.power = v0.power - v9;
            arg2.active_power = arg2.active_power - (v9 as u128);
        };
        let v10 = HiveGemsPortedToSkin{
            ported_by_profile  : 0x2::object::uid_to_address(&arg5.id),
            ported_by_username : arg5.username,
            version            : arg7,
            skin_type          : arg6,
            gems_ported        : arg8,
        };
        0x2::event::emit<HiveGemsPortedToSkin>(v10);
        (v1, v8)
    }

    public entry fun pow_approx(arg0: u128, arg1: u128, arg2: u128) : u128 {
        if (arg0 <= 2) {
            return calculate_pow(arg0, 1, arg1, arg2)
        };
        let v0 = 0;
        while (arg0 >= 2) {
            arg0 = arg0 / 2;
            v0 = v0 + 1;
        };
        let v1 = arg0 * (1000000000000000000 as u128);
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 / 2;
            v2 = v2 + 1;
        };
        calculate_pow(2, 1, v0 * arg1, arg2) / (1000000000000000000 as u128) * calculate_pow(v1, (1000000000000000000 as u128), arg1, arg2)
    }

    public entry fun pow_approx_frac(arg0: u256, arg1: u128, arg2: u64) : u256 {
        let (v0, v1) = sub_sign(arg0, (1000000000000000000 as u256));
        let v2 = (1000000000000000000 as u256);
        let v3 = v2;
        let v4 = false;
        let v5 = 0;
        let v6 = 1;
        while (v2 >= (arg2 as u256) && v6 < 32) {
            let (v7, v8) = sub_sign((arg1 as u256), v5);
            let v9 = ((v6 * (1000000000000000000 as u128)) as u256);
            v5 = v9;
            let v10 = v2 * v7 / (1000000000000000000 as u256) * v0 / v9;
            v2 = v10;
            if (v10 == 0) {
                break
            };
            if (v1) {
                v4 = !v4;
            };
            if (v8) {
                v4 = !v4;
            };
            if (v4) {
                v3 = v3 - v10;
            } else {
                v3 = v3 + v10;
            };
            v6 = v6 + 1;
        };
        v3
    }

    fun process_gems_royalty(arg0: &mut HiveManager, arg1: 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::HiveGems, arg2: &mut HiveDisperser) : (0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::HiveGems, u64, u64, u64) {
        let v0 = (0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::math::mul_div_u256((0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::value(&arg1) as u256), (arg0.gems_royalty.numerator as u256), (arg0.gems_royalty.denominator as u256)) as u64);
        let v1 = 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::split(&mut arg1, v0);
        let v2 = (0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::math::mul_div_u256((v0 as u256), (arg0.gems_royalty.treasury_percent as u256), (100 as u256)) as u64);
        let v3 = (0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::math::mul_div_u256((v0 as u256), (arg0.gems_royalty.burn_percent as u256), (100 as u256)) as u64);
        let v4 = &mut arg0.hive_profile;
        deposit_gems_in_profile(v4, 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::split(&mut v1, v2));
        0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::burn(0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::split(&mut v1, v3));
        deposit_gems_for_hive(arg2, v1);
        (arg1, v0, v2, v3)
    }

    fun process_highest_bid_sale_listing(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &0xe0e81e85d25c7f0ce1de241f82139208838e3f5e656cce7059f6525b116a69f4::hsui_vault::HSuiVault, arg3: &mut HSuiDisperser<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg4: &mut MarketPlace<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg5: u64) {
        assert!(arg1.module_version == 0 && arg3.module_version == 0 && arg4.module_version == 0, 1079);
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x2::linked_table::borrow<u64, Listing>(&mut arg4.active_listings, arg5);
        if (v1.expiration_sec > v0) {
            return
        };
        assert!(v1.is_sale_listing && v1.highest_bid_sale, 1044);
        let v2 = v1.listed_by_profile;
        let v3 = false;
        if (0x2::linked_table::contains<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(&arg4.available_bids, arg5)) {
            let v4 = v1.min_sui_price;
            let v5 = 0x2::linked_table::remove<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(&mut arg4.available_bids, arg5);
            let v6 = 0;
            while (v6 < 0x1::vector::length<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&v5)) {
                let v7 = 0x1::vector::borrow_mut<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&mut v5, v6);
                v7.is_listing_live = false;
                v7.is_valid = false;
                let v8 = BidMarkedInvalid{
                    version        : arg5,
                    bidder_profile : v7.bidder_profile,
                };
                0x2::event::emit<BidMarkedInvalid>(v8);
                if (v7.expiration_sec > v0) {
                    if (v7.offer_hsui_price >= v4) {
                        v4 = v7.offer_hsui_price;
                        v3 = true;
                    };
                };
                v6 = v6 + 1;
            };
            if (v3) {
                let (v9, _, _, _, _, _, _, _, _, _, _) = destroy_listing(0x2::linked_table::remove<u64, Listing>(&mut arg4.active_listings, arg5));
                let v20 = v9;
                let v21 = 0x1::vector::remove<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&mut v5, 0);
                let v22 = v21.bidder_profile;
                let (v23, _, _, _, _, _) = destroy_bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(v21, arg5);
                let v29 = v23;
                let v30 = 0x2::balance::value<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&v29);
                let v31 = 0xe0e81e85d25c7f0ce1de241f82139208838e3f5e656cce7059f6525b116a69f4::hsui_vault::get_sui_by_hsui(arg2, v30);
                let v32 = ExecutedListing<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>{
                    listed_by_profile       : v2,
                    hive_asset              : 0x1::option::some<HiveAsset>(v20),
                    version                 : arg5,
                    was_sale_listing        : true,
                    balance                 : 0x1::option::some<0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(process_royalty(v29, arg1, arg3, v20.creator_profile)),
                    bidder_profile          : v22,
                    executed_price_in_hsui  : v30,
                    executed_price_in_sui   : v31,
                    borrow_period_start_sec : 0,
                    borrow_period_end_sec   : 0,
                };
                0x2::linked_table::push_back<u64, ExecutedListing<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&mut arg4.processed_listings, arg5, v32);
                let v33 = SaleExecuted{
                    version         : arg5,
                    buyer_profile   : v22,
                    seller_profile  : v2,
                    price_paid_hsui : v30,
                    price_paid_sui  : v31,
                };
                0x2::event::emit<SaleExecuted>(v33);
            };
            0x2::linked_table::push_back<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(&mut arg4.available_bids, arg5, v5);
        };
        if (!v3) {
            let (v34, _, _, _, _, _, _, _, _, _, _) = destroy_listing(0x2::linked_table::remove<u64, Listing>(&mut arg4.active_listings, arg5));
            let v45 = ExecutedListing<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>{
                listed_by_profile       : v2,
                hive_asset              : 0x1::option::some<HiveAsset>(v34),
                version                 : arg5,
                was_sale_listing        : true,
                balance                 : 0x1::option::none<0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(),
                bidder_profile          : v2,
                executed_price_in_hsui  : 0,
                executed_price_in_sui   : 0,
                borrow_period_start_sec : 0,
                borrow_period_end_sec   : 0,
            };
            0x2::linked_table::push_back<u64, ExecutedListing<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&mut arg4.processed_listings, arg5, v45);
            let v46 = HighestBidListingUnsold{
                version           : arg5,
                listed_by_profile : v2,
            };
            0x2::event::emit<HighestBidListingUnsold>(v46);
        };
    }

    public entry fun process_highest_bid_sale_listings(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &0xe0e81e85d25c7f0ce1de241f82139208838e3f5e656cce7059f6525b116a69f4::hsui_vault::HSuiVault, arg3: &mut HSuiDisperser<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg4: &mut MarketPlace<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg5: vector<u64>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg3.module_version == 0, 1079);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg5)) {
            process_highest_bid_sale_listing(arg0, arg1, arg2, arg3, arg4, *0x1::vector::borrow<u64>(&arg5, v0));
            v0 = v0 + 1;
        };
    }

    fun process_royalty(arg0: 0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg1: &mut HiveManager, arg2: &mut HSuiDisperser<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg3: address) : 0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI> {
        let v0 = (0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::math::mul_div_u128((0x2::balance::value<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&arg0) as u128), (arg1.royalty.numerator as u128), (arg1.royalty.denominator as u128)) as u64);
        let v1 = 0x2::balance::split<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut arg0, v0);
        let v2 = (0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::math::mul_div_u128((0x2::balance::value<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&v1) as u128), (arg1.royalty.assets_dispersal_percent as u128), (100 as u128)) as u64);
        let v3 = (0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::math::mul_div_u128((0x2::balance::value<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&v1) as u128), (arg1.royalty.creators_royalty_percent as u128), (100 as u128)) as u64);
        deposit_hsui_for_hive<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(arg2, 0x2::balance::split<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut v1, v2));
        0x2::balance::join<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(0x2::linked_table::borrow_mut<address, 0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(&mut arg1.creator_royalties, arg3), 0x2::balance::split<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut v1, v3));
        0x2::balance::join<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut arg1.buidlers_royalty, v1);
        let v4 = RoyaltyProcessed{
            total_royalty_amt         : v0,
            hive_dispersal_amt        : v2,
            creator_royalty_amt       : v3,
            accrued_to_fee_cap_holder : 0x2::balance::value<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&v1),
        };
        0x2::event::emit<RoyaltyProcessed>(v4);
        arg0
    }

    public fun process_subscription_payment(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &mut HiveProfile, arg3: &mut HiveProfile, arg4: &mut HiveDisperser, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x2::object::uid_to_address(&arg3.id);
        let v2 = 0x2::object::uid_to_address(&arg2.id);
        let v3 = 0x2::linked_table::borrow_mut<address, SubscriptionRecord>(&mut arg2.following_list, v1);
        let v4 = 0x2::linked_table::borrow_mut<address, SubscriptionRecord>(&mut arg3.followers_list, v2);
        assert!(v0 > v3.next_payment_timestamp, 1096);
        if (0x1::option::is_some<u64>(&v3.switch_to_plan)) {
            let v5 = *0x1::option::borrow<u64>(&v3.switch_to_plan);
            v3.switch_to_plan = 0x1::option::none<u64>();
            v4.switch_to_plan = 0x1::option::none<u64>();
            if (v5 == 10) {
                v3.is_active = false;
                v4.is_active = false;
                return
            };
            let v6 = *0x1::option::borrow<u64>(&v3.switch_to_plan_price);
            v3.subscription_type = v5;
            v3.subscription_cost = v6;
            v4.subscription_type = v5;
            v4.subscription_cost = v6;
            v3.switch_to_plan_price = 0x1::option::none<u64>();
            v4.switch_to_plan_price = 0x1::option::none<u64>();
        };
        assert!(v3.is_active, 1088);
        let v7 = *0x2::table::borrow<u8, u64>(&arg3.subscriptions, (v3.subscription_type as u8));
        assert!(v7 <= v3.subscription_cost, 1094);
        0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::join(&mut arg3.available_gems, internal_process_subscription_payment(arg1, arg4, v2, v1, 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::split(&mut arg2.available_gems, v7), v3.subscription_type, v7));
        let v8 = calc_next_payment_timestamp(v0, (v3.subscription_type as u8));
        v3.next_payment_timestamp = v8;
        v3.total_paid = v3.total_paid + v7;
        v4.next_payment_timestamp = v8;
        v4.total_paid = v4.total_paid + v7;
    }

    public fun remove_asset_upgrade_from_kiosk(arg0: &0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::config::HiveEntryCap, arg1: bool, arg2: &mut HiveProfile, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = get_kiosk_storage_identifier(arg4, arg5);
        let v1 = remove_from_profile<CreatorHiveKiosk>(arg2, v0);
        authority_check(arg2, 0x2::tx_context::sender(arg8));
        if (!arg1) {
            authority_check(arg2, 0x2::tx_context::sender(arg8));
        };
        assert!(0x2::linked_table::contains<u64, address>(&v1.krafted_versions_map, arg6), 1079);
        let AssetUpgrade {
            upgrade_price       : _,
            followers_only      : _,
            followers_discount  : _,
            upgrade_img_url     : _,
            upgrade_traits_list : _,
            upgrade_prompts     : v7,
        } = 0x1::vector::remove<AssetUpgrade>(0x2::linked_table::borrow_mut<u64, vector<AssetUpgrade>>(&mut v1.available_upgrades, arg6), arg7);
        0x2::table::drop<0x1::string::String, 0x1::string::String>(v7);
        let v8 = RemovedUpgradeForVersion{
            creator_profile_addr : 0x2::object::uid_to_address(&arg2.id),
            post_number          : arg3,
            aesthetic            : arg4,
            type                 : arg5,
            version              : arg6,
            upgrade_index        : arg7,
        };
        0x2::event::emit<RemovedUpgradeForVersion>(v8);
        add_to_profile<CreatorHiveKiosk>(arg2, v0, v1);
    }

    fun remove_from_profile<T0: store + key>(arg0: &mut HiveProfile, arg1: 0x1::ascii::String) : T0 {
        0x2::dynamic_object_field::remove<0x1::ascii::String, T0>(&mut arg0.id, arg1)
    }

    public entry fun return_borrowed_hive_asset(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &mut HSuiDisperser<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg3: &mut HiveDisperser, arg4: &mut HiveProfile, arg5: &mut HiveProfile, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0 && arg3.module_version == 0, 1079);
        assert!(0x2::linked_table::contains<u64, LendRecord>(&arg4.lend_records, arg6) && 0x2::linked_table::contains<u64, BorrowRecord>(&arg5.borrow_records, arg6), 1063);
        let v0 = 0x2::linked_table::remove<u64, BorrowRecord>(&mut arg5.borrow_records, arg6);
        if (0x2::tx_context::sender(arg7) != arg5.owner) {
            assert!(v0.expiration_sec < 0x2::clock::timestamp_ms(arg0), 1063);
        };
        let (_, _, _, _, _) = destroy_borrow_record(v0);
        let (v6, v7) = withdraw_hive_asset(arg0, arg1, arg2, arg3, arg5, arg6, false);
        let v8 = v6;
        0x2::balance::join<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut arg5.available_hsui, v7);
        v8.is_borrowed = false;
        deposit_hive_asset(arg4, v8);
        let (_, _, _, _, _, _) = destroy_lend_record(0x2::linked_table::remove<u64, LendRecord>(&mut arg4.lend_records, arg6));
        let v15 = ReturnBorrowedHiveAsset{
            version  : arg6,
            owner    : arg4.owner,
            borrower : arg5.owner,
        };
        0x2::event::emit<ReturnBorrowedHiveAsset>(v15);
    }

    public fun set_traits_in_hive_kiosk(arg0: &0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::config::DegenHiveDeployerCap, arg1: &mut HiveProfile, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: u64) {
        let v0 = get_kiosk_storage_identifier(arg2, arg3);
        let v1 = remove_from_profile<CreatorHiveKiosk>(arg1, v0);
        assert!(v1.krafted_assets == 0, 1077);
        v1.traits_list = arg4;
        let v2 = TraitsSetInHiveKiosk{
            creator_profile : 0x2::object::uid_to_address(&arg1.id),
            post_number     : arg5,
            aesthetic       : arg2,
            type            : arg3,
            traits_list     : arg4,
        };
        0x2::event::emit<TraitsSetInHiveKiosk>(v2);
        add_to_profile<CreatorHiveKiosk>(arg1, v0, v1);
    }

    public entry fun setup_hive_manager(arg0: &mut 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::config::DegenHiveDeployerCap, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: vector<u64>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg8) == 0x1::vector::length<u64>(&arg9), 1087);
        let v0 = 0x2::table::new<u8, u64>(arg10);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg8)) {
            0x2::table::add<u8, u64>(&mut v0, *0x1::vector::borrow<u8>(&arg8, v1), *0x1::vector::borrow<u64>(&arg9, v1));
            v1 = v1 + 1;
        };
        let v2 = 0x2::table::new<u8, u64>(arg10);
        0x2::table::add<u8, u64>(&mut v2, 1, 0);
        0x2::table::add<u8, u64>(&mut v2, 3, 0);
        0x2::table::add<u8, u64>(&mut v2, 12, 0);
        let v3 = 0x1::string::to_ascii(0x1::string::utf8(b"HIVE_AIRDROP_CAP"));
        let v4 = 0x1::string::to_ascii(0x1::string::utf8(b"HIVE_LOCKDROP_CAP"));
        let v5 = 0x1::string::to_ascii(0x1::string::utf8(b"HIVE_INFUSION_CAP"));
        let v6 = 0x1::string::to_ascii(0x1::string::utf8(b"hive_entry_CAP"));
        let v7 = AdminDofOwnershipCapability{
            id             : 0x2::object::new(arg10),
            dof_identifier : v3,
        };
        let v8 = AdminDofOwnershipCapability{
            id             : 0x2::object::new(arg10),
            dof_identifier : v4,
        };
        let v9 = AdminDofOwnershipCapability{
            id             : 0x2::object::new(arg10),
            dof_identifier : v6,
        };
        let v10 = AdminDofOwnershipCapability{
            id             : 0x2::object::new(arg10),
            dof_identifier : v5,
        };
        let v11 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v11, v3);
        0x1::vector::push_back<0x1::ascii::String>(&mut v11, v4);
        0x1::vector::push_back<0x1::ascii::String>(&mut v11, v6);
        0x1::vector::push_back<0x1::ascii::String>(&mut v11, v5);
        let v12 = 0x1::string::utf8(b"HiveManager Profile -::- Managed by BUIDLers of the DegenHive Ecosystem to facilitate the creation of GenAI Assets.");
        let v13 = HiveProfile{
            id                    : 0x2::object::new(arg10),
            username              : 0x1::string::to_ascii(0x1::string::utf8(b"HiveVault")),
            bio                   : v12,
            lead_genai_asset      : 0x1::option::none<0x2::url::Url>(),
            creation_timestamp    : 0x2::clock::timestamp_ms(arg1),
            owner                 : @0x0,
            is_composable_profile : true,
            subscriptions         : v2,
            followers_list        : 0x2::linked_table::new<address, SubscriptionRecord>(arg10),
            following_list        : 0x2::linked_table::new<address, SubscriptionRecord>(arg10),
            available_gems        : 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::zero(),
            available_hsui        : 0x2::balance::zero<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(),
            hive_assets           : 0x2::linked_table::new<u64, HiveAsset>(arg10),
            incoming_bids         : 0x2::linked_table::new<u64, vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>>(arg10),
            borrow_records        : 0x2::linked_table::new<u64, BorrowRecord>(arg10),
            listing_records       : 0x2::linked_table::new<u64, ListingRecord>(arg10),
            bid_records           : 0x2::linked_table::new<u64, BidRecord>(arg10),
            lend_records          : 0x2::linked_table::new<u64, LendRecord>(arg10),
            supported_dofs        : v11,
            module_version        : 0,
        };
        let v14 = HiveProfileKrafted{
            name                  : 0x1::string::utf8(b"HiveVault"),
            bio                   : v12,
            new_profile_addr      : 0x2::object::uid_to_address(&v13.id),
            krafter               : @0x0,
            fee                   : arg6,
            is_composable_profile : true,
        };
        0x2::event::emit<HiveProfileKrafted>(v14);
        let v15 = ConfigParams{
            max_bids_per_asset     : arg4,
            min_sui_bid_allowed    : arg5,
            profile_kraft_fees_sui : arg6,
            social_fee_gems        : arg7,
        };
        let v16 = Royalty{
            numerator                : 5,
            denominator              : 100,
            assets_dispersal_percent : arg2,
            creators_royalty_percent : arg3,
        };
        let v17 = SubscriptionRoyalty{
            numerator        : 10,
            denominator      : 100,
            treasury_percent : 10,
            burn_percent     : 24,
        };
        let v18 = HiveManager{
            id                         : 0x2::object::new(arg10),
            hive_profile               : v13,
            config_params              : v15,
            active_assets              : 0,
            locked_assets              : 0,
            max_assets_limit           : 100000,
            assets_to_profile_mapping  : 0x2::linked_table::new<u64, address>(arg10),
            active_power               : 0,
            supported_lockup_durations : v0,
            royalty                    : v16,
            gems_royalty               : v17,
            buidlers_royalty           : 0x2::balance::zero<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(),
            creator_royalties          : 0x2::linked_table::new<address, 0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(arg10),
            keeper_accounts            : 0x2::linked_table::new<address, bool>(arg10),
            module_version             : 0,
        };
        0x2::transfer::share_object<HiveManager>(v18);
        0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::config::manager_setup_by_deployer(arg0);
        0x2::transfer::public_transfer<AdminDofOwnershipCapability>(v7, 0x2::tx_context::sender(arg10));
        0x2::transfer::public_transfer<AdminDofOwnershipCapability>(v8, 0x2::tx_context::sender(arg10));
        0x2::transfer::public_transfer<AdminDofOwnershipCapability>(v9, 0x2::tx_context::sender(arg10));
        0x2::transfer::public_transfer<AdminDofOwnershipCapability>(v10, 0x2::tx_context::sender(arg10));
    }

    fun stake_sui_for_hsui(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0xe0e81e85d25c7f0ce1de241f82139208838e3f5e656cce7059f6525b116a69f4::hsui_vault::HSuiVault, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>) {
        (arg2, 0xe0e81e85d25c7f0ce1de241f82139208838e3f5e656cce7059f6525b116a69f4::hsui_vault::stake_sui_request(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut arg2, arg3), 0x1::option::none<address>(), arg4))
    }

    fun sub_sign(arg0: u256, arg1: u256) : (u256, bool) {
        if (arg0 >= arg1) {
            return (arg0 - arg1, false)
        };
        (arg1 - arg0, true)
    }

    public entry fun switch_subscription(arg0: &0x2::clock::Clock, arg1: &mut HiveProfile, arg2: &mut HiveProfile, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        authority_check(arg1, 0x2::tx_context::sender(arg4));
        let v0 = 0x2::object::uid_to_address(&arg2.id);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        let v2 = 0x2::linked_table::borrow_mut<address, SubscriptionRecord>(&mut arg1.following_list, v0);
        let v3 = 0x2::linked_table::borrow_mut<address, SubscriptionRecord>(&mut arg2.followers_list, v1);
        assert!(v2.is_active, 1092);
        let v4 = *0x2::table::borrow<u8, u64>(&arg2.subscriptions, arg3);
        v2.switch_to_plan = 0x1::option::some<u64>((arg3 as u64));
        v3.switch_to_plan = 0x1::option::some<u64>((arg3 as u64));
        v2.switch_to_plan_price = 0x1::option::some<u64>(v4);
        v3.switch_to_plan_price = 0x1::option::some<u64>(v4);
        let v5 = SubscriptionSwitchedToNewPlan{
            follower_profile_addr : v1,
            profile_followed_addr : v0,
            follower_username     : 0x1::string::from_ascii(arg1.username),
            followed_username     : 0x1::string::from_ascii(arg2.username),
            new_subscription_type : arg3,
            new_subscription_cost : v4,
        };
        0x2::event::emit<SubscriptionSwitchedToNewPlan>(v5);
    }

    public entry fun transfer_hive_asset(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &mut HSuiDisperser<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg3: &mut HiveDisperser, arg4: &mut HiveProfile, arg5: &mut HiveProfile, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0 && arg3.module_version == 0 && arg4.module_version == 0 && arg5.module_version == 0, 1079);
        authority_check(arg4, 0x2::tx_context::sender(arg7));
        let (v0, v1) = withdraw_hive_asset(arg0, arg1, arg2, arg3, arg4, arg6, false);
        let v2 = v0;
        0x2::balance::join<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut arg4.available_hsui, v1);
        assert!(!v2.is_borrowed, 1066);
        deposit_hive_asset(arg5, v2);
        update_asset_ownership(arg1, arg6, 0x2::object::uid_to_address(&arg5.id));
        let v3 = HiveAssetTransfered{
            version      : arg6,
            from_profile : 0x2::object::uid_to_address(&arg4.id),
            to_profile   : 0x2::object::uid_to_address(&arg5.id),
        };
        0x2::event::emit<HiveAssetTransfered>(v3);
    }

    public entry fun transfer_hive_gems(arg0: &mut HiveProfile, arg1: &mut HiveProfile, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        authority_check(arg0, 0x2::tx_context::sender(arg3));
        0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::join(&mut arg1.available_gems, 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::split(&mut arg0.available_gems, arg2));
        let v0 = HiveGemsTransfered{
            from_username     : arg0.username,
            to_username       : arg1.username,
            from_profile_addr : 0x2::object::uid_to_address(&arg0.id),
            to_profile_addr   : 0x2::object::uid_to_address(&arg1.id),
            gems_transferred  : arg2,
        };
        0x2::event::emit<HiveGemsTransfered>(v0);
    }

    public fun transfer_kiosk(arg0: &0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::config::DegenHiveDeployerCap, arg1: &mut HiveProfileMappingStore, arg2: &mut HiveProfile, arg3: &mut HiveProfile, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = get_kiosk_storage_identifier(arg4, arg5);
        let v1 = remove_from_profile<CreatorHiveKiosk>(arg2, v0);
        let v2 = 0x2::object::uid_to_address(&v1.id);
        let v3 = 0x2::object::uid_to_address(&arg3.id);
        let v4 = 0x2::linked_table::remove<address, vector<address>>(&mut arg1.profile_to_creator_kiosk_mapping, 0x2::object::uid_to_address(&arg2.id));
        let (_, v6) = 0x1::vector::index_of<address>(&v4, &v2);
        0x1::vector::remove<address>(&mut v4, v6);
        if (0x2::linked_table::contains<address, vector<address>>(&arg1.profile_to_creator_kiosk_mapping, v3)) {
            0x1::vector::push_back<address>(0x2::linked_table::borrow_mut<address, vector<address>>(&mut arg1.profile_to_creator_kiosk_mapping, v3), v2);
        } else {
            let v7 = 0x1::vector::empty<address>();
            0x1::vector::push_back<address>(&mut v7, v2);
            0x2::linked_table::push_back<address, vector<address>>(&mut arg1.profile_to_creator_kiosk_mapping, v3, v7);
        };
        0x2::dynamic_object_field::add<0x1::ascii::String, CreatorHiveKiosk>(&mut arg3.id, v0, v1);
        let v8 = KioskOwnershipTransferred{
            aesthetic                    : arg4,
            type                         : arg5,
            creator_profile              : 0x2::object::uid_to_address(&arg2.id),
            creator_profile_username     : arg2.username,
            new_creator_profile          : 0x2::object::uid_to_address(&arg3.id),
            new_creator_profile_username : arg3.username,
            kiosk                        : v2,
        };
        0x2::event::emit<KioskOwnershipTransferred>(v8);
    }

    public entry fun unfollow_profile(arg0: &0x2::clock::Clock, arg1: &mut HiveProfile, arg2: &mut HiveProfile, arg3: &mut 0x2::tx_context::TxContext) {
        authority_check(arg1, 0x2::tx_context::sender(arg3));
        let v0 = 0x2::object::uid_to_address(&arg2.id);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        let v2 = 0x2::linked_table::borrow_mut<address, SubscriptionRecord>(&mut arg1.following_list, v0);
        let v3 = 0x2::linked_table::borrow_mut<address, SubscriptionRecord>(&mut arg2.followers_list, v1);
        assert!(v2.is_active, 1093);
        if (v2.next_payment_timestamp > 0x2::clock::timestamp_ms(arg0)) {
            v2.switch_to_plan = 0x1::option::some<u64>(10);
            v3.switch_to_plan = 0x1::option::some<u64>(10);
        } else {
            v2.is_active = false;
            v3.is_active = false;
        };
        let v4 = ProfileUnfollowed{
            follower_profile_addr   : v1,
            profile_unfollowed_addr : v0,
            follower_username       : 0x1::string::from_ascii(arg1.username),
            unfollowed_username     : 0x1::string::from_ascii(arg2.username),
        };
        0x2::event::emit<ProfileUnfollowed>(v4);
    }

    public fun unlock_hivecard(arg0: &0x2::clock::Clock, arg1: &0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::config::HiveDaoCapability, arg2: &mut HiveManager, arg3: &mut HSuiDisperser<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg4: &mut HiveDisperser, arg5: &mut HiveProfile, arg6: u64) : u64 {
        assert!(arg2.module_version == 0 && arg3.module_version == 0 && arg4.module_version == 0 && arg5.module_version == 0, 1079);
        let v0 = 0x2::linked_table::borrow<u64, HiveAsset>(&arg5.hive_assets, arg6);
        assert!(v0.is_staked, 1085);
        assert!(v0.unlock_timestamp < 0x2::clock::timestamp_ms(arg0), 1089);
        let v1 = v0.power;
        let (v2, v3) = withdraw_hive_asset(arg0, arg2, arg3, arg4, arg5, arg6, true);
        let v4 = v2;
        0x2::balance::join<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut arg5.available_hsui, v3);
        assert!(!v4.is_staked, 1091);
        deposit_hive_asset(arg5, v4);
        v1
    }

    fun unstake_hive_asset(arg0: &mut HiveManager, arg1: &mut HiveAsset) {
        arg0.active_power = arg0.active_power - (arg1.power as u128);
        arg0.locked_assets = arg0.locked_assets - 1;
        let v0 = TotalActivePowerUpdated{
            new_total_active_power : arg0.active_power,
            total_staked_assets    : arg0.locked_assets,
        };
        0x2::event::emit<TotalActivePowerUpdated>(v0);
        arg1.is_staked = false;
        arg1.power = 0;
        arg1.lockup_duration = 0;
    }

    fun update_asset_ownership(arg0: &mut HiveManager, arg1: u64, arg2: address) {
        if (0x2::linked_table::contains<u64, address>(&arg0.assets_to_profile_mapping, arg1)) {
            *0x2::linked_table::borrow_mut<u64, address>(&mut arg0.assets_to_profile_mapping, arg1) = arg2;
        } else {
            0x2::linked_table::push_back<u64, address>(&mut arg0.assets_to_profile_mapping, arg1, arg2);
        };
    }

    fun update_bid_among_bids(arg0: &mut vector<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg5: bool, arg6: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(arg0)) {
            let v1 = 0x1::vector::borrow<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(arg0, v0);
            if (v1.bidder_profile == arg1) {
                assert!(v1.is_valid, 1069);
                let (v2, _, _, _, _, _) = destroy_bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(0x1::vector::remove<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(arg0, v0), arg6);
                0x2::balance::join<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(arg4, v2);
                let v8 = Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>{
                    bidder_profile   : arg1,
                    balance          : 0x2::balance::split<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(arg4, arg2),
                    offer_hsui_price : arg2,
                    expiration_sec   : arg3,
                    is_listing_live  : arg5,
                    is_valid         : true,
                };
                0x1::vector::push_back<Bid<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>>(arg0, v8);
                return
            };
            v0 = v0 + 1;
        };
    }

    fun update_bid_record(arg0: &mut BidRecord, arg1: u64, arg2: u64, arg3: u64) {
        arg0.offer_hsui_price = arg1;
        if (arg2 > arg3) {
            assert!(arg2 - arg3 < 7776000000, 1030);
            arg0.expiration_sec = arg2;
        };
    }

    public fun update_bio(arg0: &0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::config::HiveEntryCap, arg1: &HiveManager, arg2: &mut HiveDisperser, arg3: &mut HiveProfile, arg4: 0x1::string::String, arg5: &0x2::tx_context::TxContext) {
        authority_check(arg3, 0x2::tx_context::sender(arg5));
        assert!(0x1::string::length(&arg4) <= 150, 1105);
        increment_gems_global_index(arg1, arg2);
        deposit_gems_for_hive(arg2, 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::split(&mut arg3.available_gems, arg1.config_params.social_fee_gems));
        arg3.bio = arg4;
        let v0 = BioUpdated{
            profile_addr : 0x2::object::uid_to_address(&arg3.id),
            username     : 0x1::string::from_ascii(arg3.username),
            new_bio      : arg3.bio,
        };
        0x2::event::emit<BioUpdated>(v0);
    }

    public fun update_config_for_skin_kraft(arg0: &0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::config::HiveDaoCapability, arg1: &mut HiveProfile, arg2: u64, arg3: 0x1::string::String, arg4: u64, arg5: bool, arg6: bool, arg7: u64, arg8: bool, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 1079);
        authority_check(arg1, 0x2::tx_context::sender(arg10));
        let v0 = 0x2::linked_table::borrow_mut<0x1::string::String, SkinRecord>(&mut 0x2::linked_table::borrow_mut<u64, HiveAsset>(&mut arg1.hive_assets, arg2).active_skins, arg3);
        if (arg4 > 0) {
            assert!(arg4 / 100 <= 25, 1035);
            v0.royalty_fee_percent = arg4;
            let v1 = SkinRoyaltyCommissionUpdated{
                version             : arg2,
                skin_type           : arg3,
                royalty_fee_percent : v0.royalty_fee_percent,
            };
            0x2::event::emit<SkinRoyaltyCommissionUpdated>(v1);
        };
        if (arg5) {
            assert!(arg7 / 100 <= 25, 1108);
            v0.only_followers_allowed = arg6;
            v0.followers_discount = arg7;
            let v2 = SkinFollowerPermissionsUpdated{
                version                : arg2,
                skin_type              : arg3,
                only_followers_allowed : v0.only_followers_allowed,
                followers_discount     : v0.followers_discount,
            };
            0x2::event::emit<SkinFollowerPermissionsUpdated>(v2);
        };
        if (arg8) {
            v0.public_skin_kraft_enabled = arg9;
            let v3 = SkinPublicKraftPermissionsUpdated{
                version              : arg2,
                skin_type            : arg3,
                public_kraft_enabled : v0.public_skin_kraft_enabled,
            };
            0x2::event::emit<SkinPublicKraftPermissionsUpdated>(v3);
        };
    }

    public fun update_keeper_accounts_list(arg0: &0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::config::DegenHiveDeployerCap, arg1: &mut HiveManager, arg2: address, arg3: bool) {
        if (!0x2::linked_table::contains<address, bool>(&arg1.keeper_accounts, arg2) && arg3) {
            0x2::linked_table::push_back<address, bool>(&mut arg1.keeper_accounts, arg2, arg3);
        } else if (!arg3) {
            *0x2::linked_table::borrow_mut<address, bool>(&mut arg1.keeper_accounts, arg2) = arg3;
        };
    }

    public fun update_lead_genai_asset(arg0: &0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::config::HiveEntryCap, arg1: &HiveManager, arg2: &mut HiveDisperser, arg3: &mut HiveProfile, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        authority_check(arg3, 0x2::tx_context::sender(arg5));
        assert!(0x2::linked_table::contains<u64, HiveAsset>(&arg3.hive_assets, arg4), 1114);
        increment_gems_global_index(arg1, arg2);
        deposit_gems_for_hive(arg2, 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::split(&mut arg3.available_gems, arg1.config_params.social_fee_gems));
        let v0 = 0x2::linked_table::borrow_mut<u64, HiveAsset>(&mut arg3.hive_assets, arg4);
        arg3.lead_genai_asset = 0x1::option::some<0x2::url::Url>(v0.img_url);
        let v1 = LeadGenAiAssetSet{
            profile_addr : 0x2::object::uid_to_address(&arg3.id),
            username     : 0x1::string::from_ascii(arg3.username),
            new_lead_url : 0x1::string::from_ascii(0x2::url::inner_url(&v0.img_url)),
        };
        0x2::event::emit<LeadGenAiAssetSet>(v1);
    }

    public entry fun update_listing(arg0: &0x2::clock::Clock, arg1: &HiveManager, arg2: &mut MarketPlace<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg3: &mut HiveProfile, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0 && arg3.module_version == 0, 1079);
        let v0 = 0x2::clock::timestamp_ms(arg0);
        authority_check(arg3, 0x2::tx_context::sender(arg8));
        assert!(0x2::linked_table::contains<u64, ListingRecord>(&arg3.listing_records, arg4), 1037);
        let v1 = 0x2::linked_table::borrow_mut<u64, Listing>(&mut arg2.active_listings, arg4);
        let v2 = 0x2::linked_table::borrow_mut<u64, ListingRecord>(&mut arg3.listing_records, arg4);
        assert!(v1.expiration_sec > v0, 1032);
        if (arg5 != 0) {
            v1.min_sui_price = arg5;
            v2.min_sui_price = arg5;
        };
        if (arg7 != 0) {
            assert!(arg7 > v1.start_sec && arg7 > v0 && arg7 - v0 < 7776000000, 1030);
            v1.expiration_sec = arg7;
            v2.expiration_sec = arg7;
        };
        if (arg6 != 0 && !v2.is_sale_listing) {
            assert!(0x2::table::contains<u8, u64>(&arg1.supported_lockup_durations, arg6), 1088);
            v1.lockup_duration = arg6;
            v2.lockup_duration = arg6;
        };
        let v3 = ListingUpdated{
            listed_by_profile : v1.listed_by_profile,
            version           : arg4,
            min_sui_price     : v1.min_sui_price,
            lockup_duration   : v1.lockup_duration,
            start_sec         : v1.start_sec,
            expiration_sec    : v1.expiration_sec,
        };
        0x2::event::emit<ListingUpdated>(v3);
    }

    public fun update_profile_config_params(arg0: &0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::config::HiveDaoCapability, arg1: &mut HiveManager, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        assert!(arg1.module_version == 0, 1079);
        if (arg2 > 0) {
            assert!(5 <= arg2 && 500 >= arg2, 1082);
            arg1.config_params.max_bids_per_asset = arg2;
        };
        if (arg3 > 0) {
            assert!(10000000 <= arg3, 1081);
            arg1.config_params.min_sui_bid_allowed = arg3;
        };
        if (arg4 > 0) {
            assert!(0 <= arg4 && 50000000000 >= arg4, 1080);
            arg1.config_params.profile_kraft_fees_sui = arg4;
        };
        if (arg5 > 0) {
            assert!(1000000 <= arg5 && 1000000000 >= arg5, 1080);
            arg1.config_params.social_fee_gems = arg5;
        };
        let v0 = ProfileConfigParamsUpdated{
            max_bids_per_asset     : arg1.config_params.max_bids_per_asset,
            min_sui_bid_allowed    : arg1.config_params.min_sui_bid_allowed,
            profile_kraft_fees_sui : arg1.config_params.profile_kraft_fees_sui,
            social_fee_gems        : arg1.config_params.social_fee_gems,
        };
        0x2::event::emit<ProfileConfigParamsUpdated>(v0);
    }

    public fun update_royalty(arg0: &0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::config::HiveDaoCapability, arg1: &mut HiveManager, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        assert!(arg1.module_version == 0, 1079);
        if (arg2 > 0 && arg3 > 0) {
            let v0 = 100 * arg2 / arg3;
            assert!(1 <= v0 && v0 <= 7, 1035);
            arg1.royalty.numerator = arg2;
            arg1.royalty.denominator = arg3;
        };
        if (arg4 > 0) {
            assert!(arg4 <= 25, 1036);
            arg1.royalty.assets_dispersal_percent = arg4;
        };
        if (arg5 > 0) {
            assert!(arg5 <= 50, 1036);
            arg1.royalty.creators_royalty_percent = arg5;
        };
        if (arg6 > 0 && arg7 > 0) {
            let v1 = 100 * arg6 / arg7;
            assert!(5 <= v1 && v1 <= 15, 1035);
            arg1.gems_royalty.numerator = arg6;
            arg1.gems_royalty.denominator = arg7;
        };
        if (arg8 > 0) {
            assert!(arg8 <= 25, 1036);
            arg1.gems_royalty.treasury_percent = arg8;
        };
        if (arg9 > 0) {
            assert!(arg9 <= 25, 1036);
            arg1.gems_royalty.burn_percent = arg9;
        };
        let v2 = KraftRoyaltyUpdated{
            royalty_num              : arg1.royalty.numerator,
            royalty_denom            : arg1.royalty.denominator,
            assets_dispersal_percent : arg1.royalty.assets_dispersal_percent,
            creators_royalty_percent : arg1.royalty.creators_royalty_percent,
            gems_royalty_num         : arg6,
            gems_royalty_denom       : arg7,
            gems_treasury_percent    : arg8,
            gems_burn_percent        : arg9,
        };
        0x2::event::emit<KraftRoyaltyUpdated>(v2);
    }

    public fun update_subscription_pricing(arg0: &0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::config::HiveEntryCap, arg1: &HiveManager, arg2: &mut HiveDisperser, arg3: &mut HiveProfile, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        authority_check(arg3, 0x2::tx_context::sender(arg7));
        increment_gems_global_index(arg1, arg2);
        deposit_gems_for_hive(arg2, 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::split(&mut arg3.available_gems, arg1.config_params.social_fee_gems));
        *0x2::table::borrow_mut<u8, u64>(&mut arg3.subscriptions, 1) = arg4;
        *0x2::table::borrow_mut<u8, u64>(&mut arg3.subscriptions, 3) = arg5;
        *0x2::table::borrow_mut<u8, u64>(&mut arg3.subscriptions, 12) = arg6;
        let v0 = SubscriptionPlanUpdated{
            profile_addr             : 0x2::object::uid_to_address(&arg3.id),
            username                 : 0x1::string::from_ascii(arg3.username),
            new_one_month_sub_cost   : arg4,
            new_three_month_sub_cost : arg5,
            new_one_year_sub_cost    : arg6,
        };
        0x2::event::emit<SubscriptionPlanUpdated>(v0);
    }

    public fun update_username(arg0: &0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::config::HiveEntryCap, arg1: &HiveManager, arg2: &mut HiveProfileMappingStore, arg3: &mut HiveDisperser, arg4: &mut HiveProfile, arg5: 0x1::string::String, arg6: &0x2::tx_context::TxContext) {
        authority_check(arg4, 0x2::tx_context::sender(arg6));
        assert!(is_valid_profile_name(arg5), 1084);
        assert!(!arg4.is_composable_profile, 1100);
        increment_gems_global_index(arg1, arg3);
        deposit_gems_for_hive(arg3, 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::split(&mut arg4.available_gems, arg1.config_params.social_fee_gems));
        let v0 = 0x1::string::to_ascii(arg5);
        0x2::linked_table::remove<0x1::ascii::String, address>(&mut arg2.username_to_profile_mapping, arg4.username);
        arg4.username = v0;
        0x2::linked_table::push_back<0x1::ascii::String, address>(&mut arg2.username_to_profile_mapping, v0, 0x2::object::uid_to_address(&arg4.id));
        let v1 = UserNameUpdated{
            profile_addr  : 0x2::object::uid_to_address(&arg4.id),
            prev_username : 0x1::string::from_ascii(arg4.username),
            new_username  : arg5,
        };
        0x2::event::emit<UserNameUpdated>(v1);
    }

    public fun upgrade_asset_via_kiosk(arg0: &0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::config::HiveEntryCap, arg1: &0x2::clock::Clock, arg2: &mut HiveManager, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut HiveDisperser, arg6: &mut HiveProfile, arg7: &mut HiveProfile, arg8: u64, arg9: u64, arg10: &0x2::tx_context::TxContext) {
        authority_check(arg7, 0x2::tx_context::sender(arg10));
        let v0 = get_kiosk_storage_identifier(arg3, arg4);
        let v1 = remove_from_profile<CreatorHiveKiosk>(arg6, v0);
        assert!(0x2::linked_table::contains<u64, address>(&v1.krafted_versions_map, arg8), 1079);
        let v2 = 0x2::object::uid_to_address(&arg6.id);
        increment_gems_global_index(arg2, arg5);
        let v3 = 0x2::linked_table::remove<u64, vector<AssetUpgrade>>(&mut v1.available_upgrades, arg8);
        let v4 = 0x1::vector::remove<AssetUpgrade>(&mut v3, arg9);
        0x2::linked_table::push_back<u64, vector<AssetUpgrade>>(&mut v1.available_upgrades, arg8, v3);
        let v5 = v4.upgrade_price;
        let v6 = v5;
        if (v4.followers_only) {
            assert!(0x2::linked_table::contains<address, SubscriptionRecord>(&arg7.following_list, v2), 1099);
            let v7 = 0x2::linked_table::borrow<address, SubscriptionRecord>(&arg7.following_list, v2);
            assert!(0x2::clock::timestamp_ms(arg1) < v7.next_payment_timestamp && v7.is_active, 1088);
            v6 = (0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::math::mul_div_u256((v5 as u256), ((100 - v4.followers_discount) as u256), 100) as u64);
        };
        let v8 = 0x2::linked_table::borrow_mut<u64, HiveAsset>(&mut arg7.hive_assets, arg8);
        v8.img_url = v4.upgrade_img_url;
        let v9 = 0;
        while (v9 < 0x1::vector::length<0x1::string::String>(&v4.upgrade_traits_list)) {
            let v10 = *0x1::vector::borrow<0x1::string::String>(&v4.upgrade_traits_list, v9);
            if (0x2::linked_table::contains<0x1::string::String, 0x1::string::String>(&v8.prompts, v10)) {
                *0x2::linked_table::borrow_mut<0x1::string::String, 0x1::string::String>(&mut v8.prompts, v10) = *0x2::table::borrow<0x1::string::String, 0x1::string::String>(&v4.upgrade_prompts, v10);
            };
            v9 = v9 + 1;
        };
        let (v11, v12, v13, v14) = process_gems_royalty(arg2, 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::split(&mut arg7.available_gems, v6), arg5);
        0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::join(&mut arg6.available_gems, v11);
        let AssetUpgrade {
            upgrade_price       : v15,
            followers_only      : _,
            followers_discount  : _,
            upgrade_img_url     : _,
            upgrade_traits_list : _,
            upgrade_prompts     : v20,
        } = v4;
        0x2::table::drop<0x1::string::String, 0x1::string::String>(v20);
        let v21 = HiveAssetUpgraded{
            version           : arg8,
            hive_kiosk        : 0x2::object::uid_to_address(&v1.id),
            new_img_url       : 0x1::string::from_ascii(0x2::url::inner_url(&v8.img_url)),
            upgrade_price     : v15,
            total_royalty_amt : v12,
            treasury_amt      : v13,
            gems_burnt        : v14,
        };
        0x2::event::emit<HiveAssetUpgraded>(v21);
        add_to_profile<CreatorHiveKiosk>(arg6, v0, v1);
    }

    public fun withdraw_gems_from_profile(arg0: &mut HiveProfile, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::HiveGems {
        authority_check(arg0, 0x2::tx_context::sender(arg2));
        let v0 = GemWithdrawnFromProfile{
            username       : arg0.username,
            profile_addr   : 0x2::object::uid_to_address(&arg0.id),
            withdrawn_gems : arg1,
        };
        0x2::event::emit<GemWithdrawnFromProfile>(v0);
        0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::split(&mut arg0.available_gems, arg1)
    }

    fun withdraw_hive_asset(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &mut HSuiDisperser<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>, arg3: &mut HiveDisperser, arg4: &mut HiveProfile, arg5: u64, arg6: bool) : (HiveAsset, 0x2::balance::Balance<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>) {
        assert!(0x2::linked_table::contains<u64, HiveAsset>(&arg4.hive_assets, arg5), 1024);
        increment_global_index(arg1, arg2);
        increment_gems_global_index(arg1, arg3);
        let v0 = 0x2::linked_table::borrow_mut<u64, HiveAsset>(&mut arg4.hive_assets, arg5);
        let v1 = 0x2::balance::zero<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>();
        if (arg6) {
            assert!(v0.is_staked && v0.unlock_timestamp < 0x2::clock::timestamp_ms(arg0), 1067);
            let (v2, v3, v4) = claim_accrued_rewards_for_asset(arg0, arg1, arg2, arg3, v0);
            0x2::balance::join<0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hsui::HSUI>(&mut v1, v3);
            0x364b3e5f475ffbc9124454011f973db1e1335a98b1b20026f78b162e7ca7df6a::hive_gems::join(&mut arg4.available_gems, v2);
            if (v4) {
                let v5 = HiveAssetUnstaked{
                    profile_addr : 0x2::object::uid_to_address(&arg4.id),
                    version      : arg5,
                };
                0x2::event::emit<HiveAssetUnstaked>(v5);
            };
        } else {
            assert!(!v0.is_staked, 1021);
        };
        (0x2::linked_table::remove<u64, HiveAsset>(&mut arg4.hive_assets, arg5), v1)
    }

    // decompiled from Move bytecode v6
}

