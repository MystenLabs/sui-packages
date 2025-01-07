module 0xbe7aee0c1e79fee9b7478821a5c3eab28ade3c513b0c7a027990e0adabeb5ca8::dragon_trainer {
    struct DRAGON_TRAINER has drop {
        dummy_field: bool,
    }

    struct GenesisBeesUploaderCapability has store, key {
        id: 0x2::object::UID,
    }

    struct GameMasterKey has store, key {
        id: 0x2::object::UID,
        app_name: 0x1::ascii::String,
        total_energy: u64,
        total_health: u64,
        hive_incentives: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>,
        honey_incentives: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>,
    }

    struct TwapUpdateCap has store, key {
        id: 0x2::object::UID,
    }

    struct DegenHiveMapStore has key {
        id: 0x2::object::UID,
        owner_to_trainer_mapping: 0x2::linked_table::LinkedTable<address, address>,
        username_to_trainer_mapping: 0x2::linked_table::LinkedTable<0x1::ascii::String, address>,
        username_to_school_mapping: 0x2::linked_table::LinkedTable<0x1::ascii::String, address>,
        bee_name_to_version_mapping: 0x2::linked_table::LinkedTable<0x1::string::String, u64>,
        suins_name_to_expiry_mapping: 0x2::linked_table::LinkedTable<0x1::ascii::String, u64>,
        app_names_to_cap_mapping: 0x2::linked_table::LinkedTable<0x1::ascii::String, address>,
        module_version: u64,
    }

    struct BeesManager has store, key {
        id: 0x2::object::UID,
        configuration: Configuration,
        hive_treasury: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>,
        honey_treasury: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>,
        bees_tracker: BeesTracker,
        bee_transfers: BeeTransfers,
        dragon_eggs_basket: 0x2::table::Table<u64, DragonEggsBasket>,
        bee_hives: 0x2::linked_table::LinkedTable<u64, BeeHive>,
        buidlers_royalty: 0x2::balance::Balance<0x2::sui::SUI>,
        module_version: u64,
    }

    struct BeesTracker has store {
        total_eggs_laid: u64,
        bees_to_owner_map: 0x2::linked_table::LinkedTable<u64, address>,
        queen_bees_map: 0x2::linked_table::LinkedTable<u64, bool>,
    }

    struct BeeTransfers has store {
        custodied_bees: 0x2::linked_table::LinkedTable<u64, BeeInFlight>,
        incoming_boxes: 0x2::linked_table::LinkedTable<address, vector<u64>>,
        outgoing_boxes: 0x2::linked_table::LinkedTable<address, vector<u64>>,
    }

    struct BeeInFlight has store {
        mystical_bee: MysticalBee,
        transferred_by: address,
        recepient: address,
    }

    struct Configuration has store {
        max_bids_per_bee: u64,
        min_bid_amt: u64,
        trainer_onboarding_fee: u64,
        mutation_fee: u64,
        royalty: Royalty,
        breeding_royalty: BreedingRoyalty,
        cooldown_periods: 0x2::linked_table::LinkedTable<u64, u64>,
        min_energy_to_hatch: u64,
        min_health_to_hatch: u64,
    }

    struct Royalty has copy, store {
        numerator: u64,
        gov_yield_pct: u64,
        queen_pct: u64,
    }

    struct BreedingRoyalty has copy, store {
        platform_fees_pct: u64,
        gov_yield_pct: u64,
        treasury_pct: u64,
    }

    struct DragonEggsBasket has store {
        start_time: u64,
        eggs_count: u64,
        queen_bee_eggs_count: u64,
        eggs_laid: u64,
        queen_eggs_laid: u64,
        queen_chance: u64,
        max_eggs_limit: u64,
        base_price: u64,
        curve_a: u64,
        address_list: 0x2::linked_table::LinkedTable<address, u64>,
        per_user_limit: u64,
        whitelist_trainers_pricing: 0x2::linked_table::LinkedTable<address, u64>,
        whitelist_trainers_availability: 0x2::linked_table::LinkedTable<address, u64>,
        bees_indexes: vector<u64>,
        genesis_genes_list: 0x2::linked_table::LinkedTable<u64, u256>,
        images_list: 0x2::linked_table::LinkedTable<u64, 0x2::linked_table::LinkedTable<u64, 0x1::string::String>>,
        capabilities: 0x2::linked_table::LinkedTable<u64, CapabilityState>,
        dragonbee_imgs_list: 0x2::linked_table::LinkedTable<u64, 0x2::linked_table::LinkedTable<u64, 0x1::string::String>>,
        honey_avail: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>,
        hive_avail: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>,
    }

    struct BeeHive has store {
        queenBeeId: address,
        queen_type: u64,
        queen_version: u64,
        queenBirthInfo: QueenFamilyInfo,
        max_eggs_limit: u64,
        eggs_incubated: u64,
        auction_epoch: u64,
        queen_gene: u256,
        is_active: bool,
        base_price: u64,
        curve_a: u64,
        friends_list: 0x2::linked_table::LinkedTable<u64, u64>,
        incubating_eggs: 0x2::linked_table::LinkedTable<u64, BeeEgg>,
        eggs_hatched_list: 0x2::linked_table::LinkedTable<u64, address>,
        sui_custody: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct QueenFamilyInfo has copy, drop, store {
        queenId: 0x1::option::Option<address>,
        stingerId: 0x1::option::Option<address>,
        generation: u64,
    }

    struct BeeEgg has store {
        timestamp: u64,
        egg_index: u64,
        stingerBeeId: address,
        stingerBeeVersion: u64,
        stinger_gene: u256,
        dragon_bee_egg: MysticalBee,
        is_processed: bool,
    }

    struct HiddenWorldConfig has store {
        is_active: bool,
        max_active_duration: u64,
        turn_duration: u64,
        expiry_penalty_pct: u64,
        min_sui_bet_amt: u64,
        max_sui_bet_amt: u64,
        session_health: u64,
        session_energy: u64,
        min_dragon_dust_chance: u64,
        max_dragon_dust_chance: u64,
        half_life: u64,
        health_pct_to_emit_dust: u64,
        max_capability_increase: u64,
        max_power_pct: u64,
    }

    struct HiddenWorld has store, key {
        id: 0x2::object::UID,
        cap: 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::HiddenWorldCapability,
        sui_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        config: HiddenWorldConfig,
        avg_quests_played: u64,
        avg_dragon_dust_emitted: u64,
        total_quests_count: u256,
        hidden_bees: 0x2::linked_table::LinkedTable<u64, HiddenMysticalBee>,
        hidden_bees_list: 0x2::linked_table::LinkedTable<u64, vector<u64>>,
        list_count: u64,
        trainer_sessions: 0x2::linked_table::LinkedTable<address, TrainerSession>,
        active_trainers: 0x2::linked_table::LinkedTable<address, QuestRequest>,
        active_trainers_list: 0x2::linked_table::LinkedTable<u64, address>,
        active_trainers_indexes: vector<u64>,
        p2p_quests: 0x2::linked_table::LinkedTable<0x1::string::String, P2pGameSession>,
        bees_to_collect: 0x2::linked_table::LinkedTable<address, vector<MysticalBee>>,
        dragon_dust: 0x2::linked_table::LinkedTable<u64, DragonDust>,
        module_version: u64,
    }

    struct QuestRequest has store {
        timestamp: u64,
        version: u64,
        mystical_bee: MysticalBee,
        sui_bet: 0x2::balance::Balance<0x2::sui::SUI>,
        player_only: bool,
        with_trainer: 0x1::option::Option<address>,
        active_index: u64,
    }

    struct P2pGameSession has store {
        trainer_addr1: address,
        trainer_addr2: address,
        version1: u64,
        v1_dust_pct_sum: u64,
        v1_evolved: u64,
        version2: u64,
        v2_dust_pct_sum: u64,
        v2_evolved: u64,
        current_quest: HiddenWorldQuest,
    }

    struct TrainerSession has store {
        trainer_address: address,
        user_bees: vector<u64>,
        quests_count: u64,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        current_quest: 0x1::string::String,
        state: u8,
    }

    struct DragonDust has store {
        quests_played: u64,
        evolution_stage: u8,
        evolved_genes: vector<u256>,
        genes_img_map: 0x2::linked_table::LinkedTable<u64, vector<0x1::string::String>>,
        evolution_map: vector<u64>,
    }

    struct HiddenMysticalBee has store {
        mystical_bee: 0x1::option::Option<MysticalBee>,
        winnings: 0x2::balance::Balance<0x2::sui::SUI>,
        winnings_sum: u64,
        loosing_sum: u64,
        dragon_dust_emitted: u64,
    }

    struct HiddenWorldQuest has store {
        trainer_addr1: address,
        trainer_addr2: address,
        next_turn: u8,
        last_action_ts: u64,
        sui_bet_bal: 0x2::balance::Balance<0x2::sui::SUI>,
        start_game_health: u64,
        start_game_energy: u64,
        user_bee_health: u64,
        user_bee_energy: u64,
        user_dragon_bee: MysticalBee,
        user2_bee_health: u64,
        user2_bee_energy: u64,
        user2_dragon_bee: MysticalBee,
    }

    struct MysticalBee has store, key {
        id: 0x2::object::UID,
        version: u64,
        name: 0x1::string::String,
        owned_by: address,
        queen_version: u64,
        genes: u256,
        appearance: 0x2::linked_table::LinkedTable<u64, 0x1::string::String>,
        birth_certificate: BirthCertificate,
        eggs_basket: EggBasketInfo,
        nectar: NectarStore,
        capabilities: 0x2::linked_table::LinkedTable<u64, CapabilityState>,
        game_state: 0x2::linked_table::LinkedTable<0x1::ascii::String, address>,
        hive_energy: u64,
        honey_health: u64,
        dragon_dust: u64,
        is_hatched: bool,
    }

    struct BirthCertificate has store {
        generation: u64,
        birth_time: u64,
        birther_trainer: address,
        queenId: 0x1::option::Option<address>,
        stingerId: 0x1::option::Option<address>,
    }

    struct EggBasketInfo has store {
        is_queen: bool,
        total_eggs: u64,
        hatch_egg_record: 0x1::option::Option<BeeEggRecord>,
        last_egg_ts: u64,
        cooldown_stage: u8,
        cooldown_till_ts: u64,
    }

    struct BeeEggRecord has drop, store {
        queenBeeId: address,
        queen_version: u64,
        child_gene: u256,
        child_generation: u64,
        child_version: u64,
    }

    struct NectarStore has store {
        evolution_stage: u8,
        lockup_weeks: u64,
        hive_locked: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>,
        weighted_hive_locked: u128,
        unlock_timestamp: u64,
        honey_locked: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>,
        weighted_honey_locked: u128,
        hive_claim_index: u256,
        honey_claim_index: u256,
    }

    struct CapabilityState has store {
        cap_type: u8,
        health_impact_pct: u64,
        energy_cost_pct: u64,
        attempts: u64,
        cooldown: u64,
        next_use_ts: u64,
        base_attempts: u64,
    }

    struct DragonTrainer has key {
        id: 0x2::object::UID,
        owner: address,
        joined_at: u64,
        username: 0x1::ascii::String,
        inscription: Inscription,
        available_honey: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>,
        available_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        owned_bees: 0x2::linked_table::LinkedTable<u64, MysticalBee>,
        locked_bees: 0x2::linked_table::LinkedTable<u64, address>,
        listing_records: 0x2::linked_table::LinkedTable<u64, ListingRecord>,
        bid_records: 0x2::linked_table::LinkedTable<u64, BidRecord>,
        trainer_sessions: 0x2::linked_table::LinkedTable<0x1::ascii::String, address>,
        module_version: u64,
    }

    struct DragonSchool has store, key {
        id: 0x2::object::UID,
        owner: address,
        username: 0x1::ascii::String,
        available_hive: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>,
        available_honey: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>,
        module_version: u64,
    }

    struct LockedDegenHiveAssets has store, key {
        id: 0x2::object::UID,
        hive_locked: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>,
        honey_locked: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>,
    }

    struct Inscription has store {
        format: 0x1::string::String,
        base64: 0x2::linked_table::LinkedTable<u64, 0x1::string::String>,
    }

    struct ListingRecord has store {
        version: u64,
        min_price: u64,
        expiration_sec: u64,
    }

    struct BidRecord has store {
        version: u64,
        offer_price: u64,
        expiration_sec: u64,
    }

    struct MarketPlace has store, key {
        id: 0x2::object::UID,
        active_listings: 0x2::linked_table::LinkedTable<u64, Listing>,
        available_bids: 0x2::linked_table::LinkedTable<u64, vector<Bid>>,
        processed_listings: 0x2::linked_table::LinkedTable<u64, ExecutedListing>,
        module_version: u64,
    }

    struct Listing has store {
        listed_by_trainer: address,
        mystical_bee: MysticalBee,
        min_price: u64,
        expiration_sec: u64,
    }

    struct Bid has store {
        bidder_trainer: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        offer_price: u64,
        expiration_sec: u64,
        is_valid: bool,
    }

    struct ExecutedListing has store {
        listed_by_trainer: address,
        mystical_bee: 0x1::option::Option<MysticalBee>,
        version: u64,
        balance: 0x1::option::Option<0x2::balance::Balance<0x2::sui::SUI>>,
        bidder_trainer: address,
        executed_price: u64,
    }

    struct YieldFarm has store, key {
        id: 0x2::object::UID,
        trading_enabled: bool,
        governance_info: GovernanceInfo,
        incoming_honey_for_bees: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>,
        incoming_hive_for_bees: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>,
        honey_for_bees: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>,
        hive_for_bees: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>,
        honey_global_index: u256,
        hive_global_index: u256,
        module_version: u64,
    }

    struct GovernanceInfo has store {
        total_weighted_hive: u128,
        total_weighted_honey: u128,
    }

    struct HiveGraph has store, key {
        id: 0x2::object::UID,
        hive_twap: HiveTwapInfo,
        followers_list: 0x2::linked_table::LinkedTable<address, 0x2::linked_table::LinkedTable<address, bool>>,
        following_list: 0x2::linked_table::LinkedTable<address, 0x2::linked_table::LinkedTable<address, bool>>,
        module_version: u64,
    }

    struct HiveTwapInfo has copy, store {
        last_update_timestamp: u64,
        hive_sui_twap: u256,
        sui_usdc_twap: u256,
        hive_usdc_twap: u256,
    }

    struct BeeIsNowAQueen has copy, drop {
        queenBeeId: address,
        family_type: u64,
        version: u64,
        queen_gene: u256,
        max_eggs_limit: u64,
        auction_epoch: u64,
    }

    struct AppAddedToHiveStore has copy, drop {
        capability_addr: address,
        app_name: 0x1::ascii::String,
        hive_incentives: u64,
        honey_incentives: u64,
        receipient: address,
    }

    struct PricingUpdatedForBreeding has copy, drop {
        queen_version: u64,
        is_active: bool,
        base_price: u64,
        curve_a: u64,
    }

    struct BeeAddedToFriendsList has copy, drop {
        queen_version: u64,
        friendly_bee: u64,
        new_price: u64,
    }

    struct BeeRemovedFromFriendsList has copy, drop {
        queen_version: u64,
        friendly_bee: u64,
    }

    struct SuiClaimedFromBeeHive has copy, drop {
        queen_version: u64,
        sui_claimed: u64,
    }

    struct BeesAddedToGenesisBasket has copy, drop {
        index: u64,
        gene: u256,
        img: vector<0x1::string::String>,
    }

    struct BeeUpdatedInGenesisBasket has copy, drop {
        index: u64,
        gene: u256,
        img: vector<0x1::string::String>,
    }

    struct UserWhitelistedForGenesisMint has copy, drop {
        user_addr: address,
        mint_price: u64,
    }

    struct BeeCapabilityUpdated has copy, drop {
        spot: u64,
        cap_type: u8,
        health_impact_pct: u64,
        energy_cost_pct: u64,
        attempts: u64,
        cooldown: u64,
        base_attempts: u64,
    }

    struct BreedingRequestProcessed has copy, drop {
        queen_version: u64,
        stinger_index: u64,
        img: vector<0x1::string::String>,
    }

    struct BreedingRequestUnprocessed has copy, drop {
        queen_version: u64,
        stinger_index: u64,
    }

    struct TransformationRequestProcessed has copy, drop {
        version: u64,
        img_index: u64,
        img: vector<0x1::string::String>,
    }

    struct BeeOwnershipUpdated has copy, drop {
        version: u64,
        new_owner: address,
    }

    struct BuidlersYieldHarvested has copy, drop {
        sui_yield: u64,
        receiver: address,
    }

    struct ManagerConfigUpdated has copy, drop {
        max_bids_per_bee: u64,
        min_bid_amt: u64,
        trainer_onboarding_fee: u64,
        mutation_fee: u64,
    }

    struct RoyaltyUpdated has copy, drop {
        royalty_num: u64,
        gov_yield_pct: u64,
        queen_pct: u64,
        breeding_platform_fees_pct: u64,
        breeding_gov_yield_pct: u64,
        breeding_treasury_pct: u64,
    }

    struct HiveEnergyInfusedInBee has copy, drop {
        version: u64,
        add_hive_locked: u64,
        hive_locked_with_bee: u64,
        weighted_hive_locked: u128,
        unlock_timestamp: u64,
        lockup_weeks: u64,
        hive_energy: u64,
        total_weighted_hive: u128,
    }

    struct HiveUnlockedFromBee has copy, drop {
        beeId: address,
        version: u64,
        hive_unlocked: u64,
        wHive_decrease: u128,
        total_weighted_hive: u128,
    }

    struct HealthInfusedInBee has copy, drop {
        version: u64,
        honey_added: u64,
        total_honey_locked: u64,
        weighted_honey_locked: u128,
        health_increase: u64,
        honey_health: u64,
    }

    struct BeeFarmedYield has copy, drop {
        beeId: address,
        version: u64,
        claimed_hive_amt: u64,
        claimed_honey_amt: u64,
        honeylocked: u64,
        total_honey_locked: u64,
        hive_energy: u64,
        honey_health: u64,
        total_weighted_honey: u128,
    }

    struct HiveAddedForHarvest has copy, drop {
        yield_added: u64,
    }

    struct HoneyAddedForHarvest has copy, drop {
        yield_added: u64,
    }

    struct MysticalBeeReturnedFromCompetition has copy, drop {
        recepient_trainer: address,
        recepient_username: 0x1::ascii::String,
        version: u64,
        energy_increase: u64,
        health_increase: u64,
        hive_energy: u64,
        honey_health: u64,
    }

    struct StoreAddedToBee has copy, drop {
        version: u64,
        app_name: 0x1::ascii::String,
        app_addr: address,
    }

    struct StoreRemovedFromBee has copy, drop {
        version: u64,
        app_name: 0x1::ascii::String,
    }

    struct HoneyAddedToProfile has copy, drop {
        username: 0x1::ascii::String,
        profile_addr: address,
        deposited_honey: u64,
    }

    struct HoneyTransferredToProfile has copy, drop {
        from_username: 0x1::ascii::String,
        from_dragon_school_addr: address,
        to_username: 0x1::ascii::String,
        to_trainer_addr: address,
        honey_to_transfer: u64,
    }

    struct DragonTrainerKrafted has copy, drop {
        name: 0x1::string::String,
        new_trainer_addr: address,
        krafter: address,
        fee: u64,
    }

    struct DragonTrainerDeleted has copy, drop {
        owner: address,
        username: 0x1::ascii::String,
        profile_addr: address,
        recepient: address,
        available_honey: u64,
        available_sui: u64,
    }

    struct EggLaidForDragonBee has copy, drop {
        id: address,
        generation: u64,
        version: u64,
        gene: u256,
        birth_time: u64,
        birther_trainer: address,
        queen_version: u64,
        queenId: 0x1::option::Option<address>,
        stingerId: 0x1::option::Option<address>,
        price: u64,
        honey_deposit: u64,
    }

    struct NewEggIncubated has copy, drop {
        child_version: u64,
        incubated_at: u64,
        child_generation: u64,
        queenId: address,
        queen_version: u64,
        stingerBeeId: address,
        stinger_version: u64,
        queen_gene: u256,
        stinger_gene: u256,
        child_gene: u256,
        total_breeding_cost: u64,
        platform_fees: u64,
        gov_yield_amt: u64,
        treasury_fees: u64,
        stinger_cooldown_stage: u8,
        stinger_cooldown_till: u64,
    }

    struct DegenHiveYieldHarvested has copy, drop {
        harvester_trainer: address,
        username: 0x1::ascii::String,
        hive_harvested: u64,
        honey_harvested: u64,
    }

    struct FundsWithdrawnFromProfile has copy, drop {
        profile_addr: address,
        username: 0x1::ascii::String,
        withdrawn_sui: u64,
        withdrawn_honey: u64,
    }

    struct BidMarkedInvalid has copy, drop {
        version: u64,
        bidder_trainer: address,
    }

    struct NewListing has copy, drop {
        listed_by_trainer: address,
        version: u64,
        min_price: u64,
        expiration_sec: u64,
    }

    struct ListingUpdated has copy, drop {
        listed_by_trainer: address,
        version: u64,
        min_price: u64,
        expiration_sec: u64,
    }

    struct ListingCanceled has copy, drop {
        listed_by_trainer: address,
        version: u64,
    }

    struct ListingExpired has copy, drop {
        listed_by_trainer: address,
        version: u64,
    }

    struct BidPlaced has copy, drop {
        bidder_trainer: address,
        username: 0x1::ascii::String,
        version: u64,
        offer_price: u64,
        expiration_sec: u64,
    }

    struct BidDestroyed has copy, drop {
        bee_version: u64,
        bidder_trainer: address,
    }

    struct ListingDestroyed has copy, drop {
        version: u64,
        listed_by_trainer: address,
    }

    struct SaleExecuted has copy, drop {
        version: u64,
        buyer_trainer: address,
        seller_trainer: address,
        purchase_price: u64,
    }

    struct RoyaltyProcessed has copy, drop {
        total_royalty_amt: u64,
        gov_yield_amt: u64,
        queen_royalty_amt: u64,
        platform_fees: u64,
    }

    struct BidCanceled has copy, drop {
        version: u64,
        bidder_trainer: address,
        refund_sui: u64,
    }

    struct BidExpired has copy, drop {
        version: u64,
        bidder_trainer: address,
        refund_sui: u64,
    }

    struct UserNameUpdated has copy, drop {
        profile_addr: address,
        prev_username: 0x1::string::String,
        new_username: 0x1::string::String,
    }

    struct MysticalBeeRenamed has copy, drop {
        trainer_addr: address,
        version: u64,
        new_bee_name: 0x1::string::String,
    }

    struct SuiNsNameExpired has copy, drop {
        profile_addr: address,
        suins_domain_name: 0x1::string::String,
    }

    struct JoinedHiveOfProfile has copy, drop {
        follower_trainer_addr: address,
        followed_trainer: address,
        follower_username: 0x1::string::String,
    }

    struct ExitHiveOfProfile has copy, drop {
        follower_trainer_addr: address,
        unfollowed_trainer_addr: address,
        follower_username: 0x1::string::String,
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
        app_id: address,
    }

    struct AppRemovedByProfile has copy, drop {
        profile_addr: address,
        username: 0x1::ascii::String,
        app_name: 0x1::ascii::String,
    }

    struct MasterKeyReplenished has copy, drop {
        addr: address,
        app_name: 0x1::ascii::String,
        honey_earned: u64,
        energy_added: u64,
        health_added: u64,
        available_energy: u64,
        available_health: u64,
    }

    struct BeeSentToHiddenWorld has copy, drop {
        sent_at: u64,
        sender: address,
        beeId: address,
        version: u64,
        genes: u256,
        energy: u64,
        health: u64,
        total_honey_claimed: u64,
        hive_unlocked: u64,
        total_weighted_hive: u128,
        total_weighted_honey: u128,
    }

    struct HiveWithdrawnFromTreasury has copy, drop {
        hive_withdrawn: u64,
    }

    struct HiveAddedToTreasury has copy, drop {
        hive_added: u64,
        total_hive_in_treasury: u64,
    }

    struct HoneyAddedToTreasury has copy, drop {
        honey_added: u64,
        total_honey_in_treasury: u64,
    }

    struct BeeAttack has copy, drop {
        attacker_version: u64,
        capability_slot: u8,
        defender_version: u64,
        attacker_energy: u64,
        defender_health: u64,
        health_impact: u64,
        energy_cost: u64,
    }

    struct ExecutedListingDestroyed has copy, drop {
        version: u64,
        executed_price: u64,
        listed_by_trainer: address,
    }

    struct PowersAddedToDragonBee has copy, drop {
        version: u64,
        slot: u64,
        capability_type_vec: vector<u8>,
        health_impact_pct_vec: vector<u64>,
        energy_cost_pct_vec: vector<u64>,
        attempts_vec: vector<u64>,
        cooldown_vec: vector<u64>,
        base_attempts_vec: vector<u64>,
    }

    struct CapabilityAdded has copy, drop {
        version: u64,
        slot: u64,
        capability_type: u8,
        health_impact_pct: u64,
        energy_cost_pct: u64,
        attempts: u64,
        cooldown: u64,
        next_use_ts: u64,
        base_attempts: u64,
    }

    struct DragonBeeHatched has copy, drop {
        version: u64,
    }

    struct BeeTransferInitiated has copy, drop {
        version: u64,
        transferred_by: address,
        recepient: address,
    }

    struct BeeTransferCancelled has copy, drop {
        version: u64,
        transferred_by: address,
        recepient: address,
    }

    struct IncomingBeeClaimed has copy, drop {
        version: u64,
        claimed_by: address,
    }

    struct HiddenWorldRewardsClaimed has copy, drop {
        trainer_address: address,
        sui_winnings: u64,
        claimed_bees: vector<u64>,
        claimed_per_bee_amt: vector<u64>,
    }

    struct BeeDeletedFromHiddenWorld has copy, drop {
        deleted_at: u64,
        version: u64,
        genes: u256,
    }

    struct HiddenBeeDeleted has copy, drop {
        deleted_at: u64,
        version: u64,
        winnings_sum: u64,
        loosing_sum: u64,
        dragon_dust_emitted: u64,
    }

    struct TrainerActiveForQuest has copy, drop {
        trainer_address: address,
        version: u64,
        sui_bet: u64,
        player_only: bool,
        with_trainer: 0x1::option::Option<address>,
        active_index: u64,
    }

    struct TrainerCanceledActiveQuest has copy, drop {
        trainer_address: address,
        version: u64,
    }

    struct QuestRequestExpired has copy, drop {
        trainer_address: address,
        version: u64,
    }

    struct QuestRequestDestroyed has copy, drop {
        trainer_address: address,
        version: u64,
    }

    struct DragonSchoolCreated has copy, drop {
        name: 0x1::ascii::String,
        new_school_addr: address,
    }

    struct NewGameSession has copy, drop {
        p2p_session_id: 0x1::string::String,
        trainer_addr1: address,
        trainer_addr2: address,
        version1: u64,
        version2: u64,
        sui_bet: u64,
    }

    public entry fun accept_bid(arg0: &0x2::clock::Clock, arg1: &mut BeesManager, arg2: &mut 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::FeeCollector<0x2::sui::SUI>, arg3: &mut MarketPlace, arg4: &mut DragonTrainer, arg5: address, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg3.module_version == 0, 1079);
        assert!(0x2::linked_table::contains<u64, ListingRecord>(&arg4.listing_records, arg6), 1045);
        let v0 = 0x2::linked_table::remove<u64, ListingRecord>(&mut arg4.listing_records, arg6);
        assert!(v0.expiration_sec > 0x2::clock::timestamp_ms(arg0), 1032);
        let (_, _, _) = destroy_listing_record(v0);
        let v4 = 0x2::balance::zero<0x2::sui::SUI>();
        let v5 = &mut v4;
        let v6 = execute_sale(arg1, arg3, arg2, arg6, true, arg5, 0, v5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg4.available_sui, 0x1::option::extract<0x2::balance::Balance<0x2::sui::SUI>>(&mut v6.balance));
        update_bee_ownership(arg1, arg6, arg5);
        0x2::linked_table::push_back<u64, ExecutedListing>(&mut arg3.processed_listings, arg6, v6);
        0x2::balance::value<0x2::sui::SUI>(&arg4.available_sui);
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v4, 0x2::tx_context::sender(arg7), arg7);
    }

    public fun add_app_to_hive_store(arg0: &mut 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::DragonDaoCapability, arg1: &mut BeesManager, arg2: &mut DegenHiveMapStore, arg3: 0x1::ascii::String, arg4: u64, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = GameMasterKey{
            id               : 0x2::object::new(arg7),
            app_name         : arg3,
            total_energy     : 0,
            total_health     : 0,
            hive_incentives  : 0x2::balance::split<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut arg1.hive_treasury, arg4),
            honey_incentives : 0x2::balance::split<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut arg1.honey_treasury, arg5),
        };
        assert!(!0x2::linked_table::contains<0x1::ascii::String, address>(&arg2.app_names_to_cap_mapping, arg3), 1112);
        0x2::linked_table::push_back<0x1::ascii::String, address>(&mut arg2.app_names_to_cap_mapping, arg3, 0x2::object::uid_to_address(&v0.id));
        let v1 = AppAddedToHiveStore{
            capability_addr  : 0x2::object::uid_to_address(&v0.id),
            app_name         : arg3,
            hive_incentives  : arg4,
            honey_incentives : arg5,
            receipient       : arg6,
        };
        0x2::event::emit<AppAddedToHiveStore>(v1);
        0x2::transfer::public_transfer<GameMasterKey>(v0, arg6);
    }

    public fun add_app_to_trainer<T0: store + key>(arg0: &GameMasterKey, arg1: &mut DragonTrainer, arg2: address, arg3: T0, arg4: &0x2::tx_context::TxContext) {
        if (!0x2::linked_table::contains<0x1::ascii::String, address>(&arg1.trainer_sessions, arg0.app_name)) {
            0x2::linked_table::push_back<0x1::ascii::String, address>(&mut arg1.trainer_sessions, arg0.app_name, arg2);
            let v0 = AppInstalledByProfile{
                profile_addr : 0x2::object::uid_to_address(&arg1.id),
                username     : arg1.username,
                app_name     : arg0.app_name,
                app_id       : arg2,
            };
            0x2::event::emit<AppInstalledByProfile>(v0);
        };
        0x2::dynamic_object_field::add<0x1::ascii::String, T0>(&mut arg1.id, arg0.app_name, arg3);
    }

    fun add_bee_friends_for_breeding(arg0: &mut BeesManager, arg1: &MysticalBee, arg2: u64, arg3: u64) {
        let v0 = 0x2::linked_table::borrow_mut<u64, BeeHive>(&mut arg0.bee_hives, arg1.version);
        if (0x2::linked_table::contains<u64, u64>(&v0.friends_list, arg2)) {
            *0x2::linked_table::borrow_mut<u64, u64>(&mut v0.friends_list, arg2) = arg3;
        } else {
            0x2::linked_table::push_back<u64, u64>(&mut v0.friends_list, arg2, arg3);
        };
        let v1 = BeeAddedToFriendsList{
            queen_version : arg1.version,
            friendly_bee  : arg2,
            new_price     : arg3,
        };
        0x2::event::emit<BeeAddedToFriendsList>(v1);
    }

    fun add_bid_to_table(arg0: &mut 0x2::linked_table::LinkedTable<u64, vector<Bid>>, arg1: u64, arg2: Bid, arg3: u64) {
        if (0x2::linked_table::contains<u64, vector<Bid>>(arg0, arg1)) {
            let v0 = 0x2::linked_table::borrow_mut<u64, vector<Bid>>(arg0, arg1);
            assert!(0x1::vector::length<Bid>(v0) < arg3, 1078);
            0x1::vector::push_back<Bid>(v0, arg2);
        } else {
            let v1 = 0x1::vector::empty<Bid>();
            0x1::vector::push_back<Bid>(&mut v1, arg2);
            0x2::linked_table::push_back<u64, vector<Bid>>(arg0, arg1, v1);
        };
    }

    fun add_capabilities_based_on_gene(arg0: &BeesManager, arg1: &mut MysticalBee) {
        let v0 = 0x2::table::borrow<u64, DragonEggsBasket>(&arg0.dragon_eggs_basket, 420);
        let v1 = 0xbe7aee0c1e79fee9b7478821a5c3eab28ade3c513b0c7a027990e0adabeb5ca8::beescience::decode_dominant_power_traits(arg1.genes);
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 0x1::vector::empty<u64>();
        let v8 = 0;
        while (v8 < 7) {
            let v9 = v8 * 15 + (*0x1::vector::borrow<u8>(&v1, v8) as u64);
            assert!(0x2::linked_table::contains<u64, CapabilityState>(&v0.capabilities, v9), 9223390453674541055);
            let v10 = 0x2::linked_table::borrow<u64, CapabilityState>(&v0.capabilities, v9);
            0x1::vector::push_back<u8>(&mut v2, v10.cap_type);
            0x1::vector::push_back<u64>(&mut v3, v10.health_impact_pct);
            0x1::vector::push_back<u64>(&mut v4, v10.energy_cost_pct);
            0x1::vector::push_back<u64>(&mut v5, v10.attempts);
            0x1::vector::push_back<u64>(&mut v6, v10.cooldown);
            0x1::vector::push_back<u64>(&mut v7, v10.attempts);
            let v11 = CapabilityState{
                cap_type          : v10.cap_type,
                health_impact_pct : v10.health_impact_pct,
                energy_cost_pct   : v10.energy_cost_pct,
                attempts          : v10.attempts,
                cooldown          : v10.cooldown,
                next_use_ts       : 0,
                base_attempts     : v10.attempts,
            };
            0x2::linked_table::push_back<u64, CapabilityState>(&mut arg1.capabilities, (v8 as u64), v11);
            v8 = v8 + 1;
        };
        let v12 = PowersAddedToDragonBee{
            version               : arg1.version,
            slot                  : v8,
            capability_type_vec   : v2,
            health_impact_pct_vec : v3,
            energy_cost_pct_vec   : v4,
            attempts_vec          : v5,
            cooldown_vec          : v6,
            base_attempts_vec     : v7,
        };
        0x2::event::emit<PowersAddedToDragonBee>(v12);
    }

    public entry fun add_dna_for_dragon_egg(arg0: &GenesisBeesUploaderCapability, arg1: &mut BeesManager, arg2: u256, arg3: vector<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 1079);
        let v0 = 0x2::table::borrow_mut<u64, DragonEggsBasket>(&mut arg1.dragon_eggs_basket, 420);
        let v1 = 0;
        if (0x1::vector::length<u64>(&v0.bees_indexes) > 0) {
            v1 = *0x1::vector::borrow<u64>(&v0.bees_indexes, 0x1::vector::length<u64>(&v0.bees_indexes) - 1) + 1;
        };
        0x1::vector::push_back<u64>(&mut v0.bees_indexes, v1);
        0x2::linked_table::push_back<u64, u256>(&mut v0.genesis_genes_list, v1, arg2);
        let v2 = 0;
        let v3 = 0x2::linked_table::new<u64, 0x1::string::String>(arg4);
        while (v2 < 0x1::vector::length<0x1::string::String>(&arg3)) {
            0x2::linked_table::push_back<u64, 0x1::string::String>(&mut v3, v2, *0x1::vector::borrow<0x1::string::String>(&arg3, v2));
            v2 = v2 + 1;
        };
        0x2::linked_table::push_back<u64, 0x2::linked_table::LinkedTable<u64, 0x1::string::String>>(&mut v0.images_list, v1, v3);
        let v4 = BeesAddedToGenesisBasket{
            index : v1,
            gene  : arg2,
            img   : arg3,
        };
        0x2::event::emit<BeesAddedToGenesisBasket>(v4);
    }

    public fun add_store_to_bee<T0: store + key>(arg0: &GameMasterKey, arg1: &mut MysticalBee, arg2: address, arg3: T0) {
        assert!(!0x2::linked_table::contains<0x1::ascii::String, address>(&arg1.game_state, arg0.app_name), 1125);
        0x2::linked_table::push_back<0x1::ascii::String, address>(&mut arg1.game_state, arg0.app_name, arg2);
        let v0 = StoreAddedToBee{
            version  : arg1.version,
            app_name : arg0.app_name,
            app_addr : arg2,
        };
        0x2::event::emit<StoreAddedToBee>(v0);
        0x2::dynamic_object_field::add<0x1::ascii::String, T0>(&mut arg1.id, arg0.app_name, arg3);
    }

    fun adjust_capability_value(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = arg0 * arg1 / 1000;
        if (arg0 + v0 > arg2) {
            return arg2
        };
        arg0 + v0
    }

    public fun admin_mint_queen(arg0: &0x2::clock::Clock, arg1: &0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::DeployerCap, arg2: &0x2::random::Random, arg3: &mut 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::FeeCollector<0x2::sui::SUI>, arg4: &mut BeesManager, arg5: &mut YieldFarm, arg6: &mut DragonTrainer, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = lay_genesis_dragonbee_egg(arg0, arg2, arg3, arg4, arg5, arg6, 0x2::coin::into_balance<0x2::sui::SUI>(arg7), true, arg8);
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg8), arg8);
    }

    fun attack_bee(arg0: &mut MysticalBee, arg1: &mut MysticalBee, arg2: u64, arg3: u64, arg4: u8, arg5: u64) : (u64, u64) {
        let v0 = 0x2::linked_table::borrow_mut<u64, CapabilityState>(&mut arg0.capabilities, (arg4 as u64));
        if (!use_power_if_can(v0, arg5)) {
            return (0, 0)
        };
        let (v1, v2, v3, v4, _, _, _) = get_capability_state(arg0, arg4);
        if (v4 == 0) {
            return (0, 0)
        };
        let v8 = arg2 * v3 / 100;
        let v9 = arg3 * v2 / 100;
        if (arg0.hive_energy < v8 || v1 != 0) {
            return (0, 0)
        };
        arg0.hive_energy = arg0.hive_energy - v8;
        if (arg1.honey_health >= v9) {
            arg1.honey_health = arg1.honey_health - v9;
        } else {
            arg1.honey_health = 0;
        };
        let v10 = BeeAttack{
            attacker_version : arg0.version,
            capability_slot  : arg4,
            defender_version : arg1.version,
            attacker_energy  : arg0.hive_energy,
            defender_health  : arg1.honey_health,
            health_impact    : v9,
            energy_cost      : v8,
        };
        0x2::event::emit<BeeAttack>(v10);
        (v8, v9)
    }

    public fun borrow_app_from_trainer<T0: store + key>(arg0: &GameMasterKey, arg1: &mut DragonTrainer, arg2: &0x2::tx_context::TxContext) : &mut T0 {
        0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, T0>(&mut arg1.id, arg0.app_name)
    }

    public fun borrow_from_trainer<T0: store + key>(arg0: &DragonTrainer, arg1: 0x1::ascii::String) : &T0 {
        0x2::dynamic_object_field::borrow<0x1::ascii::String, T0>(&arg0.id, arg1)
    }

    public fun borrow_non_mut_store_from_bee<T0: store + key>(arg0: &MysticalBee, arg1: 0x1::string::String) : &T0 {
        0x2::dynamic_object_field::borrow<0x1::string::String, T0>(&arg0.id, arg1)
    }

    public fun borrow_store_from_bee<T0: store + key>(arg0: &GameMasterKey, arg1: &mut MysticalBee) : &mut T0 {
        0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, T0>(&mut arg1.id, arg0.app_name)
    }

    entry fun breed_with_queen_bee(arg0: &0x2::clock::Clock, arg1: &0x2::random::Random, arg2: &mut 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::YieldFlow, arg3: &mut 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::FeeCollector<0x2::sui::SUI>, arg4: &mut BeesManager, arg5: u64, arg6: &mut DragonTrainer, arg7: u64, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg4.module_version == 0 && arg6.module_version == 0, 1079);
        let v0 = 0x2::object::uid_to_address(&arg6.id);
        assert!(0x2::linked_table::contains<u64, BeeHive>(&arg4.bee_hives, arg5), 1173);
        assert!(0x2::linked_table::contains<u64, MysticalBee>(&arg6.owned_bees, arg7), 1172);
        let v1 = 0x2::linked_table::borrow_mut<u64, MysticalBee>(&mut arg6.owned_bees, arg7);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg8);
        let v3 = internal_breed_with_queen_bee(arg0, arg1, arg2, arg3, arg4, v1, arg5, 0x2::balance::split<0x2::sui::SUI>(&mut v2, arg9), v0, v0, arg10);
        0x2::balance::join<0x2::sui::SUI>(&mut v3, v2);
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v3, 0x2::tx_context::sender(arg10), arg10);
    }

    fun calculate_dragon_dust_chance(arg0: &HiddenWorld, arg1: u64) : u64 {
        let v0 = arg0.avg_quests_played;
        let v1 = arg0.config.min_dragon_dust_chance;
        let v2 = arg0.config.max_dragon_dust_chance;
        if (v0 == 0) {
            return v1
        };
        let v3 = if (arg1 >= v0) {
            (arg1 - v0) * 100 / v0
        } else {
            (v0 - arg1) * 100 / v0
        };
        if (arg1 >= v0) {
            v1 + v3 * (v2 - v1) / 100
        } else {
            v2 - v3 * (v2 - v1) / 100
        }
    }

    fun calculate_max_multiplier(arg0: u64, arg1: u64) : u64 {
        let v0 = if (arg1 > 0) {
            (arg1 as u64) * 50
        } else {
            0
        };
        100 + arg0 + v0
    }

    public fun cancel_active_trainer_request(arg0: &mut HiddenWorld, arg1: &mut BeesManager, arg2: &mut DragonTrainer, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 1079);
        let v0 = 0x2::object::uid_to_address(&arg2.id);
        let v1 = 0x2::linked_table::borrow_mut<address, TrainerSession>(&mut arg0.trainer_sessions, v0);
        assert!(v1.state == 1 || v1.state == 3, 1201);
        let QuestRequest {
            timestamp    : _,
            version      : v3,
            mystical_bee : v4,
            sui_bet      : v5,
            player_only  : v6,
            with_trainer : v7,
            active_index : v8,
        } = 0x2::linked_table::remove<address, QuestRequest>(&mut arg0.active_trainers, v0);
        let v9 = v8;
        let v10 = v7;
        let v11 = v5;
        update_bee_ownership(arg1, v3, 0x2::object::uid_to_address(&arg2.id));
        deposit_bee_in_trainer(arg2, v4);
        let v12 = if (v1.state != 3) {
            if (v6) {
                0x1::option::is_none<address>(&v10)
            } else {
                false
            }
        } else {
            false
        };
        if (v12) {
            let (_, v14) = 0x1::vector::index_of<u64>(&arg0.active_trainers_indexes, &v9);
            0x1::vector::remove<u64>(&mut arg0.active_trainers_indexes, v14);
            0x2::linked_table::remove<u64, address>(&mut arg0.active_trainers_list, v9);
        };
        if (v1.state == 3) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_pool, 0x2::balance::split<0x2::sui::SUI>(&mut v11, 0x2::balance::value<0x2::sui::SUI>(&v11) * arg0.config.expiry_penalty_pct / 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::constants::percent_precision()));
        };
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v11, 0x2::tx_context::sender(arg3), arg3);
        v1.state = 0;
        let v15 = TrainerCanceledActiveQuest{
            trainer_address : v0,
            version         : v3,
        };
        0x2::event::emit<TrainerCanceledActiveQuest>(v15);
    }

    public entry fun cancel_bid(arg0: &mut MarketPlace, arg1: &mut DragonTrainer, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 1079);
        let v0 = 0x2::object::uid_to_address(&arg1.id);
        let (_, _, _) = destroy_bid_record(0x2::linked_table::remove<u64, BidRecord>(&mut arg1.bid_records, arg2));
        let v4 = 0x2::linked_table::remove<u64, vector<Bid>>(&mut arg0.available_bids, arg2);
        let v5 = &mut v4;
        let v6 = destroy_bid_among_bids(v5, v0, false, arg2);
        0x2::linked_table::push_back<u64, vector<Bid>>(&mut arg0.available_bids, arg2, v4);
        let v7 = BidCanceled{
            version        : arg2,
            bidder_trainer : v0,
            refund_sui     : 0x2::balance::value<0x2::sui::SUI>(&v6),
        };
        0x2::event::emit<BidCanceled>(v7);
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v6, 0x2::tx_context::sender(arg3), arg3);
    }

    public entry fun cancel_listing(arg0: &mut MarketPlace, arg1: &mut DragonTrainer, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 1079);
        assert!(0x2::linked_table::contains<u64, ListingRecord>(&arg1.listing_records, arg2), 1037);
        let v0 = 0x2::linked_table::remove<u64, Listing>(&mut arg0.active_listings, arg2);
        let v1 = ListingCanceled{
            listed_by_trainer : v0.listed_by_trainer,
            version           : arg2,
        };
        0x2::event::emit<ListingCanceled>(v1);
        let (v2, _, _, _) = destroy_listing(v0);
        let (_, _, _) = destroy_listing_record(0x2::linked_table::remove<u64, ListingRecord>(&mut arg1.listing_records, arg2));
        deposit_bee_in_trainer(arg1, v2);
        mark_marketplace_bids_as_invalid(arg0, arg2);
    }

    public entry fun cancel_transfer_of_bee(arg0: &mut BeesManager, arg1: &mut DragonTrainer, arg2: u64) {
        assert!(0x2::linked_table::contains<u64, BeeInFlight>(&arg0.bee_transfers.custodied_bees, arg2), 1194);
        let BeeInFlight {
            mystical_bee   : v0,
            transferred_by : v1,
            recepient      : v2,
        } = 0x2::linked_table::remove<u64, BeeInFlight>(&mut arg0.bee_transfers.custodied_bees, arg2);
        assert!(0x2::object::uid_to_address(&arg1.id) == v1, 1195);
        deposit_bee_in_trainer(arg1, v0);
        let v3 = 0x2::linked_table::borrow_mut<address, vector<u64>>(&mut arg0.bee_transfers.incoming_boxes, v2);
        let (_, v5) = 0x1::vector::index_of<u64>(v3, &arg2);
        0x1::vector::remove<u64>(v3, v5);
        let v6 = 0x2::linked_table::borrow_mut<address, vector<u64>>(&mut arg0.bee_transfers.outgoing_boxes, v1);
        let (_, v8) = 0x1::vector::index_of<u64>(v6, &arg2);
        0x1::vector::remove<u64>(v6, v8);
        let v9 = BeeTransferCancelled{
            version        : arg2,
            transferred_by : v1,
            recepient      : v2,
        };
        0x2::event::emit<BeeTransferCancelled>(v9);
        update_bee_ownership(arg0, arg2, v1);
    }

    public fun charge_mystical_bee(arg0: &0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::DragonFoodCapability, arg1: &mut MysticalBee, arg2: u64) {
        arg1.hive_energy = arg1.hive_energy + arg2;
    }

    fun choose_random_dragon_bee(arg0: &0x2::clock::Clock, arg1: &mut HiddenWorld, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) : (u64, 0x1::option::Option<MysticalBee>) {
        let v0 = 0x2::random::new_generator(arg2, arg3);
        let v1 = 0x1::option::none<MysticalBee>();
        let v2 = 0;
        while (0x1::option::is_none<MysticalBee>(&v1)) {
            let v3 = *0x2::linked_table::borrow_mut<u64, vector<u64>>(&mut arg1.hidden_bees_list, 0x2::random::generate_u64_in_range(&mut v0, 0, arg1.list_count - 1));
            let v4 = 0x2::random::generate_u64_in_range(&mut v0, 0, 0x1::vector::length<u64>(&v3) - 1);
            let v5 = *0x1::vector::borrow<u64>(&v3, v4);
            if (0x2::linked_table::contains<u64, HiddenMysticalBee>(&arg1.hidden_bees, v5)) {
                let v6 = 0x2::linked_table::borrow<u64, HiddenMysticalBee>(&arg1.hidden_bees, v5);
                if (!0x1::option::is_some<MysticalBee>(&v6.mystical_bee)) {
                    continue
                };
                let v7 = 0x1::option::borrow<MysticalBee>(&v6.mystical_bee);
                if (v7.hive_energy < arg1.config.session_energy || v7.honey_health < arg1.config.session_health) {
                    let v8 = 0x2::linked_table::remove<u64, HiddenMysticalBee>(&mut arg1.hidden_bees, v5);
                    delete_hidden_bee(arg0, arg1, v5, v8);
                    0x1::vector::remove<u64>(&mut v3, v4);
                    continue
                };
                v2 = v5;
                0x1::option::fill<MysticalBee>(&mut v1, 0x1::option::extract<MysticalBee>(&mut 0x2::linked_table::borrow_mut<u64, HiddenMysticalBee>(&mut arg1.hidden_bees, v5).mystical_bee));
            };
        };
        (v2, v1)
    }

    fun choose_random_trainer(arg0: u64, arg1: &mut HiddenWorld, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) : (address, u64, 0x1::option::Option<MysticalBee>, 0x2::balance::Balance<0x2::sui::SUI>) {
        let v0 = 0x2::random::new_generator(arg2, arg3);
        let v1 = false;
        let v2 = @0x0;
        let v3 = 0;
        let v4 = 0x1::option::none<MysticalBee>();
        let v5 = 0x2::balance::zero<0x2::sui::SUI>();
        while (!v1) {
            let v6 = 0x2::random::generate_u64_in_range(&mut v0, 0, 0x1::vector::length<u64>(&arg1.active_trainers_indexes) - 1);
            let v7 = *0x2::linked_table::borrow<u64, address>(&arg1.active_trainers_list, v6);
            let v8 = 0x2::linked_table::borrow<address, QuestRequest>(&arg1.active_trainers, v7);
            if (arg0 - v8.timestamp > arg1.config.max_active_duration || 0x1::option::is_some<address>(&v8.with_trainer)) {
                continue
            };
            let QuestRequest {
                timestamp    : _,
                version      : v10,
                mystical_bee : v11,
                sui_bet      : v12,
                player_only  : _,
                with_trainer : _,
                active_index : _,
            } = 0x2::linked_table::remove<address, QuestRequest>(&mut arg1.active_trainers, v7);
            0x1::vector::remove<u64>(&mut arg1.active_trainers_indexes, v6);
            v1 = true;
            v2 = v7;
            v3 = v10;
            0x1::option::fill<MysticalBee>(&mut v4, v11);
            0x2::balance::join<0x2::sui::SUI>(&mut v5, v12);
        };
        (v2, v3, v4, v5)
    }

    public entry fun claim_bee_from_incoming_box(arg0: &mut BeesManager, arg1: &mut DragonTrainer, arg2: u64) {
        let v0 = 0x2::object::uid_to_address(&arg1.id);
        let v1 = 0x2::linked_table::borrow_mut<address, vector<u64>>(&mut arg0.bee_transfers.incoming_boxes, v0);
        let (v2, v3) = 0x1::vector::index_of<u64>(v1, &arg2);
        assert!(v2, 1196);
        0x1::vector::remove<u64>(v1, v3);
        let BeeInFlight {
            mystical_bee   : v4,
            transferred_by : v5,
            recepient      : _,
        } = 0x2::linked_table::remove<u64, BeeInFlight>(&mut arg0.bee_transfers.custodied_bees, arg2);
        deposit_bee_in_trainer(arg1, v4);
        let v7 = 0x2::linked_table::borrow_mut<address, vector<u64>>(&mut arg0.bee_transfers.outgoing_boxes, v5);
        let (_, v9) = 0x1::vector::index_of<u64>(v7, &arg2);
        0x1::vector::remove<u64>(v7, v9);
        let v10 = IncomingBeeClaimed{
            version    : arg2,
            claimed_by : v0,
        };
        0x2::event::emit<IncomingBeeClaimed>(v10);
        update_bee_ownership(arg0, arg2, v0);
    }

    fun claim_gov_yield(arg0: &mut YieldFarm, arg1: &mut MysticalBee) : (0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>, 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>) {
        let v0 = 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::constants::precision_constant();
        let v1 = 0x2::balance::zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>();
        let v2 = 0x2::balance::zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>();
        increment_global_yield_indexes(arg0);
        let v3 = (0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::math::mul_div_u256(arg0.hive_global_index - arg1.nectar.hive_claim_index, (arg1.nectar.weighted_hive_locked as u256), (v0 as u256)) as u64);
        let v4 = (0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::math::mul_div_u256(arg0.honey_global_index - arg1.nectar.honey_claim_index, (arg1.nectar.weighted_honey_locked as u256), (v0 as u256)) as u64);
        0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut v1, 0x2::balance::split<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut arg0.hive_for_bees, v3));
        0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut v2, 0x2::balance::split<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut arg0.honey_for_bees, v4));
        arg1.nectar.hive_claim_index = arg0.hive_global_index;
        arg1.nectar.honey_claim_index = arg0.honey_global_index;
        let v5 = v4 / 2;
        lock_honey_with_bee(arg0, arg1, 0x2::balance::split<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut v2, v5));
        arg1.hive_energy = arg1.hive_energy + v3;
        arg1.honey_health = arg1.honey_health + v4;
        if (v3 > 0 || v4 > 0) {
            let v6 = BeeFarmedYield{
                beeId                : 0x2::object::uid_to_address(&arg1.id),
                version              : arg1.version,
                claimed_hive_amt     : v3,
                claimed_honey_amt    : v4,
                honeylocked          : v5,
                total_honey_locked   : 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&arg1.nectar.honey_locked),
                hive_energy          : arg1.hive_energy,
                honey_health         : arg1.honey_health,
                total_weighted_honey : arg1.nectar.weighted_honey_locked,
            };
            0x2::event::emit<BeeFarmedYield>(v6);
        };
        (v1, v2)
    }

    public entry fun claim_hidden_world_rewards(arg0: &0x2::clock::Clock, arg1: &mut HiddenWorld, arg2: &mut DragonTrainer, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(claim_rewards_from_hidden_world_bees(arg0, arg1, 0x2::object::uid_to_address(&arg2.id), arg3), 0x2::tx_context::sender(arg4), arg4);
    }

    fun claim_rewards_from_hidden_world_bees(arg0: &0x2::clock::Clock, arg1: &mut HiddenWorld, arg2: address, arg3: vector<u64>) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x2::linked_table::borrow_mut<address, TrainerSession>(&mut arg1.trainer_sessions, arg2);
        let v1 = 0x2::balance::zero<0x2::sui::SUI>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        while (0x1::vector::length<u64>(&arg3) > 0) {
            let v4 = 0x1::vector::pop_back<u64>(&mut arg3);
            let (v5, v6) = 0x1::vector::index_of<u64>(&v0.user_bees, &v4);
            if (v5) {
                if (0x2::linked_table::contains<u64, HiddenMysticalBee>(&arg1.hidden_bees, v4)) {
                    let v7 = 0x2::linked_table::borrow_mut<u64, HiddenMysticalBee>(&mut arg1.hidden_bees, v4);
                    0x1::vector::push_back<u64>(&mut v2, v4);
                    0x1::vector::push_back<u64>(&mut v3, 0x2::balance::value<0x2::sui::SUI>(&v7.winnings));
                    0x2::balance::join<0x2::sui::SUI>(&mut v1, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v7.winnings));
                    continue
                };
                0x1::vector::remove<u64>(&mut v0.user_bees, v6);
            };
        };
        let v8 = HiddenWorldRewardsClaimed{
            trainer_address     : arg2,
            sui_winnings        : 0x2::balance::value<0x2::sui::SUI>(&v1),
            claimed_bees        : v2,
            claimed_per_bee_amt : v3,
        };
        0x2::event::emit<HiddenWorldRewardsClaimed>(v8);
        v1
    }

    public fun claim_sui_from_beehive(arg0: &mut BeesManager, arg1: &mut MysticalBee) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg0.module_version == 0, 1079);
        let v0 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut 0x2::linked_table::borrow_mut<u64, BeeHive>(&mut arg0.bee_hives, arg1.version).sui_custody);
        let v1 = SuiClaimedFromBeeHive{
            queen_version : arg1.version,
            sui_claimed   : 0x2::balance::value<0x2::sui::SUI>(&v0),
        };
        0x2::event::emit<SuiClaimedFromBeeHive>(v1);
        v0
    }

    fun compute_veHive(arg0: u64, arg1: u64, arg2: u64) : u128 {
        (0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::math::mul_div_u256(0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::math::mul_div_u256((arg1 as u256), (arg0 as u256), (208 as u256)), (get_evolution_multiplier((arg2 as u8)) as u256), (1000000 as u256)) as u128)
    }

    fun create_bid(arg0: address, arg1: u64, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: u64) : Bid {
        Bid{
            bidder_trainer : arg0,
            balance        : arg2,
            offer_price    : arg1,
            expiration_sec : arg3,
            is_valid       : true,
        }
    }

    fun create_bid_record(arg0: u64, arg1: u64, arg2: u64) : BidRecord {
        BidRecord{
            version        : arg0,
            offer_price    : arg1,
            expiration_sec : arg2,
        }
    }

    fun create_hidden_world_quest(arg0: &0x2::clock::Clock, arg1: address, arg2: address, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: u64, arg5: u64, arg6: MysticalBee, arg7: MysticalBee) : HiddenWorldQuest {
        HiddenWorldQuest{
            trainer_addr1     : arg1,
            trainer_addr2     : arg2,
            next_turn         : 1,
            last_action_ts    : 0x2::clock::timestamp_ms(arg0),
            sui_bet_bal       : arg3,
            start_game_health : arg4,
            start_game_energy : arg5,
            user_bee_health   : arg4,
            user_bee_energy   : arg5,
            user_dragon_bee   : arg6,
            user2_bee_health  : arg4,
            user2_bee_energy  : arg5,
            user2_dragon_bee  : arg7,
        }
    }

    fun create_p2p_game_session(arg0: &0x2::clock::Clock, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: MysticalBee, arg6: MysticalBee, arg7: 0x2::balance::Balance<0x2::sui::SUI>, arg8: u64, arg9: u64) : P2pGameSession {
        P2pGameSession{
            trainer_addr1   : arg1,
            trainer_addr2   : arg2,
            version1        : arg3,
            v1_dust_pct_sum : 0,
            v1_evolved      : 0,
            version2        : arg4,
            v2_dust_pct_sum : 0,
            v2_evolved      : 0,
            current_quest   : create_hidden_world_quest(arg0, arg1, arg2, arg7, arg8, arg9, arg5, arg6),
        }
    }

    fun create_p2p_session_id(arg0: u64, arg1: u64) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v0, 0x1::string::utf8(u64_to_ascii(arg0)));
        0x1::string::append(&mut v0, 0x1::string::utf8(u64_to_ascii(arg1)));
        v0
    }

    fun create_trainer_session(arg0: address) : TrainerSession {
        TrainerSession{
            trainer_address : arg0,
            user_bees       : 0x1::vector::empty<u64>(),
            quests_count    : 0,
            sui_balance     : 0x2::balance::zero<0x2::sui::SUI>(),
            current_quest   : 0x1::string::utf8(b""),
            state           : 0,
        }
    }

    fun delete_dragon_bee(arg0: &0x2::clock::Clock, arg1: MysticalBee) {
        let MysticalBee {
            id                : v0,
            version           : v1,
            name              : _,
            owned_by          : _,
            queen_version     : _,
            genes             : v5,
            appearance        : v6,
            birth_certificate : v7,
            eggs_basket       : v8,
            nectar            : v9,
            capabilities      : v10,
            game_state        : v11,
            hive_energy       : _,
            honey_health      : _,
            dragon_dust       : _,
            is_hatched        : _,
        } = arg1;
        let v16 = v10;
        let BirthCertificate {
            generation      : _,
            birth_time      : _,
            birther_trainer : _,
            queenId         : _,
            stingerId       : _,
        } = v7;
        let EggBasketInfo {
            is_queen         : _,
            total_eggs       : _,
            hatch_egg_record : _,
            last_egg_ts      : _,
            cooldown_stage   : _,
            cooldown_till_ts : _,
        } = v8;
        let NectarStore {
            evolution_stage       : _,
            lockup_weeks          : _,
            hive_locked           : v30,
            weighted_hive_locked  : _,
            unlock_timestamp      : _,
            honey_locked          : v33,
            weighted_honey_locked : _,
            hive_claim_index      : _,
            honey_claim_index     : _,
        } = v9;
        0x2::balance::destroy_zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(v30);
        0x2::balance::destroy_zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(v33);
        while (0x2::linked_table::length<u64, CapabilityState>(&v16) > 0) {
            let (_, v38) = 0x2::linked_table::pop_back<u64, CapabilityState>(&mut v16);
            let CapabilityState {
                cap_type          : _,
                health_impact_pct : _,
                energy_cost_pct   : _,
                attempts          : _,
                cooldown          : _,
                next_use_ts       : _,
                base_attempts     : _,
            } = v38;
        };
        0x2::linked_table::destroy_empty<u64, CapabilityState>(v16);
        0x2::linked_table::drop<0x1::ascii::String, address>(v11);
        0x2::linked_table::drop<u64, 0x1::string::String>(v6);
        let v46 = BeeDeletedFromHiddenWorld{
            deleted_at : 0x2::clock::timestamp_ms(arg0),
            version    : v1,
            genes      : v5,
        };
        0x2::event::emit<BeeDeletedFromHiddenWorld>(v46);
        0x2::object::delete(v0);
    }

    public entry fun delete_dragon_trainer(arg0: &mut DegenHiveMapStore, arg1: &mut HiveGraph, arg2: &mut 0x2::token::TokenPolicy<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg3: &0x2::token::TokenPolicyCap<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg4: &YieldFarm, arg5: DragonTrainer, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::uid_to_address(&arg5.id);
        assert!(arg4.trading_enabled, 1210);
        assert!(0x2::linked_table::length<u64, address>(&arg5.locked_bees) == 0, 1211);
        let v1 = if (0x2::linked_table::length<u64, MysticalBee>(&arg5.owned_bees) == 0) {
            if (0x2::linked_table::length<u64, ListingRecord>(&arg5.listing_records) == 0) {
                0x2::linked_table::length<u64, BidRecord>(&arg5.bid_records) == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 1155);
        let DragonTrainer {
            id               : v2,
            owner            : v3,
            joined_at        : _,
            username         : v5,
            inscription      : v6,
            available_honey  : v7,
            available_sui    : v8,
            owned_bees       : v9,
            locked_bees      : v10,
            listing_records  : v11,
            bid_records      : v12,
            trainer_sessions : v13,
            module_version   : _,
        } = arg5;
        let v15 = v8;
        let v16 = v7;
        0x2::object::delete(v2);
        0x2::linked_table::destroy_empty<u64, MysticalBee>(v9);
        0x2::linked_table::destroy_empty<u64, ListingRecord>(v11);
        0x2::linked_table::destroy_empty<u64, BidRecord>(v12);
        0x2::linked_table::drop<0x1::ascii::String, address>(v13);
        0x2::linked_table::destroy_empty<u64, address>(v10);
        let Inscription {
            format : _,
            base64 : v18,
        } = v6;
        0x2::linked_table::drop<u64, 0x1::string::String>(v18);
        0x2::linked_table::remove<address, address>(&mut arg0.owner_to_trainer_mapping, v3);
        0x2::linked_table::remove<0x1::ascii::String, address>(&mut arg0.username_to_trainer_mapping, to_lowercase(arg5.username));
        0x2::linked_table::drop<address, bool>(0x2::linked_table::remove<address, 0x2::linked_table::LinkedTable<address, bool>>(&mut arg1.followers_list, v0));
        0x2::linked_table::drop<address, bool>(0x2::linked_table::remove<address, 0x2::linked_table::LinkedTable<address, bool>>(&mut arg1.following_list, v0));
        let v19 = DragonTrainerDeleted{
            owner           : v3,
            username        : v5,
            profile_addr    : v0,
            recepient       : arg6,
            available_honey : 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&v16),
            available_sui   : 0x2::balance::value<0x2::sui::SUI>(&v15),
        };
        0x2::event::emit<DragonTrainerDeleted>(v19);
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v15, arg6, arg7);
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::transfer_honey_balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(arg2, arg3, v16, arg6, arg7);
    }

    public fun delete_expired_trainer_request_from_list(arg0: &0x2::clock::Clock, arg1: &mut HiddenWorld, arg2: address) {
        assert!(arg1.module_version == 0, 1079);
        let v0 = 0x2::linked_table::borrow_mut<address, TrainerSession>(&mut arg1.trainer_sessions, arg2);
        assert!(v0.state == 1, 1201);
        let v1 = 0x2::linked_table::borrow_mut<address, QuestRequest>(&mut arg1.active_trainers, arg2);
        let v2 = v1.active_index;
        let v3 = if (0x2::clock::timestamp_ms(arg0) > v1.timestamp + arg1.config.max_active_duration) {
            if (v1.player_only) {
                0x1::option::is_none<address>(&v1.with_trainer)
            } else {
                false
            }
        } else {
            false
        };
        if (v3) {
            let (_, v5) = 0x1::vector::index_of<u64>(&arg1.active_trainers_indexes, &v2);
            0x1::vector::remove<u64>(&mut arg1.active_trainers_indexes, v5);
            0x2::linked_table::remove<u64, address>(&mut arg1.active_trainers_list, v2);
            v1.active_index = 0;
            v0.state = 3;
        };
        let v6 = QuestRequestExpired{
            trainer_address : arg2,
            version         : v1.version,
        };
        0x2::event::emit<QuestRequestExpired>(v6);
    }

    fun delete_hidden_bee(arg0: &0x2::clock::Clock, arg1: &mut HiddenWorld, arg2: u64, arg3: HiddenMysticalBee) {
        let HiddenMysticalBee {
            mystical_bee        : v0,
            winnings            : v1,
            winnings_sum        : v2,
            loosing_sum         : v3,
            dragon_dust_emitted : v4,
        } = arg3;
        let v5 = v0;
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_pool, v1);
        if (0x1::option::is_some<MysticalBee>(&v5)) {
            delete_dragon_bee(arg0, 0x1::option::extract<MysticalBee>(&mut v5));
        };
        0x1::option::destroy_none<MysticalBee>(v5);
        let v6 = HiddenBeeDeleted{
            deleted_at          : 0x2::clock::timestamp_ms(arg0),
            version             : arg2,
            winnings_sum        : v2,
            loosing_sum         : v3,
            dragon_dust_emitted : v4,
        };
        0x2::event::emit<HiddenBeeDeleted>(v6);
    }

    public fun deposit_bee_back_to_its_owner(arg0: &mut DragonTrainer, arg1: MysticalBee) {
        assert!(0x2::object::uid_to_address(&arg0.id) == arg1.owned_by, 1166);
        deposit_bee_in_trainer(arg0, arg1);
    }

    fun deposit_bee_in_trainer(arg0: &mut DragonTrainer, arg1: MysticalBee) {
        0x2::linked_table::push_back<u64, MysticalBee>(&mut arg0.owned_bees, arg1.version, arg1);
    }

    public fun deposit_hive_for_distribution(arg0: &mut YieldFarm, arg1: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>) {
        if (0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&arg1) > 0) {
            let v0 = HiveAddedForHarvest{yield_added: 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&arg1)};
            0x2::event::emit<HiveAddedForHarvest>(v0);
        };
        0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut arg0.incoming_hive_for_bees, arg1);
        increment_global_yield_indexes(arg0);
    }

    public fun deposit_hive_with_dragon_eggs_basket(arg0: &mut BeesManager, arg1: 0x2::coin::Coin<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(arg1);
        0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut 0x2::table::borrow_mut<u64, DragonEggsBasket>(&mut arg0.dragon_eggs_basket, 420).hive_avail, 0x2::balance::split<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut v0, arg2));
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::coin_helper::destroy_or_transfer_balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(v0, 0x2::tx_context::sender(arg3), arg3);
    }

    public fun deposit_hive_with_treasury(arg0: &mut BeesManager, arg1: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>) {
        0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut arg0.hive_treasury, arg1);
        let v0 = HiveAddedToTreasury{
            hive_added             : 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&arg1),
            total_hive_in_treasury : 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&arg0.hive_treasury),
        };
        0x2::event::emit<HiveAddedToTreasury>(v0);
    }

    public fun deposit_honey_for_distribution(arg0: &mut YieldFarm, arg1: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>) {
        if (0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&arg1) > 0) {
            let v0 = HoneyAddedForHarvest{yield_added: 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&arg1)};
            0x2::event::emit<HoneyAddedForHarvest>(v0);
        };
        0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut arg0.incoming_honey_for_bees, arg1);
        increment_global_yield_indexes(arg0);
    }

    public fun deposit_honey_in_dragon_school(arg0: &mut DragonSchool, arg1: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>) {
        let v0 = 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&arg1);
        if (v0 > 0) {
            let v1 = HoneyAddedToProfile{
                username        : arg0.username,
                profile_addr    : 0x2::object::uid_to_address(&arg0.id),
                deposited_honey : v0,
            };
            0x2::event::emit<HoneyAddedToProfile>(v1);
        };
        0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut arg0.available_honey, arg1);
    }

    public fun deposit_honey_in_trainer(arg0: &mut DragonTrainer, arg1: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>) {
        let v0 = 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&arg1);
        if (v0 > 0) {
            let v1 = HoneyAddedToProfile{
                username        : arg0.username,
                profile_addr    : 0x2::object::uid_to_address(&arg0.id),
                deposited_honey : v0,
            };
            0x2::event::emit<HoneyAddedToProfile>(v1);
        };
        0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut arg0.available_honey, arg1);
    }

    public fun deposit_honey_tokens_for_distribution(arg0: &mut YieldFarm, arg1: &0x2::token::TokenPolicyCap<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg2: &mut 0x2::token::TokenPolicy<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg3: &mut 0x2::token::Token<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::unwrap_honey_tokens_to_coins<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(arg3, arg1, arg2, arg4, arg5));
        if (0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&v0) > 0) {
            let v1 = HoneyAddedForHarvest{yield_added: 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&v0)};
            0x2::event::emit<HoneyAddedForHarvest>(v1);
        };
        0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut arg0.incoming_honey_for_bees, v0);
        increment_global_yield_indexes(arg0);
    }

    public fun deposit_honey_with_dragon_eggs_basket(arg0: &mut BeesManager, arg1: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>) {
        0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut 0x2::table::borrow_mut<u64, DragonEggsBasket>(&mut arg0.dragon_eggs_basket, 420).honey_avail, arg1);
    }

    public fun deposit_honey_with_treasury(arg0: &mut BeesManager, arg1: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>) {
        0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut arg0.honey_treasury, arg1);
        let v0 = HoneyAddedToTreasury{
            honey_added             : 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&arg1),
            total_honey_in_treasury : 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&arg0.honey_treasury),
        };
        0x2::event::emit<HoneyAddedToTreasury>(v0);
    }

    fun destroy_bid(arg0: Bid, arg1: u64) : (0x2::balance::Balance<0x2::sui::SUI>, address, u64, u64, bool) {
        let Bid {
            bidder_trainer : v0,
            balance        : v1,
            offer_price    : v2,
            expiration_sec : v3,
            is_valid       : v4,
        } = arg0;
        let v5 = BidDestroyed{
            bee_version    : arg1,
            bidder_trainer : v0,
        };
        0x2::event::emit<BidDestroyed>(v5);
        (v1, v0, v2, v3, v4)
    }

    fun destroy_bid_among_bids(arg0: &mut vector<Bid>, arg1: address, arg2: bool, arg3: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Bid>(arg0)) {
            if (0x1::vector::borrow<Bid>(arg0, v1).bidder_trainer == arg1) {
                let v2 = 0x1::vector::remove<Bid>(arg0, v1);
                if (arg2) {
                    assert!(!v2.is_valid, 1075);
                };
                let (v3, _, _, _, _) = destroy_bid(v2, arg3);
                0x2::balance::join<0x2::sui::SUI>(&mut v0, v3);
                return v0
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun destroy_bid_record(arg0: BidRecord) : (u64, u64, u64) {
        let BidRecord {
            version        : v0,
            offer_price    : v1,
            expiration_sec : v2,
        } = arg0;
        (v0, v1, v2)
    }

    fun destroy_listing(arg0: Listing) : (MysticalBee, address, u64, u64) {
        let Listing {
            listed_by_trainer : v0,
            mystical_bee      : v1,
            min_price         : v2,
            expiration_sec    : v3,
        } = arg0;
        let v4 = v1;
        let v5 = ListingDestroyed{
            version           : v4.version,
            listed_by_trainer : v0,
        };
        0x2::event::emit<ListingDestroyed>(v5);
        (v4, v0, v2, v3)
    }

    fun destroy_listing_record(arg0: ListingRecord) : (u64, u64, u64) {
        let ListingRecord {
            version        : v0,
            min_price      : v1,
            expiration_sec : v2,
        } = arg0;
        (v0, v1, v2)
    }

    public fun does_dapp_name_exist(arg0: &DegenHiveMapStore, arg1: 0x1::ascii::String) : bool {
        0x2::linked_table::contains<0x1::ascii::String, address>(&arg0.app_names_to_cap_mapping, arg1)
    }

    public fun dragon_food_claim_gov_yield(arg0: &0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::DragonFoodCapability, arg1: &mut YieldFarm, arg2: &mut MysticalBee) : (0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>, 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>) {
        claim_gov_yield(arg1, arg2)
    }

    public fun dragon_food_deposit_bee(arg0: &0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::DragonFoodCapability, arg1: &mut BeesManager, arg2: &mut DragonTrainer, arg3: MysticalBee) {
        update_bee_ownership(arg1, arg3.version, 0x2::object::uid_to_address(&arg2.id));
        0x2::linked_table::remove<u64, address>(&mut arg2.locked_bees, arg3.version);
        deposit_bee_in_trainer(arg2, arg3);
    }

    public fun dragon_food_infuse_bee_with_energy(arg0: &0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::DragonFoodCapability, arg1: &0x2::clock::Clock, arg2: &mut YieldFarm, arg3: &mut MysticalBee, arg4: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>) : (0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>, 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>) {
        internal_infuse_bee_with_energy(arg1, arg2, arg3, arg4, 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&arg4), 0)
    }

    public fun dragon_food_infuse_bee_with_health(arg0: &0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::DragonFoodCapability, arg1: &0x2::clock::Clock, arg2: &mut YieldFarm, arg3: &mut MysticalBee, arg4: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>) : (0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>, 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>) {
        internal_infuse_bee_with_honey(arg1, arg2, arg3, arg4)
    }

    fun emit_dragon_dust(arg0: &mut HiddenWorld, arg1: &0x2::random::Random, arg2: &mut HiddenWorldQuest, arg3: bool, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::random::new_generator(arg1, arg5);
        let (v1, v2) = if (arg3) {
            (arg2.user_dragon_bee.genes, arg2.user_dragon_bee.version)
        } else {
            (arg2.user2_dragon_bee.genes, arg2.user2_dragon_bee.version)
        };
        if (!0x2::linked_table::contains<u64, DragonDust>(&arg0.dragon_dust, v2)) {
            let v3 = DragonDust{
                quests_played   : 0,
                evolution_stage : 1,
                evolved_genes   : 0x1::vector::empty<u256>(),
                genes_img_map   : 0x2::linked_table::new<u64, vector<0x1::string::String>>(arg5),
                evolution_map   : 0x1::vector::empty<u64>(),
            };
            0x2::linked_table::push_back<u64, DragonDust>(&mut arg0.dragon_dust, v2, v3);
        };
        if (0x2::random::generate_u64_in_range(&mut v0, 1, 100) > calculate_dragon_dust_chance(arg0, 0x2::linked_table::borrow<u64, DragonDust>(&arg0.dragon_dust, v2).quests_played)) {
            return 0
        };
        let v4 = 0x2::linked_table::borrow_mut<u64, DragonDust>(&mut arg0.dragon_dust, v2);
        let v5 = 0x2::random::generate_u64_in_range(&mut v0, 10, 100);
        let v6 = arg4 * v5 / 100;
        if (arg3) {
            arg2.user_dragon_bee.dragon_dust = arg2.user_dragon_bee.dragon_dust + v6;
        } else {
            arg2.user2_dragon_bee.dragon_dust = arg2.user2_dragon_bee.dragon_dust + v6;
        };
        if (0x1::vector::length<u256>(&v4.evolved_genes) < 7) {
            let v7 = &mut v0;
            0x1::vector::push_back<u256>(&mut v4.evolved_genes, evolved_gene_generator(v7, v1));
        };
        let v8 = arg0.total_quests_count;
        arg0.avg_dragon_dust_emitted = ((((arg0.avg_dragon_dust_emitted as u256) * (v8 as u256) + (v6 as u256)) / ((v8 as u256) + 1)) as u64);
        let v9 = arg2.start_game_energy / 2 * v5 / 100;
        let v10 = arg2.start_game_health / 2 * v5 / 100;
        if (arg3) {
            arg2.user_bee_health = arg2.user_bee_health + v10;
            arg2.user_bee_energy = arg2.user_bee_energy + v9;
            arg2.user_dragon_bee.hive_energy = arg2.user_dragon_bee.hive_energy + v9;
            arg2.user_dragon_bee.honey_health = arg2.user_dragon_bee.honey_health + v10;
        } else {
            arg2.user2_bee_health = arg2.user2_bee_health + v10;
            arg2.user2_bee_energy = arg2.user2_bee_energy + v9;
            arg2.user2_dragon_bee.hive_energy = arg2.user2_dragon_bee.hive_energy + v9;
            arg2.user2_dragon_bee.honey_health = arg2.user2_dragon_bee.honey_health + v10;
        };
        v5
    }

    entry fun engage_hidden_world_quest(arg0: &0x2::clock::Clock, arg1: &0x2::random::Random, arg2: &BeesManager, arg3: &mut HiddenWorld, arg4: &DragonTrainer, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x2::random::new_generator(arg1, arg6);
        let v2 = 0x2::object::uid_to_address(&arg4.id);
        let v3 = 0x2::linked_table::borrow<address, TrainerSession>(&arg3.trainer_sessions, v2);
        let v4 = v3.current_quest;
        assert!(0x2::linked_table::contains<0x1::string::String, P2pGameSession>(&arg3.p2p_quests, v3.current_quest), 1197);
        let v5 = 0x2::linked_table::remove<0x1::string::String, P2pGameSession>(&mut arg3.p2p_quests, v3.current_quest);
        let v6 = v5.current_quest.next_turn;
        let v7 = v6;
        if (v5.trainer_addr2 != @0x0 && arg3.config.turn_duration > 0) {
            let v8 = get_current_turn((v6 as u64), v0, v5.current_quest.last_action_ts, arg3.config.turn_duration);
            v7 = v8;
            if (v8 == 1) {
                assert!(v5.trainer_addr1 == v2, 1208);
            } else {
                assert!(v5.trainer_addr2 == v2, 1208);
            };
        };
        let v9 = v5.current_quest.start_game_health;
        let v10 = v5.current_quest.start_game_energy;
        let v11 = 0x2::balance::value<0x2::sui::SUI>(&v5.current_quest.sui_bet_bal);
        let (v12, v13) = if (v5.trainer_addr1 == v2) {
            let v14 = &mut v5.current_quest.user_dragon_bee;
            let v15 = &mut v5.current_quest.user2_dragon_bee;
            let (v16, v17) = internal_handle_battle_turn(v14, v15, v10, v9, arg5, v0);
            let v18 = &mut v5.current_quest;
            let (v19, v20, _) = internal_handle_battle_turn_impact(true, v18, v16, v17);
            (v19, v20)
        } else {
            let v22 = &mut v5.current_quest.user2_dragon_bee;
            let v23 = &mut v5.current_quest.user_dragon_bee;
            let (v24, v25) = internal_handle_battle_turn(v22, v23, v10, v9, arg5, v0);
            let v26 = &mut v5.current_quest;
            let (v27, v28, _) = internal_handle_battle_turn_impact(false, v26, v24, v25);
            (v27, v28)
        };
        if (v5.trainer_addr1 == @0x0) {
            let v30 = false;
            let v31 = v30;
            let v32 = 0;
            let v33 = 0;
            if (!v30) {
                while (!v31) {
                    let v34 = &mut v5.current_quest.user2_dragon_bee;
                    let v35 = &mut v5.current_quest.user_dragon_bee;
                    let (v36, v37) = attack_bee(v34, v35, v10, v9, (0x2::random::generate_u64_in_range(&mut v1, 1, 6) as u8), v0);
                    v32 = v37;
                    v33 = v36;
                    if (v36 > 0) {
                        v31 = true;
                    };
                };
            };
            let v38 = &mut v5.current_quest;
            let (v39, v40, _) = internal_handle_battle_turn_impact(false, v38, v33, v32);
            v13 = v40;
            v12 = v39;
        };
        let v42 = v5.current_quest.start_game_health * arg3.config.health_pct_to_emit_dust / 100;
        if (v7 == 1 && v5.current_quest.user_bee_health <= v42) {
            let v43 = &mut v5.current_quest;
            let v44 = emit_dragon_dust(arg3, arg1, v43, true, v11, arg6);
            v5.v1_dust_pct_sum = v5.v1_dust_pct_sum + v44;
            let v45 = &mut v1;
            let v46 = &mut v5.current_quest.user_dragon_bee;
            let v47 = evolve_dragon_bee(arg2, arg3, v45, v46);
            v5.v1_evolved = v5.v1_evolved + v47;
        };
        if (v7 == 2 && v5.current_quest.user2_bee_health <= v42) {
            let v48 = &mut v5.current_quest;
            let v49 = emit_dragon_dust(arg3, arg1, v48, false, v11, arg6);
            v5.v2_dust_pct_sum = v5.v2_dust_pct_sum + v49;
            let v50 = &mut v1;
            let v51 = &mut v5.current_quest.user2_dragon_bee;
            let v52 = evolve_dragon_bee(arg2, arg3, v50, v51);
            v5.v2_evolved = v5.v2_evolved + v52;
        };
        v5.current_quest.last_action_ts = v0;
        v5.current_quest.next_turn = (v7 + 1) % 2;
        process_and_store_quest(arg1, arg3, v4, v5, v12, v13, arg6);
    }

    public entry fun entry_add_bee_friends_for_breeding(arg0: &mut BeesManager, arg1: &DragonTrainer, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg0.module_version == 0, 1079);
        assert!(0x2::linked_table::contains<u64, MysticalBee>(&arg1.owned_bees, arg2), 1159);
        let v0 = 0x2::linked_table::borrow<u64, MysticalBee>(&arg1.owned_bees, arg2);
        assert!(v0.eggs_basket.is_queen, 1158);
        add_bee_friends_for_breeding(arg0, v0, arg3, arg4);
    }

    public fun entry_claim_sui_from_beehive(arg0: &mut BeesManager, arg1: &mut DragonTrainer, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::linked_table::borrow_mut<u64, MysticalBee>(&mut arg1.owned_bees, arg2);
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(claim_sui_from_beehive(arg0, v0), 0x2::tx_context::sender(arg3), arg3);
    }

    public fun entry_deposit_honey_in_dragon_school(arg0: &mut DragonSchool, arg1: &mut 0x2::token::TokenPolicy<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg2: &0x2::token::TokenPolicyCap<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg3: 0x2::token::Token<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        deposit_honey_in_dragon_school(arg0, 0x2::coin::into_balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::unwrap_honey_tokens_to_coins<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut arg3, arg2, arg1, arg4, arg5)));
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::transfer_honey<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut arg3, arg2, arg1, 0x2::token::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&arg3), 0x2::tx_context::sender(arg5), arg5);
        0x2::token::destroy_zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(arg3);
    }

    public entry fun entry_deposit_honey_in_trainer(arg0: &mut DragonTrainer, arg1: &mut 0x2::token::TokenPolicy<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg2: &0x2::token::TokenPolicyCap<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg3: 0x2::token::Token<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        deposit_honey_in_trainer(arg0, 0x2::coin::into_balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::unwrap_honey_tokens_to_coins<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut arg3, arg2, arg1, arg4, arg5)));
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::transfer_honey<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut arg3, arg2, arg1, 0x2::token::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&arg3), 0x2::tx_context::sender(arg5), arg5);
        0x2::token::destroy_zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(arg3);
    }

    public entry fun entry_remove_bee_friends_for_breeding(arg0: &mut BeesManager, arg1: &DragonTrainer, arg2: u64, arg3: u64) {
        assert!(arg0.module_version == 0, 1079);
        assert!(0x2::linked_table::contains<u64, MysticalBee>(&arg1.owned_bees, arg2), 1159);
        let v0 = 0x2::linked_table::borrow<u64, MysticalBee>(&arg1.owned_bees, arg2);
        assert!(v0.eggs_basket.is_queen, 1158);
        remove_bee_friends_for_breeding(arg0, v0, arg3);
    }

    public entry fun entry_update_pricing_for_breeding(arg0: &mut BeesManager, arg1: &DragonTrainer, arg2: u64, arg3: bool, arg4: u64, arg5: u64) {
        assert!(arg0.module_version == 0, 1079);
        assert!(0x2::linked_table::contains<u64, MysticalBee>(&arg1.owned_bees, arg2), 1159);
        let v0 = 0x2::linked_table::borrow<u64, MysticalBee>(&arg1.owned_bees, arg2);
        assert!(v0.eggs_basket.is_queen, 1158);
        update_pricing_for_breeding(arg0, v0, arg3, arg4, arg5);
    }

    fun evolve_bee_powers(arg0: &BeesManager, arg1: &mut MysticalBee, arg2: &mut 0x2::random::RandomGenerator, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = 0xbe7aee0c1e79fee9b7478821a5c3eab28ade3c513b0c7a027990e0adabeb5ca8::beescience::decode_dominant_power_traits(arg1.genes);
        let v1 = 0x2::table::borrow<u64, DragonEggsBasket>(&arg0.dragon_eggs_basket, 420);
        let v2 = 0;
        while (v2 < 7) {
            let v3 = v2 * 15 + (*0x1::vector::borrow<u8>(&v0, v2) as u64);
            assert!(0x2::linked_table::contains<u64, CapabilityState>(&v1.capabilities, v3), 9223397454471233535);
            let v4 = 0x2::linked_table::borrow<u64, CapabilityState>(&v1.capabilities, v3);
            let v5 = arg3 * arg5;
            let v6 = adjust_capability_value(v4.health_impact_pct, 0x2::random::generate_u64_in_range(arg2, 0, v5), arg4);
            let v7 = adjust_capability_value(v4.energy_cost_pct, 0x2::random::generate_u64_in_range(arg2, 0, v5), arg4);
            if (0x2::linked_table::contains<u64, CapabilityState>(&arg1.capabilities, v2)) {
                let CapabilityState {
                    cap_type          : _,
                    health_impact_pct : _,
                    energy_cost_pct   : _,
                    attempts          : _,
                    cooldown          : _,
                    next_use_ts       : _,
                    base_attempts     : _,
                } = 0x2::linked_table::remove<u64, CapabilityState>(&mut arg1.capabilities, v2);
            };
            let v15 = CapabilityState{
                cap_type          : v4.cap_type,
                health_impact_pct : v6,
                energy_cost_pct   : v7,
                attempts          : v4.attempts,
                cooldown          : v4.cooldown,
                next_use_ts       : 0,
                base_attempts     : v4.attempts,
            };
            0x2::linked_table::push_back<u64, CapabilityState>(&mut arg1.capabilities, (v2 as u64), v15);
            let v16 = CapabilityAdded{
                version           : arg1.version,
                slot              : v2,
                capability_type   : v4.cap_type,
                health_impact_pct : v6,
                energy_cost_pct   : v7,
                attempts          : v4.attempts,
                cooldown          : v4.cooldown,
                next_use_ts       : 0,
                base_attempts     : v4.attempts,
            };
            0x2::event::emit<CapabilityAdded>(v16);
            v2 = v2 + 1;
        };
    }

    fun evolve_dragon_bee(arg0: &BeesManager, arg1: &mut HiddenWorld, arg2: &mut 0x2::random::RandomGenerator, arg3: &mut MysticalBee) : u64 {
        let v0 = 0x2::linked_table::borrow_mut<u64, DragonDust>(&mut arg1.dragon_dust, arg3.version);
        let v1 = arg1.avg_dragon_dust_emitted * (v0.evolution_stage as u64) * 7 / 2;
        if (arg3.dragon_dust < v1) {
            return 0
        };
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 10 && v2 == 0) {
            let v5 = 0x2::random::generate_u64_in_range(arg2, 0, 0x1::vector::length<u256>(&v0.evolved_genes) - 1);
            if (0x2::linked_table::contains<u64, vector<0x1::string::String>>(&v0.genes_img_map, v5)) {
                v2 = 0x1::vector::remove<u256>(&mut v0.evolved_genes, v5);
                let v6 = 0x2::linked_table::remove<u64, vector<0x1::string::String>>(&mut v0.genes_img_map, v5);
                while (0x2::linked_table::length<u64, 0x1::string::String>(&arg3.appearance) > 0) {
                    let (_, _) = 0x2::linked_table::pop_back<u64, 0x1::string::String>(&mut arg3.appearance);
                };
                let v9 = 0;
                while (v9 < 0x1::vector::length<0x1::string::String>(&v6)) {
                    0x2::linked_table::push_back<u64, 0x1::string::String>(&mut arg3.appearance, v9, *0x1::vector::borrow<0x1::string::String>(&v6, v9));
                    v9 = v9 + 1;
                };
            };
            v4 = v4 + 1;
        };
        if (v2 > 0) {
            arg3.dragon_dust = arg3.dragon_dust - v1;
            arg3.genes = v2;
            0x1::vector::push_back<u64>(&mut v0.evolution_map, v1);
            while (0x1::vector::length<u256>(&v0.evolved_genes) > 0) {
                0x1::vector::pop_back<u256>(&mut v0.evolved_genes);
            };
            while (0x2::linked_table::length<u64, vector<0x1::string::String>>(&v0.genes_img_map) > 0) {
                let (_, _) = 0x2::linked_table::pop_back<u64, vector<0x1::string::String>>(&mut v0.genes_img_map);
            };
            evolve_bee_powers(arg0, arg3, arg2, (v0.evolution_stage as u64), arg1.config.max_capability_increase, arg1.config.max_power_pct);
            v0.evolution_stage = v0.evolution_stage + 1;
            v3 = v0.evolution_stage;
        };
        (v3 as u64)
    }

    fun evolved_gene_generator(arg0: &mut 0x2::random::RandomGenerator, arg1: u256) : u256 {
        let v0 = 0x1::vector::empty<u256>();
        0x1::vector::push_back<u256>(&mut v0, (0x2::random::generate_u128_in_range(arg0, 340282, 340384634633755) as u256) << 128 | (0x2::random::generate_u128_in_range(arg0, 340282, 340282366920938463463) as u256));
        0x1::vector::push_back<u256>(&mut v0, (0x2::random::generate_u128_in_range(arg0, 340282, 340384634633755) as u256) << 128 | (0x2::random::generate_u128_in_range(arg0, 340282, 340282366920938463463) as u256));
        0x1::vector::push_back<u256>(&mut v0, (0x2::random::generate_u128_in_range(arg0, 340282, 340384634633755) as u256) << 128 | (0x2::random::generate_u128_in_range(arg0, 340282, 340282366920938463463) as u256));
        0xbe7aee0c1e79fee9b7478821a5c3eab28ade3c513b0c7a027990e0adabeb5ca8::beescience::evolve_bee(arg1, v0)
    }

    fun execute_sale(arg0: &mut BeesManager, arg1: &mut MarketPlace, arg2: &mut 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::FeeCollector<0x2::sui::SUI>, arg3: u64, arg4: bool, arg5: address, arg6: u64, arg7: &mut 0x2::balance::Balance<0x2::sui::SUI>) : ExecutedListing {
        let (v0, v1, _, _) = destroy_listing(0x2::linked_table::remove<u64, Listing>(&mut arg1.active_listings, arg3));
        let v4 = v0;
        assert!(v1 != arg5, 1062);
        if (0x2::linked_table::contains<u64, vector<Bid>>(&arg1.available_bids, arg3)) {
            let v5 = 0x2::linked_table::remove<u64, vector<Bid>>(&mut arg1.available_bids, arg3);
            let v6 = 0;
            while (v6 < 0x1::vector::length<Bid>(&v5)) {
                let v7 = 0x1::vector::borrow_mut<Bid>(&mut v5, v6);
                v7.is_valid = false;
                let v8 = BidMarkedInvalid{
                    version        : arg3,
                    bidder_trainer : v7.bidder_trainer,
                };
                0x2::event::emit<BidMarkedInvalid>(v8);
                if (arg4 && v7.bidder_trainer == arg5) {
                    let (v9, _, v11, _, _) = destroy_bid(0x1::vector::remove<Bid>(&mut v5, v6), arg3);
                    if (arg6 == 0) {
                        arg6 = v11;
                    };
                    0x2::balance::join<0x2::sui::SUI>(arg7, v9);
                    break
                };
                v6 = v6 + 1;
            };
            0x2::linked_table::push_back<u64, vector<Bid>>(&mut arg1.available_bids, arg3, v5);
        };
        assert!(arg6 > 0, 1186);
        let v14 = ExecutedListing{
            listed_by_trainer : v1,
            mystical_bee      : 0x1::option::some<MysticalBee>(v4),
            version           : arg3,
            balance           : 0x1::option::some<0x2::balance::Balance<0x2::sui::SUI>>(process_royalty(0x2::balance::split<0x2::sui::SUI>(arg7, arg6), arg0, arg2, v4.queen_version, v4.birth_certificate.generation == 0)),
            bidder_trainer    : arg5,
            executed_price    : arg6,
        };
        let v15 = SaleExecuted{
            version        : arg3,
            buyer_trainer  : arg5,
            seller_trainer : v1,
            purchase_price : arg6,
        };
        0x2::event::emit<SaleExecuted>(v15);
        v14
    }

    public fun exists_for_trainer(arg0: &DragonTrainer, arg1: 0x1::ascii::String) : bool {
        0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, arg1)
    }

    public entry fun follow_trainer(arg0: &mut HiveGraph, arg1: &DragonTrainer, arg2: address) {
        follow_trainer_and_return(arg0, arg1, arg2);
    }

    public fun follow_trainer_and_return(arg0: &mut HiveGraph, arg1: &DragonTrainer, arg2: address) : bool {
        let v0 = 0x2::object::uid_to_address(&arg1.id);
        assert!(arg2 != v0, 1087);
        let v1 = false;
        let v2 = 0x2::linked_table::borrow_mut<address, 0x2::linked_table::LinkedTable<address, bool>>(&mut arg0.following_list, v0);
        let v3 = 0x2::linked_table::borrow_mut<address, 0x2::linked_table::LinkedTable<address, bool>>(&mut arg0.followers_list, arg2);
        if (!0x2::linked_table::contains<address, bool>(v2, arg2)) {
            v1 = true;
            0x2::linked_table::push_back<address, bool>(v2, arg2, true);
            0x2::linked_table::push_back<address, bool>(v3, v0, true);
        };
        let v4 = JoinedHiveOfProfile{
            follower_trainer_addr : v0,
            followed_trainer      : arg2,
            follower_username     : 0x1::string::from_ascii(arg1.username),
        };
        0x2::event::emit<JoinedHiveOfProfile>(v4);
        v1
    }

    public fun free_expired_suins_domain_username(arg0: &0x2::clock::Clock, arg1: &mut DegenHiveMapStore, arg2: 0x1::ascii::String, arg3: &0x2::tx_context::TxContext) {
        let v0 = to_lowercase(arg2);
        assert!(0x2::clock::timestamp_ms(arg0) > 0x2::linked_table::remove<0x1::ascii::String, u64>(&mut arg1.suins_name_to_expiry_mapping, v0), 1137);
        let v1 = SuiNsNameExpired{
            profile_addr      : 0x2::linked_table::remove<0x1::ascii::String, address>(&mut arg1.username_to_trainer_mapping, v0),
            suins_domain_name : 0x1::string::from_ascii(arg2),
        };
        0x2::event::emit<SuiNsNameExpired>(v1);
    }

    public fun game_master_adds_honey_to_trainer_via_bee(arg0: &mut GameMasterKey, arg1: &0x2::clock::Clock, arg2: &mut YieldFarm, arg3: &mut DragonTrainer, arg4: u64, arg5: u64) {
        if (arg5 > 0) {
            let v0 = 0x2::linked_table::borrow_mut<u64, MysticalBee>(&mut arg3.owned_bees, arg4);
            let v1 = 0x2::balance::split<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut arg0.honey_incentives, arg5);
            let (v2, v3) = update_global_mystic_power(arg1, arg2, v0, 0x2::balance::split<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut v1, arg5 / 2), 0x2::balance::zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(), 0, false, false);
            let v4 = HoneyAddedToProfile{
                username        : arg3.username,
                profile_addr    : 0x2::object::uid_to_address(&arg3.id),
                deposited_honey : arg5 / 2,
            };
            0x2::event::emit<HoneyAddedToProfile>(v4);
            0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut arg3.available_honey, v1);
            let v5 = internal_replenish_master_key(arg0, v2, v3, 0, arg5);
            0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut arg0.hive_incentives, v5);
        };
    }

    public fun game_master_bees_attack(arg0: &mut GameMasterKey, arg1: &0x2::clock::Clock, arg2: &mut MysticalBee, arg3: &mut MysticalBee, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = attack_bee(arg2, arg3, arg4, arg5, (arg6 as u8), 0x2::clock::timestamp_ms(arg1));
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::coin_helper::destroy_or_transfer_balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(internal_replenish_master_key(arg0, 0x2::balance::zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(), 0x2::balance::zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(), v0 / 2, v1 / 2), 0x2::tx_context::sender(arg7), arg7);
    }

    public fun game_master_claim_hidden_world_rewards(arg0: &GameMasterKey, arg1: &0x2::clock::Clock, arg2: &mut HiddenWorld, arg3: vector<u64>) : 0x2::balance::Balance<0x2::sui::SUI> {
        claim_rewards_from_hidden_world_bees(arg1, arg2, 0x2::object::uid_to_address(&arg0.id), arg3)
    }

    public fun game_master_deposit_bee(arg0: &GameMasterKey, arg1: &mut BeesManager, arg2: &mut DragonTrainer, arg3: MysticalBee) {
        update_bee_ownership(arg1, arg3.version, 0x2::object::uid_to_address(&arg2.id));
        deposit_bee_in_trainer(arg2, arg3);
    }

    public fun game_master_infuses_bee_with_energy(arg0: &mut GameMasterKey, arg1: &0x2::clock::Clock, arg2: &mut YieldFarm, arg3: &mut MysticalBee, arg4: u64, arg5: u64) : 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE> {
        assert!(arg2.module_version == 0, 1079);
        let (v0, v1) = internal_infuse_bee_with_energy(arg1, arg2, arg3, 0x2::balance::split<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut arg0.hive_incentives, arg4), arg4, arg5);
        let v2 = v1;
        let v3 = v0;
        internal_replenish_master_key(arg0, v2, v3, 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&v3), 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&v2))
    }

    public fun game_master_infuses_bee_with_health(arg0: &mut GameMasterKey, arg1: &0x2::clock::Clock, arg2: &mut YieldFarm, arg3: &mut MysticalBee, arg4: u64) : 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE> {
        assert!(arg2.module_version == 0, 1079);
        let (v0, v1) = internal_infuse_bee_with_honey(arg1, arg2, arg3, 0x2::balance::split<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut arg0.honey_incentives, arg4));
        let v2 = v1;
        let v3 = v0;
        internal_replenish_master_key(arg0, v2, v3, 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&v3), 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&v2))
    }

    public fun game_master_send_to_hidden_world(arg0: &mut GameMasterKey, arg1: &0x2::clock::Clock, arg2: &mut BeesManager, arg3: &mut HiddenWorld, arg4: &mut YieldFarm, arg5: MysticalBee, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE> {
        assert!(arg4.module_version == 0, 1079);
        let (v0, v1) = internal_send_to_hidden_world(arg1, arg2, arg3, arg4, arg5, 0x2::object::uid_to_address(&arg0.id), arg6);
        internal_replenish_master_key(arg0, v1, v0, 0, 0)
    }

    public fun game_master_withdraw_bee(arg0: &GameMasterKey, arg1: &mut BeesManager, arg2: &mut DragonTrainer, arg3: u64) : MysticalBee {
        withdraw_bee_from_trainer(arg1, arg2, arg3, 0x2::object::uid_to_address(&arg0.id))
    }

    public fun game_master_withdraws_hive_from_bee(arg0: &mut GameMasterKey, arg1: &0x2::clock::Clock, arg2: &mut YieldFarm, arg3: &mut MysticalBee) : 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE> {
        let (v0, v1) = internal_unlock_hive_from_bee(arg1, arg2, arg3);
        internal_replenish_master_key(arg0, v1, v0, 0, 0)
    }

    public fun get_accrued_yield_for_bee(arg0: &YieldFarm, arg1: &MysticalBee) : (u64, u64, u64) {
        let v0 = 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::constants::precision_constant();
        let v1 = 0;
        let v2 = 0;
        if (arg0.governance_info.total_weighted_hive > 0) {
            v1 = 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::math::mul_div_u256((0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&arg0.incoming_hive_for_bees) as u256), (0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::constants::precision_constant() as u256), (arg0.governance_info.total_weighted_hive as u256));
        };
        if (arg0.governance_info.total_weighted_honey > 0) {
            v2 = 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::math::mul_div_u256((0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&arg0.incoming_honey_for_bees) as u256), (0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::constants::precision_constant() as u256), (arg0.governance_info.total_weighted_honey as u256));
        };
        let v3 = (0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::math::mul_div_u256(arg0.honey_global_index + v2 - arg1.nectar.honey_claim_index, (arg1.nectar.weighted_honey_locked as u256), (v0 as u256)) as u64);
        let v4 = v3 / 2;
        ((0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::math::mul_div_u256(arg0.hive_global_index + v1 - arg1.nectar.hive_claim_index, (arg1.nectar.weighted_hive_locked as u256), (v0 as u256)) as u64), v3 - v4, v4)
    }

    public fun get_accrued_yield_for_listed_bee(arg0: &YieldFarm, arg1: &MarketPlace, arg2: u64) : (u64, u64, u64) {
        if (0x2::linked_table::contains<u64, Listing>(&arg1.active_listings, arg2)) {
            get_accrued_yield_for_bee(arg0, &0x2::linked_table::borrow<u64, Listing>(&arg1.active_listings, arg2).mystical_bee)
        } else if (0x2::linked_table::contains<u64, ExecutedListing>(&arg1.processed_listings, arg2)) {
            get_accrued_yield_for_bee(arg0, 0x1::option::borrow<MysticalBee>(&0x2::linked_table::borrow<u64, ExecutedListing>(&arg1.processed_listings, arg2).mystical_bee))
        } else {
            (0, 0, 0)
        }
    }

    public fun get_accrued_yield_for_owned_bee(arg0: &YieldFarm, arg1: &mut DragonTrainer, arg2: u64) : (u64, u64, u64) {
        get_accrued_yield_for_bee(arg0, 0x2::linked_table::borrow<u64, MysticalBee>(&arg1.owned_bees, arg2))
    }

    public fun get_active_trainers_indexes(arg0: &HiddenWorld) : vector<u64> {
        arg0.active_trainers_indexes
    }

    public fun get_all_owners_and_trainers_list(arg0: &DegenHiveMapStore, arg1: 0x1::option::Option<address>, arg2: u64) : (vector<address>, vector<address>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<address>();
        let v2 = if (0x1::option::is_some<address>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<address, address>(&arg0.owner_to_trainer_mapping)
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<address>(&v3) && v4 < arg2) {
            let v5 = 0x1::option::borrow<address>(&v3);
            0x1::vector::push_back<address>(&mut v0, *v5);
            0x1::vector::push_back<address>(&mut v1, *0x2::linked_table::borrow<address, address>(&arg0.owner_to_trainer_mapping, *v5));
            v3 = *0x2::linked_table::next<address, address>(&arg0.owner_to_trainer_mapping, *v5);
            v4 = v4 + 1;
        };
        (v0, v1, 0x2::linked_table::length<address, address>(&arg0.owner_to_trainer_mapping))
    }

    public fun get_all_supported_apps_and_capabilities(arg0: &DegenHiveMapStore, arg1: 0x1::option::Option<0x1::ascii::String>, arg2: u64) : (vector<0x1::ascii::String>, vector<address>, u64) {
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

    public fun get_all_usernames_and_comp_trainers_list(arg0: &DegenHiveMapStore, arg1: 0x1::option::Option<0x1::string::String>, arg2: u64) : (vector<0x1::ascii::String>, vector<address>, u64) {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = 0x1::vector::empty<address>();
        let v2 = if (0x1::option::is_some<0x1::string::String>(&arg1)) {
            0x1::option::some<0x1::ascii::String>(0x1::string::to_ascii(*0x1::option::borrow<0x1::string::String>(&arg1)))
        } else {
            *0x2::linked_table::front<0x1::ascii::String, address>(&arg0.username_to_school_mapping)
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<0x1::ascii::String>(&v3) && v4 < arg2) {
            let v5 = 0x1::option::borrow<0x1::ascii::String>(&v3);
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, *v5);
            0x1::vector::push_back<address>(&mut v1, *0x2::linked_table::borrow<0x1::ascii::String, address>(&arg0.username_to_school_mapping, *v5));
            v3 = *0x2::linked_table::next<0x1::ascii::String, address>(&arg0.username_to_school_mapping, *v5);
            v4 = v4 + 1;
        };
        (v0, v1, 0x2::linked_table::length<0x1::ascii::String, address>(&arg0.username_to_school_mapping))
    }

    public fun get_all_usernames_and_trainers_list(arg0: &DegenHiveMapStore, arg1: 0x1::option::Option<0x1::string::String>, arg2: u64) : (vector<0x1::ascii::String>, vector<address>, u64) {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = 0x1::vector::empty<address>();
        let v2 = if (0x1::option::is_some<0x1::string::String>(&arg1)) {
            0x1::option::some<0x1::ascii::String>(to_lowercase(0x1::string::to_ascii(*0x1::option::borrow<0x1::string::String>(&arg1))))
        } else {
            *0x2::linked_table::front<0x1::ascii::String, address>(&arg0.username_to_trainer_mapping)
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<0x1::ascii::String>(&v3) && v4 < arg2) {
            let v5 = 0x1::option::borrow<0x1::ascii::String>(&v3);
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, *v5);
            0x1::vector::push_back<address>(&mut v1, *0x2::linked_table::borrow<0x1::ascii::String, address>(&arg0.username_to_trainer_mapping, *v5));
            v3 = *0x2::linked_table::next<0x1::ascii::String, address>(&arg0.username_to_trainer_mapping, *v5);
            v4 = v4 + 1;
        };
        (v0, v1, 0x2::linked_table::length<0x1::ascii::String, address>(&arg0.username_to_trainer_mapping))
    }

    public fun get_appearance(arg0: &MysticalBee) : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = *0x2::linked_table::front<u64, 0x1::string::String>(&arg0.appearance);
        while (0x1::option::is_some<u64>(&v1)) {
            0x1::vector::push_back<0x1::string::String>(&mut v0, *0x2::linked_table::borrow<u64, 0x1::string::String>(&arg0.appearance, *0x1::option::borrow<u64>(&v1)));
            let v2 = 0x2::linked_table::next<u64, 0x1::string::String>(&arg0.appearance, *0x1::option::borrow<u64>(&v1));
            v1 = *v2;
        };
        v0
    }

    public fun get_available_hive_in_school(arg0: &DragonSchool) : u64 {
        0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&arg0.available_hive)
    }

    public fun get_available_honey(arg0: &DragonTrainer) : u64 {
        0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&arg0.available_honey)
    }

    public fun get_available_honey_in_school(arg0: &DragonSchool) : u64 {
        0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&arg0.available_honey)
    }

    public fun get_available_sui(arg0: &DragonTrainer) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.available_sui)
    }

    public fun get_bee_egg_content(arg0: &BeesManager, arg1: u64, arg2: u64) : (u64, u64, address, u64, u256, bool) {
        let v0 = 0x2::linked_table::borrow<u64, BeeEgg>(&0x2::linked_table::borrow<u64, BeeHive>(&arg0.bee_hives, arg1).incubating_eggs, arg2);
        (v0.timestamp, v0.egg_index, v0.stingerBeeId, v0.stingerBeeVersion, v0.stinger_gene, v0.is_processed)
    }

    public fun get_bee_family(arg0: &MysticalBee) : u64 {
        (0xbe7aee0c1e79fee9b7478821a5c3eab28ade3c513b0c7a027990e0adabeb5ca8::beescience::get_family_type(arg0.genes) as u64)
    }

    public fun get_bee_for_queen_competition(arg0: &0x2::coin::TreasuryCap<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>, arg1: &mut BeesManager, arg2: address, arg3: &mut DragonTrainer, arg4: u64) : MysticalBee {
        assert!(arg1.module_version == 0 && arg3.module_version == 0, 1079);
        let v0 = withdraw_bee_from_trainer(arg1, arg3, arg4, arg2);
        assert!(v0.is_hatched, 1192);
        assert!(!v0.eggs_basket.is_queen && !0x1::option::is_some<BeeEggRecord>(&v0.eggs_basket.hatch_egg_record), 1001);
        v0
    }

    public fun get_bee_info(arg0: &MysticalBee) : (u64, 0x1::string::String, address, u64, u256, u64, u64, address, 0x1::option::Option<address>, 0x1::option::Option<address>, bool, u64, bool, u64, u8, u64, u8, u64, u128, u64, u64, u64, u128, u64, u64, u64, u64, u64, bool) {
        (arg0.version, arg0.name, arg0.owned_by, arg0.queen_version, arg0.genes, arg0.birth_certificate.generation, arg0.birth_certificate.birth_time, arg0.birth_certificate.birther_trainer, arg0.birth_certificate.queenId, arg0.birth_certificate.stingerId, arg0.eggs_basket.is_queen, arg0.eggs_basket.total_eggs, 0x1::option::is_some<BeeEggRecord>(&arg0.eggs_basket.hatch_egg_record), arg0.eggs_basket.last_egg_ts, arg0.eggs_basket.cooldown_stage, arg0.eggs_basket.cooldown_till_ts, arg0.nectar.evolution_stage, 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&arg0.nectar.hive_locked), arg0.nectar.weighted_hive_locked, arg0.nectar.lockup_weeks, arg0.nectar.unlock_timestamp, 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&arg0.nectar.honey_locked), arg0.nectar.weighted_honey_locked, 0x2::linked_table::length<u64, CapabilityState>(&arg0.capabilities), 0x2::linked_table::length<0x1::ascii::String, address>(&arg0.game_state), arg0.hive_energy, arg0.honey_health, arg0.dragon_dust, arg0.is_hatched)
    }

    public fun get_bee_trainer(arg0: &BeesManager, arg1: u64) : address {
        *0x2::linked_table::borrow<u64, address>(&arg0.bees_tracker.bees_to_owner_map, arg1)
    }

    public fun get_bee_version(arg0: &MysticalBee) : u64 {
        arg0.version
    }

    public fun get_beehive_content(arg0: &BeesManager, arg1: u64) : (u64, u64, u64, u64, u256, u64, u64, u64) {
        let v0 = 0x2::linked_table::borrow<u64, BeeHive>(&arg0.bee_hives, arg1);
        (v0.queen_version, v0.max_eggs_limit, v0.eggs_incubated, v0.auction_epoch, v0.queen_gene, v0.base_price, v0.curve_a, 0x2::balance::value<0x2::sui::SUI>(&v0.sui_custody))
    }

    public fun get_bees_manager_params_info(arg0: &BeesManager) : (u64, u64, u64, u64) {
        let v0 = &arg0.configuration;
        (v0.max_bids_per_bee, v0.min_bid_amt, v0.trainer_onboarding_fee, v0.mutation_fee)
    }

    public fun get_bees_to_collect_list(arg0: &HiddenWorld, arg1: address) : vector<u64> {
        let v0 = 0x2::linked_table::borrow<address, vector<MysticalBee>>(&arg0.bees_to_collect, arg1);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<MysticalBee>(v0)) {
            0x1::vector::push_back<u64>(&mut v1, 0x1::vector::borrow<MysticalBee>(v0, v2).version);
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_bid_record(arg0: &DragonTrainer, arg1: u64) : (u64, u64, u64) {
        if (!0x2::linked_table::contains<u64, BidRecord>(&arg0.bid_records, arg1)) {
            return (0, 0, 0)
        };
        let v0 = 0x2::linked_table::borrow<u64, BidRecord>(&arg0.bid_records, arg1);
        (v0.version, v0.offer_price, v0.expiration_sec)
    }

    public fun get_bid_records(arg0: &DragonTrainer) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = *0x2::linked_table::front<u64, BidRecord>(&arg0.bid_records);
        while (0x1::option::is_some<u64>(&v1)) {
            0x1::vector::push_back<u64>(&mut v0, *0x1::option::borrow<u64>(&v1));
            let v2 = 0x2::linked_table::next<u64, BidRecord>(&arg0.bid_records, *0x1::option::borrow<u64>(&v1));
            v1 = *v2;
        };
        v0
    }

    public fun get_bids_for_listing(arg0: &MarketPlace, arg1: u64, arg2: 0x1::option::Option<u64>, arg3: u64) : (vector<address>, vector<u64>, vector<u64>, vector<bool>, u64) {
        if (!0x2::linked_table::contains<u64, vector<Bid>>(&arg0.available_bids, arg1)) {
            return (0x1::vector::empty<address>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<bool>(), 0)
        };
        let v0 = 0x2::linked_table::borrow<u64, vector<Bid>>(&arg0.available_bids, arg1);
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<bool>();
        let v5 = if (0x1::option::is_some<u64>(&arg2)) {
            0x1::option::extract<u64>(&mut arg2)
        } else {
            0
        };
        while (v5 < arg3 && v5 < 0x1::vector::length<Bid>(v0)) {
            let v6 = 0x1::vector::borrow<Bid>(v0, v5);
            0x1::vector::push_back<address>(&mut v1, v6.bidder_trainer);
            0x1::vector::push_back<u64>(&mut v2, v6.offer_price);
            0x1::vector::push_back<u64>(&mut v3, v6.expiration_sec);
            0x1::vector::push_back<bool>(&mut v4, v6.is_valid);
            v5 = v5 + 1;
        };
        (v1, v2, v3, v4, 0x1::vector::length<Bid>(v0))
    }

    public fun get_breeding_royalty_info(arg0: &BeesManager) : (u64, u64, u64) {
        (arg0.configuration.breeding_royalty.platform_fees_pct, arg0.configuration.breeding_royalty.gov_yield_pct, arg0.configuration.breeding_royalty.treasury_pct)
    }

    public fun get_capability_state(arg0: &MysticalBee, arg1: u8) : (u8, u64, u64, u64, u64, u64, u64) {
        let v0 = 0x2::linked_table::borrow<u64, CapabilityState>(&arg0.capabilities, (arg1 as u64));
        (v0.cap_type, v0.health_impact_pct, v0.energy_cost_pct, v0.attempts, v0.cooldown, v0.next_use_ts, v0.base_attempts)
    }

    fun get_current_turn(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u8 {
        (((arg0 + (arg1 - arg2) / arg3) % 2) as u8)
    }

    public fun get_dragon_bee_power(arg0: &MysticalBee) : (u128, u128) {
        ((arg0.hive_energy as u128), (arg0.honey_health as u128))
    }

    public fun get_dragon_dust_info(arg0: &HiddenWorld, arg1: u64) : (u64, u8, vector<u256>, vector<u64>) {
        if (!0x2::linked_table::contains<u64, DragonDust>(&arg0.dragon_dust, arg1)) {
            return (0, 0, 0x1::vector::empty<u256>(), 0x1::vector::empty<u64>())
        };
        let v0 = 0x2::linked_table::borrow<u64, DragonDust>(&arg0.dragon_dust, arg1);
        (v0.quests_played, v0.evolution_stage, v0.evolved_genes, v0.evolution_map)
    }

    public fun get_dragon_eggs_basket_content(arg0: &BeesManager, arg1: u64) : (u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64) {
        let v0 = 0x2::table::borrow<u64, DragonEggsBasket>(&arg0.dragon_eggs_basket, arg1);
        (v0.start_time, v0.eggs_count, v0.eggs_laid, v0.queen_bee_eggs_count, v0.queen_chance, v0.queen_eggs_laid, v0.max_eggs_limit, v0.base_price, v0.curve_a, v0.per_user_limit, 0x1::vector::length<u64>(&v0.bees_indexes), 0x2::linked_table::length<u64, 0x2::linked_table::LinkedTable<u64, 0x1::string::String>>(&v0.images_list), 0x2::linked_table::length<u64, 0x2::linked_table::LinkedTable<u64, 0x1::string::String>>(&v0.dragonbee_imgs_list), 0x2::linked_table::length<u64, u256>(&v0.genesis_genes_list), 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&v0.honey_avail), 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&v0.hive_avail))
    }

    public fun get_dragon_school_meta_info(arg0: &DragonSchool) : (address, 0x1::string::String, address) {
        (0x2::object::uid_to_address(&arg0.id), 0x1::string::from_ascii(arg0.username), arg0.owner)
    }

    public fun get_dragon_trainers_list(arg0: &BeesManager, arg1: 0x1::option::Option<u64>, arg2: u64) : (vector<u64>, vector<address>, u64) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<address>();
        let v2 = if (0x1::option::is_some<u64>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<u64, address>(&arg0.bees_tracker.bees_to_owner_map)
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<u64>(&v3) && v4 < arg2) {
            let v5 = 0x1::option::borrow<u64>(&v3);
            0x1::vector::push_back<u64>(&mut v0, *v5);
            0x1::vector::push_back<address>(&mut v1, *0x2::linked_table::borrow<u64, address>(&arg0.bees_tracker.bees_to_owner_map, *v5));
            v3 = *0x2::linked_table::next<u64, address>(&arg0.bees_tracker.bees_to_owner_map, *v5);
            v4 = v4 + 1;
        };
        (v0, v1, 0x2::linked_table::length<u64, address>(&arg0.bees_tracker.bees_to_owner_map))
    }

    public fun get_eggs_info_for_bee(arg0: &MysticalBee) : (bool, u64, bool, u64, u64, u64, u256, u64, u8, u64) {
        let v0 = &arg0.eggs_basket;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        if (0x1::option::is_some<BeeEggRecord>(&v0.hatch_egg_record)) {
            let v5 = 0x1::option::borrow<BeeEggRecord>(&v0.hatch_egg_record);
            v1 = v5.child_version;
            v2 = v5.child_generation;
            v3 = v5.child_gene;
            v4 = v5.queen_version;
        };
        (v0.is_queen, v0.total_eggs, 0x1::option::is_some<BeeEggRecord>(&v0.hatch_egg_record), v4, v1, v2, v3, v0.last_egg_ts, v0.cooldown_stage, v0.cooldown_till_ts)
    }

    public fun get_evolution_multiplier(arg0: u8) : u64 {
        (((1000000 + (arg0 as u64) * 4 * 1000000 / 7) as u256) as u64)
    }

    public fun get_executed_listing_info(arg0: &MarketPlace, arg1: u64) : (0x1::string::String, bool, bool, u64, 0x1::string::String, u64) {
        if (!0x2::linked_table::contains<u64, ExecutedListing>(&arg0.processed_listings, arg1)) {
            return (0x1::string::utf8(b""), false, false, 0, 0x1::string::utf8(b""), 0)
        };
        let v0 = 0x2::linked_table::borrow<u64, ExecutedListing>(&arg0.processed_listings, arg1);
        let v1 = 0x1::option::is_some<0x2::balance::Balance<0x2::sui::SUI>>(&v0.balance);
        let v2 = 0;
        if (v1) {
            v2 = 0x2::balance::value<0x2::sui::SUI>(0x1::option::borrow<0x2::balance::Balance<0x2::sui::SUI>>(&v0.balance));
        };
        (0x2::address::to_string(v0.listed_by_trainer), 0x1::option::is_some<MysticalBee>(&v0.mystical_bee), v1, v2, 0x2::address::to_string(v0.bidder_trainer), v0.executed_price)
    }

    public fun get_followers_and_following_length(arg0: &HiveGraph, arg1: address) : (u64, u64) {
        (0x2::linked_table::length<address, bool>(0x2::linked_table::borrow<address, 0x2::linked_table::LinkedTable<address, bool>>(&arg0.followers_list, arg1)), 0x2::linked_table::length<address, bool>(0x2::linked_table::borrow<address, 0x2::linked_table::LinkedTable<address, bool>>(&arg0.following_list, arg1)))
    }

    public fun get_followers_list(arg0: &HiveGraph, arg1: address, arg2: 0x1::option::Option<address>, arg3: u64) : (vector<address>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x2::linked_table::borrow<address, 0x2::linked_table::LinkedTable<address, bool>>(&arg0.followers_list, arg1);
        let v2 = if (0x1::option::is_some<address>(&arg2)) {
            arg2
        } else {
            *0x2::linked_table::front<address, bool>(v1)
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<address>(&v3) && v4 < arg3) {
            let v5 = 0x1::option::borrow<address>(&v3);
            0x1::vector::push_back<address>(&mut v0, *v5);
            v3 = *0x2::linked_table::next<address, bool>(v1, *v5);
            v4 = v4 + 1;
        };
        (v0, 0x2::linked_table::length<address, bool>(v1))
    }

    public fun get_following_list(arg0: &HiveGraph, arg1: address, arg2: 0x1::option::Option<address>, arg3: u64) : (vector<address>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x2::linked_table::borrow<address, 0x2::linked_table::LinkedTable<address, bool>>(&arg0.following_list, arg1);
        let v2 = if (0x1::option::is_some<address>(&arg2)) {
            arg2
        } else {
            *0x2::linked_table::front<address, bool>(v1)
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<address>(&v3) && v4 < arg3) {
            let v5 = 0x1::option::borrow<address>(&v3);
            0x1::vector::push_back<address>(&mut v0, *v5);
            v3 = *0x2::linked_table::next<address, bool>(v1, *v5);
            v4 = v4 + 1;
        };
        (v0, 0x2::linked_table::length<address, bool>(v1))
    }

    public fun get_hidden_mystical_bee_info(arg0: &HiddenWorld, arg1: u64) : (u64, 0x1::string::String, u64, u256, u64, u64, address, 0x1::option::Option<address>, bool, u64, bool, u64, u8, u64, u64, u64, u64, u64, u64, u64, u64) {
        let v0 = 0x2::linked_table::borrow<u64, HiddenMysticalBee>(&arg0.hidden_bees, arg1);
        let v1 = 0x1::option::borrow<MysticalBee>(&v0.mystical_bee);
        (v1.version, v1.name, v1.queen_version, v1.genes, v1.birth_certificate.generation, v1.birth_certificate.birth_time, v1.birth_certificate.birther_trainer, v1.birth_certificate.stingerId, v1.eggs_basket.is_queen, v1.eggs_basket.total_eggs, 0x1::option::is_some<BeeEggRecord>(&v1.eggs_basket.hatch_egg_record), v1.eggs_basket.last_egg_ts, v1.eggs_basket.cooldown_stage, v1.eggs_basket.cooldown_till_ts, v1.hive_energy, v1.honey_health, v1.dragon_dust, 0x2::balance::value<0x2::sui::SUI>(&v0.winnings), v0.winnings_sum, v0.loosing_sum, v0.dragon_dust_emitted)
    }

    public fun get_hidden_mystical_bees_info(arg0: &HiddenWorld, arg1: vector<u64>) : (vector<0x1::string::String>, vector<u256>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<u64>) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = 0x1::vector::empty<u256>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 0x1::vector::empty<u64>();
        let v8 = 0x1::vector::empty<u64>();
        let v9 = 0;
        while (v9 < 0x1::vector::length<u64>(&arg1)) {
            let v10 = 0x2::linked_table::borrow<u64, HiddenMysticalBee>(&arg0.hidden_bees, *0x1::vector::borrow<u64>(&arg1, v9));
            let v11 = 0x1::option::borrow<MysticalBee>(&v10.mystical_bee);
            0x1::vector::push_back<0x1::string::String>(&mut v0, v11.name);
            0x1::vector::push_back<u256>(&mut v1, v11.genes);
            0x1::vector::push_back<u64>(&mut v2, v11.honey_health);
            0x1::vector::push_back<u64>(&mut v3, v11.hive_energy);
            0x1::vector::push_back<u64>(&mut v4, v11.dragon_dust);
            0x1::vector::push_back<u64>(&mut v5, v10.winnings_sum);
            0x1::vector::push_back<u64>(&mut v6, v10.winnings_sum);
            0x1::vector::push_back<u64>(&mut v7, v10.loosing_sum);
            0x1::vector::push_back<u64>(&mut v8, v10.dragon_dust_emitted);
            v9 = v9 + 1;
        };
        (v0, v1, v2, v3, v4, v5, v6, v7, v8)
    }

    public fun get_hidden_world_version_list(arg0: &HiddenWorld, arg1: u64) : vector<u64> {
        *0x2::linked_table::borrow<u64, vector<u64>>(&arg0.hidden_bees_list, arg1)
    }

    public fun get_listed_bee_eggs_info(arg0: &MarketPlace, arg1: u64) : (bool, u64, bool, u64, u64, u64, u256, u64, u8, u64) {
        get_eggs_info_for_bee(&0x2::linked_table::borrow<u64, Listing>(&arg0.active_listings, arg1).mystical_bee)
    }

    public fun get_listed_bee_info(arg0: &MarketPlace, arg1: u64) : (u64, 0x1::string::String, address, u64, u256, u64, u64, address, 0x1::option::Option<address>, 0x1::option::Option<address>, bool, u64, bool, u64, u8, u64, u8, u64, u128, u64, u64, u64, u128, u64, u64, u64, u64, u64, bool) {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27, v28) = if (0x2::linked_table::contains<u64, Listing>(&arg0.active_listings, arg1)) {
            let (v29, v30, v31, v32, v33, v34, v35, v36, v37, v38, v39, v40, v41, v42, v43, v44, v45, v46, v47, v48, v49, v50, v51, v52, v53, v54, v55, v56, v57) = get_bee_info(&0x2::linked_table::borrow<u64, Listing>(&arg0.active_listings, arg1).mystical_bee);
            (v29, v38, v39, v40, v41, v42, v43, v44, v45, v46, v47, v30, v48, v49, v50, v51, v52, v53, v54, v55, v56, v57, v31, v32, v33, v34, v35, v36, v37)
        } else {
            let (v58, v59, v60, v61, v62, v63, v64, v65, v66, v67, v68, v69, v70, v71, v72, v73, v74, v75, v76, v77, v78, v79, v80, v81, v82, v83, v84, v85, v86) = get_bee_info(0x1::option::borrow<MysticalBee>(&0x2::linked_table::borrow<u64, ExecutedListing>(&arg0.processed_listings, arg1).mystical_bee));
            (v58, v67, v68, v69, v70, v71, v72, v73, v74, v75, v76, v59, v77, v78, v79, v80, v81, v82, v83, v84, v85, v86, v60, v61, v62, v63, v64, v65, v66)
        };
        (v0, v11, v22, v23, v24, v25, v26, v27, v28, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21)
    }

    public fun get_listed_bees_in_marketplace(arg0: &MarketPlace, arg1: 0x1::option::Option<u64>, arg2: u64) : (vector<u64>, u64) {
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

    public fun get_listing_from_marketplace(arg0: &MarketPlace, arg1: u64) : (0x1::string::String, u64, u64) {
        if (!0x2::linked_table::contains<u64, Listing>(&arg0.active_listings, arg1)) {
            return (0x1::string::utf8(b""), 0, 0)
        };
        let v0 = 0x2::linked_table::borrow<u64, Listing>(&arg0.active_listings, arg1);
        (0x2::address::to_string(v0.listed_by_trainer), v0.min_price, v0.expiration_sec)
    }

    public fun get_listing_record(arg0: &DragonTrainer, arg1: u64) : (u64, u64) {
        if (!0x2::linked_table::contains<u64, ListingRecord>(&arg0.listing_records, arg1)) {
            return (0, 0)
        };
        let v0 = 0x2::linked_table::borrow<u64, ListingRecord>(&arg0.listing_records, arg1);
        (v0.min_price, v0.expiration_sec)
    }

    public fun get_listing_records(arg0: &DragonTrainer) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = *0x2::linked_table::front<u64, ListingRecord>(&arg0.listing_records);
        while (0x1::option::is_some<u64>(&v1)) {
            0x1::vector::push_back<u64>(&mut v0, *0x1::option::borrow<u64>(&v1));
            let v2 = 0x2::linked_table::next<u64, ListingRecord>(&arg0.listing_records, *0x1::option::borrow<u64>(&v1));
            v1 = *v2;
        };
        v0
    }

    public fun get_locked_assets(arg0: &DragonTrainer) : (u64, u64) {
        let v0 = 0x2::dynamic_object_field::borrow<0x1::string::String, LockedDegenHiveAssets>(&arg0.id, 0x1::string::utf8(b"LOCKED_DEGEN_HIVE_ASSETS"));
        (0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&v0.hive_locked), 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&v0.honey_locked))
    }

    public fun get_locked_bees_paginated(arg0: &DragonTrainer, arg1: u64, arg2: 0x1::option::Option<u64>) : (vector<u64>, vector<address>, u64) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<address>();
        let v2 = if (0x1::option::is_some<u64>(&arg2)) {
            arg2
        } else {
            *0x2::linked_table::front<u64, address>(&arg0.locked_bees)
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<u64>(&v3) && v4 < arg1) {
            0x1::vector::push_back<u64>(&mut v0, *0x1::option::borrow<u64>(&v3));
            0x1::vector::push_back<address>(&mut v1, *0x2::linked_table::borrow<u64, address>(&arg0.locked_bees, *0x1::option::borrow<u64>(&v3)));
            let v5 = 0x2::linked_table::next<u64, address>(&arg0.locked_bees, *0x1::option::borrow<u64>(&v3));
            v3 = *v5;
            v4 = v4 + 1;
        };
        (v0, v1, 0x2::linked_table::length<u64, address>(&arg0.locked_bees))
    }

    public fun get_master_key_info(arg0: &GameMasterKey) : (address, 0x1::ascii::String, u64, u64, u64, u64) {
        (0x2::object::uid_to_address(&arg0.id), arg0.app_name, arg0.total_energy, arg0.total_health, 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&arg0.hive_incentives), 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&arg0.honey_incentives))
    }

    public fun get_mystical_bee_info_with_power(arg0: &MysticalBee) : (address, u64, address, u64, u256, u64, bool, u64, u64, u8, u64, u8, u64, u128, u64, u64, u64, u128, u64, u64, u64) {
        (0x2::object::uid_to_address(&arg0.id), arg0.version, arg0.owned_by, arg0.queen_version, arg0.genes, arg0.birth_certificate.generation, arg0.eggs_basket.is_queen, arg0.eggs_basket.total_eggs, arg0.eggs_basket.last_egg_ts, arg0.eggs_basket.cooldown_stage, arg0.eggs_basket.cooldown_till_ts, arg0.nectar.evolution_stage, 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&arg0.nectar.hive_locked), arg0.nectar.weighted_hive_locked, arg0.nectar.lockup_weeks, arg0.nectar.unlock_timestamp, 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&arg0.nectar.honey_locked), arg0.nectar.weighted_honey_locked, arg0.hive_energy, arg0.honey_health, arg0.dragon_dust)
    }

    public fun get_owned_bee_eggs_info(arg0: &DragonTrainer, arg1: u64) : (bool, u64, bool, u64, u64, u64, u256, u64, u8, u64) {
        get_eggs_info_for_bee(0x2::linked_table::borrow<u64, MysticalBee>(&arg0.owned_bees, arg1))
    }

    public fun get_owned_bee_info(arg0: &DragonTrainer, arg1: u64) : (u64, 0x1::string::String, address, u64, u256, u64, u64, address, 0x1::option::Option<address>, 0x1::option::Option<address>, bool, u64, bool, u64, u8, u64, u8, u64, u128, u64, u64, u64, u128, u64, u64, u64, u64, u64, bool) {
        get_bee_info(0x2::linked_table::borrow<u64, MysticalBee>(&arg0.owned_bees, arg1))
    }

    public fun get_owned_bees(arg0: &DragonTrainer) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = *0x2::linked_table::front<u64, MysticalBee>(&arg0.owned_bees);
        while (0x1::option::is_some<u64>(&v1)) {
            0x1::vector::push_back<u64>(&mut v0, *0x1::option::borrow<u64>(&v1));
            let v2 = 0x2::linked_table::next<u64, MysticalBee>(&arg0.owned_bees, *0x1::option::borrow<u64>(&v1));
            v1 = *v2;
        };
        v0
    }

    public fun get_p2p_game_session_info(arg0: &HiddenWorld, arg1: 0x1::string::String) : (address, address, u64, u64, u64, u64, u64, u64, u8, u64, u64, u64, u64, u64, u64, u64, u64) {
        let v0 = 0x2::linked_table::borrow<0x1::string::String, P2pGameSession>(&arg0.p2p_quests, arg1);
        (v0.trainer_addr1, v0.trainer_addr2, v0.version1, v0.v1_dust_pct_sum, v0.v1_evolved, v0.version2, v0.v2_dust_pct_sum, v0.v2_evolved, v0.current_quest.next_turn, v0.current_quest.last_action_ts, 0x2::balance::value<0x2::sui::SUI>(&v0.current_quest.sui_bet_bal), v0.current_quest.start_game_health, v0.current_quest.start_game_energy, v0.current_quest.user_bee_health, v0.current_quest.user_bee_energy, v0.current_quest.user2_bee_health, v0.current_quest.user2_bee_energy)
    }

    public fun get_paginated_active_trainers_list(arg0: &HiddenWorld, arg1: 0x1::option::Option<u64>, arg2: u64) : (vector<u64>, vector<address>, u64) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<address>();
        let v2 = if (0x1::option::is_some<u64>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<u64, address>(&arg0.active_trainers_list)
        };
        let v3 = 0;
        while (v3 < arg2 && 0x1::option::is_some<u64>(&v2)) {
            let v4 = 0x1::option::borrow<u64>(&v2);
            0x1::vector::push_back<u64>(&mut v0, *v4);
            0x1::vector::push_back<address>(&mut v1, *0x2::linked_table::borrow<u64, address>(&arg0.active_trainers_list, *v4));
            v2 = *0x2::linked_table::next<u64, address>(&arg0.active_trainers_list, *v4);
            v3 = v3 + 1;
        };
        (v0, v1, 0x2::linked_table::length<u64, address>(&arg0.active_trainers_list))
    }

    public fun get_prices_for_dragonbee_eggs(arg0: &0x2::clock::Clock, arg1: &mut BeesManager, arg2: address, arg3: u64) : (u64, vector<u64>, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x2::table::borrow<u64, DragonEggsBasket>(&arg1.dragon_eggs_basket, 420);
        let v2 = 0;
        let v3 = 0x1::vector::empty<u64>();
        if (v0 < v1.start_time) {
            v2 = v1.start_time - v0;
        };
        if (v1.eggs_laid >= v1.eggs_count) {
            return (0, 0x1::vector::empty<u64>(), 0)
        };
        let v4 = if (0x2::linked_table::contains<address, u64>(&v1.address_list, arg2)) {
            v1.per_user_limit - *0x2::linked_table::borrow<address, u64>(&v1.address_list, arg2)
        } else {
            v1.per_user_limit
        };
        let v5 = 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::math::min_u64(v1.eggs_count - v1.eggs_laid, 0x1::vector::length<u64>(&v1.bees_indexes));
        if (v4 > v5) {
            v4 = v5;
        };
        let v6 = v1.eggs_laid;
        let v7 = 0;
        let v8 = 0;
        if (0x2::linked_table::contains<address, u64>(&v1.whitelist_trainers_pricing, arg2)) {
            v7 = *0x2::linked_table::borrow<address, u64>(&v1.whitelist_trainers_availability, arg2);
            v8 = *0x2::linked_table::borrow<address, u64>(&v1.whitelist_trainers_pricing, arg2);
        };
        let v9 = 0;
        while (v9 < arg3) {
            let v10 = if (v7 > 0) {
                v7 = v7 - 1;
                v8
            } else {
                0xbe7aee0c1e79fee9b7478821a5c3eab28ade3c513b0c7a027990e0adabeb5ca8::beescience::compute_gene_price(v1.base_price, v1.curve_a, v6)
            };
            v6 = v6 + 1;
            0x1::vector::push_back<u64>(&mut v3, v10);
            v9 = v9 + 1;
        };
        (v2, v3, v4)
    }

    public fun get_processed_listings_list(arg0: &MarketPlace, arg1: 0x1::option::Option<u64>, arg2: u64) : (vector<u64>, u64) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = if (0x1::option::is_some<u64>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<u64, ExecutedListing>(&arg0.processed_listings)
        };
        let v2 = v1;
        let v3 = 0;
        while (0x1::option::is_some<u64>(&v2) && v3 < arg2) {
            let v4 = 0x1::option::borrow<u64>(&v2);
            0x1::vector::push_back<u64>(&mut v0, *v4);
            v2 = *0x2::linked_table::next<u64, ExecutedListing>(&arg0.processed_listings, *v4);
            v3 = v3 + 1;
        };
        (v0, 0x2::linked_table::length<u64, ExecutedListing>(&arg0.processed_listings))
    }

    public fun get_quest_request_info(arg0: &HiddenWorld, arg1: address) : (u64, u64, u64, bool, 0x1::option::Option<address>, u64) {
        if (!0x2::linked_table::contains<address, QuestRequest>(&arg0.active_trainers, arg1)) {
            return (0, 0, 0, false, 0x1::option::none<address>(), 0)
        };
        let v0 = 0x2::linked_table::borrow<address, QuestRequest>(&arg0.active_trainers, arg1);
        (v0.timestamp, v0.version, 0x2::balance::value<0x2::sui::SUI>(&v0.sui_bet), v0.player_only, v0.with_trainer, v0.active_index)
    }

    public fun get_royalty_info(arg0: &BeesManager) : (u64, u64, u64) {
        let v0 = &arg0.configuration.royalty;
        (v0.numerator, v0.gov_yield_pct, v0.queen_pct)
    }

    public fun get_trainer_addr(arg0: &DragonTrainer) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun get_trainer_for_username(arg0: &DegenHiveMapStore, arg1: 0x1::string::String) : (bool, address) {
        let v0 = to_lowercase(0x1::string::to_ascii(arg1));
        let v1 = 0x2::linked_table::contains<0x1::ascii::String, address>(&arg0.username_to_trainer_mapping, v0);
        let v2 = if (v1) {
            *0x2::linked_table::borrow<0x1::ascii::String, address>(&arg0.username_to_trainer_mapping, v0)
        } else {
            @0x0
        };
        (v1, v2)
    }

    public fun get_trainer_info(arg0: &DragonTrainer) : (0x1::ascii::String, u64, address, u64, u64, vector<u64>, vector<u64>, vector<u64>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = *0x2::linked_table::front<u64, MysticalBee>(&arg0.owned_bees);
        while (0x1::option::is_some<u64>(&v4)) {
            0x1::vector::push_back<u64>(&mut v0, *0x1::option::borrow<u64>(&v4));
            let v5 = 0x2::linked_table::next<u64, MysticalBee>(&arg0.owned_bees, *0x1::option::borrow<u64>(&v4));
            v4 = *v5;
        };
        v4 = *0x2::linked_table::front<u64, address>(&arg0.locked_bees);
        while (0x1::option::is_some<u64>(&v4)) {
            0x1::vector::push_back<u64>(&mut v1, *0x1::option::borrow<u64>(&v4));
            let v6 = 0x2::linked_table::next<u64, address>(&arg0.locked_bees, *0x1::option::borrow<u64>(&v4));
            v4 = *v6;
        };
        v4 = *0x2::linked_table::front<u64, ListingRecord>(&arg0.listing_records);
        while (0x1::option::is_some<u64>(&v4)) {
            0x1::vector::push_back<u64>(&mut v2, *0x1::option::borrow<u64>(&v4));
            let v7 = 0x2::linked_table::next<u64, ListingRecord>(&arg0.listing_records, *0x1::option::borrow<u64>(&v4));
            v4 = *v7;
        };
        v4 = *0x2::linked_table::front<u64, BidRecord>(&arg0.bid_records);
        while (0x1::option::is_some<u64>(&v4)) {
            0x1::vector::push_back<u64>(&mut v3, *0x1::option::borrow<u64>(&v4));
            let v8 = 0x2::linked_table::next<u64, BidRecord>(&arg0.bid_records, *0x1::option::borrow<u64>(&v4));
            v4 = *v8;
        };
        (arg0.username, arg0.joined_at, arg0.owner, 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&arg0.available_honey), 0x2::balance::value<0x2::sui::SUI>(&arg0.available_sui), v0, v1, v2, v3, 0x2::linked_table::length<0x1::ascii::String, address>(&arg0.trainer_sessions))
    }

    public fun get_trainer_info_with_power(arg0: &YieldFarm, arg1: &DragonTrainer) : (0x1::ascii::String, u64, u64, address, u64, u64, vector<u64>, vector<u64>, vector<u64>, vector<u64>, u64) {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9) = get_trainer_info(arg1);
        (v0, 0, v1, v2, v3, v4, v5, v6, v7, v8, v9)
    }

    public fun get_trainer_inscription(arg0: &DragonTrainer) : (0x1::string::String, vector<0x1::string::String>) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = *0x2::linked_table::front<u64, 0x1::string::String>(&arg0.inscription.base64);
        while (0x1::option::is_some<u64>(&v1)) {
            0x1::vector::push_back<0x1::string::String>(&mut v0, *0x2::linked_table::borrow<u64, 0x1::string::String>(&arg0.inscription.base64, *0x1::option::borrow<u64>(&v1)));
            let v2 = 0x2::linked_table::next<u64, 0x1::string::String>(&arg0.inscription.base64, *0x1::option::borrow<u64>(&v1));
            v1 = *v2;
        };
        (arg0.inscription.format, v0)
    }

    public fun get_trainer_joined_at(arg0: &DragonTrainer) : u64 {
        arg0.joined_at
    }

    public fun get_trainer_meta_info(arg0: &DragonTrainer) : (address, 0x1::string::String, address) {
        (0x2::object::uid_to_address(&arg0.id), 0x1::string::from_ascii(arg0.username), arg0.owner)
    }

    public fun get_trainer_owner(arg0: &DragonTrainer) : address {
        arg0.owner
    }

    public fun get_trainer_session_info(arg0: &HiddenWorld, arg1: address) : (vector<u64>, u64, u64, 0x1::string::String, u8) {
        if (!0x2::linked_table::contains<address, TrainerSession>(&arg0.trainer_sessions, arg1)) {
            return (0x1::vector::empty<u64>(), 0, 0, 0x1::string::utf8(b""), 0)
        };
        let v0 = 0x2::linked_table::borrow<address, TrainerSession>(&arg0.trainer_sessions, arg1);
        (v0.user_bees, v0.quests_count, 0x2::balance::value<0x2::sui::SUI>(&v0.sui_balance), v0.current_quest, v0.state)
    }

    public fun get_trainer_sessions(arg0: &DragonTrainer) : vector<0x1::ascii::String> {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = *0x2::linked_table::front<0x1::ascii::String, address>(&arg0.trainer_sessions);
        while (0x1::option::is_some<0x1::ascii::String>(&v1)) {
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, *0x1::option::borrow<0x1::ascii::String>(&v1));
            let v2 = 0x2::linked_table::next<0x1::ascii::String, address>(&arg0.trainer_sessions, *0x1::option::borrow<0x1::ascii::String>(&v1));
            v1 = *v2;
        };
        v0
    }

    public fun get_trainer_username(arg0: &DragonTrainer) : 0x1::string::String {
        0x1::string::from_ascii(arg0.username)
    }

    public fun get_treasury_info(arg0: &BeesManager) : (u64, u64) {
        (0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&arg0.hive_treasury), 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&arg0.honey_treasury))
    }

    public fun get_yield_farm_info(arg0: &YieldFarm) : (u128, u128, u64, u64, u64, u64, u256, u256) {
        (arg0.governance_info.total_weighted_hive, arg0.governance_info.total_weighted_honey, 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&arg0.incoming_hive_for_bees), 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&arg0.hive_for_bees), 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&arg0.incoming_honey_for_bees), 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&arg0.honey_for_bees), arg0.hive_global_index, arg0.honey_global_index)
    }

    public entry fun handle_expired_listings(arg0: &0x2::clock::Clock, arg1: &mut MarketPlace, arg2: &mut DragonTrainer, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 1079);
        let v0 = *0x2::linked_table::front<u64, ListingRecord>(&arg2.listing_records);
        while (0x1::option::is_some<u64>(&v0)) {
            let v1 = *0x1::option::borrow<u64>(&v0);
            v0 = *0x2::linked_table::next<u64, ListingRecord>(&arg2.listing_records, v1);
            if (0x2::linked_table::borrow<u64, ListingRecord>(&arg2.listing_records, v1).expiration_sec > 0x2::clock::timestamp_ms(arg0)) {
                continue
            };
            let v2 = 0x2::linked_table::remove<u64, Listing>(&mut arg1.active_listings, v1);
            let v3 = ListingExpired{
                listed_by_trainer : v2.listed_by_trainer,
                version           : v1,
            };
            0x2::event::emit<ListingExpired>(v3);
            let (v4, _, _, _) = destroy_listing(v2);
            let (_, _, _) = destroy_listing_record(0x2::linked_table::remove<u64, ListingRecord>(&mut arg2.listing_records, v1));
            deposit_bee_in_trainer(arg2, v4);
            mark_marketplace_bids_as_invalid(arg1, v1);
        };
    }

    public entry fun handle_expired_marketplace_bids(arg0: &0x2::clock::Clock, arg1: &mut MarketPlace, arg2: &mut DragonTrainer, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 1079);
        let v0 = 0x2::object::uid_to_address(&arg2.id);
        let v1 = *0x2::linked_table::front<u64, BidRecord>(&arg2.bid_records);
        while (0x1::option::is_some<u64>(&v1)) {
            let v2 = *0x1::option::borrow<u64>(&v1);
            v1 = *0x2::linked_table::next<u64, BidRecord>(&arg2.bid_records, v2);
            if (0x2::linked_table::borrow<u64, BidRecord>(&arg2.bid_records, v2).expiration_sec < 0x2::clock::timestamp_ms(arg0)) {
                let v3 = 0x2::linked_table::borrow_mut<u64, vector<Bid>>(&mut arg1.available_bids, v2);
                let v4 = destroy_bid_among_bids(v3, v0, false, v2);
                let v5 = BidExpired{
                    version        : v2,
                    bidder_trainer : v0,
                    refund_sui     : 0x2::balance::value<0x2::sui::SUI>(&v4),
                };
                0x2::event::emit<BidExpired>(v5);
                0x2::balance::join<0x2::sui::SUI>(&mut arg2.available_sui, v4);
                let (_, _, _) = destroy_bid_record(0x2::linked_table::remove<u64, BidRecord>(&mut arg2.bid_records, v2));
            };
        };
    }

    public fun handle_processed_listing(arg0: &mut BeesManager, arg1: &mut MarketPlace, arg2: &mut DragonTrainer, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 1079);
        assert!(0x2::linked_table::contains<u64, ExecutedListing>(&arg1.processed_listings, arg3), 1059);
        let ExecutedListing {
            listed_by_trainer : v0,
            mystical_bee      : v1,
            version           : _,
            balance           : v3,
            bidder_trainer    : v4,
            executed_price    : v5,
        } = 0x2::linked_table::remove<u64, ExecutedListing>(&mut arg1.processed_listings, arg3);
        let v6 = v3;
        let v7 = v1;
        let v8 = ExecutedListingDestroyed{
            version           : arg3,
            executed_price    : v5,
            listed_by_trainer : v0,
        };
        0x2::event::emit<ExecutedListingDestroyed>(v8);
        if (0x1::option::is_some<0x2::balance::Balance<0x2::sui::SUI>>(&v6)) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg2.available_sui, 0x1::option::extract<0x2::balance::Balance<0x2::sui::SUI>>(&mut v6));
            let (_, _, _) = destroy_listing_record(0x2::linked_table::remove<u64, ListingRecord>(&mut arg2.listing_records, arg3));
        };
        0x1::option::destroy_none<0x2::balance::Balance<0x2::sui::SUI>>(v6);
        if (0x1::option::is_some<MysticalBee>(&v7)) {
            assert!(v4 == 0x2::object::uid_to_address(&arg2.id), 1167);
            update_bee_ownership(arg0, arg3, 0x2::object::uid_to_address(&arg2.id));
            deposit_bee_in_trainer(arg2, 0x1::option::extract<MysticalBee>(&mut v7));
            let (_, _, _) = destroy_bid_record(0x2::linked_table::remove<u64, BidRecord>(&mut arg2.bid_records, arg3));
        };
        0x1::option::destroy_none<MysticalBee>(v7);
    }

    fun handle_sui_bet(arg0: &HiddenWorld, arg1: &mut 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::YieldFlow, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: 0x2::balance::Balance<0x2::sui::SUI>) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<0x2::sui::SUI>) {
        if (0x2::balance::value<0x2::sui::SUI>(&arg3) == 0) {
            let v1 = 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::math::min_u64(0x2::balance::value<0x2::sui::SUI>(&arg2), 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::get_treasury_balance(arg1));
            let v2 = 0x2::balance::zero<0x2::sui::SUI>();
            0x2::balance::join<0x2::sui::SUI>(&mut v2, 0x2::balance::split<0x2::sui::SUI>(&mut arg2, v1));
            0x2::balance::join<0x2::sui::SUI>(&mut v2, 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::release_sui_from_treasury_for_bet(&arg0.cap, arg1, v1));
            (arg2, arg3, v2)
        } else {
            let v3 = 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::math::min_u64(0x2::balance::value<0x2::sui::SUI>(&arg2), 0x2::balance::value<0x2::sui::SUI>(&arg3));
            let v4 = 0x2::balance::zero<0x2::sui::SUI>();
            0x2::balance::join<0x2::sui::SUI>(&mut v4, 0x2::balance::split<0x2::sui::SUI>(&mut arg2, v3));
            0x2::balance::join<0x2::sui::SUI>(&mut v4, 0x2::balance::split<0x2::sui::SUI>(&mut arg3, v3));
            (arg2, arg3, v4)
        }
    }

    public entry fun harvest_royalty_yield_for_builders(arg0: &0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::MasterAccessKey, arg1: &mut BeesManager, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.buidlers_royalty);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg3), arg2);
        let v1 = BuidlersYieldHarvested{
            sui_yield : 0x2::balance::value<0x2::sui::SUI>(&v0),
            receiver  : arg2,
        };
        0x2::event::emit<BuidlersYieldHarvested>(v1);
    }

    public fun harvest_yield_from_bees(arg0: &mut BeesManager, arg1: &mut YieldFarm, arg2: &mut DragonTrainer, arg3: &mut 0x2::token::TokenPolicy<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg4: &0x2::token::TokenPolicyCap<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE> {
        let v0 = if (arg0.module_version == 0) {
            if (arg1.module_version == 0) {
                arg2.module_version == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1079);
        assert!(arg1.trading_enabled, 1210);
        let v1 = 0x2::balance::zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>();
        let v2 = 0x2::balance::zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>();
        let v3 = *0x2::linked_table::front<u64, MysticalBee>(&arg2.owned_bees);
        while (0x1::option::is_some<u64>(&v3)) {
            let v4 = 0x1::option::borrow<u64>(&v3);
            let v5 = 0x2::linked_table::borrow_mut<u64, MysticalBee>(&mut arg2.owned_bees, *v4);
            let (v6, v7) = claim_gov_yield(arg1, v5);
            0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut v1, v6);
            0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut v2, v7);
            v3 = *0x2::linked_table::next<u64, MysticalBee>(&arg2.owned_bees, *v4);
        };
        let v8 = DegenHiveYieldHarvested{
            harvester_trainer : 0x2::object::uid_to_address(&arg2.id),
            username          : arg2.username,
            hive_harvested    : 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&v1),
            honey_harvested   : 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&v2),
        };
        0x2::event::emit<DegenHiveYieldHarvested>(v8);
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::transfer_honey_balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(arg3, arg4, v2, 0x2::tx_context::sender(arg5), arg5);
        v1
    }

    public entry fun harvest_yield_from_bees_and_return(arg0: &mut BeesManager, arg1: &mut YieldFarm, arg2: &mut DragonTrainer, arg3: &mut 0x2::token::TokenPolicy<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg4: &0x2::token::TokenPolicyCap<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = harvest_yield_from_bees(arg0, arg1, arg2, arg3, arg4, arg5);
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::coin_helper::destroy_or_transfer_balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(v0, 0x2::tx_context::sender(arg5), arg5);
    }

    public fun hatch_dragon_egg(arg0: &mut BeesManager, arg1: &mut DragonTrainer, arg2: u64) {
        let v0 = 0x2::linked_table::borrow_mut<u64, MysticalBee>(&mut arg1.owned_bees, arg2);
        assert!(!v0.is_hatched, 1190);
        assert!(v0.hive_energy >= arg0.configuration.min_energy_to_hatch, 1213);
        assert!(v0.honey_health >= arg0.configuration.min_health_to_hatch, 1212);
        let v1 = 0x2::table::borrow_mut<u64, DragonEggsBasket>(&mut arg0.dragon_eggs_basket, 420);
        assert!(0x2::linked_table::length<u64, 0x1::string::String>(0x2::linked_table::borrow<u64, 0x2::linked_table::LinkedTable<u64, 0x1::string::String>>(&v1.dragonbee_imgs_list, arg2)) > 0, 1191);
        let v2 = 0x2::linked_table::remove<u64, 0x2::linked_table::LinkedTable<u64, 0x1::string::String>>(&mut v1.dragonbee_imgs_list, arg2);
        while (0x2::linked_table::length<u64, 0x1::string::String>(&v0.appearance) > 0) {
            let (_, _) = 0x2::linked_table::pop_back<u64, 0x1::string::String>(&mut v0.appearance);
        };
        let v5 = *0x2::linked_table::front<u64, 0x1::string::String>(&v2);
        while (0x1::option::is_some<u64>(&v5)) {
            let v6 = *0x1::option::borrow<u64>(&v5);
            v5 = *0x2::linked_table::next<u64, 0x1::string::String>(&v2, v6);
            0x2::linked_table::push_back<u64, 0x1::string::String>(&mut v0.appearance, v6, 0x2::linked_table::remove<u64, 0x1::string::String>(&mut v2, v6));
        };
        v0.is_hatched = true;
        0x2::linked_table::destroy_empty<u64, 0x1::string::String>(v2);
        let v7 = DragonBeeHatched{version: v0.version};
        0x2::event::emit<DragonBeeHatched>(v7);
    }

    public fun id_for_dof_of_trainer(arg0: &DragonTrainer, arg1: 0x1::ascii::String) : 0x1::option::Option<0x2::object::ID> {
        0x2::dynamic_object_field::id<0x1::ascii::String>(&arg0.id, arg1)
    }

    public entry fun increment_bees_manager(arg0: &mut BeesManager) {
        assert!(arg0.module_version < 0, 1080);
        arg0.module_version = 0;
    }

    public entry fun increment_degenhive_map_store(arg0: &mut DegenHiveMapStore) {
        assert!(arg0.module_version < 0, 1080);
        arg0.module_version = 0;
    }

    public entry fun increment_global_yield_indexes(arg0: &mut YieldFarm) {
        let v0 = 0;
        let v1 = 0;
        if (arg0.governance_info.total_weighted_hive > 0) {
            v0 = 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::math::mul_div_u256((0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&arg0.incoming_hive_for_bees) as u256), (0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::constants::precision_constant() as u256), (arg0.governance_info.total_weighted_hive as u256));
        };
        if (arg0.governance_info.total_weighted_honey > 0) {
            v1 = 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::math::mul_div_u256((0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&arg0.incoming_honey_for_bees) as u256), (0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::constants::precision_constant() as u256), (arg0.governance_info.total_weighted_honey as u256));
        };
        arg0.hive_global_index = arg0.hive_global_index + v0;
        arg0.honey_global_index = arg0.honey_global_index + v1;
        0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut arg0.hive_for_bees, 0x2::balance::withdraw_all<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut arg0.incoming_hive_for_bees));
        0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut arg0.honey_for_bees, 0x2::balance::withdraw_all<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut arg0.incoming_honey_for_bees));
    }

    public entry fun increment_hidden_world(arg0: &mut HiddenWorld, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.module_version < 0, 1080);
        arg0.module_version = 0;
    }

    public entry fun increment_marketplace(arg0: &mut MarketPlace) {
        assert!(arg0.module_version < 0, 1080);
        arg0.module_version = 0;
    }

    public entry fun increment_trainer(arg0: &mut DragonTrainer, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 1057);
        assert!(arg0.module_version < 0, 1080);
        arg0.module_version = 0;
    }

    public entry fun increment_yield_farm(arg0: &mut YieldFarm) {
        assert!(arg0.module_version < 0, 1080);
        arg0.module_version = 0;
    }

    public fun infuse_bee_and_school_with_honey(arg0: &0x2::clock::Clock, arg1: &mut YieldFarm, arg2: &mut DragonSchool, arg3: &mut MysticalBee, arg4: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0, 1079);
        let (v0, v1) = internal_infuse_bee_with_honey(arg0, arg1, arg3, 0x2::balance::split<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut arg4, 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&arg4) / 2));
        0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut arg2.available_hive, v0);
        0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut arg4, v1);
        0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut arg2.available_honey, arg4);
    }

    public fun infuse_bee_and_trainer_with_honey(arg0: &0x2::clock::Clock, arg1: &mut YieldFarm, arg2: &mut DragonTrainer, arg3: &mut MysticalBee, arg4: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0, 1079);
        let (v0, v1) = internal_infuse_bee_with_honey(arg0, arg1, arg3, 0x2::balance::split<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut arg4, 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&arg4) / 2));
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::coin_helper::destroy_or_transfer_balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(v0, 0x2::tx_context::sender(arg5), arg5);
        0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut arg4, v1);
        deposit_honey_in_trainer(arg2, arg4);
    }

    public fun infuse_bee_with_energy(arg0: &0x2::clock::Clock, arg1: &mut YieldFarm, arg2: &mut 0x2::token::TokenPolicy<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg3: &0x2::token::TokenPolicyCap<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg4: &mut DragonTrainer, arg5: u64, arg6: 0x2::coin::Coin<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg4.module_version == 0, 1079);
        let v0 = 0x2::linked_table::borrow_mut<u64, MysticalBee>(&mut arg4.owned_bees, arg5);
        let (v1, v2) = internal_infuse_bee_with_energy(arg0, arg1, v0, 0x2::coin::into_balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(arg6), arg7, arg8);
        if (arg1.trading_enabled) {
            0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::coin_helper::destroy_or_transfer_balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(v1, 0x2::tx_context::sender(arg9), arg9);
            0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::transfer_honey_balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(arg2, arg3, v2, 0x2::tx_context::sender(arg9), arg9);
        } else {
            let v3 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, LockedDegenHiveAssets>(&mut arg4.id, 0x1::string::utf8(b"LOCKED_DEGEN_HIVE_ASSETS"));
            0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut v3.hive_locked, v1);
            0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut v3.honey_locked, v2);
        };
    }

    public fun infuse_bee_with_health(arg0: &0x2::clock::Clock, arg1: &mut YieldFarm, arg2: &mut 0x2::token::TokenPolicy<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg3: &0x2::token::TokenPolicyCap<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg4: &mut DragonTrainer, arg5: u64, arg6: 0x2::token::Token<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg4.module_version == 0, 1079);
        let v0 = 0x2::linked_table::borrow_mut<u64, MysticalBee>(&mut arg4.owned_bees, arg5);
        let (v1, v2) = internal_infuse_bee_with_honey(arg0, arg1, v0, 0x2::coin::into_balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::unwrap_honey_tokens_to_coins<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut arg6, arg3, arg2, arg7, arg8)));
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::coin_helper::destroy_or_transfer_balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(v1, 0x2::tx_context::sender(arg8), arg8);
        if (arg1.trading_enabled) {
            0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::transfer_honey_balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(arg2, arg3, v2, 0x2::tx_context::sender(arg8), arg8);
        } else {
            0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::string::String, LockedDegenHiveAssets>(&mut arg4.id, 0x1::string::utf8(b"LOCKED_DEGEN_HIVE_ASSETS")).honey_locked, v2);
        };
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::transfer_honey<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut arg6, arg3, arg2, 0x2::token::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&arg6), 0x2::tx_context::sender(arg8), arg8);
        0x2::token::destroy_zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(arg6);
    }

    fun init(arg0: DRAGON_TRAINER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DegenHiveMapStore{
            id                           : 0x2::object::new(arg1),
            owner_to_trainer_mapping     : 0x2::linked_table::new<address, address>(arg1),
            username_to_trainer_mapping  : 0x2::linked_table::new<0x1::ascii::String, address>(arg1),
            username_to_school_mapping   : 0x2::linked_table::new<0x1::ascii::String, address>(arg1),
            bee_name_to_version_mapping  : 0x2::linked_table::new<0x1::string::String, u64>(arg1),
            suins_name_to_expiry_mapping : 0x2::linked_table::new<0x1::ascii::String, u64>(arg1),
            app_names_to_cap_mapping     : 0x2::linked_table::new<0x1::ascii::String, address>(arg1),
            module_version               : 0,
        };
        0x2::transfer::share_object<DegenHiveMapStore>(v0);
        let v1 = MarketPlace{
            id                 : 0x2::object::new(arg1),
            active_listings    : 0x2::linked_table::new<u64, Listing>(arg1),
            available_bids     : 0x2::linked_table::new<u64, vector<Bid>>(arg1),
            processed_listings : 0x2::linked_table::new<u64, ExecutedListing>(arg1),
            module_version     : 0,
        };
        0x2::transfer::share_object<MarketPlace>(v1);
        let v2 = TwapUpdateCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<TwapUpdateCap>(v2, 0x2::tx_context::sender(arg1));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"username"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"owner"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"creation time"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Website"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"version"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"DegenHive - DragonTrainer"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"DRAGON-TRAINER -::- Collect, breed and battle with mystical-bees to evolve them into dragons! "));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{username}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{owner}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{joined_at}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"https://www.degenhive.ai"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{module_version}"));
        let v7 = 0x2::package::claim<DRAGON_TRAINER>(arg0, arg1);
        let v8 = 0x2::display::new_with_fields<DragonTrainer>(&v7, v3, v5, arg1);
        0x2::display::update_version<DragonTrainer>(&mut v8);
        let v9 = 0x1::vector::empty<0x1::string::String>();
        let v10 = &mut v9;
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"version"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"owned_by"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"queen_version"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"genes"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"energy"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"health"));
        0x1::vector::push_back<0x1::string::String>(v10, 0x1::string::utf8(b"dragon_dust"));
        let v11 = 0x1::vector::empty<0x1::string::String>();
        let v12 = &mut v11;
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"{version}"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"{owned_by}"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"{queen_version}"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"{genes}"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"{energy}"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"{health}"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"{dragon_dust}"));
        let v13 = 0x2::display::new_with_fields<MysticalBee>(&v7, v9, v11, arg1);
        0x2::display::update_version<MysticalBee>(&mut v13);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<DragonTrainer>>(v8, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MysticalBee>>(v13, 0x2::tx_context::sender(arg1));
        let v14 = HiveTwapInfo{
            last_update_timestamp : 0,
            hive_sui_twap         : 0,
            sui_usdc_twap         : 0,
            hive_usdc_twap        : 0,
        };
        let v15 = HiveGraph{
            id             : 0x2::object::new(arg1),
            hive_twap      : v14,
            followers_list : 0x2::linked_table::new<address, 0x2::linked_table::LinkedTable<address, bool>>(arg1),
            following_list : 0x2::linked_table::new<address, 0x2::linked_table::LinkedTable<address, bool>>(arg1),
            module_version : 0,
        };
        0x2::transfer::share_object<HiveGraph>(v15);
        let v16 = GenesisBeesUploaderCapability{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<GenesisBeesUploaderCapability>(v16, 0x2::tx_context::sender(arg1));
    }

    fun internal_breed_with_queen_bee(arg0: &0x2::clock::Clock, arg1: &0x2::random::Random, arg2: &mut 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::YieldFlow, arg3: &mut 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::FeeCollector<0x2::sui::SUI>, arg4: &mut BeesManager, arg5: &mut MysticalBee, arg6: u64, arg7: 0x2::balance::Balance<0x2::sui::SUI>, arg8: address, arg9: address, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::constants::percent_precision();
        let v1 = 0x2::clock::timestamp_ms(arg0);
        assert!(arg5.is_hatched, 1193);
        let v2 = 0x2::linked_table::borrow<u64, BeeHive>(&arg4.bee_hives, arg6);
        let v3 = v2.queenBeeId;
        let (v4, v5, v6) = validate_if_can_beed(arg0, arg4, v3, arg6, v2.queen_type, arg5);
        assert!(v4, v6);
        assert!(v2.is_active, 1169);
        assert!(v2.max_eggs_limit > v2.eggs_incubated, 1170);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg7) >= v5, 1171);
        let v7 = 0x2::balance::split<0x2::sui::SUI>(&mut arg7, v5);
        let v8 = (0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::math::mul_div_u256((v5 as u256), (arg4.configuration.breeding_royalty.platform_fees_pct as u256), (v0 as u256)) as u64);
        0x2::balance::join<0x2::sui::SUI>(&mut arg4.buidlers_royalty, 0x2::balance::split<0x2::sui::SUI>(&mut v7, v8));
        let v9 = (0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::math::mul_div_u128((v5 as u128), (arg4.configuration.breeding_royalty.gov_yield_pct as u128), (v0 as u128)) as u64);
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::collect_fee_for_coin<0x2::sui::SUI>(arg3, 0x2::balance::split<0x2::sui::SUI>(&mut v7, v9));
        let v10 = (0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::math::mul_div_u256((v5 as u256), (arg4.configuration.breeding_royalty.treasury_pct as u256), (v0 as u256)) as u64);
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::add_to_treasury(arg2, 0x2::balance::split<0x2::sui::SUI>(&mut v7, v10));
        let v11 = 0x2::random::new_generator(arg1, arg10);
        let v12 = 0xbe7aee0c1e79fee9b7478821a5c3eab28ade3c513b0c7a027990e0adabeb5ca8::beescience::breed_bees(v2.queen_gene, arg5.genes, (0x2::random::generate_u128_in_range(&mut v11, 340282, 340384634633755) as u256) << 128 | (0x2::random::generate_u128_in_range(&mut v11, 340282, 340282366920938463463) as u256), (0x2::random::generate_u128_in_range(&mut v11, 340282, 340384634633755) as u256) << 128 | (0x2::random::generate_u128_in_range(&mut v11, 340282, 340282366920938463463) as u256));
        let v13 = 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::math::min_u64(v2.queenBirthInfo.generation, arg5.birth_certificate.generation) + 1;
        let v14 = 0x2::linked_table::new<u64, 0x1::string::String>(arg10);
        let v15 = lay_dragon_egg(v13, 0, v1, arg8, arg6, 0x1::option::some<address>(v3), 0x1::option::some<address>(0x2::object::uid_to_address(&arg5.id)), v12, v14, arg9, arg4, v5, arg10);
        let v16 = v15.version;
        let v17 = 0x2::linked_table::borrow_mut<u64, BeeHive>(&mut arg4.bee_hives, arg6);
        0x2::balance::join<0x2::sui::SUI>(&mut v17.sui_custody, v7);
        v17.eggs_incubated = v17.eggs_incubated + 1;
        let v18 = BeeEgg{
            timestamp         : v1,
            egg_index         : v17.eggs_incubated,
            stingerBeeId      : 0x2::object::uid_to_address(&arg5.id),
            stingerBeeVersion : arg5.version,
            stinger_gene      : arg5.genes,
            dragon_bee_egg    : v15,
            is_processed      : false,
        };
        0x2::linked_table::push_back<u64, BeeEgg>(&mut v17.incubating_eggs, arg5.version, v18);
        let v19 = 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::math::min_u64(10, ((arg5.eggs_basket.cooldown_stage + 1) as u64));
        arg5.eggs_basket.cooldown_stage = (v19 as u8);
        arg5.eggs_basket.cooldown_till_ts = v1 + *0x2::linked_table::borrow<u64, u64>(&arg4.configuration.cooldown_periods, v19);
        let v20 = NewEggIncubated{
            child_version          : v16,
            incubated_at           : v1,
            child_generation       : v13,
            queenId                : v3,
            queen_version          : arg6,
            stingerBeeId           : 0x2::object::uid_to_address(&arg5.id),
            stinger_version        : arg5.version,
            queen_gene             : v17.queen_gene,
            stinger_gene           : arg5.genes,
            child_gene             : v12,
            total_breeding_cost    : v5,
            platform_fees          : v8,
            gov_yield_amt          : v9,
            treasury_fees          : v10,
            stinger_cooldown_stage : arg5.eggs_basket.cooldown_stage,
            stinger_cooldown_till  : arg5.eggs_basket.cooldown_till_ts,
        };
        0x2::event::emit<NewEggIncubated>(v20);
        let v21 = BeeEggRecord{
            queenBeeId       : v3,
            queen_version    : arg6,
            child_gene       : v12,
            child_generation : v13,
            child_version    : v16,
        };
        arg5.eggs_basket.hatch_egg_record = 0x1::option::some<BeeEggRecord>(v21);
        arg5.eggs_basket.last_egg_ts = v1;
        arg7
    }

    fun internal_handle_battle_turn(arg0: &mut MysticalBee, arg1: &mut MysticalBee, arg2: u64, arg3: u64, arg4: u8, arg5: u64) : (u64, u64) {
        attack_bee(arg0, arg1, arg2, arg3, (arg4 as u8), arg5)
    }

    fun internal_handle_battle_turn_impact(arg0: bool, arg1: &mut HiddenWorldQuest, arg2: u64, arg3: u64) : (bool, bool, bool) {
        let v0 = false;
        let v1 = false;
        let v2 = false;
        if (arg0) {
            if (arg2 < arg1.user_bee_energy) {
                arg1.user_bee_energy = arg1.user_bee_energy - arg2;
            } else {
                arg1.user_bee_energy = 0;
            };
            if (arg1.user2_bee_health > arg3) {
                arg1.user2_bee_health = arg1.user2_bee_health - arg3;
            } else {
                v0 = true;
                v1 = true;
            };
        } else {
            if (arg2 < arg1.user2_bee_energy) {
                arg1.user2_bee_energy = arg1.user2_bee_energy - arg2;
            } else {
                arg1.user2_bee_energy = 0;
            };
            if (arg1.user_bee_health > arg3) {
                arg1.user_bee_health = arg1.user_bee_health - arg3;
            } else {
                v0 = true;
                v2 = false;
            };
        };
        (v0, v1, v2)
    }

    fun internal_infuse_bee_with_energy(arg0: &0x2::clock::Clock, arg1: &mut YieldFarm, arg2: &mut MysticalBee, arg3: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>, arg4: u64, arg5: u64) : (0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>, 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>) {
        assert!(arg1.module_version == 0, 1079);
        if (0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&arg2.nectar.hive_locked) == 0) {
            assert!(arg5 <= 208, 1189);
        };
        let (v0, v1) = update_global_mystic_power(arg0, arg1, arg2, 0x2::balance::zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(), 0x2::balance::split<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut arg3, arg4), arg5, false, false);
        0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut arg3, v1);
        (arg3, v0)
    }

    fun internal_infuse_bee_with_honey(arg0: &0x2::clock::Clock, arg1: &mut YieldFarm, arg2: &mut MysticalBee, arg3: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>) : (0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>, 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>) {
        assert!(arg1.module_version == 0, 1079);
        let (v0, v1) = update_global_mystic_power(arg0, arg1, arg2, arg3, 0x2::balance::zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(), 0, false, false);
        (v1, v0)
    }

    fun internal_kraft_dragon_trainer(arg0: &0x2::clock::Clock, arg1: 0x1::string::String, arg2: address, arg3: &mut DegenHiveMapStore, arg4: &mut BeesManager, arg5: &mut HiveGraph, arg6: &mut 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::FeeCollector<0x2::sui::SUI>, arg7: 0x2::balance::Balance<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) : DragonTrainer {
        let v0 = 0x2::object::new(arg8);
        let v1 = 0x2::object::uid_to_address(&v0);
        assert!(is_valid_trainer_name(arg1), 1084);
        let v2 = 0x1::string::to_ascii(arg1);
        let v3 = to_lowercase(v2);
        assert!(!0x2::linked_table::contains<0x1::ascii::String, address>(&arg3.username_to_trainer_mapping, v3), 1083);
        0x2::linked_table::push_back<0x1::ascii::String, address>(&mut arg3.username_to_trainer_mapping, v3, v1);
        assert!(!0x2::linked_table::contains<address, address>(&arg3.owner_to_trainer_mapping, arg2), 1056);
        0x2::linked_table::push_back<address, address>(&mut arg3.owner_to_trainer_mapping, arg2, v1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg4.buidlers_royalty, 0x2::balance::split<0x2::sui::SUI>(&mut arg7, 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::math::mul_div(0x2::balance::value<0x2::sui::SUI>(&arg7), 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::constants::admin_fee_trainer_kraft(), 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::constants::percent_precision())));
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::collect_fee_for_coin<0x2::sui::SUI>(arg6, arg7);
        let v4 = DragonTrainerKrafted{
            name             : arg1,
            new_trainer_addr : v1,
            krafter          : arg2,
            fee              : arg4.configuration.trainer_onboarding_fee,
        };
        0x2::event::emit<DragonTrainerKrafted>(v4);
        0x2::linked_table::push_back<address, 0x2::linked_table::LinkedTable<address, bool>>(&mut arg5.followers_list, v1, 0x2::linked_table::new<address, bool>(arg8));
        0x2::linked_table::push_back<address, 0x2::linked_table::LinkedTable<address, bool>>(&mut arg5.following_list, v1, 0x2::linked_table::new<address, bool>(arg8));
        let v5 = Inscription{
            format : 0x1::string::utf8(b"png"),
            base64 : 0x2::linked_table::new<u64, 0x1::string::String>(arg8),
        };
        let v6 = DragonTrainer{
            id               : v0,
            owner            : arg2,
            joined_at        : 0x2::clock::timestamp_ms(arg0),
            username         : v2,
            inscription      : v5,
            available_honey  : 0x2::balance::zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(),
            available_sui    : 0x2::balance::zero<0x2::sui::SUI>(),
            owned_bees       : 0x2::linked_table::new<u64, MysticalBee>(arg8),
            locked_bees      : 0x2::linked_table::new<u64, address>(arg8),
            listing_records  : 0x2::linked_table::new<u64, ListingRecord>(arg8),
            bid_records      : 0x2::linked_table::new<u64, BidRecord>(arg8),
            trainer_sessions : 0x2::linked_table::new<0x1::ascii::String, address>(arg8),
            module_version   : 0,
        };
        let v7 = LockedDegenHiveAssets{
            id           : 0x2::object::new(arg8),
            hive_locked  : 0x2::balance::zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(),
            honey_locked : 0x2::balance::zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(),
        };
        0x2::dynamic_object_field::add<0x1::string::String, LockedDegenHiveAssets>(&mut v6.id, 0x1::string::utf8(b"LOCKED_DEGEN_HIVE_ASSETS"), v7);
        v6
    }

    fun internal_make_bee_queen(arg0: &mut BeesManager, arg1: &mut MysticalBee, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::uid_to_address(&arg1.id);
        arg1.eggs_basket.is_queen = true;
        let v1 = (0xbe7aee0c1e79fee9b7478821a5c3eab28ade3c513b0c7a027990e0adabeb5ca8::beescience::get_family_type(arg1.genes) as u64);
        let v2 = QueenFamilyInfo{
            queenId    : arg1.birth_certificate.queenId,
            stingerId  : arg1.birth_certificate.stingerId,
            generation : arg1.birth_certificate.generation,
        };
        let v3 = BeeHive{
            queenBeeId        : v0,
            queen_type        : v1,
            queen_version     : arg1.version,
            queenBirthInfo    : v2,
            max_eggs_limit    : arg2,
            eggs_incubated    : 0,
            auction_epoch     : arg3,
            queen_gene        : arg1.genes,
            is_active         : false,
            base_price        : 0,
            curve_a           : 0,
            friends_list      : 0x2::linked_table::new<u64, u64>(arg4),
            incubating_eggs   : 0x2::linked_table::new<u64, BeeEgg>(arg4),
            eggs_hatched_list : 0x2::linked_table::new<u64, address>(arg4),
            sui_custody       : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v4 = BeeIsNowAQueen{
            queenBeeId     : v0,
            family_type    : v1,
            version        : arg1.version,
            queen_gene     : arg1.genes,
            max_eggs_limit : arg2,
            auction_epoch  : arg3,
        };
        0x2::event::emit<BeeIsNowAQueen>(v4);
        0x2::linked_table::push_back<u64, bool>(&mut arg0.bees_tracker.queen_bees_map, arg1.version, true);
        0x2::linked_table::push_back<u64, BeeHive>(&mut arg0.bee_hives, arg1.version, v3);
    }

    fun internal_replenish_master_key(arg0: &mut GameMasterKey, arg1: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg2: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>, arg3: u64, arg4: u64) : 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE> {
        arg0.total_energy = arg0.total_energy + 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&arg2) + arg3;
        arg0.total_health = arg0.total_health + 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&arg1) + arg4;
        let v0 = MasterKeyReplenished{
            addr             : 0x2::object::uid_to_address(&arg0.id),
            app_name         : arg0.app_name,
            honey_earned     : 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&arg1),
            energy_added     : arg3 + 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&arg2),
            health_added     : arg4 + 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&arg1),
            available_energy : arg0.total_energy,
            available_health : arg0.total_health,
        };
        0x2::event::emit<MasterKeyReplenished>(v0);
        0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut arg0.honey_incentives, arg1);
        arg2
    }

    fun internal_send_to_hidden_world(arg0: &0x2::clock::Clock, arg1: &mut BeesManager, arg2: &mut HiddenWorld, arg3: &mut YieldFarm, arg4: MysticalBee, arg5: address, arg6: &0x2::tx_context::TxContext) : (0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>, 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>) {
        assert!(arg1.module_version == 0 && arg3.module_version == 0, 1079);
        let v0 = 0x2::clock::timestamp_ms(arg0);
        assert!(arg4.is_hatched, 1192);
        let v1 = 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&arg4.nectar.hive_locked);
        if (arg4.nectar.unlock_timestamp < v0) {
            v1 = 0;
        };
        let v2 = &mut arg4;
        let (v3, v4) = update_global_mystic_power(arg0, arg3, v2, 0x2::balance::zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(), 0x2::balance::zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(), 0, true, true);
        let v5 = v4;
        let v6 = v3;
        0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut arg1.hive_treasury, 0x2::balance::split<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut v5, (0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::math::mul_div_u128((v1 as u128), (10 as u128), (0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::constants::percent_precision() as u128)) as u64)));
        0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut v5, 0x2::balance::withdraw_all<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut arg4.nectar.hive_locked));
        0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut v6, 0x2::balance::withdraw_all<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut arg4.nectar.honey_locked));
        arg4.nectar.weighted_honey_locked = 0;
        let v7 = BeeSentToHiddenWorld{
            sent_at              : v0,
            sender               : arg5,
            beeId                : 0x2::object::uid_to_address(&arg4.id),
            version              : arg4.version,
            genes                : arg4.genes,
            energy               : arg4.hive_energy,
            health               : arg4.honey_health,
            total_honey_claimed  : 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&v6),
            hive_unlocked        : v1,
            total_weighted_hive  : arg3.governance_info.total_weighted_hive,
            total_weighted_honey : arg3.governance_info.total_weighted_honey,
        };
        0x2::event::emit<BeeSentToHiddenWorld>(v7);
        if (0x2::linked_table::contains<u64, DragonDust>(&arg2.dragon_dust, arg4.version)) {
            let DragonDust {
                quests_played   : _,
                evolution_stage : _,
                evolved_genes   : _,
                genes_img_map   : v11,
                evolution_map   : _,
            } = 0x2::linked_table::remove<u64, DragonDust>(&mut arg2.dragon_dust, arg4.version);
            0x2::linked_table::drop<u64, vector<0x1::string::String>>(v11);
        };
        let v13 = arg4.version;
        if (arg2.list_count == 0) {
            0x2::linked_table::push_back<u64, vector<u64>>(&mut arg2.hidden_bees_list, 0, 0x1::vector::empty<u64>());
            arg2.list_count = 1;
        } else {
            let v14 = 0x2::linked_table::borrow_mut<u64, vector<u64>>(&mut arg2.hidden_bees_list, arg2.list_count - 1);
            if (0x1::vector::length<u64>(v14) >= 100) {
                let v15 = 0x1::vector::empty<u64>();
                0x1::vector::push_back<u64>(&mut v15, v13);
                0x2::linked_table::push_back<u64, vector<u64>>(&mut arg2.hidden_bees_list, arg2.list_count, v15);
                arg2.list_count = arg2.list_count + 1;
            } else {
                0x1::vector::push_back<u64>(v14, v13);
            };
        };
        let v16 = HiddenMysticalBee{
            mystical_bee        : 0x1::option::some<MysticalBee>(arg4),
            winnings            : 0x2::balance::zero<0x2::sui::SUI>(),
            winnings_sum        : 0,
            loosing_sum         : 0,
            dragon_dust_emitted : 0,
        };
        0x2::linked_table::push_back<u64, HiddenMysticalBee>(&mut arg2.hidden_bees, arg4.version, v16);
        if (!0x2::linked_table::contains<address, TrainerSession>(&arg2.trainer_sessions, arg5)) {
            0x2::linked_table::push_back<address, TrainerSession>(&mut arg2.trainer_sessions, arg5, create_trainer_session(arg5));
        };
        0x1::vector::push_back<u64>(&mut 0x2::linked_table::borrow_mut<address, TrainerSession>(&mut arg2.trainer_sessions, arg5).user_bees, v13);
        (v5, v6)
    }

    fun internal_unlock_hive_from_bee(arg0: &0x2::clock::Clock, arg1: &mut YieldFarm, arg2: &mut MysticalBee) : (0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>, 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>) {
        assert!(arg1.module_version == 0, 1079);
        let (v0, v1) = update_global_mystic_power(arg0, arg1, arg2, 0x2::balance::zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(), 0x2::balance::zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(), 0, true, false);
        (v1, v0)
    }

    public fun isReadyToBreed(arg0: &0x2::clock::Clock, arg1: &MysticalBee) : bool {
        let v0 = if (arg1.eggs_basket.is_queen) {
            true
        } else if (0x1::option::is_some<BeeEggRecord>(&arg1.eggs_basket.hatch_egg_record)) {
            true
        } else {
            arg1.eggs_basket.cooldown_till_ts > 0x2::clock::timestamp_ms(arg0)
        };
        if (v0) {
            return false
        };
        true
    }

    public fun is_bee_listing_executed(arg0: &MarketPlace, arg1: u64) : bool {
        0x2::linked_table::contains<u64, ExecutedListing>(&arg0.processed_listings, arg1)
    }

    public fun is_dragon_bee_egg_hatchable(arg0: &mut BeesManager, arg1: &mut DragonTrainer, arg2: u64) : bool {
        let v0 = 0x2::linked_table::borrow<u64, MysticalBee>(&arg1.owned_bees, arg2);
        if (v0.is_hatched) {
            return false
        };
        if (v0.hive_energy < arg0.configuration.min_energy_to_hatch || v0.honey_health < arg0.configuration.min_health_to_hatch) {
            let v1 = 0x1::string::utf8(b"is_hatched");
            0x1::debug::print<0x1::string::String>(&v1);
            return false
        };
        let v2 = 0x2::table::borrow<u64, DragonEggsBasket>(&arg0.dragon_eggs_basket, 420);
        if (!0x2::linked_table::contains<u64, 0x2::linked_table::LinkedTable<u64, 0x1::string::String>>(&v2.dragonbee_imgs_list, arg2)) {
            return false
        };
        if (0x2::linked_table::length<u64, 0x1::string::String>(0x2::linked_table::borrow<u64, 0x2::linked_table::LinkedTable<u64, 0x1::string::String>>(&v2.dragonbee_imgs_list, arg2)) == 0) {
            return false
        };
        true
    }

    public fun is_mystical_bee_listed(arg0: &MarketPlace, arg1: u64) : bool {
        0x2::linked_table::contains<u64, Listing>(&arg0.active_listings, arg1)
    }

    public fun is_registered_as_trainer(arg0: &DegenHiveMapStore, arg1: address) : (bool, address) {
        let v0 = 0x2::linked_table::contains<address, address>(&arg0.owner_to_trainer_mapping, arg1);
        let v1 = if (v0) {
            *0x2::linked_table::borrow<address, address>(&arg0.owner_to_trainer_mapping, arg1)
        } else {
            @0x0
        };
        (v0, v1)
    }

    public fun is_trading_enabled(arg0: &YieldFarm) : bool {
        arg0.trading_enabled
    }

    public fun is_usable_trainer_name(arg0: &DegenHiveMapStore, arg1: 0x1::string::String) : bool {
        let v0 = to_lowercase(0x1::string::to_ascii(arg1));
        (0x2::linked_table::contains<0x1::ascii::String, address>(&arg0.username_to_trainer_mapping, v0) || 0x2::linked_table::contains<0x1::ascii::String, address>(&arg0.username_to_school_mapping, v0)) && false || is_valid_trainer_name(arg1)
    }

    public fun is_valid_bee_name(arg0: 0x1::string::String) : bool {
        let v0 = 0x1::string::to_ascii(arg0);
        if (0x1::ascii::length(&v0) > 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::constants::max_trainer_name_length()) {
            return false
        };
        let v1 = 0x1::ascii::as_bytes(&v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(v1)) {
            if (!is_valid_trainer_char(*0x1::vector::borrow<u8>(v1, v2), true)) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    fun is_valid_trainer_char(arg0: u8, arg1: bool) : bool {
        let v0 = arg0 >= 65 && arg0 <= 90 || arg0 >= 97 && arg0 <= 122;
        let v1 = arg0 >= 48 && arg0 <= 57;
        if (!arg1) {
            if (v0) {
                true
            } else if (v1) {
                true
            } else {
                arg0 == 95
            }
        } else if (v0) {
            true
        } else if (v1) {
            true
        } else if (arg0 == 95) {
            true
        } else {
            arg0 == 32
        }
    }

    public fun is_valid_trainer_name(arg0: 0x1::string::String) : bool {
        let v0 = 0x1::string::to_ascii(arg0);
        if (0x1::ascii::length(&v0) > 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::constants::max_trainer_name_length()) {
            return false
        };
        let v1 = 0x1::ascii::as_bytes(&v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(v1)) {
            if (!is_valid_trainer_char(*0x1::vector::borrow<u8>(v1, v2), false)) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    public fun kraft_dragon_school(arg0: &mut DegenHiveMapStore, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) : DragonSchool {
        assert!(0x2::linked_table::contains<0x1::ascii::String, address>(&arg0.username_to_school_mapping, arg1), 1084);
        let v0 = DragonSchool{
            id              : 0x2::object::new(arg2),
            owner           : 0x2::tx_context::sender(arg2),
            username        : arg1,
            available_hive  : 0x2::balance::zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(),
            available_honey : 0x2::balance::zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(),
            module_version  : 0,
        };
        let v1 = DragonSchoolCreated{
            name            : arg1,
            new_school_addr : 0x2::object::uid_to_address(&v0.id),
        };
        0x2::event::emit<DragonSchoolCreated>(v1);
        0x2::linked_table::push_back<0x1::ascii::String, address>(&mut arg0.username_to_school_mapping, arg1, 0x2::object::uid_to_address(&v0.id));
        v0
    }

    public fun kraft_dragon_trainer(arg0: &0x2::clock::Clock, arg1: &mut DegenHiveMapStore, arg2: &mut BeesManager, arg3: &mut HiveGraph, arg4: &mut 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::FeeCollector<0x2::sui::SUI>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = kraft_dragon_trainer_and_return_sui(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg7), arg7);
    }

    public fun kraft_dragon_trainer_and_return_sui(arg0: &0x2::clock::Clock, arg1: &mut DegenHiveMapStore, arg2: &mut BeesManager, arg3: &mut HiveGraph, arg4: &mut 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::FeeCollector<0x2::sui::SUI>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg1.module_version == 0 && arg2.module_version == 0, 1079);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg5);
        let v1 = 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg2.configuration.trainer_onboarding_fee);
        let v2 = 0x2::tx_context::sender(arg7);
        let v3 = internal_kraft_dragon_trainer(arg0, arg6, v2, arg1, arg2, arg3, arg4, v1, arg7);
        0x2::transfer::transfer<DragonTrainer>(v3, 0x2::tx_context::sender(arg7));
        v0
    }

    fun lay_dragon_egg(arg0: u64, arg1: u64, arg2: u64, arg3: address, arg4: u64, arg5: 0x1::option::Option<address>, arg6: 0x1::option::Option<address>, arg7: u256, arg8: 0x2::linked_table::LinkedTable<u64, 0x1::string::String>, arg9: address, arg10: &mut BeesManager, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : MysticalBee {
        arg10.bees_tracker.total_eggs_laid = arg10.bees_tracker.total_eggs_laid + 1;
        let v0 = arg10.bees_tracker.total_eggs_laid;
        let v1 = BirthCertificate{
            generation      : arg0,
            birth_time      : arg2,
            birther_trainer : arg3,
            queenId         : arg5,
            stingerId       : arg6,
        };
        let v2 = EggBasketInfo{
            is_queen         : false,
            total_eggs       : 0,
            hatch_egg_record : 0x1::option::none<BeeEggRecord>(),
            last_egg_ts      : 0,
            cooldown_stage   : 0,
            cooldown_till_ts : 0,
        };
        let v3 = NectarStore{
            evolution_stage       : 0xbe7aee0c1e79fee9b7478821a5c3eab28ade3c513b0c7a027990e0adabeb5ca8::beescience::get_evolution_stage(arg7),
            lockup_weeks          : 0,
            hive_locked           : 0x2::balance::zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(),
            weighted_hive_locked  : 0,
            unlock_timestamp      : 0,
            honey_locked          : 0x2::balance::zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(),
            weighted_honey_locked : 0,
            hive_claim_index      : 0,
            honey_claim_index     : 0,
        };
        let v4 = MysticalBee{
            id                : 0x2::object::new(arg12),
            version           : v0,
            name              : 0x1::string::utf8(b"Baby Dragon-Bee"),
            owned_by          : arg9,
            queen_version     : arg4,
            genes             : arg7,
            appearance        : arg8,
            birth_certificate : v1,
            eggs_basket       : v2,
            nectar            : v3,
            capabilities      : 0x2::linked_table::new<u64, CapabilityState>(arg12),
            game_state        : 0x2::linked_table::new<0x1::ascii::String, address>(arg12),
            hive_energy       : 0,
            honey_health      : 0,
            dragon_dust       : 0,
            is_hatched        : false,
        };
        let v5 = &mut v4;
        add_capabilities_based_on_gene(arg10, v5);
        let v6 = EggLaidForDragonBee{
            id              : 0x2::object::uid_to_address(&v4.id),
            generation      : arg0,
            version         : v0,
            gene            : arg7,
            birth_time      : arg2,
            birther_trainer : arg3,
            queen_version   : arg4,
            queenId         : arg5,
            stingerId       : arg6,
            price           : arg11,
            honey_deposit   : arg1,
        };
        0x2::event::emit<EggLaidForDragonBee>(v6);
        v4
    }

    fun lay_genesis_dragonbee_egg(arg0: &0x2::clock::Clock, arg1: &0x2::random::Random, arg2: &mut 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::FeeCollector<0x2::sui::SUI>, arg3: &mut BeesManager, arg4: &mut YieldFarm, arg5: &mut DragonTrainer, arg6: 0x2::balance::Balance<0x2::sui::SUI>, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x2::object::uid_to_address(&arg5.id);
        let v2 = 1;
        let v3 = 0x2::table::borrow_mut<u64, DragonEggsBasket>(&mut arg3.dragon_eggs_basket, 420);
        assert!(v0 >= v3.start_time, 1008);
        if (!0x2::linked_table::contains<address, u64>(&v3.address_list, v1)) {
            0x2::linked_table::push_back<address, u64>(&mut v3.address_list, v1, 0);
        };
        let v4 = 0x2::linked_table::borrow_mut<address, u64>(&mut v3.address_list, v1);
        assert!(v3.per_user_limit >= *v4 + v2, 1018);
        *v4 = *v4 + v2;
        let v5 = 0;
        if (0x2::linked_table::contains<address, u64>(&v3.whitelist_trainers_pricing, v1)) {
            let v6 = 0x2::linked_table::borrow_mut<address, u64>(&mut v3.whitelist_trainers_availability, v1);
            if (*v6 > 0) {
                v5 = *0x2::linked_table::borrow<address, u64>(&v3.whitelist_trainers_pricing, v1);
                *v6 = *v6 - 1;
            };
        };
        if (v5 == 0) {
            v5 = 0xbe7aee0c1e79fee9b7478821a5c3eab28ade3c513b0c7a027990e0adabeb5ca8::beescience::compute_gene_price(v3.base_price, v3.curve_a, v3.eggs_laid);
        };
        let v7 = 0x2::balance::split<0x2::sui::SUI>(&mut arg6, v5);
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::collect_fee_for_coin<0x2::sui::SUI>(arg2, 0x2::balance::split<0x2::sui::SUI>(&mut v7, (0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::math::mul_div_u256((v5 as u256), (arg3.configuration.royalty.numerator as u256), (0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::constants::percent_precision() as u256)) as u64)));
        0x2::balance::join<0x2::sui::SUI>(&mut arg3.buidlers_royalty, v7);
        let v8 = 0x1::vector::length<u64>(&v3.bees_indexes);
        assert!(v8 > 0, 1184);
        let v9 = 0;
        let v10 = 0;
        let v11 = 0x2::random::new_generator(arg1, arg8);
        if (v8 > 1) {
            let v12 = 0x2::random::generate_u64_in_range(&mut v11, 0, v8 - 1);
            v10 = v12;
            v9 = *0x1::vector::borrow<u64>(&v3.bees_indexes, v12);
        };
        0x1::vector::remove<u64>(&mut v3.bees_indexes, v10);
        v3.eggs_laid = v3.eggs_laid + 1;
        let v13 = 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::math::min_u64(0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&v3.honey_avail), 42000000000);
        let v14 = 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::math::min_u64(0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&v3.hive_avail), 1000000000);
        let v15 = if (v13 > 420000000) {
            0x2::random::generate_u64_in_range(&mut v11, 420000000, v13)
        } else {
            v13
        };
        let v16 = if (v14 > 10000000) {
            0x2::random::generate_u64_in_range(&mut v11, 10000000, v14)
        } else {
            v14
        };
        let v17 = 0x2::balance::split<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut v3.honey_avail, v15);
        let v18 = 0x2::balance::split<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut v3.hive_avail, v16);
        let v19 = false;
        let v20 = v3.max_eggs_limit;
        if (v3.queen_bee_eggs_count > 0 && (arg7 || 0x2::random::generate_u64_in_range(&mut v11, 0, 1000) < v3.queen_chance)) {
            v19 = true;
            v3.queen_bee_eggs_count = v3.queen_bee_eggs_count - 1;
            v3.queen_eggs_laid = v3.queen_eggs_laid + 1;
        };
        0x2::linked_table::push_back<u64, 0x2::linked_table::LinkedTable<u64, 0x1::string::String>>(&mut v3.dragonbee_imgs_list, arg3.bees_tracker.total_eggs_laid + 1, 0x2::linked_table::new<u64, 0x1::string::String>(arg8));
        let v21 = lay_dragon_egg(0, v15, v0, v1, 0, 0x1::option::none<address>(), 0x1::option::none<address>(), 0x2::linked_table::remove<u64, u256>(&mut v3.genesis_genes_list, v9), 0x2::linked_table::remove<u64, 0x2::linked_table::LinkedTable<u64, 0x1::string::String>>(&mut v3.images_list, v9), v1, arg3, v5, arg8);
        if (0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&v17) > 0) {
            let v22 = &mut v21;
            lock_honey_with_bee(arg4, v22, v17);
        } else {
            0x2::balance::destroy_zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(v17);
        };
        if (0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&v18) > 0) {
            let v23 = &mut v21;
            lock_hive_with_bee(0x2::clock::timestamp_ms(arg0), arg4, v23, v18, 0x2::random::generate_u64_in_range(&mut v11, 10, 208 / 4));
        } else {
            0x2::balance::destroy_zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(v18);
        };
        if (v19) {
            let v24 = &mut v21;
            internal_make_bee_queen(arg3, v24, v20, 0, arg8);
        };
        update_bee_ownership(arg3, v21.version, v1);
        deposit_bee_in_trainer(arg5, v21);
        arg6
    }

    fun lay_genesis_dragonbee_egg_loop(arg0: &0x2::clock::Clock, arg1: &0x2::random::Random, arg2: &mut 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::FeeCollector<0x2::sui::SUI>, arg3: &mut BeesManager, arg4: &mut YieldFarm, arg5: &mut DragonTrainer, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x2::table::borrow<u64, DragonEggsBasket>(&arg3.dragon_eggs_basket, 420);
        assert!(v0.eggs_count > v0.eggs_laid + arg7, 1162);
        let v1 = 0;
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg6);
        while (v1 < arg7) {
            v2 = lay_genesis_dragonbee_egg(arg0, arg1, arg2, arg3, arg4, arg5, v2, false, arg8);
            v1 = v1 + 1;
        };
        v2
    }

    entry fun lay_genesis_dragonbee_eggs(arg0: &0x2::clock::Clock, arg1: &0x2::random::Random, arg2: &mut 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::FeeCollector<0x2::sui::SUI>, arg3: &mut BeesManager, arg4: &mut YieldFarm, arg5: &mut DragonTrainer, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = lay_genesis_dragonbee_egg_loop(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg8), arg8);
    }

    public fun lock_assets_with_trainer(arg0: &mut DragonTrainer, arg1: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>, arg2: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, LockedDegenHiveAssets>(&mut arg0.id, 0x1::string::utf8(b"LOCKED_DEGEN_HIVE_ASSETS"));
        0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut v0.hive_locked, arg1);
        0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut v0.honey_locked, arg2);
    }

    fun lock_hive_with_bee(arg0: u64, arg1: &mut YieldFarm, arg2: &mut MysticalBee, arg3: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>, arg4: u64) {
        0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut arg2.nectar.hive_locked, arg3);
        if (arg2.nectar.lockup_weeks == 0) {
            assert!(arg4 > 0 && arg4 <= 208, 1189);
            arg2.nectar.unlock_timestamp = arg0 + (arg4 as u64) * 604800000;
            arg2.nectar.lockup_weeks = arg4;
        };
        assert!(arg2.nectar.unlock_timestamp != 0, 1189);
        if (arg2.nectar.unlock_timestamp < arg0) {
            return
        };
        let v0 = arg2.nectar.weighted_hive_locked;
        let v1 = compute_veHive(arg2.nectar.lockup_weeks, 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&arg2.nectar.hive_locked), (arg2.nectar.evolution_stage as u64));
        arg2.nectar.weighted_hive_locked = v1;
        if (v1 > v0) {
            arg2.hive_energy = arg2.hive_energy + ((v1 - v0) as u64);
        };
        arg1.governance_info.total_weighted_hive = arg1.governance_info.total_weighted_hive + v1 - v0;
        let v2 = HiveEnergyInfusedInBee{
            version              : arg2.version,
            add_hive_locked      : 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&arg3),
            hive_locked_with_bee : 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&arg2.nectar.hive_locked),
            weighted_hive_locked : arg2.nectar.weighted_hive_locked,
            unlock_timestamp     : arg2.nectar.unlock_timestamp,
            lockup_weeks         : arg2.nectar.lockup_weeks,
            hive_energy          : arg2.hive_energy,
            total_weighted_hive  : arg1.governance_info.total_weighted_hive,
        };
        0x2::event::emit<HiveEnergyInfusedInBee>(v2);
    }

    fun lock_honey_with_bee(arg0: &mut YieldFarm, arg1: &mut MysticalBee, arg2: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>) {
        if (0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&arg2) == 0) {
            0x2::balance::destroy_zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(arg2);
            return
        };
        0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut arg1.nectar.honey_locked, arg2);
        let v0 = (0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::math::mul_div_u256((0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&arg1.nectar.honey_locked) as u256), (get_evolution_multiplier(0xbe7aee0c1e79fee9b7478821a5c3eab28ade3c513b0c7a027990e0adabeb5ca8::beescience::get_evolution_stage(arg1.genes)) as u256), (1000000 as u256)) as u128);
        arg1.nectar.weighted_honey_locked = v0;
        let v1 = v0 - arg1.nectar.weighted_honey_locked;
        arg1.honey_health = arg1.honey_health + (v1 as u64);
        arg0.governance_info.total_weighted_honey = arg0.governance_info.total_weighted_honey + v1;
        let v2 = HealthInfusedInBee{
            version               : arg1.version,
            honey_added           : 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&arg2),
            total_honey_locked    : 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&arg1.nectar.honey_locked),
            weighted_honey_locked : arg1.nectar.weighted_honey_locked,
            health_increase       : (v1 as u64),
            honey_health          : arg1.honey_health,
        };
        0x2::event::emit<HealthInfusedInBee>(v2);
    }

    public fun make_bee_queen(arg0: &0x2::coin::TreasuryCap<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>, arg1: &mut BeesManager, arg2: &mut MysticalBee, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        internal_make_bee_queen(arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun make_bid(arg0: &0x2::clock::Clock, arg1: &mut BeesManager, arg2: &mut MarketPlace, arg3: &mut 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::FeeCollector<0x2::sui::SUI>, arg4: &mut DragonTrainer, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0, 1079);
        let v0 = 0x2::object::uid_to_address(&arg4.id);
        let v1 = 0x2::clock::timestamp_ms(arg0);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg5);
        assert!(arg7 >= arg1.configuration.min_bid_amt, 1040);
        assert!(arg7 <= 0x2::balance::value<0x2::sui::SUI>(&v2), 1185);
        assert!(v1 < arg8 && arg8 - v1 < 7776000000, 1030);
        let v3 = 0x2::linked_table::borrow<u64, Listing>(&arg2.active_listings, arg6);
        assert!(v3.expiration_sec > v1, 1032);
        let v4 = 0x2::balance::split<0x2::sui::SUI>(&mut v2, arg7);
        if (arg7 >= v3.min_price) {
            let v5 = &mut v4;
            let v6 = execute_sale(arg1, arg2, arg3, arg6, false, v0, arg7, v5);
            update_bee_ownership(arg1, arg6, v0);
            deposit_bee_in_trainer(arg4, 0x1::option::extract<MysticalBee>(&mut v6.mystical_bee));
            0x2::linked_table::push_back<u64, ExecutedListing>(&mut arg2.processed_listings, arg6, v6);
            0x2::balance::join<0x2::sui::SUI>(&mut v2, v4);
        } else {
            let v7 = BidPlaced{
                bidder_trainer : v0,
                username       : arg4.username,
                version        : arg6,
                offer_price    : arg7,
                expiration_sec : arg8,
            };
            0x2::event::emit<BidPlaced>(v7);
            let v8 = &mut arg2.available_bids;
            add_bid_to_table(v8, arg6, create_bid(v0, arg7, v4, arg8), arg1.configuration.max_bids_per_bee);
            0x2::linked_table::push_back<u64, BidRecord>(&mut arg4.bid_records, arg6, create_bid_record(arg6, arg7, arg8));
        };
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v2, 0x2::tx_context::sender(arg9), arg9);
    }

    public entry fun make_dragon_egg_hatchable(arg0: &GenesisBeesUploaderCapability, arg1: &mut BeesManager, arg2: u64, arg3: vector<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 1079);
        let v0 = 0x2::table::borrow_mut<u64, DragonEggsBasket>(&mut arg1.dragon_eggs_basket, 420);
        assert!(0x2::linked_table::contains<u64, 0x2::linked_table::LinkedTable<u64, 0x1::string::String>>(&v0.dragonbee_imgs_list, arg2), 1156);
        let v1 = 0;
        let v2 = 0x2::linked_table::new<u64, 0x1::string::String>(arg4);
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg3)) {
            0x2::linked_table::push_back<u64, 0x1::string::String>(&mut v2, v1, *0x1::vector::borrow<0x1::string::String>(&arg3, v1));
            v1 = v1 + 1;
        };
        0x2::linked_table::drop<u64, 0x1::string::String>(0x2::linked_table::remove<u64, 0x2::linked_table::LinkedTable<u64, 0x1::string::String>>(&mut v0.dragonbee_imgs_list, arg2));
        0x2::linked_table::push_back<u64, 0x2::linked_table::LinkedTable<u64, 0x1::string::String>>(&mut v0.dragonbee_imgs_list, arg2, v2);
    }

    public entry fun make_listing(arg0: &0x2::clock::Clock, arg1: &BeesManager, arg2: &mut MarketPlace, arg3: &mut DragonTrainer, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        let v0 = if (arg1.module_version == 0) {
            if (arg2.module_version == 0) {
                arg3.module_version == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1079);
        let v1 = 0x2::object::uid_to_address(&arg3.id);
        let v2 = 0x2::clock::timestamp_ms(arg0);
        assert!(arg6 > v2 && arg6 - v2 < 7776000000, 1002);
        assert!(arg5 >= arg1.configuration.min_bid_amt, 1040);
        assert!(0x2::linked_table::contains<u64, MysticalBee>(&arg3.owned_bees, arg4), 1024);
        let v3 = Listing{
            listed_by_trainer : v1,
            mystical_bee      : 0x2::linked_table::remove<u64, MysticalBee>(&mut arg3.owned_bees, arg4),
            min_price         : arg5,
            expiration_sec    : arg6,
        };
        let v4 = ListingRecord{
            version        : arg4,
            min_price      : arg5,
            expiration_sec : arg6,
        };
        let v5 = NewListing{
            listed_by_trainer : v1,
            version           : arg4,
            min_price         : arg5,
            expiration_sec    : arg6,
        };
        0x2::event::emit<NewListing>(v5);
        0x2::linked_table::push_back<u64, ListingRecord>(&mut arg3.listing_records, arg4, v4);
        0x2::linked_table::push_back<u64, Listing>(&mut arg2.active_listings, arg4, v3);
    }

    fun mark_marketplace_bids_as_invalid(arg0: &mut MarketPlace, arg1: u64) {
        if (0x2::linked_table::contains<u64, vector<Bid>>(&arg0.available_bids, arg1)) {
            let v0 = 0x2::linked_table::remove<u64, vector<Bid>>(&mut arg0.available_bids, arg1);
            let v1 = 0;
            while (v1 < 0x1::vector::length<Bid>(&v0)) {
                let v2 = 0x1::vector::borrow_mut<Bid>(&mut v0, v1);
                v2.is_valid = false;
                let v3 = BidMarkedInvalid{
                    version        : arg1,
                    bidder_trainer : v2.bidder_trainer,
                };
                0x2::event::emit<BidMarkedInvalid>(v3);
                v1 = v1 + 1;
            };
            0x2::linked_table::push_back<u64, vector<Bid>>(&mut arg0.available_bids, arg1, v0);
        };
    }

    entry fun match_active_trainers(arg0: &0x2::clock::Clock, arg1: &0x2::random::Random, arg2: &mut HiddenWorld, arg3: &mut 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::YieldFlow, arg4: &DragonTrainer, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.module_version == 0, 1079);
        let v0 = 0x2::object::uid_to_address(&arg4.id);
        let v1 = arg2.config.session_health;
        let v2 = arg2.config.session_energy;
        let QuestRequest {
            timestamp    : v3,
            version      : v4,
            mystical_bee : v5,
            sui_bet      : v6,
            player_only  : v7,
            with_trainer : v8,
            active_index : v9,
        } = 0x2::linked_table::remove<address, QuestRequest>(&mut arg2.active_trainers, v0);
        let v10 = v9;
        let v11 = v8;
        let (_, v13) = 0x1::vector::index_of<u64>(&arg2.active_trainers_indexes, &v10);
        0x1::vector::remove<u64>(&mut arg2.active_trainers_indexes, v13);
        let v14 = QuestRequestDestroyed{
            trainer_address : v0,
            version         : v4,
        };
        0x2::event::emit<QuestRequestDestroyed>(v14);
        assert!(0x2::clock::timestamp_ms(arg0) - v3 <= arg2.config.max_active_duration, 1206);
        let v15 = @0x0;
        let v16 = 0;
        let v17 = 0x1::option::none<MysticalBee>();
        let v18 = 0x2::balance::zero<0x2::sui::SUI>();
        if (!v7) {
            let (v19, v20) = choose_random_dragon_bee(arg0, arg2, arg1, arg5);
            let v21 = v20;
            v16 = v19;
            0x1::option::fill<MysticalBee>(&mut v17, 0x1::option::extract<MysticalBee>(&mut v21));
            0x1::option::destroy_none<MysticalBee>(v21);
        } else if (0x1::option::is_some<address>(&v11)) {
            let v22 = *0x1::option::borrow<address>(&v11);
            v15 = v22;
            assert!(0x2::linked_table::contains<address, QuestRequest>(&arg2.active_trainers, v22), 1202);
            let QuestRequest {
                timestamp    : v23,
                version      : v24,
                mystical_bee : v25,
                sui_bet      : v26,
                player_only  : _,
                with_trainer : v28,
                active_index : v29,
            } = 0x2::linked_table::remove<address, QuestRequest>(&mut arg2.active_trainers, v22);
            let v30 = v29;
            let v31 = v28;
            let (_, v33) = 0x1::vector::index_of<u64>(&arg2.active_trainers_indexes, &v30);
            0x1::vector::remove<u64>(&mut arg2.active_trainers_indexes, v33);
            let v34 = QuestRequestDestroyed{
                trainer_address : v22,
                version         : v24,
            };
            0x2::event::emit<QuestRequestDestroyed>(v34);
            assert!(0x2::clock::timestamp_ms(arg0) - v23 <= arg2.config.max_active_duration, 1206);
            assert!(*0x1::option::borrow<address>(&v31) == v0, 1203);
            0x2::balance::join<0x2::sui::SUI>(&mut v18, v26);
            0x1::option::fill<MysticalBee>(&mut v17, v25);
        } else {
            let (v35, v36, v37, v38) = choose_random_trainer(0x2::clock::timestamp_ms(arg0), arg2, arg1, arg5);
            let v39 = v37;
            v15 = v35;
            v16 = v36;
            0x2::balance::join<0x2::sui::SUI>(&mut v18, v38);
            0x1::option::fill<MysticalBee>(&mut v17, 0x1::option::extract<MysticalBee>(&mut v39));
            0x1::option::destroy_none<MysticalBee>(v39);
        };
        let (v40, v41, v42) = handle_sui_bet(arg2, arg3, v6, v18);
        let v43 = v42;
        let v44 = create_p2p_session_id(v4, v16);
        0x2::linked_table::push_back<0x1::string::String, P2pGameSession>(&mut arg2.p2p_quests, v44, create_p2p_game_session(arg0, v0, v15, v4, v16, v5, 0x1::option::extract<MysticalBee>(&mut v17), v43, v1, v2));
        0x1::option::destroy_none<MysticalBee>(v17);
        let v45 = 0x2::linked_table::borrow_mut<address, TrainerSession>(&mut arg2.trainer_sessions, v0);
        v45.state = 2;
        v45.current_quest = v44;
        v45.quests_count = v45.quests_count + 1;
        0x2::balance::join<0x2::sui::SUI>(&mut v45.sui_balance, v40);
        if (v15 != @0x0) {
            let v46 = 0x2::linked_table::borrow_mut<address, TrainerSession>(&mut arg2.trainer_sessions, v15);
            v46.state = 2;
            v46.current_quest = v44;
            v46.quests_count = v46.quests_count + 1;
            0x2::balance::join<0x2::sui::SUI>(&mut v46.sui_balance, v41);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v41);
        };
        let v47 = 0;
        let v48 = 0;
        if (0x2::linked_table::contains<u64, DragonDust>(&arg2.dragon_dust, v4)) {
            v47 = 0x2::linked_table::borrow<u64, DragonDust>(&arg2.dragon_dust, v4).quests_played;
        };
        if (0x2::linked_table::contains<u64, DragonDust>(&arg2.dragon_dust, v16)) {
            v48 = 0x2::linked_table::borrow<u64, DragonDust>(&arg2.dragon_dust, v16).quests_played;
        };
        arg2.avg_quests_played = update_ema_quests_played(update_ema_quests_played(arg2.avg_quests_played, v47, arg2.config.half_life), v48, arg2.config.half_life);
        let v49 = NewGameSession{
            p2p_session_id : v44,
            trainer_addr1  : v0,
            trainer_addr2  : v15,
            version1       : v4,
            version2       : v16,
            sui_bet        : 0x2::balance::value<0x2::sui::SUI>(&v43),
        };
        0x2::event::emit<NewGameSession>(v49);
    }

    fun process_and_store_quest(arg0: &0x2::random::Random, arg1: &mut HiddenWorld, arg2: 0x1::string::String, arg3: P2pGameSession, arg4: bool, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg0, arg6);
        if (!arg4) {
            0x2::linked_table::push_back<0x1::string::String, P2pGameSession>(&mut arg1.p2p_quests, arg2, arg3);
            return
        };
        let P2pGameSession {
            trainer_addr1   : v1,
            trainer_addr2   : v2,
            version1        : _,
            v1_dust_pct_sum : v4,
            v1_evolved      : v5,
            version2        : v6,
            v2_dust_pct_sum : v7,
            v2_evolved      : v8,
            current_quest   : v9,
        } = arg3;
        let HiddenWorldQuest {
            trainer_addr1     : _,
            trainer_addr2     : _,
            next_turn         : _,
            last_action_ts    : _,
            sui_bet_bal       : v14,
            start_game_health : _,
            start_game_energy : _,
            user_bee_health   : _,
            user_bee_energy   : _,
            user_dragon_bee   : v19,
            user2_bee_health  : _,
            user2_bee_energy  : _,
            user2_dragon_bee  : v22,
        } = v9;
        let v23 = v14;
        let (v24, v25) = if (arg5) {
            (v1, v2)
        } else {
            (v2, v1)
        };
        let v26 = 0x2::balance::value<0x2::sui::SUI>(&v23);
        let v27 = v26 * (0x2::random::generate_u64_in_range(&mut v0, 100, calculate_max_multiplier(v4 + v7, v5 + v8) * 100) as u64) / 100;
        let v28 = 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_pool);
        let v29 = if (v27 > v28) {
            v28
        } else {
            v27
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_pool, v29), arg6), v24);
        if (v25 == @0x0) {
            if (0x2::random::generate_u64_in_range(&mut v0, 1, 100) <= 5) {
                0x1::vector::push_back<MysticalBee>(0x2::linked_table::borrow_mut<address, vector<MysticalBee>>(&mut arg1.bees_to_collect, v1), v22);
                let HiddenMysticalBee {
                    mystical_bee        : v30,
                    winnings            : v31,
                    winnings_sum        : _,
                    loosing_sum         : _,
                    dragon_dust_emitted : _,
                } = 0x2::linked_table::remove<u64, HiddenMysticalBee>(&mut arg1.hidden_bees, v6);
                0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_pool, v31);
                0x1::option::destroy_none<MysticalBee>(v30);
            } else {
                let v35 = 0x2::linked_table::borrow_mut<u64, HiddenMysticalBee>(&mut arg1.hidden_bees, v6);
                0x1::option::fill<MysticalBee>(&mut v35.mystical_bee, v22);
                v35.winnings_sum = v35.winnings_sum + v26;
                v35.dragon_dust_emitted = v35.dragon_dust_emitted + v7;
            };
        } else {
            0x1::vector::push_back<MysticalBee>(0x2::linked_table::borrow_mut<address, vector<MysticalBee>>(&mut arg1.bees_to_collect, v2), v22);
        };
        0x1::vector::push_back<MysticalBee>(0x2::linked_table::borrow_mut<address, vector<MysticalBee>>(&mut arg1.bees_to_collect, v1), v19);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v23, arg6), v24);
    }

    public entry fun process_breeding_request(arg0: &GenesisBeesUploaderCapability, arg1: &mut BeesManager, arg2: u64, arg3: u64, arg4: vector<0x1::string::String>, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::linked_table::borrow_mut<u64, BeeEgg>(&mut 0x2::linked_table::borrow_mut<u64, BeeHive>(&mut arg1.bee_hives, arg2).incubating_eggs, arg3);
        assert!(0x2::linked_table::length<u64, 0x1::string::String>(&v0.dragon_bee_egg.appearance) == 0, 1157);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg4)) {
            0x2::linked_table::push_back<u64, 0x1::string::String>(&mut v0.dragon_bee_egg.appearance, v1, *0x1::vector::borrow<0x1::string::String>(&arg4, v1));
            v1 = v1 + 1;
        };
        v0.is_processed = true;
        let v2 = BreedingRequestProcessed{
            queen_version : arg2,
            stinger_index : arg3,
            img           : arg4,
        };
        0x2::event::emit<BreedingRequestProcessed>(v2);
    }

    public entry fun process_evolution_request(arg0: &GenesisBeesUploaderCapability, arg1: &mut HiddenWorld, arg2: u64, arg3: u64, arg4: vector<0x1::string::String>) {
        assert!(0x2::linked_table::contains<u64, DragonDust>(&arg1.dragon_dust, arg2), 1079);
        let v0 = 0x2::linked_table::borrow_mut<u64, DragonDust>(&mut arg1.dragon_dust, arg2);
        if (0x2::linked_table::contains<u64, vector<0x1::string::String>>(&v0.genes_img_map, arg3)) {
            0x2::linked_table::remove<u64, vector<0x1::string::String>>(&mut v0.genes_img_map, arg3);
        };
        0x2::linked_table::push_back<u64, vector<0x1::string::String>>(&mut v0.genes_img_map, arg3, arg4);
        let v1 = TransformationRequestProcessed{
            version   : arg2,
            img_index : arg3,
            img       : arg4,
        };
        0x2::event::emit<TransformationRequestProcessed>(v1);
    }

    fun process_royalty(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: &mut BeesManager, arg2: &mut 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::FeeCollector<0x2::sui::SUI>, arg3: u64, arg4: bool) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::constants::percent_precision();
        let v1 = (0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::math::mul_div_u128((0x2::balance::value<0x2::sui::SUI>(&arg0) as u128), (arg1.configuration.royalty.numerator as u128), (v0 as u128)) as u64);
        let v2 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0, v1);
        let v3 = (0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::math::mul_div_u128((0x2::balance::value<0x2::sui::SUI>(&v2) as u128), (arg1.configuration.royalty.gov_yield_pct as u128), (v0 as u128)) as u64);
        let v4 = (0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::math::mul_div_u128((0x2::balance::value<0x2::sui::SUI>(&v2) as u128), (arg1.configuration.royalty.queen_pct as u128), (v0 as u128)) as u64);
        let v5 = v4;
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::collect_fee_for_coin<0x2::sui::SUI>(arg2, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v3));
        if (!arg4) {
            0x2::balance::join<0x2::sui::SUI>(&mut 0x2::linked_table::borrow_mut<u64, BeeHive>(&mut arg1.bee_hives, arg3).sui_custody, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v4));
        } else {
            v5 = 0;
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.buidlers_royalty, v2);
        let v6 = RoyaltyProcessed{
            total_royalty_amt : v1,
            gov_yield_amt     : v3,
            queen_royalty_amt : v5,
            platform_fees     : 0x2::balance::value<0x2::sui::SUI>(&v2),
        };
        0x2::event::emit<RoyaltyProcessed>(v6);
        arg0
    }

    public fun remove_app_from_trainer<T0: store + key>(arg0: &GameMasterKey, arg1: &mut DragonTrainer, arg2: &0x2::tx_context::TxContext) : T0 {
        0x2::linked_table::remove<0x1::ascii::String, address>(&mut arg1.trainer_sessions, arg0.app_name);
        let v0 = AppRemovedByProfile{
            profile_addr : 0x2::object::uid_to_address(&arg1.id),
            username     : arg1.username,
            app_name     : arg0.app_name,
        };
        0x2::event::emit<AppRemovedByProfile>(v0);
        0x2::dynamic_object_field::remove<0x1::ascii::String, T0>(&mut arg1.id, arg0.app_name)
    }

    fun remove_bee_friends_for_breeding(arg0: &mut BeesManager, arg1: &MysticalBee, arg2: u64) {
        let v0 = 0x2::linked_table::borrow_mut<u64, BeeHive>(&mut arg0.bee_hives, arg1.version);
        if (0x2::linked_table::contains<u64, u64>(&v0.friends_list, arg2)) {
            0x2::linked_table::remove<u64, u64>(&mut v0.friends_list, arg2);
        };
        let v1 = BeeRemovedFromFriendsList{
            queen_version : arg1.version,
            friendly_bee  : arg2,
        };
        0x2::event::emit<BeeRemovedFromFriendsList>(v1);
    }

    public fun remove_store_from_bee<T0: store + key>(arg0: &GameMasterKey, arg1: &mut MysticalBee) : T0 {
        0x2::linked_table::remove<0x1::ascii::String, address>(&mut arg1.game_state, arg0.app_name);
        let v0 = StoreRemovedFromBee{
            version  : arg1.version,
            app_name : arg0.app_name,
        };
        0x2::event::emit<StoreRemovedFromBee>(v0);
        0x2::dynamic_object_field::remove<0x1::ascii::String, T0>(&mut arg1.id, arg0.app_name)
    }

    public fun replenish_master_key(arg0: &mut GameMasterKey, arg1: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg2: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>) {
        let v0 = internal_replenish_master_key(arg0, arg1, arg2, 0, 0);
        0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut arg0.hive_incentives, v0);
    }

    public fun replenish_master_key_with_honey(arg0: &mut GameMasterKey, arg1: &mut 0x2::token::TokenPolicy<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg2: &0x2::token::TokenPolicyCap<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg3: 0x2::token::Token<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = internal_replenish_master_key(arg0, 0x2::coin::into_balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::unwrap_honey_tokens_to_coins<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut arg3, arg2, arg1, arg4, arg5)), 0x2::balance::zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(), 0, 0);
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::transfer_honey<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut arg3, arg2, arg1, 0x2::token::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&arg3), 0x2::tx_context::sender(arg5), arg5);
        0x2::token::destroy_zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(arg3);
        0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut arg0.hive_incentives, v0);
    }

    public fun return_bee_from_competition(arg0: &0x2::coin::TreasuryCap<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>, arg1: &mut BeesManager, arg2: &mut DragonTrainer, arg3: MysticalBee, arg4: u64, arg5: u64) {
        arg3.hive_energy = arg3.hive_energy + arg4;
        arg3.honey_health = arg3.honey_health + arg5;
        let v0 = MysticalBeeReturnedFromCompetition{
            recepient_trainer  : 0x2::object::uid_to_address(&arg2.id),
            recepient_username : arg2.username,
            version            : arg3.version,
            energy_increase    : arg4,
            health_increase    : arg5,
            hive_energy        : arg3.hive_energy + arg4,
            honey_health       : arg3.honey_health + arg5,
        };
        0x2::event::emit<MysticalBeeReturnedFromCompetition>(v0);
        update_bee_ownership(arg1, arg3.version, 0x2::object::uid_to_address(&arg2.id));
        deposit_bee_in_trainer(arg2, arg3);
    }

    public entry fun send_to_hidden_world(arg0: &0x2::clock::Clock, arg1: &mut BeesManager, arg2: &mut YieldFarm, arg3: &mut HiddenWorld, arg4: &mut 0x2::token::TokenPolicy<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg5: &0x2::token::TokenPolicyCap<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg6: &mut DragonTrainer, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0 && arg2.module_version == 0, 1079);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = withdraw_bee_from_trainer(arg1, arg6, arg7, v0);
        let (v2, v3) = internal_send_to_hidden_world(arg0, arg1, arg3, arg2, v1, 0x2::object::uid_to_address(&arg6.id), arg8);
        if (arg2.trading_enabled) {
            0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::coin_helper::destroy_or_transfer_balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(v2, v0, arg8);
            0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::transfer_honey_balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(arg4, arg5, v3, v0, arg8);
        } else {
            let v4 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, LockedDegenHiveAssets>(&mut arg6.id, 0x1::string::utf8(b"LOCKED_DEGEN_HIVE_ASSETS"));
            0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut v4.hive_locked, v2);
            0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut v4.honey_locked, v3);
        };
    }

    public fun set_suins_domain_as_username(arg0: &BeesManager, arg1: &mut DegenHiveMapStore, arg2: &mut YieldFarm, arg3: &mut DragonTrainer, arg4: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg5: 0x2::coin::Coin<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain_name(arg4);
        let v1 = 0x1::string::to_ascii(v0);
        let v2 = to_lowercase(v1);
        assert!(!0x2::linked_table::contains<0x1::ascii::String, address>(&arg1.username_to_trainer_mapping, v2), 1135);
        increment_global_yield_indexes(arg2);
        let v3 = arg0.configuration.mutation_fee;
        let v4 = 0x2::coin::into_balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(arg5);
        assert!(v3 <= 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&v4), 1122);
        deposit_hive_for_distribution(arg2, 0x2::balance::split<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut v4, v3));
        let v5 = arg3.username;
        0x2::linked_table::remove<0x1::ascii::String, address>(&mut arg1.username_to_trainer_mapping, to_lowercase(v5));
        arg3.username = v1;
        0x2::linked_table::push_back<0x1::ascii::String, address>(&mut arg1.username_to_trainer_mapping, v2, 0x2::object::uid_to_address(&arg3.id));
        0x2::linked_table::push_back<0x1::ascii::String, u64>(&mut arg1.suins_name_to_expiry_mapping, v2, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::expiration_timestamp_ms(arg4));
        let v6 = UserNameUpdated{
            profile_addr  : 0x2::object::uid_to_address(&arg3.id),
            prev_username : 0x1::string::from_ascii(v5),
            new_username  : v0,
        };
        0x2::event::emit<UserNameUpdated>(v6);
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::coin_helper::destroy_or_transfer_balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(v4, 0x2::tx_context::sender(arg6), arg6);
    }

    public entry fun setup_bees_manager(arg0: &mut 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::DeployerCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: bool, arg18: u64, arg19: u64, arg20: &mut 0x2::tx_context::TxContext) {
        let v0 = GovernanceInfo{
            total_weighted_hive  : 0,
            total_weighted_honey : 0,
        };
        let v1 = YieldFarm{
            id                      : 0x2::object::new(arg20),
            trading_enabled         : arg17,
            governance_info         : v0,
            incoming_honey_for_bees : 0x2::balance::zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(),
            incoming_hive_for_bees  : 0x2::balance::zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(),
            honey_for_bees          : 0x2::balance::zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(),
            hive_for_bees           : 0x2::balance::zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(),
            honey_global_index      : 0,
            hive_global_index       : 0,
            module_version          : 0,
        };
        0x2::transfer::share_object<YieldFarm>(v1);
        let v2 = DragonEggsBasket{
            start_time                      : arg11,
            eggs_count                      : arg12,
            queen_bee_eggs_count            : arg13,
            eggs_laid                       : 0,
            queen_eggs_laid                 : 0,
            queen_chance                    : arg14,
            max_eggs_limit                  : arg15,
            base_price                      : 0,
            curve_a                         : 0,
            address_list                    : 0x2::linked_table::new<address, u64>(arg20),
            per_user_limit                  : arg16,
            whitelist_trainers_pricing      : 0x2::linked_table::new<address, u64>(arg20),
            whitelist_trainers_availability : 0x2::linked_table::new<address, u64>(arg20),
            bees_indexes                    : 0x1::vector::empty<u64>(),
            genesis_genes_list              : 0x2::linked_table::new<u64, u256>(arg20),
            images_list                     : 0x2::linked_table::new<u64, 0x2::linked_table::LinkedTable<u64, 0x1::string::String>>(arg20),
            capabilities                    : 0x2::linked_table::new<u64, CapabilityState>(arg20),
            dragonbee_imgs_list             : 0x2::linked_table::new<u64, 0x2::linked_table::LinkedTable<u64, 0x1::string::String>>(arg20),
            honey_avail                     : 0x2::balance::zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(),
            hive_avail                      : 0x2::balance::zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(),
        };
        let v3 = 0x2::table::new<u64, DragonEggsBasket>(arg20);
        0x2::table::add<u64, DragonEggsBasket>(&mut v3, 420, v2);
        let v4 = 0x2::linked_table::new<u64, u64>(arg20);
        0x2::linked_table::push_back<u64, u64>(&mut v4, 1, 300000);
        0x2::linked_table::push_back<u64, u64>(&mut v4, 2, 900000);
        0x2::linked_table::push_back<u64, u64>(&mut v4, 3, 1800000);
        0x2::linked_table::push_back<u64, u64>(&mut v4, 4, 60000);
        0x2::linked_table::push_back<u64, u64>(&mut v4, 5, 360000);
        0x2::linked_table::push_back<u64, u64>(&mut v4, 6, 720000);
        0x2::linked_table::push_back<u64, u64>(&mut v4, 7, 1440000);
        0x2::linked_table::push_back<u64, u64>(&mut v4, 8, 4320000);
        0x2::linked_table::push_back<u64, u64>(&mut v4, 9, 10080000);
        let v5 = Royalty{
            numerator     : arg1,
            gov_yield_pct : arg2,
            queen_pct     : arg3,
        };
        let v6 = BreedingRoyalty{
            platform_fees_pct : arg4,
            gov_yield_pct     : arg5,
            treasury_pct      : arg6,
        };
        let v7 = Configuration{
            max_bids_per_bee       : arg7,
            min_bid_amt            : arg8,
            trainer_onboarding_fee : arg9,
            mutation_fee           : arg10,
            royalty                : v5,
            breeding_royalty       : v6,
            cooldown_periods       : v4,
            min_energy_to_hatch    : arg18,
            min_health_to_hatch    : arg19,
        };
        let v8 = BeesTracker{
            total_eggs_laid   : 0,
            bees_to_owner_map : 0x2::linked_table::new<u64, address>(arg20),
            queen_bees_map    : 0x2::linked_table::new<u64, bool>(arg20),
        };
        let v9 = BeeTransfers{
            custodied_bees : 0x2::linked_table::new<u64, BeeInFlight>(arg20),
            incoming_boxes : 0x2::linked_table::new<address, vector<u64>>(arg20),
            outgoing_boxes : 0x2::linked_table::new<address, vector<u64>>(arg20),
        };
        let v10 = BeesManager{
            id                 : 0x2::object::new(arg20),
            configuration      : v7,
            hive_treasury      : 0x2::balance::zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(),
            honey_treasury     : 0x2::balance::zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(),
            bees_tracker       : v8,
            bee_transfers      : v9,
            dragon_eggs_basket : v3,
            bee_hives          : 0x2::linked_table::new<u64, BeeHive>(arg20),
            buidlers_royalty   : 0x2::balance::zero<0x2::sui::SUI>(),
            module_version     : 0,
        };
        0x2::transfer::share_object<BeesManager>(v10);
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::manager_setup_by_deployer(arg0);
    }

    public entry fun setup_hidden_world(arg0: &mut 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::DeployerCap, arg1: 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::HiddenWorldCapability, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = HiddenWorldConfig{
            is_active               : false,
            max_active_duration     : arg2,
            turn_duration           : arg3,
            expiry_penalty_pct      : arg4,
            min_sui_bet_amt         : arg5,
            max_sui_bet_amt         : arg6,
            session_health          : arg7,
            session_energy          : arg8,
            min_dragon_dust_chance  : arg9,
            max_dragon_dust_chance  : arg10,
            half_life               : arg11,
            health_pct_to_emit_dust : arg12,
            max_capability_increase : arg13,
            max_power_pct           : arg14,
        };
        let v1 = HiddenWorld{
            id                      : 0x2::object::new(arg15),
            cap                     : arg1,
            sui_pool                : 0x2::balance::zero<0x2::sui::SUI>(),
            config                  : v0,
            avg_quests_played       : 0,
            avg_dragon_dust_emitted : 0,
            total_quests_count      : 0,
            hidden_bees             : 0x2::linked_table::new<u64, HiddenMysticalBee>(arg15),
            hidden_bees_list        : 0x2::linked_table::new<u64, vector<u64>>(arg15),
            list_count              : 0,
            trainer_sessions        : 0x2::linked_table::new<address, TrainerSession>(arg15),
            active_trainers         : 0x2::linked_table::new<address, QuestRequest>(arg15),
            active_trainers_list    : 0x2::linked_table::new<u64, address>(arg15),
            active_trainers_indexes : 0x1::vector::empty<u64>(),
            p2p_quests              : 0x2::linked_table::new<0x1::string::String, P2pGameSession>(arg15),
            bees_to_collect         : 0x2::linked_table::new<address, vector<MysticalBee>>(arg15),
            dragon_dust             : 0x2::linked_table::new<u64, DragonDust>(arg15),
            module_version          : 0,
        };
        0x2::transfer::share_object<HiddenWorld>(v1);
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::hidden_world_setup_by_deployer(arg0);
    }

    public fun store_exists_for_bee(arg0: &MysticalBee, arg1: 0x1::string::String) : bool {
        0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, arg1)
    }

    public fun switch_trading_enabled(arg0: &mut 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::DeployerCap, arg1: &mut YieldFarm, arg2: bool) {
        arg1.trading_enabled = arg2;
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

    public fun trainer_active_for_quest(arg0: &0x2::clock::Clock, arg1: &mut HiddenWorld, arg2: &mut BeesManager, arg3: &mut DragonTrainer, arg4: u64, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: bool, arg8: 0x1::option::Option<address>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 1079);
        let v0 = 0x2::object::uid_to_address(&arg3.id);
        assert!(arg1.config.is_active, 1204);
        if (!0x2::linked_table::contains<address, TrainerSession>(&arg1.trainer_sessions, v0)) {
            0x2::linked_table::push_back<address, TrainerSession>(&mut arg1.trainer_sessions, v0, create_trainer_session(v0));
        };
        let v1 = 0x2::linked_table::borrow_mut<address, TrainerSession>(&mut arg1.trainer_sessions, v0);
        assert!(v1.state == 0, 1200);
        let v2 = withdraw_bee_from_trainer(arg2, arg3, arg4, 0x2::object::uid_to_address(&arg1.id));
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg5);
        assert!(v2.hive_energy >= arg1.config.session_energy && v2.honey_health >= arg1.config.session_health, 1205);
        assert!(arg6 <= arg1.config.max_sui_bet_amt && arg6 >= arg1.config.min_sui_bet_amt, 1207);
        let v4 = QuestRequest{
            timestamp    : 0x2::clock::timestamp_ms(arg0),
            version      : arg4,
            mystical_bee : v2,
            sui_bet      : 0x2::balance::split<0x2::sui::SUI>(&mut v3, arg6),
            player_only  : arg7,
            with_trainer : arg8,
            active_index : 0,
        };
        v1.state = 1;
        if (arg7 && 0x1::option::is_none<address>(&arg8)) {
            let v5 = 0x1::vector::length<u64>(&arg1.active_trainers_indexes);
            0x1::vector::push_back<u64>(&mut arg1.active_trainers_indexes, v5);
            0x2::linked_table::push_back<u64, address>(&mut arg1.active_trainers_list, v5, v0);
            v4.active_index = v5;
        };
        let v6 = TrainerActiveForQuest{
            trainer_address : v0,
            version         : arg4,
            sui_bet         : arg6,
            player_only     : arg7,
            with_trainer    : arg8,
            active_index    : v4.active_index,
        };
        0x2::event::emit<TrainerActiveForQuest>(v6);
        0x2::linked_table::push_back<address, QuestRequest>(&mut arg1.active_trainers, v0, v4);
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v3, 0x2::tx_context::sender(arg9), arg9);
    }

    public entry fun transfer_bee_to_trainer(arg0: &mut BeesManager, arg1: &mut DragonTrainer, arg2: address, arg3: u64) {
        let v0 = 0x2::object::uid_to_address(&arg0.id);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        let v2 = withdraw_bee_from_trainer(arg0, arg1, arg3, v0);
        let v3 = v2.version;
        let v4 = BeeInFlight{
            mystical_bee   : v2,
            transferred_by : v1,
            recepient      : arg2,
        };
        0x2::linked_table::push_back<u64, BeeInFlight>(&mut arg0.bee_transfers.custodied_bees, v3, v4);
        0x1::vector::push_back<u64>(0x2::linked_table::borrow_mut<address, vector<u64>>(&mut arg0.bee_transfers.incoming_boxes, arg2), v3);
        0x1::vector::push_back<u64>(0x2::linked_table::borrow_mut<address, vector<u64>>(&mut arg0.bee_transfers.outgoing_boxes, v1), v3);
        let v5 = BeeTransferInitiated{
            version        : v3,
            transferred_by : v1,
            recepient      : arg2,
        };
        0x2::event::emit<BeeTransferInitiated>(v5);
    }

    public fun transfer_hive_treasury_funds(arg0: &0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::DragonDaoCapability, arg1: &mut BeesManager, arg2: u64) : 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE> {
        assert!(arg1.module_version == 0, 1079);
        assert!(0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&arg1.hive_treasury) >= arg2, 1145);
        let v0 = HiveWithdrawnFromTreasury{hive_withdrawn: arg2};
        0x2::event::emit<HiveWithdrawnFromTreasury>(v0);
        0x2::balance::split<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut arg1.hive_treasury, arg2)
    }

    public fun transfer_honey_via_dragon_school(arg0: &mut DragonSchool, arg1: &mut DragonTrainer, arg2: u64) {
        0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut arg1.available_honey, 0x2::balance::split<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut arg0.available_honey, arg2));
        if (arg2 > 0) {
            let v0 = HoneyTransferredToProfile{
                from_username           : arg0.username,
                from_dragon_school_addr : 0x2::object::uid_to_address(&arg0.id),
                to_username             : arg1.username,
                to_trainer_addr         : 0x2::object::uid_to_address(&arg1.id),
                honey_to_transfer       : arg2,
            };
            0x2::event::emit<HoneyTransferredToProfile>(v0);
        };
    }

    fun u64_to_ascii(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            let v1 = arg0 % 10;
            arg0 = arg0 / 10;
            0x1::vector::push_back<u8>(&mut v0, (v1 as u8) + 48);
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public entry fun unfollow_trainer(arg0: &mut HiveGraph, arg1: &mut DragonTrainer, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::uid_to_address(&arg1.id);
        let v1 = 0x2::linked_table::borrow_mut<address, 0x2::linked_table::LinkedTable<address, bool>>(&mut arg0.following_list, v0);
        let v2 = 0x2::linked_table::borrow_mut<address, 0x2::linked_table::LinkedTable<address, bool>>(&mut arg0.followers_list, arg2);
        if (!0x2::linked_table::contains<address, bool>(v1, arg2)) {
            return
        };
        0x2::linked_table::remove<address, bool>(v1, arg2);
        0x2::linked_table::remove<address, bool>(v2, v0);
        let v3 = ExitHiveOfProfile{
            follower_trainer_addr   : v0,
            unfollowed_trainer_addr : arg2,
            follower_username       : 0x1::string::from_ascii(arg1.username),
        };
        0x2::event::emit<ExitHiveOfProfile>(v3);
    }

    public fun unlock_hive_from_bee(arg0: &0x2::clock::Clock, arg1: &mut 0x2::token::TokenPolicy<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg2: &0x2::token::TokenPolicyCap<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg3: &mut YieldFarm, arg4: &mut DragonTrainer, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg4.module_version == 0, 1079);
        let v0 = 0x2::linked_table::borrow_mut<u64, MysticalBee>(&mut arg4.owned_bees, arg5);
        let (v1, v2) = internal_unlock_hive_from_bee(arg0, arg3, v0);
        if (arg3.trading_enabled) {
            0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::coin_helper::destroy_or_transfer_balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(v1, 0x2::tx_context::sender(arg6), arg6);
            0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::transfer_honey_balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(arg1, arg2, v2, 0x2::tx_context::sender(arg6), arg6);
        } else {
            let v3 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, LockedDegenHiveAssets>(&mut arg4.id, 0x1::string::utf8(b"LOCKED_DEGEN_HIVE_ASSETS"));
            0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut v3.hive_locked, v1);
            0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut v3.honey_locked, v2);
        };
    }

    public entry fun unprocess_breeding_request(arg0: &GenesisBeesUploaderCapability, arg1: &mut BeesManager, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::linked_table::borrow_mut<u64, BeeEgg>(&mut 0x2::linked_table::borrow_mut<u64, BeeHive>(&mut arg1.bee_hives, arg2).incubating_eggs, arg3);
        assert!(0x2::linked_table::length<u64, 0x1::string::String>(&v0.dragon_bee_egg.appearance) > 0, 1157);
        while (0x2::linked_table::length<u64, 0x1::string::String>(&v0.dragon_bee_egg.appearance) > 0) {
            let (_, _) = 0x2::linked_table::pop_back<u64, 0x1::string::String>(&mut v0.dragon_bee_egg.appearance);
        };
        v0.is_processed = false;
        let v3 = BreedingRequestUnprocessed{
            queen_version : arg2,
            stinger_index : arg3,
        };
        0x2::event::emit<BreedingRequestUnprocessed>(v3);
    }

    fun update_bee_ownership(arg0: &mut BeesManager, arg1: u64, arg2: address) {
        if (0x2::linked_table::contains<u64, address>(&arg0.bees_tracker.bees_to_owner_map, arg1)) {
            *0x2::linked_table::borrow_mut<u64, address>(&mut arg0.bees_tracker.bees_to_owner_map, arg1) = arg2;
        } else {
            0x2::linked_table::push_back<u64, address>(&mut arg0.bees_tracker.bees_to_owner_map, arg1, arg2);
        };
        let v0 = BeeOwnershipUpdated{
            version   : arg1,
            new_owner : arg2,
        };
        0x2::event::emit<BeeOwnershipUpdated>(v0);
    }

    public fun update_bees_manager_config(arg0: &0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::DragonDaoCapability, arg1: &mut BeesManager, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        assert!(arg1.module_version == 0, 1079);
        if (arg2 > 0) {
            assert!(5 <= arg2 && 500 >= arg2, 1082);
            arg1.configuration.max_bids_per_bee = arg2;
        };
        if (arg3 > 0) {
            arg1.configuration.min_bid_amt = arg3;
        };
        if (arg4 > 0) {
            assert!(0 <= arg4 && 50000000000 >= arg4, 1080);
            arg1.configuration.trainer_onboarding_fee = arg4;
        };
        if (arg5 > 0) {
            assert!(1000000 <= arg5 && 1000000000 >= arg5, 1080);
            arg1.configuration.mutation_fee = arg5;
        };
        let v0 = ManagerConfigUpdated{
            max_bids_per_bee       : arg1.configuration.max_bids_per_bee,
            min_bid_amt            : arg1.configuration.min_bid_amt,
            trainer_onboarding_fee : arg1.configuration.trainer_onboarding_fee,
            mutation_fee           : arg1.configuration.mutation_fee,
        };
        0x2::event::emit<ManagerConfigUpdated>(v0);
    }

    public fun update_capability_in_bee_manager(arg0: &GenesisBeesUploaderCapability, arg1: &mut BeesManager, arg2: u64, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = 0x2::table::borrow_mut<u64, DragonEggsBasket>(&mut arg1.dragon_eggs_basket, 420);
        let v1 = if (!0x2::linked_table::contains<u64, CapabilityState>(&v0.capabilities, arg2)) {
            CapabilityState{cap_type: arg3, health_impact_pct: arg4, energy_cost_pct: arg5, attempts: arg6, cooldown: arg7, next_use_ts: 0, base_attempts: arg8}
        } else {
            let v1 = 0x2::linked_table::remove<u64, CapabilityState>(&mut v0.capabilities, arg2);
            v1.cap_type = arg3;
            v1.health_impact_pct = arg4;
            v1.energy_cost_pct = arg5;
            v1.attempts = arg6;
            v1.cooldown = arg7;
            v1.base_attempts = arg8;
            v1
        };
        0x2::linked_table::push_back<u64, CapabilityState>(&mut v0.capabilities, arg2, v1);
        let v2 = BeeCapabilityUpdated{
            spot              : arg2,
            cap_type          : arg3,
            health_impact_pct : arg4,
            energy_cost_pct   : arg5,
            attempts          : arg6,
            cooldown          : arg7,
            base_attempts     : arg8,
        };
        0x2::event::emit<BeeCapabilityUpdated>(v2);
    }

    public entry fun update_dna_for_dragon_egg(arg0: &GenesisBeesUploaderCapability, arg1: &mut BeesManager, arg2: u64, arg3: u256, arg4: vector<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 1079);
        let v0 = 0x2::table::borrow_mut<u64, DragonEggsBasket>(&mut arg1.dragon_eggs_basket, 420);
        assert!(0x1::vector::contains<u64>(&v0.bees_indexes, &arg2), 1156);
        *0x2::linked_table::borrow_mut<u64, u256>(&mut v0.genesis_genes_list, arg2) = arg3;
        let v1 = 0;
        let v2 = 0x2::linked_table::new<u64, 0x1::string::String>(arg5);
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg4)) {
            0x2::linked_table::push_back<u64, 0x1::string::String>(&mut v2, v1, *0x1::vector::borrow<0x1::string::String>(&arg4, v1));
            v1 = v1 + 1;
        };
        0x2::linked_table::drop<u64, 0x1::string::String>(0x2::linked_table::remove<u64, 0x2::linked_table::LinkedTable<u64, 0x1::string::String>>(&mut v0.images_list, arg2));
        0x2::linked_table::push_back<u64, 0x2::linked_table::LinkedTable<u64, 0x1::string::String>>(&mut v0.images_list, arg2, v2);
        let v3 = BeeUpdatedInGenesisBasket{
            index : arg2,
            gene  : arg3,
            img   : arg4,
        };
        0x2::event::emit<BeeUpdatedInGenesisBasket>(v3);
    }

    public fun update_ema_quests_played(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (1000000 as u256);
        let v1 = (arg1 as u256) * v0;
        let v2 = 0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::math::mul_div_u256(0xe4d80fb4983dcf39d24bd2742442fcc3ee757d2e22c458fbf4b5a9e95201ff27::curved_math::halfpow(v1, (arg2 as u256), v0), (v0 as u256), 1000000000000000000);
        (((v1 * v2 + (arg0 as u256) * v0 * (v0 - v2)) / v0) as u64)
    }

    fun update_global_mystic_power(arg0: &0x2::clock::Clock, arg1: &mut YieldFarm, arg2: &mut MysticalBee, arg3: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg4: 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>, arg5: u64, arg6: bool, arg7: bool) : (0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>) {
        let (v0, v1) = claim_gov_yield(arg1, arg2);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::clock::timestamp_ms(arg0);
        lock_honey_with_bee(arg1, arg2, arg3);
        if (arg7) {
            let v5 = withdraw_honey_from_bee(arg1, arg2);
            0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut v2, v5);
        };
        if (0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&arg4) > 0) {
            lock_hive_with_bee(v4, arg1, arg2, arg4, arg5);
        } else {
            0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut v3, arg4);
        };
        if (0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&arg2.nectar.hive_locked) > 0 && arg6) {
            0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut v3, withdraw_hive_from_bee(v4, arg1, arg2, arg7));
        };
        (v2, v3)
    }

    public fun update_hidden_world_params(arg0: &0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::DragonDaoCapability, arg1: &mut HiddenWorld, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64) {
        assert!(arg1.module_version == 0, 1079);
        arg1.config.is_active = arg2;
        if (arg3 > 0) {
            arg1.config.max_active_duration = arg3;
        };
        if (arg4 > 0) {
            arg1.config.turn_duration = arg4;
        };
        if (arg5 > 0) {
            arg1.config.expiry_penalty_pct = arg5;
        };
        if (arg6 > 0) {
            arg1.config.min_sui_bet_amt = arg6;
        };
        if (arg7 > 0) {
            arg1.config.max_sui_bet_amt = arg7;
        };
        if (arg8 > 0) {
            arg1.config.session_health = arg8;
        };
        if (arg9 > 0) {
            arg1.config.session_energy = arg9;
        };
        if (arg10 > 0) {
            arg1.config.min_dragon_dust_chance = arg10;
        };
        if (arg11 > 0) {
            arg1.config.max_dragon_dust_chance = arg11;
        };
        if (arg12 > 0) {
            arg1.config.half_life = arg12;
        };
        if (arg13 > 0) {
            arg1.config.health_pct_to_emit_dust = arg13;
        };
        if (arg14 > 0) {
            arg1.config.max_capability_increase = arg14;
        };
        if (arg15 > 0) {
            arg1.config.max_power_pct = arg15;
        };
    }

    public fun update_hive_twap_info(arg0: &TwapUpdateCap, arg1: &0x2::clock::Clock, arg2: &mut HiveGraph, arg3: u256, arg4: u256, arg5: u256) {
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

    public fun update_inscription(arg0: &BeesManager, arg1: &mut YieldFarm, arg2: &mut DragonTrainer, arg3: 0x2::coin::Coin<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: &mut 0x2::tx_context::TxContext) {
        increment_global_yield_indexes(arg1);
        let v0 = arg0.configuration.mutation_fee;
        let v1 = 0x2::coin::into_balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(arg3);
        assert!(v0 <= 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&v1), 1122);
        deposit_hive_for_distribution(arg1, 0x2::balance::split<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut v1, v0));
        if (0x2::linked_table::length<u64, 0x1::string::String>(&arg2.inscription.base64) > 0) {
            while (0x2::linked_table::length<u64, 0x1::string::String>(&arg2.inscription.base64) > 0) {
                let (_, _) = 0x2::linked_table::pop_back<u64, 0x1::string::String>(&mut arg2.inscription.base64);
            };
        };
        arg2.inscription.format = arg4;
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x1::string::String>(&arg5)) {
            0x2::linked_table::push_back<u64, 0x1::string::String>(&mut arg2.inscription.base64, v4, *0x1::vector::borrow<0x1::string::String>(&arg5, v4));
            v4 = v4 + 1;
        };
        let v5 = InscriptionSetForProfile{
            profile_addr : 0x2::object::uid_to_address(&arg2.id),
            username     : 0x1::string::from_ascii(arg2.username),
            format       : arg4,
            base64       : arg5,
        };
        0x2::event::emit<InscriptionSetForProfile>(v5);
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::coin_helper::destroy_or_transfer_balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(v1, 0x2::tx_context::sender(arg6), arg6);
    }

    public entry fun update_listing(arg0: &0x2::clock::Clock, arg1: &BeesManager, arg2: &mut MarketPlace, arg3: &mut DragonTrainer, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        let v0 = if (arg1.module_version == 0) {
            if (arg2.module_version == 0) {
                arg3.module_version == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1079);
        let v1 = 0x2::clock::timestamp_ms(arg0);
        assert!(0x2::linked_table::contains<u64, ListingRecord>(&arg3.listing_records, arg4), 1037);
        let v2 = 0x2::linked_table::borrow_mut<u64, Listing>(&mut arg2.active_listings, arg4);
        let v3 = 0x2::linked_table::borrow_mut<u64, ListingRecord>(&mut arg3.listing_records, arg4);
        assert!(v2.expiration_sec > v1, 1032);
        if (arg5 != 0) {
            assert!(arg5 >= arg1.configuration.min_bid_amt, 1040);
            v2.min_price = arg5;
            v3.min_price = arg5;
        };
        if (arg6 != 0) {
            assert!(arg6 > v1 && arg6 - v1 < 7776000000, 1030);
            v2.expiration_sec = arg6;
            v3.expiration_sec = arg6;
        };
        let v4 = ListingUpdated{
            listed_by_trainer : v2.listed_by_trainer,
            version           : arg4,
            min_price         : v2.min_price,
            expiration_sec    : v2.expiration_sec,
        };
        0x2::event::emit<ListingUpdated>(v4);
    }

    public fun update_name_of_bee(arg0: &mut DegenHiveMapStore, arg1: &mut DragonTrainer, arg2: u64, arg3: 0x1::string::String) {
        assert!(is_valid_bee_name(arg3), 1084);
        assert!(!0x2::linked_table::contains<0x1::string::String, u64>(&arg0.bee_name_to_version_mapping, arg3), 1214);
        let v0 = 0x2::linked_table::borrow_mut<u64, MysticalBee>(&mut arg1.owned_bees, arg2);
        let v1 = v0.name;
        if (v1 != 0x1::string::utf8(b"Baby Dragon-Bee") && 0x2::linked_table::contains<0x1::string::String, u64>(&arg0.bee_name_to_version_mapping, v1)) {
            0x2::linked_table::remove<0x1::string::String, u64>(&mut arg0.bee_name_to_version_mapping, v1);
        };
        v0.name = arg3;
        0x2::linked_table::push_back<0x1::string::String, u64>(&mut arg0.bee_name_to_version_mapping, arg3, arg2);
        let v2 = MysticalBeeRenamed{
            trainer_addr : 0x2::object::uid_to_address(&arg1.id),
            version      : arg2,
            new_bee_name : arg3,
        };
        0x2::event::emit<MysticalBeeRenamed>(v2);
    }

    fun update_pricing_for_breeding(arg0: &mut BeesManager, arg1: &MysticalBee, arg2: bool, arg3: u64, arg4: u64) {
        let v0 = 0x2::linked_table::borrow_mut<u64, BeeHive>(&mut arg0.bee_hives, arg1.version);
        v0.is_active = arg2;
        v0.base_price = arg3;
        v0.curve_a = arg4;
        let v1 = PricingUpdatedForBreeding{
            queen_version : arg1.version,
            is_active     : arg2,
            base_price    : arg3,
            curve_a       : arg4,
        };
        0x2::event::emit<PricingUpdatedForBreeding>(v1);
    }

    public entry fun update_pricing_for_genesis_mint(arg0: &GenesisBeesUploaderCapability, arg1: &mut BeesManager, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<u64, DragonEggsBasket>(&mut arg1.dragon_eggs_basket, 420);
        v0.start_time = arg2;
        v0.base_price = arg3;
        v0.curve_a = arg4;
        v0.per_user_limit = arg5;
    }

    public fun update_royalty(arg0: &0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::DragonDaoCapability, arg1: &mut BeesManager, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        assert!(arg1.module_version == 0, 1079);
        if (arg2 > 0) {
            assert!(1 <= arg2 && arg2 <= 7, 1035);
            arg1.configuration.royalty.numerator = arg2;
        };
        if (arg3 > 0) {
            assert!(arg3 <= 20, 1174);
            arg1.configuration.royalty.gov_yield_pct = arg3;
        };
        if (arg4 > 0) {
            assert!(arg4 <= 50, 1175);
            arg1.configuration.royalty.queen_pct = arg4;
        };
        if (arg5 > 0) {
            assert!(1 <= arg5 && arg5 <= 15, 1176);
            arg1.configuration.breeding_royalty.platform_fees_pct = arg5;
        };
        if (arg6 > 0) {
            assert!(arg6 <= 15, 1177);
            arg1.configuration.breeding_royalty.gov_yield_pct = arg6;
        };
        if (arg8 > 0) {
            arg1.configuration.min_energy_to_hatch = arg8;
        };
        if (arg9 > 0) {
            arg1.configuration.min_health_to_hatch = arg9;
        };
        if (arg7 > 0) {
            assert!(arg7 <= 15, 1178);
            arg1.configuration.breeding_royalty.treasury_pct = arg7;
        };
        let v0 = RoyaltyUpdated{
            royalty_num                : arg1.configuration.royalty.numerator,
            gov_yield_pct              : arg1.configuration.royalty.gov_yield_pct,
            queen_pct                  : arg1.configuration.royalty.queen_pct,
            breeding_platform_fees_pct : arg1.configuration.breeding_royalty.platform_fees_pct,
            breeding_gov_yield_pct     : arg1.configuration.breeding_royalty.gov_yield_pct,
            breeding_treasury_pct      : arg1.configuration.breeding_royalty.treasury_pct,
        };
        0x2::event::emit<RoyaltyUpdated>(v0);
    }

    public fun update_username(arg0: &BeesManager, arg1: &mut DegenHiveMapStore, arg2: &mut YieldFarm, arg3: &mut DragonTrainer, arg4: 0x2::coin::Coin<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::to_ascii(arg5);
        let v1 = to_lowercase(v0);
        assert!(is_valid_trainer_name(arg5), 1084);
        assert!(!0x2::linked_table::contains<0x1::ascii::String, address>(&arg1.username_to_trainer_mapping, v1), 1127);
        increment_global_yield_indexes(arg2);
        let v2 = arg0.configuration.mutation_fee;
        let v3 = 0x2::coin::into_balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(arg4);
        assert!(v2 <= 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&v3), 1122);
        deposit_hive_for_distribution(arg2, 0x2::balance::split<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut v3, v2));
        let v4 = arg3.username;
        0x2::linked_table::remove<0x1::ascii::String, address>(&mut arg1.username_to_trainer_mapping, to_lowercase(v4));
        arg3.username = v0;
        0x2::linked_table::push_back<0x1::ascii::String, address>(&mut arg1.username_to_trainer_mapping, v1, 0x2::object::uid_to_address(&arg3.id));
        let v5 = UserNameUpdated{
            profile_addr  : 0x2::object::uid_to_address(&arg3.id),
            prev_username : 0x1::string::from_ascii(v4),
            new_username  : arg5,
        };
        0x2::event::emit<UserNameUpdated>(v5);
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::coin_helper::destroy_or_transfer_balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(v3, 0x2::tx_context::sender(arg6), arg6);
    }

    fun use_power_if_can(arg0: &mut CapabilityState, arg1: u64) : bool {
        if (arg0.next_use_ts > arg1 || arg0.attempts == 0) {
            return false
        };
        arg0.attempts = arg0.attempts - 1;
        if (arg0.attempts == 0) {
            arg0.next_use_ts = arg1 + arg0.cooldown;
            arg0.attempts = arg0.base_attempts;
        };
        true
    }

    public fun validate_if_can_beed(arg0: &0x2::clock::Clock, arg1: &BeesManager, arg2: address, arg3: u64, arg4: u64, arg5: &MysticalBee) : (bool, u64, u64) {
        if ((0xbe7aee0c1e79fee9b7478821a5c3eab28ade3c513b0c7a027990e0adabeb5ca8::beescience::get_family_type(arg5.genes) as u64) != arg4) {
            return (false, 0, 0)
        };
        if (!isReadyToBreed(arg0, arg5)) {
            return (false, 0, 1)
        };
        if (!0x2::linked_table::contains<u64, BeeHive>(&arg1.bee_hives, arg3)) {
            return (false, 0, 2)
        };
        let v0 = 0x2::linked_table::borrow<u64, BeeHive>(&arg1.bee_hives, arg3);
        let v1 = v0.queenBirthInfo;
        if (arg5.birth_certificate.generation == 0) {
            return (true, 0, 0)
        };
        let v2 = if (0x2::linked_table::contains<u64, u64>(&v0.friends_list, arg5.version)) {
            *0x2::linked_table::borrow<u64, u64>(&v0.friends_list, arg5.version)
        } else {
            0xbe7aee0c1e79fee9b7478821a5c3eab28ade3c513b0c7a027990e0adabeb5ca8::beescience::compute_gene_price(v0.base_price, v0.curve_a, v0.eggs_incubated)
        };
        let v3 = 0x1::option::borrow<address>(&arg5.birth_certificate.queenId);
        let v4 = 0x1::option::borrow<address>(&arg5.birth_certificate.stingerId);
        if (v3 == &arg2 || v4 == &arg2) {
            return (false, 0, 3)
        };
        if (v1.generation != 0) {
            let v5 = *0x1::option::borrow<address>(&v1.queenId);
            let v6 = if (v3 == &v5) {
                true
            } else {
                let v7 = *0x1::option::borrow<address>(&v1.stingerId);
                v3 == &v7
            };
            if (v6) {
                return (false, 0, 4)
            };
            let v8 = *0x1::option::borrow<address>(&v1.queenId);
            let v9 = if (v4 == &v8) {
                true
            } else {
                let v10 = *0x1::option::borrow<address>(&v1.stingerId);
                v4 == &v10
            };
            if (v9) {
                return (false, 0, 4)
            };
        };
        (true, v2, 0)
    }

    public fun validate_if_can_beed_for_owner(arg0: &0x2::clock::Clock, arg1: &BeesManager, arg2: address, arg3: u64, arg4: u64, arg5: &DragonTrainer, arg6: u64) : (bool, u64, u64) {
        validate_if_can_beed(arg0, arg1, arg2, arg3, arg4, 0x2::linked_table::borrow<u64, MysticalBee>(&arg5.owned_bees, arg6))
    }

    public fun whitelist_user_for_genesis_mint(arg0: &GenesisBeesUploaderCapability, arg1: &mut BeesManager, arg2: address, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<u64, DragonEggsBasket>(&mut arg1.dragon_eggs_basket, 420);
        0x2::linked_table::push_back<address, u64>(&mut v0.whitelist_trainers_pricing, arg2, arg3);
        0x2::linked_table::push_back<address, u64>(&mut v0.whitelist_trainers_availability, arg2, arg4);
        let v1 = UserWhitelistedForGenesisMint{
            user_addr  : arg2,
            mint_price : arg3,
        };
        0x2::event::emit<UserWhitelistedForGenesisMint>(v1);
    }

    public fun withdraw_bee_for_food(arg0: &0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::yield_flow::DragonFoodCapability, arg1: &mut BeesManager, arg2: &mut DragonTrainer, arg3: u64, arg4: address) : MysticalBee {
        let v0 = 0x2::object::uid_to_address(&arg2.id);
        let v1 = withdraw_bee_from_trainer(arg1, arg2, arg3, v0);
        0x2::linked_table::push_back<u64, address>(&mut arg2.locked_bees, v1.version, arg4);
        v1
    }

    fun withdraw_bee_from_trainer(arg0: &mut BeesManager, arg1: &mut DragonTrainer, arg2: u64, arg3: address) : MysticalBee {
        assert!(0x2::linked_table::contains<u64, MysticalBee>(&arg1.owned_bees, arg2), 1024);
        update_bee_ownership(arg0, arg2, arg3);
        0x2::linked_table::remove<u64, MysticalBee>(&mut arg1.owned_bees, arg2)
    }

    public fun withdraw_funds_from_trainer(arg0: &mut DragonTrainer, arg1: &mut 0x2::token::TokenPolicy<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg2: &0x2::token::TokenPolicyCap<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg3: &YieldFarm, arg4: bool, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = 0x2::balance::zero<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>();
        if (arg4) {
            0x2::balance::join<0x2::sui::SUI>(&mut v0, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.available_sui));
        };
        if (arg5 && arg3.trading_enabled) {
            0x2::balance::join<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut v1, 0x2::balance::withdraw_all<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut arg0.available_honey));
        };
        let v2 = FundsWithdrawnFromProfile{
            profile_addr    : 0x2::object::uid_to_address(&arg0.id),
            username        : arg0.username,
            withdrawn_sui   : 0x2::balance::value<0x2::sui::SUI>(&v0),
            withdrawn_honey : 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&v1),
        };
        0x2::event::emit<FundsWithdrawnFromProfile>(v2);
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::transfer_honey_balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(arg1, arg2, v1, 0x2::tx_context::sender(arg6), arg6);
        v0
    }

    public entry fun withdraw_funds_from_trainer_and_return(arg0: &mut DragonTrainer, arg1: &mut 0x2::token::TokenPolicy<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg2: &0x2::token::TokenPolicyCap<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg3: &YieldFarm, arg4: bool, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_funds_from_trainer(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v0, 0x2::tx_context::sender(arg6), arg6);
    }

    fun withdraw_hive_from_bee(arg0: u64, arg1: &mut YieldFarm, arg2: &mut MysticalBee, arg3: bool) : 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE> {
        if (!arg3) {
            assert!(arg2.nectar.unlock_timestamp < arg0, 1089);
        };
        arg2.nectar.unlock_timestamp = 0;
        arg2.nectar.lockup_weeks = 0;
        let v0 = arg2.nectar.weighted_hive_locked;
        arg2.nectar.weighted_hive_locked = 0;
        arg1.governance_info.total_weighted_hive = arg1.governance_info.total_weighted_hive - v0;
        let v1 = HiveUnlockedFromBee{
            beeId               : 0x2::object::uid_to_address(&arg2.id),
            version             : arg2.version,
            hive_unlocked       : 0x2::balance::value<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&arg2.nectar.hive_locked),
            wHive_decrease      : v0,
            total_weighted_hive : arg1.governance_info.total_weighted_hive,
        };
        0x2::event::emit<HiveUnlockedFromBee>(v1);
        0x2::balance::withdraw_all<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut arg2.nectar.hive_locked)
    }

    fun withdraw_honey_from_bee(arg0: &mut YieldFarm, arg1: &mut MysticalBee) : 0x2::balance::Balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY> {
        arg1.nectar.weighted_honey_locked = 0;
        arg0.governance_info.total_weighted_honey = arg0.governance_info.total_weighted_honey - arg1.nectar.weighted_honey_locked;
        0x2::balance::withdraw_all<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut arg1.nectar.honey_locked)
    }

    public fun withdraw_locked_assets(arg0: &YieldFarm, arg1: &mut DragonTrainer, arg2: &mut 0x2::token::TokenPolicy<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg3: &0x2::token::TokenPolicyCap<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 1079);
        assert!(arg0.trading_enabled, 1210);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, LockedDegenHiveAssets>(&mut arg1.id, 0x1::string::utf8(b"LOCKED_DEGEN_HIVE_ASSETS"));
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::coin_helper::destroy_or_transfer_balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(0x2::balance::withdraw_all<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::hive::HIVE>(&mut v0.hive_locked), 0x2::tx_context::sender(arg4), arg4);
        0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::transfer_honey_balance<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(arg2, arg3, 0x2::balance::withdraw_all<0xdaae9e57b35c357382697984c8ff770dafc06ea60a24659dbc55517f731dcfe9::honey::HONEY>(&mut v0.honey_locked), 0x2::tx_context::sender(arg4), arg4);
    }

    // decompiled from Move bytecode v6
}

