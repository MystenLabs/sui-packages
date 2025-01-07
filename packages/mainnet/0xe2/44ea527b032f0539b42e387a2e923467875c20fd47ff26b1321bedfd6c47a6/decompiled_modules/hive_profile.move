module 0xe244ea527b032f0539b42e387a2e923467875c20fd47ff26b1321bedfd6c47a6::hive_profile {
    struct HIVE_PROFILE has drop {
        dummy_field: bool,
    }

    struct HiveProfileDeployerCap has store, key {
        id: 0x2::object::UID,
    }

    struct BuidlersRoyaltyCollectionAbility has store, key {
        id: 0x2::object::UID,
    }

    struct HiveProfileConfig has store, key {
        id: 0x2::object::UID,
        hive_gems_for_cards: 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::HiveGems,
        config_params: ConfigParams,
        active_cards: u64,
        locked_cards: u64,
        total_cards: u64,
        cards_to_profile_mapping: 0x2::table::Table<u64, address>,
        active_power: u128,
        supported_lockup_durations: 0x2::table::Table<u8, u64>,
        royalty: Royalty,
        gems_royalty: HiveSubscriptionRoyalty,
        buidlers_royalty: 0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>,
        module_version: u64,
        creator_royalties: 0x2::table::Table<address, 0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>,
    }

    struct Royalty has copy, store {
        numerator: u64,
        denominator: u64,
        cards_dispersal_percent: u64,
        creators_royalty_percent: u64,
    }

    struct HiveSubscriptionRoyalty has copy, store {
        numerator: u64,
        denominator: u64,
        treasury_percent: u64,
    }

    struct ConfigParams has copy, store {
        max_bids_per_card: u64,
        min_bid_allowed: u64,
        profile_kraft_fees: u64,
        social_param_update_fee: u64,
    }

    struct HiveDisperser has store, key {
        id: 0x2::object::UID,
        incoming_gems_for_cards: 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::HiveGems,
        gems_for_cards: 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::HiveGems,
        global_dispersal_index: u256,
        module_version: u64,
    }

    struct HSuiDisperser<phantom T0> has store, key {
        id: 0x2::object::UID,
        incoming_hsui_for_cards: 0x2::balance::Balance<T0>,
        hsui_for_cards: 0x2::balance::Balance<T0>,
        global_dispersal_index: u256,
        module_version: u64,
    }

    struct HiveProfileMappingStore has key {
        id: 0x2::object::UID,
        hive_profile_ids: 0x2::table::Table<address, 0x2::object::ID>,
        hive_profile_names: 0x2::table::Table<0x1::ascii::String, 0x2::object::ID>,
        module_version: u64,
    }

    struct HiveProfile has store, key {
        id: 0x2::object::UID,
        username: 0x1::ascii::String,
        owner: address,
        is_owned_obj: bool,
        available_gems: 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::HiveGems,
        available_hsui: 0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>,
        hive_cards: 0x2::table::Table<u64, HiveCard>,
        available_versions: vector<u64>,
        incoming_bids: 0x2::table::Table<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>,
        borrowed_versions: vector<u64>,
        borrow_records: 0x2::table::Table<u64, BorrowRecord>,
        listing_records: 0x2::table::Table<u64, ListingRecord>,
        listed_versions: vector<u64>,
        bid_records: 0x2::table::Table<u64, BidRecord>,
        bidded_versions: vector<u64>,
        lend_records: 0x2::table::Table<u64, LendRecord>,
        lend_versions: vector<u64>,
        subscriptions: 0x2::table::Table<u8, u64>,
        followers_list: 0x2::table::Table<address, Subscription>,
        following_list: 0x2::table::Table<address, Subscription>,
        module_version: u64,
    }

    struct Subscription has copy, store {
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

    struct MarketPlace<phantom T0> has store, key {
        id: 0x2::object::UID,
        active_listings: 0x2::table::Table<u64, Listing>,
        available_bids: 0x2::table::Table<u64, vector<Bid<T0>>>,
        processed_listings: 0x2::table::Table<u64, ExecutedListing<T0>>,
        module_version: u64,
    }

    struct HiveCard has store, key {
        id: 0x2::object::UID,
        version: u64,
        power: u64,
        available_gems: 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::HiveGems,
        claim_index: u256,
        gems_claim_index: u256,
        name: 0x1::string::String,
        img_url: 0x2::url::Url,
        aesthetic: 0x1::string::String,
        character: 0x1::string::String,
        traits_list: vector<0x1::string::String>,
        prompts: 0x2::table::Table<0x1::string::String, 0x1::string::String>,
        total_hsui_claimed: u64,
        total_gems_claimed: u64,
        is_borrowed: bool,
        is_staked: bool,
        lockup_duration: u8,
        unlock_timestamp: u64,
        active_skins: 0x2::table::Table<0x1::string::String, SkinRecord>,
        creator_profile: address,
    }

    struct SkinRecord has store {
        admin_address: address,
        public_skin_kraft_enabled: bool,
        royalty_fee_percent: u64,
        total_gems_ported: u64,
        total_skins_krafted: u64,
    }

    struct Listing has store {
        listed_by_profile: address,
        hive_card: HiveCard,
        followers_only: bool,
        min_price: u64,
        is_sale_listing: bool,
        instant_sale: bool,
        highest_bid_sale: bool,
        lockup_duration: u8,
        start_sec: u64,
        expiration_sec: u64,
    }

    struct ListingRecord has store {
        version: u64,
        followers_only: bool,
        min_price: u64,
        is_sale_listing: bool,
        instant_sale: bool,
        highest_bid_sale: bool,
        lockup_duration: u8,
        start_sec: u64,
        expiration_sec: u64,
    }

    struct Bid<phantom T0> has store {
        bidder_profile: address,
        balance: 0x2::balance::Balance<T0>,
        offer_price: u64,
        expiration_sec: u64,
        is_listing_live: bool,
        is_valid: bool,
    }

    struct BidRecord has store {
        version: u64,
        offer_price: u64,
        expiration_sec: u64,
        is_card_listed: bool,
    }

    struct LendRecord has store {
        borrower: address,
        version: u64,
        lend_price: u64,
        start_sec: u64,
        lockup_duration: u8,
        expiration_sec: u64,
    }

    struct BorrowRecord has store {
        owner: address,
        borrow_price: u64,
        start_sec: u64,
        lockup_duration: u8,
        expiration_sec: u64,
    }

    struct ExecutedListing<phantom T0> has store {
        listed_by_profile: address,
        hive_card: 0x1::option::Option<HiveCard>,
        version: u64,
        was_sale_listing: bool,
        balance: 0x1::option::Option<0x2::balance::Balance<T0>>,
        bidder_profile: address,
        executed_price: u64,
        borrow_period_start_sec: u64,
        borrow_period_end_sec: u64,
    }

    struct CreatorHiveKiosk has key {
        id: 0x2::object::UID,
        creator_profile: address,
        followers_only: bool,
        aesthetic: 0x1::string::String,
        character: 0x1::string::String,
        img_url: 0x2::url::Url,
        init_hive_gems: u64,
        traits_list: vector<0x1::string::String>,
        prompts_list: vector<vector<0x1::string::String>>,
        url_list: vector<0x1::string::String>,
        names_list: vector<0x1::string::String>,
        krafted_versions_map: 0x2::table::Table<u64, bool>,
        total_cards: u64,
        krafted_cards: u64,
        base_price: u64,
        curve_a: u64,
        available_upgrades: 0x2::table::Table<u64, vector<CardUpgrade>>,
        module_version: u64,
    }

    struct CardUpgrade has store {
        upgrade_price: u64,
        followers_only: bool,
        upgrade_img_url: 0x2::url::Url,
        upgrade_traits_list: vector<0x1::string::String>,
        upgrade_prompts: 0x2::table::Table<0x1::string::String, 0x1::string::String>,
        added_traits_list: vector<0x1::string::String>,
        added_prompts: 0x2::table::Table<0x1::string::String, 0x1::string::String>,
        removed_traits_list: vector<0x1::string::String>,
    }

    struct WhitelistKraftConfig has key {
        id: 0x2::object::UID,
        aesthetic: 0x1::string::String,
        character: 0x1::string::String,
        whitelisted_addresses: 0x2::table::Table<address, u64>,
        start_time: u64,
        end_time: u64,
        available_cards_to_kraft: u64,
        krafts_processed: u64,
        base_price: u64,
        curve_a: u64,
        module_version: u64,
    }

    struct PublicKraftConfig has key {
        id: 0x2::object::UID,
        aesthetic: 0x1::string::String,
        character: 0x1::string::String,
        address_list: 0x2::table::Table<address, u64>,
        start_time: u64,
        per_user_limit: u64,
        available_cards_to_kraft: u64,
        krafts_processed: u64,
        module_version: u64,
    }

    struct PublicKraftInitialized has copy, drop {
        id: 0x2::object::ID,
        aesthetic: 0x1::string::String,
        character: 0x1::string::String,
        start_time: u64,
        per_user_limit: u64,
        available_cards_to_kraft: u64,
    }

    struct WhitelistKraftInitialized has copy, drop {
        id: 0x2::object::ID,
        aesthetic: 0x1::string::String,
        character: 0x1::string::String,
        start_time: u64,
        end_time: u64,
        base_price: u64,
        curve_a: u64,
        available_cards_to_kraft: u64,
    }

    struct KraftYieldHarvested has copy, drop {
        sui_yield: u64,
        receiver: address,
    }

    struct CreatorProfileUpdatedForCard has copy, drop {
        version: u64,
        prev_creator_profile: address,
        new_creator_profile: address,
    }

    struct RoyaltyCollectedForCreator has copy, drop {
        creator_profile: address,
        hsui_collected: u64,
    }

    struct ProfileConfigParamsUpdated has copy, drop {
        max_bids_per_card: u64,
        min_bid_allowed: u64,
        profile_kraft_fees: u64,
    }

    struct KraftRoyaltyUpdated has copy, drop {
        royalty_num: u64,
        royalty_denom: u64,
        cards_dispersal_percent: u64,
        creators_royalty_percent: u64,
    }

    struct TotalActivePowerUpdated has copy, drop {
        new_total_active_power: u128,
    }

    struct HiveCardStaked has copy, drop {
        staker: address,
        profile_addr: address,
        version: u64,
        duration: u8,
        new_card_power: u64,
        unlock_timestamp: u64,
    }

    struct HiveCardUnstaked has copy, drop {
        profile_addr: address,
        version: u64,
    }

    struct NewSkinForCard has copy, drop {
        version: u64,
        skin_type: 0x1::string::String,
        admin_address: address,
        public_skin_kraft_enabled: bool,
        royalty_fee_percent: u64,
    }

    struct NewSkinForCardKrafted has copy, drop {
        krafted_by: address,
        version: u64,
        skin_type: 0x1::string::String,
        skin_price: u64,
        skins_krafted_for_type_by_card: u64,
        royalty_earned_by_owner: u64,
    }

    struct HiveGemsPortedToSkin has copy, drop {
        ported_by: address,
        version: u64,
        skin_type: 0x1::string::String,
        gems_ported: u64,
    }

    struct SkinAdminUpdated has copy, drop {
        version: u64,
        skin_type: 0x1::string::String,
        new_admin: address,
    }

    struct SkinRoyaltyCommissionUpdated has copy, drop {
        version: u64,
        skin_type: 0x1::string::String,
        royalty_fee_percent: u64,
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
        profile_id: address,
        deposited_gems: u64,
    }

    struct CardPowerUpdated has copy, drop {
        version: u64,
        add_power: u64,
        new_card_power: u64,
    }

    struct HiveGemsDepositedIntoCard has copy, drop {
        profile: address,
        version: u64,
        gems_deposited: u64,
    }

    struct HiveProfileKrafted has copy, drop {
        name: 0x1::string::String,
        new_profile_addr: address,
        krafter: address,
        fee: u64,
        is_owned: bool,
    }

    struct NewHiveCardKrafted has copy, drop {
        id: 0x2::object::ID,
        krafter_profile_addr: address,
        krafter: address,
        aesthetic: 0x1::string::String,
        character: 0x1::string::String,
        name: 0x1::string::String,
        version: u64,
        img_url: 0x1::string::String,
        genesis_hivegems: u64,
        power: u64,
        price: u64,
        traits_list: vector<0x1::string::String>,
        prompts_list: vector<0x1::string::String>,
    }

    struct HiveRewardsHarvested has copy, drop {
        harvester: address,
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
        version: u64,
        min_price: u64,
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
        followers_only: bool,
        min_price: u64,
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
        version: u64,
        bidder_profile: address,
        offer_price: u64,
        expiration_sec: u64,
        is_card_listed: bool,
    }

    struct BidDestroyed has copy, drop {
        card_version: u64,
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
        price: u64,
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
        offer_price: u64,
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
        executed_price: u64,
        listed_by_profile: address,
    }

    struct HiveCardBorrowed has copy, drop {
        version: u64,
        borrower: address,
        lender: address,
        borrow_price: u64,
        lockup_duration: u8,
        borrow_start_sec: u64,
        borrow_exp_sec: u64,
    }

    struct ReturnBorrowedHiveCard has copy, drop {
        version: u64,
        owner: address,
        borrower: address,
    }

    struct HighestBidListingUnsold has copy, drop {
        version: u64,
        listed_by_profile: address,
    }

    struct HiveGemsTransfered has copy, drop {
        from: address,
        to: address,
        gems_transferred: u64,
    }

    struct HiveCardTransfered has copy, drop {
        version: u64,
        from: address,
        to: address,
    }

    struct HarvestRewardsForCard has copy, drop {
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
        profile_addr: address,
        withdrawn_gems: u64,
    }

    struct ProfileFollowed has copy, drop {
        follower: 0x1::string::String,
        follower_profile: address,
        following: 0x1::string::String,
        following_profile: address,
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

    struct HiveCardUpgraded has copy, drop {
        version: u64,
        hive_kiosk: address,
        new_img_url: 0x1::string::String,
        new_traits_list: vector<0x1::string::String>,
        upgrade_price: u64,
        total_royalty_amt: u64,
        gems_burnt: u64,
    }

    struct KioskFollowersOnlyFlagUpdated has copy, drop {
        hive_kiosk: address,
        followers_only: bool,
    }

    struct RemovedUpgradeForVersion has copy, drop {
        hive_kiosk: address,
        version: u64,
        new_img_url: 0x1::string::String,
    }

    struct AddedNewUpgradeForVersion has copy, drop {
        hive_kiosk: address,
        version: u64,
        new_img_url: 0x1::string::String,
        upgrade_traits_list: vector<0x1::string::String>,
        upgrade_prompts_list: vector<0x1::string::String>,
        added_traits_list: vector<0x1::string::String>,
        added_prompts_list: vector<0x1::string::String>,
        removed_traits_list: vector<0x1::string::String>,
    }

    public entry fun accept_bid(arg0: &0x2::clock::Clock, arg1: &mut HiveProfileConfig, arg2: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg3: &mut MarketPlace<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg4: &mut HiveProfile, arg5: &mut HiveProfile, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0 && arg3.module_version == 0, 1079);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::clock::timestamp_ms(arg0);
        assert!(arg4.is_owned_obj || arg4.owner == v0, 1057);
        let (v2, v3) = 0x1::vector::index_of<u64>(&arg4.listed_versions, &arg6);
        assert!(v2, 1045);
        let v4 = 0x2::table::remove<u64, ListingRecord>(&mut arg4.listing_records, arg6);
        assert!(v4.expiration_sec > v1, 1032);
        let v5 = &mut arg4.listed_versions;
        let (_, _, _, _, _, _, _, _, _) = destroy_listing_record(v5, v3, v4);
        let (_, v16) = 0x1::vector::index_of<u64>(&arg5.bidded_versions, &arg6);
        let v17 = 0x2::table::remove<u64, BidRecord>(&mut arg5.bid_records, arg6);
        assert!(v17.expiration_sec > v1, 1071);
        let v18 = &mut arg5.bidded_versions;
        let (_, _, _, _) = destroy_bid_record(v17, v18, v16);
        let v23 = 0x2::balance::zero<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>();
        let v24 = &mut v23;
        let (v25, v26) = execute_sale(arg1, arg3, arg2, arg6, true, arg5.owner, 0, v24);
        let v27 = v26;
        0x2::balance::join<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut arg4.available_hsui, 0x1::option::extract<0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&mut v27.balance));
        update_card_ownership(arg1, arg6, 0x2::object::uid_to_address(&arg5.id));
        deposit_hive_card(arg5, v25);
        let (_, v29, _, _, v32, _, _, _, _) = destroy_executed_listing<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(v27);
        0x1::option::destroy_none<HiveCard>(v29);
        0x1::option::destroy_none<0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(v32);
        destroy_or_transfer_balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(v23, v0, arg7);
    }

    public entry fun accept_direct_bid(arg0: &0x2::clock::Clock, arg1: &mut HiveProfileConfig, arg2: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg3: &mut HiveDisperser, arg4: &mut HiveProfile, arg5: &mut HiveProfile, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0 && arg3.module_version == 0, 1079);
        let v0 = 0x2::object::uid_to_address(&arg5.id);
        let v1 = 0x2::object::uid_to_address(&arg4.id);
        assert!(arg4.is_owned_obj || arg4.owner == 0x2::tx_context::sender(arg7), 1057);
        let (v2, _) = 0x1::vector::index_of<u64>(&arg4.available_versions, &arg6);
        assert!(v2, 1064);
        assert!(0x1::vector::contains<u64>(&arg5.bidded_versions, &arg6), 1033);
        let (_, v5) = 0x1::vector::index_of<u64>(&arg5.bidded_versions, &arg6);
        let v6 = 0x2::table::remove<u64, BidRecord>(&mut arg5.bid_records, arg6);
        assert!(v6.expiration_sec > 0x2::clock::timestamp_ms(arg0), 1071);
        let (v7, v8) = withdraw_hive_card(arg0, arg1, arg2, arg3, arg4, arg6, false);
        let v9 = v7;
        0x2::balance::join<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut arg4.available_hsui, v8);
        let v10 = 0;
        let v11 = v10;
        let v12 = 0x2::balance::zero<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>();
        let v13 = 0x2::table::remove<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(&mut arg4.incoming_bids, arg6);
        let v14 = 0;
        while (v14 < 0x1::vector::length<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&v13)) {
            let v15 = 0x1::vector::borrow_mut<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&mut v13, v14);
            if (v15.bidder_profile == v0) {
                let v16 = 0x1::vector::remove<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&mut v13, v14);
                assert!(v16.is_valid, 1072);
                let (v17, _, v19, _, _, _) = destroy_bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(v16, arg6);
                if (v10 == 0) {
                    v11 = v19;
                };
                0x2::balance::join<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut v12, v17);
                break
            };
            v15.is_valid = false;
            v14 = v14 + 1;
        };
        0x2::table::add<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(&mut arg4.incoming_bids, arg6, v13);
        let v23 = &mut arg5.bidded_versions;
        let (_, _, _, _) = destroy_bid_record(v6, v23, v5);
        let v28 = v12;
        v12 = process_royalty(v28, arg1, arg2, v9.creator_profile);
        0x2::balance::join<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut arg4.available_hsui, v12);
        update_card_ownership(arg1, arg6, v0);
        deposit_hive_card(arg5, v9);
        let v29 = SaleExecuted{
            version        : arg6,
            buyer_profile  : v0,
            seller_profile : v1,
            price          : v11,
        };
        0x2::event::emit<SaleExecuted>(v29);
    }

    fun add_bid_record_to_profile(arg0: &mut HiveProfile, arg1: u64, arg2: BidRecord) {
        0x2::table::add<u64, BidRecord>(&mut arg0.bid_records, arg1, arg2);
        0x1::vector::push_back<u64>(&mut arg0.bidded_versions, arg1);
    }

    fun add_bid_to_table(arg0: &mut 0x2::table::Table<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>, arg1: u64, arg2: Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg3: u64) {
        if (0x2::table::contains<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(arg0, arg1)) {
            let v0 = 0x2::table::borrow_mut<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(arg0, arg1);
            assert!(0x1::vector::length<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(v0) < arg3, 1078);
            0x1::vector::push_back<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(v0, arg2);
        } else {
            let v1 = 0x1::vector::empty<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>();
            0x1::vector::push_back<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&mut v1, arg2);
            0x2::table::add<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(arg0, arg1, v1);
        };
    }

    public entry fun add_card_upgrade_to_kiosk(arg0: &mut HiveProfile, arg1: &mut CreatorHiveKiosk, arg2: u64, arg3: bool, arg4: u64, arg5: 0x1::string::String, arg6: vector<0x1::string::String>, arg7: vector<0x1::string::String>, arg8: vector<0x1::string::String>, arg9: vector<0x1::string::String>, arg10: vector<0x1::string::String>, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.creator_profile, 1095);
        assert!(arg0.is_owned_obj || arg0.owner == 0x2::tx_context::sender(arg11), 1095);
        assert!(*0x2::table::borrow<u64, bool>(&arg1.krafted_versions_map, arg2), 1079);
        assert!(0x1::vector::length<0x1::string::String>(&arg6) < 5 && 0x1::vector::length<0x1::string::String>(&arg6) == 0x1::vector::length<0x1::string::String>(&arg7), 1051);
        assert!(0x1::vector::length<0x1::string::String>(&arg8) < 5 && 0x1::vector::length<0x1::string::String>(&arg8) == 0x1::vector::length<0x1::string::String>(&arg9), 1051);
        assert!(0x1::vector::length<0x1::string::String>(&arg10) < 5, 1051);
        let v0 = CardUpgrade{
            upgrade_price       : arg4,
            followers_only      : arg3,
            upgrade_img_url     : 0x2::url::new_unsafe(0x1::string::to_ascii(arg5)),
            upgrade_traits_list : arg6,
            upgrade_prompts     : 0x2::table::new<0x1::string::String, 0x1::string::String>(arg11),
            added_traits_list   : arg8,
            added_prompts       : 0x2::table::new<0x1::string::String, 0x1::string::String>(arg11),
            removed_traits_list : arg10,
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg6)) {
            0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v0.upgrade_prompts, *0x1::vector::borrow<0x1::string::String>(&arg6, v1), *0x1::vector::borrow<0x1::string::String>(&arg7, v1));
            v1 = v1 + 1;
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&arg8)) {
            0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v0.added_prompts, *0x1::vector::borrow<0x1::string::String>(&arg8, v2), *0x1::vector::borrow<0x1::string::String>(&arg9, v2));
            v2 = v2 + 1;
        };
        if (!0x2::table::contains<u64, vector<CardUpgrade>>(&arg1.available_upgrades, arg2)) {
            let v3 = 0x1::vector::empty<CardUpgrade>();
            0x1::vector::push_back<CardUpgrade>(&mut v3, v0);
            0x2::table::add<u64, vector<CardUpgrade>>(&mut arg1.available_upgrades, arg2, v3);
        } else {
            let v4 = 0x2::table::remove<u64, vector<CardUpgrade>>(&mut arg1.available_upgrades, arg2);
            assert!(0x1::vector::length<CardUpgrade>(&v4) < 10, 1098);
            0x1::vector::push_back<CardUpgrade>(&mut v4, v0);
            0x2::table::add<u64, vector<CardUpgrade>>(&mut arg1.available_upgrades, arg2, v4);
        };
        let v5 = AddedNewUpgradeForVersion{
            hive_kiosk           : 0x2::object::uid_to_address(&arg1.id),
            version              : arg2,
            new_img_url          : arg5,
            upgrade_traits_list  : arg6,
            upgrade_prompts_list : arg7,
            added_traits_list    : arg8,
            added_prompts_list   : arg9,
            removed_traits_list  : arg10,
        };
        0x2::event::emit<AddedNewUpgradeForVersion>(v5);
    }

    public fun add_to_profile<T0: copy + drop + store, T1: store + key>(arg0: bool, arg1: &mut HiveProfile, arg2: T0, arg3: T1, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::dynamic_object_field::add<T0, T1>(&mut arg1.id, arg2, arg3);
    }

    public entry fun add_to_whitelist(arg0: &HiveProfileDeployerCap, arg1: &mut WhitelistKraftConfig, arg2: &0x2::clock::Clock, arg3: vector<address>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 1079);
        assert!(arg1.end_time > 0x2::clock::timestamp_ms(arg2), 1007);
        assert!(arg4 > 0, 1068);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg3)) {
            let v1 = *0x1::vector::borrow<address>(&arg3, v0);
            if (!0x2::table::contains<address, u64>(&arg1.whitelisted_addresses, v1)) {
                0x2::table::add<address, u64>(&mut arg1.whitelisted_addresses, v1, arg4);
            } else {
                *0x2::table::borrow_mut<address, u64>(&mut arg1.whitelisted_addresses, v1) = arg4;
            };
            v0 = v0 + 1;
        };
    }

    fun assertion_check(arg0: bool, arg1: address, arg2: address) {
        if (arg0) {
            assert!(arg1 == arg2, 1057);
        };
    }

    public fun borrow_from_profile<T0: copy + drop + store, T1: store + key>(arg0: &HiveProfile, arg1: T0) : &T1 {
        0x2::dynamic_object_field::borrow<T0, T1>(&arg0.id, arg1)
    }

    public entry fun borrow_hive_card_with_hsui(arg0: &0x2::clock::Clock, arg1: &mut HiveProfileConfig, arg2: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg3: &mut MarketPlace<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg4: &mut HiveProfile, arg5: &mut HiveProfile, arg6: u64, arg7: 0x2::coin::Coin<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0 && arg3.module_version == 0, 1079);
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x2::object::uid_to_address(&arg5.id);
        let v2 = 0x2::tx_context::sender(arg8);
        assert!(arg4.is_owned_obj || arg4.owner == v2, 1057);
        let (v3, v4) = 0x1::vector::index_of<u64>(&arg5.listed_versions, &arg6);
        assert!(v3, 1070);
        let v5 = 0x2::table::remove<u64, ListingRecord>(&mut arg5.listing_records, arg6);
        assert!(v5.expiration_sec > v0, 1032);
        assert!(!v5.is_sale_listing, 1047);
        if (v5.followers_only) {
            assert!(0x2::table::contains<address, Subscription>(&arg4.following_list, v1), 1090);
            let v6 = 0x2::table::borrow<address, Subscription>(&arg4.following_list, v1);
            assert!(0x2::clock::timestamp_ms(arg0) < v6.next_payment_timestamp && v6.is_active, 1088);
        };
        let v7 = v5.lockup_duration;
        let v8 = 0x2::clock::timestamp_ms(arg0);
        let v9 = v0 + 259200000 + (v7 as u64) * 2592000000;
        let v10 = v5.min_price;
        let v11 = &mut arg5.listed_versions;
        let (_, _, _, _, _, _, _, _, _) = destroy_listing_record(v11, v4, v5);
        let v21 = 0x2::coin::into_balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(arg7);
        assert!(0x2::balance::value<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&v21) >= v10, 1058);
        let v22 = &mut v21;
        let (v23, v24) = execute_sale(arg1, arg3, arg2, arg6, false, v2, v10, v22);
        let v25 = v24;
        let v26 = v23;
        0x2::balance::join<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut arg5.available_hsui, 0x1::option::extract<0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&mut v25.balance));
        let v27 = BorrowRecord{
            owner           : arg5.owner,
            borrow_price    : v10,
            start_sec       : v8,
            lockup_duration : (v7 as u8),
            expiration_sec  : v9,
        };
        v26.is_borrowed = true;
        deposit_hive_card(arg4, v26);
        0x1::vector::push_back<u64>(&mut arg4.borrowed_versions, arg6);
        0x2::table::add<u64, BorrowRecord>(&mut arg4.borrow_records, arg6, v27);
        let v28 = LendRecord{
            borrower        : v2,
            version         : arg6,
            lend_price      : v10,
            start_sec       : v8,
            lockup_duration : (v7 as u8),
            expiration_sec  : v9,
        };
        0x2::table::add<u64, LendRecord>(&mut arg5.lend_records, arg6, v28);
        0x1::vector::push_back<u64>(&mut arg5.lend_versions, arg6);
        let (_, v30, _, _, v33, _, _, _, _) = destroy_executed_listing<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(v25);
        0x1::option::destroy_none<HiveCard>(v30);
        0x1::option::destroy_none<0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(v33);
        let v38 = HiveCardBorrowed{
            version          : arg6,
            borrower         : v2,
            lender           : arg5.owner,
            borrow_price     : v10,
            lockup_duration  : v7,
            borrow_start_sec : v8,
            borrow_exp_sec   : v9,
        };
        0x2::event::emit<HiveCardBorrowed>(v38);
        destroy_or_transfer_balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(v21, v2, arg8);
    }

    public entry fun borrow_hive_card_with_sui(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x27e0df03aead8beed62eaf8e0bd299a4d6693886b5d88a1edf7d0e4453239e04::hsui_vault::HSuiVault, arg3: &mut HiveProfileConfig, arg4: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg5: &mut MarketPlace<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg6: &mut HiveProfile, arg7: &mut HiveProfile, arg8: u64, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(0x27e0df03aead8beed62eaf8e0bd299a4d6693886b5d88a1edf7d0e4453239e04::hsui_vault::stake_sui_request(arg1, arg2, 0x2::coin::into_balance<0x2::sui::SUI>(arg9), 0x1::option::none<address>(), arg10), arg10);
        borrow_hive_card_with_hsui(arg0, arg3, arg4, arg5, arg6, arg7, arg8, v0, arg10);
    }

    public fun borrow_mut_from_profile<T0: copy + drop + store, T1: store + key>(arg0: bool, arg1: &mut HiveProfile, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) : &mut T1 {
        0x2::dynamic_object_field::borrow_mut<T0, T1>(&mut arg1.id, arg2)
    }

    fun calc_next_payment_timestamp(arg0: u64, arg1: u64) : u64 {
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
        0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::math::mul_div(arg0, arg1, 1000)
    }

    public entry fun calculate_kraft_price(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg0 + arg1 * ((pow_approx((arg2 as u128), 2, 3) / 1000000000000) as u64)
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

    public entry fun cancel_bid(arg0: &mut MarketPlace<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg1: &mut HiveProfile, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 1079);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        assert!(arg1.is_owned_obj || arg1.owner == v0, 1057);
        let (_, v3) = 0x1::vector::index_of<u64>(&arg1.bidded_versions, &arg2);
        let v4 = &mut arg1.bidded_versions;
        let (_, _, _, _) = destroy_bid_record(0x2::table::remove<u64, BidRecord>(&mut arg1.bid_records, arg2), v4, v3);
        let v9 = 0x2::table::remove<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(&mut arg0.available_bids, arg2);
        let v10 = &mut v9;
        0x2::table::add<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(&mut arg0.available_bids, arg2, v9);
        let v11 = BidCanceled{
            version        : arg2,
            bidder_profile : v1,
        };
        0x2::event::emit<BidCanceled>(v11);
        destroy_or_transfer_balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(destroy_bid_among_bids(v10, v1, false, arg2), v0, arg3);
    }

    public entry fun cancel_direct_bid(arg0: &mut HiveProfile, arg1: &mut HiveProfile, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 1079);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        assert!(arg1.is_owned_obj || arg1.owner == v0, 1057);
        let (_, v3) = 0x1::vector::index_of<u64>(&arg1.bidded_versions, &arg2);
        let v4 = &mut arg1.bidded_versions;
        let (_, _, _, _) = destroy_bid_record(0x2::table::remove<u64, BidRecord>(&mut arg1.bid_records, arg2), v4, v3);
        let v9 = 0x2::table::remove<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(&mut arg0.incoming_bids, arg2);
        let v10 = &mut v9;
        0x2::table::add<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(&mut arg0.incoming_bids, arg2, v9);
        let v11 = BidCanceled{
            version        : arg2,
            bidder_profile : v1,
        };
        0x2::event::emit<BidCanceled>(v11);
        destroy_or_transfer_balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(destroy_bid_among_bids(v10, v1, false, arg2), v0, arg3);
    }

    public entry fun cancel_listing(arg0: &mut MarketPlace<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg1: &mut HiveProfile, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 1079);
        assert!(arg1.is_owned_obj || arg1.owner == 0x2::tx_context::sender(arg3), 1057);
        let (v0, v1) = 0x1::vector::index_of<u64>(&arg1.listed_versions, &arg2);
        assert!(v0, 1037);
        let v2 = 0x2::table::remove<u64, Listing>(&mut arg0.active_listings, arg2);
        let v3 = ListingCanceled{
            listed_by_profile : v2.listed_by_profile,
            version           : arg2,
        };
        0x2::event::emit<ListingCanceled>(v3);
        let (v4, _, _, _, _, _, _, _, _, _) = destroy_listing(v2);
        let v14 = &mut arg1.listed_versions;
        let (_, _, _, _, _, _, _, _, _) = destroy_listing_record(v14, v1, 0x2::table::remove<u64, ListingRecord>(&mut arg1.listing_records, arg2));
        deposit_hive_card(arg1, v4);
        mark_marketplace_bids_as_invalid(arg0, arg2);
    }

    fun claim_accrued_rewards_for_card(arg0: &0x2::clock::Clock, arg1: &mut HiveProfileConfig, arg2: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg3: &mut HiveDisperser, arg4: &mut HiveCard) : (0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::HiveGems, 0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, bool) {
        let v0 = false;
        let v1 = v0;
        if (arg4.is_staked) {
            let v5 = compute_harvest_by_gems(arg2.global_dispersal_index, arg4.claim_index, arg4.power);
            let v6 = compute_harvest_by_gems(arg3.global_dispersal_index, arg4.gems_claim_index, arg4.power);
            let v7 = HarvestRewardsForCard{
                version        : arg4.version,
                hsui_harvested : v5,
                gems_harvested : v6,
            };
            0x2::event::emit<HarvestRewardsForCard>(v7);
            arg4.claim_index = arg2.global_dispersal_index;
            arg4.gems_claim_index = arg3.global_dispersal_index;
            arg4.total_hsui_claimed = arg4.total_hsui_claimed + v5;
            arg4.total_gems_claimed = arg4.total_gems_claimed + v6;
            if (arg4.unlock_timestamp < 0x2::clock::timestamp_ms(arg0)) {
                unstake_hive_card(arg1, arg4);
                v1 = true;
            };
            (0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::split(&mut arg3.gems_for_cards, v6), 0x2::balance::split<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut arg2.hsui_for_cards, v5), v1)
        } else {
            (0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::zero(), 0x2::balance::zero<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(), v0)
        }
    }

    fun compute_harvest_by_gems(arg0: u256, arg1: u256, arg2: u64) : u64 {
        ((((arg0 - arg1) as u256) * (arg2 as u256) / (1000000000000000000 as u256)) as u64)
    }

    fun create_bid(arg0: address, arg1: u64, arg2: 0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg3: u64, arg4: bool) : Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI> {
        Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>{
            bidder_profile  : arg0,
            balance         : arg2,
            offer_price     : arg1,
            expiration_sec  : arg3,
            is_listing_live : arg4,
            is_valid        : true,
        }
    }

    fun create_bid_record(arg0: u64, arg1: u64, arg2: u64, arg3: bool) : BidRecord {
        BidRecord{
            version        : arg0,
            offer_price    : arg1,
            expiration_sec : arg2,
            is_card_listed : arg3,
        }
    }

    public fun deposit_gems_for_distribution_via_cards(arg0: &0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::HiveGemKraftCap, arg1: &mut HiveProfileConfig, arg2: 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::HiveGems) {
        0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::join(&mut arg1.hive_gems_for_cards, arg2);
    }

    public fun deposit_gems_for_hive(arg0: &mut HiveDisperser, arg1: 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::HiveGems) {
        let v0 = HiveAddedForHarvest{yield_added: 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::value(&arg1)};
        0x2::event::emit<HiveAddedForHarvest>(v0);
        0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::join(&mut arg0.incoming_gems_for_cards, arg1);
    }

    public fun deposit_gems_in_profile(arg0: &mut HiveProfile, arg1: 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::HiveGems) {
        let v0 = GemAddedToProfile{
            profile_id     : 0x2::object::uid_to_address(&arg0.id),
            deposited_gems : 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::value(&arg1),
        };
        0x2::event::emit<GemAddedToProfile>(v0);
        0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::join(&mut arg0.available_gems, arg1);
    }

    fun deposit_hive_card(arg0: &mut HiveProfile, arg1: HiveCard) {
        assert!(0x1::vector::length<u64>(&arg0.available_versions) + 0x1::vector::length<u64>(&arg0.listed_versions) + 0x1::vector::length<u64>(&arg0.lend_versions) < 25, 1020);
        let v0 = arg1.version;
        0x2::table::add<u64, HiveCard>(&mut arg0.hive_cards, v0, arg1);
        0x1::vector::push_back<u64>(&mut arg0.available_versions, v0);
    }

    public fun deposit_hsui_for_hive<T0>(arg0: &mut HSuiDisperser<T0>, arg1: 0x2::balance::Balance<T0>) {
        let v0 = HSuiAddedForHarvest{yield_added: 0x2::balance::value<T0>(&arg1)};
        0x2::event::emit<HSuiAddedForHarvest>(v0);
        0x2::balance::join<T0>(&mut arg0.incoming_hsui_for_cards, arg1);
    }

    public fun deposit_hsui_for_profile(arg0: &mut HiveProfile, arg1: 0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 1079);
        0x2::balance::join<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut arg0.available_hsui, arg1);
        let v0 = DepositHSuiForProfile{
            profile_addr   : 0x2::object::uid_to_address(&arg0.id),
            hsui_deposited : 0x2::balance::value<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&arg1),
            depositor_addr : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<DepositHSuiForProfile>(v0);
    }

    public fun deposit_sui_for_profile(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x27e0df03aead8beed62eaf8e0bd299a4d6693886b5d88a1edf7d0e4453239e04::hsui_vault::HSuiVault, arg2: &mut HiveProfile, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.module_version == 0, 1079);
        let v0 = 0x27e0df03aead8beed62eaf8e0bd299a4d6693886b5d88a1edf7d0e4453239e04::hsui_vault::stake_sui_request(arg0, arg1, arg3, 0x1::option::none<address>(), arg4);
        deposit_hsui_for_profile(arg2, v0, arg4);
    }

    fun destroy_bid<T0>(arg0: Bid<T0>, arg1: u64) : (0x2::balance::Balance<T0>, address, u64, u64, bool, bool) {
        let Bid {
            bidder_profile  : v0,
            balance         : v1,
            offer_price     : v2,
            expiration_sec  : v3,
            is_listing_live : v4,
            is_valid        : v5,
        } = arg0;
        let v6 = BidDestroyed{
            card_version   : arg1,
            bidder_profile : v0,
        };
        0x2::event::emit<BidDestroyed>(v6);
        (v1, v0, v2, v3, v4, v5)
    }

    fun destroy_bid_among_bids(arg0: &mut vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>, arg1: address, arg2: bool, arg3: u64) : 0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI> {
        let v0 = 0x2::balance::zero<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(arg0)) {
            if (0x1::vector::borrow<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(arg0, v1).bidder_profile == arg1) {
                let v2 = 0x1::vector::remove<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(arg0, v1);
                if (arg2) {
                    assert!(!v2.is_valid, 1075);
                };
                let (v3, _, _, _, _, _) = destroy_bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(v2, arg3);
                0x2::balance::join<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut v0, v3);
                return v0
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun destroy_bid_record(arg0: BidRecord, arg1: &mut vector<u64>, arg2: u64) : (u64, u64, u64, bool) {
        0x1::vector::remove<u64>(arg1, arg2);
        let BidRecord {
            version        : v0,
            offer_price    : v1,
            expiration_sec : v2,
            is_card_listed : v3,
        } = arg0;
        (v0, v1, v2, v3)
    }

    fun destroy_borrow_record(arg0: BorrowRecord, arg1: &mut vector<u64>, arg2: u64) : (address, u8, u64, u64, u64) {
        0x1::vector::remove<u64>(arg1, arg2);
        let BorrowRecord {
            owner           : v0,
            borrow_price    : v1,
            start_sec       : v2,
            lockup_duration : v3,
            expiration_sec  : v4,
        } = arg0;
        (v0, v3, v1, v2, v4)
    }

    fun destroy_executed_listing<T0>(arg0: ExecutedListing<T0>) : (address, 0x1::option::Option<HiveCard>, u64, bool, 0x1::option::Option<0x2::balance::Balance<T0>>, address, u64, u64, u64) {
        let ExecutedListing {
            listed_by_profile       : v0,
            hive_card               : v1,
            version                 : v2,
            was_sale_listing        : v3,
            balance                 : v4,
            bidder_profile          : v5,
            executed_price          : v6,
            borrow_period_start_sec : v7,
            borrow_period_end_sec   : v8,
        } = arg0;
        let v9 = ExecutedListingDestroyed{
            version           : v2,
            executed_price    : v6,
            listed_by_profile : v0,
        };
        0x2::event::emit<ExecutedListingDestroyed>(v9);
        (v0, v1, v2, v3, v4, v5, v6, v7, v8)
    }

    fun destroy_lend_record(arg0: LendRecord, arg1: &mut vector<u64>, arg2: u64) : (address, u64, u64, u64, u8, u64) {
        0x1::vector::remove<u64>(arg1, arg2);
        let LendRecord {
            borrower        : v0,
            version         : v1,
            lend_price      : v2,
            start_sec       : v3,
            lockup_duration : v4,
            expiration_sec  : v5,
        } = arg0;
        (v0, v1, v2, v3, v4, v5)
    }

    fun destroy_listing(arg0: Listing) : (HiveCard, address, bool, u64, bool, bool, bool, u8, u64, u64) {
        let Listing {
            listed_by_profile : v0,
            hive_card         : v1,
            followers_only    : v2,
            min_price         : v3,
            is_sale_listing   : v4,
            instant_sale      : v5,
            highest_bid_sale  : v6,
            lockup_duration   : v7,
            start_sec         : v8,
            expiration_sec    : v9,
        } = arg0;
        let v10 = v1;
        let v11 = ListingDestroyed{
            version           : v10.version,
            listed_by_profile : v0,
        };
        0x2::event::emit<ListingDestroyed>(v11);
        (v10, v0, v2, v3, v4, v5, v6, v7, v8, v9)
    }

    fun destroy_listing_record(arg0: &mut vector<u64>, arg1: u64, arg2: ListingRecord) : (u64, bool, u64, bool, bool, bool, u8, u64, u64) {
        0x1::vector::remove<u64>(arg0, arg1);
        let ListingRecord {
            version          : v0,
            followers_only   : v1,
            min_price        : v2,
            is_sale_listing  : v3,
            instant_sale     : v4,
            highest_bid_sale : v5,
            lockup_duration  : v6,
            start_sec        : v7,
            expiration_sec   : v8,
        } = arg2;
        (v0, v1, v2, v3, v4, v5, v6, v7, v8)
    }

    fun destroy_or_transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    public fun does_user_own_profile(arg0: &HiveProfileMappingStore, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.hive_profile_ids, arg1)
    }

    public fun execute_public_kraft(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x27e0df03aead8beed62eaf8e0bd299a4d6693886b5d88a1edf7d0e4453239e04::hsui_vault::HSuiVault, arg3: &mut HiveProfileConfig, arg4: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg5: &mut HiveDisperser, arg6: &mut CreatorHiveKiosk, arg7: &mut PublicKraftConfig, arg8: &mut HiveProfile, arg9: 0x2::balance::Balance<0x2::sui::SUI>, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg3.module_version == 0 && arg4.module_version == 0 && arg5.module_version == 0 && arg6.module_version == 0 && arg7.module_version == 0 && arg8.module_version == 0, 1079);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 1;
        assert!(arg6.aesthetic == arg7.aesthetic && arg6.character == arg7.character, 1068);
        assert!(arg8.is_owned_obj || arg8.owner == 0x2::tx_context::sender(arg10), 1057);
        let v2 = 0x2::clock::timestamp_ms(arg0);
        let v3 = calculate_kraft_price(arg6.base_price, arg6.curve_a, arg6.krafted_cards);
        assert!(v2 >= arg7.start_time, 1008);
        assert!(arg7.available_cards_to_kraft >= arg7.krafts_processed + v1, 1018);
        assert!(0x1::vector::length<u64>(&arg8.available_versions) + v1 <= 25, 1020);
        if (!0x2::table::contains<address, u64>(&arg7.address_list, v0)) {
            0x2::table::add<address, u64>(&mut arg7.address_list, v0, 0);
        };
        let v4 = 0x2::table::borrow_mut<address, u64>(&mut arg7.address_list, v0);
        assert!(arg7.per_user_limit >= *v4 + v1, 1018);
        *v4 = *v4 + v1;
        arg7.krafts_processed = arg7.krafts_processed + v1;
        arg6.krafted_cards = arg6.krafted_cards + v1;
        let v5 = 0x2::tx_context::sender(arg10);
        let (v6, v7, _, _) = internal_kraft_hiveverse_asset(arg8, arg1, arg2, v5, v2, arg3, arg4, arg5, arg6, arg9, v3, arg10);
        deposit_hive_card(arg8, v7);
        v6
    }

    fun execute_sale(arg0: &mut HiveProfileConfig, arg1: &mut MarketPlace<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg2: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg3: u64, arg4: bool, arg5: address, arg6: u64, arg7: &mut 0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>) : (HiveCard, ExecutedListing<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>) {
        let (v0, v1, _, _, v4, _, _, _, _, _) = destroy_listing(0x2::table::remove<u64, Listing>(&mut arg1.active_listings, arg3));
        let v10 = v0;
        assert!(v1 != arg5, 1062);
        if (v4 && 0x2::table::contains<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(&mut arg1.available_bids, arg3)) {
            let v11 = 0x2::table::remove<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(&mut arg1.available_bids, arg3);
            let v12 = 0;
            while (v12 < 0x1::vector::length<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&v11)) {
                let v13 = 0x1::vector::borrow_mut<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&mut v11, v12);
                v13.is_listing_live = false;
                v13.is_valid = false;
                let v14 = BidMarkedInvalid{
                    version        : arg3,
                    bidder_profile : v13.bidder_profile,
                };
                0x2::event::emit<BidMarkedInvalid>(v14);
                if (arg4 && v13.bidder_profile == arg5) {
                    let (v15, _, v17, _, _, _) = destroy_bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(0x1::vector::remove<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&mut v11, v12), arg3);
                    if (arg6 == 0) {
                        arg6 = v17;
                    };
                    0x2::balance::join<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(arg7, v15);
                    break
                };
                v12 = v12 + 1;
            };
            0x2::table::add<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(&mut arg1.available_bids, arg3, v11);
        };
        let v21 = ExecutedListing<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>{
            listed_by_profile       : v1,
            hive_card               : 0x1::option::none<HiveCard>(),
            version                 : arg3,
            was_sale_listing        : v4,
            balance                 : 0x1::option::some<0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(process_royalty(0x2::balance::split<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(arg7, arg6), arg0, arg2, v10.creator_profile)),
            bidder_profile          : arg5,
            executed_price          : arg6,
            borrow_period_start_sec : 0,
            borrow_period_end_sec   : 0,
        };
        let v22 = SaleExecuted{
            version        : arg3,
            buyer_profile  : arg5,
            seller_profile : v1,
            price          : arg6,
        };
        0x2::event::emit<SaleExecuted>(v22);
        (v10, v21)
    }

    public fun execute_whitelisted_kraft(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x27e0df03aead8beed62eaf8e0bd299a4d6693886b5d88a1edf7d0e4453239e04::hsui_vault::HSuiVault, arg3: &mut HiveProfileConfig, arg4: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg5: &mut HiveDisperser, arg6: &mut CreatorHiveKiosk, arg7: &mut WhitelistKraftConfig, arg8: &mut HiveProfile, arg9: 0x2::balance::Balance<0x2::sui::SUI>, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg3.module_version == 0 && arg4.module_version == 0 && arg5.module_version == 0 && arg6.module_version == 0 && arg7.module_version == 0 && arg8.module_version == 0, 1079);
        let v0 = 0x2::tx_context::sender(arg10);
        assert!(arg6.aesthetic == arg7.aesthetic && arg6.character == arg7.character, 1068);
        assert!(arg8.is_owned_obj || arg8.owner == 0x2::tx_context::sender(arg10), 1057);
        let v1 = 0x2::clock::timestamp_ms(arg0);
        let v2 = calculate_kraft_price(arg7.base_price, arg7.curve_a, arg6.krafted_cards);
        let v3 = 1;
        assert!(v1 >= arg7.start_time && v1 < arg7.end_time, 1008);
        assert!(arg7.available_cards_to_kraft >= arg7.krafts_processed + v3, 1018);
        assert!(0x2::table::contains<address, u64>(&arg7.whitelisted_addresses, v0), 1010);
        assert!(0x1::vector::length<u64>(&arg8.available_versions) + 1 <= 25, 1020);
        let v4 = 0x2::table::borrow_mut<address, u64>(&mut arg7.whitelisted_addresses, v0);
        assert!(v3 <= *v4, 1014);
        *v4 = *v4 - v3;
        arg7.krafts_processed = arg7.krafts_processed + v3;
        arg6.krafted_cards = arg6.krafted_cards + v3;
        let v5 = 0x2::tx_context::sender(arg10);
        let (v6, v7, _, _) = internal_kraft_hiveverse_asset(arg8, arg1, arg2, v5, v1, arg3, arg4, arg5, arg6, arg9, v2, arg10);
        deposit_hive_card(arg8, v7);
        v6
    }

    public fun exists_for_profile<T0: copy + drop + store>(arg0: &mut HiveProfile, arg1: T0) : bool {
        0x2::dynamic_object_field::exists_<T0>(&arg0.id, arg1)
    }

    public fun exists_with_type_for_profile<T0: copy + drop + store, T1: store + key>(arg0: &HiveProfile, arg1: T0) : bool {
        0x2::dynamic_object_field::exists_with_type<T0, T1>(&arg0.id, arg1)
    }

    fun extract_collected_creator_royalty(arg0: &mut HiveProfileConfig, arg1: &mut HiveProfile) : 0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI> {
        let v0 = 0x2::object::uid_to_address(&arg1.id);
        if (!0x2::table::contains<address, 0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&arg0.creator_royalties, v0)) {
            0x2::balance::zero<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>()
        } else {
            let v2 = RoyaltyCollectedForCreator{
                creator_profile : v0,
                hsui_collected  : 0x2::balance::value<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(0x2::table::borrow<address, 0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&mut arg0.creator_royalties, v0)),
            };
            0x2::event::emit<RoyaltyCollectedForCreator>(v2);
            0x2::balance::withdraw_all<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(0x2::table::borrow_mut<address, 0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&mut arg0.creator_royalties, v0))
        }
    }

    public fun follow_profile(arg0: &0x2::clock::Clock, arg1: &HiveProfileConfig, arg2: &mut 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::config::GemsTreasury, arg3: &mut HiveProfile, arg4: &mut HiveProfile, arg5: &mut HiveDisperser, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.is_owned_obj || arg3.owner == 0x2::tx_context::sender(arg7), 1057);
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x2::object::uid_to_address(&arg4.id);
        let v2 = 0x2::object::uid_to_address(&arg3.id);
        assert!(v1 != v2, 1087);
        let v3 = *0x2::table::borrow<u8, u64>(&arg4.subscriptions, (arg6 as u8));
        let v4 = calc_next_payment_timestamp(v0, arg6);
        if (!0x2::table::contains<address, Subscription>(&arg3.following_list, v1)) {
            let v5 = Subscription{
                follower               : v2,
                following              : v1,
                is_active              : true,
                init_timestamp         : 0x2::clock::timestamp_ms(arg0),
                subscription_type      : arg6,
                subscription_cost      : v3,
                next_payment_timestamp : v4,
                total_paid             : v3,
                switch_to_plan         : 0x1::option::none<u64>(),
                switch_to_plan_price   : 0x1::option::none<u64>(),
            };
            0x2::table::add<address, Subscription>(&mut arg3.following_list, v1, v5);
            0x2::table::add<address, Subscription>(&mut arg4.followers_list, v2, v5);
        } else {
            let v6 = 0x2::table::borrow_mut<address, Subscription>(&mut arg3.following_list, v1);
            let v7 = 0x2::table::borrow_mut<address, Subscription>(&mut arg4.followers_list, v2);
            assert!(!v6.is_active, 1097);
            assert!(v0 > v6.next_payment_timestamp, 1096);
            v6.subscription_type = arg6;
            v6.subscription_cost = v3;
            v6.next_payment_timestamp = v4;
            v6.total_paid = v6.total_paid + v3;
            v6.is_active = true;
            v7.subscription_type = arg6;
            v7.subscription_cost = v3;
            v7.next_payment_timestamp = v4;
            v7.total_paid = v7.total_paid + v3;
            v7.is_active = true;
        };
        0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::join(&mut arg4.available_gems, internal_process_subscription_payment(arg1, arg5, arg2, v2, v1, 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::split(&mut arg3.available_gems, v3), arg6, v3));
        let v8 = SubscribedToProfile{
            follower_profile_addr  : v2,
            profile_followed_addr  : v1,
            follower_username      : 0x1::string::from_ascii(arg3.username),
            followed_username      : 0x1::string::from_ascii(arg4.username),
            subscription_type      : arg6,
            subscription_cost      : v3,
            next_payment_timestamp : v4,
        };
        0x2::event::emit<SubscribedToProfile>(v8);
    }

    public fun get_accrued_harvest_for_card(arg0: &0x2::clock::Clock, arg1: &HiveProfileConfig, arg2: &HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg3: &HiveDisperser, arg4: &HiveProfile, arg5: u64) : (u64, u64) {
        if (arg1.active_power == 0) {
            return (0, 0)
        };
        let v0 = 0x2::table::borrow<u64, HiveCard>(&arg4.hive_cards, arg5);
        let v1 = 0;
        let v2 = 0;
        if (v0.is_staked && v0.unlock_timestamp > 0x2::clock::timestamp_ms(arg0)) {
            v1 = compute_harvest_by_gems(arg2.global_dispersal_index + (0x2::balance::value<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&arg2.incoming_hsui_for_cards) as u256) * (1000000000000000000 as u256) / (arg1.active_power as u256), v0.claim_index, v0.power);
            v2 = compute_harvest_by_gems(arg3.global_dispersal_index + (0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::value(&arg3.incoming_gems_for_cards) as u256) * (1000000000000000000 as u256) / (arg1.active_power as u256), v0.gems_claim_index, v0.power);
        };
        (v1, v2)
    }

    public fun get_active_power(arg0: &HiveProfileConfig) : u128 {
        arg0.active_power
    }

    public fun get_available_gems_in_profile(arg0: &HiveProfile) : u64 {
        0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::value(&arg0.available_gems)
    }

    public fun get_available_harvest_for_profile(arg0: &HiveProfileConfig, arg1: &HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg2: &HiveDisperser, arg3: &HiveProfile) : (u64, u64) {
        if (arg0.active_power == 0) {
            return (0, 0)
        };
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg3.available_versions)) {
            let v3 = 0x2::table::borrow<u64, HiveCard>(&arg3.hive_cards, *0x1::vector::borrow<u64>(&arg3.available_versions, v2));
            v0 = v0 + compute_harvest_by_gems(arg1.global_dispersal_index + 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::math::mul_div_u256((0x2::balance::value<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&arg1.incoming_hsui_for_cards) as u256), (1000000000000000000 as u256), (arg0.active_power as u256)), v3.claim_index, v3.power);
            v1 = v1 + compute_harvest_by_gems(arg2.global_dispersal_index + 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::math::mul_div_u256((0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::value(&arg2.incoming_gems_for_cards) as u256), (1000000000000000000 as u256), (arg0.active_power as u256)), v3.gems_claim_index, v3.power);
            v2 = v2 + 1;
        };
        (v1, v0 + 0x2::balance::value<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&arg3.available_hsui))
    }

    public fun get_bid_for_card(arg0: &HiveProfile, arg1: u64, arg2: u64) : (address, u64, u64, u64, bool, bool) {
        let v0 = 0x1::vector::borrow<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(0x2::table::borrow<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(&arg0.incoming_bids, arg1), arg2);
        (v0.bidder_profile, 0x2::balance::value<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&v0.balance), v0.offer_price, v0.expiration_sec, v0.is_listing_live, v0.is_valid)
    }

    public fun get_bid_info(arg0: &MarketPlace<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg1: u64, arg2: u64) : (0x1::string::String, u64, u64, u64, bool, bool) {
        let v0 = 0x1::vector::borrow<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(0x2::table::borrow<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(&arg0.available_bids, arg1), arg2);
        (0x2::address::to_string(v0.bidder_profile), 0x2::balance::value<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&v0.balance), v0.offer_price, v0.expiration_sec, v0.is_listing_live, v0.is_valid)
    }

    public fun get_bid_record(arg0: &HiveProfile, arg1: u64) : (u64, u64, u64, bool) {
        let v0 = 0x2::table::borrow<u64, BidRecord>(&arg0.bid_records, arg1);
        (v0.version, v0.offer_price, v0.expiration_sec, v0.is_card_listed)
    }

    public fun get_borrow_record(arg0: &HiveProfile, arg1: u64) : (0x1::string::String, u8, u64, u64, u64) {
        let v0 = 0x2::table::borrow<u64, BorrowRecord>(&arg0.borrow_records, arg1);
        (0x2::address::to_string(v0.owner), v0.lockup_duration, v0.borrow_price, v0.start_sec, v0.expiration_sec)
    }

    public fun get_buidlers_royalty(arg0: &HiveProfileConfig) : u64 {
        0x2::balance::value<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&arg0.buidlers_royalty)
    }

    public fun get_creator_kiosk_info(arg0: &CreatorHiveKiosk) : (0x1::string::String, 0x1::string::String, 0x1::string::String, vector<0x1::string::String>, u64, u64, u64, u64, u64) {
        (arg0.aesthetic, arg0.character, 0x1::string::from_ascii(0x2::url::inner_url(&arg0.img_url)), arg0.traits_list, arg0.init_hive_gems, arg0.total_cards, arg0.krafted_cards, arg0.base_price, arg0.curve_a)
    }

    public fun get_executed_listing_info(arg0: &MarketPlace<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg1: u64) : (0x1::string::String, bool, bool, bool, u64, 0x1::string::String, u64, u64, u64) {
        let v0 = 0x2::table::borrow<u64, ExecutedListing<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&arg0.processed_listings, arg1);
        let v1 = 0x1::option::is_some<0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&v0.balance);
        let v2 = 0;
        if (v1) {
            v2 = 0x2::balance::value<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(0x1::option::borrow<0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&v0.balance));
        };
        (0x2::address::to_string(v0.listed_by_profile), 0x1::option::is_some<HiveCard>(&v0.hive_card), v1, v0.was_sale_listing, v2, 0x2::address::to_string(v0.bidder_profile), v0.executed_price, v0.borrow_period_start_sec, v0.borrow_period_end_sec)
    }

    public fun get_follower_subscription_info(arg0: &HiveProfile, arg1: address) : (address, address, u64, u64, u64, u64, u64, u64, u64) {
        let v0 = 0x2::table::borrow<address, Subscription>(&arg0.followers_list, arg1);
        let v1 = 0;
        if (0x1::option::is_some<u64>(&v0.switch_to_plan)) {
            v1 = *0x1::option::borrow<u64>(&v0.switch_to_plan);
        };
        let v2 = 0;
        if (0x1::option::is_some<u64>(&v0.switch_to_plan_price)) {
            v2 = *0x1::option::borrow<u64>(&v0.switch_to_plan_price);
        };
        (v0.follower, v0.following, v0.init_timestamp, v0.subscription_type, v0.subscription_cost, v0.next_payment_timestamp, v0.total_paid, v1, v2)
    }

    public fun get_followers_and_following_length(arg0: &HiveProfile) : (u64, u64) {
        (0x2::table::length<address, Subscription>(&arg0.followers_list), 0x2::table::length<address, Subscription>(&arg0.following_list))
    }

    public fun get_following_subscription_info(arg0: &HiveProfile, arg1: address) : (address, address, u64, u64, u64, u64, u64, u64, u64) {
        let v0 = 0x2::table::borrow<address, Subscription>(&arg0.following_list, arg1);
        let v1 = 0;
        if (0x1::option::is_some<u64>(&v0.switch_to_plan)) {
            v1 = *0x1::option::borrow<u64>(&v0.switch_to_plan);
        };
        let v2 = 0;
        if (0x1::option::is_some<u64>(&v0.switch_to_plan_price)) {
            v2 = *0x1::option::borrow<u64>(&v0.switch_to_plan_price);
        };
        (v0.follower, v0.following, v0.init_timestamp, v0.subscription_type, v0.subscription_cost, v0.next_payment_timestamp, v0.total_paid, v1, v2)
    }

    public fun get_harvest_by_cards(arg0: &0x2::clock::Clock, arg1: &HiveProfileConfig, arg2: &HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg3: &HiveDisperser, arg4: &HiveProfile) : (u64, vector<u64>, u64, vector<u64>) {
        if (arg1.active_power == 0) {
            return (0, 0x1::vector::empty<u64>(), 0, 0x1::vector::empty<u64>())
        };
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg4.available_versions)) {
            let v5 = 0x2::table::borrow<u64, HiveCard>(&arg4.hive_cards, *0x1::vector::borrow<u64>(&arg4.available_versions, v4));
            let v6 = 0;
            let v7 = 0;
            if (v5.is_staked && v5.unlock_timestamp > 0x2::clock::timestamp_ms(arg0)) {
                v6 = compute_harvest_by_gems(arg2.global_dispersal_index + (0x2::balance::value<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&arg2.incoming_hsui_for_cards) as u256) * (1000000000000000000 as u256) / (arg1.active_power as u256), v5.claim_index, v5.power);
                v7 = compute_harvest_by_gems(arg3.global_dispersal_index + (0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::value(&arg3.incoming_gems_for_cards) as u256) * (1000000000000000000 as u256) / (arg1.active_power as u256), v5.gems_claim_index, v5.power);
            };
            v0 = v0 + v6;
            v1 = v1 + v7;
            0x1::vector::push_back<u64>(&mut v2, v6);
            0x1::vector::push_back<u64>(&mut v3, v7);
            v4 = v4 + 1;
        };
        (v0, v2, v1, v3)
    }

    public fun get_hive_card_owner_address(arg0: &HiveProfileConfig, arg1: u64) : address {
        *0x2::table::borrow<u64, address>(&arg0.cards_to_profile_mapping, arg1)
    }

    public fun get_hive_card_owner_profile_id(arg0: &HiveProfileConfig, arg1: &HiveProfileMappingStore, arg2: u64) : address {
        0x2::object::id_to_address(0x2::table::borrow<address, 0x2::object::ID>(&arg1.hive_profile_ids, get_hive_card_owner_address(arg0, arg2)))
    }

    public fun get_hive_disperser_info(arg0: &HiveDisperser) : (u64, u64, u256) {
        (0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::value(&arg0.incoming_gems_for_cards), 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::value(&arg0.gems_for_cards), arg0.global_dispersal_index)
    }

    public fun get_hive_gems_available_for_cards(arg0: &HiveProfileConfig) : u64 {
        0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::value(&arg0.hive_gems_for_cards)
    }

    public fun get_hive_profile_config_info(arg0: &HiveProfileConfig) : (u64, u64, u64, u128, u64) {
        (arg0.active_cards, arg0.locked_cards, arg0.total_cards, arg0.active_power, 0x2::balance::value<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&arg0.buidlers_royalty))
    }

    public fun get_hive_profile_config_params_info(arg0: &HiveProfileConfig) : (u64, u64, u64) {
        (arg0.config_params.max_bids_per_card, arg0.config_params.min_bid_allowed, arg0.config_params.profile_kraft_fees)
    }

    public fun get_hivecard_info(arg0: &HiveProfile, arg1: u64) : (0x1::string::String, u64, u64, bool, u64, u8, u64, u256, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, u64, bool) {
        let v0 = 0x2::table::borrow<u64, HiveCard>(&arg0.hive_cards, arg1);
        (0x2::address::to_string(0x2::object::uid_to_address(&v0.id)), v0.version, v0.power, v0.is_staked, v0.unlock_timestamp, v0.lockup_duration, 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::value(&v0.available_gems), v0.claim_index, v0.name, 0x1::string::from_ascii(0x2::url::inner_url(&v0.img_url)), v0.aesthetic, v0.character, v0.total_hsui_claimed, v0.is_borrowed)
    }

    public fun get_hsui_disperser_info<T0>(arg0: &HSuiDisperser<T0>) : (u64, u64, u256) {
        (0x2::balance::value<T0>(&arg0.incoming_hsui_for_cards), 0x2::balance::value<T0>(&arg0.hsui_for_cards), arg0.global_dispersal_index)
    }

    public fun get_lend_record(arg0: &HiveProfile, arg1: u64) : (0x1::string::String, u64, u64, u64, u64) {
        let v0 = 0x2::table::borrow<u64, LendRecord>(&arg0.lend_records, arg1);
        (0x2::address::to_string(v0.borrower), v0.version, v0.lend_price, v0.start_sec, v0.expiration_sec)
    }

    public fun get_listing_from_marketplace(arg0: &MarketPlace<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg1: u64) : (0x1::string::String, u64, bool, bool, bool, u8, u64, u64) {
        let v0 = 0x2::table::borrow<u64, Listing>(&arg0.active_listings, arg1);
        (0x2::address::to_string(v0.listed_by_profile), v0.min_price, v0.is_sale_listing, v0.instant_sale, v0.highest_bid_sale, v0.lockup_duration, v0.start_sec, v0.expiration_sec)
    }

    public fun get_listing_record(arg0: &HiveProfile, arg1: u64) : (u64, bool, bool, bool, u8, u64, u64) {
        let v0 = 0x2::table::borrow<u64, ListingRecord>(&arg0.listing_records, arg1);
        (v0.min_price, v0.is_sale_listing, v0.instant_sale, v0.highest_bid_sale, v0.lockup_duration, v0.start_sec, v0.expiration_sec)
    }

    public fun get_prices_for_public_hive_card_krafts(arg0: &0x2::clock::Clock, arg1: address, arg2: &mut CreatorHiveKiosk, arg3: &PublicKraftConfig, arg4: u64) : (u64, u64, vector<u64>, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        assert!(arg2.aesthetic == arg3.aesthetic && arg2.character == arg3.character, 1068);
        let v1 = 0;
        let v2 = 0;
        let v3 = v2;
        let v4 = 0x1::vector::empty<u64>();
        if (v0 < arg3.start_time) {
            v1 = arg3.start_time - v0;
        };
        let v5 = if (0x2::table::contains<address, u64>(&arg3.address_list, arg1)) {
            arg3.per_user_limit - *0x2::table::borrow<address, u64>(&arg3.address_list, arg1)
        } else {
            arg3.per_user_limit
        };
        if (arg3.available_cards_to_kraft - arg3.krafts_processed < v5) {
            v5 = arg3.available_cards_to_kraft - arg3.krafts_processed;
        };
        if (arg4 > v5) {
            return (v1, v2, v4, v5)
        };
        let v6 = arg2.krafted_cards;
        let v7 = 0;
        while (v7 < arg4) {
            let v8 = calculate_kraft_price(arg2.base_price, arg2.curve_a, v6);
            v6 = v6 + 1;
            v3 = v3 + v8;
            0x1::vector::push_back<u64>(&mut v4, v8);
            v7 = v7 + 1;
        };
        (v1, v3, v4, v5)
    }

    public fun get_prices_for_wl_hive_card_krafts(arg0: &0x2::clock::Clock, arg1: address, arg2: &mut CreatorHiveKiosk, arg3: &WhitelistKraftConfig, arg4: u64) : (u64, u64, vector<u64>, u64, bool) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        assert!(arg2.aesthetic == arg3.aesthetic && arg2.character == arg3.character, 1068);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        let v4 = v3;
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x2::table::contains<address, u64>(&arg3.whitelisted_addresses, arg1);
        if (v0 < arg3.start_time) {
            v2 = arg3.start_time - v0;
        } else if (arg3.end_time < v0) {
            return (v1, 0, v5, 0, false)
        };
        if (v6) {
            let v7 = *0x2::table::borrow<address, u64>(&arg3.whitelisted_addresses, arg1);
            let v8 = v7;
            if (arg3.available_cards_to_kraft - arg3.krafts_processed < v7) {
                v8 = arg3.available_cards_to_kraft - arg3.krafts_processed;
            };
            if (arg4 > v8) {
                return (v2, v3, v5, v8, v6)
            };
            let v9 = 0;
            while (v9 < arg4) {
                let v10 = calculate_kraft_price(arg3.base_price, arg3.curve_a, arg2.krafted_cards);
                v4 = v4 + v10;
                0x1::vector::push_back<u64>(&mut v5, v10);
                v9 = v9 + 1;
            };
            return (v2, v4, v5, v8, v6)
        };
        (v2, v3, v5, 0, v6)
    }

    public fun get_profile_addr_for_username(arg0: &HiveProfileMappingStore, arg1: 0x1::string::String) : 0x1::string::String {
        0x2::address::to_string(0x2::object::id_to_address(0x2::table::borrow<0x1::ascii::String, 0x2::object::ID>(&arg0.hive_profile_names, 0x1::string::to_ascii(arg1))))
    }

    public fun get_profile_addr_for_wallet(arg0: &HiveProfileMappingStore, arg1: address) : 0x1::string::String {
        0x2::address::to_string(0x2::object::id_to_address(0x2::table::borrow<address, 0x2::object::ID>(&arg0.hive_profile_ids, arg1)))
    }

    public fun get_profile_id_for_username(arg0: &HiveProfileMappingStore, arg1: 0x1::string::String) : 0x2::object::ID {
        *0x2::table::borrow<0x1::ascii::String, 0x2::object::ID>(&arg0.hive_profile_names, 0x1::string::to_ascii(arg1))
    }

    public fun get_profile_id_for_wallet(arg0: &HiveProfileMappingStore, arg1: address) : 0x2::object::ID {
        *0x2::table::borrow<address, 0x2::object::ID>(&arg0.hive_profile_ids, arg1)
    }

    public fun get_profile_info(arg0: &HiveProfile) : (0x1::string::String, u64, vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, u64) {
        (0x2::address::to_string(arg0.owner), 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::value(&arg0.available_gems), arg0.available_versions, arg0.borrowed_versions, arg0.listed_versions, arg0.bidded_versions, arg0.lend_versions, 0x2::balance::value<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&arg0.available_hsui))
    }

    public fun get_profile_info_with_power(arg0: &0x2::clock::Clock, arg1: &HiveProfile) : (0x1::string::String, u64, u64, vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, u64) {
        let (v0, v1, v2, v3, v4, v5, v6, v7) = get_profile_info(arg1);
        (v0, get_voting_power_for_profile(arg0, arg1), v1, v2, v3, v4, v5, v6, v7)
    }

    public fun get_profile_meta_info(arg0: &HiveProfile) : (address, 0x1::string::String, bool, address) {
        (0x2::object::uid_to_address(&arg0.id), 0x1::string::from_ascii(arg0.username), arg0.is_owned_obj, arg0.owner)
    }

    public fun get_profile_owner(arg0: &HiveProfile) : address {
        arg0.owner
    }

    public fun get_profile_username(arg0: &HiveProfile) : 0x1::string::String {
        0x1::string::from_ascii(arg0.username)
    }

    public fun get_prompts_for_hive_card(arg0: &CreatorHiveKiosk, arg1: &HiveProfile, arg2: u64) : (vector<0x1::string::String>, vector<0x1::string::String>) {
        let v0 = 0x2::table::borrow<u64, HiveCard>(&arg1.hive_cards, arg2);
        let v1 = arg0.traits_list;
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(&v1)) {
            0x1::vector::push_back<0x1::string::String>(&mut v2, *0x2::table::borrow<0x1::string::String, 0x1::string::String>(&v0.prompts, *0x1::vector::borrow<0x1::string::String>(&v1, v3)));
            v3 = v3 + 1;
        };
        (v1, v2)
    }

    public fun get_royalty_info(arg0: &HiveProfileConfig) : (u64, u64, u64) {
        (arg0.royalty.numerator, arg0.royalty.denominator, arg0.royalty.cards_dispersal_percent)
    }

    public fun get_skin_record(arg0: &HiveProfileConfig, arg1: &MarketPlace<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg2: &HiveProfile, arg3: u64, arg4: 0x1::string::String) : (bool, address, bool, u64, u64, u64) {
        let v0 = if (0x2::table::contains<u64, Listing>(&arg1.active_listings, arg3)) {
            &0x2::table::borrow<u64, Listing>(&arg1.active_listings, arg3).hive_card
        } else {
            0x2::table::borrow<u64, HiveCard>(&arg2.hive_cards, arg3)
        };
        if (!0x2::table::contains<0x1::string::String, SkinRecord>(&v0.active_skins, arg4)) {
            return (false, get_hive_card_owner_address(arg0, arg3), false, 0, 0, 0)
        };
        let v1 = 0x2::table::borrow<0x1::string::String, SkinRecord>(&v0.active_skins, arg4);
        (true, v1.admin_address, v1.public_skin_kraft_enabled, v1.royalty_fee_percent, v1.total_gems_ported, v1.total_skins_krafted)
    }

    public fun get_total_bids_for_card(arg0: &HiveProfile, arg1: u64) : u64 {
        if (!0x2::table::contains<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(&arg0.incoming_bids, arg1)) {
            return 0
        };
        0x1::vector::length<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(0x2::table::borrow<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(&arg0.incoming_bids, arg1))
    }

    public fun get_total_bids_for_listing(arg0: &MarketPlace<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg1: u64) : u64 {
        0x1::vector::length<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(0x2::table::borrow<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(&arg0.available_bids, arg1))
    }

    public fun get_voting_power_for_profile(arg0: &0x2::clock::Clock, arg1: &HiveProfile) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1.available_versions)) {
            let v2 = 0x2::table::borrow<u64, HiveCard>(&arg1.hive_cards, *0x1::vector::borrow<u64>(&arg1.available_versions, v1));
            if (v2.is_staked && v2.unlock_timestamp > 0x2::clock::timestamp_ms(arg0)) {
                v0 = v0 + v2.power;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun handle_expired_listing(arg0: &0x2::clock::Clock, arg1: &mut MarketPlace<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg2: &mut HiveProfile, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 1079);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg3)) {
            let v1 = *0x1::vector::borrow<u64>(&arg3, v0);
            let (v2, v3) = 0x1::vector::index_of<u64>(&arg2.listed_versions, &v1);
            assert!(v2, 1037);
            let v4 = 0x2::table::remove<u64, Listing>(&mut arg1.active_listings, v1);
            assert!(v4.expiration_sec < 0x2::clock::timestamp_ms(arg0), 1043);
            if (v4.is_sale_listing) {
                assert!(!v4.highest_bid_sale, 1076);
            };
            let v5 = ListingExpired{
                listed_by_profile : v4.listed_by_profile,
                version           : v1,
            };
            0x2::event::emit<ListingExpired>(v5);
            let (v6, _, _, _, _, _, _, _, _, _) = destroy_listing(v4);
            let v16 = &mut arg2.listed_versions;
            let (_, _, _, _, _, _, _, _, _) = destroy_listing_record(v16, v3, 0x2::table::remove<u64, ListingRecord>(&mut arg2.listing_records, v1));
            deposit_hive_card(arg2, v6);
            mark_marketplace_bids_as_invalid(arg1, v1);
            v0 = v0 + 1;
        };
    }

    public entry fun handle_expired_marketplace_bids_for_profile(arg0: &0x2::clock::Clock, arg1: &mut MarketPlace<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg2: &mut HiveProfile, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 1079);
        let v0 = 0x2::object::uid_to_address(&arg2.id);
        let v1 = 0x1::vector::length<u64>(&arg2.bidded_versions);
        while (v1 > 0) {
            v1 = v1 - 1;
            let v2 = 0x1::vector::borrow<u64>(&arg2.bidded_versions, v1);
            let v3 = 0x2::table::borrow<u64, BidRecord>(&mut arg2.bid_records, *v2);
            if (v3.is_card_listed && v3.expiration_sec < 0x2::clock::timestamp_ms(arg0)) {
                let v4 = 0x2::table::remove<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(&mut arg1.available_bids, *v2);
                let v5 = &mut v4;
                0x2::balance::join<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut arg2.available_hsui, destroy_bid_among_bids(v5, v0, false, *v2));
                0x2::table::add<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(&mut arg1.available_bids, *v2, v4);
                let v6 = BidExpired{
                    version        : *v2,
                    bidder_profile : v0,
                };
                0x2::event::emit<BidExpired>(v6);
                let v7 = &mut arg2.bidded_versions;
                let (_, _, _, _) = destroy_bid_record(0x2::table::remove<u64, BidRecord>(&mut arg2.bid_records, *v2), v7, v1);
                continue
            };
        };
    }

    public entry fun handle_invalid_direct_bid(arg0: &0x2::clock::Clock, arg1: &mut HiveProfile, arg2: &mut HiveProfile, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 1079);
        let v0 = 0x2::object::uid_to_address(&arg2.id);
        let (_, v2) = 0x1::vector::index_of<u64>(&arg2.bidded_versions, &arg3);
        let v3 = 0x2::table::remove<u64, BidRecord>(&mut arg2.bid_records, arg3);
        let v4 = 0x2::table::remove<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(&mut arg1.incoming_bids, arg3);
        let v5 = &mut v4;
        let v6 = &mut arg2.bidded_versions;
        let (_, _, _, _) = destroy_bid_record(v3, v6, v2);
        0x2::table::add<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(&mut arg1.incoming_bids, arg3, v4);
        0x2::balance::join<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut arg2.available_hsui, destroy_bid_among_bids(v5, v0, v3.expiration_sec >= 0x2::clock::timestamp_ms(arg0), arg3));
        let v11 = BidExpired{
            version        : arg3,
            bidder_profile : v0,
        };
        0x2::event::emit<BidExpired>(v11);
    }

    public fun handle_processed_listing(arg0: &mut HiveProfileConfig, arg1: &mut MarketPlace<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg2: &mut HiveProfile, arg3: &mut HiveProfile, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 1079);
        let (v0, v1) = 0x1::vector::index_of<u64>(&arg2.listed_versions, &arg4);
        assert!(v0, 1050);
        assert!(0x2::table::contains<u64, ExecutedListing<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&arg1.processed_listings, arg4), 1059);
        let (v2, v3, _, _, v6, v7, _, _, _) = destroy_executed_listing<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(0x2::table::remove<u64, ExecutedListing<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&mut arg1.processed_listings, arg4));
        let v11 = v6;
        let v12 = v3;
        assert!(v2 == 0x2::object::uid_to_address(&arg2.id), 1050);
        if (0x1::option::is_some<0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&v11)) {
            0x2::balance::join<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut arg2.available_hsui, 0x1::option::destroy_some<0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(v11));
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(v11);
        };
        if (v7 != v2) {
            assert!(v7 == 0x2::object::uid_to_address(&arg3.id), 1061);
        };
        if (0x1::vector::contains<u64>(&arg3.bidded_versions, &arg4)) {
            let (_, v14) = 0x1::vector::index_of<u64>(&arg3.bidded_versions, &arg4);
            assert!(v0, 1061);
            let v15 = &mut arg3.bidded_versions;
            let (_, _, _, _) = destroy_bid_record(0x2::table::remove<u64, BidRecord>(&mut arg3.bid_records, arg4), v15, v14);
        };
        if (0x1::option::is_some<HiveCard>(&v12)) {
            update_card_ownership(arg0, arg4, 0x2::object::uid_to_address(&arg3.id));
            deposit_hive_card(arg3, 0x1::option::extract<HiveCard>(&mut v12));
        };
        let v20 = &mut arg2.listed_versions;
        let (_, _, _, _, _, _, _, _, _) = destroy_listing_record(v20, v1, 0x2::table::remove<u64, ListingRecord>(&mut arg2.listing_records, arg4));
        0x1::option::destroy_none<HiveCard>(v12);
    }

    public fun harvest_hive_rewards(arg0: &0x2::clock::Clock, arg1: &mut HiveProfileConfig, arg2: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg3: &mut HiveDisperser, arg4: &mut HiveProfile, arg5: &mut 0x2::tx_context::TxContext) : (0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::HiveGems, 0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0 && arg3.module_version == 0 && arg4.module_version == 0, 1079);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg4.is_owned_obj || arg4.owner == v0, 1057);
        increment_global_index(arg1, arg2);
        increment_gems_global_index(arg1, arg3);
        let v1 = 0x2::balance::zero<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>();
        let v2 = 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::zero();
        let v3 = extract_collected_creator_royalty(arg1, arg4);
        0x2::balance::join<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut v1, v3);
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg4.available_versions)) {
            let v5 = 0x1::vector::borrow<u64>(&arg4.available_versions, v4);
            let v6 = 0x2::table::borrow_mut<u64, HiveCard>(&mut arg4.hive_cards, *v5);
            let (v7, v8, v9) = claim_accrued_rewards_for_card(arg0, arg1, arg2, arg3, v6);
            0x2::balance::join<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut v1, v8);
            0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::join(&mut v2, v7);
            if (v9) {
                let v10 = HiveCardUnstaked{
                    profile_addr : 0x2::object::uid_to_address(&arg4.id),
                    version      : *v5,
                };
                0x2::event::emit<HiveCardUnstaked>(v10);
            };
            v4 = v4 + 1;
        };
        0x2::balance::join<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut v1, 0x2::balance::withdraw_all<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut arg4.available_hsui));
        let v11 = HiveRewardsHarvested{
            harvester      : v0,
            hsui_harvested : 0x2::balance::value<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&v1),
            gems_harvested : 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::value(&v2),
        };
        0x2::event::emit<HiveRewardsHarvested>(v11);
        (v2, v1)
    }

    public entry fun harvest_hive_rewards_and_transfer(arg0: &0x2::clock::Clock, arg1: &mut HiveProfileConfig, arg2: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg3: &mut HiveDisperser, arg4: &mut HiveProfile, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = harvest_hive_rewards(arg0, arg1, arg2, arg3, arg4, arg5);
        0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::join(&mut arg4.available_gems, v0);
        let v2 = 0x2::tx_context::sender(arg5);
        destroy_or_transfer_balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(v1, v2, arg5);
    }

    public entry fun harvest_royalty_yield_for_builders(arg0: &BuidlersRoyaltyCollectionAbility, arg1: &mut HiveProfileConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 1079);
        let v0 = 0x2::balance::value<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&arg1.buidlers_royalty);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(0x2::coin::from_balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(0x2::balance::split<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut arg1.buidlers_royalty, v0), arg3), arg2);
        let v1 = KraftYieldHarvested{
            sui_yield : v0,
            receiver  : arg2,
        };
        0x2::event::emit<KraftYieldHarvested>(v1);
    }

    public fun id_for_dof_of_profile<T0: copy + drop + store>(arg0: &HiveProfile, arg1: T0) : 0x1::option::Option<0x2::object::ID> {
        0x2::dynamic_object_field::id<T0>(&arg0.id, arg1)
    }

    public entry fun increment_config(arg0: &mut HiveProfileConfig) {
        assert!(arg0.module_version < 0, 1080);
        arg0.module_version = 0;
    }

    fun increment_gems_global_index(arg0: &HiveProfileConfig, arg1: &mut HiveDisperser) {
        let v0 = 0x1::string::utf8(b"----- increment_gems_global_index");
        0x1::debug::print<0x1::string::String>(&v0);
        let v1 = 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::value(&arg1.incoming_gems_for_cards);
        if (arg0.active_power == 0 || v1 == 0) {
            return
        };
        arg1.global_dispersal_index = arg1.global_dispersal_index + 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::math::mul_div_u256((v1 as u256), (1000000000000000000 as u256), (arg0.active_power as u256));
        0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::join(&mut arg1.gems_for_cards, 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::withdraw_all(&mut arg1.incoming_gems_for_cards));
    }

    fun increment_global_index(arg0: &HiveProfileConfig, arg1: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>) {
        let v0 = 0x1::string::utf8(b"----- increment_global_index");
        0x1::debug::print<0x1::string::String>(&v0);
        let v1 = 0x2::balance::value<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&arg1.incoming_hsui_for_cards);
        if (arg0.active_power == 0 || v1 == 0) {
            return
        };
        arg1.global_dispersal_index = arg1.global_dispersal_index + 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::math::mul_div_u256((v1 as u256), (1000000000000000000 as u256), (arg0.active_power as u256));
        0x2::balance::join<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut arg1.hsui_for_cards, 0x2::balance::withdraw_all<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut arg1.incoming_hsui_for_cards));
    }

    public entry fun increment_hive_dispenser(arg0: &mut HiveDisperser) {
        assert!(arg0.module_version < 0, 1080);
        arg0.module_version = 0;
    }

    public entry fun increment_hive_kiosk(arg0: &mut CreatorHiveKiosk) {
        assert!(arg0.module_version < 0, 1080);
        arg0.module_version = 0;
    }

    public entry fun increment_hsui_dispenser(arg0: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>) {
        assert!(arg0.module_version < 0, 1080);
        arg0.module_version = 0;
    }

    public entry fun increment_marketplace(arg0: &mut MarketPlace<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>) {
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

    public entry fun increment_public_kraft_config(arg0: &mut PublicKraftConfig) {
        assert!(arg0.module_version < 0, 1080);
        arg0.module_version = 0;
    }

    public entry fun increment_whitelisted_kraft_config(arg0: &mut WhitelistKraftConfig) {
        assert!(arg0.module_version < 0, 1080);
        arg0.module_version = 0;
    }

    public fun infuse_gems_into_card(arg0: &0x2::clock::Clock, arg1: &0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::config::HiveDaoCapability, arg2: &mut HiveProfileConfig, arg3: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg4: &mut HiveDisperser, arg5: &mut HiveProfile, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert!(arg2.module_version == 0 && arg3.module_version == 0 && arg4.module_version == 0, 1079);
        let v0 = 0;
        let v1 = 0;
        assert!(arg5.is_owned_obj || arg5.owner == 0x2::tx_context::sender(arg8), 1057);
        let v2 = 0x2::table::borrow_mut<u64, HiveCard>(&mut arg5.hive_cards, arg7);
        let v3 = v2.power;
        increment_global_index(arg2, arg3);
        increment_gems_global_index(arg2, arg4);
        let (v4, v5, v6) = claim_accrued_rewards_for_card(arg0, arg2, arg3, arg4, v2);
        0x2::balance::join<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut arg5.available_hsui, v5);
        0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::join(&mut arg5.available_gems, v4);
        if (v6) {
            let v7 = HiveCardUnstaked{
                profile_addr : 0x2::object::uid_to_address(&arg5.id),
                version      : arg7,
            };
            0x2::event::emit<HiveCardUnstaked>(v7);
            v1 = v3;
        };
        if (v2.is_staked && v2.unlock_timestamp > 0x2::clock::timestamp_ms(arg0)) {
            let v8 = calc_voting_power(arg6, *0x2::table::borrow<u8, u64>(&arg2.supported_lockup_durations, v2.lockup_duration));
            v0 = v8;
            v2.power = v2.power + v8;
            arg2.active_power = arg2.active_power + (v8 as u128);
            let v9 = TotalActivePowerUpdated{new_total_active_power: arg2.active_power};
            0x2::event::emit<TotalActivePowerUpdated>(v9);
            let v10 = CardPowerUpdated{
                version        : arg7,
                add_power      : v8,
                new_card_power : v2.power,
            };
            0x2::event::emit<CardPowerUpdated>(v10);
        };
        0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::join(&mut v2.available_gems, 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::split(&mut arg5.available_gems, arg6));
        let v11 = HiveGemsDepositedIntoCard{
            profile        : 0x2::object::uid_to_address(&arg5.id),
            version        : arg7,
            gems_deposited : arg6,
        };
        0x2::event::emit<HiveGemsDepositedIntoCard>(v11);
        (v0, v1)
    }

    fun init(arg0: HIVE_PROFILE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = HiveProfileMappingStore{
            id                 : 0x2::object::new(arg1),
            hive_profile_ids   : 0x2::table::new<address, 0x2::object::ID>(arg1),
            hive_profile_names : 0x2::table::new<0x1::ascii::String, 0x2::object::ID>(arg1),
            module_version     : 0,
        };
        0x2::transfer::share_object<HiveProfileMappingStore>(v0);
        let v1 = HiveProfileDeployerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<HiveProfileDeployerCap>(v1, 0x2::tx_context::sender(arg1));
        let v2 = BuidlersRoyaltyCollectionAbility{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<BuidlersRoyaltyCollectionAbility>(v2, 0x2::tx_context::sender(arg1));
        let v3 = HiveDisperser{
            id                      : 0x2::object::new(arg1),
            incoming_gems_for_cards : 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::zero(),
            gems_for_cards          : 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::zero(),
            global_dispersal_index  : 0,
            module_version          : 0,
        };
        0x2::transfer::share_object<HiveDisperser>(v3);
        let v4 = HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>{
            id                      : 0x2::object::new(arg1),
            incoming_hsui_for_cards : 0x2::balance::zero<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(),
            hsui_for_cards          : 0x2::balance::zero<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(),
            global_dispersal_index  : 0,
            module_version          : 0,
        };
        0x2::transfer::share_object<HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(v4);
        let v5 = MarketPlace<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>{
            id                 : 0x2::object::new(arg1),
            active_listings    : 0x2::table::new<u64, Listing>(arg1),
            available_bids     : 0x2::table::new<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(arg1),
            processed_listings : 0x2::table::new<u64, ExecutedListing<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(arg1),
            module_version     : 0,
        };
        0x2::transfer::share_object<MarketPlace<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(v5);
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"username"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"owner"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"is_owned_obj"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"available_gems"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"Website"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"version"));
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"DegenHive - Profile"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"Degenhive's social profile is your unique, non-transferable passport to a hiveverse filled with countless adventures. Trade and collect Hive cards to build your personalized character within this expansive digital universe."));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{username}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{owner}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{is_owned_obj}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{available_gems}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{module_version}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"https://www.app.degenhive.ai/profile"));
        let v10 = 0x2::package::claim<HIVE_PROFILE>(arg0, arg1);
        let v11 = 0x2::display::new_with_fields<HiveProfile>(&v10, v6, v8, arg1);
        0x2::display::update_version<HiveProfile>(&mut v11);
        let v12 = 0x1::vector::empty<0x1::string::String>();
        let v13 = &mut v12;
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"Collection Info"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"img_url"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"version"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"power"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"aesthetic"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"character"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"creator_profile"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"is_staked"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"total_hsui_claimed"));
        0x1::vector::push_back<0x1::string::String>(v13, 0x1::string::utf8(b"Website"));
        let v14 = 0x1::vector::empty<0x1::string::String>();
        let v15 = &mut v14;
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"Hive Cards are unique NFTs representing diverse characters within the Degenhive hiveverse. Choose from four distinct aesthetic of monkeys and gorillas, each with their own elemental powers, and build a dynamic universe of pets, hunters, and legendary creatures."));
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"{version}"));
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"{power}"));
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"{aesthetic}"));
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"{character}"));
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"{creator_profile}"));
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"{is_staked}"));
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"{total_hsui_claimed}"));
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"https://www.app.degenhive.ai/hiveverse"));
        let v16 = 0x2::display::new_with_fields<HiveCard>(&v10, v12, v14, arg1);
        0x2::display::update_version<HiveCard>(&mut v16);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v10, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<HiveProfile>>(v11, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<HiveCard>>(v16, 0x2::tx_context::sender(arg1));
    }

    public entry fun init_hive_profile_config(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: vector<u64>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg7) == 0x1::vector::length<u64>(&arg8), 1087);
        let v0 = 0x2::table::new<u8, u64>(arg9);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg7)) {
            0x2::table::add<u8, u64>(&mut v0, *0x1::vector::borrow<u8>(&arg7, v1), *0x1::vector::borrow<u64>(&arg8, v1));
            v1 = v1 + 1;
        };
        let v2 = ConfigParams{
            max_bids_per_card       : arg2,
            min_bid_allowed         : arg3,
            profile_kraft_fees      : arg4,
            social_param_update_fee : arg5,
        };
        let v3 = Royalty{
            numerator                : 5,
            denominator              : 100,
            cards_dispersal_percent  : arg0,
            creators_royalty_percent : arg1,
        };
        let v4 = HiveSubscriptionRoyalty{
            numerator        : 10,
            denominator      : 100,
            treasury_percent : arg6,
        };
        let v5 = HiveProfileConfig{
            id                         : 0x2::object::new(arg9),
            hive_gems_for_cards        : 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::zero(),
            config_params              : v2,
            active_cards               : 0,
            locked_cards               : 0,
            total_cards                : 100000,
            cards_to_profile_mapping   : 0x2::table::new<u64, address>(arg9),
            active_power               : 0,
            supported_lockup_durations : v0,
            royalty                    : v3,
            gems_royalty               : v4,
            buidlers_royalty           : 0x2::balance::zero<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(),
            module_version             : 0,
            creator_royalties          : 0x2::table::new<address, 0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(arg9),
        };
        0x2::transfer::share_object<HiveProfileConfig>(v5);
    }

    public entry fun initialize_creator_kiosk(arg0: &HiveProfileDeployerCap, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = CreatorHiveKiosk{
            id                   : 0x2::object::new(arg9),
            creator_profile      : arg1,
            followers_only       : false,
            aesthetic            : arg2,
            character            : arg3,
            img_url              : 0x2::url::new_unsafe(0x1::string::to_ascii(arg4)),
            init_hive_gems       : arg5,
            traits_list          : 0x1::vector::empty<0x1::string::String>(),
            prompts_list         : 0x1::vector::empty<vector<0x1::string::String>>(),
            url_list             : 0x1::vector::empty<0x1::string::String>(),
            names_list           : 0x1::vector::empty<0x1::string::String>(),
            krafted_versions_map : 0x2::table::new<u64, bool>(arg9),
            total_cards          : arg6,
            krafted_cards        : 0,
            base_price           : arg7,
            curve_a              : arg8,
            available_upgrades   : 0x2::table::new<u64, vector<CardUpgrade>>(arg9),
            module_version       : 0,
        };
        0x2::transfer::share_object<CreatorHiveKiosk>(v0);
    }

    public entry fun initialize_public_kraft(arg0: &HiveProfileDeployerCap, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 >= 0x2::clock::timestamp_ms(arg1), 1002);
        let v0 = 0x2::object::new(arg7);
        let v1 = PublicKraftInitialized{
            id                       : 0x2::object::uid_to_inner(&v0),
            aesthetic                : arg2,
            character                : arg3,
            start_time               : arg4,
            per_user_limit           : arg5,
            available_cards_to_kraft : arg6,
        };
        0x2::event::emit<PublicKraftInitialized>(v1);
        let v2 = PublicKraftConfig{
            id                       : v0,
            aesthetic                : arg2,
            character                : arg3,
            address_list             : 0x2::table::new<address, u64>(arg7),
            start_time               : arg4,
            per_user_limit           : arg5,
            available_cards_to_kraft : arg6,
            krafts_processed         : 0,
            module_version           : 0,
        };
        0x2::transfer::share_object<PublicKraftConfig>(v2);
    }

    public entry fun initialize_whitelisted_kraft(arg0: &HiveProfileDeployerCap, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 >= 0x2::clock::timestamp_ms(arg1) && arg4 < arg5, 1002);
        let v0 = 0x2::object::new(arg9);
        let v1 = WhitelistKraftInitialized{
            id                       : 0x2::object::uid_to_inner(&v0),
            aesthetic                : arg2,
            character                : arg3,
            start_time               : arg4,
            end_time                 : arg5,
            base_price               : arg6,
            curve_a                  : arg7,
            available_cards_to_kraft : arg8,
        };
        0x2::event::emit<WhitelistKraftInitialized>(v1);
        let v2 = WhitelistKraftConfig{
            id                       : v0,
            aesthetic                : arg2,
            character                : arg3,
            whitelisted_addresses    : 0x2::table::new<address, u64>(arg9),
            start_time               : arg4,
            end_time                 : arg5,
            available_cards_to_kraft : arg8,
            krafts_processed         : 0,
            base_price               : arg6,
            curve_a                  : arg7,
            module_version           : 0,
        };
        0x2::transfer::share_object<WhitelistKraftConfig>(v2);
    }

    public entry fun insert_characters_attributes_in_record(arg0: &HiveProfileDeployerCap, arg1: &mut CreatorHiveKiosk, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<vector<0x1::string::String>>, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 1079);
        assert!(arg1.aesthetic == arg2 && arg1.character == arg3, 1068);
        let v0 = 0;
        assert!(0x1::vector::length<vector<0x1::string::String>>(&arg4) == 0x1::vector::length<0x1::string::String>(&arg5), 1055);
        assert!(0x1::vector::length<vector<0x1::string::String>>(&arg4) == 0x1::vector::length<0x1::string::String>(&arg6), 1066);
        while (v0 < 0x1::vector::length<vector<0x1::string::String>>(&arg4)) {
            let v1 = 0x1::vector::borrow<vector<0x1::string::String>>(&arg4, v0);
            let v2 = 0x1::vector::borrow<0x1::string::String>(&arg5, v0);
            let v3 = 0x1::vector::borrow<0x1::string::String>(&arg6, v0);
            let v4 = *v1;
            assert!(0x1::vector::length<0x1::string::String>(&v4) == 0x1::vector::length<0x1::string::String>(&arg1.traits_list), 1051);
            0x1::vector::push_back<vector<0x1::string::String>>(&mut arg1.prompts_list, *v1);
            0x1::vector::push_back<0x1::string::String>(&mut arg1.url_list, *v2);
            0x1::vector::push_back<0x1::string::String>(&mut arg1.names_list, *v3);
            v0 = v0 + 1;
        };
    }

    fun internal_kraft_hive_profile(arg0: bool, arg1: 0x1::string::String, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: &mut HiveProfileMappingStore, arg7: &mut HiveProfileConfig, arg8: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg9: 0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg10: &mut 0x2::tx_context::TxContext) : HiveProfile {
        let v0 = 0x2::object::new(arg10);
        let v1 = 0x2::object::uid_to_inner(&v0);
        assert!(is_valid_profile_name(arg1), 1084);
        let v2 = 0x1::string::to_ascii(arg1);
        assert!(!0x2::table::contains<0x1::ascii::String, 0x2::object::ID>(&arg6.hive_profile_names, v2), 1083);
        0x2::table::add<0x1::ascii::String, 0x2::object::ID>(&mut arg6.hive_profile_names, v2, v1);
        if (!arg0) {
            assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg6.hive_profile_ids, arg2), 1056);
            0x2::table::add<address, 0x2::object::ID>(&mut arg6.hive_profile_ids, arg2, v1);
        } else {
            arg2 = @0x0;
        };
        0x2::balance::join<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut arg7.buidlers_royalty, 0x2::balance::split<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut arg9, 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::math::mul_div(0x2::balance::value<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&arg9), 50, 100)));
        0x2::balance::join<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut arg8.incoming_hsui_for_cards, arg9);
        let v3 = 0x2::table::new<u8, u64>(arg10);
        0x2::table::add<u8, u64>(&mut v3, 1, arg3);
        0x2::table::add<u8, u64>(&mut v3, 3, arg4);
        0x2::table::add<u8, u64>(&mut v3, 12, arg5);
        let v4 = HiveProfileKrafted{
            name             : arg1,
            new_profile_addr : 0x2::object::uid_to_address(&v0),
            krafter          : arg2,
            fee              : arg7.config_params.profile_kraft_fees,
            is_owned         : arg0,
        };
        0x2::event::emit<HiveProfileKrafted>(v4);
        HiveProfile{
            id                 : v0,
            username           : v2,
            owner              : arg2,
            is_owned_obj       : arg0,
            available_gems     : 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::zero(),
            available_hsui     : 0x2::balance::zero<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(),
            hive_cards         : 0x2::table::new<u64, HiveCard>(arg10),
            available_versions : 0x1::vector::empty<u64>(),
            incoming_bids      : 0x2::table::new<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(arg10),
            borrowed_versions  : 0x1::vector::empty<u64>(),
            borrow_records     : 0x2::table::new<u64, BorrowRecord>(arg10),
            listing_records    : 0x2::table::new<u64, ListingRecord>(arg10),
            listed_versions    : 0x1::vector::empty<u64>(),
            bid_records        : 0x2::table::new<u64, BidRecord>(arg10),
            bidded_versions    : 0x1::vector::empty<u64>(),
            lend_records       : 0x2::table::new<u64, LendRecord>(arg10),
            lend_versions      : 0x1::vector::empty<u64>(),
            subscriptions      : v3,
            followers_list     : 0x2::table::new<address, Subscription>(arg10),
            following_list     : 0x2::table::new<address, Subscription>(arg10),
            module_version     : 0,
        }
    }

    fun internal_kraft_hiveverse_asset(arg0: &mut HiveProfile, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x27e0df03aead8beed62eaf8e0bd299a4d6693886b5d88a1edf7d0e4453239e04::hsui_vault::HSuiVault, arg3: address, arg4: u64, arg5: &mut HiveProfileConfig, arg6: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg7: &mut HiveDisperser, arg8: &mut CreatorHiveKiosk, arg9: 0x2::balance::Balance<0x2::sui::SUI>, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, HiveCard, vector<0x1::string::String>, vector<0x1::string::String>) {
        let v0 = arg8.creator_profile;
        let v1 = 0x2::object::uid_to_address(&arg0.id);
        if (arg8.followers_only) {
            assert!(0x2::table::contains<address, Subscription>(&arg0.following_list, v0), 1089);
            let v2 = 0x2::table::borrow<address, Subscription>(&arg0.following_list, v0);
            assert!(arg4 < v2.next_payment_timestamp && v2.is_active, 1088);
        };
        let v3 = 0x27e0df03aead8beed62eaf8e0bd299a4d6693886b5d88a1edf7d0e4453239e04::hsui_vault::stake_sui_request(arg1, arg2, 0x2::balance::split<0x2::sui::SUI>(&mut arg9, arg10), 0x1::option::none<address>(), arg11);
        if (!0x2::table::contains<address, 0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&arg5.creator_royalties, v0)) {
            0x2::table::add<address, 0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&mut arg5.creator_royalties, v0, 0x2::balance::zero<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>());
        };
        0x2::balance::join<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(0x2::table::borrow_mut<address, 0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&mut arg5.creator_royalties, v0), 0x2::balance::split<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut v3, (0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::math::mul_div_u256((0x2::balance::value<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&v3) as u256), (30 as u256), (100 as u256)) as u64)));
        0x2::balance::join<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut arg5.buidlers_royalty, v3);
        increment_global_index(arg5, arg6);
        increment_gems_global_index(arg5, arg7);
        assert!(arg5.active_cards + 1 <= arg5.total_cards, 1049);
        let v4 = 0x1::vector::length<0x1::string::String>(&arg8.names_list);
        let v5 = if (v4 == 0) {
            0
        } else {
            arg4 % v4
        };
        let v6 = 0x1::vector::remove<vector<0x1::string::String>>(&mut arg8.prompts_list, v5);
        let v7 = 0x1::vector::remove<0x1::string::String>(&mut arg8.url_list, v5);
        let v8 = 0x2::table::new<0x1::string::String, 0x1::string::String>(arg11);
        let v9 = 0x1::vector::empty<0x1::string::String>();
        let v10 = 0x1::vector::empty<0x1::string::String>();
        let v11 = 0;
        while (v11 < 0x1::vector::length<0x1::string::String>(&arg8.traits_list)) {
            let v12 = 0x1::vector::borrow<0x1::string::String>(&arg8.traits_list, v11);
            let v13 = 0x1::vector::borrow<0x1::string::String>(&v6, v11);
            0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v8, *v12, *v13);
            0x1::vector::push_back<0x1::string::String>(&mut v9, *v12);
            0x1::vector::push_back<0x1::string::String>(&mut v10, *v13);
            v11 = v11 + 1;
        };
        let v14 = 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::zero();
        if (0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::value(&arg5.hive_gems_for_cards) >= arg8.init_hive_gems) {
            0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::join(&mut v14, 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::split(&mut arg5.hive_gems_for_cards, arg8.init_hive_gems));
        };
        let v15 = HiveCard{
            id                 : 0x2::object::new(arg11),
            version            : arg5.active_cards + 1,
            power              : 0,
            available_gems     : v14,
            claim_index        : arg6.global_dispersal_index,
            gems_claim_index   : arg7.global_dispersal_index,
            name               : 0x1::vector::remove<0x1::string::String>(&mut arg8.names_list, v5),
            img_url            : 0x2::url::new_unsafe(0x1::string::to_ascii(v7)),
            aesthetic          : arg8.aesthetic,
            character          : arg8.character,
            traits_list        : v9,
            prompts            : v8,
            total_hsui_claimed : 0,
            total_gems_claimed : 0,
            is_borrowed        : false,
            is_staked          : false,
            lockup_duration    : 0,
            unlock_timestamp   : 0,
            active_skins       : 0x2::table::new<0x1::string::String, SkinRecord>(arg11),
            creator_profile    : v0,
        };
        0x2::table::add<u64, bool>(&mut arg8.krafted_versions_map, v15.version, true);
        update_card_ownership(arg5, v15.version, v1);
        let v16 = NewHiveCardKrafted{
            id                   : 0x2::object::uid_to_inner(&v15.id),
            krafter_profile_addr : v1,
            krafter              : arg3,
            aesthetic            : v15.aesthetic,
            character            : v15.character,
            name                 : v15.name,
            version              : v15.version,
            img_url              : v7,
            genesis_hivegems     : 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::value(&v15.available_gems),
            power                : v15.power,
            price                : arg10,
            traits_list          : v9,
            prompts_list         : v10,
        };
        0x2::event::emit<NewHiveCardKrafted>(v16);
        arg5.active_cards = arg5.active_cards + 1;
        (arg9, v15, v9, v10)
    }

    fun internal_process_subscription_payment(arg0: &HiveProfileConfig, arg1: &mut HiveDisperser, arg2: &mut 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::config::GemsTreasury, arg3: address, arg4: address, arg5: 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::HiveGems, arg6: u64, arg7: u64) : 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::HiveGems {
        increment_gems_global_index(arg0, arg1);
        let (v0, v1, v2) = process_gems_royalty(arg0, arg2, arg5, arg1);
        let v3 = SubscriptionPaymentProcessed{
            follower_profile_addr : arg3,
            profile_followed_addr : arg4,
            subscription_type     : arg6,
            subscription_cost     : arg7,
            total_royalty_amt     : v1,
            gems_burnt            : v2,
        };
        0x2::event::emit<SubscriptionPaymentProcessed>(v3);
        v0
    }

    public fun is_follower_of_profile(arg0: &HiveProfile, arg1: &HiveProfile) : bool {
        0x2::table::contains<address, Subscription>(&arg0.followers_list, 0x2::object::uid_to_address(&arg1.id))
    }

    public fun is_follower_of_profile_addr(arg0: &HiveProfile, arg1: address) : bool {
        0x2::table::contains<address, Subscription>(&arg0.followers_list, arg1)
    }

    public fun is_following_profile(arg0: &HiveProfile, arg1: &HiveProfile) : bool {
        0x2::table::contains<address, Subscription>(&arg0.following_list, 0x2::object::uid_to_address(&arg1.id))
    }

    public fun is_following_profile_addr(arg0: &HiveProfile, arg1: address) : bool {
        0x2::table::contains<address, Subscription>(&arg0.following_list, arg1)
    }

    public fun is_hive_card_listed(arg0: &MarketPlace<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg1: u64) : bool {
        0x2::table::contains<u64, Listing>(&arg0.active_listings, arg1)
    }

    public fun is_listing_executed(arg0: &MarketPlace<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg1: u64) : bool {
        0x2::table::contains<u64, ExecutedListing<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&arg0.processed_listings, arg1)
    }

    public fun is_usable_profile_name(arg0: &HiveProfileMappingStore, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::ascii::String, 0x2::object::ID>(&arg0.hive_profile_names, 0x1::string::to_ascii(arg1)) && false || is_valid_profile_name(arg1)
    }

    fun is_valid_profile_char(arg0: u8) : bool {
        arg0 >= 65 && arg0 <= 90 || arg0 >= 97 && arg0 <= 122 || arg0 >= 48 && arg0 <= 57 || arg0 == 95 || arg0 == 45
    }

    public fun is_valid_profile_name(arg0: 0x1::string::String) : bool {
        let v0 = 0x1::string::to_ascii(arg0);
        if (0x1::ascii::length(&v0) > 24) {
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

    public entry fun kraft_hive_cards(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x27e0df03aead8beed62eaf8e0bd299a4d6693886b5d88a1edf7d0e4453239e04::hsui_vault::HSuiVault, arg3: &mut HiveProfileConfig, arg4: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg5: &mut HiveDisperser, arg6: &mut CreatorHiveKiosk, arg7: &mut WhitelistKraftConfig, arg8: &mut PublicKraftConfig, arg9: &mut HiveProfile, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg9.is_owned_obj || arg9.owner == 0x2::tx_context::sender(arg13), 1057);
        let v0 = kraft_hive_cards_loop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        let v1 = 0x2::tx_context::sender(arg13);
        destroy_or_transfer_balance<0x2::sui::SUI>(v0, v1, arg13);
    }

    public fun kraft_hive_cards_and_return_sui(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x27e0df03aead8beed62eaf8e0bd299a4d6693886b5d88a1edf7d0e4453239e04::hsui_vault::HSuiVault, arg3: &mut HiveProfileConfig, arg4: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg5: &mut HiveDisperser, arg6: &mut CreatorHiveKiosk, arg7: &mut WhitelistKraftConfig, arg8: &mut PublicKraftConfig, arg9: &mut HiveProfile, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg9.is_owned_obj || arg9.owner == 0x2::tx_context::sender(arg13), 1057);
        let v0 = kraft_hive_cards_loop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        0x2::coin::from_balance<0x2::sui::SUI>(v0, arg13)
    }

    fun kraft_hive_cards_loop(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x27e0df03aead8beed62eaf8e0bd299a4d6693886b5d88a1edf7d0e4453239e04::hsui_vault::HSuiVault, arg3: &mut HiveProfileConfig, arg4: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg5: &mut HiveDisperser, arg6: &mut CreatorHiveKiosk, arg7: &mut WhitelistKraftConfig, arg8: &mut PublicKraftConfig, arg9: &mut HiveProfile, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg11 + arg12 <= 0x1::vector::length<0x1::string::String>(&arg6.names_list), 1082);
        let v0 = 0;
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg10);
        while (v0 < arg11) {
            v1 = execute_whitelisted_kraft(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9, v1, arg13);
            v0 = v0 + 1;
        };
        v0 = 0;
        while (v0 < arg12) {
            v1 = execute_public_kraft(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg9, v1, arg13);
            v0 = v0 + 1;
        };
        v1
    }

    public entry fun kraft_hive_cards_with_profile(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x27e0df03aead8beed62eaf8e0bd299a4d6693886b5d88a1edf7d0e4453239e04::hsui_vault::HSuiVault, arg3: &mut HiveProfileMappingStore, arg4: &mut HiveProfileConfig, arg5: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg6: &mut HiveDisperser, arg7: &mut CreatorHiveKiosk, arg8: &mut WhitelistKraftConfig, arg9: &mut PublicKraftConfig, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: u64, arg12: u64, arg13: 0x1::string::String, arg14: u64, arg15: u64, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg17);
        let (v1, v2) = stake_sui_for_hsui(arg1, arg2, 0x2::coin::into_balance<0x2::sui::SUI>(arg10), arg4.config_params.profile_kraft_fees, arg17);
        let v3 = internal_kraft_hive_profile(false, arg13, v0, arg14, arg15, arg16, arg3, arg4, arg5, v2, arg17);
        let v4 = &mut v3;
        let v5 = 0x2::coin::from_balance<0x2::sui::SUI>(v1, arg17);
        let v6 = kraft_hive_cards_loop(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8, arg9, v4, v5, arg11, arg12, arg17);
        let v7 = 0x2::tx_context::sender(arg17);
        destroy_or_transfer_balance<0x2::sui::SUI>(v6, v7, arg17);
        0x2::transfer::share_object<HiveProfile>(v3);
    }

    public entry fun kraft_hive_profile(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x27e0df03aead8beed62eaf8e0bd299a4d6693886b5d88a1edf7d0e4453239e04::hsui_vault::HSuiVault, arg2: &mut HiveProfileMappingStore, arg3: &mut HiveProfileConfig, arg4: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = kraft_hive_profile_and_return_sui(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v1 = 0x2::tx_context::sender(arg10);
        destroy_or_transfer_balance<0x2::sui::SUI>(v0, v1, arg10);
    }

    public fun kraft_hive_profile_and_return_sui(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x27e0df03aead8beed62eaf8e0bd299a4d6693886b5d88a1edf7d0e4453239e04::hsui_vault::HSuiVault, arg2: &mut HiveProfileMappingStore, arg3: &mut HiveProfileConfig, arg4: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg2.module_version == 0 && arg3.module_version == 0 && arg4.module_version == 0, 1079);
        let (v0, v1) = stake_sui_for_hsui(arg0, arg1, 0x2::coin::into_balance<0x2::sui::SUI>(arg5), arg3.config_params.profile_kraft_fees, arg10);
        let v2 = 0x2::tx_context::sender(arg10);
        0x2::transfer::share_object<HiveProfile>(internal_kraft_hive_profile(false, arg6, v2, arg7, arg8, arg9, arg2, arg3, arg4, v1, arg10));
        v0
    }

    public fun kraft_owned_hive_profile(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x27e0df03aead8beed62eaf8e0bd299a4d6693886b5d88a1edf7d0e4453239e04::hsui_vault::HSuiVault, arg2: &mut HiveProfileMappingStore, arg3: &mut HiveProfileConfig, arg4: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : (HiveProfile, 0x2::balance::Balance<0x2::sui::SUI>) {
        let (v0, v1) = stake_sui_for_hsui(arg0, arg1, 0x2::coin::into_balance<0x2::sui::SUI>(arg5), arg3.config_params.profile_kraft_fees, arg10);
        let v2 = 0x2::tx_context::sender(arg10);
        (internal_kraft_hive_profile(true, arg6, v2, arg7, arg8, arg9, arg2, arg3, arg4, v1, arg10), v0)
    }

    public fun lock_hivecard(arg0: &0x2::clock::Clock, arg1: &0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::config::HiveDaoCapability, arg2: &mut HiveProfileConfig, arg3: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg4: &mut HiveDisperser, arg5: &mut HiveProfile, arg6: u64, arg7: u8, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg2.module_version == 0 && arg3.module_version == 0 && arg4.module_version == 0 && arg5.module_version == 0, 1079);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::clock::timestamp_ms(arg0);
        assert!(0x2::table::contains<u8, u64>(&arg2.supported_lockup_durations, arg7), 1088);
        let v2 = *0x2::table::borrow<u8, u64>(&arg2.supported_lockup_durations, arg7);
        assert!(arg5.is_owned_obj || arg5.owner == v0, 1057);
        let (v3, v4) = withdraw_hive_card(arg0, arg2, arg3, arg4, arg5, arg6, false);
        let v5 = v3;
        0x2::balance::join<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut arg5.available_hsui, v4);
        assert!(!v5.is_staked, 1082);
        if (v5.is_borrowed) {
            let v6 = 0x2::table::borrow<u64, BorrowRecord>(&arg5.borrow_records, arg6);
            assert!(v6.lockup_duration == arg7, 1088);
            assert!(v6.start_sec + 259200000 > v1, 1083);
        };
        v5.is_staked = true;
        let v7 = calc_voting_power(0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::value(&v5.available_gems), v2);
        v5.power = v7;
        v5.unlock_timestamp = v1 + (arg7 as u64) * 2592000000;
        v5.lockup_duration = arg7;
        arg2.locked_cards = arg2.locked_cards + 1;
        arg2.active_power = arg2.active_power + (v5.power as u128);
        v5.claim_index = arg3.global_dispersal_index;
        v5.gems_claim_index = arg4.global_dispersal_index;
        let v8 = TotalActivePowerUpdated{new_total_active_power: arg2.active_power};
        0x2::event::emit<TotalActivePowerUpdated>(v8);
        let v9 = HiveCardStaked{
            staker           : v0,
            profile_addr     : 0x2::object::uid_to_address(&arg5.id),
            version          : arg6,
            duration         : arg7,
            new_card_power   : v5.power,
            unlock_timestamp : v5.unlock_timestamp,
        };
        0x2::event::emit<HiveCardStaked>(v9);
        if (0x2::table::contains<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(&mut arg5.incoming_bids, arg6)) {
            let v10 = 0x2::table::borrow_mut<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(&mut arg5.incoming_bids, arg6);
            let v11 = 0;
            while (v11 < 0x1::vector::length<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(v10)) {
                let v12 = 0x1::vector::borrow_mut<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(v10, v11);
                v12.is_valid = false;
                let v13 = BidMarkedInvalid{
                    version        : arg6,
                    bidder_profile : v12.bidder_profile,
                };
                0x2::event::emit<BidMarkedInvalid>(v13);
                v11 = v11 + 1;
            };
        };
        deposit_hive_card(arg5, v5);
        v7
    }

    public entry fun make_bid_with_hsui(arg0: &0x2::clock::Clock, arg1: &mut HiveProfileConfig, arg2: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg3: &mut MarketPlace<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg4: &mut HiveProfile, arg5: 0x2::coin::Coin<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0 && arg3.module_version == 0, 1079);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::object::uid_to_address(&arg4.id);
        assert!(arg4.is_owned_obj || arg4.owner == v0, 1057);
        assert!(arg7 >= arg1.config_params.min_bid_allowed, 1040);
        let v2 = 0x2::clock::timestamp_ms(arg0);
        let v3 = 0x2::table::borrow<u64, Listing>(&arg3.active_listings, arg6);
        assert!(v3.start_sec < v2, 1031);
        assert!(v3.expiration_sec > v2, 1032);
        assert!(v3.is_sale_listing, 1042);
        if (v3.followers_only) {
            assert!(0x2::table::contains<address, Subscription>(&arg4.following_list, v3.listed_by_profile), 1090);
            let v4 = 0x2::table::borrow<address, Subscription>(&arg4.following_list, v3.listed_by_profile);
            assert!(0x2::clock::timestamp_ms(arg0) < v4.next_payment_timestamp && v4.is_active, 1088);
        };
        assert!(v2 < arg8 && arg8 - v2 < 7776000000, 1030);
        let v5 = 0x2::coin::into_balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(arg5);
        if (v3.instant_sale && arg7 >= v3.min_price) {
            let v6 = &mut v5;
            let (v7, v8) = execute_sale(arg1, arg3, arg2, arg6, false, v1, arg7, v6);
            update_card_ownership(arg1, arg6, v1);
            deposit_hive_card(arg4, v7);
            0x2::table::add<u64, ExecutedListing<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&mut arg3.processed_listings, arg6, v8);
        } else {
            let v9 = BidPlaced{
                version        : arg6,
                bidder_profile : v1,
                offer_price    : arg7,
                expiration_sec : arg8,
                is_card_listed : true,
            };
            0x2::event::emit<BidPlaced>(v9);
            let v10 = &mut arg3.available_bids;
            add_bid_to_table(v10, arg6, create_bid(v1, arg7, 0x2::balance::split<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut v5, arg7), arg8, true), arg1.config_params.max_bids_per_card);
            add_bid_record_to_profile(arg4, arg6, create_bid_record(arg6, arg7, arg8, true));
        };
        destroy_or_transfer_balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(v5, v0, arg9);
    }

    public entry fun make_bid_with_sui(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x27e0df03aead8beed62eaf8e0bd299a4d6693886b5d88a1edf7d0e4453239e04::hsui_vault::HSuiVault, arg3: &mut HiveProfileConfig, arg4: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg5: &mut MarketPlace<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg6: &mut HiveProfile, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg7);
        let v1 = 0x27e0df03aead8beed62eaf8e0bd299a4d6693886b5d88a1edf7d0e4453239e04::hsui_vault::stake_sui_request(arg1, arg2, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg9), 0x1::option::none<address>(), arg11);
        let v2 = 0x2::coin::from_balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(v1, arg11);
        make_bid_with_hsui(arg0, arg3, arg4, arg5, arg6, v2, arg8, 0x2::balance::value<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&v1), arg10, arg11);
        let v3 = 0x2::tx_context::sender(arg11);
        destroy_or_transfer_balance<0x2::sui::SUI>(v0, v3, arg11);
    }

    public entry fun make_direct_bid_with_hsui(arg0: &0x2::clock::Clock, arg1: &mut HiveProfileConfig, arg2: &mut HiveProfile, arg3: &mut HiveProfile, arg4: 0x2::coin::Coin<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 1079);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::object::uid_to_address(&arg3.id);
        assert!(arg3.is_owned_obj || arg3.owner == v0, 1057);
        assert!(arg6 >= arg1.config_params.min_bid_allowed, 1040);
        let v2 = 0x2::table::borrow<u64, HiveCard>(&arg2.hive_cards, arg5);
        assert!(!v2.is_borrowed, 1046);
        assert!(!v2.is_staked, 1053);
        let v3 = 0x2::clock::timestamp_ms(arg0);
        assert!(v3 < arg7 && arg7 - v3 < 7776000000, 1030);
        let v4 = 0x2::coin::into_balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(arg4);
        let v5 = &mut arg2.incoming_bids;
        add_bid_to_table(v5, arg5, create_bid(v1, arg6, 0x2::balance::split<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut v4, arg6), arg7, false), arg1.config_params.max_bids_per_card);
        add_bid_record_to_profile(arg3, arg5, create_bid_record(arg5, arg6, arg7, false));
        destroy_or_transfer_balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(v4, v0, arg8);
        let v6 = BidPlaced{
            version        : arg5,
            bidder_profile : v1,
            offer_price    : arg6,
            expiration_sec : arg7,
            is_card_listed : false,
        };
        0x2::event::emit<BidPlaced>(v6);
    }

    public entry fun make_direct_bid_with_sui(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x27e0df03aead8beed62eaf8e0bd299a4d6693886b5d88a1edf7d0e4453239e04::hsui_vault::HSuiVault, arg3: &mut HiveProfileConfig, arg4: &mut HiveProfile, arg5: &mut HiveProfile, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg6);
        let v1 = 0x27e0df03aead8beed62eaf8e0bd299a4d6693886b5d88a1edf7d0e4453239e04::hsui_vault::stake_sui_request(arg1, arg2, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg8), 0x1::option::none<address>(), arg10);
        let v2 = 0x2::coin::from_balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(v1, arg10);
        make_direct_bid_with_hsui(arg0, arg3, arg4, arg5, v2, arg7, 0x2::balance::value<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&v1), arg9, arg10);
        let v3 = 0x2::tx_context::sender(arg10);
        destroy_or_transfer_balance<0x2::sui::SUI>(v0, v3, arg10);
    }

    public entry fun make_listing(arg0: &0x2::clock::Clock, arg1: &mut HiveProfileConfig, arg2: &mut MarketPlace<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg3: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg4: &mut HiveDisperser, arg5: &mut HiveProfile, arg6: u64, arg7: bool, arg8: u64, arg9: bool, arg10: bool, arg11: bool, arg12: u8, arg13: u64, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0 && arg4.module_version == 0 && arg3.module_version == 0 && arg5.module_version == 0, 1079);
        let v0 = 0x2::object::uid_to_address(&arg5.id);
        assert!(arg5.is_owned_obj || arg5.owner == 0x2::tx_context::sender(arg15), 1057);
        assert!(arg13 > 0x2::clock::timestamp_ms(arg0) && arg14 > arg13 && arg14 - arg13 < 7776000000, 1002);
        if (!arg9) {
            assert!(0x2::table::contains<u8, u64>(&arg1.supported_lockup_durations, arg12), 1088);
        } else {
            assert!(arg10 || arg11, 1078);
            if (arg10) {
                assert!(!arg11, 1078);
            } else {
                assert!(arg11, 1078);
            };
        };
        let (v1, v2) = withdraw_hive_card(arg0, arg1, arg3, arg4, arg5, arg6, false);
        let v3 = v1;
        0x2::balance::join<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut arg5.available_hsui, v2);
        assert!(!v3.is_borrowed, 1046);
        if (0x2::table::contains<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(&mut arg5.incoming_bids, arg6)) {
            let v4 = 0x2::table::borrow_mut<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(&mut arg5.incoming_bids, arg6);
            let v5 = 0;
            while (v5 < 0x1::vector::length<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(v4)) {
                let v6 = 0x1::vector::borrow_mut<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(v4, v5);
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
            listed_by_profile : v0,
            hive_card         : v3,
            followers_only    : arg7,
            min_price         : arg8,
            is_sale_listing   : arg9,
            instant_sale      : arg10,
            highest_bid_sale  : arg11,
            lockup_duration   : arg12,
            start_sec         : arg13,
            expiration_sec    : arg14,
        };
        let v9 = ListingRecord{
            version          : arg6,
            followers_only   : arg7,
            min_price        : arg8,
            is_sale_listing  : arg9,
            instant_sale     : arg10,
            highest_bid_sale : arg11,
            lockup_duration  : arg12,
            start_sec        : arg13,
            expiration_sec   : arg14,
        };
        let v10 = NewListing{
            listed_by_profile : v0,
            followers_only    : arg7,
            version           : arg6,
            min_price         : arg8,
            is_sale_listing   : arg9,
            instant_sale      : arg10,
            highest_bid_sale  : arg11,
            lockup_duration   : arg12,
            start_sec         : arg13,
            expiration_sec    : arg14,
        };
        0x2::event::emit<NewListing>(v10);
        0x2::table::add<u64, ListingRecord>(&mut arg5.listing_records, arg6, v9);
        0x1::vector::push_back<u64>(&mut arg5.listed_versions, arg6);
        0x2::table::add<u64, Listing>(&mut arg2.active_listings, arg6, v8);
    }

    fun mark_marketplace_bids_as_invalid(arg0: &mut MarketPlace<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg1: u64) {
        if (0x2::table::contains<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(&arg0.available_bids, arg1)) {
            let v0 = 0x2::table::remove<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(&mut arg0.available_bids, arg1);
            let v1 = 0;
            while (v1 < 0x1::vector::length<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&v0)) {
                let v2 = 0x1::vector::borrow_mut<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&mut v0, v1);
                v2.is_listing_live = false;
                v2.is_valid = false;
                let v3 = BidMarkedInvalid{
                    version        : arg1,
                    bidder_profile : v2.bidder_profile,
                };
                0x2::event::emit<BidMarkedInvalid>(v3);
                v1 = v1 + 1;
            };
            0x2::table::add<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(&mut arg0.available_bids, arg1, v0);
        };
    }

    public entry fun modify_bid(arg0: &0x2::clock::Clock, arg1: &mut HiveProfileConfig, arg2: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg3: &mut MarketPlace<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg4: &mut HiveProfile, arg5: 0x2::coin::Coin<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0 && arg3.module_version == 0, 1079);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::object::uid_to_address(&arg4.id);
        assert!(arg4.is_owned_obj || arg4.owner == v0, 1057);
        assert!(0x2::table::contains<u64, BidRecord>(&arg4.bid_records, arg6), 1026);
        let v2 = 0x2::clock::timestamp_ms(arg0);
        let v3 = 0x2::table::borrow<u64, Listing>(&arg3.active_listings, arg6);
        assert!(v3.start_sec < v2, 1031);
        assert!(v3.expiration_sec > v2, 1032);
        assert!(0x2::table::borrow<u64, BidRecord>(&arg4.bid_records, arg6).expiration_sec > v2, 1071);
        let v4 = 0x2::coin::into_balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(arg5);
        if (v3.instant_sale && arg7 >= v3.min_price) {
            let v5 = &mut v4;
            let (v6, v7) = execute_sale(arg1, arg3, arg2, arg6, true, v1, arg7, v5);
            update_card_ownership(arg1, arg6, v1);
            deposit_hive_card(arg4, v6);
            0x2::table::add<u64, ExecutedListing<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&mut arg3.processed_listings, arg6, v7);
        } else {
            let v8 = 0x2::table::borrow_mut<u64, BidRecord>(&mut arg4.bid_records, arg6);
            update_bid_record(v8, arg7, arg8, v2);
            let v9 = BidModified{
                version        : arg6,
                bidder_profile : v1,
                offer_price    : arg7,
                expiration_sec : arg8,
            };
            0x2::event::emit<BidModified>(v9);
            let v10 = 0x2::table::remove<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(&mut arg3.available_bids, arg6);
            let v11 = &mut v10;
            let v12 = &mut v4;
            update_bid_among_bids(v11, v1, arg7, arg8, v12, true, arg6);
            0x2::table::add<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(&mut arg3.available_bids, arg6, v10);
        };
        destroy_or_transfer_balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(v4, v0, arg9);
    }

    public entry fun modify_direct_bid(arg0: &0x2::clock::Clock, arg1: &mut HiveProfile, arg2: &mut HiveProfile, arg3: 0x2::coin::Coin<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0, 1079);
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x2::coin::into_balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(arg3);
        let v2 = 0x2::tx_context::sender(arg7);
        let v3 = 0x2::object::uid_to_address(&arg2.id);
        assert!(arg2.is_owned_obj || arg2.owner == v2, 1057);
        assert!(0x2::table::contains<u64, BidRecord>(&arg2.bid_records, arg4), 1026);
        assert!(0x1::vector::contains<u64>(&arg1.available_versions, &arg4), 1065);
        let v4 = 0x2::table::borrow_mut<u64, BidRecord>(&mut arg2.bid_records, arg4);
        assert!(v4.expiration_sec > v0, 1071);
        update_bid_record(v4, arg5, arg6, v0);
        let v5 = 0x2::table::remove<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(&mut arg1.incoming_bids, arg4);
        let v6 = &mut v5;
        let v7 = &mut v1;
        update_bid_among_bids(v6, v3, arg5, arg6, v7, false, arg4);
        0x2::table::add<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(&mut arg1.incoming_bids, arg4, v5);
        let v8 = BidModified{
            version        : arg4,
            bidder_profile : v3,
            offer_price    : arg5,
            expiration_sec : arg6,
        };
        0x2::event::emit<BidModified>(v8);
        destroy_or_transfer_balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(v1, v2, arg7);
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

    fun process_gems_royalty(arg0: &HiveProfileConfig, arg1: &mut 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::config::GemsTreasury, arg2: 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::HiveGems, arg3: &mut HiveDisperser) : (0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::HiveGems, u64, u64) {
        let v0 = (0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::math::mul_div_u128((0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::value(&arg2) as u128), (arg0.gems_royalty.numerator as u128), (arg0.gems_royalty.denominator as u128)) as u64);
        let v1 = 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::split(&mut arg2, v0);
        let v2 = (0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::math::mul_div_u128((0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::value(&v1) as u128), (arg0.gems_royalty.treasury_percent as u128), (100 as u128)) as u64);
        deposit_gems_for_hive(arg3, 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::config::deposit_gems_to_treasury(arg1, v1, v2));
        (arg2, v0, v2)
    }

    fun process_highest_bid_sale_listing(arg0: &0x2::clock::Clock, arg1: &mut HiveProfileConfig, arg2: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg3: &mut MarketPlace<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg4: u64) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0 && arg3.module_version == 0, 1079);
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x2::table::borrow<u64, Listing>(&mut arg3.active_listings, arg4);
        if (v1.expiration_sec > v0) {
            return
        };
        assert!(v1.is_sale_listing && v1.highest_bid_sale, 1044);
        let v2 = v1.listed_by_profile;
        let v3 = false;
        if (0x2::table::contains<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(&arg3.available_bids, arg4)) {
            let v4 = v1.min_price;
            let v5 = 0x2::table::remove<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(&mut arg3.available_bids, arg4);
            let v6 = 0;
            while (v6 < 0x1::vector::length<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&v5)) {
                let v7 = 0x1::vector::borrow_mut<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&mut v5, v6);
                v7.is_listing_live = false;
                v7.is_valid = false;
                let v8 = BidMarkedInvalid{
                    version        : arg4,
                    bidder_profile : v7.bidder_profile,
                };
                0x2::event::emit<BidMarkedInvalid>(v8);
                if (v7.expiration_sec > v0) {
                    if (v7.offer_price >= v4) {
                        v4 = v7.offer_price;
                        v3 = true;
                    };
                };
                v6 = v6 + 1;
            };
            if (v3) {
                let (v9, _, _, _, _, _, _, _, _, _) = destroy_listing(0x2::table::remove<u64, Listing>(&mut arg3.active_listings, arg4));
                let v19 = v9;
                let v20 = 0x1::vector::remove<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&mut v5, 0);
                let v21 = v20.bidder_profile;
                let (v22, _, _, _, _, _) = destroy_bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(v20, arg4);
                let v28 = v22;
                let v29 = 0x2::balance::value<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&v28);
                let v30 = ExecutedListing<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>{
                    listed_by_profile       : v2,
                    hive_card               : 0x1::option::some<HiveCard>(v19),
                    version                 : arg4,
                    was_sale_listing        : true,
                    balance                 : 0x1::option::some<0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(process_royalty(v28, arg1, arg2, v19.creator_profile)),
                    bidder_profile          : v21,
                    executed_price          : v29,
                    borrow_period_start_sec : 0,
                    borrow_period_end_sec   : 0,
                };
                0x2::table::add<u64, ExecutedListing<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&mut arg3.processed_listings, arg4, v30);
                let v31 = SaleExecuted{
                    version        : arg4,
                    buyer_profile  : v21,
                    seller_profile : v2,
                    price          : v29,
                };
                0x2::event::emit<SaleExecuted>(v31);
            };
            0x2::table::add<u64, vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>>(&mut arg3.available_bids, arg4, v5);
        };
        if (!v3) {
            let (v32, _, _, _, _, _, _, _, _, _) = destroy_listing(0x2::table::remove<u64, Listing>(&mut arg3.active_listings, arg4));
            let v42 = ExecutedListing<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>{
                listed_by_profile       : v2,
                hive_card               : 0x1::option::some<HiveCard>(v32),
                version                 : arg4,
                was_sale_listing        : true,
                balance                 : 0x1::option::none<0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(),
                bidder_profile          : v2,
                executed_price          : 0,
                borrow_period_start_sec : 0,
                borrow_period_end_sec   : 0,
            };
            0x2::table::add<u64, ExecutedListing<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&mut arg3.processed_listings, arg4, v42);
            let v43 = HighestBidListingUnsold{
                version           : arg4,
                listed_by_profile : v2,
            };
            0x2::event::emit<HighestBidListingUnsold>(v43);
        };
    }

    public entry fun process_highest_bid_sale_listings(arg0: &0x2::clock::Clock, arg1: &mut HiveProfileConfig, arg2: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg3: &mut MarketPlace<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0, 1079);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg4)) {
            process_highest_bid_sale_listing(arg0, arg1, arg2, arg3, *0x1::vector::borrow<u64>(&arg4, v0));
            v0 = v0 + 1;
        };
    }

    fun process_royalty(arg0: 0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg1: &mut HiveProfileConfig, arg2: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg3: address) : 0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI> {
        let v0 = (0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::math::mul_div_u128((0x2::balance::value<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&arg0) as u128), (arg1.royalty.numerator as u128), (arg1.royalty.denominator as u128)) as u64);
        let v1 = 0x2::balance::split<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut arg0, v0);
        let v2 = (0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::math::mul_div_u128((0x2::balance::value<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&v1) as u128), (arg1.royalty.cards_dispersal_percent as u128), (100 as u128)) as u64);
        let v3 = (0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::math::mul_div_u128((0x2::balance::value<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&v1) as u128), (arg1.royalty.creators_royalty_percent as u128), (100 as u128)) as u64);
        deposit_hsui_for_hive<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(arg2, 0x2::balance::split<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut v1, v2));
        0x2::balance::join<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(0x2::table::borrow_mut<address, 0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&mut arg1.creator_royalties, arg3), 0x2::balance::split<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut v1, v3));
        0x2::balance::join<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut arg1.buidlers_royalty, v1);
        let v4 = RoyaltyProcessed{
            total_royalty_amt         : v0,
            hive_dispersal_amt        : v2,
            creator_royalty_amt       : v3,
            accrued_to_fee_cap_holder : 0x2::balance::value<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&v1),
        };
        0x2::event::emit<RoyaltyProcessed>(v4);
        arg0
    }

    public fun process_subscription_payment(arg0: &0x2::clock::Clock, arg1: &HiveProfileConfig, arg2: &mut 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::config::GemsTreasury, arg3: &mut HiveProfile, arg4: &mut HiveProfile, arg5: &mut HiveDisperser, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x2::object::uid_to_address(&arg4.id);
        let v2 = 0x2::object::uid_to_address(&arg3.id);
        let v3 = 0x2::table::borrow_mut<address, Subscription>(&mut arg3.following_list, v1);
        let v4 = 0x2::table::borrow_mut<address, Subscription>(&mut arg4.followers_list, v2);
        assert!(v0 > v3.next_payment_timestamp, 1096);
        if (0x1::option::is_some<u64>(&v3.switch_to_plan)) {
            let v5 = *0x1::option::borrow<u64>(&v3.switch_to_plan);
            if (v5 == 10) {
                v3.is_active = false;
                v4.is_active = false;
            } else {
                let v6 = *0x1::option::borrow<u64>(&v3.switch_to_plan_price);
                v3.subscription_type = v5;
                v3.subscription_cost = v6;
                v3.switch_to_plan = 0x1::option::none<u64>();
                v3.switch_to_plan_price = 0x1::option::none<u64>();
                v4.subscription_type = v5;
                v4.subscription_cost = v6;
                v4.switch_to_plan = 0x1::option::none<u64>();
                v4.switch_to_plan_price = 0x1::option::none<u64>();
            };
            v3.switch_to_plan = 0x1::option::none<u64>();
            v4.switch_to_plan = 0x1::option::none<u64>();
        };
        assert!(v3.is_active, 1088);
        let v7 = *0x2::table::borrow<u8, u64>(&arg4.subscriptions, (v3.subscription_type as u8));
        assert!(v7 == v3.subscription_cost, 1094);
        0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::join(&mut arg4.available_gems, internal_process_subscription_payment(arg1, arg5, arg2, v2, v1, 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::split(&mut arg3.available_gems, v7), v3.subscription_type, v7));
        let v8 = calc_next_payment_timestamp(v0, v3.subscription_type);
        v3.next_payment_timestamp = v8;
        v3.total_paid = v3.total_paid + v7;
        v4.next_payment_timestamp = v8;
        v4.total_paid = v4.total_paid + v7;
    }

    public entry fun remove_card_upgrade_from_kiosk(arg0: &mut HiveProfile, arg1: &mut CreatorHiveKiosk, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.creator_profile, 1095);
        assert!(arg0.is_owned_obj || arg0.owner == 0x2::tx_context::sender(arg4), 1095);
        assert!(*0x2::table::borrow<u64, bool>(&arg1.krafted_versions_map, arg2), 1079);
        let CardUpgrade {
            upgrade_price       : _,
            followers_only      : _,
            upgrade_img_url     : v2,
            upgrade_traits_list : _,
            upgrade_prompts     : v4,
            added_traits_list   : _,
            added_prompts       : v6,
            removed_traits_list : _,
        } = 0x1::vector::remove<CardUpgrade>(0x2::table::borrow_mut<u64, vector<CardUpgrade>>(&mut arg1.available_upgrades, arg2), arg3);
        let v8 = v2;
        0x2::table::drop<0x1::string::String, 0x1::string::String>(v4);
        0x2::table::drop<0x1::string::String, 0x1::string::String>(v6);
        let v9 = RemovedUpgradeForVersion{
            hive_kiosk  : 0x2::object::uid_to_address(&arg1.id),
            version     : arg2,
            new_img_url : 0x1::string::from_ascii(0x2::url::inner_url(&v8)),
        };
        0x2::event::emit<RemovedUpgradeForVersion>(v9);
    }

    public entry fun remove_characters_attributes_from_record(arg0: &HiveProfileDeployerCap, arg1: &mut CreatorHiveKiosk, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u128>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 1079);
        assert!(arg1.aesthetic == arg2 && arg1.character == arg3, 1068);
        let v0 = 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::math::sort(arg4);
        let v1 = 0x1::vector::length<u128>(&v0) - 1;
        while (v1 >= 0) {
            let v2 = (*0x1::vector::borrow<u128>(&v0, v1) as u64);
            0x1::vector::remove<vector<0x1::string::String>>(&mut arg1.prompts_list, v2);
            0x1::vector::remove<0x1::string::String>(&mut arg1.url_list, v2);
            0x1::vector::remove<0x1::string::String>(&mut arg1.names_list, v2);
            v1 = v1 - 1;
        };
    }

    public fun remove_from_profile<T0: copy + drop + store, T1: store + key>(arg0: bool, arg1: &mut HiveProfile, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) : T1 {
        0x2::dynamic_object_field::remove<T0, T1>(&mut arg1.id, arg2)
    }

    public entry fun return_borrowed_hive_card(arg0: &0x2::clock::Clock, arg1: &mut HiveProfileConfig, arg2: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg3: &mut HiveDisperser, arg4: &mut HiveProfile, arg5: &mut HiveProfile, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0 && arg3.module_version == 0, 1079);
        let (v0, v1) = 0x1::vector::index_of<u64>(&arg4.lend_versions, &arg6);
        let (v2, v3) = 0x1::vector::index_of<u64>(&arg5.borrowed_versions, &arg6);
        assert!(v0 && v2, 1063);
        let v4 = 0x2::table::remove<u64, BorrowRecord>(&mut arg5.borrow_records, arg6);
        if (0x2::tx_context::sender(arg7) != arg5.owner) {
            assert!(v4.expiration_sec < 0x2::clock::timestamp_ms(arg0), 1063);
        };
        let v5 = &mut arg5.borrowed_versions;
        let (_, _, _, _, _) = destroy_borrow_record(v4, v5, v3);
        let (v11, v12) = withdraw_hive_card(arg0, arg1, arg2, arg3, arg5, arg6, false);
        let v13 = v11;
        0x2::balance::join<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut arg5.available_hsui, v12);
        v13.is_borrowed = false;
        deposit_hive_card(arg4, v13);
        let v14 = &mut arg4.lend_versions;
        let (_, _, _, _, _, _) = destroy_lend_record(0x2::table::remove<u64, LendRecord>(&mut arg4.lend_records, arg6), v14, v1);
        let v21 = ReturnBorrowedHiveCard{
            version  : arg6,
            owner    : arg4.owner,
            borrower : arg5.owner,
        };
        0x2::event::emit<ReturnBorrowedHiveCard>(v21);
    }

    public entry fun set_traits_in_hive_kiosk(arg0: &HiveProfileDeployerCap, arg1: &mut CreatorHiveKiosk, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.aesthetic == arg2 && arg1.character == arg3, 1068);
        assert!(arg1.krafted_cards == 0, 1077);
        arg1.traits_list = arg4;
    }

    fun stake_sui_for_hsui(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0x27e0df03aead8beed62eaf8e0bd299a4d6693886b5d88a1edf7d0e4453239e04::hsui_vault::HSuiVault, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>) {
        (arg2, 0x27e0df03aead8beed62eaf8e0bd299a4d6693886b5d88a1edf7d0e4453239e04::hsui_vault::stake_sui_request(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut arg2, arg3), 0x1::option::none<address>(), arg4))
    }

    fun sub_sign(arg0: u256, arg1: u256) : (u256, bool) {
        if (arg0 >= arg1) {
            return (arg0 - arg1, false)
        };
        (arg1 - arg0, true)
    }

    public entry fun switch_subscription(arg0: &0x2::clock::Clock, arg1: &mut HiveProfile, arg2: &mut HiveProfile, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_owned_obj || arg1.owner == 0x2::tx_context::sender(arg4), 1057);
        0x2::clock::timestamp_ms(arg0);
        let v0 = 0x2::object::uid_to_address(&arg2.id);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        let v2 = 0x2::table::borrow_mut<address, Subscription>(&mut arg1.following_list, v0);
        let v3 = 0x2::table::borrow_mut<address, Subscription>(&mut arg2.followers_list, v1);
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

    public entry fun transfer_hive_card(arg0: &0x2::clock::Clock, arg1: &mut HiveProfileConfig, arg2: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg3: &mut HiveDisperser, arg4: &mut HiveProfile, arg5: &mut HiveProfile, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0 && arg3.module_version == 0 && arg4.module_version == 0 && arg5.module_version == 0, 1079);
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(arg4.is_owned_obj || arg4.owner == v0, 1057);
        let (v1, v2) = withdraw_hive_card(arg0, arg1, arg2, arg3, arg4, arg6, false);
        let v3 = v1;
        0x2::balance::join<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut arg4.available_hsui, v2);
        assert!(!v3.is_borrowed, 1066);
        deposit_hive_card(arg5, v3);
        update_card_ownership(arg1, arg6, 0x2::object::uid_to_address(&arg5.id));
        let v4 = HiveCardTransfered{
            version : arg6,
            from    : v0,
            to      : arg5.owner,
        };
        0x2::event::emit<HiveCardTransfered>(v4);
    }

    public entry fun transfer_hive_gems(arg0: &mut HiveProfile, arg1: &mut HiveProfile, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 1079);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.is_owned_obj || arg0.owner == v0, 1057);
        0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::join(&mut arg1.available_gems, 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::split(&mut arg0.available_gems, arg2));
        let v1 = HiveGemsTransfered{
            from             : v0,
            to               : arg1.owner,
            gems_transferred : arg2,
        };
        0x2::event::emit<HiveGemsTransfered>(v1);
    }

    public entry fun unfollow_profile(arg0: &0x2::clock::Clock, arg1: &mut HiveProfile, arg2: &mut HiveProfile, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_owned_obj || arg1.owner == 0x2::tx_context::sender(arg3), 1057);
        let v0 = 0x2::object::uid_to_address(&arg2.id);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        let v2 = 0x2::table::borrow_mut<address, Subscription>(&mut arg1.following_list, v0);
        let v3 = 0x2::table::borrow_mut<address, Subscription>(&mut arg2.followers_list, v1);
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

    public fun unlock_hivecard(arg0: &0x2::clock::Clock, arg1: &0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::config::HiveDaoCapability, arg2: &mut HiveProfileConfig, arg3: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg4: &mut HiveDisperser, arg5: &mut HiveProfile, arg6: u64) : u64 {
        assert!(arg2.module_version == 0 && arg3.module_version == 0 && arg4.module_version == 0 && arg5.module_version == 0, 1079);
        let v0 = 0x2::table::borrow<u64, HiveCard>(&arg5.hive_cards, arg6);
        assert!(v0.is_staked, 1085);
        assert!(v0.unlock_timestamp < 0x2::clock::timestamp_ms(arg0), 1089);
        let v1 = v0.power;
        let (v2, v3) = withdraw_hive_card(arg0, arg2, arg3, arg4, arg5, arg6, true);
        let v4 = v2;
        0x2::balance::join<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut arg5.available_hsui, v3);
        assert!(!v4.is_staked, 1091);
        deposit_hive_card(arg5, v4);
        v1
    }

    fun unstake_hive_card(arg0: &mut HiveProfileConfig, arg1: &mut HiveCard) {
        arg0.active_power = arg0.active_power - (arg1.power as u128);
        arg0.locked_cards = arg0.locked_cards - 1;
        let v0 = TotalActivePowerUpdated{new_total_active_power: arg0.active_power};
        0x2::event::emit<TotalActivePowerUpdated>(v0);
        arg1.is_staked = false;
        arg1.power = 0;
        arg1.lockup_duration = 0;
    }

    fun update_bid_among_bids(arg0: &mut vector<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg5: bool, arg6: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(arg0)) {
            let v1 = 0x1::vector::borrow<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(arg0, v0);
            if (v1.bidder_profile == arg1) {
                assert!(v1.is_valid, 1069);
                let (v2, _, _, _, _, _) = destroy_bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(0x1::vector::remove<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(arg0, v0), arg6);
                0x2::balance::join<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(arg4, v2);
                let v8 = Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>{
                    bidder_profile  : arg1,
                    balance         : 0x2::balance::split<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(arg4, arg2),
                    offer_price     : arg2,
                    expiration_sec  : arg3,
                    is_listing_live : arg5,
                    is_valid        : true,
                };
                0x1::vector::push_back<Bid<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(arg0, v8);
                return
            };
            v0 = v0 + 1;
        };
    }

    fun update_bid_record(arg0: &mut BidRecord, arg1: u64, arg2: u64, arg3: u64) {
        arg0.offer_price = arg1;
        if (arg2 > arg3) {
            assert!(arg2 - arg3 < 7776000000, 1030);
            arg0.expiration_sec = arg2;
        };
    }

    fun update_card_ownership(arg0: &mut HiveProfileConfig, arg1: u64, arg2: address) {
        if (0x2::table::contains<u64, address>(&arg0.cards_to_profile_mapping, arg1)) {
            0x2::table::remove<u64, address>(&mut arg0.cards_to_profile_mapping, arg1);
        };
        0x2::table::add<u64, address>(&mut arg0.cards_to_profile_mapping, arg1, arg2);
    }

    public entry fun update_creator_kiosk(arg0: &HiveProfileDeployerCap, arg1: &mut CreatorHiveKiosk, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        arg1.creator_profile = arg2;
        arg1.aesthetic = arg3;
        arg1.character = arg4;
        arg1.img_url = 0x2::url::new_unsafe(0x1::string::to_ascii(arg5));
        arg1.init_hive_gems = arg6;
        arg1.total_cards = arg7;
        arg1.base_price = arg8;
        arg1.curve_a = arg9;
    }

    public entry fun update_creator_profile_for_card(arg0: &BuidlersRoyaltyCollectionAbility, arg1: &mut HiveProfileConfig, arg2: &mut HiveProfile, arg3: u64, arg4: &mut HiveProfile, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::uid_to_address(&arg4.id);
        if (!0x2::table::contains<address, 0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&arg1.creator_royalties, v0)) {
            0x2::table::add<address, 0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>>(&mut arg1.creator_royalties, v0, 0x2::balance::zero<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>());
        };
        let v1 = 0x2::table::borrow_mut<u64, HiveCard>(&mut arg2.hive_cards, arg3);
        v1.creator_profile = v0;
        let v2 = CreatorProfileUpdatedForCard{
            version              : arg3,
            prev_creator_profile : v1.creator_profile,
            new_creator_profile  : v0,
        };
        0x2::event::emit<CreatorProfileUpdatedForCard>(v2);
    }

    public entry fun update_kiosk_followers_flag(arg0: &mut HiveProfile, arg1: &mut CreatorHiveKiosk, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.creator_profile, 1095);
        assert!(arg0.is_owned_obj || arg0.owner == 0x2::tx_context::sender(arg3), 1095);
        arg1.followers_only = arg2;
        let v0 = KioskFollowersOnlyFlagUpdated{
            hive_kiosk     : 0x2::object::uid_to_address(&arg1.id),
            followers_only : arg1.followers_only,
        };
        0x2::event::emit<KioskFollowersOnlyFlagUpdated>(v0);
    }

    public entry fun update_listing(arg0: &0x2::clock::Clock, arg1: &HiveProfileConfig, arg2: &mut MarketPlace<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg3: &mut HiveProfile, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0 && arg3.module_version == 0, 1079);
        let v0 = 0x2::clock::timestamp_ms(arg0);
        assert!(arg3.is_owned_obj || arg3.owner == 0x2::tx_context::sender(arg8), 1057);
        assert!(0x1::vector::contains<u64>(&arg3.listed_versions, &arg4), 1037);
        let v1 = 0x2::table::borrow_mut<u64, Listing>(&mut arg2.active_listings, arg4);
        let v2 = 0x2::table::borrow_mut<u64, ListingRecord>(&mut arg3.listing_records, arg4);
        assert!(v1.expiration_sec > v0, 1032);
        if (arg5 != 0) {
            v1.min_price = arg5;
            v2.min_price = arg5;
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
            followers_only    : v1.followers_only,
            min_price         : v1.min_price,
            lockup_duration   : v1.lockup_duration,
            start_sec         : v1.start_sec,
            expiration_sec    : v1.expiration_sec,
        };
        0x2::event::emit<ListingUpdated>(v3);
    }

    public fun update_profile_config_params(arg0: &0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::config::HiveDaoCapability, arg1: &mut HiveProfileConfig, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg1.module_version == 0, 1079);
        if (arg2 > 0) {
            assert!(5 <= arg2 && 500 >= arg2, 1082);
            arg1.config_params.max_bids_per_card = arg2;
        };
        if (arg3 > 0) {
            assert!(100000 <= arg3, 1081);
            arg1.config_params.min_bid_allowed = arg3;
        };
        if (arg4 > 0) {
            assert!(10000000 <= arg4 && 50000000000 >= arg4, 1080);
            arg1.config_params.profile_kraft_fees = arg4;
        };
        let v0 = ProfileConfigParamsUpdated{
            max_bids_per_card  : arg1.config_params.max_bids_per_card,
            min_bid_allowed    : arg1.config_params.min_bid_allowed,
            profile_kraft_fees : arg1.config_params.profile_kraft_fees,
        };
        0x2::event::emit<ProfileConfigParamsUpdated>(v0);
    }

    public fun update_royalty(arg0: &0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::config::HiveDaoCapability, arg1: &mut HiveProfileConfig, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        assert!(arg1.module_version == 0, 1079);
        if (arg2 > 0 && arg3 > 0) {
            let v0 = 100 * arg2 / arg3;
            assert!(1 <= v0 && v0 <= 7, 1035);
            arg1.royalty.numerator = arg2;
            arg1.royalty.denominator = arg3;
        };
        if (arg4 > 0) {
            assert!(arg4 <= 25, 1036);
            arg1.royalty.cards_dispersal_percent = arg4;
        };
        if (arg5 > 0) {
            assert!(arg5 <= 50, 1036);
            arg1.royalty.creators_royalty_percent = arg5;
        };
        if (arg2 > 0 && arg3 > 0 || arg4 > 0) {
            let v1 = KraftRoyaltyUpdated{
                royalty_num              : arg1.royalty.numerator,
                royalty_denom            : arg1.royalty.denominator,
                cards_dispersal_percent  : arg1.royalty.cards_dispersal_percent,
                creators_royalty_percent : arg1.royalty.creators_royalty_percent,
            };
            0x2::event::emit<KraftRoyaltyUpdated>(v1);
        };
    }

    public fun update_subscription_pricing(arg0: &HiveProfileConfig, arg1: &mut HiveDisperser, arg2: &mut HiveProfile, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.is_owned_obj || arg2.owner == 0x2::tx_context::sender(arg6), 1057);
        increment_gems_global_index(arg0, arg1);
        deposit_gems_for_hive(arg1, 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::split(&mut arg2.available_gems, arg0.config_params.social_param_update_fee));
        0x2::table::remove<u8, u64>(&mut arg2.subscriptions, 1);
        0x2::table::add<u8, u64>(&mut arg2.subscriptions, 1, arg3);
        0x2::table::remove<u8, u64>(&mut arg2.subscriptions, 3);
        0x2::table::add<u8, u64>(&mut arg2.subscriptions, 3, arg4);
        0x2::table::remove<u8, u64>(&mut arg2.subscriptions, 12);
        0x2::table::add<u8, u64>(&mut arg2.subscriptions, 12, arg5);
        let v0 = SubscriptionPlanUpdated{
            profile_addr             : 0x2::object::uid_to_address(&arg2.id),
            username                 : 0x1::string::from_ascii(arg2.username),
            new_one_month_sub_cost   : arg3,
            new_three_month_sub_cost : arg4,
            new_one_year_sub_cost    : arg5,
        };
        0x2::event::emit<SubscriptionPlanUpdated>(v0);
    }

    public fun update_username(arg0: &HiveProfileConfig, arg1: &mut HiveProfileMappingStore, arg2: &mut HiveDisperser, arg3: &mut HiveProfile, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.is_owned_obj || arg3.owner == 0x2::tx_context::sender(arg5), 1057);
        assert!(is_valid_profile_name(arg4), 1084);
        increment_gems_global_index(arg0, arg2);
        deposit_gems_for_hive(arg2, 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::split(&mut arg3.available_gems, arg0.config_params.social_param_update_fee));
        let v0 = 0x1::string::to_ascii(arg4);
        0x2::table::remove<0x1::ascii::String, 0x2::object::ID>(&mut arg1.hive_profile_names, arg3.username);
        arg3.username = v0;
        0x2::table::add<0x1::ascii::String, 0x2::object::ID>(&mut arg1.hive_profile_names, v0, 0x2::object::uid_to_inner(&arg3.id));
        let v1 = UserNameUpdated{
            profile_addr  : 0x2::object::uid_to_address(&arg3.id),
            prev_username : 0x1::string::from_ascii(arg3.username),
            new_username  : arg4,
        };
        0x2::event::emit<UserNameUpdated>(v1);
    }

    public entry fun upgrade_card_via_kiosk(arg0: &0x2::clock::Clock, arg1: &HiveProfileConfig, arg2: &mut HiveDisperser, arg3: &mut 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::config::GemsTreasury, arg4: &mut HiveProfile, arg5: &mut HiveProfile, arg6: &mut CreatorHiveKiosk, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::uid_to_address(&arg4.id);
        assert!(v0 == arg6.creator_profile, 1095);
        assert!(*0x2::table::borrow<u64, bool>(&arg6.krafted_versions_map, arg7), 1079);
        assert!(arg5.is_owned_obj || arg5.owner == 0x2::tx_context::sender(arg9), 1057);
        increment_gems_global_index(arg1, arg2);
        let v1 = 0x2::table::remove<u64, vector<CardUpgrade>>(&mut arg6.available_upgrades, arg7);
        let v2 = 0x1::vector::remove<CardUpgrade>(&mut v1, arg8);
        0x2::table::add<u64, vector<CardUpgrade>>(&mut arg6.available_upgrades, arg7, v1);
        if (v2.followers_only) {
            assert!(0x2::table::contains<address, Subscription>(&arg5.following_list, v0), 1099);
            let v3 = 0x2::table::borrow<address, Subscription>(&arg5.following_list, v0);
            assert!(0x2::clock::timestamp_ms(arg0) < v3.next_payment_timestamp && v3.is_active, 1088);
        };
        let v4 = 0x2::table::borrow_mut<u64, HiveCard>(&mut arg5.hive_cards, arg7);
        v4.img_url = v2.upgrade_img_url;
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x1::string::String>(&v4.traits_list)) {
            let v6 = *0x1::vector::borrow<0x1::string::String>(&v4.traits_list, v5);
            if (0x1::vector::contains<0x1::string::String>(&v2.upgrade_traits_list, &v6)) {
                *0x2::table::borrow_mut<0x1::string::String, 0x1::string::String>(&mut v4.prompts, v6) = *0x2::table::borrow<0x1::string::String, 0x1::string::String>(&v2.upgrade_prompts, v6);
            };
            v5 = v5 + 1;
        };
        let v7 = 0;
        while (v7 < 0x1::vector::length<0x1::string::String>(&v2.added_traits_list)) {
            let v8 = *0x1::vector::borrow<0x1::string::String>(&v2.added_traits_list, v7);
            0x1::vector::push_back<0x1::string::String>(&mut v4.traits_list, v8);
            0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v4.prompts, v8, *0x2::table::borrow<0x1::string::String, 0x1::string::String>(&v2.added_prompts, v8));
            v7 = v7 + 1;
        };
        let v9 = 0;
        while (v9 < 0x1::vector::length<0x1::string::String>(&v2.removed_traits_list)) {
            let v10 = *0x1::vector::borrow<0x1::string::String>(&v2.removed_traits_list, v9);
            let (v11, v12) = 0x1::vector::index_of<0x1::string::String>(&v4.traits_list, &v10);
            if (v11) {
                0x1::vector::remove<0x1::string::String>(&mut v4.traits_list, v12);
                0x2::table::remove<0x1::string::String, 0x1::string::String>(&mut v4.prompts, v10);
            };
            v9 = v9 + 1;
        };
        let (v13, v14, v15) = process_gems_royalty(arg1, arg3, 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::split(&mut arg5.available_gems, v2.upgrade_price), arg2);
        0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::join(&mut arg4.available_gems, v13);
        let CardUpgrade {
            upgrade_price       : v16,
            followers_only      : _,
            upgrade_img_url     : _,
            upgrade_traits_list : _,
            upgrade_prompts     : v20,
            added_traits_list   : _,
            added_prompts       : v22,
            removed_traits_list : _,
        } = v2;
        0x2::table::drop<0x1::string::String, 0x1::string::String>(v20);
        0x2::table::drop<0x1::string::String, 0x1::string::String>(v22);
        let v24 = HiveCardUpgraded{
            version           : arg7,
            hive_kiosk        : 0x2::object::uid_to_address(&arg6.id),
            new_img_url       : 0x1::string::from_ascii(0x2::url::inner_url(&v4.img_url)),
            new_traits_list   : v4.traits_list,
            upgrade_price     : v16,
            total_royalty_amt : v14,
            gems_burnt        : v15,
        };
        0x2::event::emit<HiveCardUpgraded>(v24);
    }

    public fun withdraw_gems_from_profile(arg0: &mut HiveProfile, arg1: u64) : 0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::HiveGems {
        let v0 = GemWithdrawnFromProfile{
            profile_addr   : 0x2::object::uid_to_address(&arg0.id),
            withdrawn_gems : arg1,
        };
        0x2::event::emit<GemWithdrawnFromProfile>(v0);
        0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::split(&mut arg0.available_gems, arg1)
    }

    fun withdraw_hive_card(arg0: &0x2::clock::Clock, arg1: &mut HiveProfileConfig, arg2: &mut HSuiDisperser<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>, arg3: &mut HiveDisperser, arg4: &mut HiveProfile, arg5: u64, arg6: bool) : (HiveCard, 0x2::balance::Balance<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>) {
        let (v0, v1) = 0x1::vector::index_of<u64>(&arg4.available_versions, &arg5);
        assert!(v0, 1024);
        increment_global_index(arg1, arg2);
        increment_gems_global_index(arg1, arg3);
        let v2 = 0x2::table::borrow_mut<u64, HiveCard>(&mut arg4.hive_cards, arg5);
        let v3 = 0x2::balance::zero<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>();
        if (arg6) {
            assert!(v2.is_staked && v2.unlock_timestamp < 0x2::clock::timestamp_ms(arg0), 1067);
            let (v4, v5, v6) = claim_accrued_rewards_for_card(arg0, arg1, arg2, arg3, v2);
            0x2::balance::join<0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hsui::HSUI>(&mut v3, v5);
            0xf7d07d53cf2996ec31c7df19a58420bf0614735a25a7db62a27f39ec973ae612::hive_gems::join(&mut arg4.available_gems, v4);
            if (v6) {
                let v7 = HiveCardUnstaked{
                    profile_addr : 0x2::object::uid_to_address(&arg4.id),
                    version      : arg5,
                };
                0x2::event::emit<HiveCardUnstaked>(v7);
            };
        } else {
            assert!(!v2.is_staked, 1021);
        };
        0x1::vector::remove<u64>(&mut arg4.available_versions, v1);
        (0x2::table::remove<u64, HiveCard>(&mut arg4.hive_cards, arg5), v3)
    }

    // decompiled from Move bytecode v6
}

