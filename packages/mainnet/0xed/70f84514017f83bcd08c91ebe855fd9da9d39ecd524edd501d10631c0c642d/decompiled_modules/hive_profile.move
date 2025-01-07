module 0xcfc06c5e96b2a09666851de57669afcf97bc9bb7dd5ac50ea3dbe801c9f24772::hive_profile {
    struct HIVE_PROFILE has drop {
        dummy_field: bool,
    }

    struct HiveAppAccessCapability has store, key {
        id: 0x2::object::UID,
        app_name: 0x1::ascii::String,
        only_owner_can_add_app: bool,
        only_owner_can_access_app: bool,
        only_owner_can_remove_app: bool,
    }

    struct ManagerAppAccessCapability has store, key {
        id: 0x2::object::UID,
        app_name: 0x1::ascii::String,
    }

    struct TwapUpdateCap has store, key {
        id: 0x2::object::UID,
    }

    struct HiveProfileMappingStore has key {
        id: 0x2::object::UID,
        owner_to_profile_mapping: 0x2::linked_table::LinkedTable<address, address>,
        username_to_profile_mapping: 0x2::linked_table::LinkedTable<0x1::ascii::String, address>,
        username_to_comp_profile_mapping: 0x2::linked_table::LinkedTable<0x1::ascii::String, address>,
        suins_name_to_expiry_mapping: 0x2::linked_table::LinkedTable<0x1::ascii::String, u64>,
        profile_to_creator_kiosk_mapping: 0x2::linked_table::LinkedTable<address, vector<address>>,
        app_names_to_cap_mapping: 0x2::linked_table::LinkedTable<0x1::ascii::String, address>,
        kiosk_names_mapping: 0x2::linked_table::LinkedTable<0x1::ascii::String, address>,
        reserved_usernames_to_accessor_mapping: 0x2::linked_table::LinkedTable<0x1::ascii::String, address>,
        module_version: u64,
    }

    struct HiveManager has store, key {
        id: 0x2::object::UID,
        hive_profile: HiveProfile,
        config_params: ConfigParams,
        active_assets: u64,
        locked_assets: u64,
        assets_to_profile_mapping: 0x2::linked_table::LinkedTable<u64, address>,
        active_power: u128,
        supported_lockup_durations: 0x2::table::Table<u8, u64>,
        royalty: Royalty,
        gems_royalty: SubscriptionRoyalty,
        hive_twap: HiveTwapInfo,
        buidlers_royalty: 0x2::balance::Balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>,
        kiosk_earnings: 0x2::linked_table::LinkedTable<address, KioskEarnings>,
        keeper_accounts: 0x2::linked_table::LinkedTable<address, bool>,
        builder_hive_assets: u64,
        launch_caps_initialized: bool,
        module_version: u64,
    }

    struct KioskEarnings has store {
        liquidity_pool: 0x2::balance::Balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>,
        creator_earnings: 0x2::balance::Balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>,
        nfts_count: u64,
    }

    struct HiveTwapInfo has copy, store {
        last_update_timestamp: u64,
        hive_sui_twap: u256,
        sui_usdc_twap: u256,
        hive_usdc_twap: u256,
    }

    struct HiveDisperser has store, key {
        id: 0x2::object::UID,
        incoming_gems_for_assets: 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::HiveGems,
        gems_for_assets: 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::HiveGems,
        global_dispersal_index: u256,
        module_version: u64,
    }

    struct DSuiDisperser<phantom T0> has store, key {
        id: 0x2::object::UID,
        incoming_dsui_for_assets: 0x2::balance::Balance<T0>,
        dsui_for_assets: 0x2::balance::Balance<T0>,
        global_dispersal_index: u256,
        module_version: u64,
    }

    struct HiveProfile has store, key {
        id: 0x2::object::UID,
        username: 0x1::ascii::String,
        bio: 0x1::string::String,
        inscription: 0x2::linked_table::LinkedTable<u64, Inscription>,
        creation_timestamp: u64,
        owner: address,
        is_composable_profile: bool,
        beehive_plan: 0x2::table::Table<u8, u64>,
        subscribers_list: 0x2::linked_table::LinkedTable<address, AccessRecord>,
        subscriptions_list: 0x2::linked_table::LinkedTable<address, AccessRecord>,
        available_gems: 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::HiveGems,
        available_dsui: 0x2::balance::Balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>,
        last_active_epoch: u64,
        entropy_used_for_cur_epoch: u64,
        hive_assets: 0x2::linked_table::LinkedTable<u64, HiveAsset>,
        incoming_bids: 0x2::linked_table::LinkedTable<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>,
        borrow_records: 0x2::linked_table::LinkedTable<u64, BorrowRecord>,
        listing_records: 0x2::linked_table::LinkedTable<u64, ListingRecord>,
        bid_records: 0x2::linked_table::LinkedTable<u64, BidRecord>,
        lend_records: 0x2::linked_table::LinkedTable<u64, LendRecord>,
        installed_apps: vector<0x1::ascii::String>,
        module_version: u64,
    }

    struct MarketPlace<phantom T0> has store, key {
        id: 0x2::object::UID,
        active_listings: 0x2::linked_table::LinkedTable<u64, Listing>,
        available_bids: 0x2::linked_table::LinkedTable<u64, vector<Bid<T0>>>,
        processed_listings: 0x2::linked_table::LinkedTable<u64, ExecutedListing<T0>>,
        module_version: u64,
    }

    struct HiveKiosk has store, key {
        id: 0x2::object::UID,
        creator_profile: address,
        collection_name: 0x1::string::String,
        img_url: 0x2::url::Url,
        traits_list: vector<0x1::string::String>,
        max_assets_limit: u64,
        krafted_assets: u64,
        base_price: u64,
        curve_a: u64,
        pool_pct: u64,
        prompts_list: vector<vector<0x1::string::String>>,
        url_list: vector<0x1::string::String>,
        names_list: vector<0x1::string::String>,
        krafted_versions_map: 0x2::linked_table::LinkedTable<u64, address>,
        kraft_access: u8,
        discount_access: u8,
        discount: u64,
        available_upgrades: 0x2::linked_table::LinkedTable<u64, vector<AssetUpgrade>>,
        module_version: u64,
    }

    struct HiveAsset has store, key {
        id: 0x2::object::UID,
        version: u64,
        power: u64,
        kiosk_addr: address,
        name: 0x1::string::String,
        img_url: 0x2::url::Url,
        collection_name: 0x1::string::String,
        prompts: 0x2::linked_table::LinkedTable<0x1::string::String, 0x1::string::String>,
        is_borrowed: bool,
        is_staked: bool,
        lockup_duration: u8,
        unlock_timestamp: u64,
        available_gems: 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::HiveGems,
        claim_index: u256,
        hive_claim_index: u256,
        total_dsui_claimed: u64,
        total_gems_claimed: u64,
        active_apps: vector<0x1::ascii::String>,
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
        min_dsui_bid_allowed: u64,
        profile_kraft_fees_sui: u64,
        social_fee_gems: u64,
        social_multiplier_for_gems: u64,
        social_multiplier_for_power: u64,
    }

    struct AssetUpgrade has store {
        upgrade_price: u64,
        upgrade_access: u8,
        upgrade_img_url: 0x2::url::Url,
        upgrade_traits_list: vector<0x1::string::String>,
        upgrade_prompts: 0x2::table::Table<0x1::string::String, 0x1::string::String>,
    }

    struct PublicKraftConfig has store, key {
        id: 0x2::object::UID,
        start_time: u64,
        per_user_limit: u64,
        krafts_processed: u64,
        address_list: 0x2::linked_table::LinkedTable<address, u64>,
    }

    struct AccessRecord has copy, store {
        subscriber: address,
        subscribed_to: address,
        init_timestamp: u64,
        access_type: u8,
        access_cost: u64,
        next_payment_timestamp: u64,
        total_paid: u64,
        to_unsubscribe: bool,
    }

    struct Inscription has copy, drop, store {
        format: 0x1::string::String,
        base64: vector<0x1::string::String>,
    }

    struct Listing has store {
        listed_by_profile: address,
        hive_asset: HiveAsset,
        listing_access: u8,
        discount_access: u8,
        discount: u64,
        min_dsui_price: u64,
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
        executed_price_in_dsui: u64,
        borrow_period_start_sec: u64,
        borrow_period_end_sec: u64,
    }

    struct Bid<phantom T0> has store {
        bidder_profile: address,
        balance: 0x2::balance::Balance<T0>,
        offer_dsui_price: u64,
        expiration_sec: u64,
        is_listing_live: bool,
        is_valid: bool,
    }

    struct ListingRecord has store {
        version: u64,
        listing_access: u8,
        discount_access: u8,
        discount: u64,
        min_dsui_price: u64,
        is_sale_listing: bool,
        instant_sale: bool,
        highest_bid_sale: bool,
        lockup_duration: u8,
        start_sec: u64,
        expiration_sec: u64,
    }

    struct BidRecord has store {
        version: u64,
        offer_dsui_price: u64,
        expiration_sec: u64,
        is_asset_listed: bool,
    }

    struct LendRecord has store {
        borrower: address,
        version: u64,
        lend_price_dsui: u64,
        start_sec: u64,
        lockup_duration: u8,
        expiration_sec: u64,
    }

    struct BorrowRecord has store {
        owner: address,
        borrow_price_dsui: u64,
        start_sec: u64,
        lockup_duration: u8,
        expiration_sec: u64,
    }

    struct AppAddedToHiveStore has copy, drop {
        capability_addr: address,
        app_name: 0x1::ascii::String,
        only_owner_can_add_app: bool,
        only_owner_can_access_app: bool,
        only_owner_can_remove_app: bool,
    }

    struct UpdateEntropyForEpoch has copy, drop {
        username: 0x1::ascii::String,
        profile_addr: address,
        epoch: u64,
        max_entropy: u64,
        entropy_used_for_cur_epoch: u64,
        remaining_entropy: u64,
        max_withdrawable_gems: u64,
        available_gems: u64,
    }

    struct HiveKioskInitialized has copy, drop {
        kiosk_addr: address,
        creator_profile: address,
        time_stream: u64,
        collection_name: 0x1::string::String,
        img_url: 0x1::string::String,
        max_assets_limit: u64,
    }

    struct TraitsSetInHiveKiosk has copy, drop {
        kiosk_addr: address,
        creator_profile: address,
        collection_name: 0x1::string::String,
        traits_list: vector<0x1::string::String>,
        img_url: 0x1::string::String,
    }

    struct PublicKraftInitialized has copy, drop {
        collection_name: 0x1::string::String,
        kiosk_addr: address,
        creator_profile: address,
        creator_profile_username: 0x1::ascii::String,
        start_time: u64,
        per_user_limit: u64,
    }

    struct KraftYieldHarvested has copy, drop {
        dsui_yield: u64,
        receiver: address,
    }

    struct RoyaltyCollectedForCreator has copy, drop {
        kiosk_addr: address,
        creator_profile: address,
        username: 0x1::ascii::String,
        dsui_collected: u64,
        collection_name: 0x1::string::String,
    }

    struct ProfileConfigParamsUpdated has copy, drop {
        max_bids_per_asset: u64,
        min_dsui_bid_allowed: u64,
        profile_kraft_fees_sui: u64,
        social_fee_gems: u64,
        social_multiplier_for_gems: u64,
        social_multiplier_for_power: u64,
    }

    struct HiveProfileDestroyed has copy, drop {
        username: 0x1::ascii::String,
        profile_addr: address,
        owner: address,
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
        hive_total_active_power: u128,
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

    struct AppSupportAddedForAsset has copy, drop {
        profile_addr: address,
        version: u64,
        app_name: 0x1::ascii::String,
    }

    struct PricingAndAccessSetInHiveKiosk has copy, drop {
        creator_profile: address,
        collection_name: 0x1::string::String,
        base_price: u64,
        curve_a: u64,
        pool_pct: u64,
        kraft_access: u8,
        discount_access: u8,
        discount: u64,
    }

    struct HiveGemsPortedToApp has copy, drop {
        ported_by_profile: address,
        ported_by_username: 0x1::ascii::String,
        version: u64,
        app_name: 0x1::ascii::String,
        gems_ported: u64,
    }

    struct HiveAssetPortedToApp has copy, drop {
        ported_by_profile: address,
        ported_by_username: 0x1::ascii::String,
        version: u64,
        app_name: 0x1::ascii::String,
    }

    struct HiveAssetReturnedByApp has copy, drop {
        app_name: 0x1::ascii::String,
        recepient_profile: address,
        recepient_username: 0x1::ascii::String,
        version: u64,
    }

    struct DegenSuiAddedForHarvest has copy, drop {
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

    struct AssetPowerUpdated has copy, drop {
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
        collection_name: 0x1::string::String,
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
        dsui_harvested: u64,
        gems_harvested: u64,
    }

    struct BidMarkedInvalid has copy, drop {
        version: u64,
        bidder_profile: address,
    }

    struct NewListing has copy, drop {
        listed_by_profile: address,
        listing_access: u8,
        discount_access: u8,
        discount: u64,
        version: u64,
        min_dsui_price: u64,
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
        min_dsui_price: u64,
        lockup_duration: u8,
        start_sec: u64,
        expiration_sec: u64,
        listing_access: u8,
        discount_access: u8,
        discount: u64,
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
        offer_dsui_price: u64,
        expiration_sec: u64,
        is_asset_listed: bool,
    }

    struct BidDestroyed has copy, drop {
        asset_version: u64,
        bidder_profile: address,
    }

    struct AccessRecordDestroyed has copy, drop {
        subscriber_profile: address,
        subscribed_to_profile: address,
        init_timestamp: u64,
        total_paid: u64,
    }

    struct ListingDestroyed has copy, drop {
        version: u64,
        listed_by_profile: address,
    }

    struct SaleExecuted has copy, drop {
        version: u64,
        buyer_profile: address,
        seller_profile: address,
        price_paid_dsui: u64,
        is_sale_listing: bool,
        instant_sale: bool,
        highest_bid_sale: bool,
        is_direct_bid_accepted: bool,
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
        offer_dsui_price: u64,
        expiration_sec: u64,
    }

    struct BidCanceled has copy, drop {
        version: u64,
        bidder_profile: address,
        refund_dsui: u64,
    }

    struct BidExpired has copy, drop {
        version: u64,
        bidder_profile: address,
        refund_dsui: u64,
    }

    struct ExecutedListingDestroyed has copy, drop {
        version: u64,
        executed_price_in_dsui: u64,
        listed_by_profile: address,
    }

    struct HiveAssetBorrowed has copy, drop {
        version: u64,
        borrower_profile: address,
        lender_profile: address,
        borrow_price_dsui: u64,
        lockup_duration: u8,
        borrow_start_sec: u64,
        borrow_exp_sec: u64,
    }

    struct ReturnBorrowedHiveAsset has copy, drop {
        version: u64,
        owner: address,
        borrower_profile: address,
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
        dsui_harvested: u64,
        gems_harvested: u64,
    }

    struct DepositHSuiForProfile has copy, drop {
        profile_addr: address,
        dsui_deposited: u64,
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

    struct JoinedHiveOfProfile has copy, drop {
        subscriber_profile_addr: address,
        hive_owner_profile: address,
        subscriber_username: 0x1::string::String,
        hive_owner_username: 0x1::string::String,
        access_type: u8,
        access_cost: u64,
        next_payment_timestamp: u64,
    }

    struct HiveAccessPaymentProcessed has copy, drop {
        subscriber_profile_addr: address,
        hive_owner_profile: address,
        access_type: u8,
        access_cost: u64,
        hive_twap_price: u256,
        gems_to_transfer_amt: u64,
        total_royalty_amt: u64,
        treasury_amt: u64,
        gems_burnt: u64,
        next_payment_timestamp: u64,
    }

    struct AccessTypeSwitchedToNewPlan has copy, drop {
        subscriber_profile_addr: address,
        hive_owner_profile: address,
        subscriber_username: 0x1::string::String,
        hive_owner_username: 0x1::string::String,
        new_access_type: u8,
        new_access_cost: u64,
        subscription_price_to_pay: u64,
        hive_paid_for_switch: u64,
        next_payment_timestamp: u64,
    }

    struct ExitHiveOfProfile has copy, drop {
        subscriber_profile_addr: address,
        unsubscribed_from_profile_addr: address,
        subscriber_username: 0x1::string::String,
        unhive_owner_username: 0x1::string::String,
        records_deleted: bool,
    }

    struct HiveAccessPlanUpdated has copy, drop {
        profile_addr: address,
        username: 0x1::string::String,
        new_worker_access_cost: u64,
        new_drone_access_cost: u64,
        new_queen_access_cost: u64,
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

    struct HiveAssetUpgradedViaApp has copy, drop {
        version: u64,
        app_name: 0x1::ascii::String,
        new_img_url: 0x1::string::String,
        traits_to_upgrade: vector<0x1::string::String>,
        new_prompts: vector<0x1::string::String>,
    }

    struct RemovedUpgradeForVersion has copy, drop {
        creator_profile_addr: address,
        collection_name: 0x1::string::String,
        version: u64,
        upgrade_index: u64,
    }

    struct AddedNewUpgradeForVersion has copy, drop {
        profile_addr: address,
        collection_name: 0x1::string::String,
        version: u64,
        new_img_url: 0x1::string::String,
        upgrade_traits_list: vector<0x1::string::String>,
        upgrade_prompts_list: vector<0x1::string::String>,
        upgrade_access: u8,
        upgrade_price: u64,
    }

    struct KioskOwnershipTransferred has copy, drop {
        collection_name: 0x1::string::String,
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

    struct InscriptionSetForProfile has copy, drop {
        profile_addr: address,
        username: 0x1::string::String,
        format: 0x1::string::String,
        base64: vector<0x1::string::String>,
    }

    struct HiveTwapUpdated has copy, drop {
        timestamp: u64,
        hive_sui_twap: u256,
        sui_usdc_twap: u256,
        hive_usdc_twap: u256,
    }

    struct AppInstalledByProfile has copy, drop {
        profile_addr: address,
        username: 0x1::ascii::String,
        app_name: 0x1::ascii::String,
    }

    struct AssetsInsertedInHiveKiosk has copy, drop {
        creator_profile: address,
        kiosk_addr: address,
        collection_name: 0x1::string::String,
        assets_inserted: u64,
        url_list: vector<0x1::string::String>,
        names_list: vector<0x1::string::String>,
        prompts_list: vector<vector<0x1::string::String>>,
    }

    struct HiveAssetDestroyed has copy, drop {
        owner_profile: address,
        version: u64,
        collection_name: 0x1::string::String,
        name: 0x1::string::String,
        dsui_for_nft: u64,
    }

    struct HiveGemsWithdrawnAsset has copy, drop {
        profile_addr: address,
        version: u64,
        gems_withdrawn: u64,
        total_royalty_amt: u64,
        gems_withdrawn_after_royalty: u64,
        treasury_amt: u64,
        gems_burnt: u64,
    }

    struct HiveWithdrawnFromTreasury has copy, drop {
        hive_withdrawn: u64,
    }

    struct HiveAddedToTreasury has copy, drop {
        hive_added: u64,
        total_hive_in_treasury: u64,
    }

    public entry fun accept_bid(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &mut DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg3: &mut MarketPlace<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg4: &mut HiveProfile, arg5: &mut HiveProfile, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0 && arg3.module_version == 0, 1079);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::clock::timestamp_ms(arg0);
        authority_check(arg4, v0);
        assert!(0x2::linked_table::contains<u64, ListingRecord>(&arg4.listing_records, arg6), 1045);
        let v2 = 0x2::linked_table::remove<u64, ListingRecord>(&mut arg4.listing_records, arg6);
        assert!(v2.expiration_sec > v1, 1032);
        let (_, _, _, _, _, _, _, _, _, _, _) = destroy_listing_record(v2);
        let v14 = 0x2::linked_table::remove<u64, BidRecord>(&mut arg5.bid_records, arg6);
        assert!(v14.expiration_sec > v1, 1071);
        let (_, _, _, _) = destroy_bid_record(v14);
        let v19 = 0x2::balance::zero<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>();
        let v20 = &mut v19;
        let (v21, v22) = execute_sale(arg1, arg3, arg2, arg6, true, 0x2::object::uid_to_address(&arg5.id), 0, v20);
        let v23 = v22;
        0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut arg4.available_dsui, 0x1::option::extract<0x2::balance::Balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(&mut v23.balance));
        update_asset_ownership(arg1, arg6, 0x2::object::uid_to_address(&arg5.id), false);
        deposit_hive_asset(arg5, v21);
        let (_, v25, _, _, v28, _, _, _, _) = destroy_executed_listing<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(v23);
        0x1::option::destroy_none<HiveAsset>(v25);
        0x1::option::destroy_none<0x2::balance::Balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(v28);
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::destroy_or_transfer_balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(v19, v0, arg7);
    }

    public entry fun accept_direct_bid(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &mut DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg3: &mut HiveDisperser, arg4: &mut HiveProfile, arg5: &mut HiveProfile, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0 && arg3.module_version == 0, 1079);
        let v0 = 0x2::object::uid_to_address(&arg5.id);
        let v1 = 0x2::object::uid_to_address(&arg4.id);
        assert!(arg4.is_composable_profile || arg4.owner == 0x2::tx_context::sender(arg7), 1057);
        assert!(0x2::linked_table::contains<u64, HiveAsset>(&arg4.hive_assets, arg6), 1064);
        assert!(0x2::linked_table::contains<u64, BidRecord>(&arg5.bid_records, arg6), 1033);
        let v2 = 0x2::linked_table::remove<u64, BidRecord>(&mut arg5.bid_records, arg6);
        assert!(v2.expiration_sec > 0x2::clock::timestamp_ms(arg0), 1071);
        let (v3, v4) = withdraw_hive_asset(arg0, arg1, arg2, arg3, arg4, arg6, false);
        let v5 = v3;
        0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut arg4.available_dsui, v4);
        let v6 = 0;
        let v7 = v6;
        let v8 = 0x2::balance::zero<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>();
        let v9 = 0x2::linked_table::remove<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(&mut arg4.incoming_bids, arg6);
        let v10 = 0;
        while (v10 < 0x1::vector::length<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(&v9)) {
            let v11 = 0x1::vector::borrow_mut<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(&mut v9, v10);
            if (v11.bidder_profile == v0) {
                let v12 = 0x1::vector::remove<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(&mut v9, v10);
                assert!(v12.is_valid, 1072);
                let (v13, _, v15, _, _, _) = destroy_bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(v12, arg6);
                if (v6 == 0) {
                    v7 = v15;
                };
                0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut v8, v13);
                break
            };
            v11.is_valid = false;
            v10 = v10 + 1;
        };
        0x2::linked_table::push_back<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(&mut arg4.incoming_bids, arg6, v9);
        let (_, _, _, _) = destroy_bid_record(v2);
        let v23 = v8;
        v8 = process_royalty(v23, arg1, arg2, v5.kiosk_addr);
        0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut arg4.available_dsui, v8);
        update_asset_ownership(arg1, arg6, v0, false);
        deposit_hive_asset(arg5, v5);
        let v24 = SaleExecuted{
            version                : arg6,
            buyer_profile          : v0,
            seller_profile         : v1,
            price_paid_dsui        : v7,
            is_sale_listing        : false,
            instant_sale           : false,
            highest_bid_sale       : false,
            is_direct_bid_accepted : true,
        };
        0x2::event::emit<SaleExecuted>(v24);
    }

    public fun add_app_support_to_asset(arg0: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::HiveDaoCapability, arg1: &HiveAppAccessCapability, arg2: &mut HiveProfile, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.module_version == 0, 1079);
        authority_check(arg2, 0x2::tx_context::sender(arg4));
        assert!(exists_for_profile(arg2, arg1.app_name), 1144);
        let v0 = 0x2::linked_table::borrow_mut<u64, HiveAsset>(&mut arg2.hive_assets, arg3);
        assert!(!0x1::vector::contains<0x1::ascii::String>(&v0.active_apps, &arg1.app_name), 1125);
        0x1::vector::push_back<0x1::ascii::String>(&mut v0.active_apps, arg1.app_name);
        let v1 = AppSupportAddedForAsset{
            profile_addr : 0x2::object::uid_to_address(&arg2.id),
            version      : arg3,
            app_name     : arg1.app_name,
        };
        0x2::event::emit<AppSupportAddedForAsset>(v1);
    }

    public fun add_app_to_hive_store(arg0: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::HiveDaoCapability, arg1: &mut HiveProfileMappingStore, arg2: 0x1::ascii::String, arg3: bool, arg4: bool, arg5: bool, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<HiveAppAccessCapability>(internal_add_app_to_hive_store(arg1, arg2, arg3, arg4, arg5, arg7), arg6);
    }

    public fun add_app_to_manager_profile<T0: store + key>(arg0: &ManagerAppAccessCapability, arg1: &mut HiveManager, arg2: T0) {
        0x2::dynamic_object_field::add<0x1::ascii::String, T0>(&mut arg1.hive_profile.id, arg0.app_name, arg2);
    }

    public fun add_app_to_profile<T0: store + key>(arg0: &HiveAppAccessCapability, arg1: &mut HiveProfile, arg2: T0, arg3: &0x2::tx_context::TxContext) {
        0x2::dynamic_object_field::add<0x1::ascii::String, T0>(&mut arg1.id, arg0.app_name, arg2);
    }

    public fun add_asset_upgrade_to_kiosk(arg0: &mut HiveProfile, arg1: 0x1::string::String, arg2: u64, arg3: u8, arg4: u64, arg5: 0x1::string::String, arg6: vector<0x1::string::String>, arg7: vector<0x1::string::String>, arg8: &mut 0x2::tx_context::TxContext) {
        authority_check(arg0, 0x2::tx_context::sender(arg8));
        let v0 = get_kiosk_app_name(arg1);
        let v1 = remove_from_profile<HiveKiosk>(arg0, v0);
        assert!(0x2::linked_table::contains<u64, address>(&v1.krafted_versions_map, arg2), 1079);
        assert!(0x1::vector::length<0x1::string::String>(&arg6) == 0x1::vector::length<0x1::string::String>(&arg7), 1051);
        let v2 = AssetUpgrade{
            upgrade_price       : arg4,
            upgrade_access      : arg3,
            upgrade_img_url     : 0x2::url::new_unsafe(0x1::string::to_ascii(arg5)),
            upgrade_traits_list : arg6,
            upgrade_prompts     : 0x2::table::new<0x1::string::String, 0x1::string::String>(arg8),
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::string::String>(&arg6)) {
            0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v2.upgrade_prompts, *0x1::vector::borrow<0x1::string::String>(&arg6, v3), *0x1::vector::borrow<0x1::string::String>(&arg7, v3));
            v3 = v3 + 1;
        };
        if (!0x2::linked_table::contains<u64, vector<AssetUpgrade>>(&v1.available_upgrades, arg2)) {
            let v4 = 0x1::vector::empty<AssetUpgrade>();
            0x1::vector::push_back<AssetUpgrade>(&mut v4, v2);
            0x2::linked_table::push_back<u64, vector<AssetUpgrade>>(&mut v1.available_upgrades, arg2, v4);
        } else {
            let v5 = 0x2::linked_table::remove<u64, vector<AssetUpgrade>>(&mut v1.available_upgrades, arg2);
            0x1::vector::push_back<AssetUpgrade>(&mut v5, v2);
            0x2::linked_table::push_back<u64, vector<AssetUpgrade>>(&mut v1.available_upgrades, arg2, v5);
        };
        let v6 = AddedNewUpgradeForVersion{
            profile_addr         : 0x2::object::uid_to_address(&arg0.id),
            collection_name      : arg1,
            version              : arg2,
            new_img_url          : arg5,
            upgrade_traits_list  : arg6,
            upgrade_prompts_list : arg7,
            upgrade_access       : arg3,
            upgrade_price        : arg4,
        };
        0x2::event::emit<AddedNewUpgradeForVersion>(v6);
        add_to_profile<HiveKiosk>(arg0, v0, v1);
    }

    fun add_bid_record_to_profile(arg0: &mut HiveProfile, arg1: u64, arg2: BidRecord) {
        0x2::linked_table::push_back<u64, BidRecord>(&mut arg0.bid_records, arg1, arg2);
    }

    fun add_bid_to_table(arg0: &mut 0x2::linked_table::LinkedTable<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>, arg1: u64, arg2: Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg3: u64) {
        if (0x2::linked_table::contains<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(arg0, arg1)) {
            let v0 = 0x2::linked_table::borrow_mut<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(arg0, arg1);
            assert!(0x1::vector::length<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(v0) < arg3, 1078);
            0x1::vector::push_back<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(v0, arg2);
        } else {
            let v1 = 0x1::vector::empty<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>();
            0x1::vector::push_back<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(&mut v1, arg2);
            0x2::linked_table::push_back<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(arg0, arg1, v1);
        };
    }

    public fun add_store_to_asset<T0: store + key>(arg0: &HiveAppAccessCapability, arg1: &mut HiveAsset, arg2: T0) {
        let (v0, _) = 0x1::vector::index_of<0x1::ascii::String>(&arg1.active_apps, &arg0.app_name);
        assert!(v0, 1115);
        0x2::dynamic_object_field::add<0x1::ascii::String, T0>(&mut arg1.id, arg0.app_name, arg2);
    }

    public fun add_time_stream_app(arg0: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::HiveGemKraftCap, arg1: &mut HiveProfileMappingStore, arg2: 0x1::ascii::String, arg3: bool, arg4: bool, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : HiveAppAccessCapability {
        internal_add_app_to_hive_store(arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun add_to_composable_profile<T0: store + key>(arg0: &mut HiveProfile, arg1: 0x1::ascii::String, arg2: T0) {
        assert!(arg0.is_composable_profile, 1116);
        if (!0x1::vector::contains<0x1::ascii::String>(&arg0.installed_apps, &arg1)) {
            0x1::vector::push_back<0x1::ascii::String>(&mut arg0.installed_apps, arg1);
            let v0 = AppInstalledByProfile{
                profile_addr : 0x2::object::uid_to_address(&arg0.id),
                username     : arg0.username,
                app_name     : arg1,
            };
            0x2::event::emit<AppInstalledByProfile>(v0);
        };
        0x2::dynamic_object_field::add<0x1::ascii::String, T0>(&mut arg0.id, arg1, arg2);
    }

    fun add_to_profile<T0: store + key>(arg0: &mut HiveProfile, arg1: 0x1::ascii::String, arg2: T0) {
        let (v0, _) = 0x1::vector::index_of<0x1::ascii::String>(&arg0.installed_apps, &arg1);
        assert!(v0, 1115);
        0x2::dynamic_object_field::add<0x1::ascii::String, T0>(&mut arg0.id, arg1, arg2);
    }

    fun authority_check(arg0: &HiveProfile, arg1: address) {
        assert!(arg0.is_composable_profile || arg0.owner == arg1, 1057);
    }

    public fun bee_hive_access_info(arg0: &0x2::clock::Clock, arg1: &HiveProfile, arg2: address) : (bool, u64, u8, u64, u64, u64, bool) {
        let v0 = false;
        let v1 = v0;
        if (0x2::linked_table::contains<address, AccessRecord>(&arg1.subscribers_list, arg2)) {
            let v9 = 0x2::linked_table::borrow<address, AccessRecord>(&arg1.subscribers_list, arg2);
            if (v9.access_type == 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::forever_subscribe_plan() || v9.next_payment_timestamp > 0x2::clock::timestamp_ms(arg0) || v9.access_cost == 0) {
                v1 = true;
            };
            (v1, v9.init_timestamp, v9.access_type, v9.access_cost, v9.next_payment_timestamp, v9.total_paid, v9.to_unsubscribe)
        } else {
            (v0, 0, 0, 0, 0, 0, false)
        }
    }

    public fun borrow_app_from_profile<T0: store + key>(arg0: &HiveAppAccessCapability, arg1: &mut HiveProfile, arg2: &0x2::tx_context::TxContext) : &mut T0 {
        0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, T0>(&mut arg1.id, arg0.app_name)
    }

    public fun borrow_from_admin_profile<T0: store + key>(arg0: &HiveManager, arg1: 0x1::ascii::String) : &T0 {
        0x2::dynamic_object_field::borrow<0x1::ascii::String, T0>(&arg0.hive_profile.id, arg1)
    }

    public fun borrow_from_profile<T0: store + key>(arg0: &HiveProfile, arg1: 0x1::ascii::String) : &T0 {
        0x2::dynamic_object_field::borrow<0x1::ascii::String, T0>(&arg0.id, arg1)
    }

    public entry fun borrow_hive_asset(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &mut DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg3: &mut MarketPlace<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg4: &mut HiveProfile, arg5: &mut HiveProfile, arg6: u64, arg7: 0x2::coin::Coin<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0 && arg3.module_version == 0, 1079);
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x2::tx_context::sender(arg8);
        authority_check(arg4, v1);
        assert!(0x2::linked_table::contains<u64, ListingRecord>(&arg5.listing_records, arg6), 1070);
        let v2 = 0x2::linked_table::remove<u64, ListingRecord>(&mut arg5.listing_records, arg6);
        assert!(v2.expiration_sec > v0, 1032);
        assert!(!v2.is_sale_listing, 1047);
        let v3 = get_access_level(&arg4.subscriptions_list, 0x2::object::uid_to_address(&arg5.id), v0);
        assert!(v3 >= v2.listing_access, 1129);
        let v4 = v2.min_dsui_price;
        if (v3 >= v2.discount_access) {
            v4 = v2.min_dsui_price - v2.min_dsui_price * v2.discount / 100;
        };
        let v5 = v2.lockup_duration;
        let v6 = 0x2::clock::timestamp_ms(arg0);
        let v7 = v0 + 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::borrow_locking_window() + (v5 as u64) * 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::month_multiplier();
        let (_, _, _, _, _, _, _, _, _, _, _) = destroy_listing_record(v2);
        let v19 = 0x2::coin::into_balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(arg7);
        assert!(0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&v19) >= v4, 1058);
        let v20 = 0x2::balance::split<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut v19, v4);
        let v21 = &mut v20;
        let (v22, v23) = execute_sale(arg1, arg3, arg2, arg6, false, 0x2::object::uid_to_address(&arg4.id), 0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&v20), v21);
        let v24 = v23;
        let v25 = v22;
        0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut arg5.available_dsui, 0x1::option::extract<0x2::balance::Balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(&mut v24.balance));
        let v26 = BorrowRecord{
            owner             : arg5.owner,
            borrow_price_dsui : v4,
            start_sec         : v6,
            lockup_duration   : (v5 as u8),
            expiration_sec    : v7,
        };
        v25.is_borrowed = true;
        deposit_hive_asset(arg4, v25);
        0x2::linked_table::push_back<u64, BorrowRecord>(&mut arg4.borrow_records, arg6, v26);
        let v27 = LendRecord{
            borrower        : v1,
            version         : arg6,
            lend_price_dsui : v4,
            start_sec       : v6,
            lockup_duration : (v5 as u8),
            expiration_sec  : v7,
        };
        0x2::linked_table::push_back<u64, LendRecord>(&mut arg5.lend_records, arg6, v27);
        let (_, v29, _, _, v32, _, _, _, _) = destroy_executed_listing<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(v24);
        0x1::option::destroy_none<HiveAsset>(v29);
        0x1::option::destroy_none<0x2::balance::Balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(v32);
        let v37 = HiveAssetBorrowed{
            version           : arg6,
            borrower_profile  : 0x2::object::uid_to_address(&arg4.id),
            lender_profile    : 0x2::object::uid_to_address(&arg5.id),
            borrow_price_dsui : v4,
            lockup_duration   : v5,
            borrow_start_sec  : v6,
            borrow_exp_sec    : v7,
        };
        0x2::event::emit<HiveAssetBorrowed>(v37);
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::destroy_or_transfer_balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(v19, v1, arg8);
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::destroy_or_transfer_balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(v20, v1, arg8);
    }

    public fun borrow_mut_from_composable_profile<T0: store + key>(arg0: &mut HiveProfile, arg1: 0x1::ascii::String) : &mut T0 {
        assert!(arg0.is_composable_profile, 1116);
        0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, T0>(&mut arg0.id, arg1)
    }

    public fun borrow_mut_from_manager_profile<T0: store + key>(arg0: &ManagerAppAccessCapability, arg1: &mut HiveManager) : &mut T0 {
        0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, T0>(&mut arg1.hive_profile.id, arg0.app_name)
    }

    fun borrow_mut_from_profile<T0: store + key>(arg0: &mut HiveProfile, arg1: 0x1::ascii::String) : &mut T0 {
        0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, T0>(&mut arg0.id, arg1)
    }

    public fun borrow_non_mut_store_from_asset<T0: store + key>(arg0: &HiveAppAccessCapability, arg1: &HiveAsset) : &T0 {
        0x2::dynamic_object_field::borrow<0x1::ascii::String, T0>(&arg1.id, arg0.app_name)
    }

    public fun borrow_store_from_asset<T0: store + key>(arg0: &HiveAppAccessCapability, arg1: &mut HiveAsset) : &mut T0 {
        0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, T0>(&mut arg1.id, arg0.app_name)
    }

    public entry fun burn_hive_asset(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &mut DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg3: &mut HiveDisperser, arg4: &mut HiveProfile, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0 && arg3.module_version == 0 && arg4.module_version == 0, 1079);
        let v0 = 0x2::tx_context::sender(arg6);
        authority_check(arg4, v0);
        let (v1, v2) = withdraw_hive_asset(arg0, arg1, arg2, arg3, arg4, arg5, false);
        let v3 = v1;
        0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut arg4.available_dsui, v2);
        assert!(!v3.is_borrowed, 1138);
        let (v4, v5) = internal_burn_hive_asset(arg1, v3, v0);
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::join(&mut arg4.available_gems, v4);
        0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut arg4.available_dsui, v5);
    }

    public fun burn_hive_asset_via_app(arg0: &HiveAppAccessCapability, arg1: &mut HiveManager, arg2: HiveAsset) : (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::HiveGems, 0x2::balance::Balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>) {
        assert!(arg1.module_version == 0, 1079);
        internal_burn_hive_asset(arg1, arg2, 0x2::object::uid_to_address(&arg0.id))
    }

    fun cal_access_price_to_pay_when_switching(arg0: u64, arg1: &AccessRecord, arg2: u64) : u64 {
        let v0 = arg2;
        let v1 = if (arg0 > arg1.next_payment_timestamp) {
            0
        } else {
            arg1.next_payment_timestamp - arg0
        };
        let v2 = arg1.access_cost * v1 / 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::month_multiplier();
        if (arg2 > v2) {
            v0 = arg2 - v2;
        };
        v0
    }

    fun calc_next_payment_timestamp(arg0: u64) : u64 {
        arg0 + 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::month_multiplier()
    }

    fun calc_voting_power(arg0: u64, arg1: u64) : u64 {
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div(arg0, arg1, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::boost_precision())
    }

    fun calculate_hive_to_charge_for_subscription(arg0: u64, arg1: &HiveManager, arg2: u64) : u64 {
        assert!(arg1.hive_twap.last_update_timestamp + 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::max_twap_update_delay() > arg0, 1119);
        assert!(arg1.hive_twap.hive_usdc_twap > 0, 1118);
        (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256((arg2 as u256), (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::pow(10, (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::twap_precision() as u128)) as u256), (arg1.hive_twap.hive_usdc_twap as u256)) as u64)
    }

    public entry fun calculate_kraft_price(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = arg1 + arg2 * ((pow_approx((arg3 as u128), 2, 3) / 1000000000000) as u64);
        v0 - (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256((v0 as u256), (arg0 as u256), (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::percent_precision() as u256)) as u64)
    }

    public entry fun calculate_pow(arg0: u128, arg1: u128, arg2: u128, arg3: u128) : u128 {
        let v0 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::precision_constant();
        let v1 = (arg0 as u256) * (v0 as u256) / (arg1 as u256);
        let v2 = (arg2 as u256) * (v0 as u256) / (arg3 as u256);
        if (v2 == 0) {
            return (v0 as u128)
        };
        if (v1 == 0) {
            return (v1 as u128)
        };
        let v3 = v2 / (v0 as u256);
        let v4 = v2 % (v0 as u256);
        let v5 = v1;
        if (v3 == 0) {
            v5 = (v0 as u256);
        } else {
            let v6 = 1;
            while (v6 < (v3 as u128)) {
                let v7 = v5 * v1;
                v5 = v7 / (v0 as u256);
                v6 = v6 + 1;
            };
        };
        if (v4 == 0) {
            return (v5 as u128)
        };
        ((v5 * pow_approx_frac(v1, (v4 as u128), 1000000000000000) / (v0 as u256)) as u128)
    }

    public entry fun cancel_bid(arg0: &mut MarketPlace<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg1: &mut HiveProfile, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 1079);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        authority_check(arg1, v0);
        let (_, _, _, _) = destroy_bid_record(0x2::linked_table::remove<u64, BidRecord>(&mut arg1.bid_records, arg2));
        let v6 = 0x2::linked_table::remove<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(&mut arg0.available_bids, arg2);
        let v7 = &mut v6;
        let v8 = destroy_bid_among_bids(v7, v1, false, arg2);
        0x2::linked_table::push_back<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(&mut arg0.available_bids, arg2, v6);
        let v9 = BidCanceled{
            version        : arg2,
            bidder_profile : v1,
            refund_dsui    : 0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&v8),
        };
        0x2::event::emit<BidCanceled>(v9);
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::destroy_or_transfer_balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(v8, v0, arg3);
    }

    public entry fun cancel_direct_bid(arg0: &mut HiveProfile, arg1: &mut HiveProfile, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 1079);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        authority_check(arg1, v0);
        let (_, _, _, _) = destroy_bid_record(0x2::linked_table::remove<u64, BidRecord>(&mut arg1.bid_records, arg2));
        let v6 = 0x2::linked_table::remove<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(&mut arg0.incoming_bids, arg2);
        let v7 = &mut v6;
        let v8 = destroy_bid_among_bids(v7, v1, false, arg2);
        0x2::linked_table::push_back<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(&mut arg0.incoming_bids, arg2, v6);
        let v9 = BidCanceled{
            version        : arg2,
            bidder_profile : v1,
            refund_dsui    : 0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&v8),
        };
        0x2::event::emit<BidCanceled>(v9);
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::destroy_or_transfer_balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(v8, v0, arg3);
    }

    public entry fun cancel_listing(arg0: &mut MarketPlace<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg1: &mut HiveProfile, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 1079);
        authority_check(arg1, 0x2::tx_context::sender(arg3));
        assert!(0x2::linked_table::contains<u64, ListingRecord>(&arg1.listing_records, arg2), 1037);
        let v0 = 0x2::linked_table::remove<u64, Listing>(&mut arg0.active_listings, arg2);
        let v1 = ListingCanceled{
            listed_by_profile : v0.listed_by_profile,
            version           : arg2,
        };
        0x2::event::emit<ListingCanceled>(v1);
        let (v2, _, _, _, _, _, _, _, _, _, _, _) = destroy_listing(v0);
        let (_, _, _, _, _, _, _, _, _, _, _) = destroy_listing_record(0x2::linked_table::remove<u64, ListingRecord>(&mut arg1.listing_records, arg2));
        deposit_hive_asset(arg1, v2);
        mark_marketplace_bids_as_invalid(arg0, arg2);
    }

    fun claim_accrued_rewards_for_asset(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &mut DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg3: &mut HiveDisperser, arg4: &mut HiveAsset) : (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::HiveGems, 0x2::balance::Balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, bool) {
        let v0 = false;
        let v1 = v0;
        if (arg4.is_staked) {
            let v5 = compute_harvest_by_gems(arg2.global_dispersal_index, arg4.claim_index, arg4.power);
            let v6 = compute_harvest_by_gems(arg3.global_dispersal_index, arg4.hive_claim_index, arg4.power);
            let v7 = HarvestRewardsForAsset{
                version        : arg4.version,
                dsui_harvested : v5,
                gems_harvested : v6,
            };
            0x2::event::emit<HarvestRewardsForAsset>(v7);
            arg4.claim_index = arg2.global_dispersal_index;
            arg4.hive_claim_index = arg3.global_dispersal_index;
            arg4.total_dsui_claimed = arg4.total_dsui_claimed + v5;
            arg4.total_gems_claimed = arg4.total_gems_claimed + v6;
            if (arg4.unlock_timestamp < 0x2::clock::timestamp_ms(arg0)) {
                unstake_hive_asset(arg1, arg4);
                v1 = true;
            };
            (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::split(&mut arg3.gems_for_assets, v6), 0x2::balance::split<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut arg2.dsui_for_assets, v5), v1)
        } else {
            (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::zero(), 0x2::balance::zero<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(), v0)
        }
    }

    fun compute_harvest_by_gems(arg0: u256, arg1: u256, arg2: u64) : u64 {
        ((((arg0 - arg1) as u256) * (arg2 as u256) / (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::precision_constant() as u256)) as u64)
    }

    public fun compute_profile_socialfi_info(arg0: &0x2::clock::Clock, arg1: &HiveManager, arg2: &HiveProfile, arg3: &0x2::tx_context::TxContext) : (u64, u64, u64, u64) {
        let v0 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::hive_decimal_precision();
        let (v1, _) = get_voting_power_for_profile(arg0, arg2);
        let v3 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&arg2.available_gems);
        let v4 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u128((v1 as u128), (arg1.config_params.social_multiplier_for_power as u128), (v0 as u128));
        let v5 = v4 + 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u128((v3 as u128), (arg1.config_params.social_multiplier_for_gems as u128), (v0 as u128));
        let v6 = 0;
        let v7 = 0;
        if (0x2::tx_context::epoch(arg3) == arg2.last_active_epoch) {
            let v8 = arg2.entropy_used_for_cur_epoch;
            v7 = v8;
            if (v8 > v4) {
                v6 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u128(((v8 - v4) as u128), (v0 as u128), (arg1.config_params.social_multiplier_for_gems as u128));
            };
        };
        (v5, v5 - v7, v3 - v6, v3)
    }

    fun consume_entropy(arg0: &0x2::clock::Clock, arg1: &HiveManager, arg2: &mut HiveProfile, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg2.owner == 0x2::tx_context::sender(arg4), 1057);
        let v0 = 0x2::tx_context::epoch(arg4);
        let (v1, v2, v3, v4) = compute_profile_socialfi_info(arg0, arg1, arg2, arg4);
        assert!(v2 >= arg3, 1123);
        if (v0 > arg2.last_active_epoch) {
            arg2.last_active_epoch = v0;
            arg2.entropy_used_for_cur_epoch = arg3;
        } else {
            arg2.entropy_used_for_cur_epoch = arg2.entropy_used_for_cur_epoch + arg3;
        };
        let v5 = UpdateEntropyForEpoch{
            username                   : arg2.username,
            profile_addr               : 0x2::object::uid_to_address(&arg2.id),
            epoch                      : v0,
            max_entropy                : v1,
            entropy_used_for_cur_epoch : arg2.entropy_used_for_cur_epoch,
            remaining_entropy          : v2 - 1,
            max_withdrawable_gems      : v3,
            available_gems             : v4,
        };
        0x2::event::emit<UpdateEntropyForEpoch>(v5);
    }

    public fun consume_entropy_of_profile(arg0: &0x2::clock::Clock, arg1: &HiveAppAccessCapability, arg2: &HiveManager, arg3: &mut HiveProfile, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        consume_entropy(arg0, arg2, arg3, arg4, arg5);
    }

    fun create_bid(arg0: address, arg1: u64, arg2: 0x2::balance::Balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg3: u64, arg4: bool) : Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI> {
        Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>{
            bidder_profile   : arg0,
            balance          : arg2,
            offer_dsui_price : arg1,
            expiration_sec   : arg3,
            is_listing_live  : arg4,
            is_valid         : true,
        }
    }

    fun create_bid_record(arg0: u64, arg1: u64, arg2: u64, arg3: bool) : BidRecord {
        BidRecord{
            version          : arg0,
            offer_dsui_price : arg1,
            expiration_sec   : arg2,
            is_asset_listed  : arg3,
        }
    }

    public entry fun delete_hive_profile(arg0: &0x2::clock::Clock, arg1: HiveProfile, arg2: &mut HiveProfileMappingStore, arg3: &mut HiveManager, arg4: &mut 0x2::tx_context::TxContext) {
        internal_destroy_profile(arg0, arg1, arg2, arg3, arg4);
    }

    public fun deposit_back_hiveasset(arg0: &HiveAppAccessCapability, arg1: &mut HiveManager, arg2: &mut HiveProfile, arg3: HiveAsset) {
        assert!(arg1.module_version == 0, 1079);
        let v0 = arg3.version;
        deposit_hive_asset(arg2, arg3);
        update_asset_ownership(arg1, v0, 0x2::object::uid_to_address(&arg2.id), false);
        let v1 = HiveAssetReturnedByApp{
            app_name           : arg0.app_name,
            recepient_profile  : 0x2::object::uid_to_address(&arg2.id),
            recepient_username : arg2.username,
            version            : v0,
        };
        0x2::event::emit<HiveAssetReturnedByApp>(v1);
    }

    public fun deposit_dsui_for_hive<T0>(arg0: &mut DSuiDisperser<T0>, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        if (v0 > 0) {
            let v1 = DegenSuiAddedForHarvest{yield_added: v0};
            0x2::event::emit<DegenSuiAddedForHarvest>(v1);
        };
        0x2::balance::join<T0>(&mut arg0.incoming_dsui_for_assets, arg1);
    }

    public fun deposit_dsui_for_profile(arg0: &mut HiveProfile, arg1: 0x2::balance::Balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 1079);
        0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut arg0.available_dsui, arg1);
        let v0 = DepositHSuiForProfile{
            profile_addr   : 0x2::object::uid_to_address(&arg0.id),
            dsui_deposited : 0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&arg1),
            depositor_addr : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<DepositHSuiForProfile>(v0);
    }

    public fun deposit_gems_for_hive(arg0: &mut HiveDisperser, arg1: 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::HiveGems) {
        if (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&arg1) > 0) {
            let v0 = HiveAddedForHarvest{yield_added: 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&arg1)};
            0x2::event::emit<HiveAddedForHarvest>(v0);
        };
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::join(&mut arg0.incoming_gems_for_assets, arg1);
    }

    public fun deposit_gems_in_profile(arg0: &mut HiveProfile, arg1: 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::HiveGems) {
        let v0 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&arg1);
        if (v0 > 0) {
            let v1 = GemAddedToProfile{
                username       : arg0.username,
                profile_addr   : 0x2::object::uid_to_address(&arg0.id),
                deposited_gems : v0,
            };
            0x2::event::emit<GemAddedToProfile>(v1);
        };
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::join(&mut arg0.available_gems, arg1);
    }

    fun deposit_hive_asset(arg0: &mut HiveProfile, arg1: HiveAsset) {
        0x2::linked_table::push_back<u64, HiveAsset>(&mut arg0.hive_assets, arg1.version, arg1);
    }

    public fun deposit_hive_into_hive_asset_via_app(arg0: &HiveAppAccessCapability, arg1: &mut HiveAsset, arg2: 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::HiveGems) {
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::join(&mut arg1.available_gems, arg2);
        let v0 = HiveGemsDepositedIntoAsset{
            profile        : 0x2::object::uid_to_address(&arg0.id),
            version        : arg1.version,
            gems_deposited : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&arg2),
        };
        0x2::event::emit<HiveGemsDepositedIntoAsset>(v0);
    }

    public fun deposit_hive_with_manager_profile(arg0: &mut HiveManager, arg1: 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::HiveGems) {
        let v0 = &mut arg0.hive_profile;
        deposit_gems_in_profile(v0, arg1);
        let v1 = HiveAddedToTreasury{
            hive_added             : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&arg1),
            total_hive_in_treasury : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&arg0.hive_profile.available_gems),
        };
        0x2::event::emit<HiveAddedToTreasury>(v1);
    }

    fun destroy_bid<T0>(arg0: Bid<T0>, arg1: u64) : (0x2::balance::Balance<T0>, address, u64, u64, bool, bool) {
        let Bid {
            bidder_profile   : v0,
            balance          : v1,
            offer_dsui_price : v2,
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

    fun destroy_bid_among_bids(arg0: &mut vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>, arg1: address, arg2: bool, arg3: u64) : 0x2::balance::Balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI> {
        let v0 = 0x2::balance::zero<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(arg0)) {
            if (0x1::vector::borrow<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(arg0, v1).bidder_profile == arg1) {
                let v2 = 0x1::vector::remove<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(arg0, v1);
                if (arg2) {
                    assert!(!v2.is_valid, 1075);
                };
                let (v3, _, _, _, _, _) = destroy_bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(v2, arg3);
                0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut v0, v3);
                return v0
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun destroy_bid_record(arg0: BidRecord) : (u64, u64, u64, bool) {
        let BidRecord {
            version          : v0,
            offer_dsui_price : v1,
            expiration_sec   : v2,
            is_asset_listed  : v3,
        } = arg0;
        (v0, v1, v2, v3)
    }

    fun destroy_borrow_record(arg0: BorrowRecord) : (address, u8, u64, u64, u64) {
        let BorrowRecord {
            owner             : v0,
            borrow_price_dsui : v1,
            start_sec         : v2,
            lockup_duration   : v3,
            expiration_sec    : v4,
        } = arg0;
        (v0, v3, v1, v2, v4)
    }

    fun destroy_executed_listing<T0>(arg0: ExecutedListing<T0>) : (address, 0x1::option::Option<HiveAsset>, u64, bool, 0x1::option::Option<0x2::balance::Balance<T0>>, address, u64, u64, u64) {
        let ExecutedListing {
            listed_by_profile       : v0,
            hive_asset              : v1,
            version                 : v2,
            was_sale_listing        : v3,
            balance                 : v4,
            bidder_profile          : v5,
            executed_price_in_dsui  : v6,
            borrow_period_start_sec : v7,
            borrow_period_end_sec   : v8,
        } = arg0;
        let v9 = ExecutedListingDestroyed{
            version                : v2,
            executed_price_in_dsui : v6,
            listed_by_profile      : v0,
        };
        0x2::event::emit<ExecutedListingDestroyed>(v9);
        (v0, v1, v2, v3, v4, v5, v6, v7, v8)
    }

    fun destroy_lend_record(arg0: LendRecord) : (address, u64, u64, u64, u8, u64) {
        let LendRecord {
            borrower        : v0,
            version         : v1,
            lend_price_dsui : v2,
            start_sec       : v3,
            lockup_duration : v4,
            expiration_sec  : v5,
        } = arg0;
        (v0, v1, v2, v3, v4, v5)
    }

    fun destroy_listing(arg0: Listing) : (HiveAsset, address, u8, u8, u64, u64, bool, bool, bool, u8, u64, u64) {
        let Listing {
            listed_by_profile : v0,
            hive_asset        : v1,
            listing_access    : v2,
            discount_access   : v3,
            discount          : v4,
            min_dsui_price    : v5,
            is_sale_listing   : v6,
            instant_sale      : v7,
            highest_bid_sale  : v8,
            lockup_duration   : v9,
            start_sec         : v10,
            expiration_sec    : v11,
        } = arg0;
        let v12 = v1;
        let v13 = ListingDestroyed{
            version           : v12.version,
            listed_by_profile : v0,
        };
        0x2::event::emit<ListingDestroyed>(v13);
        (v12, v0, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11)
    }

    fun destroy_listing_record(arg0: ListingRecord) : (u64, u8, u8, u64, u64, bool, bool, bool, u8, u64, u64) {
        let ListingRecord {
            version          : v0,
            listing_access   : v1,
            discount_access  : v2,
            discount         : v3,
            min_dsui_price   : v4,
            is_sale_listing  : v5,
            instant_sale     : v6,
            highest_bid_sale : v7,
            lockup_duration  : v8,
            start_sec        : v9,
            expiration_sec   : v10,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10)
    }

    fun destroy_subscription_record(arg0: AccessRecord) : (address, address, u64, u8, u64, u64, u64, bool) {
        let AccessRecord {
            subscriber             : v0,
            subscribed_to          : v1,
            init_timestamp         : v2,
            access_type            : v3,
            access_cost            : v4,
            next_payment_timestamp : v5,
            total_paid             : v6,
            to_unsubscribe         : v7,
        } = arg0;
        let v8 = AccessRecordDestroyed{
            subscriber_profile    : v0,
            subscribed_to_profile : v1,
            init_timestamp        : v2,
            total_paid            : v6,
        };
        0x2::event::emit<AccessRecordDestroyed>(v8);
        (v0, v1, v2, v3, v4, v5, v6, v7)
    }

    public fun does_collection_exist(arg0: &HiveProfileMappingStore, arg1: 0x1::string::String) : bool {
        0x2::linked_table::contains<0x1::ascii::String, address>(&arg0.kiosk_names_mapping, get_kiosk_app_name(arg1))
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

    fun execute_public_kraft(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xbd6fb3628e2130230c35df4a964a3727f928e17fe6971ac71f62286646a5a37b::dsui_vault::DSuiVault, arg3: &mut HiveManager, arg4: &mut HiveKiosk, arg5: &mut PublicKraftConfig, arg6: &mut HiveProfile, arg7: u64, arg8: 0x2::balance::Balance<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x2::object::uid_to_address(&arg6.id);
        let v1 = 1;
        let v2 = 0x2::clock::timestamp_ms(arg0);
        let v3 = calculate_kraft_price(arg7, arg4.base_price, arg4.curve_a, arg4.krafted_assets);
        assert!(v2 >= arg5.start_time, 1008);
        if (!0x2::linked_table::contains<address, u64>(&arg5.address_list, v0)) {
            0x2::linked_table::push_back<address, u64>(&mut arg5.address_list, v0, 0);
        };
        let v4 = 0x2::linked_table::borrow_mut<address, u64>(&mut arg5.address_list, v0);
        assert!(arg5.per_user_limit >= *v4 + v1, 1018);
        *v4 = *v4 + v1;
        arg5.krafts_processed = arg5.krafts_processed + v1;
        arg4.krafted_assets = arg4.krafted_assets + v1;
        let v5 = 0x2::tx_context::sender(arg9);
        let (v6, v7, _, _) = internal_kraft_hiveverse_asset(arg6, arg1, arg2, v5, v2, arg3, arg4, arg8, v3, arg9);
        deposit_hive_asset(arg6, v7);
        v6
    }

    fun execute_sale(arg0: &mut HiveManager, arg1: &mut MarketPlace<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg2: &mut DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg3: u64, arg4: bool, arg5: address, arg6: u64, arg7: &mut 0x2::balance::Balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>) : (HiveAsset, ExecutedListing<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>) {
        let (v0, v1, _, _, _, _, v6, v7, v8, _, _, _) = destroy_listing(0x2::linked_table::remove<u64, Listing>(&mut arg1.active_listings, arg3));
        let v12 = v0;
        assert!(v1 != arg5, 1062);
        if (v6 && 0x2::linked_table::contains<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(&arg1.available_bids, arg3)) {
            let v13 = 0x2::linked_table::remove<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(&mut arg1.available_bids, arg3);
            let v14 = 0;
            while (v14 < 0x1::vector::length<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(&v13)) {
                let v15 = 0x1::vector::borrow_mut<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(&mut v13, v14);
                v15.is_listing_live = false;
                v15.is_valid = false;
                let v16 = BidMarkedInvalid{
                    version        : arg3,
                    bidder_profile : v15.bidder_profile,
                };
                0x2::event::emit<BidMarkedInvalid>(v16);
                if (arg4 && v15.bidder_profile == arg5) {
                    let (v17, _, v19, _, _, _) = destroy_bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(0x1::vector::remove<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(&mut v13, v14), arg3);
                    if (arg6 == 0) {
                        arg6 = v19;
                    };
                    0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(arg7, v17);
                    break
                };
                v14 = v14 + 1;
            };
            0x2::linked_table::push_back<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(&mut arg1.available_bids, arg3, v13);
        };
        let v23 = ExecutedListing<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>{
            listed_by_profile       : v1,
            hive_asset              : 0x1::option::none<HiveAsset>(),
            version                 : arg3,
            was_sale_listing        : v6,
            balance                 : 0x1::option::some<0x2::balance::Balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(process_royalty(0x2::balance::split<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(arg7, arg6), arg0, arg2, v12.kiosk_addr)),
            bidder_profile          : arg5,
            executed_price_in_dsui  : arg6,
            borrow_period_start_sec : 0,
            borrow_period_end_sec   : 0,
        };
        let v24 = SaleExecuted{
            version                : arg3,
            buyer_profile          : arg5,
            seller_profile         : v1,
            price_paid_dsui        : arg6,
            is_sale_listing        : v6,
            instant_sale           : v7,
            highest_bid_sale       : v8,
            is_direct_bid_accepted : false,
        };
        0x2::event::emit<SaleExecuted>(v24);
        (v12, v23)
    }

    public fun exists_for_admin_profile(arg0: &HiveManager, arg1: 0x1::ascii::String) : bool {
        0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.hive_profile.id, arg1)
    }

    public fun exists_for_profile(arg0: &HiveProfile, arg1: 0x1::ascii::String) : bool {
        0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, arg1)
    }

    public entry fun exit_hive_of_profile(arg0: &0x2::clock::Clock, arg1: &mut HiveProfile, arg2: &mut HiveProfile, arg3: &0x2::tx_context::TxContext) {
        authority_check(arg1, 0x2::tx_context::sender(arg3));
        let v0 = 0x2::object::uid_to_address(&arg2.id);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        let v2 = 0x2::linked_table::borrow<address, AccessRecord>(&arg1.subscriptions_list, v0);
        assert!(v2.to_unsubscribe, 1093);
        if (v2.next_payment_timestamp > 0x2::clock::timestamp_ms(arg0)) {
            0x2::linked_table::borrow_mut<address, AccessRecord>(&mut arg1.subscriptions_list, v0).to_unsubscribe = true;
            0x2::linked_table::borrow_mut<address, AccessRecord>(&mut arg2.subscribers_list, v1).to_unsubscribe = true;
        } else {
            let (_, _, _, _, _, _, _, _) = destroy_subscription_record(0x2::linked_table::remove<address, AccessRecord>(&mut arg1.subscriptions_list, v0));
            let (_, _, _, _, _, _, _, _) = destroy_subscription_record(0x2::linked_table::remove<address, AccessRecord>(&mut arg2.subscribers_list, v1));
        };
        let v19 = ExitHiveOfProfile{
            subscriber_profile_addr        : v1,
            unsubscribed_from_profile_addr : v0,
            subscriber_username            : 0x1::string::from_ascii(arg1.username),
            unhive_owner_username          : 0x1::string::from_ascii(arg2.username),
            records_deleted                : false,
        };
        0x2::event::emit<ExitHiveOfProfile>(v19);
    }

    public fun extract_collected_kiosk_earnings(arg0: &mut HiveManager, arg1: &mut HiveProfile, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        authority_check(arg1, 0x2::tx_context::sender(arg3));
        let v0 = 0x2::object::uid_to_address(&borrow_from_profile<HiveKiosk>(arg1, get_kiosk_app_name(arg2)).id);
        if (!0x2::linked_table::contains<address, KioskEarnings>(&arg0.kiosk_earnings, v0)) {
            return
        };
        let v1 = 0x2::balance::withdraw_all<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut 0x2::linked_table::borrow_mut<address, KioskEarnings>(&mut arg0.kiosk_earnings, v0).creator_earnings);
        let v2 = RoyaltyCollectedForCreator{
            kiosk_addr      : v0,
            creator_profile : 0x2::object::uid_to_address(&arg1.id),
            username        : arg1.username,
            dsui_collected  : 0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&v1),
            collection_name : arg2,
        };
        0x2::event::emit<RoyaltyCollectedForCreator>(v2);
        0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut arg1.available_dsui, v1);
    }

    public fun free_expired_suins_domain_username(arg0: &0x2::clock::Clock, arg1: &mut HiveProfileMappingStore, arg2: &mut HiveProfile, arg3: &0x2::tx_context::TxContext) {
        let v0 = to_lowercase(arg2.username);
        assert!(0x2::linked_table::remove<0x1::ascii::String, address>(&mut arg1.username_to_profile_mapping, v0) == 0x2::object::uid_to_address(&arg2.id), 1136);
        assert!(0x2::clock::timestamp_ms(arg0) > 0x2::linked_table::remove<0x1::ascii::String, u64>(&mut arg1.suins_name_to_expiry_mapping, v0), 1137);
        let v1 = 0x1::string::to_ascii(0x1::string::utf8(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::default_username()));
        arg2.username = v1;
        let v2 = UserNameUpdated{
            profile_addr  : 0x2::object::uid_to_address(&arg2.id),
            prev_username : 0x1::string::from_ascii(arg2.username),
            new_username  : 0x1::string::from_ascii(v1),
        };
        0x2::event::emit<UserNameUpdated>(v2);
    }

    public fun free_suins_domain_username(arg0: &mut HiveProfileMappingStore, arg1: &mut HiveProfile, arg2: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg3: &0x2::tx_context::TxContext) {
        let v0 = to_lowercase(0x1::string::to_ascii(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain_name(arg2)));
        assert!(0x2::linked_table::remove<0x1::ascii::String, address>(&mut arg0.username_to_profile_mapping, v0) == 0x2::object::uid_to_address(&arg1.id), 1136);
        0x2::linked_table::remove<0x1::ascii::String, u64>(&mut arg0.suins_name_to_expiry_mapping, v0);
        let v1 = 0x1::string::to_ascii(0x1::string::utf8(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::default_username()));
        arg1.username = v1;
        let v2 = UserNameUpdated{
            profile_addr  : 0x2::object::uid_to_address(&arg1.id),
            prev_username : 0x1::string::from_ascii(arg1.username),
            new_username  : 0x1::string::from_ascii(v1),
        };
        0x2::event::emit<UserNameUpdated>(v2);
    }

    fun get_access_level(arg0: &0x2::linked_table::LinkedTable<address, AccessRecord>, arg1: address, arg2: u64) : u8 {
        let v0 = 0;
        if (0x2::linked_table::contains<address, AccessRecord>(arg0, arg1)) {
            let v1 = 0x2::linked_table::borrow<address, AccessRecord>(arg0, arg1);
            if (arg2 < v1.next_payment_timestamp || v1.access_cost == 0) {
                let v2 = v1.access_type;
                v0 = v2;
                if (v2 == 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::forever_subscribe_plan()) {
                    v0 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::worker_bee_plan();
                };
            };
        };
        v0
    }

    public fun get_access_to_hive_info(arg0: &0x2::clock::Clock, arg1: &HiveProfile, arg2: address) : (bool, u64, u8, u64, u64, u64, bool) {
        let v0 = false;
        let v1 = v0;
        if (0x2::linked_table::contains<address, AccessRecord>(&arg1.subscriptions_list, arg2)) {
            let v9 = 0x2::linked_table::borrow<address, AccessRecord>(&arg1.subscriptions_list, arg2);
            if (v9.access_type == 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::forever_subscribe_plan() || v9.next_payment_timestamp > 0x2::clock::timestamp_ms(arg0) || v9.access_cost == 0) {
                v1 = true;
            };
            (v1, v9.init_timestamp, v9.access_type, v9.access_cost, v9.next_payment_timestamp, v9.total_paid, v9.to_unsubscribe)
        } else {
            (v0, 0, 0, 0, 0, 0, false)
        }
    }

    public fun get_accrued_harvest_for_asset(arg0: &HiveManager, arg1: &DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg2: &HiveDisperser, arg3: &HiveProfile, arg4: u64) : (u64, u64) {
        let v0 = 0x2::linked_table::borrow<u64, HiveAsset>(&arg3.hive_assets, arg4);
        if (arg0.active_power == 0 || !v0.is_staked) {
            return (0, 0)
        };
        (compute_harvest_by_gems(arg1.global_dispersal_index + 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256((0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&arg1.incoming_dsui_for_assets) as u256), (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::precision_constant() as u256), (arg0.active_power as u256)), v0.claim_index, v0.power), compute_harvest_by_gems(arg2.global_dispersal_index + 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256((0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&arg2.incoming_gems_for_assets) as u256), (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::precision_constant() as u256), (arg0.active_power as u256)), v0.hive_claim_index, v0.power))
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

    public fun get_all_supported_apps_and_capabilities(arg0: &HiveProfileMappingStore, arg1: 0x1::option::Option<0x1::ascii::String>, arg2: u64) : (vector<0x1::ascii::String>, vector<address>, u64) {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = 0x1::vector::empty<address>();
        let v2 = if (0x1::option::is_some<0x1::ascii::String>(&arg1)) {
            0x1::option::some<0x1::ascii::String>(*0x1::option::borrow<0x1::ascii::String>(&arg1))
        } else {
            *0x2::linked_table::front<0x1::ascii::String, address>(&arg0.app_names_to_cap_mapping)
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<0x1::ascii::String>(&v3) && v4 < arg2) {
            let v5 = 0x1::option::borrow<0x1::ascii::String>(&v3);
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, *v5);
            0x1::vector::push_back<address>(&mut v1, *0x2::linked_table::borrow<0x1::ascii::String, address>(&arg0.app_names_to_cap_mapping, *v5));
            v3 = *0x2::linked_table::next<0x1::ascii::String, address>(&arg0.app_names_to_cap_mapping, *v5);
            v4 = v4 + 1;
        };
        (v0, v1, 0x2::linked_table::length<0x1::ascii::String, address>(&arg0.app_names_to_cap_mapping))
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
            0x1::option::some<0x1::ascii::String>(to_lowercase(0x1::string::to_ascii(*0x1::option::borrow<0x1::string::String>(&arg1))))
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

    public fun get_apps_info_for_asset(arg0: &HiveProfile, arg1: u64) : vector<0x1::ascii::String> {
        0x2::linked_table::borrow<u64, HiveAsset>(&arg0.hive_assets, arg1).active_apps
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

    public fun get_asset_upgrade_info(arg0: &HiveProfile, arg1: 0x1::string::String, arg2: u64, arg3: u64) : (u64, u8, 0x1::ascii::String, vector<0x1::string::String>, vector<0x1::string::String>) {
        let v0 = 0x1::vector::borrow<AssetUpgrade>(0x2::linked_table::borrow<u64, vector<AssetUpgrade>>(&borrow_from_profile<HiveKiosk>(arg0, get_kiosk_app_name(arg1)).available_upgrades, arg2), arg3);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&v0.upgrade_traits_list)) {
            0x1::vector::push_back<0x1::string::String>(&mut v1, *0x2::table::borrow<0x1::string::String, 0x1::string::String>(&v0.upgrade_prompts, *0x1::vector::borrow<0x1::string::String>(&v0.upgrade_traits_list, v2)));
            v2 = v2 + 1;
        };
        (v0.upgrade_price, v0.upgrade_access, 0x2::url::inner_url(&v0.upgrade_img_url), v0.upgrade_traits_list, v1)
    }

    public fun get_asset_upgrades_for_version(arg0: &HiveProfile, arg1: 0x1::string::String, arg2: u64) : (vector<u64>, vector<u64>, vector<u8>, vector<0x1::ascii::String>) {
        let v0 = 0x2::linked_table::borrow<u64, vector<AssetUpgrade>>(&borrow_from_profile<HiveKiosk>(arg0, get_kiosk_app_name(arg1)).available_upgrades, arg2);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 0x1::vector::empty<0x1::ascii::String>();
        let v5 = 0;
        while (v5 < 0x1::vector::length<AssetUpgrade>(v0)) {
            let v6 = 0x1::vector::borrow<AssetUpgrade>(v0, v5);
            0x1::vector::push_back<u64>(&mut v1, v5);
            0x1::vector::push_back<u64>(&mut v2, v6.upgrade_price);
            0x1::vector::push_back<u8>(&mut v3, v6.upgrade_access);
            0x1::vector::push_back<0x1::ascii::String>(&mut v4, 0x2::url::inner_url(&v6.upgrade_img_url));
            v5 = v5 + 1;
        };
        (v1, v2, v3, v4)
    }

    public fun get_available_gems_in_profile(arg0: &HiveProfile) : u64 {
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&arg0.available_gems)
    }

    public fun get_available_harvest_for_profile(arg0: &HiveManager, arg1: &DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg2: &HiveDisperser, arg3: &HiveProfile) : (u64, u64) {
        if (arg0.active_power == 0) {
            return (0, 0)
        };
        let v0 = 0;
        let v1 = 0;
        let v2 = *0x2::linked_table::front<u64, HiveAsset>(&arg3.hive_assets);
        while (0x1::option::is_some<u64>(&v2)) {
            let v3 = 0x1::option::borrow<u64>(&v2);
            let v4 = 0x2::linked_table::borrow<u64, HiveAsset>(&arg3.hive_assets, *v3);
            v0 = v0 + compute_harvest_by_gems(arg1.global_dispersal_index + 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256((0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&arg1.incoming_dsui_for_assets) as u256), (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::precision_constant() as u256), (arg0.active_power as u256)), v4.claim_index, v4.power);
            v1 = v1 + compute_harvest_by_gems(arg2.global_dispersal_index + 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256((0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&arg2.incoming_gems_for_assets) as u256), (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::precision_constant() as u256), (arg0.active_power as u256)), v4.hive_claim_index, v4.power);
            v2 = *0x2::linked_table::next<u64, HiveAsset>(&arg3.hive_assets, *v3);
        };
        (v1, v0 + 0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&arg3.available_dsui))
    }

    public fun get_bid_record(arg0: &HiveProfile, arg1: u64) : (u64, u64, u64, bool) {
        if (!0x2::linked_table::contains<u64, BidRecord>(&arg0.bid_records, arg1)) {
            return (0, 0, 0, false)
        };
        let v0 = 0x2::linked_table::borrow<u64, BidRecord>(&arg0.bid_records, arg1);
        (v0.version, v0.offer_dsui_price, v0.expiration_sec, v0.is_asset_listed)
    }

    public fun get_bids_for_asset(arg0: &HiveProfile, arg1: u64, arg2: 0x1::option::Option<u64>, arg3: u64) : (vector<address>, vector<u64>, vector<u64>, vector<bool>, vector<bool>, u64) {
        if (!0x2::linked_table::contains<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(&arg0.incoming_bids, arg1)) {
            return (0x1::vector::empty<address>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<bool>(), 0x1::vector::empty<bool>(), 0)
        };
        let v0 = 0x2::linked_table::borrow<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(&arg0.incoming_bids, arg1);
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
        while (v6 < arg3 && v6 < 0x1::vector::length<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(v0)) {
            let v7 = 0x1::vector::borrow<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(v0, v6);
            0x1::vector::push_back<address>(&mut v1, v7.bidder_profile);
            0x1::vector::push_back<u64>(&mut v2, v7.offer_dsui_price);
            0x1::vector::push_back<u64>(&mut v3, v7.expiration_sec);
            0x1::vector::push_back<bool>(&mut v4, v7.is_listing_live);
            0x1::vector::push_back<bool>(&mut v5, v7.is_valid);
            v6 = v6 + 1;
        };
        (v1, v2, v3, v4, v5, 0x1::vector::length<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(v0))
    }

    public fun get_bids_for_listing(arg0: &MarketPlace<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg1: u64, arg2: 0x1::option::Option<u64>, arg3: u64) : (vector<address>, vector<u64>, vector<u64>, vector<bool>, vector<bool>, u64) {
        if (!0x2::linked_table::contains<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(&arg0.available_bids, arg1)) {
            return (0x1::vector::empty<address>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<bool>(), 0x1::vector::empty<bool>(), 0)
        };
        let v0 = 0x2::linked_table::borrow<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(&arg0.available_bids, arg1);
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
        while (v6 < arg3 && v6 < 0x1::vector::length<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(v0)) {
            let v7 = 0x1::vector::borrow<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(v0, v6);
            0x1::vector::push_back<address>(&mut v1, v7.bidder_profile);
            0x1::vector::push_back<u64>(&mut v2, v7.offer_dsui_price);
            0x1::vector::push_back<u64>(&mut v3, v7.expiration_sec);
            0x1::vector::push_back<bool>(&mut v4, v7.is_listing_live);
            0x1::vector::push_back<bool>(&mut v5, v7.is_valid);
            v6 = v6 + 1;
        };
        (v1, v2, v3, v4, v5, 0x1::vector::length<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(v0))
    }

    public fun get_borrow_record(arg0: &HiveProfile, arg1: u64) : (0x1::string::String, u8, u64, u64, u64) {
        if (!0x2::linked_table::contains<u64, BorrowRecord>(&arg0.borrow_records, arg1)) {
            return (0x1::string::utf8(b""), 0, 0, 0, 0)
        };
        let v0 = 0x2::linked_table::borrow<u64, BorrowRecord>(&arg0.borrow_records, arg1);
        (0x2::address::to_string(v0.owner), v0.lockup_duration, v0.borrow_price_dsui, v0.start_sec, v0.expiration_sec)
    }

    public fun get_collection_kiosk(arg0: &HiveProfileMappingStore, arg1: 0x1::string::String) : address {
        *0x2::linked_table::borrow<0x1::ascii::String, address>(&arg0.kiosk_names_mapping, get_kiosk_app_name(arg1))
    }

    public fun get_dsui_disperser_info<T0>(arg0: &DSuiDisperser<T0>) : (u64, u64, u256) {
        (0x2::balance::value<T0>(&arg0.incoming_dsui_for_assets), 0x2::balance::value<T0>(&arg0.dsui_for_assets), arg0.global_dispersal_index)
    }

    public fun get_executed_listing_info(arg0: &MarketPlace<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg1: u64) : (0x1::string::String, bool, bool, bool, u64, 0x1::string::String, u64, u64, u64) {
        if (!0x2::linked_table::contains<u64, ExecutedListing<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(&arg0.processed_listings, arg1)) {
            return (0x1::string::utf8(b""), false, false, false, 0, 0x1::string::utf8(b""), 0, 0, 0)
        };
        let v0 = 0x2::linked_table::borrow<u64, ExecutedListing<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(&arg0.processed_listings, arg1);
        let v1 = 0x1::option::is_some<0x2::balance::Balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(&v0.balance);
        let v2 = 0;
        if (v1) {
            v2 = 0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(0x1::option::borrow<0x2::balance::Balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(&v0.balance));
        };
        (0x2::address::to_string(v0.listed_by_profile), 0x1::option::is_some<HiveAsset>(&v0.hive_asset), v1, v0.was_sale_listing, v2, 0x2::address::to_string(v0.bidder_profile), v0.executed_price_in_dsui, v0.borrow_period_start_sec, v0.borrow_period_end_sec)
    }

    public fun get_executed_listings_list(arg0: &MarketPlace<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg1: 0x1::option::Option<u64>, arg2: u64) : (vector<u64>, u64) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = if (0x1::option::is_some<u64>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<u64, ExecutedListing<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(&arg0.processed_listings)
        };
        let v2 = v1;
        let v3 = 0;
        while (0x1::option::is_some<u64>(&v2) && v3 < arg2) {
            let v4 = 0x1::option::borrow<u64>(&v2);
            0x1::vector::push_back<u64>(&mut v0, *v4);
            v2 = *0x2::linked_table::next<u64, ExecutedListing<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(&arg0.processed_listings, *v4);
            v3 = v3 + 1;
        };
        (v0, 0x2::linked_table::length<u64, ExecutedListing<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(&arg0.processed_listings))
    }

    public fun get_gems_royalty_info(arg0: &HiveManager) : (u64, u64, u64, u64) {
        (arg0.royalty.numerator, arg0.royalty.denominator, arg0.royalty.assets_dispersal_percent, arg0.royalty.assets_dispersal_percent)
    }

    public fun get_harvest_by_assets(arg0: &HiveManager, arg1: &DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg2: &HiveDisperser, arg3: &HiveProfile) : (u64, vector<u64>, u64, vector<u64>) {
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
                v7 = compute_harvest_by_gems(arg1.global_dispersal_index + 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256((0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&arg1.incoming_dsui_for_assets) as u256), (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::precision_constant() as u256), (arg0.active_power as u256)), v6.claim_index, v6.power);
                v8 = compute_harvest_by_gems(arg2.global_dispersal_index + 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256((0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&arg2.incoming_gems_for_assets) as u256), (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::precision_constant() as u256), (arg0.active_power as u256)), v6.hive_claim_index, v6.power);
            };
            v0 = v0 + v7;
            v1 = v1 + v8;
            0x1::vector::push_back<u64>(&mut v2, v7);
            0x1::vector::push_back<u64>(&mut v3, v8);
            v4 = *0x2::linked_table::next<u64, HiveAsset>(&arg3.hive_assets, *v5);
        };
        (v0, v2, v1, v3)
    }

    public fun get_hive_app_name(arg0: &HiveAppAccessCapability) : 0x1::ascii::String {
        arg0.app_name
    }

    public fun get_hive_asset_info(arg0: &HiveProfile, arg1: u64) : (0x1::string::String, u64, u64, u64, u256, u256, 0x1::string::String, 0x1::string::String, 0x1::string::String, u64, u64, bool, bool, u8, u64, address) {
        let v0 = 0x2::linked_table::borrow<u64, HiveAsset>(&arg0.hive_assets, arg1);
        (0x2::address::to_string(0x2::object::uid_to_address(&v0.id)), v0.version, v0.power, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&v0.available_gems), v0.claim_index, v0.hive_claim_index, v0.name, 0x1::string::from_ascii(0x2::url::inner_url(&v0.img_url)), v0.collection_name, v0.total_dsui_claimed, v0.total_gems_claimed, v0.is_borrowed, v0.is_staked, v0.lockup_duration, v0.unlock_timestamp, v0.kiosk_addr)
    }

    public fun get_hive_avail_in_hive_asset(arg0: &HiveAsset) : u64 {
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&arg0.available_gems)
    }

    public fun get_hive_disperser_info(arg0: &HiveDisperser) : (u64, u64, u256) {
        (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&arg0.incoming_gems_for_assets), 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&arg0.gems_for_assets), arg0.global_dispersal_index)
    }

    public fun get_hive_manager_info(arg0: &HiveManager) : (address, u64, u64, u128, u64, u64) {
        (0x2::object::uid_to_address(&arg0.hive_profile.id), arg0.active_assets, arg0.locked_assets, arg0.active_power, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&arg0.hive_profile.available_gems), 0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&arg0.buidlers_royalty))
    }

    public fun get_hive_manager_params_info(arg0: &HiveManager) : (u64, u64, u64, u64) {
        (arg0.config_params.max_bids_per_asset, arg0.config_params.min_dsui_bid_allowed, arg0.config_params.profile_kraft_fees_sui, arg0.config_params.social_fee_gems)
    }

    public fun get_hive_to_charge_for_subscription(arg0: &0x2::clock::Clock, arg1: &HiveManager, arg2: u64) : u64 {
        calculate_hive_to_charge_for_subscription(0x2::clock::timestamp_ms(arg0), arg1, arg2)
    }

    public fun get_hivekiosk_info(arg0: &HiveProfile, arg1: 0x1::string::String) : (0x1::string::String, 0x1::ascii::String, vector<0x1::string::String>, u64, u64, u64, u64, u64, u8, u8, u64, u64) {
        let v0 = borrow_from_profile<HiveKiosk>(arg0, get_kiosk_app_name(arg1));
        (0x2::address::to_string(0x2::object::uid_to_address(&v0.id)), 0x2::url::inner_url(&v0.img_url), v0.traits_list, v0.max_assets_limit, v0.krafted_assets, 0x1::vector::length<0x1::string::String>(&v0.url_list), v0.base_price, v0.curve_a, v0.kraft_access, v0.discount_access, v0.discount, v0.module_version)
    }

    fun get_kiosk_app_name(arg0: 0x1::string::String) : 0x1::ascii::String {
        let v0 = 0x1::string::utf8(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::kiosk_storage());
        0x1::string::append(&mut v0, 0x1::string::utf8(b"::"));
        0x1::string::append(&mut v0, arg0);
        0x1::string::to_ascii(v0)
    }

    public fun get_kiosk_earnings(arg0: &HiveManager, arg1: address) : (u64, u64) {
        let v0 = 0x2::linked_table::borrow<address, KioskEarnings>(&arg0.kiosk_earnings, arg1);
        (0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&v0.creator_earnings), 0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&v0.liquidity_pool))
    }

    public fun get_kiosk_earnings_list(arg0: &HiveManager, arg1: 0x1::option::Option<address>, arg2: u64) : (vector<address>, vector<u64>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = if (0x1::option::is_some<address>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<address, KioskEarnings>(&arg0.kiosk_earnings)
        };
        let v4 = v3;
        let v5 = 0;
        while (0x1::option::is_some<address>(&v4) && v5 < arg2) {
            let v6 = 0x1::option::borrow<address>(&v4);
            let v7 = 0x2::linked_table::borrow<address, KioskEarnings>(&arg0.kiosk_earnings, *v6);
            0x1::vector::push_back<address>(&mut v0, *v6);
            0x1::vector::push_back<u64>(&mut v1, 0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&v7.creator_earnings));
            0x1::vector::push_back<u64>(&mut v2, 0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&v7.liquidity_pool));
            v4 = *0x2::linked_table::next<address, KioskEarnings>(&arg0.kiosk_earnings, *v6);
            v5 = v5 + 1;
        };
        (v0, v1, v2, 0x2::linked_table::length<address, KioskEarnings>(&arg0.kiosk_earnings))
    }

    public fun get_kiosk_info(arg0: &HiveKiosk) : (0x1::string::String, 0x1::ascii::String, vector<0x1::string::String>, u64, u64, u64, u64, u8, u8, u64, u64) {
        (0x2::address::to_string(0x2::object::uid_to_address(&arg0.id)), 0x2::url::inner_url(&arg0.img_url), arg0.traits_list, arg0.max_assets_limit, arg0.krafted_assets, arg0.base_price, arg0.curve_a, arg0.kraft_access, arg0.discount_access, arg0.discount, arg0.module_version)
    }

    public fun get_kiosks_list_for_creator(arg0: &HiveProfileMappingStore, arg1: address) : vector<address> {
        *0x2::linked_table::borrow<address, vector<address>>(&arg0.profile_to_creator_kiosk_mapping, arg1)
    }

    public fun get_krafted_versions_for_kiosk(arg0: &HiveProfile, arg1: 0x1::string::String, arg2: 0x1::option::Option<u64>, arg3: u64) : vector<u64> {
        let v0 = borrow_from_profile<HiveKiosk>(arg0, get_kiosk_app_name(arg1));
        let v1 = 0x1::vector::empty<u64>();
        let v2 = if (0x1::option::is_some<u64>(&arg2)) {
            arg2
        } else {
            *0x2::linked_table::front<u64, address>(&v0.krafted_versions_map)
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<u64>(&v3) && v4 < arg3) {
            let v5 = 0x1::option::borrow<u64>(&v3);
            0x1::vector::push_back<u64>(&mut v1, *v5);
            v3 = *0x2::linked_table::next<u64, address>(&v0.krafted_versions_map, *v5);
            v4 = v4 + 1;
        };
        v1
    }

    public fun get_lend_record(arg0: &HiveProfile, arg1: u64) : (0x1::string::String, u64, u64, u64, u64) {
        if (!0x2::linked_table::contains<u64, LendRecord>(&arg0.lend_records, arg1)) {
            return (0x1::string::utf8(b""), 0, 0, 0, 0)
        };
        let v0 = 0x2::linked_table::borrow<u64, LendRecord>(&arg0.lend_records, arg1);
        (0x2::address::to_string(v0.borrower), v0.version, v0.lend_price_dsui, v0.start_sec, v0.expiration_sec)
    }

    public fun get_listed_assets_in_marketplace(arg0: &MarketPlace<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg1: 0x1::option::Option<u64>, arg2: u64) : (vector<u64>, u64) {
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

    public fun get_listing_from_marketplace(arg0: &MarketPlace<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg1: u64) : (0x1::string::String, u8, u8, u64, u64, bool, bool, bool, u8, u64, u64) {
        if (!0x2::linked_table::contains<u64, Listing>(&arg0.active_listings, arg1)) {
            return (0x1::string::utf8(b""), 0, 0, 0, 0, false, false, false, 0, 0, 0)
        };
        let v0 = 0x2::linked_table::borrow<u64, Listing>(&arg0.active_listings, arg1);
        (0x2::address::to_string(v0.listed_by_profile), v0.listing_access, v0.discount_access, v0.discount, v0.min_dsui_price, v0.is_sale_listing, v0.instant_sale, v0.highest_bid_sale, v0.lockup_duration, v0.start_sec, v0.expiration_sec)
    }

    public fun get_listing_record(arg0: &HiveProfile, arg1: u64) : (u8, u8, u64, u64, bool, bool, bool, u8, u64, u64) {
        if (!0x2::linked_table::contains<u64, ListingRecord>(&arg0.listing_records, arg1)) {
            return (0, 0, 0, 0, false, false, false, 0, 0, 0)
        };
        let v0 = 0x2::linked_table::borrow<u64, ListingRecord>(&arg0.listing_records, arg1);
        (v0.listing_access, v0.discount_access, v0.discount, v0.min_dsui_price, v0.is_sale_listing, v0.instant_sale, v0.highest_bid_sale, v0.lockup_duration, v0.start_sec, v0.expiration_sec)
    }

    public fun get_prices_for_hive_asset_krafts(arg0: &0x2::clock::Clock, arg1: &HiveProfile, arg2: 0x1::string::String, arg3: address, arg4: u64) : (u64, vector<u64>, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = get_kiosk_app_name(arg2);
        if (!exists_for_profile(arg1, v1)) {
            return (0, 0x1::vector::empty<u64>(), 0)
        };
        let v2 = borrow_from_profile<HiveKiosk>(arg1, v1);
        let v3 = get_access_level(&arg1.subscribers_list, arg3, 0x2::clock::timestamp_ms(arg0));
        let v4 = 0;
        if (v3 >= v2.discount_access) {
            v4 = v2.discount;
        };
        if (v3 < v2.kraft_access) {
            return (0, 0x1::vector::empty<u64>(), 0)
        };
        let v5 = 0;
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 0x1::string::from_ascii(v1);
        0x1::string::append(&mut v7, 0x1::string::utf8(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::public_kraft_storage()));
        let v8 = 0x1::string::to_ascii(v7);
        if (!exists_for_profile(arg1, v8)) {
            return (0, 0x1::vector::empty<u64>(), 0)
        };
        let v9 = borrow_from_profile<PublicKraftConfig>(arg1, v8);
        if (v0 < v9.start_time) {
            v5 = v9.start_time - v0;
        };
        let v10 = if (0x2::linked_table::contains<address, u64>(&v9.address_list, arg3)) {
            v9.per_user_limit - *0x2::linked_table::borrow<address, u64>(&v9.address_list, arg3)
        } else {
            v9.per_user_limit
        };
        if (v10 > v2.max_assets_limit - v2.krafted_assets) {
            v10 = v2.max_assets_limit - v2.krafted_assets;
        };
        let v11 = v2.krafted_assets;
        let v12 = 0;
        while (v12 < arg4) {
            let v13 = calculate_kraft_price(v4, v2.base_price, v2.curve_a, v11);
            v11 = v11 + 1;
            0x1::vector::push_back<u64>(&mut v6, v13);
            v12 = v12 + 1;
        };
        (v5, v6, v10)
    }

    public fun get_profile_addr(arg0: &HiveProfile) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun get_profile_bio(arg0: &HiveProfile) : 0x1::string::String {
        arg0.bio
    }

    public fun get_profile_for_username(arg0: &HiveProfileMappingStore, arg1: 0x1::string::String) : (bool, address) {
        let v0 = to_lowercase(0x1::string::to_ascii(arg1));
        let v1 = 0x2::linked_table::contains<0x1::ascii::String, address>(&arg0.username_to_profile_mapping, v0);
        let v2 = if (v1) {
            *0x2::linked_table::borrow<0x1::ascii::String, address>(&arg0.username_to_profile_mapping, v0)
        } else {
            @0x0
        };
        (v1, v2)
    }

    public fun get_profile_info(arg0: &HiveProfile) : (0x1::string::String, 0x1::string::String, vector<u64>, u64, 0x1::string::String, bool, u64, u64, u64, vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v5, *0x2::table::borrow<u8, u64>(&arg0.beehive_plan, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::worker_bee_plan()));
        0x1::vector::push_back<u64>(&mut v5, *0x2::table::borrow<u8, u64>(&arg0.beehive_plan, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::drone_bee_plan()));
        0x1::vector::push_back<u64>(&mut v5, *0x2::table::borrow<u8, u64>(&arg0.beehive_plan, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::queen_bee_plan()));
        let v6 = *0x2::linked_table::front<u64, HiveAsset>(&arg0.hive_assets);
        while (0x1::option::is_some<u64>(&v6)) {
            0x1::vector::push_back<u64>(&mut v0, *0x1::option::borrow<u64>(&v6));
            let v7 = 0x2::linked_table::next<u64, HiveAsset>(&arg0.hive_assets, *0x1::option::borrow<u64>(&v6));
            v6 = *v7;
        };
        let v8 = *0x2::linked_table::front<u64, BorrowRecord>(&arg0.borrow_records);
        while (0x1::option::is_some<u64>(&v8)) {
            0x1::vector::push_back<u64>(&mut v1, *0x1::option::borrow<u64>(&v8));
            let v9 = 0x2::linked_table::next<u64, BorrowRecord>(&arg0.borrow_records, *0x1::option::borrow<u64>(&v8));
            v8 = *v9;
        };
        let v10 = *0x2::linked_table::front<u64, ListingRecord>(&arg0.listing_records);
        while (0x1::option::is_some<u64>(&v10)) {
            0x1::vector::push_back<u64>(&mut v2, *0x1::option::borrow<u64>(&v10));
            let v11 = 0x2::linked_table::next<u64, ListingRecord>(&arg0.listing_records, *0x1::option::borrow<u64>(&v10));
            v10 = *v11;
        };
        let v12 = *0x2::linked_table::front<u64, BidRecord>(&arg0.bid_records);
        while (0x1::option::is_some<u64>(&v12)) {
            0x1::vector::push_back<u64>(&mut v3, *0x1::option::borrow<u64>(&v12));
            let v13 = 0x2::linked_table::next<u64, BidRecord>(&arg0.bid_records, *0x1::option::borrow<u64>(&v12));
            v12 = *v13;
        };
        let v14 = *0x2::linked_table::front<u64, LendRecord>(&arg0.lend_records);
        while (0x1::option::is_some<u64>(&v14)) {
            0x1::vector::push_back<u64>(&mut v4, *0x1::option::borrow<u64>(&v14));
            let v15 = 0x2::linked_table::next<u64, LendRecord>(&arg0.lend_records, *0x1::option::borrow<u64>(&v14));
            v14 = *v15;
        };
        (0x1::string::from_ascii(arg0.username), arg0.bio, v5, arg0.creation_timestamp, 0x2::address::to_string(arg0.owner), arg0.is_composable_profile, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&arg0.available_gems), arg0.last_active_epoch, arg0.entropy_used_for_cur_epoch, v0, v1, v2, v3, v4, 0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&arg0.available_dsui))
    }

    public fun get_profile_info_with_power(arg0: &0x2::clock::Clock, arg1: &HiveProfile) : (0x1::string::String, u64, 0x1::string::String, vector<u64>, u64, 0x1::string::String, bool, u64, u64, u64, vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, u64) {
        let (v0, _) = get_voting_power_for_profile(arg0, arg1);
        let (v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16) = get_profile_info(arg1);
        (v2, v0, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16)
    }

    public fun get_profile_info_with_power_and_likes(arg0: &0x2::clock::Clock, arg1: &HiveManager, arg2: &HiveProfile, arg3: &0x2::tx_context::TxContext) : (0x1::string::String, u64, 0x1::string::String, vector<u64>, u64, 0x1::string::String, bool, u64, u64, u64, u64, u64, u64, vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, u64) {
        let (v0, _) = get_voting_power_for_profile(arg0, arg2);
        let (v2, v3, v4, _) = compute_profile_socialfi_info(arg0, arg1, arg2, arg3);
        let (v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20) = get_profile_info(arg2);
        (v6, v0, v7, v8, v9, v10, v11, v12, v13, v14, v2, v3, v4, v15, v16, v17, v18, v19, v20)
    }

    public fun get_profile_inscription(arg0: &HiveProfile) : (0x1::string::String, vector<0x1::string::String>) {
        if (0x2::linked_table::contains<u64, Inscription>(&arg0.inscription, 42)) {
            let v2 = *0x2::linked_table::borrow<u64, Inscription>(&arg0.inscription, 42);
            (v2.format, v2.base64)
        } else {
            (0x1::string::utf8(b""), 0x1::vector::empty<0x1::string::String>())
        }
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

    public fun get_public_kraft_config_info(arg0: &HiveProfile, arg1: 0x1::string::String) : (u64, u64, u64) {
        let v0 = 0x1::string::from_ascii(get_kiosk_app_name(arg1));
        0x1::string::append(&mut v0, 0x1::string::utf8(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::public_kraft_storage()));
        let v1 = borrow_from_profile<PublicKraftConfig>(arg0, 0x1::string::to_ascii(v0));
        (v1.start_time, v1.per_user_limit, v1.krafts_processed)
    }

    public fun get_royalty_info(arg0: &HiveManager) : (u64, u64, u64, u64) {
        (arg0.gems_royalty.numerator, arg0.gems_royalty.denominator, arg0.gems_royalty.treasury_percent, arg0.gems_royalty.burn_percent)
    }

    public fun get_subscribers_and_subscriptions_length(arg0: &HiveProfile) : (u64, u64) {
        (0x2::linked_table::length<address, AccessRecord>(&arg0.subscribers_list), 0x2::linked_table::length<address, AccessRecord>(&arg0.subscriptions_list))
    }

    public fun get_subscribers_list(arg0: &HiveProfile, arg1: 0x1::option::Option<address>, arg2: u64) : (vector<address>, vector<u64>, vector<u8>, vector<u64>, vector<u64>, vector<u64>, vector<bool>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<bool>();
        let v7 = if (0x1::option::is_some<address>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<address, AccessRecord>(&arg0.subscribers_list)
        };
        let v8 = v7;
        let v9 = 0;
        while (0x1::option::is_some<address>(&v8) && v9 < arg2) {
            let v10 = 0x1::option::borrow<address>(&v8);
            let v11 = 0x2::linked_table::borrow<address, AccessRecord>(&arg0.subscribers_list, *v10);
            0x1::vector::push_back<address>(&mut v0, *v10);
            0x1::vector::push_back<u64>(&mut v1, v11.init_timestamp);
            0x1::vector::push_back<u8>(&mut v2, v11.access_type);
            0x1::vector::push_back<u64>(&mut v3, v11.access_cost);
            0x1::vector::push_back<u64>(&mut v4, v11.next_payment_timestamp);
            0x1::vector::push_back<u64>(&mut v5, v11.total_paid);
            0x1::vector::push_back<bool>(&mut v6, v11.to_unsubscribe);
            v8 = *0x2::linked_table::next<address, AccessRecord>(&arg0.subscribers_list, *v10);
            v9 = v9 + 1;
        };
        (v0, v1, v2, v3, v4, v5, v6, 0x2::linked_table::length<address, AccessRecord>(&arg0.subscribers_list))
    }

    public fun get_subscriptions_list(arg0: &HiveProfile, arg1: 0x1::option::Option<address>, arg2: u64) : (vector<address>, vector<u64>, vector<u8>, vector<u64>, vector<u64>, vector<u64>, vector<bool>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<bool>();
        let v7 = if (0x1::option::is_some<address>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<address, AccessRecord>(&arg0.subscriptions_list)
        };
        let v8 = v7;
        let v9 = 0;
        while (0x1::option::is_some<address>(&v8) && v9 < arg2) {
            let v10 = 0x1::option::borrow<address>(&v8);
            let v11 = 0x2::linked_table::borrow<address, AccessRecord>(&arg0.subscriptions_list, *v10);
            0x1::vector::push_back<address>(&mut v0, *v10);
            0x1::vector::push_back<u64>(&mut v1, v11.init_timestamp);
            0x1::vector::push_back<u8>(&mut v2, v11.access_type);
            0x1::vector::push_back<u64>(&mut v3, v11.access_cost);
            0x1::vector::push_back<u64>(&mut v4, v11.next_payment_timestamp);
            0x1::vector::push_back<u64>(&mut v5, v11.total_paid);
            0x1::vector::push_back<bool>(&mut v6, v11.to_unsubscribe);
            v8 = *0x2::linked_table::next<address, AccessRecord>(&arg0.subscriptions_list, *v10);
            v9 = v9 + 1;
        };
        (v0, v1, v2, v3, v4, v5, v6, 0x2::linked_table::length<address, AccessRecord>(&arg0.subscriptions_list))
    }

    public fun get_voting_power_for_profile(arg0: &0x2::clock::Clock, arg1: &HiveProfile) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = *0x2::linked_table::front<u64, HiveAsset>(&arg1.hive_assets);
        while (0x1::option::is_some<u64>(&v2)) {
            let v3 = 0x1::option::borrow<u64>(&v2);
            let v4 = 0x2::linked_table::borrow<u64, HiveAsset>(&arg1.hive_assets, *v3);
            if (v4.is_staked && v4.unlock_timestamp > 0x2::clock::timestamp_ms(arg0)) {
                v0 = v0 + v4.power;
            } else {
                v1 = v1 + 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&v4.available_gems);
            };
            v2 = *0x2::linked_table::next<u64, HiveAsset>(&arg1.hive_assets, *v3);
        };
        (v0, v1)
    }

    public entry fun handle_expired_listings(arg0: &0x2::clock::Clock, arg1: &mut MarketPlace<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg2: &mut HiveProfile, arg3: &mut 0x2::tx_context::TxContext) {
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
            let (v5, _, _, _, _, _, _, _, _, _, _, _) = destroy_listing(v3);
            let (_, _, _, _, _, _, _, _, _, _, _) = destroy_listing_record(0x2::linked_table::remove<u64, ListingRecord>(&mut arg2.listing_records, v1));
            deposit_hive_asset(arg2, v5);
            mark_marketplace_bids_as_invalid(arg1, v1);
        };
    }

    public entry fun handle_expired_marketplace_bids_for_profile(arg0: &0x2::clock::Clock, arg1: &mut MarketPlace<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg2: &mut HiveProfile, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 1079);
        let v0 = 0x2::object::uid_to_address(&arg2.id);
        let v1 = *0x2::linked_table::front<u64, BidRecord>(&arg2.bid_records);
        while (0x1::option::is_some<u64>(&v1)) {
            let v2 = *0x1::option::borrow<u64>(&v1);
            let v3 = 0x2::linked_table::borrow<u64, BidRecord>(&arg2.bid_records, v2);
            v1 = *0x2::linked_table::next<u64, BidRecord>(&arg2.bid_records, v2);
            if (v3.is_asset_listed && v3.expiration_sec < 0x2::clock::timestamp_ms(arg0)) {
                let v4 = 0x2::linked_table::borrow_mut<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(&mut arg1.available_bids, v2);
                let v5 = destroy_bid_among_bids(v4, v0, false, v2);
                let v6 = BidExpired{
                    version        : v2,
                    bidder_profile : v0,
                    refund_dsui    : 0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&v5),
                };
                0x2::event::emit<BidExpired>(v6);
                0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut arg2.available_dsui, v5);
                let (_, _, _, _) = destroy_bid_record(0x2::linked_table::remove<u64, BidRecord>(&mut arg2.bid_records, v2));
            };
        };
    }

    public entry fun handle_invalid_direct_bid(arg0: &0x2::clock::Clock, arg1: &mut HiveProfile, arg2: &mut HiveProfile, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 1079);
        let v0 = 0x2::object::uid_to_address(&arg2.id);
        let v1 = 0x2::linked_table::remove<u64, BidRecord>(&mut arg2.bid_records, arg3);
        let v2 = 0x2::linked_table::remove<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(&mut arg1.incoming_bids, arg3);
        let v3 = &mut v2;
        let v4 = destroy_bid_among_bids(v3, v0, v1.expiration_sec >= 0x2::clock::timestamp_ms(arg0), arg3);
        let (_, _, _, _) = destroy_bid_record(v1);
        0x2::linked_table::push_back<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(&mut arg1.incoming_bids, arg3, v2);
        let v9 = BidExpired{
            version        : arg3,
            bidder_profile : v0,
            refund_dsui    : 0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&v4),
        };
        0x2::event::emit<BidExpired>(v9);
        0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut arg2.available_dsui, v4);
    }

    public fun handle_processed_listing(arg0: &mut HiveManager, arg1: &mut MarketPlace<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg2: &mut HiveProfile, arg3: &mut HiveProfile, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 1079);
        assert!(0x2::linked_table::contains<u64, ListingRecord>(&arg2.listing_records, arg4), 1050);
        assert!(0x2::linked_table::contains<u64, ExecutedListing<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(&arg1.processed_listings, arg4), 1059);
        let (v0, v1, _, _, v4, v5, _, _, _) = destroy_executed_listing<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(0x2::linked_table::remove<u64, ExecutedListing<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(&mut arg1.processed_listings, arg4));
        let v9 = v4;
        let v10 = v1;
        assert!(v0 == 0x2::object::uid_to_address(&arg2.id), 1050);
        if (0x1::option::is_some<0x2::balance::Balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(&v9)) {
            0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut arg2.available_dsui, 0x1::option::destroy_some<0x2::balance::Balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(v9));
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(v9);
        };
        if (v5 != v0) {
            assert!(v5 == 0x2::object::uid_to_address(&arg3.id), 1061);
        };
        if (0x2::linked_table::contains<u64, BidRecord>(&arg3.bid_records, arg4)) {
            let (_, _, _, _) = destroy_bid_record(0x2::linked_table::remove<u64, BidRecord>(&mut arg3.bid_records, arg4));
        };
        if (0x1::option::is_some<HiveAsset>(&v10)) {
            update_asset_ownership(arg0, arg4, 0x2::object::uid_to_address(&arg3.id), false);
            deposit_hive_asset(arg3, 0x1::option::extract<HiveAsset>(&mut v10));
        };
        let (_, _, _, _, _, _, _, _, _, _, _) = destroy_listing_record(0x2::linked_table::remove<u64, ListingRecord>(&mut arg2.listing_records, arg4));
        0x1::option::destroy_none<HiveAsset>(v10);
    }

    public fun harvest_governance_rewards(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &mut DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg3: &mut HiveDisperser, arg4: &mut HiveProfile, arg5: &0x2::tx_context::TxContext) : (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::HiveGems, 0x2::balance::Balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0 && arg3.module_version == 0 && arg4.module_version == 0, 1079);
        authority_check(arg4, 0x2::tx_context::sender(arg5));
        increment_global_index(arg1, arg2);
        increment_gems_global_index(arg1, arg3);
        let v0 = 0x2::balance::zero<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>();
        let v1 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::zero();
        let v2 = *0x2::linked_table::front<u64, HiveAsset>(&arg4.hive_assets);
        while (0x1::option::is_some<u64>(&v2)) {
            let v3 = 0x1::option::borrow<u64>(&v2);
            let v4 = 0x2::linked_table::borrow_mut<u64, HiveAsset>(&mut arg4.hive_assets, *v3);
            let (v5, v6, v7) = claim_accrued_rewards_for_asset(arg0, arg1, arg2, arg3, v4);
            0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut v0, v6);
            0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::join(&mut v1, v5);
            if (v7) {
                let v8 = HiveAssetUnstaked{
                    profile_addr : 0x2::object::uid_to_address(&arg4.id),
                    version      : *v3,
                };
                0x2::event::emit<HiveAssetUnstaked>(v8);
            };
            v2 = *0x2::linked_table::next<u64, HiveAsset>(&arg4.hive_assets, *v3);
        };
        0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut v0, 0x2::balance::withdraw_all<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut arg4.available_dsui));
        let v9 = DegenHiveYieldHarvested{
            harvester_profile : 0x2::object::uid_to_address(&arg4.id),
            username          : arg4.username,
            dsui_harvested    : 0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&v0),
            gems_harvested    : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&v1),
        };
        0x2::event::emit<DegenHiveYieldHarvested>(v9);
        (v1, v0)
    }

    public entry fun harvest_governance_rewards_and_transfer(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &mut DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg3: &mut HiveDisperser, arg4: &mut HiveProfile, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = harvest_governance_rewards(arg0, arg1, arg2, arg3, arg4, arg5);
        let v2 = v0;
        if (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&v2) > 0) {
            let v3 = GemAddedToProfile{
                username       : arg4.username,
                profile_addr   : 0x2::object::uid_to_address(&arg4.id),
                deposited_gems : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&v2),
            };
            0x2::event::emit<GemAddedToProfile>(v3);
        };
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::join(&mut arg4.available_gems, v2);
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::destroy_or_transfer_balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(v1, 0x2::tx_context::sender(arg5), arg5);
    }

    public entry fun harvest_royalty_yield_for_builders(arg0: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::BuidlersRoyaltyCollectionAbility, arg1: &mut HiveManager, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 1079);
        let v0 = 0x2::balance::withdraw_all<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut arg1.buidlers_royalty);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(0x2::coin::from_balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(v0, arg3), arg2);
        let v1 = KraftYieldHarvested{
            dsui_yield : 0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&v0),
            receiver   : arg2,
        };
        0x2::event::emit<KraftYieldHarvested>(v1);
    }

    public fun id_for_dof_of_admin_profile(arg0: &HiveManager, arg1: 0x1::ascii::String) : 0x1::option::Option<0x2::object::ID> {
        0x2::dynamic_object_field::id<0x1::ascii::String>(&arg0.hive_profile.id, arg1)
    }

    public fun id_for_dof_of_profile(arg0: &HiveProfile, arg1: 0x1::ascii::String) : 0x1::option::Option<0x2::object::ID> {
        0x2::dynamic_object_field::id<0x1::ascii::String>(&arg0.id, arg1)
    }

    public entry fun increment_config(arg0: &mut HiveManager) {
        assert!(arg0.module_version < 0, 1080);
        arg0.module_version = 0;
    }

    public entry fun increment_dsui_dispenser(arg0: &mut DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>) {
        assert!(arg0.module_version < 0, 1080);
        arg0.module_version = 0;
    }

    fun increment_gems_global_index(arg0: &HiveManager, arg1: &mut HiveDisperser) {
        let v0 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&arg1.incoming_gems_for_assets);
        if (arg0.active_power == 0 || v0 == 0) {
            return
        };
        arg1.global_dispersal_index = arg1.global_dispersal_index + 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256((v0 as u256), (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::precision_constant() as u256), (arg0.active_power as u256));
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::join(&mut arg1.gems_for_assets, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::withdraw_all(&mut arg1.incoming_gems_for_assets));
    }

    fun increment_global_index(arg0: &HiveManager, arg1: &mut DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>) {
        let v0 = 0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&arg1.incoming_dsui_for_assets);
        if (arg0.active_power == 0 || v0 == 0) {
            return
        };
        arg1.global_dispersal_index = arg1.global_dispersal_index + 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256((v0 as u256), (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::precision_constant() as u256), (arg0.active_power as u256));
        0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut arg1.dsui_for_assets, 0x2::balance::withdraw_all<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut arg1.incoming_dsui_for_assets));
    }

    public entry fun increment_hive_dispenser(arg0: &mut HiveDisperser) {
        assert!(arg0.module_version < 0, 1080);
        arg0.module_version = 0;
    }

    public entry fun increment_hive_kiosk(arg0: &mut HiveKiosk) {
        assert!(arg0.module_version < 0, 1080);
        arg0.module_version = 0;
    }

    public entry fun increment_marketplace(arg0: &mut MarketPlace<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>) {
        assert!(arg0.module_version < 0, 1080);
        arg0.module_version = 0;
    }

    public entry fun increment_profile(arg0: &mut HiveProfile, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 1057);
        assert!(arg0.module_version < 0, 1080);
        arg0.module_version = 0;
    }

    public entry fun increment_profile_ids_store(arg0: &mut HiveProfileMappingStore) {
        assert!(arg0.module_version < 0, 1080);
        arg0.module_version = 0;
    }

    public fun infuse_gems_into_asset(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &mut DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg3: &mut HiveDisperser, arg4: &mut HiveProfile, arg5: u64, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0 && arg3.module_version == 0, 1079);
        authority_check(arg4, 0x2::tx_context::sender(arg7));
        let (_, _, v2, _) = compute_profile_socialfi_info(arg0, arg1, arg4, arg7);
        let v4 = 0x2::linked_table::borrow_mut<u64, HiveAsset>(&mut arg4.hive_assets, arg6);
        increment_global_index(arg1, arg2);
        increment_gems_global_index(arg1, arg3);
        let (v5, v6, v7) = claim_accrued_rewards_for_asset(arg0, arg1, arg2, arg3, v4);
        let v8 = v5;
        0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut arg4.available_dsui, v6);
        let v9 = GemAddedToProfile{
            username       : arg4.username,
            profile_addr   : 0x2::object::uid_to_address(&arg4.id),
            deposited_gems : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&v8),
        };
        0x2::event::emit<GemAddedToProfile>(v9);
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::join(&mut arg4.available_gems, v8);
        if (v7) {
            let v10 = HiveAssetUnstaked{
                profile_addr : 0x2::object::uid_to_address(&arg4.id),
                version      : arg6,
            };
            0x2::event::emit<HiveAssetUnstaked>(v10);
        };
        assert!(arg5 <= v2, 1122);
        let v11 = GemWithdrawnFromProfile{
            username       : arg4.username,
            profile_addr   : 0x2::object::uid_to_address(&arg4.id),
            withdrawn_gems : arg5,
        };
        0x2::event::emit<GemWithdrawnFromProfile>(v11);
        if (v4.is_staked && v4.unlock_timestamp > 0x2::clock::timestamp_ms(arg0)) {
            let v12 = *0x2::table::borrow<u8, u64>(&arg1.supported_lockup_durations, v4.lockup_duration);
            let v13 = v12;
            if (v4.is_borrowed) {
                v13 = v12 / 2;
            };
            let v14 = calc_voting_power(arg5, v13);
            v4.power = v4.power + v14;
            arg1.active_power = arg1.active_power + (v14 as u128);
            let v15 = TotalActivePowerUpdated{
                hive_total_active_power : arg1.active_power,
                total_staked_assets     : arg1.locked_assets,
            };
            0x2::event::emit<TotalActivePowerUpdated>(v15);
            let v16 = AssetPowerUpdated{
                version         : arg6,
                add_power       : v14,
                new_asset_power : v4.power,
            };
            0x2::event::emit<AssetPowerUpdated>(v16);
        };
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::join(&mut v4.available_gems, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::split(&mut arg4.available_gems, arg5));
        let v17 = HiveGemsDepositedIntoAsset{
            profile        : 0x2::object::uid_to_address(&arg4.id),
            version        : arg6,
            gems_deposited : arg5,
        };
        0x2::event::emit<HiveGemsDepositedIntoAsset>(v17);
    }

    fun init(arg0: HIVE_PROFILE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = HiveProfileMappingStore{
            id                                     : 0x2::object::new(arg1),
            owner_to_profile_mapping               : 0x2::linked_table::new<address, address>(arg1),
            username_to_profile_mapping            : 0x2::linked_table::new<0x1::ascii::String, address>(arg1),
            username_to_comp_profile_mapping       : 0x2::linked_table::new<0x1::ascii::String, address>(arg1),
            suins_name_to_expiry_mapping           : 0x2::linked_table::new<0x1::ascii::String, u64>(arg1),
            profile_to_creator_kiosk_mapping       : 0x2::linked_table::new<address, vector<address>>(arg1),
            app_names_to_cap_mapping               : 0x2::linked_table::new<0x1::ascii::String, address>(arg1),
            kiosk_names_mapping                    : 0x2::linked_table::new<0x1::ascii::String, address>(arg1),
            reserved_usernames_to_accessor_mapping : 0x2::linked_table::new<0x1::ascii::String, address>(arg1),
            module_version                         : 0,
        };
        0x2::transfer::share_object<HiveProfileMappingStore>(v0);
        let v1 = HiveDisperser{
            id                       : 0x2::object::new(arg1),
            incoming_gems_for_assets : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::zero(),
            gems_for_assets          : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::zero(),
            global_dispersal_index   : 0,
            module_version           : 0,
        };
        0x2::transfer::share_object<HiveDisperser>(v1);
        let v2 = DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>{
            id                       : 0x2::object::new(arg1),
            incoming_dsui_for_assets : 0x2::balance::zero<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(),
            dsui_for_assets          : 0x2::balance::zero<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(),
            global_dispersal_index   : 0,
            module_version           : 0,
        };
        0x2::transfer::share_object<DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(v2);
        let v3 = MarketPlace<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>{
            id                 : 0x2::object::new(arg1),
            active_listings    : 0x2::linked_table::new<u64, Listing>(arg1),
            available_bids     : 0x2::linked_table::new<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(arg1),
            processed_listings : 0x2::linked_table::new<u64, ExecutedListing<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(arg1),
            module_version     : 0,
        };
        0x2::transfer::share_object<MarketPlace<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(v3);
        let v4 = TwapUpdateCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<TwapUpdateCap>(v4, 0x2::tx_context::sender(arg1));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"username"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"bio"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"owner"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"is_composable_profile"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"Website"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"version"));
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"DegenHive - HiveProfile"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"HIVE-PROFILE -::- THE IDENTITY BLOCK OF DEGNENHIVE's SOCIAL-GRAPH."));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{username}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{bio}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{owner}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{is_composable_profile}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"https://www.degenhive.ai"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{module_version}"));
        let v9 = 0x2::package::claim<HIVE_PROFILE>(arg0, arg1);
        let v10 = 0x2::display::new_with_fields<HiveProfile>(&v9, v5, v7, arg1);
        0x2::display::update_version<HiveProfile>(&mut v10);
        let v11 = 0x1::vector::empty<0x1::string::String>();
        let v12 = &mut v11;
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"Collection Info"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"img_url"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"version"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"power"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"collection_name"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"kiosk_addr"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"is_staked"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"is_borrowed"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"total_dsui_claimed"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"total_gems_claimed"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"Website"));
        let v13 = 0x1::vector::empty<0x1::string::String>();
        let v14 = &mut v13;
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"Represents a GenAI Asset in the DegenHive Ecosystem. Exists within HiveProfile and can be traded / lent among users and can be staked for governance power!"));
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"{version}"));
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"{power}"));
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"{collection_name}"));
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"{kiosk_addr}"));
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"{is_staked}"));
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"is_borrowed"));
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"{total_dsui_claimed}"));
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"{total_gems_claimed}"));
        0x1::vector::push_back<0x1::string::String>(v14, 0x1::string::utf8(b"https://www.degenhive.ai"));
        let v15 = 0x2::display::new_with_fields<HiveAsset>(&v9, v11, v13, arg1);
        0x2::display::update_version<HiveAsset>(&mut v15);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v9, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<HiveProfile>>(v10, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<HiveAsset>>(v15, 0x2::tx_context::sender(arg1));
    }

    public fun initialize_public_kraft(arg0: &0x2::clock::Clock, arg1: &mut HiveProfile, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        authority_check(arg1, 0x2::tx_context::sender(arg5));
        let v0 = get_kiosk_app_name(arg2);
        assert!(arg3 >= 0x2::clock::timestamp_ms(arg0), 1002);
        let v1 = PublicKraftConfig{
            id               : 0x2::object::new(arg5),
            start_time       : arg3,
            per_user_limit   : arg4,
            krafts_processed : 0,
            address_list     : 0x2::linked_table::new<address, u64>(arg5),
        };
        let v2 = 0x1::string::from_ascii(v0);
        0x1::string::append(&mut v2, 0x1::string::utf8(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::public_kraft_storage()));
        let v3 = 0x1::string::to_ascii(v2);
        0x2::dynamic_object_field::add<0x1::ascii::String, PublicKraftConfig>(&mut arg1.id, v3, v1);
        let v4 = AppInstalledByProfile{
            profile_addr : 0x2::object::uid_to_address(&arg1.id),
            username     : arg1.username,
            app_name     : v3,
        };
        0x2::event::emit<AppInstalledByProfile>(v4);
        0x1::vector::push_back<0x1::ascii::String>(&mut arg1.installed_apps, v3);
        let v5 = PublicKraftInitialized{
            collection_name          : arg2,
            kiosk_addr               : 0x2::object::uid_to_address(&borrow_from_profile<HiveKiosk>(arg1, v0).id),
            creator_profile          : 0x2::object::uid_to_address(&arg1.id),
            creator_profile_username : arg1.username,
            start_time               : arg3,
            per_user_limit           : arg4,
        };
        0x2::event::emit<PublicKraftInitialized>(v5);
    }

    public fun insert_assets_in_kiosk(arg0: &mut HiveProfile, arg1: 0x1::string::String, arg2: vector<vector<0x1::string::String>>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &0x2::tx_context::TxContext) {
        authority_check(arg0, 0x2::tx_context::sender(arg5));
        let v0 = get_kiosk_app_name(arg1);
        let v1 = remove_from_profile<HiveKiosk>(arg0, v0);
        assert!(v1.krafted_assets < v1.max_assets_limit, 1132);
        assert!(v1.krafted_assets + 0x1::vector::length<0x1::string::String>(&v1.names_list) + 0x1::vector::length<vector<0x1::string::String>>(&arg2) <= v1.max_assets_limit, 1147);
        let v2 = 0;
        assert!(0x1::vector::length<vector<0x1::string::String>>(&arg2) == 0x1::vector::length<0x1::string::String>(&arg3), 1055);
        assert!(0x1::vector::length<vector<0x1::string::String>>(&arg2) == 0x1::vector::length<0x1::string::String>(&arg4), 1066);
        while (v2 < 0x1::vector::length<vector<0x1::string::String>>(&arg2)) {
            let v3 = 0x1::vector::borrow<vector<0x1::string::String>>(&arg2, v2);
            let v4 = 0x1::vector::borrow<0x1::string::String>(&arg3, v2);
            let v5 = 0x1::vector::borrow<0x1::string::String>(&arg4, v2);
            let v6 = *v3;
            assert!(0x1::vector::length<0x1::string::String>(&v6) == 0x1::vector::length<0x1::string::String>(&v1.traits_list), 1051);
            0x1::vector::push_back<vector<0x1::string::String>>(&mut v1.prompts_list, *v3);
            0x1::vector::push_back<0x1::string::String>(&mut v1.url_list, *v4);
            0x1::vector::push_back<0x1::string::String>(&mut v1.names_list, *v5);
            v2 = v2 + 1;
        };
        let v7 = AssetsInsertedInHiveKiosk{
            creator_profile : 0x2::object::uid_to_address(&arg0.id),
            kiosk_addr      : 0x2::object::uid_to_address(&v1.id),
            collection_name : arg1,
            assets_inserted : 0x1::vector::length<vector<0x1::string::String>>(&arg2),
            url_list        : arg3,
            names_list      : arg4,
            prompts_list    : arg2,
        };
        0x2::event::emit<AssetsInsertedInHiveKiosk>(v7);
        add_to_profile<HiveKiosk>(arg0, v0, v1);
    }

    fun internal_add_app_to_hive_store(arg0: &mut HiveProfileMappingStore, arg1: 0x1::ascii::String, arg2: bool, arg3: bool, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : HiveAppAccessCapability {
        let v0 = HiveAppAccessCapability{
            id                        : 0x2::object::new(arg5),
            app_name                  : arg1,
            only_owner_can_add_app    : arg2,
            only_owner_can_access_app : arg3,
            only_owner_can_remove_app : arg4,
        };
        assert!(!0x2::linked_table::contains<0x1::ascii::String, address>(&arg0.app_names_to_cap_mapping, arg1), 1112);
        0x2::linked_table::push_back<0x1::ascii::String, address>(&mut arg0.app_names_to_cap_mapping, arg1, 0x2::object::uid_to_address(&v0.id));
        let v1 = AppAddedToHiveStore{
            capability_addr           : 0x2::object::uid_to_address(&v0.id),
            app_name                  : arg1,
            only_owner_can_add_app    : arg2,
            only_owner_can_access_app : arg3,
            only_owner_can_remove_app : arg4,
        };
        0x2::event::emit<AppAddedToHiveStore>(v1);
        v0
    }

    fun internal_burn_hive_asset(arg0: &mut HiveManager, arg1: HiveAsset, arg2: address) : (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::HiveGems, 0x2::balance::Balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>) {
        let v0 = 0x2::linked_table::borrow_mut<address, KioskEarnings>(&mut arg0.kiosk_earnings, arg1.kiosk_addr);
        let v1 = 0x2::balance::split<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut v0.liquidity_pool, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::min_u64(5 * 0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&v0.liquidity_pool) / v0.nfts_count, 0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&v0.liquidity_pool)));
        v0.nfts_count = v0.nfts_count - 1;
        let HiveAsset {
            id                 : v2,
            version            : v3,
            power              : _,
            kiosk_addr         : _,
            name               : v6,
            img_url            : _,
            collection_name    : v8,
            prompts            : v9,
            is_borrowed        : _,
            is_staked          : _,
            lockup_duration    : _,
            unlock_timestamp   : _,
            available_gems     : v14,
            claim_index        : _,
            hive_claim_index   : _,
            total_dsui_claimed : _,
            total_gems_claimed : _,
            active_apps        : _,
        } = arg1;
        0x2::linked_table::drop<0x1::string::String, 0x1::string::String>(v9);
        0x2::object::delete(v2);
        update_asset_ownership(arg0, v3, arg2, true);
        let v20 = HiveAssetDestroyed{
            owner_profile   : arg2,
            version         : v3,
            collection_name : v8,
            name            : v6,
            dsui_for_nft    : 0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&v1),
        };
        0x2::event::emit<HiveAssetDestroyed>(v20);
        (v14, v1)
    }

    fun internal_destroy_profile(arg0: &0x2::clock::Clock, arg1: HiveProfile, arg2: &mut HiveProfileMappingStore, arg3: &HiveManager, arg4: &0x2::tx_context::TxContext) {
        assert!(!arg1.is_composable_profile, 1100);
        assert!(*0x2::linked_table::borrow<address, bool>(&arg3.keeper_accounts, 0x2::tx_context::sender(arg4)), 1101);
        assert!(0x2::clock::timestamp_ms(arg0) - arg1.creation_timestamp > 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::min_gap_for_profile_deletion(), 1103);
        assert!(0x2::linked_table::length<u64, HiveAsset>(&arg1.hive_assets) == 0 && 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&arg1.available_gems) == 0 && 0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&arg1.available_dsui) == 0 && 0x2::linked_table::length<u64, ListingRecord>(&arg1.listing_records) == 0 && 0x2::linked_table::length<u64, LendRecord>(&arg1.lend_records) == 0 && 0x2::linked_table::length<u64, BorrowRecord>(&arg1.borrow_records) == 0 && 0x2::linked_table::length<u64, BidRecord>(&arg1.bid_records) == 0, 1102);
        0x2::linked_table::remove<address, address>(&mut arg2.owner_to_profile_mapping, arg1.owner);
        0x2::linked_table::remove<0x1::ascii::String, address>(&mut arg2.username_to_profile_mapping, to_lowercase(arg1.username));
        let v0 = HiveProfileDestroyed{
            username     : arg1.username,
            profile_addr : 0x2::object::uid_to_address(&arg1.id),
            owner        : arg1.owner,
        };
        0x2::event::emit<HiveProfileDestroyed>(v0);
        let HiveProfile {
            id                         : v1,
            username                   : _,
            bio                        : _,
            inscription                : v4,
            creation_timestamp         : _,
            owner                      : _,
            is_composable_profile      : _,
            beehive_plan               : v8,
            subscribers_list           : v9,
            subscriptions_list         : v10,
            available_gems             : v11,
            available_dsui             : v12,
            last_active_epoch          : _,
            entropy_used_for_cur_epoch : _,
            hive_assets                : v15,
            incoming_bids              : v16,
            borrow_records             : v17,
            listing_records            : v18,
            bid_records                : v19,
            lend_records               : v20,
            installed_apps             : v21,
            module_version             : _,
        } = arg1;
        let v23 = v10;
        let v24 = v9;
        0x2::object::delete(v1);
        0x2::linked_table::drop<u64, Inscription>(v4);
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::destroy_zero(v11);
        0x2::balance::destroy_zero<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(v12);
        0x2::table::drop<u8, u64>(v8);
        0x2::linked_table::destroy_empty<u64, HiveAsset>(v15);
        0x2::linked_table::destroy_empty<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(v16);
        0x2::linked_table::destroy_empty<u64, BorrowRecord>(v17);
        0x2::linked_table::destroy_empty<u64, ListingRecord>(v18);
        0x2::linked_table::destroy_empty<u64, BidRecord>(v19);
        0x2::linked_table::destroy_empty<u64, LendRecord>(v20);
        0x1::vector::destroy_empty<0x1::ascii::String>(v21);
        while (0x2::linked_table::length<address, AccessRecord>(&v24) > 0) {
            let v25 = *0x2::linked_table::front<address, AccessRecord>(&v24);
            let (_, _, _, _, _, _, _, _) = destroy_subscription_record(0x2::linked_table::remove<address, AccessRecord>(&mut v24, *0x1::option::borrow<address>(&v25)));
        };
        0x2::linked_table::destroy_empty<address, AccessRecord>(v24);
        while (0x2::linked_table::length<address, AccessRecord>(&v23) > 0) {
            let v34 = *0x2::linked_table::front<address, AccessRecord>(&v23);
            let (_, _, _, _, _, _, _, _) = destroy_subscription_record(0x2::linked_table::remove<address, AccessRecord>(&mut v23, *0x1::option::borrow<address>(&v34)));
        };
        0x2::linked_table::destroy_empty<address, AccessRecord>(v23);
    }

    public fun internal_extract_hive_asset_meta(arg0: &HiveAsset) : (0x1::string::String, u64, 0x1::string::String, 0x1::string::String, vector<0x1::string::String>, vector<0x1::string::String>, u64, u64) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = *0x2::linked_table::front<0x1::string::String, 0x1::string::String>(&arg0.prompts);
        let v3 = 0;
        while (v3 < 0x2::linked_table::length<0x1::string::String, 0x1::string::String>(&arg0.prompts)) {
            let v4 = 0x1::option::borrow<0x1::string::String>(&v2);
            0x1::vector::push_back<0x1::string::String>(&mut v0, *v4);
            0x1::vector::push_back<0x1::string::String>(&mut v1, *0x2::linked_table::borrow<0x1::string::String, 0x1::string::String>(&arg0.prompts, *v4));
            v2 = *0x2::linked_table::next<0x1::string::String, 0x1::string::String>(&arg0.prompts, *v4);
            v3 = v3 + 1;
        };
        (arg0.collection_name, arg0.version, arg0.name, 0x1::string::from_ascii(0x2::url::inner_url(&arg0.img_url)), v0, v1, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&arg0.available_gems), arg0.power)
    }

    fun internal_join_hive_of_profile(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &mut HiveProfile, arg3: &mut HiveProfile, arg4: &mut HiveDisperser, arg5: u8, arg6: u64, arg7: &0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x2::object::uid_to_address(&arg3.id);
        let v2 = 0x2::object::uid_to_address(&arg2.id);
        assert!(v1 != v2, 1087);
        assert!(arg5 == 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::worker_bee_plan() || arg5 == 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::drone_bee_plan() || arg5 == 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::queen_bee_plan(), 1130);
        let v3 = false;
        let v4 = calc_next_payment_timestamp(v0);
        let v5 = arg1.hive_twap.hive_usdc_twap;
        let v6 = 0;
        if (!0x2::linked_table::contains<address, AccessRecord>(&arg2.subscriptions_list, v1)) {
            v3 = true;
            if (arg6 > 0) {
                v6 = calculate_hive_to_charge_for_subscription(v0, arg1, arg6);
            };
            process_subscription_payment_helper(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v5, v4, v6, arg7);
            let v7 = AccessRecord{
                subscriber             : v2,
                subscribed_to          : v1,
                init_timestamp         : 0x2::clock::timestamp_ms(arg0),
                access_type            : arg5,
                access_cost            : arg6,
                next_payment_timestamp : v4,
                total_paid             : v6,
                to_unsubscribe         : false,
            };
            0x2::linked_table::push_back<address, AccessRecord>(&mut arg2.subscriptions_list, v1, v7);
            0x2::linked_table::push_back<address, AccessRecord>(&mut arg3.subscribers_list, v2, v7);
        } else {
            let v8 = 0x2::linked_table::borrow<address, AccessRecord>(&arg2.subscriptions_list, v1);
            if (v8.to_unsubscribe) {
                let v9 = cal_access_price_to_pay_when_switching(v0, v8, arg6);
                let v10 = arg1.hive_twap.hive_usdc_twap;
                if (v9 > 0) {
                    v6 = calculate_hive_to_charge_for_subscription(v0, arg1, v9);
                };
                process_subscription_payment_helper(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v10, v4, v6, arg7);
            };
            let v11 = 0x2::linked_table::borrow_mut<address, AccessRecord>(&mut arg2.subscriptions_list, v1);
            let v12 = 0x2::linked_table::borrow_mut<address, AccessRecord>(&mut arg3.subscribers_list, v2);
            assert!(v0 > v11.next_payment_timestamp, 1096);
            v11.access_type = arg5;
            v11.access_cost = arg6;
            v11.next_payment_timestamp = v4;
            v11.total_paid = v11.total_paid + v6;
            v11.to_unsubscribe = false;
            v12.access_type = arg5;
            v12.access_cost = arg6;
            v12.next_payment_timestamp = v4;
            v12.total_paid = v12.total_paid + v6;
            v12.to_unsubscribe = false;
        };
        let v13 = JoinedHiveOfProfile{
            subscriber_profile_addr : v2,
            hive_owner_profile      : v1,
            subscriber_username     : 0x1::string::from_ascii(arg2.username),
            hive_owner_username     : 0x1::string::from_ascii(arg3.username),
            access_type             : arg5,
            access_cost             : arg6,
            next_payment_timestamp  : v4,
        };
        0x2::event::emit<JoinedHiveOfProfile>(v13);
        v3
    }

    fun internal_kraft_hive_profile(arg0: &0x2::clock::Clock, arg1: bool, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: &mut HiveProfileMappingStore, arg6: &mut HiveManager, arg7: &mut DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg8: 0x2::balance::Balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg9: &mut 0x2::tx_context::TxContext) : HiveProfile {
        let v0 = 0x2::object::new(arg9);
        let v1 = 0x2::object::uid_to_address(&v0);
        assert!(0x1::string::length(&arg3) <= 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::max_bio_length(), 1105);
        assert!(is_valid_profile_name(arg2), 1084);
        let v2 = 0x1::string::to_ascii(arg2);
        let v3 = to_lowercase(v2);
        if (0x2::linked_table::contains<0x1::ascii::String, address>(&arg5.reserved_usernames_to_accessor_mapping, v3)) {
            assert!(0x2::tx_context::sender(arg9) == *0x2::linked_table::borrow<0x1::ascii::String, address>(&arg5.reserved_usernames_to_accessor_mapping, v3), 1126);
        };
        assert!(!0x2::linked_table::contains<0x1::ascii::String, address>(&arg5.username_to_profile_mapping, v3), 1083);
        0x2::linked_table::push_back<0x1::ascii::String, address>(&mut arg5.username_to_profile_mapping, v3, v1);
        if (!arg1) {
            assert!(!0x2::linked_table::contains<address, address>(&arg5.owner_to_profile_mapping, arg4), 1056);
            0x2::linked_table::push_back<address, address>(&mut arg5.owner_to_profile_mapping, arg4, v1);
        } else {
            arg4 = @0x0;
            0x2::linked_table::push_back<0x1::ascii::String, address>(&mut arg5.username_to_comp_profile_mapping, v3, v1);
        };
        0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut arg6.buidlers_royalty, 0x2::balance::split<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut arg8, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div(0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&arg8), 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::admin_fee_profile_kraft(), 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::percent_precision())));
        deposit_dsui_for_hive<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(arg7, arg8);
        let v4 = 0x2::table::new<u8, u64>(arg9);
        0x2::table::add<u8, u64>(&mut v4, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::worker_bee_plan(), 0);
        0x2::table::add<u8, u64>(&mut v4, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::drone_bee_plan(), 0);
        0x2::table::add<u8, u64>(&mut v4, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::queen_bee_plan(), 0);
        let v5 = HiveProfileKrafted{
            name                  : arg2,
            bio                   : arg3,
            new_profile_addr      : v1,
            krafter               : arg4,
            fee                   : arg6.config_params.profile_kraft_fees_sui,
            is_composable_profile : arg1,
        };
        0x2::event::emit<HiveProfileKrafted>(v5);
        let v6 = HiveProfile{
            id                         : v0,
            username                   : v2,
            bio                        : arg3,
            inscription                : 0x2::linked_table::new<u64, Inscription>(arg9),
            creation_timestamp         : 0x2::clock::timestamp_ms(arg0),
            owner                      : arg4,
            is_composable_profile      : arg1,
            beehive_plan               : v4,
            subscribers_list           : 0x2::linked_table::new<address, AccessRecord>(arg9),
            subscriptions_list         : 0x2::linked_table::new<address, AccessRecord>(arg9),
            available_gems             : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::zero(),
            available_dsui             : 0x2::balance::zero<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(),
            last_active_epoch          : 0,
            entropy_used_for_cur_epoch : 0,
            hive_assets                : 0x2::linked_table::new<u64, HiveAsset>(arg9),
            incoming_bids              : 0x2::linked_table::new<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(arg9),
            borrow_records             : 0x2::linked_table::new<u64, BorrowRecord>(arg9),
            listing_records            : 0x2::linked_table::new<u64, ListingRecord>(arg9),
            bid_records                : 0x2::linked_table::new<u64, BidRecord>(arg9),
            lend_records               : 0x2::linked_table::new<u64, LendRecord>(arg9),
            installed_apps             : 0x1::vector::empty<0x1::ascii::String>(),
            module_version             : 0,
        };
        let v7 = &mut v6;
        let v8 = &mut arg6.hive_profile;
        make_forever_subscriber(0x2::clock::timestamp_ms(arg0), v7, v8);
        v6
    }

    fun internal_kraft_hiveverse_asset(arg0: &HiveProfile, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xbd6fb3628e2130230c35df4a964a3727f928e17fe6971ac71f62286646a5a37b::dsui_vault::DSuiVault, arg3: address, arg4: u64, arg5: &mut HiveManager, arg6: &mut HiveKiosk, arg7: 0x2::balance::Balance<0x2::sui::SUI>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, HiveAsset, vector<0x1::string::String>, vector<0x1::string::String>) {
        let v0 = 0x2::object::uid_to_address(&arg6.id);
        let v1 = 0x2::object::uid_to_address(&arg0.id);
        let v2 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::percent_precision();
        let v3 = 0xbd6fb3628e2130230c35df4a964a3727f928e17fe6971ac71f62286646a5a37b::dsui_vault::stake_sui_request(arg1, arg2, 0x2::balance::split<0x2::sui::SUI>(&mut arg7, arg8), 0x1::option::none<address>(), arg9);
        if (!0x2::linked_table::contains<address, KioskEarnings>(&arg5.kiosk_earnings, v0)) {
            let v4 = KioskEarnings{
                liquidity_pool   : 0x2::balance::zero<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(),
                creator_earnings : 0x2::balance::zero<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(),
                nfts_count       : 0,
            };
            0x2::linked_table::push_back<address, KioskEarnings>(&mut arg5.kiosk_earnings, v0, v4);
        };
        let v5 = 0x2::linked_table::borrow_mut<address, KioskEarnings>(&mut arg5.kiosk_earnings, v0);
        0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut v5.creator_earnings, 0x2::balance::split<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut v3, (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256((0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&v3) as u256), (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::creator_share_kraft() as u256), (v2 as u256)) as u64)));
        0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut v5.liquidity_pool, 0x2::balance::split<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut v3, (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256((0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&v3) as u256), (arg6.pool_pct as u256), (v2 as u256)) as u64)));
        v5.nfts_count = v5.nfts_count + 1;
        0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut arg5.buidlers_royalty, v3);
        let v6 = 0x1::vector::length<0x1::string::String>(&arg6.names_list);
        let v7 = if (v6 == 0) {
            0
        } else {
            arg4 % v6
        };
        let v8 = 0x1::vector::remove<vector<0x1::string::String>>(&mut arg6.prompts_list, v7);
        let v9 = 0x1::vector::remove<0x1::string::String>(&mut arg6.url_list, v7);
        let v10 = 0x2::linked_table::new<0x1::string::String, 0x1::string::String>(arg9);
        let v11 = 0x1::vector::empty<0x1::string::String>();
        let v12 = 0x1::vector::empty<0x1::string::String>();
        let v13 = 0;
        while (v13 < 0x1::vector::length<0x1::string::String>(&arg6.traits_list)) {
            let v14 = 0x1::vector::borrow<0x1::string::String>(&arg6.traits_list, v13);
            let v15 = 0x1::vector::borrow<0x1::string::String>(&v8, v13);
            0x2::linked_table::push_back<0x1::string::String, 0x1::string::String>(&mut v10, *v14, *v15);
            0x1::vector::push_back<0x1::string::String>(&mut v11, *v14);
            0x1::vector::push_back<0x1::string::String>(&mut v12, *v15);
            v13 = v13 + 1;
        };
        let v16 = HiveAsset{
            id                 : 0x2::object::new(arg9),
            version            : arg5.active_assets + 1,
            power              : 0,
            kiosk_addr         : v0,
            name               : 0x1::vector::remove<0x1::string::String>(&mut arg6.names_list, v7),
            img_url            : 0x2::url::new_unsafe(0x1::string::to_ascii(v9)),
            collection_name    : arg6.collection_name,
            prompts            : v10,
            is_borrowed        : false,
            is_staked          : false,
            lockup_duration    : 0,
            unlock_timestamp   : 0,
            available_gems     : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::zero(),
            claim_index        : 0,
            hive_claim_index   : 0,
            total_dsui_claimed : 0,
            total_gems_claimed : 0,
            active_apps        : 0x1::vector::empty<0x1::ascii::String>(),
        };
        0x2::linked_table::push_back<u64, address>(&mut arg6.krafted_versions_map, v16.version, v1);
        update_asset_ownership(arg5, v16.version, v1, false);
        let v17 = NewHiveAssetKrafted{
            id                   : 0x2::object::uid_to_inner(&v16.id),
            krafter_profile_addr : v1,
            krafter              : arg3,
            collection_name      : v16.collection_name,
            name                 : v16.name,
            version              : v16.version,
            img_url              : v9,
            genesis_hivegems     : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&v16.available_gems),
            power                : v16.power,
            price                : arg8,
            traits_list          : v11,
            prompts_list         : v12,
        };
        0x2::event::emit<NewHiveAssetKrafted>(v17);
        arg5.active_assets = arg5.active_assets + 1;
        (arg7, v16, v11, v12)
    }

    fun internal_process_subscription_payment(arg0: &mut HiveManager, arg1: &mut HiveDisperser, arg2: address, arg3: address, arg4: 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::HiveGems, arg5: u8, arg6: u64, arg7: u256, arg8: u64, arg9: u64) : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::HiveGems {
        increment_gems_global_index(arg0, arg1);
        let (v0, v1, v2, v3) = process_gems_royalty(arg0, arg4, arg1);
        let v4 = HiveAccessPaymentProcessed{
            subscriber_profile_addr : arg2,
            hive_owner_profile      : arg3,
            access_type             : arg5,
            access_cost             : arg6,
            hive_twap_price         : arg7,
            gems_to_transfer_amt    : arg8,
            total_royalty_amt       : v1,
            treasury_amt            : v2,
            gems_burnt              : v3,
            next_payment_timestamp  : arg9,
        };
        0x2::event::emit<HiveAccessPaymentProcessed>(v4);
        v0
    }

    fun internal_transfer_gems(arg0: &mut HiveProfile, arg1: &mut HiveProfile, arg2: u64) {
        let v0 = GemWithdrawnFromProfile{
            username       : arg0.username,
            profile_addr   : 0x2::object::uid_to_address(&arg0.id),
            withdrawn_gems : arg2,
        };
        0x2::event::emit<GemWithdrawnFromProfile>(v0);
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::join(&mut arg1.available_gems, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::split(&mut arg0.available_gems, arg2));
        let v1 = GemAddedToProfile{
            username       : arg1.username,
            profile_addr   : 0x2::object::uid_to_address(&arg1.id),
            deposited_gems : arg2,
        };
        0x2::event::emit<GemAddedToProfile>(v1);
        if (arg2 > 0) {
            let v2 = HiveGemsTransfered{
                from_username     : arg0.username,
                to_username       : arg1.username,
                from_profile_addr : 0x2::object::uid_to_address(&arg0.id),
                to_profile_addr   : 0x2::object::uid_to_address(&arg1.id),
                gems_transferred  : arg2,
            };
            0x2::event::emit<HiveGemsTransfered>(v2);
        };
    }

    fun internal_transfer_kiosk(arg0: &mut HiveProfileMappingStore, arg1: &mut HiveProfile, arg2: &mut HiveProfile, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = get_kiosk_app_name(arg3);
        let v1 = remove_from_profile<HiveKiosk>(arg1, v0);
        let v2 = 0x2::object::uid_to_address(&v1.id);
        let v3 = 0x2::object::uid_to_address(&arg2.id);
        let v4 = 0x2::linked_table::remove<address, vector<address>>(&mut arg0.profile_to_creator_kiosk_mapping, 0x2::object::uid_to_address(&arg1.id));
        let (_, v6) = 0x1::vector::index_of<address>(&v4, &v2);
        0x1::vector::remove<address>(&mut v4, v6);
        if (0x2::linked_table::contains<address, vector<address>>(&arg0.profile_to_creator_kiosk_mapping, v3)) {
            0x1::vector::push_back<address>(0x2::linked_table::borrow_mut<address, vector<address>>(&mut arg0.profile_to_creator_kiosk_mapping, v3), v2);
        } else {
            let v7 = 0x1::vector::empty<address>();
            0x1::vector::push_back<address>(&mut v7, v2);
            0x2::linked_table::push_back<address, vector<address>>(&mut arg0.profile_to_creator_kiosk_mapping, v3, v7);
        };
        0x2::dynamic_object_field::add<0x1::ascii::String, HiveKiosk>(&mut arg2.id, v0, v1);
        let v8 = AppInstalledByProfile{
            profile_addr : 0x2::object::uid_to_address(&arg2.id),
            username     : arg2.username,
            app_name     : v0,
        };
        0x2::event::emit<AppInstalledByProfile>(v8);
        let v9 = KioskOwnershipTransferred{
            collection_name              : arg3,
            creator_profile              : 0x2::object::uid_to_address(&arg1.id),
            creator_profile_username     : arg1.username,
            new_creator_profile          : 0x2::object::uid_to_address(&arg2.id),
            new_creator_profile_username : arg2.username,
            kiosk                        : v2,
        };
        0x2::event::emit<KioskOwnershipTransferred>(v9);
    }

    fun internal_withdraw_gems(arg0: &mut HiveProfile, arg1: u64) : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::HiveGems {
        if (arg1 > 0) {
            let v0 = GemWithdrawnFromProfile{
                username       : arg0.username,
                profile_addr   : 0x2::object::uid_to_address(&arg0.id),
                withdrawn_gems : arg1,
            };
            0x2::event::emit<GemWithdrawnFromProfile>(v0);
        };
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::split(&mut arg0.available_gems, arg1)
    }

    public fun is_asset_listing_executed(arg0: &MarketPlace<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg1: u64) : bool {
        0x2::linked_table::contains<u64, ExecutedListing<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(&arg0.processed_listings, arg1)
    }

    public fun is_hive_asset_listed(arg0: &MarketPlace<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg1: u64) : bool {
        0x2::linked_table::contains<u64, Listing>(&arg0.active_listings, arg1)
    }

    public fun is_keeper_account(arg0: &HiveManager, arg1: address) : bool {
        *0x2::linked_table::borrow<address, bool>(&arg0.keeper_accounts, arg1)
    }

    public fun is_usable_profile_name(arg0: &HiveProfileMappingStore, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) : bool {
        let v0 = to_lowercase(0x1::string::to_ascii(arg1));
        (0x2::linked_table::contains<0x1::ascii::String, address>(&arg0.username_to_profile_mapping, v0) || 0x2::linked_table::contains<0x1::ascii::String, address>(&arg0.username_to_comp_profile_mapping, v0)) && false || 0x2::linked_table::contains<0x1::ascii::String, address>(&arg0.reserved_usernames_to_accessor_mapping, v0) && *0x2::linked_table::borrow<0x1::ascii::String, address>(&arg0.reserved_usernames_to_accessor_mapping, v0) == 0x2::tx_context::sender(arg2) || is_valid_profile_name(arg1)
    }

    fun is_valid_profile_char(arg0: u8) : bool {
        let v0 = arg0 >= 65 && arg0 <= 90 || arg0 >= 97 && arg0 <= 122;
        let v1 = arg0 >= 48 && arg0 <= 57;
        v0 || v1 || arg0 == 95
    }

    public fun is_valid_profile_name(arg0: 0x1::string::String) : bool {
        let v0 = 0x1::string::to_ascii(arg0);
        if (0x1::ascii::length(&v0) > 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::max_profile_name_length()) {
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

    public fun join_hive_of_profile(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &mut HiveProfile, arg3: &mut HiveProfile, arg4: &mut HiveDisperser, arg5: u8, arg6: bool, arg7: &0x2::tx_context::TxContext) {
        let v0 = 0;
        if (arg6) {
            authority_check(arg3, 0x2::tx_context::sender(arg7));
        } else {
            authority_check(arg2, 0x2::tx_context::sender(arg7));
            v0 = *0x2::table::borrow<u8, u64>(&arg3.beehive_plan, (arg5 as u8));
        };
        internal_join_hive_of_profile(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg7);
    }

    public fun join_hive_of_profile_via_stream(arg0: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::HiveGemKraftCap, arg1: &0x2::clock::Clock, arg2: &mut HiveManager, arg3: &mut HiveProfile, arg4: &mut HiveProfile, arg5: &mut HiveDisperser, arg6: u8, arg7: u64, arg8: &0x2::tx_context::TxContext) : bool {
        internal_join_hive_of_profile(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public entry fun kraft_caps_for_launch(arg0: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::DegenHiveDeployerCap, arg1: &mut HiveManager, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.launch_caps_initialized, 1150);
        let v0 = ManagerAppAccessCapability{
            id       : 0x2::object::new(arg6),
            app_name : arg2,
        };
        let v1 = ManagerAppAccessCapability{
            id       : 0x2::object::new(arg6),
            app_name : arg3,
        };
        let v2 = ManagerAppAccessCapability{
            id       : 0x2::object::new(arg6),
            app_name : arg5,
        };
        let v3 = ManagerAppAccessCapability{
            id       : 0x2::object::new(arg6),
            app_name : arg4,
        };
        0x1::vector::push_back<0x1::ascii::String>(&mut arg1.hive_profile.installed_apps, arg2);
        0x1::vector::push_back<0x1::ascii::String>(&mut arg1.hive_profile.installed_apps, arg3);
        0x1::vector::push_back<0x1::ascii::String>(&mut arg1.hive_profile.installed_apps, arg5);
        0x1::vector::push_back<0x1::ascii::String>(&mut arg1.hive_profile.installed_apps, arg4);
        arg1.launch_caps_initialized = true;
        let v4 = AppInstalledByProfile{
            profile_addr : 0x2::object::uid_to_address(&arg1.hive_profile.id),
            username     : arg1.hive_profile.username,
            app_name     : arg2,
        };
        0x2::event::emit<AppInstalledByProfile>(v4);
        let v5 = AppInstalledByProfile{
            profile_addr : 0x2::object::uid_to_address(&arg1.hive_profile.id),
            username     : arg1.hive_profile.username,
            app_name     : arg3,
        };
        0x2::event::emit<AppInstalledByProfile>(v5);
        let v6 = AppInstalledByProfile{
            profile_addr : 0x2::object::uid_to_address(&arg1.hive_profile.id),
            username     : arg1.hive_profile.username,
            app_name     : arg5,
        };
        0x2::event::emit<AppInstalledByProfile>(v6);
        let v7 = AppInstalledByProfile{
            profile_addr : 0x2::object::uid_to_address(&arg1.hive_profile.id),
            username     : arg1.hive_profile.username,
            app_name     : arg4,
        };
        0x2::event::emit<AppInstalledByProfile>(v7);
        0x2::transfer::public_transfer<ManagerAppAccessCapability>(v0, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_transfer<ManagerAppAccessCapability>(v1, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_transfer<ManagerAppAccessCapability>(v2, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_transfer<ManagerAppAccessCapability>(v3, 0x2::tx_context::sender(arg6));
    }

    public fun kraft_hive_assets_and_return_sui(arg0: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::HiveEntryCap, arg1: &0x2::clock::Clock, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0xbd6fb3628e2130230c35df4a964a3727f928e17fe6971ac71f62286646a5a37b::dsui_vault::DSuiVault, arg4: &mut HiveManager, arg5: &mut HiveProfile, arg6: 0x1::string::String, arg7: &mut HiveProfile, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        authority_check(arg7, 0x2::tx_context::sender(arg10));
        let v0 = kraft_hive_assets_loop(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        0x2::coin::from_balance<0x2::sui::SUI>(v0, arg10)
    }

    fun kraft_hive_assets_loop(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xbd6fb3628e2130230c35df4a964a3727f928e17fe6971ac71f62286646a5a37b::dsui_vault::DSuiVault, arg3: &mut HiveManager, arg4: &mut HiveProfile, arg5: 0x1::string::String, arg6: &mut HiveProfile, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = get_kiosk_app_name(arg5);
        let v1 = remove_from_profile<HiveKiosk>(arg4, v0);
        assert!(arg8 <= 0x1::vector::length<0x1::string::String>(&v1.names_list), 1082);
        let v2 = get_access_level(&arg4.subscribers_list, 0x2::object::uid_to_address(&arg6.id), 0x2::clock::timestamp_ms(arg0));
        assert!(v2 >= v1.kraft_access, 1129);
        let v3 = 0;
        if (v2 >= v1.discount_access) {
            v3 = v1.discount;
        };
        let v4 = 0x2::coin::into_balance<0x2::sui::SUI>(arg7);
        let v5 = 0;
        while (v5 < arg8) {
            let v6 = 0x1::string::from_ascii(v0);
            0x1::string::append(&mut v6, 0x1::string::utf8(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::public_kraft_storage()));
            let v7 = borrow_mut_from_profile<PublicKraftConfig>(arg4, 0x1::string::to_ascii(v6));
            let v8 = &mut v1;
            v4 = execute_public_kraft(arg0, arg1, arg2, arg3, v8, v7, arg6, v3, v4, arg9);
            v5 = v5 + 1;
        };
        add_to_profile<HiveKiosk>(arg4, v0, v1);
        v4
    }

    public fun kraft_hive_profile_and_return_sui<T0: store + key>(arg0: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::HiveEntryCap, arg1: &HiveAppAccessCapability, arg2: &0x2::clock::Clock, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xbd6fb3628e2130230c35df4a964a3727f928e17fe6971ac71f62286646a5a37b::dsui_vault::DSuiVault, arg5: &mut HiveProfileMappingStore, arg6: &mut HiveManager, arg7: &mut DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: T0, arg12: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg5.module_version == 0 && arg6.module_version == 0 && arg7.module_version == 0, 1079);
        let (v0, v1) = stake_sui_for_dsui(arg3, arg4, 0x2::coin::into_balance<0x2::sui::SUI>(arg8), arg6.config_params.profile_kraft_fees_sui, arg12);
        let v2 = 0x2::tx_context::sender(arg12);
        let v3 = internal_kraft_hive_profile(arg2, false, arg9, arg10, v2, arg5, arg6, arg7, v1, arg12);
        let v4 = &mut v3;
        add_app_to_profile<T0>(arg1, v4, arg11, arg12);
        0x2::transfer::share_object<HiveProfile>(v3);
        v0
    }

    public fun kraft_kiosks_for_builder(arg0: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::DegenHiveDeployerCap, arg1: &mut HiveManager, arg2: &mut HiveProfileMappingStore, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut HiveProfile, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.builder_hive_assets;
        assert!(v0 > arg3, 1133);
        arg1.builder_hive_assets = v0 - arg3;
        let v1 = 0x2::tx_context::epoch(arg7);
        kraft_new_hive_kiosk(arg2, arg6, arg3, arg4, arg5, v1, arg7);
    }

    fun kraft_new_hive_kiosk(arg0: &mut HiveProfileMappingStore, arg1: &mut HiveProfile, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg6);
        let v1 = 0x2::object::uid_to_address(&v0);
        let v2 = 0x2::object::uid_to_address(&arg1.id);
        let v3 = get_kiosk_app_name(arg3);
        let v4 = AppInstalledByProfile{
            profile_addr : 0x2::object::uid_to_address(&arg1.id),
            username     : arg1.username,
            app_name     : v3,
        };
        0x2::event::emit<AppInstalledByProfile>(v4);
        let v5 = HiveKiosk{
            id                   : v0,
            creator_profile      : v2,
            collection_name      : arg3,
            img_url              : 0x2::url::new_unsafe(0x1::string::to_ascii(arg4)),
            traits_list          : 0x1::vector::empty<0x1::string::String>(),
            max_assets_limit     : arg2,
            krafted_assets       : 0,
            base_price           : 0,
            curve_a              : 0,
            pool_pct             : 0,
            prompts_list         : 0x1::vector::empty<vector<0x1::string::String>>(),
            url_list             : 0x1::vector::empty<0x1::string::String>(),
            names_list           : 0x1::vector::empty<0x1::string::String>(),
            krafted_versions_map : 0x2::linked_table::new<u64, address>(arg6),
            kraft_access         : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::accessible_by_all_plan(),
            discount_access      : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::accessible_by_all_plan(),
            discount             : 0,
            available_upgrades   : 0x2::linked_table::new<u64, vector<AssetUpgrade>>(arg6),
            module_version       : 0,
        };
        let v6 = HiveKioskInitialized{
            kiosk_addr       : v1,
            creator_profile  : v2,
            time_stream      : arg5,
            collection_name  : arg3,
            img_url          : arg4,
            max_assets_limit : arg2,
        };
        0x2::event::emit<HiveKioskInitialized>(v6);
        0x1::vector::push_back<0x1::ascii::String>(&mut arg1.installed_apps, v3);
        if (0x2::linked_table::contains<address, vector<address>>(&arg0.profile_to_creator_kiosk_mapping, v2)) {
            0x1::vector::push_back<address>(0x2::linked_table::borrow_mut<address, vector<address>>(&mut arg0.profile_to_creator_kiosk_mapping, v2), v1);
        } else {
            let v7 = 0x1::vector::empty<address>();
            0x1::vector::push_back<address>(&mut v7, v1);
            0x2::linked_table::push_back<address, vector<address>>(&mut arg0.profile_to_creator_kiosk_mapping, v2, v7);
        };
        assert!(!0x2::linked_table::contains<0x1::ascii::String, address>(&arg0.kiosk_names_mapping, v3), 1134);
        0x2::linked_table::push_back<0x1::ascii::String, address>(&mut arg0.kiosk_names_mapping, v3, v1);
        add_to_profile<HiveKiosk>(arg1, v3, v5);
    }

    public fun kraft_owned_hive_profile(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xbd6fb3628e2130230c35df4a964a3727f928e17fe6971ac71f62286646a5a37b::dsui_vault::DSuiVault, arg3: &mut HiveProfileMappingStore, arg4: &mut HiveManager, arg5: &mut DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) : (HiveProfile, 0x2::balance::Balance<0x2::sui::SUI>) {
        let (v0, v1) = stake_sui_for_dsui(arg1, arg2, 0x2::coin::into_balance<0x2::sui::SUI>(arg6), arg4.config_params.profile_kraft_fees_sui, arg9);
        let v2 = 0x2::tx_context::sender(arg9);
        (internal_kraft_hive_profile(arg0, true, arg7, arg8, v2, arg3, arg4, arg5, v1, arg9), v0)
    }

    public fun lock_hive_asset(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &mut DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg3: &mut HiveDisperser, arg4: &mut HiveProfile, arg5: u64, arg6: u8, arg7: &0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0 && arg3.module_version == 0 && arg4.module_version == 0, 1079);
        authority_check(arg4, 0x2::tx_context::sender(arg7));
        let v0 = 0x2::clock::timestamp_ms(arg0);
        assert!(0x2::table::contains<u8, u64>(&arg1.supported_lockup_durations, arg6), 1088);
        let v1 = *0x2::table::borrow<u8, u64>(&arg1.supported_lockup_durations, arg6);
        let v2 = v1;
        let (v3, v4) = withdraw_hive_asset(arg0, arg1, arg2, arg3, arg4, arg5, false);
        let v5 = v3;
        0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut arg4.available_dsui, v4);
        assert!(!v5.is_staked, 1082);
        if (v5.is_borrowed) {
            v2 = v1 / 2;
            let v6 = 0x2::linked_table::borrow<u64, BorrowRecord>(&arg4.borrow_records, arg5);
            assert!(v6.lockup_duration == arg6, 1088);
            assert!(v6.start_sec + 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::borrow_locking_window() > v0, 1083);
        };
        v5.is_staked = true;
        v5.power = calc_voting_power(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&v5.available_gems), v2);
        v5.unlock_timestamp = v0 + (arg6 as u64) * 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::month_multiplier();
        v5.lockup_duration = arg6;
        arg1.locked_assets = arg1.locked_assets + 1;
        arg1.active_power = arg1.active_power + (v5.power as u128);
        v5.claim_index = arg2.global_dispersal_index;
        v5.hive_claim_index = arg3.global_dispersal_index;
        let v7 = TotalActivePowerUpdated{
            hive_total_active_power : arg1.active_power,
            total_staked_assets     : arg1.locked_assets,
        };
        0x2::event::emit<TotalActivePowerUpdated>(v7);
        let v8 = HiveAssetStaked{
            username         : arg4.username,
            profile_addr     : 0x2::object::uid_to_address(&arg4.id),
            version          : arg5,
            duration         : arg6,
            new_asset_power  : v5.power,
            unlock_timestamp : v5.unlock_timestamp,
        };
        0x2::event::emit<HiveAssetStaked>(v8);
        if (0x2::linked_table::contains<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(&arg4.incoming_bids, arg5)) {
            let v9 = 0x2::linked_table::borrow_mut<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(&mut arg4.incoming_bids, arg5);
            let v10 = 0;
            while (v10 < 0x1::vector::length<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(v9)) {
                let v11 = 0x1::vector::borrow_mut<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(v9, v10);
                v11.is_valid = false;
                let v12 = BidMarkedInvalid{
                    version        : arg5,
                    bidder_profile : v11.bidder_profile,
                };
                0x2::event::emit<BidMarkedInvalid>(v12);
                v10 = v10 + 1;
            };
        };
        deposit_hive_asset(arg4, v5);
    }

    public entry fun make_bid_with_dsui(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &mut DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg3: &mut MarketPlace<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg4: &mut HiveProfile, arg5: 0x2::coin::Coin<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0 && arg3.module_version == 0, 1079);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::object::uid_to_address(&arg4.id);
        authority_check(arg4, v0);
        let v2 = 0x2::coin::into_balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(arg5);
        assert!(arg7 >= arg1.config_params.min_dsui_bid_allowed, 1040);
        let v3 = 0x2::clock::timestamp_ms(arg0);
        let v4 = 0x2::linked_table::borrow<u64, Listing>(&arg3.active_listings, arg6);
        assert!(v4.start_sec < v3, 1031);
        assert!(v4.expiration_sec > v3, 1032);
        assert!(v4.is_sale_listing, 1042);
        let v5 = get_access_level(&arg4.subscriptions_list, v4.listed_by_profile, v3);
        assert!(v5 >= v4.listing_access, 1129);
        let v6 = v4.min_dsui_price;
        if (v5 >= v4.discount_access) {
            v6 = v4.min_dsui_price - v4.min_dsui_price * v4.discount / 100;
        };
        assert!(v3 < arg8 && arg8 - v3 < 7776000000, 1030);
        if (v4.instant_sale && 0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&v2) >= v6) {
            let v7 = &mut v2;
            let (v8, v9) = execute_sale(arg1, arg3, arg2, arg6, false, v1, arg7, v7);
            update_asset_ownership(arg1, arg6, v1, false);
            deposit_hive_asset(arg4, v8);
            0x2::linked_table::push_back<u64, ExecutedListing<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(&mut arg3.processed_listings, arg6, v9);
        } else {
            let v10 = BidPlaced{
                bidder_profile   : v1,
                username         : arg4.username,
                version          : arg6,
                offer_dsui_price : arg7,
                expiration_sec   : arg8,
                is_asset_listed  : true,
            };
            0x2::event::emit<BidPlaced>(v10);
            let v11 = &mut arg3.available_bids;
            add_bid_to_table(v11, arg6, create_bid(v1, arg7, 0x2::balance::split<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut v2, arg7), arg8, true), arg1.config_params.max_bids_per_asset);
            add_bid_record_to_profile(arg4, arg6, create_bid_record(arg6, arg7, arg8, true));
        };
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::destroy_or_transfer_balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(v2, v0, arg9);
    }

    public entry fun make_bid_with_sui(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xbd6fb3628e2130230c35df4a964a3727f928e17fe6971ac71f62286646a5a37b::dsui_vault::DSuiVault, arg3: &mut HiveManager, arg4: &mut DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg5: &mut MarketPlace<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg6: &mut HiveProfile, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg7);
        let v1 = 0xbd6fb3628e2130230c35df4a964a3727f928e17fe6971ac71f62286646a5a37b::dsui_vault::stake_sui_request(arg1, arg2, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg9), 0x1::option::none<address>(), arg11);
        let v2 = 0x2::coin::from_balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(v1, arg11);
        make_bid_with_dsui(arg0, arg3, arg4, arg5, arg6, v2, arg8, 0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&v1), arg10, arg11);
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg11), arg11);
    }

    public entry fun make_direct_bid_with_dsui(arg0: &0x2::clock::Clock, arg1: &HiveManager, arg2: &mut HiveProfile, arg3: &mut HiveProfile, arg4: 0x2::coin::Coin<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 1079);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::object::uid_to_address(&arg3.id);
        authority_check(arg3, v0);
        assert!(arg6 >= arg1.config_params.min_dsui_bid_allowed, 1040);
        let v2 = 0x2::linked_table::borrow<u64, HiveAsset>(&arg2.hive_assets, arg5);
        assert!(!v2.is_borrowed, 1046);
        assert!(!v2.is_staked, 1053);
        let v3 = 0x2::clock::timestamp_ms(arg0);
        assert!(v3 < arg7 && arg7 - v3 < 7776000000, 1030);
        let v4 = 0x2::coin::into_balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(arg4);
        let v5 = &mut arg2.incoming_bids;
        add_bid_to_table(v5, arg5, create_bid(v1, arg6, 0x2::balance::split<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut v4, arg6), arg7, false), arg1.config_params.max_bids_per_asset);
        add_bid_record_to_profile(arg3, arg5, create_bid_record(arg5, arg6, arg7, false));
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::destroy_or_transfer_balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(v4, v0, arg8);
        let v6 = BidPlaced{
            bidder_profile   : v1,
            username         : arg3.username,
            version          : arg5,
            offer_dsui_price : arg6,
            expiration_sec   : arg7,
            is_asset_listed  : false,
        };
        0x2::event::emit<BidPlaced>(v6);
    }

    public entry fun make_direct_bid_with_sui(arg0: &0x2::clock::Clock, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xbd6fb3628e2130230c35df4a964a3727f928e17fe6971ac71f62286646a5a37b::dsui_vault::DSuiVault, arg3: &HiveManager, arg4: &mut HiveProfile, arg5: &mut HiveProfile, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg6);
        let v1 = 0xbd6fb3628e2130230c35df4a964a3727f928e17fe6971ac71f62286646a5a37b::dsui_vault::stake_sui_request(arg1, arg2, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg8), 0x1::option::none<address>(), arg10);
        let v2 = 0x2::coin::from_balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(v1, arg10);
        make_direct_bid_with_dsui(arg0, arg3, arg4, arg5, v2, arg7, 0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&v1), arg9, arg10);
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg10), arg10);
    }

    fun make_forever_subscriber(arg0: u64, arg1: &mut HiveProfile, arg2: &mut HiveProfile) {
        let v0 = 0x2::object::uid_to_address(&arg1.id);
        let v1 = 0x2::object::uid_to_address(&arg2.id);
        if (0x2::linked_table::contains<address, AccessRecord>(&arg1.subscriptions_list, v1)) {
            return
        };
        let v2 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::forever_subscribe_plan();
        let v3 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::forever_subscribe_plan_length();
        let v4 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::month_multiplier();
        let v5 = AccessRecord{
            subscriber             : v0,
            subscribed_to          : v1,
            init_timestamp         : arg0,
            access_type            : v2,
            access_cost            : 0,
            next_payment_timestamp : arg0 + v3 * v4,
            total_paid             : 0,
            to_unsubscribe         : false,
        };
        0x2::linked_table::push_back<address, AccessRecord>(&mut arg1.subscriptions_list, v1, v5);
        0x2::linked_table::push_back<address, AccessRecord>(&mut arg2.subscribers_list, v0, v5);
        let v6 = JoinedHiveOfProfile{
            subscriber_profile_addr : v0,
            hive_owner_profile      : v1,
            subscriber_username     : 0x1::string::from_ascii(arg1.username),
            hive_owner_username     : 0x1::string::from_ascii(arg2.username),
            access_type             : v2,
            access_cost             : 0,
            next_payment_timestamp  : arg0 + v3 * v4,
        };
        0x2::event::emit<JoinedHiveOfProfile>(v6);
    }

    public fun make_forever_subscriber_of_comp_profile(arg0: u64, arg1: &mut HiveProfile, arg2: &mut HiveProfile, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::uid_to_address(&arg1.id);
        let v1 = 0x2::object::uid_to_address(&arg2.id);
        assert!(arg2.is_composable_profile, 1117);
        authority_check(arg1, 0x2::tx_context::sender(arg3));
        if (0x2::linked_table::contains<address, AccessRecord>(&arg1.subscriptions_list, v1)) {
            return
        };
        let v2 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::forever_subscribe_plan();
        let v3 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::forever_subscribe_plan_length();
        let v4 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::month_multiplier();
        let v5 = AccessRecord{
            subscriber             : v0,
            subscribed_to          : v1,
            init_timestamp         : arg0,
            access_type            : v2,
            access_cost            : 0,
            next_payment_timestamp : arg0 + v3 * v4,
            total_paid             : 0,
            to_unsubscribe         : false,
        };
        0x2::linked_table::push_back<address, AccessRecord>(&mut arg1.subscriptions_list, v1, v5);
        0x2::linked_table::push_back<address, AccessRecord>(&mut arg2.subscribers_list, v0, v5);
        let v6 = JoinedHiveOfProfile{
            subscriber_profile_addr : v0,
            hive_owner_profile      : v1,
            subscriber_username     : 0x1::string::from_ascii(arg1.username),
            hive_owner_username     : 0x1::string::from_ascii(arg2.username),
            access_type             : v2,
            access_cost             : 0,
            next_payment_timestamp  : arg0 + v3 * v4,
        };
        0x2::event::emit<JoinedHiveOfProfile>(v6);
    }

    public fun make_forever_subscriber_via_stream(arg0: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::HiveGemKraftCap, arg1: u64, arg2: &mut HiveProfile, arg3: &mut HiveProfile) {
        make_forever_subscriber(arg1, arg2, arg3);
    }

    public entry fun make_listing(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &mut MarketPlace<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg3: &mut DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg4: &mut HiveDisperser, arg5: &mut HiveProfile, arg6: u64, arg7: u8, arg8: u8, arg9: u64, arg10: u64, arg11: bool, arg12: bool, arg13: bool, arg14: u8, arg15: u64, arg16: u64, arg17: &0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0 && arg4.module_version == 0 && arg3.module_version == 0 && arg5.module_version == 0, 1079);
        let v0 = 0x2::object::uid_to_address(&arg5.id);
        assert!(arg7 <= 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::queen_bee_plan() && arg8 <= 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::queen_bee_plan(), 1130);
        authority_check(arg5, 0x2::tx_context::sender(arg17));
        assert!(arg15 > 0x2::clock::timestamp_ms(arg0) && arg16 > arg15 && arg16 - arg15 < 7776000000, 1002);
        assert!(arg9 < 100, 1109);
        assert!(arg10 >= arg1.config_params.min_dsui_bid_allowed, 1040);
        if (!arg11) {
            assert!(0x2::table::contains<u8, u64>(&arg1.supported_lockup_durations, arg14), 1088);
            assert!(!arg12 && !arg13, 1110);
        } else {
            assert!(arg12 || arg13, 1078);
            if (arg12) {
                assert!(!arg13, 1078);
            } else {
                assert!(arg13, 1078);
            };
        };
        let (v1, v2) = withdraw_hive_asset(arg0, arg1, arg3, arg4, arg5, arg6, false);
        let v3 = v1;
        0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut arg5.available_dsui, v2);
        assert!(!v3.is_borrowed, 1046);
        if (0x2::linked_table::contains<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(&arg5.incoming_bids, arg6)) {
            let v4 = 0x2::linked_table::borrow_mut<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(&mut arg5.incoming_bids, arg6);
            let v5 = 0;
            while (v5 < 0x1::vector::length<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(v4)) {
                let v6 = 0x1::vector::borrow_mut<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(v4, v5);
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
            hive_asset        : v3,
            listing_access    : arg7,
            discount_access   : arg8,
            discount          : arg9,
            min_dsui_price    : arg10,
            is_sale_listing   : arg11,
            instant_sale      : arg12,
            highest_bid_sale  : arg13,
            lockup_duration   : arg14,
            start_sec         : arg15,
            expiration_sec    : arg16,
        };
        let v9 = ListingRecord{
            version          : arg6,
            listing_access   : arg7,
            discount_access  : arg8,
            discount         : arg9,
            min_dsui_price   : arg10,
            is_sale_listing  : arg11,
            instant_sale     : arg12,
            highest_bid_sale : arg13,
            lockup_duration  : arg14,
            start_sec        : arg15,
            expiration_sec   : arg16,
        };
        let v10 = NewListing{
            listed_by_profile : v0,
            listing_access    : arg7,
            discount_access   : arg8,
            discount          : arg9,
            version           : arg6,
            min_dsui_price    : arg10,
            is_sale_listing   : arg11,
            instant_sale      : arg12,
            highest_bid_sale  : arg13,
            lockup_duration   : arg14,
            start_sec         : arg15,
            expiration_sec    : arg16,
        };
        0x2::event::emit<NewListing>(v10);
        0x2::linked_table::push_back<u64, ListingRecord>(&mut arg5.listing_records, arg6, v9);
        0x2::linked_table::push_back<u64, Listing>(&mut arg2.active_listings, arg6, v8);
    }

    fun mark_marketplace_bids_as_invalid(arg0: &mut MarketPlace<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg1: u64) {
        if (0x2::linked_table::contains<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(&arg0.available_bids, arg1)) {
            let v0 = 0x2::linked_table::remove<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(&mut arg0.available_bids, arg1);
            let v1 = 0;
            while (v1 < 0x1::vector::length<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(&v0)) {
                let v2 = 0x1::vector::borrow_mut<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(&mut v0, v1);
                v2.is_listing_live = false;
                v2.is_valid = false;
                let v3 = BidMarkedInvalid{
                    version        : arg1,
                    bidder_profile : v2.bidder_profile,
                };
                0x2::event::emit<BidMarkedInvalid>(v3);
                v1 = v1 + 1;
            };
            0x2::linked_table::push_back<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(&mut arg0.available_bids, arg1, v0);
        };
    }

    public entry fun modify_bid(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &mut DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg3: &mut MarketPlace<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg4: &mut HiveProfile, arg5: 0x2::coin::Coin<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0 && arg3.module_version == 0, 1079);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::object::uid_to_address(&arg4.id);
        authority_check(arg4, v0);
        assert!(0x2::linked_table::contains<u64, BidRecord>(&arg4.bid_records, arg6), 1026);
        let v2 = 0x2::clock::timestamp_ms(arg0);
        let v3 = 0x2::linked_table::borrow<u64, Listing>(&arg3.active_listings, arg6);
        assert!(v3.start_sec < v2, 1031);
        assert!(v3.expiration_sec > v2, 1032);
        let v4 = v3.min_dsui_price;
        if (get_access_level(&arg4.subscriptions_list, v3.listed_by_profile, v2) >= v3.discount_access) {
            v4 = v3.min_dsui_price - v3.min_dsui_price * v3.discount / 100;
        };
        assert!(0x2::linked_table::borrow<u64, BidRecord>(&arg4.bid_records, arg6).expiration_sec > v2, 1071);
        let v5 = 0x2::coin::into_balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(arg5);
        if (v3.instant_sale && arg7 >= v4) {
            let v6 = &mut v5;
            let (v7, v8) = execute_sale(arg1, arg3, arg2, arg6, true, v1, arg7, v6);
            update_asset_ownership(arg1, arg6, v1, false);
            deposit_hive_asset(arg4, v7);
            0x2::linked_table::push_back<u64, ExecutedListing<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(&mut arg3.processed_listings, arg6, v8);
        } else {
            let v9 = 0x2::linked_table::borrow_mut<u64, BidRecord>(&mut arg4.bid_records, arg6);
            update_bid_record(v9, arg7, arg8, v2);
            let v10 = BidModified{
                version          : arg6,
                bidder_profile   : v1,
                offer_dsui_price : arg7,
                expiration_sec   : arg8,
            };
            0x2::event::emit<BidModified>(v10);
            let v11 = 0x2::linked_table::remove<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(&mut arg3.available_bids, arg6);
            let v12 = &mut v11;
            let v13 = &mut v5;
            update_bid_among_bids(v12, v1, arg7, arg8, v13, true, arg6);
            0x2::linked_table::push_back<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(&mut arg3.available_bids, arg6, v11);
        };
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::destroy_or_transfer_balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(v5, v0, arg9);
    }

    public entry fun modify_direct_bid(arg0: &0x2::clock::Clock, arg1: &mut HiveProfile, arg2: &mut HiveProfile, arg3: 0x2::coin::Coin<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0, 1079);
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x2::coin::into_balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(arg3);
        let v2 = 0x2::tx_context::sender(arg7);
        let v3 = 0x2::object::uid_to_address(&arg2.id);
        authority_check(arg2, v2);
        assert!(0x2::linked_table::contains<u64, BidRecord>(&arg2.bid_records, arg4), 1026);
        assert!(0x2::linked_table::contains<u64, HiveAsset>(&arg1.hive_assets, arg4), 1065);
        let v4 = 0x2::linked_table::borrow_mut<u64, BidRecord>(&mut arg2.bid_records, arg4);
        assert!(v4.expiration_sec > v0, 1071);
        update_bid_record(v4, arg5, arg6, v0);
        let v5 = 0x2::linked_table::remove<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(&mut arg1.incoming_bids, arg4);
        let v6 = &mut v5;
        let v7 = &mut v1;
        update_bid_among_bids(v6, v3, arg5, arg6, v7, false, arg4);
        0x2::linked_table::push_back<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(&mut arg1.incoming_bids, arg4, v5);
        let v8 = BidModified{
            version          : arg4,
            bidder_profile   : v3,
            offer_dsui_price : arg5,
            expiration_sec   : arg6,
        };
        0x2::event::emit<BidModified>(v8);
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::coin_helper::destroy_or_transfer_balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(v1, v2, arg7);
    }

    public fun onboard_profile_as_creator(arg0: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::HiveGemKraftCap, arg1: &mut HiveProfileMappingStore, arg2: &mut HiveProfile, arg3: u64, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        kraft_new_hive_kiosk(arg1, arg2, arg3, arg4, 0x1::string::utf8(b""), arg5, arg6);
    }

    public fun port_gems_to_app_via_asset(arg0: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::HiveDaoCapability, arg1: &HiveAppAccessCapability, arg2: &0x2::clock::Clock, arg3: &mut HiveManager, arg4: &mut DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg5: &mut HiveDisperser, arg6: &mut HiveProfile, arg7: u64, arg8: u64, arg9: &0x2::tx_context::TxContext) : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::HiveGems {
        assert!(arg3.module_version == 0 && arg4.module_version == 0 && arg6.module_version == 0, 1079);
        authority_check(arg6, 0x2::tx_context::sender(arg9));
        let (_, _, v2, _) = compute_profile_socialfi_info(arg2, arg3, arg6, arg9);
        increment_global_index(arg3, arg4);
        increment_gems_global_index(arg3, arg5);
        let v4 = 0x2::linked_table::borrow_mut<u64, HiveAsset>(&mut arg6.hive_assets, arg7);
        assert!(0x1::vector::contains<0x1::ascii::String>(&v4.active_apps, &arg1.app_name), 1077);
        let (v5, v6, v7) = claim_accrued_rewards_for_asset(arg2, arg3, arg4, arg5, v4);
        let v8 = v5;
        0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut arg6.available_dsui, v6);
        if (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&v8) > 0) {
            let v9 = GemAddedToProfile{
                username       : arg6.username,
                profile_addr   : 0x2::object::uid_to_address(&arg6.id),
                deposited_gems : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&v8),
            };
            0x2::event::emit<GemAddedToProfile>(v9);
        };
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::join(&mut arg6.available_gems, v8);
        if (v7) {
            let v10 = HiveAssetUnstaked{
                profile_addr : 0x2::object::uid_to_address(&arg6.id),
                version      : arg7,
            };
            0x2::event::emit<HiveAssetUnstaked>(v10);
        };
        assert!(arg8 <= v2, 1122);
        let v11 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::split(&mut v4.available_gems, arg8);
        assert!(!v4.is_staked, 1082);
        let v12 = HiveGemsPortedToApp{
            ported_by_profile  : 0x2::object::uid_to_address(&arg6.id),
            ported_by_username : arg6.username,
            version            : arg7,
            app_name           : arg1.app_name,
            gems_ported        : arg8,
        };
        0x2::event::emit<HiveGemsPortedToApp>(v12);
        v11
    }

    public fun port_hiveasset_to_app(arg0: &HiveAppAccessCapability, arg1: &0x2::clock::Clock, arg2: &mut HiveManager, arg3: &mut DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg4: &mut HiveDisperser, arg5: &mut HiveProfile, arg6: u64, arg7: &0x2::tx_context::TxContext) : HiveAsset {
        assert!(arg2.module_version == 0 && arg3.module_version == 0 && arg5.module_version == 0, 1079);
        authority_check(arg5, 0x2::tx_context::sender(arg7));
        let (v0, v1) = withdraw_hive_asset(arg1, arg2, arg3, arg4, arg5, arg6, false);
        let v2 = v0;
        0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut arg5.available_dsui, v1);
        assert!(!v2.is_staked, 1053);
        assert!(!v2.is_borrowed, 1066);
        update_asset_ownership(arg2, arg6, 0x2::object::uid_to_address(&arg0.id), false);
        let v3 = HiveAssetPortedToApp{
            ported_by_profile  : 0x2::object::uid_to_address(&arg5.id),
            ported_by_username : arg5.username,
            version            : arg6,
            app_name           : arg0.app_name,
        };
        0x2::event::emit<HiveAssetPortedToApp>(v3);
        v2
    }

    public entry fun pow_approx(arg0: u128, arg1: u128, arg2: u128) : u128 {
        let v0 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::precision_constant();
        if (arg0 <= 2) {
            return calculate_pow(arg0, 1, arg1, arg2)
        };
        let v1 = 0;
        while (arg0 >= 2) {
            arg0 = arg0 / 2;
            v1 = v1 + 1;
        };
        let v2 = arg0 * (v0 as u128);
        let v3 = 0;
        while (v3 < v1) {
            v2 = v2 / 2;
            v3 = v3 + 1;
        };
        calculate_pow(2, 1, v1 * arg1, arg2) / (v0 as u128) * calculate_pow(v2, (v0 as u128), arg1, arg2)
    }

    public entry fun pow_approx_frac(arg0: u256, arg1: u128, arg2: u64) : u256 {
        let v0 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::precision_constant();
        let (v1, v2) = sub_sign(arg0, (v0 as u256));
        let v3 = (v0 as u256);
        let v4 = v3;
        let v5 = false;
        let v6 = 0;
        let v7 = 1;
        while (v3 >= (arg2 as u256) && v7 < 32) {
            let (v8, v9) = sub_sign((arg1 as u256), v6);
            let v10 = ((v7 * (v0 as u128)) as u256);
            v6 = v10;
            let v11 = v3 * v8 / (v0 as u256) * v1 / v10;
            v3 = v11;
            if (v11 == 0) {
                break
            };
            if (v2) {
                v5 = !v5;
            };
            if (v9) {
                v5 = !v5;
            };
            if (v5) {
                v4 = v4 - v11;
            } else {
                v4 = v4 + v11;
            };
            v7 = v7 + 1;
        };
        v4
    }

    fun process_gems_royalty(arg0: &mut HiveManager, arg1: 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::HiveGems, arg2: &mut HiveDisperser) : (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::HiveGems, u64, u64, u64) {
        let v0 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::percent_precision();
        let v1 = (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256((0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&arg1) as u256), (arg0.gems_royalty.numerator as u256), (arg0.gems_royalty.denominator as u256)) as u64);
        let v2 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::split(&mut arg1, v1);
        let v3 = (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256((v1 as u256), (arg0.gems_royalty.treasury_percent as u256), (v0 as u256)) as u64);
        let v4 = (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u256((v1 as u256), (arg0.gems_royalty.burn_percent as u256), (v0 as u256)) as u64);
        let v5 = &mut arg0.hive_profile;
        deposit_gems_in_profile(v5, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::split(&mut v2, v3));
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::burn(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::split(&mut v2, v4));
        deposit_gems_for_hive(arg2, v2);
        (arg1, v1, v3, v4)
    }

    fun process_highest_bid_sale_listing(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &mut DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg3: &mut MarketPlace<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg4: u64) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0 && arg3.module_version == 0, 1079);
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x2::linked_table::borrow<u64, Listing>(&arg3.active_listings, arg4);
        if (v1.expiration_sec > v0) {
            return
        };
        assert!(v1.is_sale_listing && v1.highest_bid_sale, 1044);
        let v2 = v1.listed_by_profile;
        let v3 = false;
        if (0x2::linked_table::contains<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(&arg3.available_bids, arg4)) {
            let v4 = v1.min_dsui_price;
            let v5 = 0x2::linked_table::remove<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(&mut arg3.available_bids, arg4);
            let v6 = 0;
            while (v6 < 0x1::vector::length<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(&v5)) {
                let v7 = 0x1::vector::borrow_mut<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(&mut v5, v6);
                v7.is_listing_live = false;
                v7.is_valid = false;
                let v8 = BidMarkedInvalid{
                    version        : arg4,
                    bidder_profile : v7.bidder_profile,
                };
                0x2::event::emit<BidMarkedInvalid>(v8);
                if (v7.expiration_sec > v0) {
                    if (v7.offer_dsui_price >= v4) {
                        v4 = v7.offer_dsui_price;
                        v3 = true;
                    };
                };
                v6 = v6 + 1;
            };
            if (v3) {
                let (v9, _, _, _, _, _, _, _, _, _, _, _) = destroy_listing(0x2::linked_table::remove<u64, Listing>(&mut arg3.active_listings, arg4));
                let v21 = v9;
                let v22 = 0x1::vector::remove<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(&mut v5, 0);
                let v23 = v22.bidder_profile;
                let (v24, _, _, _, _, _) = destroy_bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(v22, arg4);
                let v30 = v24;
                let v31 = 0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&v30);
                let v32 = ExecutedListing<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>{
                    listed_by_profile       : v2,
                    hive_asset              : 0x1::option::some<HiveAsset>(v21),
                    version                 : arg4,
                    was_sale_listing        : true,
                    balance                 : 0x1::option::some<0x2::balance::Balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(process_royalty(v30, arg1, arg2, v21.kiosk_addr)),
                    bidder_profile          : v23,
                    executed_price_in_dsui  : v31,
                    borrow_period_start_sec : 0,
                    borrow_period_end_sec   : 0,
                };
                0x2::linked_table::push_back<u64, ExecutedListing<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(&mut arg3.processed_listings, arg4, v32);
                let v33 = SaleExecuted{
                    version                : arg4,
                    buyer_profile          : v23,
                    seller_profile         : v2,
                    price_paid_dsui        : v31,
                    is_sale_listing        : true,
                    instant_sale           : false,
                    highest_bid_sale       : true,
                    is_direct_bid_accepted : false,
                };
                0x2::event::emit<SaleExecuted>(v33);
            };
            0x2::linked_table::push_back<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(&mut arg3.available_bids, arg4, v5);
        };
        if (!v3) {
            let (v34, _, _, _, _, _, _, _, _, _, _, _) = destroy_listing(0x2::linked_table::remove<u64, Listing>(&mut arg3.active_listings, arg4));
            let v46 = ExecutedListing<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>{
                listed_by_profile       : v2,
                hive_asset              : 0x1::option::some<HiveAsset>(v34),
                version                 : arg4,
                was_sale_listing        : true,
                balance                 : 0x1::option::none<0x2::balance::Balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(),
                bidder_profile          : v2,
                executed_price_in_dsui  : 0,
                borrow_period_start_sec : 0,
                borrow_period_end_sec   : 0,
            };
            0x2::linked_table::push_back<u64, ExecutedListing<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(&mut arg3.processed_listings, arg4, v46);
            let v47 = HighestBidListingUnsold{
                version           : arg4,
                listed_by_profile : v2,
            };
            0x2::event::emit<HighestBidListingUnsold>(v47);
        };
    }

    public entry fun process_highest_bid_sale_listings(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &mut DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg3: &mut MarketPlace<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0, 1079);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg4)) {
            process_highest_bid_sale_listing(arg0, arg1, arg2, arg3, *0x1::vector::borrow<u64>(&arg4, v0));
            v0 = v0 + 1;
        };
    }

    fun process_royalty(arg0: 0x2::balance::Balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg1: &mut HiveManager, arg2: &mut DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg3: address) : 0x2::balance::Balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI> {
        let v0 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::percent_precision();
        let v1 = (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u128((0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&arg0) as u128), (arg1.royalty.numerator as u128), (arg1.royalty.denominator as u128)) as u64);
        let v2 = 0x2::balance::split<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut arg0, v1);
        let v3 = (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u128((0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&v2) as u128), (arg1.royalty.assets_dispersal_percent as u128), (v0 as u128)) as u64);
        let v4 = (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u128((0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&v2) as u128), (arg1.royalty.creators_royalty_percent as u128), (v0 as u128)) as u64);
        deposit_dsui_for_hive<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(arg2, 0x2::balance::split<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut v2, v3));
        let v5 = 0x2::linked_table::borrow_mut<address, KioskEarnings>(&mut arg1.kiosk_earnings, arg3);
        0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut v5.creator_earnings, 0x2::balance::split<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut v2, v4));
        0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut v5.liquidity_pool, 0x2::balance::split<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut v2, (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::math::mul_div_u128((0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&v2) as u128), (0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::pool_royalty_pct() as u128), (v0 as u128)) as u64)));
        0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut arg1.buidlers_royalty, v2);
        let v6 = RoyaltyProcessed{
            total_royalty_amt         : v1,
            hive_dispersal_amt        : v3,
            creator_royalty_amt       : v4,
            accrued_to_fee_cap_holder : 0x2::balance::value<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&v2),
        };
        0x2::event::emit<RoyaltyProcessed>(v6);
        arg0
    }

    public fun process_subscription_payment(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &mut HiveProfile, arg3: &mut HiveProfile, arg4: &mut HiveDisperser, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x2::object::uid_to_address(&arg3.id);
        let v2 = 0x2::object::uid_to_address(&arg2.id);
        let v3 = 0x2::linked_table::borrow<address, AccessRecord>(&arg2.subscriptions_list, v1);
        assert!(v0 > v3.next_payment_timestamp, 1096);
        if (v3.to_unsubscribe) {
            let v4 = ExitHiveOfProfile{
                subscriber_profile_addr        : v2,
                unsubscribed_from_profile_addr : v1,
                subscriber_username            : 0x1::string::from_ascii(arg2.username),
                unhive_owner_username          : 0x1::string::from_ascii(arg3.username),
                records_deleted                : true,
            };
            0x2::event::emit<ExitHiveOfProfile>(v4);
            let (_, _, _, _, _, _, _, _) = destroy_subscription_record(0x2::linked_table::remove<address, AccessRecord>(&mut arg2.subscriptions_list, v1));
            let (_, _, _, _, _, _, _, _) = destroy_subscription_record(0x2::linked_table::remove<address, AccessRecord>(&mut arg3.subscribers_list, v2));
            return
        };
        let v21 = *0x2::table::borrow<u8, u64>(&arg3.beehive_plan, (v3.access_type as u8));
        assert!(v21 <= v3.access_cost, 1094);
        let v22 = 0;
        if (v21 > 0) {
            v22 = calculate_hive_to_charge_for_subscription(v0, arg1, v21);
        };
        let v23 = calc_next_payment_timestamp(v0);
        let v24 = arg1.hive_twap.hive_usdc_twap;
        process_subscription_payment_helper(arg0, arg1, arg2, arg3, arg4, v3.access_type, v21, v24, v23, v22, arg5);
        let v25 = 0x2::linked_table::borrow_mut<address, AccessRecord>(&mut arg2.subscriptions_list, v1);
        let v26 = 0x2::linked_table::borrow_mut<address, AccessRecord>(&mut arg3.subscribers_list, v2);
        v25.next_payment_timestamp = v23;
        v25.total_paid = v25.total_paid + v22;
        v26.next_payment_timestamp = v23;
        v26.total_paid = v26.total_paid + v22;
    }

    fun process_subscription_payment_helper(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &mut HiveProfile, arg3: &mut HiveProfile, arg4: &mut HiveDisperser, arg5: u8, arg6: u64, arg7: u256, arg8: u64, arg9: u64, arg10: &0x2::tx_context::TxContext) {
        let (_, _, v2, _) = compute_profile_socialfi_info(arg0, arg1, arg2, arg10);
        assert!(arg9 <= v2, 1122);
        let v4 = internal_process_subscription_payment(arg1, arg4, 0x2::object::uid_to_address(&arg2.id), 0x2::object::uid_to_address(&arg3.id), 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::split(&mut arg2.available_gems, arg9), arg5, arg6, arg7, arg9, arg8);
        if (arg9 > 0) {
            let v5 = GemWithdrawnFromProfile{
                username       : arg2.username,
                profile_addr   : 0x2::object::uid_to_address(&arg2.id),
                withdrawn_gems : arg9,
            };
            0x2::event::emit<GemWithdrawnFromProfile>(v5);
            let v6 = GemAddedToProfile{
                username       : arg3.username,
                profile_addr   : 0x2::object::uid_to_address(&arg3.id),
                deposited_gems : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&v4),
            };
            0x2::event::emit<GemAddedToProfile>(v6);
        };
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::join(&mut arg3.available_gems, v4);
    }

    public fun remove_app_from_profile<T0: store + key>(arg0: &HiveAppAccessCapability, arg1: &mut HiveProfile, arg2: &0x2::tx_context::TxContext) : T0 {
        0x2::dynamic_object_field::remove<0x1::ascii::String, T0>(&mut arg1.id, arg0.app_name)
    }

    public fun remove_asset_upgrade_from_kiosk(arg0: &mut HiveProfile, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        authority_check(arg0, 0x2::tx_context::sender(arg4));
        let v0 = get_kiosk_app_name(arg1);
        let v1 = remove_from_profile<HiveKiosk>(arg0, v0);
        assert!(0x2::linked_table::contains<u64, address>(&v1.krafted_versions_map, arg2), 1079);
        let AssetUpgrade {
            upgrade_price       : _,
            upgrade_access      : _,
            upgrade_img_url     : _,
            upgrade_traits_list : _,
            upgrade_prompts     : v6,
        } = 0x1::vector::remove<AssetUpgrade>(0x2::linked_table::borrow_mut<u64, vector<AssetUpgrade>>(&mut v1.available_upgrades, arg2), arg3);
        0x2::table::drop<0x1::string::String, 0x1::string::String>(v6);
        let v7 = RemovedUpgradeForVersion{
            creator_profile_addr : 0x2::object::uid_to_address(&arg0.id),
            collection_name      : arg1,
            version              : arg2,
            upgrade_index        : arg3,
        };
        0x2::event::emit<RemovedUpgradeForVersion>(v7);
        add_to_profile<HiveKiosk>(arg0, v0, v1);
    }

    public fun remove_from_composable_profile<T0: store + key>(arg0: &mut HiveProfile, arg1: 0x1::ascii::String) : T0 {
        assert!(arg0.is_composable_profile, 1116);
        0x2::dynamic_object_field::remove<0x1::ascii::String, T0>(&mut arg0.id, arg1)
    }

    public fun remove_from_manager_profile<T0: store + key>(arg0: &ManagerAppAccessCapability, arg1: &mut HiveManager) : T0 {
        0x2::dynamic_object_field::remove<0x1::ascii::String, T0>(&mut arg1.hive_profile.id, arg0.app_name)
    }

    fun remove_from_profile<T0: store + key>(arg0: &mut HiveProfile, arg1: 0x1::ascii::String) : T0 {
        0x2::dynamic_object_field::remove<0x1::ascii::String, T0>(&mut arg0.id, arg1)
    }

    public fun remove_from_reserved_usernames_list(arg0: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::DegenHiveDeployerCap, arg1: &mut HiveProfileMappingStore, arg2: vector<0x1::string::String>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            let v1 = to_lowercase(0x1::string::to_ascii(*0x1::vector::borrow<0x1::string::String>(&arg2, v0)));
            if (0x2::linked_table::contains<0x1::ascii::String, address>(&arg1.reserved_usernames_to_accessor_mapping, v1)) {
                0x2::linked_table::remove<0x1::ascii::String, address>(&mut arg1.reserved_usernames_to_accessor_mapping, v1);
            };
            v0 = v0 + 1;
        };
    }

    public fun remove_store_from_asset<T0: store + key>(arg0: &HiveAppAccessCapability, arg1: &mut HiveAsset) : T0 {
        0x2::dynamic_object_field::remove<0x1::ascii::String, T0>(&mut arg1.id, arg0.app_name)
    }

    public entry fun return_borrowed_hive_asset(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &mut DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg3: &mut HiveDisperser, arg4: &mut HiveProfile, arg5: &mut HiveProfile, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0 && arg3.module_version == 0, 1079);
        assert!(0x2::linked_table::contains<u64, LendRecord>(&arg4.lend_records, arg6) && 0x2::linked_table::contains<u64, BorrowRecord>(&arg5.borrow_records, arg6), 1063);
        let v0 = 0x2::linked_table::remove<u64, BorrowRecord>(&mut arg5.borrow_records, arg6);
        if (0x2::tx_context::sender(arg7) != arg5.owner) {
            assert!(v0.expiration_sec < 0x2::clock::timestamp_ms(arg0), 1063);
        };
        let (_, _, _, _, _) = destroy_borrow_record(v0);
        let (v6, v7) = withdraw_hive_asset(arg0, arg1, arg2, arg3, arg5, arg6, false);
        let v8 = v6;
        0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut arg5.available_dsui, v7);
        v8.is_borrowed = false;
        deposit_hive_asset(arg4, v8);
        let (_, _, _, _, _, _) = destroy_lend_record(0x2::linked_table::remove<u64, LendRecord>(&mut arg4.lend_records, arg6));
        let v15 = ReturnBorrowedHiveAsset{
            version          : arg6,
            owner            : arg4.owner,
            borrower_profile : 0x2::object::uid_to_address(&arg5.id),
        };
        0x2::event::emit<ReturnBorrowedHiveAsset>(v15);
    }

    public fun set_suins_domain_as_username(arg0: &0x2::clock::Clock, arg1: &HiveManager, arg2: &mut HiveProfileMappingStore, arg3: &mut HiveDisperser, arg4: &mut HiveProfile, arg5: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg6: &0x2::tx_context::TxContext) {
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain_name(arg5);
        let v1 = 0x1::string::to_ascii(v0);
        let v2 = to_lowercase(v1);
        authority_check(arg4, 0x2::tx_context::sender(arg6));
        assert!(!0x2::linked_table::contains<0x1::ascii::String, address>(&arg2.username_to_profile_mapping, v2), 1135);
        increment_gems_global_index(arg1, arg3);
        let (_, _, v5, _) = compute_profile_socialfi_info(arg0, arg1, arg4, arg6);
        let v7 = arg1.config_params.social_fee_gems;
        assert!(v7 <= v5, 1122);
        deposit_gems_for_hive(arg3, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::split(&mut arg4.available_gems, v7));
        if (v7 > 0) {
            let v8 = GemWithdrawnFromProfile{
                username       : arg4.username,
                profile_addr   : 0x2::object::uid_to_address(&arg4.id),
                withdrawn_gems : v7,
            };
            0x2::event::emit<GemWithdrawnFromProfile>(v8);
        };
        let v9 = arg4.username;
        0x2::linked_table::remove<0x1::ascii::String, address>(&mut arg2.username_to_profile_mapping, to_lowercase(v9));
        arg4.username = v1;
        0x2::linked_table::push_back<0x1::ascii::String, address>(&mut arg2.username_to_profile_mapping, v2, 0x2::object::uid_to_address(&arg4.id));
        0x2::linked_table::push_back<0x1::ascii::String, u64>(&mut arg2.suins_name_to_expiry_mapping, v2, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::expiration_timestamp_ms(arg5));
        let v10 = UserNameUpdated{
            profile_addr  : 0x2::object::uid_to_address(&arg4.id),
            prev_username : 0x1::string::from_ascii(v9),
            new_username  : v0,
        };
        0x2::event::emit<UserNameUpdated>(v10);
    }

    public entry fun setup_hive_manager(arg0: &mut 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::DegenHiveDeployerCap, arg1: &0x2::clock::Clock, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: vector<u8>, arg13: vector<u64>, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg12) == 0x1::vector::length<u64>(&arg13), 1087);
        assert!(arg10 > arg11 && arg11 > 0, 1124);
        let v0 = 0x2::table::new<u8, u64>(arg15);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg12)) {
            0x2::table::add<u8, u64>(&mut v0, *0x1::vector::borrow<u8>(&arg12, v1), *0x1::vector::borrow<u64>(&arg13, v1));
            v1 = v1 + 1;
        };
        let v2 = 0x2::table::new<u8, u64>(arg15);
        0x2::table::add<u8, u64>(&mut v2, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::worker_bee_plan(), 0);
        0x2::table::add<u8, u64>(&mut v2, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::drone_bee_plan(), 0);
        0x2::table::add<u8, u64>(&mut v2, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::queen_bee_plan(), 0);
        let v3 = HiveProfile{
            id                         : 0x2::object::new(arg15),
            username                   : 0x1::string::to_ascii(arg2),
            bio                        : arg3,
            inscription                : 0x2::linked_table::new<u64, Inscription>(arg15),
            creation_timestamp         : 0x2::clock::timestamp_ms(arg1),
            owner                      : @0x0,
            is_composable_profile      : true,
            beehive_plan               : v2,
            subscribers_list           : 0x2::linked_table::new<address, AccessRecord>(arg15),
            subscriptions_list         : 0x2::linked_table::new<address, AccessRecord>(arg15),
            available_gems             : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::zero(),
            available_dsui             : 0x2::balance::zero<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(),
            last_active_epoch          : 0,
            entropy_used_for_cur_epoch : 0,
            hive_assets                : 0x2::linked_table::new<u64, HiveAsset>(arg15),
            incoming_bids              : 0x2::linked_table::new<u64, vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>>(arg15),
            borrow_records             : 0x2::linked_table::new<u64, BorrowRecord>(arg15),
            listing_records            : 0x2::linked_table::new<u64, ListingRecord>(arg15),
            bid_records                : 0x2::linked_table::new<u64, BidRecord>(arg15),
            lend_records               : 0x2::linked_table::new<u64, LendRecord>(arg15),
            installed_apps             : 0x1::vector::empty<0x1::ascii::String>(),
            module_version             : 0,
        };
        let v4 = HiveProfileKrafted{
            name                  : arg2,
            bio                   : arg3,
            new_profile_addr      : 0x2::object::uid_to_address(&v3.id),
            krafter               : @0x0,
            fee                   : arg8,
            is_composable_profile : true,
        };
        0x2::event::emit<HiveProfileKrafted>(v4);
        let v5 = ConfigParams{
            max_bids_per_asset          : arg6,
            min_dsui_bid_allowed        : arg7,
            profile_kraft_fees_sui      : arg8,
            social_fee_gems             : arg9,
            social_multiplier_for_gems  : arg11,
            social_multiplier_for_power : arg10,
        };
        let v6 = Royalty{
            numerator                : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::nfts_royalty_num(),
            denominator              : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::percent_precision(),
            assets_dispersal_percent : arg4,
            creators_royalty_percent : arg5,
        };
        let v7 = SubscriptionRoyalty{
            numerator        : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::socials_royalty_num(),
            denominator      : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::percent_precision(),
            treasury_percent : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::hive_treasury_pct(),
            burn_percent     : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::hive_burn_pct(),
        };
        let v8 = HiveTwapInfo{
            last_update_timestamp : 0,
            hive_sui_twap         : 0,
            sui_usdc_twap         : 0,
            hive_usdc_twap        : 0,
        };
        let v9 = HiveManager{
            id                         : 0x2::object::new(arg15),
            hive_profile               : v3,
            config_params              : v5,
            active_assets              : 0,
            locked_assets              : 0,
            assets_to_profile_mapping  : 0x2::linked_table::new<u64, address>(arg15),
            active_power               : 0,
            supported_lockup_durations : v0,
            royalty                    : v6,
            gems_royalty               : v7,
            hive_twap                  : v8,
            buidlers_royalty           : 0x2::balance::zero<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(),
            kiosk_earnings             : 0x2::linked_table::new<address, KioskEarnings>(arg15),
            keeper_accounts            : 0x2::linked_table::new<address, bool>(arg15),
            builder_hive_assets        : arg14,
            launch_caps_initialized    : false,
            module_version             : 0,
        };
        0x2::transfer::share_object<HiveManager>(v9);
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::manager_setup_by_deployer(arg0);
    }

    fun stake_sui_for_dsui(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut 0xbd6fb3628e2130230c35df4a964a3727f928e17fe6971ac71f62286646a5a37b::dsui_vault::DSuiVault, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>) {
        (arg2, 0xbd6fb3628e2130230c35df4a964a3727f928e17fe6971ac71f62286646a5a37b::dsui_vault::stake_sui_request(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut arg2, arg3), 0x1::option::none<address>(), arg4))
    }

    fun sub_sign(arg0: u256, arg1: u256) : (u256, bool) {
        if (arg0 >= arg1) {
            return (arg0 - arg1, false)
        };
        (arg1 - arg0, true)
    }

    public entry fun switch_access_type(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &mut HiveDisperser, arg3: &mut HiveProfile, arg4: &mut HiveProfile, arg5: u8, arg6: &0x2::tx_context::TxContext) {
        authority_check(arg3, 0x2::tx_context::sender(arg6));
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x2::object::uid_to_address(&arg4.id);
        let v2 = 0x2::object::uid_to_address(&arg3.id);
        let (_, _, v5, _) = compute_profile_socialfi_info(arg0, arg1, arg3, arg6);
        let v7 = 0x2::linked_table::borrow_mut<address, AccessRecord>(&mut arg3.subscriptions_list, v1);
        let v8 = 0x2::linked_table::borrow_mut<address, AccessRecord>(&mut arg4.subscribers_list, v2);
        assert!(!v7.to_unsubscribe, 1092);
        let v9 = *0x2::table::borrow<u8, u64>(&arg4.beehive_plan, arg5);
        let v10 = cal_access_price_to_pay_when_switching(v0, v7, v9);
        let v11 = arg1.hive_twap.hive_usdc_twap;
        let v12 = 0;
        if (v10 > 0) {
            v12 = calculate_hive_to_charge_for_subscription(v0, arg1, v10);
        };
        assert!(v12 <= v5, 1122);
        let v13 = calc_next_payment_timestamp(v0);
        let v14 = internal_process_subscription_payment(arg1, arg2, v2, v1, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::split(&mut arg3.available_gems, v12), v7.access_type, v9, v11, v12, v13);
        if (v12 > 0) {
            let v15 = GemWithdrawnFromProfile{
                username       : arg3.username,
                profile_addr   : 0x2::object::uid_to_address(&arg3.id),
                withdrawn_gems : v12,
            };
            0x2::event::emit<GemWithdrawnFromProfile>(v15);
            let v16 = GemAddedToProfile{
                username       : arg4.username,
                profile_addr   : 0x2::object::uid_to_address(&arg4.id),
                deposited_gems : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&v14),
            };
            0x2::event::emit<GemAddedToProfile>(v16);
        };
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::join(&mut arg4.available_gems, v14);
        v7.next_payment_timestamp = v13;
        v7.total_paid = v7.total_paid + v12;
        v7.access_type = arg5;
        v7.access_cost = v9;
        v8.next_payment_timestamp = v13;
        v8.total_paid = v8.total_paid + v12;
        v8.access_type = arg5;
        v8.access_cost = v9;
        let v17 = AccessTypeSwitchedToNewPlan{
            subscriber_profile_addr   : v2,
            hive_owner_profile        : v1,
            subscriber_username       : 0x1::string::from_ascii(arg3.username),
            hive_owner_username       : 0x1::string::from_ascii(arg4.username),
            new_access_type           : arg5,
            new_access_cost           : v9,
            subscription_price_to_pay : v10,
            hive_paid_for_switch      : v12,
            next_payment_timestamp    : v13,
        };
        0x2::event::emit<AccessTypeSwitchedToNewPlan>(v17);
    }

    public fun to_lowercase(arg0: 0x1::ascii::String) : 0x1::ascii::String {
        let v0 = 0x1::ascii::into_bytes(arg0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v0)) {
            let v3 = 0x1::vector::borrow<u8>(&v0, v2);
            if (*v3 >= 65 && *v3 <= 90) {
                0x1::vector::push_back<u8>(&mut v1, *v3 + 32);
            } else {
                0x1::vector::push_back<u8>(&mut v1, *v3);
            };
            v2 = v2 + 1;
        };
        0x1::ascii::string(v1)
    }

    public entry fun transfer_hive_asset(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &mut DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg3: &mut HiveDisperser, arg4: &mut HiveProfile, arg5: &mut HiveProfile, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0 && arg3.module_version == 0 && arg4.module_version == 0 && arg5.module_version == 0, 1079);
        authority_check(arg4, 0x2::tx_context::sender(arg7));
        let (v0, v1) = withdraw_hive_asset(arg0, arg1, arg2, arg3, arg4, arg6, false);
        let v2 = v0;
        0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut arg4.available_dsui, v1);
        assert!(!v2.is_borrowed, 1066);
        deposit_hive_asset(arg5, v2);
        update_asset_ownership(arg1, arg6, 0x2::object::uid_to_address(&arg5.id), false);
        let v3 = HiveAssetTransfered{
            version      : arg6,
            from_profile : 0x2::object::uid_to_address(&arg4.id),
            to_profile   : 0x2::object::uid_to_address(&arg5.id),
        };
        0x2::event::emit<HiveAssetTransfered>(v3);
    }

    public entry fun transfer_hive_gems(arg0: &0x2::clock::Clock, arg1: &HiveManager, arg2: &mut HiveProfile, arg3: &mut HiveProfile, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        if (arg2.owner == 0x2::tx_context::sender(arg5)) {
            let (_, _, v2, _) = compute_profile_socialfi_info(arg0, arg1, arg2, arg5);
            assert!(arg4 <= v2, 1122);
            internal_transfer_gems(arg2, arg3, arg4);
        } else {
            transfer_hive_gems_via_comp_profile(arg2, arg3, arg4, arg5);
        };
    }

    public entry fun transfer_hive_gems_via_comp_profile(arg0: &mut HiveProfile, arg1: &mut HiveProfile, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.is_composable_profile, 1057);
        internal_transfer_gems(arg0, arg1, arg2);
    }

    public fun transfer_hive_treasury_funds(arg0: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::HiveDaoCapability, arg1: &mut HiveManager, arg2: u64) : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::HiveGems {
        assert!(arg1.module_version == 0, 1079);
        assert!(0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&arg1.hive_profile.available_gems) >= arg2, 1145);
        let v0 = HiveWithdrawnFromTreasury{hive_withdrawn: arg2};
        0x2::event::emit<HiveWithdrawnFromTreasury>(v0);
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::split(&mut arg1.hive_profile.available_gems, arg2)
    }

    public fun transfer_kiosk(arg0: &mut HiveProfileMappingStore, arg1: &mut HiveProfile, arg2: &mut HiveProfile, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        authority_check(arg1, 0x2::tx_context::sender(arg4));
        internal_transfer_kiosk(arg0, arg1, arg2, arg3, arg4);
    }

    public fun transfer_kiosk_by_admin(arg0: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::DegenHiveDeployerCap, arg1: &mut HiveProfileMappingStore, arg2: &mut HiveProfile, arg3: &mut HiveProfile, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        internal_transfer_kiosk(arg1, arg2, arg3, arg4, arg5);
    }

    public fun unlock_hive_asset(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &mut DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg3: &mut HiveDisperser, arg4: &mut HiveProfile, arg5: u64) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0 && arg3.module_version == 0 && arg4.module_version == 0, 1079);
        let v0 = 0x2::linked_table::borrow<u64, HiveAsset>(&arg4.hive_assets, arg5);
        assert!(v0.is_staked, 1085);
        assert!(v0.unlock_timestamp < 0x2::clock::timestamp_ms(arg0), 1089);
        let (v1, v2) = withdraw_hive_asset(arg0, arg1, arg2, arg3, arg4, arg5, true);
        let v3 = v1;
        0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut arg4.available_dsui, v2);
        assert!(!v3.is_staked, 1091);
        deposit_hive_asset(arg4, v3);
    }

    fun unstake_hive_asset(arg0: &mut HiveManager, arg1: &mut HiveAsset) {
        arg0.active_power = arg0.active_power - (arg1.power as u128);
        arg0.locked_assets = arg0.locked_assets - 1;
        let v0 = TotalActivePowerUpdated{
            hive_total_active_power : arg0.active_power,
            total_staked_assets     : arg0.locked_assets,
        };
        0x2::event::emit<TotalActivePowerUpdated>(v0);
        arg1.is_staked = false;
        arg1.power = 0;
        arg1.lockup_duration = 0;
    }

    fun update_asset_ownership(arg0: &mut HiveManager, arg1: u64, arg2: address, arg3: bool) {
        if (arg3) {
            0x2::linked_table::remove<u64, address>(&mut arg0.assets_to_profile_mapping, arg1);
            return
        };
        if (0x2::linked_table::contains<u64, address>(&arg0.assets_to_profile_mapping, arg1)) {
            *0x2::linked_table::borrow_mut<u64, address>(&mut arg0.assets_to_profile_mapping, arg1) = arg2;
        } else {
            0x2::linked_table::push_back<u64, address>(&mut arg0.assets_to_profile_mapping, arg1, arg2);
        };
    }

    fun update_bid_among_bids(arg0: &mut vector<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::balance::Balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg5: bool, arg6: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(arg0)) {
            let v1 = 0x1::vector::borrow<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(arg0, v0);
            if (v1.bidder_profile == arg1) {
                assert!(v1.is_valid, 1069);
                let (v2, _, _, _, _, _) = destroy_bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(0x1::vector::remove<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(arg0, v0), arg6);
                0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(arg4, v2);
                let v8 = Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>{
                    bidder_profile   : arg1,
                    balance          : 0x2::balance::split<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(arg4, arg2),
                    offer_dsui_price : arg2,
                    expiration_sec   : arg3,
                    is_listing_live  : arg5,
                    is_valid         : true,
                };
                0x1::vector::push_back<Bid<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>>(arg0, v8);
                return
            };
            v0 = v0 + 1;
        };
    }

    fun update_bid_record(arg0: &mut BidRecord, arg1: u64, arg2: u64, arg3: u64) {
        arg0.offer_dsui_price = arg1;
        if (arg2 > arg3) {
            assert!(arg2 - arg3 < 7776000000, 1030);
            arg0.expiration_sec = arg2;
        };
    }

    public fun update_bio(arg0: &0x2::clock::Clock, arg1: &HiveManager, arg2: &mut HiveDisperser, arg3: &mut HiveProfile, arg4: 0x1::string::String, arg5: &0x2::tx_context::TxContext) {
        authority_check(arg3, 0x2::tx_context::sender(arg5));
        assert!(0x1::string::length(&arg4) <= 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::max_bio_length(), 1105);
        increment_gems_global_index(arg1, arg2);
        let (_, _, v2, _) = compute_profile_socialfi_info(arg0, arg1, arg3, arg5);
        let v4 = arg1.config_params.social_fee_gems;
        assert!(v4 <= v2, 1122);
        deposit_gems_for_hive(arg2, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::split(&mut arg3.available_gems, v4));
        if (v4 > 0) {
            let v5 = GemWithdrawnFromProfile{
                username       : arg3.username,
                profile_addr   : 0x2::object::uid_to_address(&arg3.id),
                withdrawn_gems : v4,
            };
            0x2::event::emit<GemWithdrawnFromProfile>(v5);
        };
        arg3.bio = arg4;
        let v6 = BioUpdated{
            profile_addr : 0x2::object::uid_to_address(&arg3.id),
            username     : 0x1::string::from_ascii(arg3.username),
            new_bio      : arg3.bio,
        };
        0x2::event::emit<BioUpdated>(v6);
    }

    public fun update_hive_manager_params(arg0: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::HiveDaoCapability, arg1: &mut HiveManager, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        assert!(arg1.module_version == 0, 1079);
        if (arg2 > 0) {
            assert!(5 <= arg2 && 500 >= arg2, 1082);
            arg1.config_params.max_bids_per_asset = arg2;
        };
        if (arg3 > 0) {
            arg1.config_params.min_dsui_bid_allowed = arg3;
        };
        if (arg4 > 0) {
            assert!(0 <= arg4 && 50000000000 >= arg4, 1080);
            arg1.config_params.profile_kraft_fees_sui = arg4;
        };
        if (arg5 > 0) {
            assert!(1000000 <= arg5 && 1000000000 >= arg5, 1080);
            arg1.config_params.social_fee_gems = arg5;
        };
        if (arg6 > 0) {
            assert!(1 <= arg6 && 10 >= arg6, 1120);
            assert!(arg1.config_params.social_multiplier_for_power > arg6, 1120);
            arg1.config_params.social_multiplier_for_gems = arg6;
        };
        if (arg7 > 0) {
            assert!(1 <= arg7 && 100 >= arg7, 1121);
            assert!(arg7 > arg1.config_params.social_multiplier_for_gems, 1121);
            arg1.config_params.social_multiplier_for_power = arg7;
        };
        let v0 = ProfileConfigParamsUpdated{
            max_bids_per_asset          : arg1.config_params.max_bids_per_asset,
            min_dsui_bid_allowed        : arg1.config_params.min_dsui_bid_allowed,
            profile_kraft_fees_sui      : arg1.config_params.profile_kraft_fees_sui,
            social_fee_gems             : arg1.config_params.social_fee_gems,
            social_multiplier_for_gems  : arg1.config_params.social_multiplier_for_gems,
            social_multiplier_for_power : arg1.config_params.social_multiplier_for_power,
        };
        0x2::event::emit<ProfileConfigParamsUpdated>(v0);
    }

    public fun update_hive_twap_info(arg0: &TwapUpdateCap, arg1: &0x2::clock::Clock, arg2: &mut HiveManager, arg3: u256, arg4: u256, arg5: u256) {
        arg2.hive_twap.last_update_timestamp = 0x2::clock::timestamp_ms(arg1);
        arg2.hive_twap.hive_sui_twap = arg3;
        arg2.hive_twap.sui_usdc_twap = arg4;
        arg2.hive_twap.hive_usdc_twap = arg5;
        let v0 = HiveTwapUpdated{
            timestamp      : 0x2::clock::timestamp_ms(arg1),
            hive_sui_twap  : arg3,
            sui_usdc_twap  : arg4,
            hive_usdc_twap : arg5,
        };
        0x2::event::emit<HiveTwapUpdated>(v0);
    }

    public fun update_inscription(arg0: &0x2::clock::Clock, arg1: &HiveManager, arg2: &mut HiveDisperser, arg3: &mut HiveProfile, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: &0x2::tx_context::TxContext) {
        authority_check(arg3, 0x2::tx_context::sender(arg6));
        increment_gems_global_index(arg1, arg2);
        let (_, _, v2, _) = compute_profile_socialfi_info(arg0, arg1, arg3, arg6);
        let v4 = arg1.config_params.social_fee_gems;
        assert!(v4 <= v2, 1122);
        deposit_gems_for_hive(arg2, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::split(&mut arg3.available_gems, v4));
        if (v4 > 0) {
            let v5 = GemWithdrawnFromProfile{
                username       : arg3.username,
                profile_addr   : 0x2::object::uid_to_address(&arg3.id),
                withdrawn_gems : v4,
            };
            0x2::event::emit<GemWithdrawnFromProfile>(v5);
        };
        if (0x2::linked_table::contains<u64, Inscription>(&arg3.inscription, 42)) {
            let v6 = 0x2::linked_table::borrow_mut<u64, Inscription>(&mut arg3.inscription, 42);
            v6.format = arg4;
            v6.base64 = arg5;
        } else {
            let v7 = Inscription{
                format : arg4,
                base64 : arg5,
            };
            0x2::linked_table::push_back<u64, Inscription>(&mut arg3.inscription, 42, v7);
        };
        let v8 = InscriptionSetForProfile{
            profile_addr : 0x2::object::uid_to_address(&arg3.id),
            username     : 0x1::string::from_ascii(arg3.username),
            format       : arg4,
            base64       : arg5,
        };
        0x2::event::emit<InscriptionSetForProfile>(v8);
    }

    public fun update_keeper_accounts_list(arg0: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::DegenHiveDeployerCap, arg1: &mut HiveManager, arg2: address, arg3: bool) {
        if (!0x2::linked_table::contains<address, bool>(&arg1.keeper_accounts, arg2) && arg3) {
            0x2::linked_table::push_back<address, bool>(&mut arg1.keeper_accounts, arg2, arg3);
        } else if (!arg3) {
            *0x2::linked_table::borrow_mut<address, bool>(&mut arg1.keeper_accounts, arg2) = arg3;
        };
    }

    public entry fun update_listing(arg0: &0x2::clock::Clock, arg1: &HiveManager, arg2: &mut MarketPlace<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg3: &mut HiveProfile, arg4: u64, arg5: bool, arg6: u8, arg7: u8, arg8: u64, arg9: u64, arg10: u8, arg11: u64, arg12: &0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0 && arg3.module_version == 0, 1079);
        let v0 = 0x2::clock::timestamp_ms(arg0);
        authority_check(arg3, 0x2::tx_context::sender(arg12));
        assert!(0x2::linked_table::contains<u64, ListingRecord>(&arg3.listing_records, arg4), 1037);
        let v1 = 0x2::linked_table::borrow_mut<u64, Listing>(&mut arg2.active_listings, arg4);
        let v2 = 0x2::linked_table::borrow_mut<u64, ListingRecord>(&mut arg3.listing_records, arg4);
        assert!(v1.expiration_sec > v0, 1032);
        if (arg9 != 0) {
            assert!(arg9 >= arg1.config_params.min_dsui_bid_allowed, 1040);
            v1.min_dsui_price = arg9;
            v2.min_dsui_price = arg9;
        };
        if (arg11 != 0) {
            assert!(arg11 > v1.start_sec && arg11 > v0 && arg11 - v0 < 7776000000, 1030);
            v1.expiration_sec = arg11;
            v2.expiration_sec = arg11;
        };
        if (arg10 != 0 && !v2.is_sale_listing) {
            assert!(0x2::table::contains<u8, u64>(&arg1.supported_lockup_durations, arg10), 1088);
            v1.lockup_duration = arg10;
            v2.lockup_duration = arg10;
        };
        if (arg5) {
            assert!(arg6 <= 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::queen_bee_plan() && arg7 <= 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::queen_bee_plan(), 1130);
            v1.listing_access = arg6;
            v1.discount_access = arg7;
            v1.discount = arg8;
            v2.listing_access = arg6;
            v2.discount_access = arg7;
            v2.discount = arg8;
        };
        let v3 = ListingUpdated{
            listed_by_profile : v1.listed_by_profile,
            version           : arg4,
            min_dsui_price    : v1.min_dsui_price,
            lockup_duration   : v1.lockup_duration,
            start_sec         : v1.start_sec,
            expiration_sec    : v1.expiration_sec,
            listing_access    : v2.listing_access,
            discount_access   : v2.discount_access,
            discount          : v2.discount,
        };
        0x2::event::emit<ListingUpdated>(v3);
    }

    public fun update_pricing_and_access_for_kiosk(arg0: &mut HiveProfile, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: u8, arg7: u64, arg8: &0x2::tx_context::TxContext) {
        authority_check(arg0, 0x2::tx_context::sender(arg8));
        let v0 = get_kiosk_app_name(arg1);
        let v1 = remove_from_profile<HiveKiosk>(arg0, v0);
        let v2 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::forever_subscribe_plan();
        assert!(arg5 < v2 && arg6 < v2, 1130);
        assert!(arg7 <= 100, 1131);
        assert!(arg4 <= 100, 1149);
        v1.base_price = arg2;
        v1.curve_a = arg3;
        v1.discount = arg7;
        if (v1.krafted_assets == 0 && arg4 > 0) {
            v1.pool_pct = arg4;
        };
        add_to_profile<HiveKiosk>(arg0, v0, v1);
        let v3 = PricingAndAccessSetInHiveKiosk{
            creator_profile : 0x2::object::uid_to_address(&arg0.id),
            collection_name : arg1,
            base_price      : arg2,
            curve_a         : arg3,
            pool_pct        : arg4,
            kraft_access    : arg5,
            discount_access : arg6,
            discount        : arg7,
        };
        0x2::event::emit<PricingAndAccessSetInHiveKiosk>(v3);
    }

    public fun update_reserved_usernames_list(arg0: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::DegenHiveDeployerCap, arg1: &mut HiveProfileMappingStore, arg2: vector<0x1::string::String>, arg3: vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            let v1 = to_lowercase(0x1::string::to_ascii(*0x1::vector::borrow<0x1::string::String>(&arg2, v0)));
            if (!0x2::linked_table::contains<0x1::ascii::String, address>(&arg1.reserved_usernames_to_accessor_mapping, v1)) {
                0x2::linked_table::push_back<0x1::ascii::String, address>(&mut arg1.reserved_usernames_to_accessor_mapping, v1, *0x1::vector::borrow<address>(&arg3, v0));
            } else {
                *0x2::linked_table::borrow_mut<0x1::ascii::String, address>(&mut arg1.reserved_usernames_to_accessor_mapping, v1) = *0x1::vector::borrow<address>(&arg3, v0);
            };
            v0 = v0 + 1;
        };
    }

    public fun update_royalty(arg0: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::HiveDaoCapability, arg1: &mut HiveManager, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        assert!(arg1.module_version == 0, 1079);
        let v0 = 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::percent_precision();
        if (arg2 > 0 && arg3 > 0) {
            let v1 = v0 * arg2 / arg3;
            assert!(3 <= v1 && v1 <= 7, 1035);
            arg1.royalty.numerator = arg2;
            arg1.royalty.denominator = arg3;
        };
        if (arg4 > 0) {
            assert!(arg4 <= 40, 1036);
            arg1.royalty.assets_dispersal_percent = arg4;
        };
        if (arg5 > 0) {
            assert!(arg5 <= 50, 1036);
            arg1.royalty.creators_royalty_percent = arg5;
        };
        if (arg6 > 0 && arg7 > 0) {
            let v2 = v0 * arg6 / arg7;
            assert!(5 <= v2 && v2 <= 15, 1035);
            arg1.gems_royalty.numerator = arg6;
            arg1.gems_royalty.denominator = arg7;
        };
        if (arg8 > 0) {
            assert!(arg8 <= 25, 1036);
            arg1.gems_royalty.treasury_percent = arg8;
        };
        if (arg9 > 0) {
            assert!(arg9 <= 50, 1036);
            arg1.gems_royalty.burn_percent = arg9;
        };
        let v3 = KraftRoyaltyUpdated{
            royalty_num              : arg1.royalty.numerator,
            royalty_denom            : arg1.royalty.denominator,
            assets_dispersal_percent : arg1.royalty.assets_dispersal_percent,
            creators_royalty_percent : arg1.royalty.creators_royalty_percent,
            gems_royalty_num         : arg6,
            gems_royalty_denom       : arg7,
            gems_treasury_percent    : arg8,
            gems_burn_percent        : arg9,
        };
        0x2::event::emit<KraftRoyaltyUpdated>(v3);
    }

    public fun update_subscription_pricing(arg0: &0x2::clock::Clock, arg1: &HiveManager, arg2: &mut HiveDisperser, arg3: &mut HiveProfile, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        authority_check(arg3, 0x2::tx_context::sender(arg7));
        increment_gems_global_index(arg1, arg2);
        let (_, _, v2, _) = compute_profile_socialfi_info(arg0, arg1, arg3, arg7);
        let v4 = arg1.config_params.social_fee_gems;
        assert!(v4 <= v2, 1122);
        deposit_gems_for_hive(arg2, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::split(&mut arg3.available_gems, v4));
        if (v4 > 0) {
            let v5 = GemWithdrawnFromProfile{
                username       : arg3.username,
                profile_addr   : 0x2::object::uid_to_address(&arg3.id),
                withdrawn_gems : v4,
            };
            0x2::event::emit<GemWithdrawnFromProfile>(v5);
        };
        *0x2::table::borrow_mut<u8, u64>(&mut arg3.beehive_plan, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::worker_bee_plan()) = arg4;
        *0x2::table::borrow_mut<u8, u64>(&mut arg3.beehive_plan, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::drone_bee_plan()) = arg5;
        *0x2::table::borrow_mut<u8, u64>(&mut arg3.beehive_plan, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::constants::queen_bee_plan()) = arg6;
        let v6 = HiveAccessPlanUpdated{
            profile_addr           : 0x2::object::uid_to_address(&arg3.id),
            username               : 0x1::string::from_ascii(arg3.username),
            new_worker_access_cost : arg4,
            new_drone_access_cost  : arg5,
            new_queen_access_cost  : arg6,
        };
        0x2::event::emit<HiveAccessPlanUpdated>(v6);
    }

    public fun update_traits_in_hive_kiosk(arg0: &mut HiveProfile, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        authority_check(arg0, 0x2::tx_context::sender(arg4));
        let v0 = get_kiosk_app_name(arg1);
        let v1 = remove_from_profile<HiveKiosk>(arg0, v0);
        assert!(v1.krafted_assets == 0, 1077);
        v1.traits_list = arg2;
        v1.img_url = 0x2::url::new_unsafe(0x1::string::to_ascii(arg3));
        let v2 = TraitsSetInHiveKiosk{
            kiosk_addr      : 0x2::object::uid_to_address(&v1.id),
            creator_profile : 0x2::object::uid_to_address(&arg0.id),
            collection_name : arg1,
            traits_list     : arg2,
            img_url         : arg3,
        };
        0x2::event::emit<TraitsSetInHiveKiosk>(v2);
        add_to_profile<HiveKiosk>(arg0, v0, v1);
    }

    public fun update_username(arg0: &0x2::clock::Clock, arg1: &HiveManager, arg2: &mut HiveProfileMappingStore, arg3: &mut HiveDisperser, arg4: &mut HiveProfile, arg5: 0x1::string::String, arg6: &0x2::tx_context::TxContext) {
        let v0 = 0x1::string::to_ascii(arg5);
        let v1 = to_lowercase(v0);
        authority_check(arg4, 0x2::tx_context::sender(arg6));
        assert!(is_valid_profile_name(arg5), 1084);
        assert!(!arg4.is_composable_profile, 1100);
        assert!(!0x2::linked_table::contains<0x1::ascii::String, address>(&arg2.username_to_profile_mapping, v1), 1127);
        if (0x2::linked_table::contains<0x1::ascii::String, address>(&arg2.reserved_usernames_to_accessor_mapping, v1)) {
            assert!(0x2::tx_context::sender(arg6) == *0x2::linked_table::borrow<0x1::ascii::String, address>(&arg2.reserved_usernames_to_accessor_mapping, v1), 1126);
        };
        increment_gems_global_index(arg1, arg3);
        let (_, _, v4, _) = compute_profile_socialfi_info(arg0, arg1, arg4, arg6);
        let v6 = arg1.config_params.social_fee_gems;
        assert!(v6 <= v4, 1122);
        deposit_gems_for_hive(arg3, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::split(&mut arg4.available_gems, v6));
        if (v6 > 0) {
            let v7 = GemWithdrawnFromProfile{
                username       : arg4.username,
                profile_addr   : 0x2::object::uid_to_address(&arg4.id),
                withdrawn_gems : v6,
            };
            0x2::event::emit<GemWithdrawnFromProfile>(v7);
        };
        let v8 = arg4.username;
        0x2::linked_table::remove<0x1::ascii::String, address>(&mut arg2.username_to_profile_mapping, to_lowercase(v8));
        arg4.username = v0;
        0x2::linked_table::push_back<0x1::ascii::String, address>(&mut arg2.username_to_profile_mapping, v1, 0x2::object::uid_to_address(&arg4.id));
        let v9 = UserNameUpdated{
            profile_addr  : 0x2::object::uid_to_address(&arg4.id),
            prev_username : 0x1::string::from_ascii(v8),
            new_username  : arg5,
        };
        0x2::event::emit<UserNameUpdated>(v9);
    }

    public fun upgrade_asset_via_kiosk(arg0: &0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::config::HiveEntryCap, arg1: &0x2::clock::Clock, arg2: &mut HiveManager, arg3: 0x1::string::String, arg4: &mut HiveDisperser, arg5: &mut HiveProfile, arg6: &mut HiveProfile, arg7: u64, arg8: u64, arg9: &0x2::tx_context::TxContext) {
        authority_check(arg6, 0x2::tx_context::sender(arg9));
        let v0 = get_kiosk_app_name(arg3);
        let v1 = remove_from_profile<HiveKiosk>(arg5, v0);
        let (_, _, v4, _) = compute_profile_socialfi_info(arg1, arg2, arg6, arg9);
        assert!(0x2::linked_table::contains<u64, address>(&v1.krafted_versions_map, arg7), 1079);
        increment_gems_global_index(arg2, arg4);
        let v6 = 0x2::linked_table::remove<u64, vector<AssetUpgrade>>(&mut v1.available_upgrades, arg7);
        let v7 = 0x1::vector::remove<AssetUpgrade>(&mut v6, arg8);
        0x2::linked_table::push_back<u64, vector<AssetUpgrade>>(&mut v1.available_upgrades, arg7, v6);
        let v8 = v7.upgrade_price;
        assert!(get_access_level(&arg5.subscribers_list, 0x2::object::uid_to_address(&arg6.id), 0x2::clock::timestamp_ms(arg1)) >= v7.upgrade_access, 1129);
        let v9 = 0x2::linked_table::borrow_mut<u64, HiveAsset>(&mut arg6.hive_assets, arg7);
        v9.img_url = v7.upgrade_img_url;
        let v10 = 0;
        while (v10 < 0x1::vector::length<0x1::string::String>(&v7.upgrade_traits_list)) {
            let v11 = *0x1::vector::borrow<0x1::string::String>(&v7.upgrade_traits_list, v10);
            if (0x2::linked_table::contains<0x1::string::String, 0x1::string::String>(&v9.prompts, v11)) {
                *0x2::linked_table::borrow_mut<0x1::string::String, 0x1::string::String>(&mut v9.prompts, v11) = *0x2::table::borrow<0x1::string::String, 0x1::string::String>(&v7.upgrade_prompts, v11);
            };
            v10 = v10 + 1;
        };
        assert!(v8 <= v4, 1122);
        let (v12, v13, v14, v15) = process_gems_royalty(arg2, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::split(&mut arg6.available_gems, v8), arg4);
        let v16 = v12;
        if (v8 > 0) {
            let v17 = GemWithdrawnFromProfile{
                username       : arg6.username,
                profile_addr   : 0x2::object::uid_to_address(&arg6.id),
                withdrawn_gems : v8,
            };
            0x2::event::emit<GemWithdrawnFromProfile>(v17);
            let v18 = GemAddedToProfile{
                username       : arg5.username,
                profile_addr   : 0x2::object::uid_to_address(&arg5.id),
                deposited_gems : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&v16),
            };
            0x2::event::emit<GemAddedToProfile>(v18);
        };
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::join(&mut arg5.available_gems, v16);
        let AssetUpgrade {
            upgrade_price       : v19,
            upgrade_access      : _,
            upgrade_img_url     : _,
            upgrade_traits_list : _,
            upgrade_prompts     : v23,
        } = v7;
        0x2::table::drop<0x1::string::String, 0x1::string::String>(v23);
        let v24 = HiveAssetUpgraded{
            version           : arg7,
            hive_kiosk        : 0x2::object::uid_to_address(&v1.id),
            new_img_url       : 0x1::string::from_ascii(0x2::url::inner_url(&v9.img_url)),
            upgrade_price     : v19,
            total_royalty_amt : v13,
            treasury_amt      : v14,
            gems_burnt        : v15,
        };
        0x2::event::emit<HiveAssetUpgraded>(v24);
        add_to_profile<HiveKiosk>(arg5, v0, v1);
    }

    public fun upgrade_hive_asset_traits_via_app(arg0: &HiveAppAccessCapability, arg1: &mut HiveProfile, arg2: &mut HiveAsset, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: 0x1::string::String, arg6: &0x2::tx_context::TxContext) {
        authority_check(arg1, 0x2::tx_context::sender(arg6));
        assert!(0x1::vector::length<0x1::string::String>(&arg3) == 0x1::vector::length<0x1::string::String>(&arg4), 1148);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg3)) {
            let v1 = *0x1::vector::borrow<0x1::string::String>(&arg3, v0);
            if (0x2::linked_table::contains<0x1::string::String, 0x1::string::String>(&arg2.prompts, v1)) {
                *0x2::linked_table::borrow_mut<0x1::string::String, 0x1::string::String>(&mut arg2.prompts, v1) = *0x1::vector::borrow<0x1::string::String>(&arg4, v0);
            };
            v0 = v0 + 1;
        };
        arg2.img_url = 0x2::url::new_unsafe(0x1::string::to_ascii(arg5));
        let v2 = HiveAssetUpgradedViaApp{
            version           : arg2.version,
            app_name          : arg0.app_name,
            new_img_url       : 0x1::string::from_ascii(0x2::url::inner_url(&arg2.img_url)),
            traits_to_upgrade : arg3,
            new_prompts       : arg4,
        };
        0x2::event::emit<HiveAssetUpgradedViaApp>(v2);
    }

    public fun withdraw_gems_from_asset(arg0: &mut HiveManager, arg1: &mut HiveDisperser, arg2: &mut HiveProfile, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0 && arg2.module_version == 0, 1079);
        authority_check(arg2, 0x2::tx_context::sender(arg5));
        let v0 = 0x2::linked_table::borrow_mut<u64, HiveAsset>(&mut arg2.hive_assets, arg3);
        assert!(!v0.is_staked, 1082);
        let (v1, v2, v3, v4) = process_gems_royalty(arg0, 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::split(&mut v0.available_gems, arg4), arg1);
        let v5 = v1;
        let v6 = HiveGemsWithdrawnAsset{
            profile_addr                 : 0x2::object::uid_to_address(&arg2.id),
            version                      : arg3,
            gems_withdrawn               : arg4,
            total_royalty_amt            : v2,
            gems_withdrawn_after_royalty : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&v5),
            treasury_amt                 : v3,
            gems_burnt                   : v4,
        };
        0x2::event::emit<HiveGemsWithdrawnAsset>(v6);
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::join(&mut arg2.available_gems, v5);
    }

    public fun withdraw_gems_from_comp_profile(arg0: &mut HiveProfile, arg1: u64) : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::HiveGems {
        assert!(arg0.is_composable_profile, 1057);
        internal_withdraw_gems(arg0, arg1)
    }

    public fun withdraw_gems_from_profile(arg0: &0x2::clock::Clock, arg1: &HiveManager, arg2: &mut HiveProfile, arg3: u64, arg4: &0x2::tx_context::TxContext) : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::HiveGems {
        if (arg2.owner == 0x2::tx_context::sender(arg4)) {
            let (_, _, v3, _) = compute_profile_socialfi_info(arg0, arg1, arg2, arg4);
            assert!(arg3 <= v3, 1122);
            internal_withdraw_gems(arg2, arg3)
        } else {
            withdraw_gems_from_comp_profile(arg2, arg3)
        }
    }

    fun withdraw_hive_asset(arg0: &0x2::clock::Clock, arg1: &mut HiveManager, arg2: &mut DSuiDisperser<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>, arg3: &mut HiveDisperser, arg4: &mut HiveProfile, arg5: u64, arg6: bool) : (HiveAsset, 0x2::balance::Balance<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>) {
        assert!(0x2::linked_table::contains<u64, HiveAsset>(&arg4.hive_assets, arg5), 1024);
        increment_global_index(arg1, arg2);
        increment_gems_global_index(arg1, arg3);
        let v0 = 0x2::linked_table::borrow_mut<u64, HiveAsset>(&mut arg4.hive_assets, arg5);
        let v1 = 0x2::balance::zero<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>();
        if (arg6) {
            assert!(v0.is_staked && v0.unlock_timestamp < 0x2::clock::timestamp_ms(arg0), 1067);
            let (v2, v3, v4) = claim_accrued_rewards_for_asset(arg0, arg1, arg2, arg3, v0);
            let v5 = v2;
            0x2::balance::join<0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::dsui::DSUI>(&mut v1, v3);
            let v6 = GemAddedToProfile{
                username       : arg4.username,
                profile_addr   : 0x2::object::uid_to_address(&arg4.id),
                deposited_gems : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::value(&v5),
            };
            0x2::event::emit<GemAddedToProfile>(v6);
            0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::join(&mut arg4.available_gems, v5);
            if (v4) {
                let v7 = HiveAssetUnstaked{
                    profile_addr : 0x2::object::uid_to_address(&arg4.id),
                    version      : arg5,
                };
                0x2::event::emit<HiveAssetUnstaked>(v7);
            };
        } else {
            assert!(!v0.is_staked, 1021);
        };
        (0x2::linked_table::remove<u64, HiveAsset>(&mut arg4.hive_assets, arg5), v1)
    }

    public fun withdraw_hive_from_hive_asset_via_app(arg0: &HiveAppAccessCapability, arg1: &mut HiveAsset, arg2: &HiveProfile, arg3: u64, arg4: &0x2::tx_context::TxContext) : 0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::HiveGems {
        if (arg0.only_owner_can_access_app) {
            authority_check(arg2, 0x2::tx_context::sender(arg4));
        };
        let v0 = HiveGemsWithdrawnAsset{
            profile_addr                 : 0x2::object::uid_to_address(&arg0.id),
            version                      : arg1.version,
            gems_withdrawn               : arg3,
            total_royalty_amt            : 0,
            gems_withdrawn_after_royalty : arg3,
            treasury_amt                 : 0,
            gems_burnt                   : 0,
        };
        0x2::event::emit<HiveGemsWithdrawnAsset>(v0);
        0x616fa729bb4fbddf2cfc165b1ce19c1d7d738252283a250dc0183b3e015d148b::hive_gems::split(&mut arg1.available_gems, arg3)
    }

    // decompiled from Move bytecode v6
}

