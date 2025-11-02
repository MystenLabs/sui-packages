module 0x305bb2dfc1cd4369675e27316f0abc8be5ece8cf06851922cb8ff2f8d05a6261::gbz_dynamic {
    struct GBZ_DYNAMIC has drop {
        dummy_field: bool,
    }

    struct ProvenanceEntry has copy, drop, store {
        owner: address,
        timestamp: u64,
        sale_price: u64,
    }

    struct Attribute has copy, drop, store {
        attribute_type: u8,
        points: u8,
    }

    struct Name has copy, drop, store {
        is_og_title: bool,
        full_name: 0x1::string::String,
        name_rarity: 0x1::string::String,
    }

    struct ActivityInfo has copy, drop, store {
        last_activity: u64,
        activity_type: u8,
    }

    struct CondemnationInfo has copy, drop, store {
        condemned_by: address,
        condemn_time: u64,
        grace_period_ends: u64,
        original_image_url: 0x1::string::String,
    }

    struct DailyLimit has copy, drop, store {
        date: u64,
        count: u64,
    }

    struct StakeInfo has copy, drop, store {
        owner: address,
        stake_time: u64,
    }

    struct ListingInfo has copy, drop, store {
        marketplace: address,
        list_time: u64,
    }

    struct GBzNFT has store, key {
        id: 0x2::object::UID,
        token_id: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        provenance: vector<ProvenanceEntry>,
        current_owner: address,
        is_condemned: bool,
        bounty_metadata: 0x1::string::String,
        attribute: Attribute,
        generated_name: Name,
    }

    struct CollectionState has key {
        id: 0x2::object::UID,
        total_minted: u64,
        total_burned: u64,
        treasury: address,
        treasury_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        mint_proceeds: 0x2::balance::Balance<0x2::sui::SUI>,
        admin: address,
        current_phase: u8,
        og_list: 0x2::table::Table<address, bool>,
        whitelist: 0x2::table::Table<address, bool>,
        mint_counts: 0x2::table::Table<address, vector<u64>>,
        approved_marketplaces: 0x2::table::Table<address, bool>,
        activity_tracker: 0x2::table::Table<u64, ActivityInfo>,
        condemned_nfts: 0x2::table::Table<u64, CondemnationInfo>,
        daily_condemnations: 0x2::table::Table<address, DailyLimit>,
        staked_nfts: 0x2::table::Table<u64, StakeInfo>,
        user_staked_nfts: 0x2::table::Table<address, vector<u64>>,
        listed_nfts: 0x2::table::Table<u64, ListingInfo>,
        burned_addresses: 0x2::table::Table<u64, bool>,
        permanent_originals: 0x2::table::Table<u64, 0x1::string::String>,
        pvp_enabled: bool,
        bounty_poster_url: 0x1::string::String,
        used_rare_names: 0x2::table::Table<u8, bool>,
        rare_names_used: u8,
        available_token_ids: vector<u64>,
        base_image_url: 0x1::string::String,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RewardPool has key {
        id: 0x2::object::UID,
        claimable_rewards: 0x2::table::Table<address, u64>,
        total_accumulated: u64,
        total_claimed: u64,
        pending_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct GlobalProvenanceTracker has key {
        id: 0x2::object::UID,
        address_stamp_count: 0x2::table::Table<address, u64>,
        total_stamps: u64,
    }

    struct NFTMinted has copy, drop {
        token_id: u64,
        recipient: address,
        name: 0x1::string::String,
        phase: u8,
        price_paid: u64,
    }

    struct NFTBurned has copy, drop {
        token_id: u64,
        owner: address,
        timestamp: u64,
    }

    struct DynamicRoyaltyCollected has copy, drop {
        token_id: u64,
        provenance_count: u64,
        royalty_percentage: u64,
        total_royalty: u64,
        treasury_amount: u64,
        provenance_rewards: u64,
    }

    struct ProvenanceUpdated has copy, drop {
        token_id: u64,
        new_owner: address,
        timestamp: u64,
    }

    struct PhaseChanged has copy, drop {
        old_phase: u8,
        new_phase: u8,
        timestamp: u64,
    }

    struct MarketplaceApprovalChanged has copy, drop {
        marketplace: address,
        approved: bool,
        timestamp: u64,
    }

    struct NFTCondemned has copy, drop {
        token_id: u64,
        condemned_by: address,
        condemn_time: u64,
        grace_period_ends: u64,
        success_rate: u64,
    }

    struct NFTSavedFromCondemnation has copy, drop {
        token_id: u64,
        saved_by: address,
        save_method: u8,
        timestamp: u64,
    }

    struct NFTBurnedDueToCondemnation has copy, drop {
        token_id: u64,
        condemned_by: address,
        burn_time: u64,
    }

    struct ActivityUpdated has copy, drop {
        token_id: u64,
        activity_type: u8,
        timestamp: u64,
    }

    struct PvPToggled has copy, drop {
        enabled: bool,
        timestamp: u64,
    }

    struct NFTStaked has copy, drop {
        token_id: u64,
        owner: address,
        stake_time: u64,
    }

    struct NFTUnstaked has copy, drop {
        token_id: u64,
        owner: address,
        unstake_time: u64,
    }

    struct NFTListed has copy, drop {
        token_id: u64,
        marketplace: address,
        list_time: u64,
    }

    struct NFTDelisted has copy, drop {
        token_id: u64,
        marketplace: address,
        delist_time: u64,
    }

    struct RewardsAccumulated has copy, drop {
        holder: address,
        amount: u64,
        total_claimable: u64,
    }

    struct RewardsClaimed has copy, drop {
        claimer: address,
        amount: u64,
        timestamp: u64,
    }

    struct GlobalStampAdded has copy, drop {
        holder: address,
        new_count: u64,
        total_stamps: u64,
    }

    struct AttributeUpdated has copy, drop {
        token_id: u64,
        old_type: u8,
        old_points: u8,
        new_type: u8,
        new_points: u8,
        updated_by: address,
    }

    struct CondemnationAttemptFailed has copy, drop {
        token_id: u64,
        attempted_by: address,
        success_rate: u64,
        attacker_attribute: u8,
        defender_attribute: u8,
    }

    struct ImageURLUpdated has copy, drop {
        token_id: u64,
        old_image_url: 0x1::string::String,
        new_image_url: 0x1::string::String,
        updated_by: address,
    }

    struct NameUpdated has copy, drop {
        token_id: u64,
        old_name: 0x1::string::String,
        new_name: 0x1::string::String,
        is_og_title: bool,
        updated_by: address,
    }

    struct DynamicRoyaltyRule has copy, drop {
        dummy_field: bool,
    }

    fun accumulate_provenance_rewards(arg0: &mut RewardPool, arg1: &vector<ProvenanceEntry>, arg2: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::balance::Balance<0x2::sui::SUI>) {
        let v0 = 0x1::vector::length<ProvenanceEntry>(arg1);
        if (v0 == 0) {
            return
        };
        assert!(0x2::balance::value<0x2::sui::SUI>(arg2) >= arg3, 28);
        let v1 = 0;
        let v2 = 0;
        while (v1 < v0) {
            let v3 = 0x1::vector::borrow<ProvenanceEntry>(arg1, v0 - 1 - v1);
            let v4 = calculate_weight(v1) * arg3 / calculate_total_weight(v0);
            if (v4 > 0) {
                if (0x2::table::contains<address, u64>(&arg0.claimable_rewards, v3.owner)) {
                    let v5 = 0x2::table::borrow_mut<address, u64>(&mut arg0.claimable_rewards, v3.owner);
                    let v6 = *v5;
                    assert!(v6 <= 18446744073709551615 - v4, 32);
                    *v5 = v6 + v4;
                } else {
                    0x2::table::add<address, u64>(&mut arg0.claimable_rewards, v3.owner, v4);
                };
                0x2::balance::join<0x2::sui::SUI>(&mut arg0.pending_balance, 0x2::balance::split<0x2::sui::SUI>(arg2, v4));
                arg0.total_accumulated = arg0.total_accumulated + v4;
                v2 = v2 + v4;
                let v7 = RewardsAccumulated{
                    holder          : v3.owner,
                    amount          : v4,
                    total_claimable : *0x2::table::borrow<address, u64>(&arg0.claimable_rewards, v3.owner),
                };
                0x2::event::emit<RewardsAccumulated>(v7);
            };
            v1 = v1 + 1;
        };
        let v8 = 0x2::balance::value<0x2::sui::SUI>(arg2);
        if (v8 > 0 && v8 < arg3) {
            0x2::balance::join<0x2::sui::SUI>(arg4, 0x2::balance::split<0x2::sui::SUI>(arg2, v8));
        };
    }

    public entry fun add_approved_marketplace(arg0: &AdminCap, arg1: &mut CollectionState, arg2: address, arg3: &0x2::clock::Clock) {
        0x2::table::add<address, bool>(&mut arg1.approved_marketplaces, arg2, true);
        let v0 = MarketplaceApprovalChanged{
            marketplace : arg2,
            approved    : true,
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MarketplaceApprovalChanged>(v0);
    }

    public entry fun add_to_og_list(arg0: &AdminCap, arg1: &mut CollectionState, arg2: vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (!0x2::table::contains<address, bool>(&arg1.og_list, v1)) {
                0x2::table::add<address, bool>(&mut arg1.og_list, v1, true);
            };
            v0 = v0 + 1;
        };
    }

    public entry fun add_to_whitelist(arg0: &AdminCap, arg1: &mut CollectionState, arg2: vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (!0x2::table::contains<address, bool>(&arg1.whitelist, v1)) {
                0x2::table::add<address, bool>(&mut arg1.whitelist, v1, true);
            };
            v0 = v0 + 1;
        };
    }

    public entry fun admin_gift(arg0: &AdminCap, arg1: &mut CollectionState, arg2: GBzNFT, arg3: address, arg4: &0x2::clock::Clock) {
        transfer_nft_internal(arg1, arg2, arg3, arg4);
    }

    public entry fun admin_update_image_url(arg0: &AdminCap, arg1: &mut GBzNFT, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.image_url = arg2;
        let v0 = ImageURLUpdated{
            token_id      : arg1.token_id,
            old_image_url : arg1.image_url,
            new_image_url : arg2,
            updated_by    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ImageURLUpdated>(v0);
    }

    public entry fun admin_update_name(arg0: &AdminCap, arg1: &mut GBzNFT, arg2: 0x1::string::String, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg3) {
            0x1::string::utf8(b"Rare Street Name")
        } else {
            0x1::string::utf8(b"Regular Name")
        };
        let v1 = Name{
            is_og_title : arg3,
            full_name   : arg2,
            name_rarity : v0,
        };
        arg1.generated_name = v1;
        arg1.name = arg2;
        let v2 = NameUpdated{
            token_id    : arg1.token_id,
            old_name    : arg1.generated_name.full_name,
            new_name    : arg2,
            is_og_title : arg3,
            updated_by  : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<NameUpdated>(v2);
    }

    public fun attribute_type_to_string(arg0: u8) : 0x1::string::String {
        if (arg0 == 1) {
            0x1::string::utf8(b"Anger Issues")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Hood Nerd")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Fashion Killer")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"Gym Rat")
        } else {
            0x1::string::utf8(b"Unknown")
        }
    }

    public entry fun burn(arg0: &mut CollectionState, arg1: GBzNFT, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.current_owner, 6);
        burn_internal(arg0, arg1, arg2, arg3);
    }

    fun burn_internal(arg0: &mut CollectionState, arg1: GBzNFT, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = arg1.token_id;
        if (!0x2::table::contains<u64, bool>(&arg0.burned_addresses, v0)) {
            0x2::table::add<u64, bool>(&mut arg0.burned_addresses, v0, true);
        };
        arg0.total_burned = arg0.total_burned + 1;
        let v1 = NFTBurned{
            token_id  : v0,
            owner     : 0x2::tx_context::sender(arg3),
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<NFTBurned>(v1);
        let GBzNFT {
            id              : v2,
            token_id        : _,
            name            : _,
            description     : _,
            image_url       : _,
            provenance      : _,
            current_owner   : _,
            is_condemned    : _,
            bounty_metadata : _,
            attribute       : _,
            generated_name  : _,
        } = arg1;
        0x2::object::delete(v2);
    }

    public entry fun buy_with_dynamic_royalty(arg0: &mut CollectionState, arg1: &mut RewardPool, arg2: GBzNFT, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = arg2.current_owner;
        let v2 = arg2.token_id;
        assert!(is_marketplace_approved(arg0, v0), 14);
        check_and_enforce_condemnation(arg0, &arg2, 0x2::clock::timestamp_ms(arg5));
        if (0x2::table::contains<u64, ListingInfo>(&arg0.listed_nfts, v2)) {
            0x2::table::remove<u64, ListingInfo>(&mut arg0.listed_nfts, v2);
        };
        let v3 = 0x1::vector::length<ProvenanceEntry>(&arg2.provenance);
        let v4 = if (v3 == 0) {
            0
        } else {
            let v5 = vector[216, 411, 586, 744, 888, 1016, 1131, 1234, 1328, 1412, 1488, 1556, 1617, 1672, 1721, 1766, 1806, 1843, 1876, 1900];
            arg4 * *0x1::vector::borrow<u64>(&v5, v3 - 1) / 10000
        };
        let v6 = arg4 * 100 / 10000;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= arg4 + v6 + v4, 2);
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v7, arg4), arg6), v1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v7, v6));
        if (v4 > 0 && v3 > 0) {
            let v8 = &mut v7;
            let v9 = &mut arg0.treasury_balance;
            accumulate_provenance_rewards(arg1, &arg2.provenance, v8, v4, v9);
        };
        if (0x2::balance::value<0x2::sui::SUI>(&v7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v7, arg6), v0);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v7);
        };
        let v10 = 0x2::clock::timestamp_ms(arg5);
        let v11 = &mut arg2;
        update_provenance(v11, v1, v10, arg4);
        clear_staking_on_transfer(arg0, v2);
        arg2.current_owner = v0;
        update_activity(arg0, v2, 1, v10);
        let v12 = if (v3 == 0) {
            0
        } else {
            let v13 = vector[216, 411, 586, 744, 888, 1016, 1131, 1234, 1328, 1412, 1488, 1556, 1617, 1672, 1721, 1766, 1806, 1843, 1876, 1900];
            *0x1::vector::borrow<u64>(&v13, v3 - 1)
        };
        let v14 = DynamicRoyaltyCollected{
            token_id           : v2,
            provenance_count   : v3,
            royalty_percentage : v12,
            total_royalty      : v6 + v4,
            treasury_amount    : v6,
            provenance_rewards : v4,
        };
        0x2::event::emit<DynamicRoyaltyCollected>(v14);
        let v15 = ProvenanceUpdated{
            token_id  : v2,
            new_owner : v0,
            timestamp : v10,
        };
        0x2::event::emit<ProvenanceUpdated>(v15);
        0x2::transfer::transfer<GBzNFT>(arg2, v0);
    }

    fun bytes_to_u64(arg0: &vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while ((v1 as u64) < 8 && (v1 as u64) < 0x1::vector::length<u8>(arg0)) {
            v0 = v0 | (*0x1::vector::borrow<u8>(arg0, (v1 as u64)) as u64) << (7 - v1) * 8;
            v1 = v1 + 1;
        };
        v0
    }

    fun calculate_burn_success_rate(arg0: &Attribute, arg1: &Attribute) : u64 {
        let v0 = 50;
        let v1 = v0;
        if (arg1.attribute_type == 1) {
            let v2 = (arg1.points as u64) * 30 / (50 as u64);
            if (v0 >= v2) {
                v1 = v0 - v2;
            } else {
                v1 = 0;
            };
        } else if (arg1.attribute_type == 2) {
            v1 = v0 + (arg1.points as u64) * 30 / (50 as u64);
        };
        if (arg0.attribute_type == 1) {
            v1 = v1 + (arg0.points as u64) * 30 / (50 as u64);
        } else if (arg0.attribute_type == 2) {
            let v3 = (arg0.points as u64) * 30 / (50 as u64);
            if (v1 >= v3) {
                v1 = v1 - v3;
            } else {
                v1 = 0;
            };
        };
        if (v1 > 100) {
            v1 = 100;
        };
        v1
    }

    public fun calculate_condemnation_odds(arg0: &GBzNFT, arg1: &GBzNFT) : u64 {
        calculate_burn_success_rate(&arg0.attribute, &arg1.attribute)
    }

    public fun calculate_royalty_for_nft(arg0: &GBzNFT, arg1: u64) : u64 {
        let v0 = 0x1::vector::length<ProvenanceEntry>(&arg0.provenance);
        if (v0 == 0) {
            0
        } else {
            let v2 = vector[216, 411, 586, 744, 888, 1016, 1131, 1234, 1328, 1412, 1488, 1556, 1617, 1672, 1721, 1766, 1806, 1843, 1876, 1900];
            arg1 * *0x1::vector::borrow<u64>(&v2, v0 - 1) / 10000
        }
    }

    fun calculate_total_weight(arg0: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 + calculate_weight(v1);
            v1 = v1 + 1;
        };
        v0
    }

    fun calculate_weight(arg0: u64) : u64 {
        let v0 = 1000;
        let v1 = 0;
        while (v1 < arg0) {
            let v2 = v0 * 900;
            v0 = v2 / 1000;
            v1 = v1 + 1;
        };
        v0
    }

    fun check_and_enforce_condemnation(arg0: &mut CollectionState, arg1: &GBzNFT, arg2: u64) {
        let v0 = arg1.token_id;
        if (!0x2::table::contains<u64, CondemnationInfo>(&arg0.condemned_nfts, v0)) {
            return
        };
        if (arg2 >= 0x2::table::borrow<u64, CondemnationInfo>(&arg0.condemned_nfts, v0).grace_period_ends) {
            abort 29
        };
    }

    fun check_daily_limit(arg0: &mut CollectionState, arg1: address, arg2: u64) : bool {
        let v0 = arg2 / 86400000;
        if (!0x2::table::contains<address, DailyLimit>(&arg0.daily_condemnations, arg1)) {
            let v1 = DailyLimit{
                date  : v0,
                count : 0,
            };
            0x2::table::add<address, DailyLimit>(&mut arg0.daily_condemnations, arg1, v1);
            return true
        };
        let v2 = 0x2::table::borrow_mut<address, DailyLimit>(&mut arg0.daily_condemnations, arg1);
        if (v2.date < v0) {
            v2.date = v0;
            v2.count = 0;
            return true
        };
        v2.count < 1
    }

    public entry fun claim_rewards(arg0: &mut RewardPool, arg1: &CollectionState, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, vector<u64>>(&arg1.user_staked_nfts, v0), 27);
        assert!(0x1::vector::length<u64>(0x2::table::borrow<address, vector<u64>>(&arg1.user_staked_nfts, v0)) > 0, 27);
        assert!(0x2::table::contains<address, u64>(&arg0.claimable_rewards, v0), 26);
        let v1 = *0x2::table::borrow<address, u64>(&arg0.claimable_rewards, v0);
        assert!(v1 > 0, 26);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.pending_balance) >= v1, 28);
        0x2::table::remove<address, u64>(&mut arg0.claimable_rewards, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pending_balance, v1), arg3), v0);
        arg0.total_claimed = arg0.total_claimed + v1;
        let v2 = RewardsClaimed{
            claimer   : v0,
            amount    : v1,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<RewardsClaimed>(v2);
    }

    fun clear_condemnation_on_transfer(arg0: &mut CollectionState, arg1: &mut GBzNFT, arg2: u64) {
        let v0 = arg1.token_id;
        if (!0x2::table::contains<u64, CondemnationInfo>(&arg0.condemned_nfts, v0)) {
            return
        };
        if (arg2 < 0x2::table::borrow<u64, CondemnationInfo>(&arg0.condemned_nfts, v0).grace_period_ends) {
            let v1 = 0x2::table::remove<u64, CondemnationInfo>(&mut arg0.condemned_nfts, v0);
            arg1.is_condemned = false;
            arg1.image_url = v1.original_image_url;
            arg1.bounty_metadata = 0x1::string::utf8(b"");
            let v2 = NFTSavedFromCondemnation{
                token_id    : v0,
                saved_by    : arg1.current_owner,
                save_method : 2,
                timestamp   : arg2,
            };
            0x2::event::emit<NFTSavedFromCondemnation>(v2);
        };
    }

    fun clear_staking_on_transfer(arg0: &mut CollectionState, arg1: u64) {
        if (0x2::table::contains<u64, StakeInfo>(&arg0.staked_nfts, arg1)) {
            let v0 = 0x2::table::remove<u64, StakeInfo>(&mut arg0.staked_nfts, arg1);
            let v1 = v0.owner;
            if (0x2::table::contains<address, vector<u64>>(&arg0.user_staked_nfts, v1)) {
                let v2 = 0x2::table::borrow_mut<address, vector<u64>>(&mut arg0.user_staked_nfts, v1);
                let (v3, v4) = 0x1::vector::index_of<u64>(v2, &arg1);
                if (v3) {
                    0x1::vector::remove<u64>(v2, v4);
                    if (0x1::vector::is_empty<u64>(v2)) {
                        0x1::vector::destroy_empty<u64>(0x2::table::remove<address, vector<u64>>(&mut arg0.user_staked_nfts, v1));
                    };
                };
            };
        };
    }

    public entry fun complete_kiosk_purchase(arg0: &mut CollectionState, arg1: &mut GBzNFT, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = arg1.token_id;
        let v2 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg1.current_owner == arg2, 35);
        assert!(v0 != arg2, 30);
        update_provenance(arg1, arg2, v2, arg3);
        clear_staking_on_transfer(arg0, v1);
        arg1.current_owner = v0;
        update_activity(arg0, v1, 1, v2);
        let v3 = ProvenanceUpdated{
            token_id  : v1,
            new_owner : v0,
            timestamp : v2,
        };
        0x2::event::emit<ProvenanceUpdated>(v3);
    }

    public entry fun condemn_idle_nft(arg0: &mut CollectionState, arg1: GBzNFT, arg2: &mut GBzNFT, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = arg2.token_id;
        assert!(arg0.pvp_enabled, 15);
        assert!(arg1.token_id != v2, 23);
        assert!(check_daily_limit(arg0, v0, v1), 18);
        assert!(is_idle(arg0, v2, v1), 16);
        assert!(!0x2::table::contains<u64, CondemnationInfo>(&arg0.condemned_nfts, v2), 17);
        assert!(!0x2::table::contains<u64, ListingInfo>(&arg0.listed_nfts, v2), 36);
        assert!(!0x2::table::contains<u64, StakeInfo>(&arg0.staked_nfts, v2), 16);
        let v3 = calculate_burn_success_rate(&arg1.attribute, &arg2.attribute);
        let v4 = 0x2::object::new(arg4);
        let v5 = 0x2::object::uid_to_bytes(&v4);
        0x2::object::delete(v4);
        if ((*0x1::vector::borrow<u8>(&v5, 0) as u64) % 101 >= v3) {
            let v6 = CondemnationAttemptFailed{
                token_id           : v2,
                attempted_by       : v0,
                success_rate       : v3,
                attacker_attribute : arg1.attribute.attribute_type,
                defender_attribute : arg2.attribute.attribute_type,
            };
            0x2::event::emit<CondemnationAttemptFailed>(v6);
            burn_internal(arg0, arg1, arg3, arg4);
            abort 39
        };
        burn_internal(arg0, arg1, arg3, arg4);
        let v7 = v1 + 604800000;
        if (!0x2::table::contains<u64, 0x1::string::String>(&arg0.permanent_originals, v2)) {
            0x2::table::add<u64, 0x1::string::String>(&mut arg0.permanent_originals, v2, arg2.image_url);
        };
        let v8 = CondemnationInfo{
            condemned_by       : v0,
            condemn_time       : v1,
            grace_period_ends  : v7,
            original_image_url : *0x2::table::borrow<u64, 0x1::string::String>(&arg0.permanent_originals, v2),
        };
        0x2::table::add<u64, CondemnationInfo>(&mut arg0.condemned_nfts, v2, v8);
        arg2.is_condemned = true;
        if (0x1::string::length(&arg0.bounty_poster_url) > 0) {
            arg2.bounty_metadata = arg0.bounty_poster_url;
        };
        increment_daily_count(arg0, v0);
        let v9 = NFTCondemned{
            token_id          : v2,
            condemned_by      : v0,
            condemn_time      : v1,
            grace_period_ends : v7,
            success_rate      : v3,
        };
        0x2::event::emit<NFTCondemned>(v9);
    }

    public fun current_owner(arg0: &GBzNFT) : address {
        arg0.current_owner
    }

    fun distribute_to_provenance(arg0: &vector<ProvenanceEntry>, arg1: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<ProvenanceEntry>(arg0);
        if (v0 == 0) {
            return
        };
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<ProvenanceEntry>(arg0, v0 - 1 - v1);
            let v3 = calculate_weight(v1) * arg2 / calculate_total_weight(v0);
            if (v3 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(arg1, v3), arg3), v2.owner);
            };
            v1 = v1 + 1;
        };
    }

    fun generate_random_attribute(arg0: &mut 0x2::tx_context::TxContext) : Attribute {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::uid_to_bytes(&v0);
        0x2::object::delete(v0);
        let v2 = (*0x1::vector::borrow<u8>(&v1, 0) as u64) % 100;
        let v3 = if (v2 < 50) {
            1
        } else if (v2 < 50 + 25) {
            3
        } else if (v2 < 50 + 25 + 20) {
            4
        } else {
            2
        };
        Attribute{
            attribute_type : v3,
            points         : (*0x1::vector::borrow<u8>(&v1, 1) as u8) % 51,
        }
    }

    fun generate_random_name(arg0: &mut CollectionState, arg1: &mut 0x2::tx_context::TxContext) : Name {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_bytes(&v0);
        0x2::object::delete(v0);
        if ((*0x1::vector::borrow<u8>(&v1, 0) as u64) % 100 < 10 && arg0.rare_names_used < 150) {
            let v2 = 0;
            let v3 = 0;
            let v4 = false;
            while (v2 < 150 && !v4) {
                let v5 = (*0x1::vector::borrow<u8>(&v1, ((v2 % 30 + 1) as u64)) + v2) % 150;
                if (!0x2::table::contains<u8, bool>(&arg0.used_rare_names, v5)) {
                    v3 = v5;
                    v4 = true;
                };
                v2 = v2 + 1;
            };
            if (v4) {
                0x2::table::add<u8, bool>(&mut arg0.used_rare_names, v3, true);
                arg0.rare_names_used = arg0.rare_names_used + 1;
                return Name{
                    is_og_title : true,
                    full_name   : get_og_title(v3),
                    name_rarity : 0x1::string::utf8(b"Rare Street Name"),
                }
            };
        };
        let v6 = get_first_name((*0x1::vector::borrow<u8>(&v1, 1) as u8) % 155);
        0x1::string::append(&mut v6, 0x1::string::utf8(b" "));
        0x1::string::append(&mut v6, get_last_name((*0x1::vector::borrow<u8>(&v1, 2) as u8) % 67));
        Name{
            is_og_title : false,
            full_name   : v6,
            name_rarity : 0x1::string::utf8(b"Regular Name"),
        }
    }

    public fun get_attribute(arg0: &GBzNFT) : (u8, u8) {
        (arg0.attribute.attribute_type, arg0.attribute.points)
    }

    public fun get_current_phase(arg0: &CollectionState) : u8 {
        arg0.current_phase
    }

    public fun get_eligible_condemnation_targets(arg0: &CollectionState, arg1: u64, arg2: u64) : vector<u64> {
        0x1::vector::empty<u64>()
    }

    fun get_first_name(arg0: u8) : 0x1::string::String {
        if (arg0 < 78) {
            get_first_name_0_77(arg0)
        } else {
            get_first_name_78_154(arg0 - 78)
        }
    }

    fun get_first_name_0_77(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Tyrone")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"DeShawn")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Malik")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Darnell")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"Trevon")
        } else if (arg0 == 5) {
            0x1::string::utf8(b"Jamal")
        } else if (arg0 == 6) {
            0x1::string::utf8(b"Marquise")
        } else if (arg0 == 7) {
            0x1::string::utf8(b"Darius")
        } else if (arg0 == 8) {
            0x1::string::utf8(b"Terrell")
        } else if (arg0 == 9) {
            0x1::string::utf8(b"Kendrick")
        } else if (arg0 == 10) {
            0x1::string::utf8(b"Demetrius")
        } else if (arg0 == 11) {
            0x1::string::utf8(b"Antwan")
        } else if (arg0 == 12) {
            0x1::string::utf8(b"Rashad")
        } else if (arg0 == 13) {
            0x1::string::utf8(b"Devonte")
        } else if (arg0 == 14) {
            0x1::string::utf8(b"Lamont")
        } else if (arg0 == 15) {
            0x1::string::utf8(b"Dontrell")
        } else if (arg0 == 16) {
            0x1::string::utf8(b"Tayvon")
        } else if (arg0 == 17) {
            0x1::string::utf8(b"Jermaine")
        } else if (arg0 == 18) {
            0x1::string::utf8(b"Cornell")
        } else if (arg0 == 19) {
            0x1::string::utf8(b"Maurice")
        } else if (arg0 == 20) {
            0x1::string::utf8(b"Tavon")
        } else if (arg0 == 21) {
            0x1::string::utf8(b"Donnell")
        } else if (arg0 == 22) {
            0x1::string::utf8(b"LaMontae")
        } else if (arg0 == 23) {
            0x1::string::utf8(b"Marquell")
        } else if (arg0 == 24) {
            0x1::string::utf8(b"LeDarius")
        } else if (arg0 == 25) {
            0x1::string::utf8(b"Tremayne")
        } else if (arg0 == 26) {
            0x1::string::utf8(b"Trayvon")
        } else if (arg0 == 27) {
            0x1::string::utf8(b"Demonte")
        } else if (arg0 == 28) {
            0x1::string::utf8(b"LaRon")
        } else if (arg0 == 29) {
            0x1::string::utf8(b"Tyree")
        } else if (arg0 == 30) {
            0x1::string::utf8(b"T'Marion")
        } else if (arg0 == 31) {
            0x1::string::utf8(b"Jayvonte")
        } else if (arg0 == 32) {
            0x1::string::utf8(b"ShaVell")
        } else if (arg0 == 33) {
            0x1::string::utf8(b"KeVonte")
        } else if (arg0 == 34) {
            0x1::string::utf8(b"Riqo")
        } else if (arg0 == 35) {
            0x1::string::utf8(b"LaJuan")
        } else if (arg0 == 36) {
            0x1::string::utf8(b"T'Rell")
        } else if (arg0 == 37) {
            0x1::string::utf8(b"K'Moni")
        } else if (arg0 == 38) {
            0x1::string::utf8(b"Zaevion")
        } else if (arg0 == 39) {
            0x1::string::utf8(b"TruVell")
        } else if (arg0 == 40) {
            0x1::string::utf8(b"Marzelle")
        } else if (arg0 == 41) {
            0x1::string::utf8(b"Vontrell")
        } else if (arg0 == 42) {
            0x1::string::utf8(b"DaeShawn")
        } else if (arg0 == 43) {
            0x1::string::utf8(b"Omario")
        } else if (arg0 == 44) {
            0x1::string::utf8(b"TreVion")
        } else if (arg0 == 45) {
            0x1::string::utf8(b"Quavell")
        } else if (arg0 == 46) {
            0x1::string::utf8(b"Zyrone")
        } else if (arg0 == 47) {
            0x1::string::utf8(b"Draylen")
        } else if (arg0 == 48) {
            0x1::string::utf8(b"Tovion")
        } else if (arg0 == 49) {
            0x1::string::utf8(b"Malvo")
        } else if (arg0 == 50) {
            0x1::string::utf8(b"T'Kell")
        } else if (arg0 == 51) {
            0x1::string::utf8(b"Renoir")
        } else if (arg0 == 52) {
            0x1::string::utf8(b"Jayvontee")
        } else if (arg0 == 53) {
            0x1::string::utf8(b"M'Ricko")
        } else if (arg0 == 54) {
            0x1::string::utf8(b"Lendrix")
        } else if (arg0 == 55) {
            0x1::string::utf8(b"Raqwon")
        } else if (arg0 == 56) {
            0x1::string::utf8(b"Verniq")
        } else if (arg0 == 57) {
            0x1::string::utf8(b"K'Rell")
        } else if (arg0 == 58) {
            0x1::string::utf8(b"Rayshawn")
        } else if (arg0 == 59) {
            0x1::string::utf8(b"DaeQuan")
        } else if (arg0 == 60) {
            0x1::string::utf8(b"Tyrell")
        } else if (arg0 == 61) {
            0x1::string::utf8(b"Tremaine")
        } else if (arg0 == 62) {
            0x1::string::utf8(b"Kentrell")
        } else if (arg0 == 63) {
            0x1::string::utf8(b"Javonte")
        } else if (arg0 == 64) {
            0x1::string::utf8(b"Romello")
        } else if (arg0 == 65) {
            0x1::string::utf8(b"Kareem")
        } else if (arg0 == 66) {
            0x1::string::utf8(b"Raekwon")
        } else if (arg0 == 67) {
            0x1::string::utf8(b"Nasir")
        } else if (arg0 == 68) {
            0x1::string::utf8(b"DeVaughn")
        } else if (arg0 == 69) {
            0x1::string::utf8(b"Tavaris")
        } else if (arg0 == 70) {
            0x1::string::utf8(b"Tyrik")
        } else if (arg0 == 71) {
            0x1::string::utf8(b"DeAndre")
        } else if (arg0 == 72) {
            0x1::string::utf8(b"LaVell")
        } else if (arg0 == 73) {
            0x1::string::utf8(b"JaRell")
        } else if (arg0 == 74) {
            0x1::string::utf8(b"T'Vion")
        } else if (arg0 == 75) {
            0x1::string::utf8(b"Myreon")
        } else if (arg0 == 76) {
            0x1::string::utf8(b"CaVell")
        } else {
            0x1::string::utf8(b"K'Shawn")
        }
    }

    fun get_first_name_78_154(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Riqell")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Drayvon")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Traveon")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Quinton")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"DeMario")
        } else if (arg0 == 5) {
            0x1::string::utf8(b"Darnelle")
        } else if (arg0 == 6) {
            0x1::string::utf8(b"TreShawn")
        } else if (arg0 == 7) {
            0x1::string::utf8(b"Tyvon")
        } else if (arg0 == 8) {
            0x1::string::utf8(b"MoVell")
        } else if (arg0 == 9) {
            0x1::string::utf8(b"JaKell")
        } else if (arg0 == 10) {
            0x1::string::utf8(b"KeShawn")
        } else if (arg0 == 11) {
            0x1::string::utf8(b"DaeRell")
        } else if (arg0 == 12) {
            0x1::string::utf8(b"Jarell")
        } else if (arg0 == 13) {
            0x1::string::utf8(b"K'Riq")
        } else if (arg0 == 14) {
            0x1::string::utf8(b"Omarrion")
        } else if (arg0 == 15) {
            0x1::string::utf8(b"JayRiq")
        } else if (arg0 == 16) {
            0x1::string::utf8(b"LaVontae")
        } else if (arg0 == 17) {
            0x1::string::utf8(b"MaVell")
        } else if (arg0 == 18) {
            0x1::string::utf8(b"DreVion")
        } else if (arg0 == 19) {
            0x1::string::utf8(b"KaVonte")
        } else if (arg0 == 20) {
            0x1::string::utf8(b"TyVell")
        } else if (arg0 == 21) {
            0x1::string::utf8(b"RaVion")
        } else if (arg0 == 22) {
            0x1::string::utf8(b"DreShawn")
        } else if (arg0 == 23) {
            0x1::string::utf8(b"TyVonne")
        } else if (arg0 == 24) {
            0x1::string::utf8(b"ZaRell")
        } else if (arg0 == 25) {
            0x1::string::utf8(b"DeVontre")
        } else if (arg0 == 26) {
            0x1::string::utf8(b"CaShawn")
        } else if (arg0 == 27) {
            0x1::string::utf8(b"DaeMarion")
        } else if (arg0 == 28) {
            0x1::string::utf8(b"T'Velle")
        } else if (arg0 == 29) {
            0x1::string::utf8(b"LaDre")
        } else if (arg0 == 30) {
            0x1::string::utf8(b"Omell")
        } else if (arg0 == 31) {
            0x1::string::utf8(b"ReVonte")
        } else if (arg0 == 32) {
            0x1::string::utf8(b"DaeTrell")
        } else if (arg0 == 33) {
            0x1::string::utf8(b"TyQuon")
        } else if (arg0 == 34) {
            0x1::string::utf8(b"LaShawn")
        } else if (arg0 == 35) {
            0x1::string::utf8(b"MarTrell")
        } else if (arg0 == 36) {
            0x1::string::utf8(b"DeMarrion")
        } else if (arg0 == 37) {
            0x1::string::utf8(b"Quellon")
        } else if (arg0 == 38) {
            0x1::string::utf8(b"JaTrell")
        } else if (arg0 == 39) {
            0x1::string::utf8(b"DaeKell")
        } else if (arg0 == 40) {
            0x1::string::utf8(b"Riqwan")
        } else if (arg0 == 41) {
            0x1::string::utf8(b"T'Riq")
        } else if (arg0 == 42) {
            0x1::string::utf8(b"Drayvontee")
        } else if (arg0 == 43) {
            0x1::string::utf8(b"ZeVonte")
        } else if (arg0 == 44) {
            0x1::string::utf8(b"KaDre")
        } else if (arg0 == 45) {
            0x1::string::utf8(b"Trunell")
        } else if (arg0 == 46) {
            0x1::string::utf8(b"DreQuan")
        } else if (arg0 == 47) {
            0x1::string::utf8(b"Rellion")
        } else if (arg0 == 48) {
            0x1::string::utf8(b"ShaDre")
        } else if (arg0 == 49) {
            0x1::string::utf8(b"VonTay")
        } else if (arg0 == 50) {
            0x1::string::utf8(b"TyRiq")
        } else if (arg0 == 51) {
            0x1::string::utf8(b"RiqDre")
        } else if (arg0 == 52) {
            0x1::string::utf8(b"MaKell")
        } else if (arg0 == 53) {
            0x1::string::utf8(b"DeTray")
        } else if (arg0 == 54) {
            0x1::string::utf8(b"DaeVon")
        } else if (arg0 == 55) {
            0x1::string::utf8(b"TyVonn")
        } else if (arg0 == 56) {
            0x1::string::utf8(b"Riqellon")
        } else if (arg0 == 57) {
            0x1::string::utf8(b"Quavontee")
        } else if (arg0 == 58) {
            0x1::string::utf8(b"J'Vell")
        } else if (arg0 == 59) {
            0x1::string::utf8(b"KaMarion")
        } else if (arg0 == 60) {
            0x1::string::utf8(b"DeRiqo")
        } else if (arg0 == 61) {
            0x1::string::utf8(b"T'Dre")
        } else if (arg0 == 62) {
            0x1::string::utf8(b"RaqDre")
        } else if (arg0 == 63) {
            0x1::string::utf8(b"LaRiq")
        } else if (arg0 == 64) {
            0x1::string::utf8(b"JaeVon")
        } else if (arg0 == 65) {
            0x1::string::utf8(b"TyMarion")
        } else if (arg0 == 66) {
            0x1::string::utf8(b"DaVontae")
        } else if (arg0 == 67) {
            0x1::string::utf8(b"Rellionaire")
        } else if (arg0 == 68) {
            0x1::string::utf8(b"DreVell")
        } else if (arg0 == 69) {
            0x1::string::utf8(b"K'Vonte")
        } else if (arg0 == 70) {
            0x1::string::utf8(b"TruRell")
        } else if (arg0 == 71) {
            0x1::string::utf8(b"RiqVell")
        } else {
            0x1::string::utf8(b"Tyrone")
        }
    }

    fun get_last_name(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Banks")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Carter")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Monroe")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Jackson")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"Young")
        } else if (arg0 == 5) {
            0x1::string::utf8(b"Brooks")
        } else if (arg0 == 6) {
            0x1::string::utf8(b"Walker")
        } else if (arg0 == 7) {
            0x1::string::utf8(b"Porter")
        } else if (arg0 == 8) {
            0x1::string::utf8(b"Tate")
        } else if (arg0 == 9) {
            0x1::string::utf8(b"Lawson")
        } else if (arg0 == 10) {
            0x1::string::utf8(b"Bishop")
        } else if (arg0 == 11) {
            0x1::string::utf8(b"King")
        } else if (arg0 == 12) {
            0x1::string::utf8(b"Hill")
        } else if (arg0 == 13) {
            0x1::string::utf8(b"Knox")
        } else if (arg0 == 14) {
            0x1::string::utf8(b"Gates")
        } else if (arg0 == 15) {
            0x1::string::utf8(b"Cross")
        } else if (arg0 == 16) {
            0x1::string::utf8(b"Bentley")
        } else if (arg0 == 17) {
            0x1::string::utf8(b"Tyson")
        } else if (arg0 == 18) {
            0x1::string::utf8(b"Vaughn")
        } else if (arg0 == 19) {
            0x1::string::utf8(b"Rivers")
        } else if (arg0 == 20) {
            0x1::string::utf8(b"Steele")
        } else if (arg0 == 21) {
            0x1::string::utf8(b"Booker")
        } else if (arg0 == 22) {
            0x1::string::utf8(b"Mercer")
        } else if (arg0 == 23) {
            0x1::string::utf8(b"Knight")
        } else if (arg0 == 24) {
            0x1::string::utf8(b"Woods")
        } else if (arg0 == 25) {
            0x1::string::utf8(b"Drake")
        } else if (arg0 == 26) {
            0x1::string::utf8(b"Keys")
        } else if (arg0 == 27) {
            0x1::string::utf8(b"Savage")
        } else if (arg0 == 28) {
            0x1::string::utf8(b"Cole")
        } else if (arg0 == 29) {
            0x1::string::utf8(b"West")
        } else if (arg0 == 30) {
            0x1::string::utf8(b"Porterfield")
        } else if (arg0 == 31) {
            0x1::string::utf8(b"Major")
        } else if (arg0 == 32) {
            0x1::string::utf8(b"Rowe")
        } else if (arg0 == 33) {
            0x1::string::utf8(b"Frost")
        } else if (arg0 == 34) {
            0x1::string::utf8(b"Knoxx")
        } else if (arg0 == 35) {
            0x1::string::utf8(b"Lane")
        } else if (arg0 == 36) {
            0x1::string::utf8(b"Barlow")
        } else if (arg0 == 37) {
            0x1::string::utf8(b"Cruz")
        } else if (arg0 == 38) {
            0x1::string::utf8(b"Wesson")
        } else if (arg0 == 39) {
            0x1::string::utf8(b"Monroe-Bishop")
        } else if (arg0 == 40) {
            0x1::string::utf8(b"Carter-Lee")
        } else if (arg0 == 41) {
            0x1::string::utf8(b"DeLamar")
        } else if (arg0 == 42) {
            0x1::string::utf8(b"Fontaine")
        } else if (arg0 == 43) {
            0x1::string::utf8(b"Valentine")
        } else if (arg0 == 44) {
            0x1::string::utf8(b"Serrano")
        } else if (arg0 == 45) {
            0x1::string::utf8(b"Roc")
        } else if (arg0 == 46) {
            0x1::string::utf8(b"Blu")
        } else if (arg0 == 47) {
            0x1::string::utf8(b"Hendrix")
        } else if (arg0 == 48) {
            0x1::string::utf8(b"Luciano")
        } else if (arg0 == 49) {
            0x1::string::utf8(b"Winters")
        } else if (arg0 == 50) {
            0x1::string::utf8(b"Armani")
        } else if (arg0 == 51) {
            0x1::string::utf8(b"Styles")
        } else if (arg0 == 52) {
            0x1::string::utf8(b"Blaze")
        } else if (arg0 == 53) {
            0x1::string::utf8(b"Rico")
        } else if (arg0 == 54) {
            0x1::string::utf8(b"Dior")
        } else if (arg0 == 55) {
            0x1::string::utf8(b"Fontaine-Jones")
        } else if (arg0 == 56) {
            0x1::string::utf8(b"Stackhouse")
        } else if (arg0 == 57) {
            0x1::string::utf8(b"Love")
        } else if (arg0 == 58) {
            0x1::string::utf8(b"Holloway")
        } else if (arg0 == 59) {
            0x1::string::utf8(b"Coltrane")
        } else if (arg0 == 60) {
            0x1::string::utf8(b"Delano")
        } else if (arg0 == 61) {
            0x1::string::utf8(b"Goldsby")
        } else if (arg0 == 62) {
            0x1::string::utf8(b"Ice")
        } else if (arg0 == 63) {
            0x1::string::utf8(b"Farris")
        } else if (arg0 == 64) {
            0x1::string::utf8(b"Royale")
        } else if (arg0 == 65) {
            0x1::string::utf8(b"Saint")
        } else {
            0x1::string::utf8(b"Banks")
        }
    }

    fun get_mint_count_for_phase(arg0: &CollectionState, arg1: address, arg2: u8) : u64 {
        if (!0x2::table::contains<address, vector<u64>>(&arg0.mint_counts, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, vector<u64>>(&arg0.mint_counts, arg1);
        let v1 = (arg2 as u64) - 1;
        if (v1 < 0x1::vector::length<u64>(v0)) {
            *0x1::vector::borrow<u64>(v0, v1)
        } else {
            0
        }
    }

    fun get_og_title(arg0: u8) : 0x1::string::String {
        if (arg0 < 50) {
            get_og_title_0_49(arg0)
        } else if (arg0 < 100) {
            get_og_title_50_99(arg0 - 50)
        } else {
            get_og_title_100_149(arg0 - 100)
        }
    }

    fun get_og_title_0_49(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Trap King")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Run-Em-Down")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Block Spinner")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Corner Fiend")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"Glock Lord")
        } else if (arg0 == 5) {
            0x1::string::utf8(b"Brick Baby")
        } else if (arg0 == 6) {
            0x1::string::utf8(b"Bandit Dre")
        } else if (arg0 == 7) {
            0x1::string::utf8(b"Bag Snatcher")
        } else if (arg0 == 8) {
            0x1::string::utf8(b"Lil Pressure")
        } else if (arg0 == 9) {
            0x1::string::utf8(b"Trenchtalker")
        } else if (arg0 == 10) {
            0x1::string::utf8(b"Zone Runner")
        } else if (arg0 == 11) {
            0x1::string::utf8(b"Chop Boy")
        } else if (arg0 == 12) {
            0x1::string::utf8(b"Block Terror")
        } else if (arg0 == 13) {
            0x1::string::utf8(b"8Block Riq")
        } else if (arg0 == 14) {
            0x1::string::utf8(b"Mud Lord")
        } else if (arg0 == 15) {
            0x1::string::utf8(b"Stick Runner")
        } else if (arg0 == 16) {
            0x1::string::utf8(b"Chop House Dre")
        } else if (arg0 == 17) {
            0x1::string::utf8(b"Trap Demon")
        } else if (arg0 == 18) {
            0x1::string::utf8(b"Big Motion")
        } else if (arg0 == 19) {
            0x1::string::utf8(b"Stick Baby")
        } else if (arg0 == 20) {
            0x1::string::utf8(b"Block Surgeon")
        } else if (arg0 == 21) {
            0x1::string::utf8(b"Hood Vandal")
        } else if (arg0 == 22) {
            0x1::string::utf8(b"Brick Runner")
        } else if (arg0 == 23) {
            0x1::string::utf8(b"Glock Baby")
        } else if (arg0 == 24) {
            0x1::string::utf8(b"Bag Flipper")
        } else if (arg0 == 25) {
            0x1::string::utf8(b"Big Trench")
        } else if (arg0 == 26) {
            0x1::string::utf8(b"Corner Baby")
        } else if (arg0 == 27) {
            0x1::string::utf8(b"Lil Bando")
        } else if (arg0 == 28) {
            0x1::string::utf8(b"Trap Hustla")
        } else if (arg0 == 29) {
            0x1::string::utf8(b"Run-It-Up")
        } else if (arg0 == 30) {
            0x1::string::utf8(b"Section Boss")
        } else if (arg0 == 31) {
            0x1::string::utf8(b"Brick Eater")
        } else if (arg0 == 32) {
            0x1::string::utf8(b"Block Lord")
        } else if (arg0 == 33) {
            0x1::string::utf8(b"Pack Mover")
        } else if (arg0 == 34) {
            0x1::string::utf8(b"Hood Menace")
        } else if (arg0 == 35) {
            0x1::string::utf8(b"Stick Talk")
        } else if (arg0 == 36) {
            0x1::string::utf8(b"Trench Made")
        } else if (arg0 == 37) {
            0x1::string::utf8(b"Big Pack")
        } else if (arg0 == 38) {
            0x1::string::utf8(b"Corner Gremlin")
        } else if (arg0 == 39) {
            0x1::string::utf8(b"Bando Baby")
        } else if (arg0 == 40) {
            0x1::string::utf8(b"Trap Shooter")
        } else if (arg0 == 41) {
            0x1::string::utf8(b"Hood Phantom")
        } else if (arg0 == 42) {
            0x1::string::utf8(b"Glock Smith")
        } else if (arg0 == 43) {
            0x1::string::utf8(b"Brick God")
        } else if (arg0 == 44) {
            0x1::string::utf8(b"Lil Section")
        } else if (arg0 == 45) {
            0x1::string::utf8(b"Runway Vell")
        } else if (arg0 == 46) {
            0x1::string::utf8(b"2Tone Riq")
        } else if (arg0 == 47) {
            0x1::string::utf8(b"Bag Chaser")
        } else if (arg0 == 48) {
            0x1::string::utf8(b"Chop Lord")
        } else {
            0x1::string::utf8(b"Block Burner")
        }
    }

    fun get_og_title_100_149(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Hood Killer")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Trap Nightmare")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Block Savage")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Street Reaper")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"Glock Demon")
        } else if (arg0 == 5) {
            0x1::string::utf8(b"Bag Boss")
        } else if (arg0 == 6) {
            0x1::string::utf8(b"Corner Menace")
        } else if (arg0 == 7) {
            0x1::string::utf8(b"Trap Beast")
        } else if (arg0 == 8) {
            0x1::string::utf8(b"Block Warlord")
        } else if (arg0 == 9) {
            0x1::string::utf8(b"Hood Emperor")
        } else if (arg0 == 10) {
            0x1::string::utf8(b"Stick Legend")
        } else if (arg0 == 11) {
            0x1::string::utf8(b"Brick Kingpin")
        } else if (arg0 == 12) {
            0x1::string::utf8(b"Zone Killer")
        } else if (arg0 == 13) {
            0x1::string::utf8(b"Trap Champion")
        } else if (arg0 == 14) {
            0x1::string::utf8(b"Block Phantom")
        } else if (arg0 == 15) {
            0x1::string::utf8(b"Hood Overlord")
        } else if (arg0 == 16) {
            0x1::string::utf8(b"Corner Killa")
        } else if (arg0 == 17) {
            0x1::string::utf8(b"Glock God")
        } else if (arg0 == 18) {
            0x1::string::utf8(b"Bag Monster")
        } else if (arg0 == 19) {
            0x1::string::utf8(b"Trap Warrior")
        } else if (arg0 == 20) {
            0x1::string::utf8(b"Block Titan")
        } else if (arg0 == 21) {
            0x1::string::utf8(b"Street Demon")
        } else if (arg0 == 22) {
            0x1::string::utf8(b"Hood Giant")
        } else if (arg0 == 23) {
            0x1::string::utf8(b"Corner Savage")
        } else if (arg0 == 24) {
            0x1::string::utf8(b"Brick Demon")
        } else if (arg0 == 25) {
            0x1::string::utf8(b"Trap Phantom")
        } else if (arg0 == 26) {
            0x1::string::utf8(b"Block Emperor")
        } else if (arg0 == 27) {
            0x1::string::utf8(b"Hood Monster")
        } else if (arg0 == 28) {
            0x1::string::utf8(b"Glock Reaper")
        } else if (arg0 == 29) {
            0x1::string::utf8(b"Bag Demon")
        } else if (arg0 == 30) {
            0x1::string::utf8(b"Corner Lord")
        } else if (arg0 == 31) {
            0x1::string::utf8(b"Trap Monster")
        } else if (arg0 == 32) {
            0x1::string::utf8(b"Block Demon")
        } else if (arg0 == 33) {
            0x1::string::utf8(b"Hood Boss")
        } else if (arg0 == 34) {
            0x1::string::utf8(b"Stick God")
        } else if (arg0 == 35) {
            0x1::string::utf8(b"Brick Phantom")
        } else if (arg0 == 36) {
            0x1::string::utf8(b"Zone Lord")
        } else if (arg0 == 37) {
            0x1::string::utf8(b"Trap God")
        } else if (arg0 == 38) {
            0x1::string::utf8(b"Block Beast")
        } else if (arg0 == 39) {
            0x1::string::utf8(b"Hood King")
        } else if (arg0 == 40) {
            0x1::string::utf8(b"Corner Demon")
        } else if (arg0 == 41) {
            0x1::string::utf8(b"Glock Boss")
        } else if (arg0 == 42) {
            0x1::string::utf8(b"Bag King")
        } else if (arg0 == 43) {
            0x1::string::utf8(b"Trap Boss")
        } else if (arg0 == 44) {
            0x1::string::utf8(b"Block King")
        } else if (arg0 == 45) {
            0x1::string::utf8(b"Street Boss")
        } else if (arg0 == 46) {
            0x1::string::utf8(b"Hood God")
        } else if (arg0 == 47) {
            0x1::string::utf8(b"Corner King")
        } else if (arg0 == 48) {
            0x1::string::utf8(b"Trap Reaper")
        } else {
            0x1::string::utf8(b"Block God")
        }
    }

    fun get_og_title_50_99(arg0: u8) : 0x1::string::String {
        if (arg0 == 0) {
            0x1::string::utf8(b"Mud Reaper")
        } else if (arg0 == 1) {
            0x1::string::utf8(b"Brick Boy")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Glock Man")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Trap General")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"Hood Demon")
        } else if (arg0 == 5) {
            0x1::string::utf8(b"Section Fiend")
        } else if (arg0 == 6) {
            0x1::string::utf8(b"Block Bandit")
        } else if (arg0 == 7) {
            0x1::string::utf8(b"Trap Surgeon")
        } else if (arg0 == 8) {
            0x1::string::utf8(b"Run-Down Ray")
        } else if (arg0 == 9) {
            0x1::string::utf8(b"Brick Boss")
        } else if (arg0 == 10) {
            0x1::string::utf8(b"Bag Lord")
        } else if (arg0 == 11) {
            0x1::string::utf8(b"Chop Demon")
        } else if (arg0 == 12) {
            0x1::string::utf8(b"Block Star")
        } else if (arg0 == 13) {
            0x1::string::utf8(b"Mud Maker")
        } else if (arg0 == 14) {
            0x1::string::utf8(b"Trap Freak")
        } else if (arg0 == 15) {
            0x1::string::utf8(b"Corner Boss")
        } else if (arg0 == 16) {
            0x1::string::utf8(b"Big Bando")
        } else if (arg0 == 17) {
            0x1::string::utf8(b"Glock Freak")
        } else if (arg0 == 18) {
            0x1::string::utf8(b"Section Lord")
        } else if (arg0 == 19) {
            0x1::string::utf8(b"Block Baby")
        } else if (arg0 == 20) {
            0x1::string::utf8(b"Trap Lord")
        } else if (arg0 == 21) {
            0x1::string::utf8(b"Hood Hustla")
        } else if (arg0 == 22) {
            0x1::string::utf8(b"Pack Runner")
        } else if (arg0 == 23) {
            0x1::string::utf8(b"Brick Dealer")
        } else if (arg0 == 24) {
            0x1::string::utf8(b"Block Reaper")
        } else if (arg0 == 25) {
            0x1::string::utf8(b"Bag Flipper")
        } else if (arg0 == 26) {
            0x1::string::utf8(b"Corner Baby Dre")
        } else if (arg0 == 27) {
            0x1::string::utf8(b"Run-It-Back")
        } else if (arg0 == 28) {
            0x1::string::utf8(b"Big Glocko")
        } else if (arg0 == 29) {
            0x1::string::utf8(b"Brick Monster")
        } else if (arg0 == 30) {
            0x1::string::utf8(b"Trench Fiend")
        } else if (arg0 == 31) {
            0x1::string::utf8(b"Section Bossman")
        } else if (arg0 == 32) {
            0x1::string::utf8(b"Block Terrorist")
        } else if (arg0 == 33) {
            0x1::string::utf8(b"Trap Addict")
        } else if (arg0 == 34) {
            0x1::string::utf8(b"Glock Runner")
        } else if (arg0 == 35) {
            0x1::string::utf8(b"Hood Prince")
        } else if (arg0 == 36) {
            0x1::string::utf8(b"Big Pressure")
        } else if (arg0 == 37) {
            0x1::string::utf8(b"Brick Bando")
        } else if (arg0 == 38) {
            0x1::string::utf8(b"Corner Reaper")
        } else if (arg0 == 39) {
            0x1::string::utf8(b"Mud Demon")
        } else if (arg0 == 40) {
            0x1::string::utf8(b"Trap Enforcer")
        } else if (arg0 == 41) {
            0x1::string::utf8(b"Stick Baby Dre")
        } else if (arg0 == 42) {
            0x1::string::utf8(b"Block Baby Riq")
        } else if (arg0 == 43) {
            0x1::string::utf8(b"Bag God")
        } else if (arg0 == 44) {
            0x1::string::utf8(b"Corner Shooter")
        } else if (arg0 == 45) {
            0x1::string::utf8(b"Brick Mover")
        } else if (arg0 == 46) {
            0x1::string::utf8(b"Trap Goblin")
        } else if (arg0 == 47) {
            0x1::string::utf8(b"Section Runner")
        } else if (arg0 == 48) {
            0x1::string::utf8(b"Block Freak")
        } else {
            0x1::string::utf8(b"Run-Up King")
        }
    }

    public fun get_provenance(arg0: &GBzNFT) : &vector<ProvenanceEntry> {
        &arg0.provenance
    }

    fun get_random_index(arg0: u64, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = 0x2::tx_context::epoch(arg2);
        let v3 = 0x2::bcs::to_bytes<address>(&v0);
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&v1));
        0x1::vector::append<u8>(&mut v3, 0x2::bcs::to_bytes<u64>(&v2));
        let v4 = 0x2::hash::blake2b256(&v3);
        bytes_to_u64(&v4) % arg0
    }

    public fun get_total_minted(arg0: &CollectionState) : u64 {
        arg0.total_minted
    }

    public entry fun gift_nft(arg0: &mut CollectionState, arg1: GBzNFT, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.current_owner, 6);
        check_and_enforce_condemnation(arg0, &arg1, 0x2::clock::timestamp_ms(arg3));
        transfer_nft_internal(arg0, arg1, arg2, arg3);
        let v0 = ProvenanceUpdated{
            token_id  : arg1.token_id,
            new_owner : arg2,
            timestamp : 0,
        };
        0x2::event::emit<ProvenanceUpdated>(v0);
    }

    public fun image_url(arg0: &GBzNFT) : 0x1::string::String {
        arg0.image_url
    }

    fun increment_daily_count(arg0: &mut CollectionState, arg1: address) {
        let v0 = 0x2::table::borrow_mut<address, DailyLimit>(&mut arg0.daily_condemnations, arg1);
        v0.count = v0.count + 1;
    }

    fun increment_mint_count(arg0: &mut CollectionState, arg1: address, arg2: u8) {
        let v0 = (arg2 as u64) - 1;
        if (!0x2::table::contains<address, vector<u64>>(&arg0.mint_counts, arg1)) {
            let v1 = 0x1::vector::empty<u64>();
            let v2 = 0;
            while (v2 <= v0) {
                0x1::vector::push_back<u64>(&mut v1, 0);
                v2 = v2 + 1;
            };
            *0x1::vector::borrow_mut<u64>(&mut v1, v0) = 1;
            0x2::table::add<address, vector<u64>>(&mut arg0.mint_counts, arg1, v1);
        } else {
            let v3 = 0x2::table::borrow_mut<address, vector<u64>>(&mut arg0.mint_counts, arg1);
            while (0x1::vector::length<u64>(v3) <= v0) {
                0x1::vector::push_back<u64>(v3, 0);
            };
            let v4 = 0x1::vector::borrow_mut<u64>(v3, v0);
            *v4 = *v4 + 1;
        };
    }

    fun init(arg0: GBZ_DYNAMIC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<GBZ_DYNAMIC>(arg0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"token_id"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"provenance_count"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"attribute_type"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"attribute_points"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"generated_name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"is_og_title"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name_rarity"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://gbz.io"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"GBz"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"#{token_id}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{provenance.length}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{attribute.attribute_type}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{attribute.points}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{generated_name.full_name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{generated_name.is_og_title}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{generated_name.name_rarity}"));
        let v6 = 0x2::display::new_with_fields<GBzNFT>(&v1, v2, v4, arg1);
        0x2::display::update_version<GBzNFT>(&mut v6);
        let v7 = AdminCap{id: 0x2::object::new(arg1)};
        let v8 = 0x1::vector::empty<u64>();
        let v9 = 1;
        while (v9 <= 11111) {
            0x1::vector::push_back<u64>(&mut v8, v9);
            v9 = v9 + 1;
        };
        let v10 = CollectionState{
            id                    : 0x2::object::new(arg1),
            total_minted          : 0,
            total_burned          : 0,
            treasury              : v0,
            treasury_balance      : 0x2::balance::zero<0x2::sui::SUI>(),
            mint_proceeds         : 0x2::balance::zero<0x2::sui::SUI>(),
            admin                 : v0,
            current_phase         : 0,
            og_list               : 0x2::table::new<address, bool>(arg1),
            whitelist             : 0x2::table::new<address, bool>(arg1),
            mint_counts           : 0x2::table::new<address, vector<u64>>(arg1),
            approved_marketplaces : 0x2::table::new<address, bool>(arg1),
            activity_tracker      : 0x2::table::new<u64, ActivityInfo>(arg1),
            condemned_nfts        : 0x2::table::new<u64, CondemnationInfo>(arg1),
            daily_condemnations   : 0x2::table::new<address, DailyLimit>(arg1),
            staked_nfts           : 0x2::table::new<u64, StakeInfo>(arg1),
            user_staked_nfts      : 0x2::table::new<address, vector<u64>>(arg1),
            listed_nfts           : 0x2::table::new<u64, ListingInfo>(arg1),
            burned_addresses      : 0x2::table::new<u64, bool>(arg1),
            permanent_originals   : 0x2::table::new<u64, 0x1::string::String>(arg1),
            pvp_enabled           : false,
            bounty_poster_url     : 0x1::string::utf8(b""),
            used_rare_names       : 0x2::table::new<u8, bool>(arg1),
            rare_names_used       : 0,
            available_token_ids   : v8,
            base_image_url        : 0x1::string::utf8(b"https://pub-c907649788c642a19b79ddf4d14b069c.r2.dev/"),
        };
        let v11 = RewardPool{
            id                : 0x2::object::new(arg1),
            claimable_rewards : 0x2::table::new<address, u64>(arg1),
            total_accumulated : 0,
            total_claimed     : 0,
            pending_balance   : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v12 = GlobalProvenanceTracker{
            id                  : 0x2::object::new(arg1),
            address_stamp_count : 0x2::table::new<address, u64>(arg1),
            total_stamps        : 0,
        };
        let (v13, v14) = 0x2::transfer_policy::new<GBzNFT>(&v1, arg1);
        0x2::transfer::public_transfer<0x2::display::Display<GBzNFT>>(v6, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<GBzNFT>>(v14, v0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<GBzNFT>>(v13);
        0x2::transfer::share_object<CollectionState>(v10);
        0x2::transfer::share_object<RewardPool>(v11);
        0x2::transfer::share_object<GlobalProvenanceTracker>(v12);
        0x2::transfer::transfer<AdminCap>(v7, v0);
    }

    public fun is_condemned(arg0: &GBzNFT) : bool {
        arg0.is_condemned
    }

    public fun is_idle(arg0: &CollectionState, arg1: u64, arg2: u64) : bool {
        if (is_protected(arg0, arg1)) {
            return false
        };
        if (!0x2::table::contains<u64, ActivityInfo>(&arg0.activity_tracker, arg1)) {
            return false
        };
        arg2 - 0x2::table::borrow<u64, ActivityInfo>(&arg0.activity_tracker, arg1).last_activity >= 2592000000
    }

    public fun is_marketplace_approved(arg0: &CollectionState, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.approved_marketplaces, arg1)
    }

    public fun is_on_og_list(arg0: &CollectionState, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.og_list, arg1)
    }

    public fun is_on_whitelist(arg0: &CollectionState, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.whitelist, arg1)
    }

    public fun is_protected(arg0: &CollectionState, arg1: u64) : bool {
        0x2::table::contains<u64, StakeInfo>(&arg0.staked_nfts, arg1) || 0x2::table::contains<u64, ListingInfo>(&arg0.listed_nfts, arg1)
    }

    public entry fun marketplace_delist_hook(arg0: &mut CollectionState, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_marketplace_approved(arg0, v0), 14);
        assert!(0x2::table::contains<u64, ListingInfo>(&arg0.listed_nfts, arg1), 20);
        0x2::table::remove<u64, ListingInfo>(&mut arg0.listed_nfts, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        update_activity(arg0, arg1, 5, v1);
        let v2 = NFTDelisted{
            token_id    : arg1,
            marketplace : v0,
            delist_time : v1,
        };
        0x2::event::emit<NFTDelisted>(v2);
    }

    public entry fun marketplace_list_hook(arg0: &mut CollectionState, arg1: &mut GBzNFT, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = arg1.token_id;
        assert!(v0 == arg1.current_owner, 6);
        assert!(is_marketplace_approved(arg0, v0), 14);
        assert!(!0x2::table::contains<u64, ListingInfo>(&arg0.listed_nfts, v1), 22);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = ListingInfo{
            marketplace : v0,
            list_time   : v2,
        };
        0x2::table::add<u64, ListingInfo>(&mut arg0.listed_nfts, v1, v3);
        update_activity(arg0, v1, 4, v2);
        if (0x2::table::contains<u64, CondemnationInfo>(&arg0.condemned_nfts, v1)) {
            let v4 = 0x2::table::remove<u64, CondemnationInfo>(&mut arg0.condemned_nfts, v1);
            arg1.is_condemned = false;
            arg1.image_url = v4.original_image_url;
            arg1.bounty_metadata = 0x1::string::utf8(b"");
            let v5 = NFTSavedFromCondemnation{
                token_id    : v1,
                saved_by    : arg1.current_owner,
                save_method : 2,
                timestamp   : v2,
            };
            0x2::event::emit<NFTSavedFromCondemnation>(v5);
        };
        let v6 = NFTListed{
            token_id    : v1,
            marketplace : v0,
            list_time   : v2,
        };
        0x2::event::emit<NFTListed>(v6);
    }

    public entry fun mint_nft(arg0: &mut CollectionState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = arg0.current_phase;
        let v2 = if (v1 == 1) {
            true
        } else if (v1 == 2) {
            true
        } else {
            v1 == 3
        };
        assert!(v2, 9);
        assert!(arg0.total_minted < 11111, 1);
        let (v3, v4) = if (v1 == 1) {
            assert!(0x2::table::contains<address, bool>(&arg0.og_list, v0), 10);
            (111000000, 50)
        } else if (v1 == 2) {
            assert!(0x2::table::contains<address, bool>(&arg0.whitelist, v0), 11);
            (222000000, 100)
        } else {
            (333000000, 100)
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v3, 2);
        assert!(get_mint_count_for_phase(arg0, v0, v1) < v4, 12);
        increment_mint_count(arg0, v0, v1);
        let v5 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.mint_proceeds, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v3));
        if (0x2::balance::value<0x2::sui::SUI>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v5, arg4), v0);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v5);
        };
        let v6 = 0x1::vector::length<u64>(&arg0.available_token_ids);
        assert!(v6 > 0, 1);
        0x1::vector::swap<u64>(&mut arg0.available_token_ids, get_random_index(v6, arg3, arg4), v6 - 1);
        let v7 = 0x1::vector::pop_back<u64>(&mut arg0.available_token_ids);
        let v8 = arg0.base_image_url;
        0x1::string::append(&mut v8, u64_to_string(v7 + 2268));
        0x1::string::append(&mut v8, 0x1::string::utf8(b".png"));
        arg0.total_minted = arg0.total_minted + 1;
        let v9 = generate_random_attribute(arg4);
        let v10 = generate_random_name(arg0, arg4);
        let v11 = v10.full_name;
        let v12 = GBzNFT{
            id              : 0x2::object::new(arg4),
            token_id        : v7,
            name            : v11,
            description     : arg2,
            image_url       : v8,
            provenance      : 0x1::vector::empty<ProvenanceEntry>(),
            current_owner   : v0,
            is_condemned    : false,
            bounty_metadata : 0x1::string::utf8(b""),
            attribute       : v9,
            generated_name  : v10,
        };
        let v13 = NFTMinted{
            token_id   : v7,
            recipient  : v0,
            name       : v11,
            phase      : v1,
            price_paid : v3,
        };
        0x2::event::emit<NFTMinted>(v13);
        0x2::transfer::transfer<GBzNFT>(v12, v0);
    }

    public fun provenance_count(arg0: &GBzNFT) : u64 {
        0x1::vector::length<ProvenanceEntry>(&arg0.provenance)
    }

    public fun purchase_from_kiosk_and_pay_royalty(arg0: &mut CollectionState, arg1: &mut RewardPool, arg2: &0x2::transfer_policy::TransferPolicy<GBzNFT>, arg3: &mut 0x2::transfer_policy::TransferRequest<GBzNFT>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &GBzNFT, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = arg5.token_id;
        let v1 = 0x1::vector::length<ProvenanceEntry>(&arg5.provenance);
        assert!(!0x2::table::contains<u64, StakeInfo>(&arg0.staked_nfts, v0), 21);
        let v2 = 0x2::transfer_policy::paid<GBzNFT>(arg3);
        let v3 = if (v1 == 0) {
            100
        } else if (v1 >= 20) {
            2000
        } else {
            let v4 = vector[216, 411, 586, 744, 888, 1016, 1131, 1234, 1328, 1412, 1488, 1556, 1617, 1672, 1721, 1766, 1806, 1843, 1876, 1900];
            100 + *0x1::vector::borrow<u64>(&v4, v1 - 1)
        };
        let v5 = v2 * v3 / 10000;
        let v6 = v2 * 100 / 10000;
        let v7 = v5 - v6;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v5, 2);
        let v8 = 0x2::coin::into_balance<0x2::sui::SUI>(arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v8, v6));
        if (v7 > 0 && v1 > 0) {
            let v9 = &mut v8;
            let v10 = &mut arg0.treasury_balance;
            accumulate_provenance_rewards(arg1, &arg5.provenance, v9, v7, v10);
        };
        if (0x2::balance::value<0x2::sui::SUI>(&v8) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v8, arg7), 0x2::tx_context::sender(arg7));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v8);
        };
        let v11 = DynamicRoyaltyCollected{
            token_id           : v0,
            provenance_count   : v1,
            royalty_percentage : v3 - 100,
            total_royalty      : v5,
            treasury_amount    : v6,
            provenance_rewards : v7,
        };
        0x2::event::emit<DynamicRoyaltyCollected>(v11);
    }

    public entry fun remove_approved_marketplace(arg0: &AdminCap, arg1: &mut CollectionState, arg2: address, arg3: &0x2::clock::Clock) {
        if (0x2::table::contains<address, bool>(&arg1.approved_marketplaces, arg2)) {
            0x2::table::remove<address, bool>(&mut arg1.approved_marketplaces, arg2);
        };
        let v0 = MarketplaceApprovalChanged{
            marketplace : arg2,
            approved    : false,
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MarketplaceApprovalChanged>(v0);
    }

    public entry fun set_bounty_poster_url(arg0: &AdminCap, arg1: &mut CollectionState, arg2: 0x1::string::String) {
        arg1.bounty_poster_url = arg2;
    }

    public entry fun set_mint_phase(arg0: &AdminCap, arg1: &mut CollectionState, arg2: u8, arg3: &0x2::clock::Clock) {
        assert!(arg2 <= 4, 13);
        arg1.current_phase = arg2;
        let v0 = PhaseChanged{
            old_phase : arg1.current_phase,
            new_phase : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PhaseChanged>(v0);
    }

    public entry fun set_nft_attribute(arg0: &AdminCap, arg1: &mut GBzNFT, arg2: u8, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 1 && arg2 <= 4, 37);
        assert!(arg3 <= 50, 38);
        arg1.attribute.attribute_type = arg2;
        arg1.attribute.points = arg3;
        let v0 = AttributeUpdated{
            token_id   : arg1.token_id,
            old_type   : arg1.attribute.attribute_type,
            old_points : arg1.attribute.points,
            new_type   : arg2,
            new_points : arg3,
            updated_by : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<AttributeUpdated>(v0);
    }

    public entry fun stake_nft(arg0: &mut CollectionState, arg1: &mut GBzNFT, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = arg1.token_id;
        assert!(v0 == arg1.current_owner, 6);
        assert!(!0x2::table::contains<u64, StakeInfo>(&arg0.staked_nfts, v1), 21);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = StakeInfo{
            owner      : v0,
            stake_time : v2,
        };
        0x2::table::add<u64, StakeInfo>(&mut arg0.staked_nfts, v1, v3);
        if (0x2::table::contains<address, vector<u64>>(&arg0.user_staked_nfts, v0)) {
            0x1::vector::push_back<u64>(0x2::table::borrow_mut<address, vector<u64>>(&mut arg0.user_staked_nfts, v0), v1);
        } else {
            let v4 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v4, v1);
            0x2::table::add<address, vector<u64>>(&mut arg0.user_staked_nfts, v0, v4);
        };
        update_activity(arg0, v1, 2, v2);
        if (0x2::table::contains<u64, CondemnationInfo>(&arg0.condemned_nfts, v1)) {
            let v5 = 0x2::table::remove<u64, CondemnationInfo>(&mut arg0.condemned_nfts, v1);
            arg1.is_condemned = false;
            arg1.image_url = v5.original_image_url;
            arg1.bounty_metadata = 0x1::string::utf8(b"");
            let v6 = NFTSavedFromCondemnation{
                token_id    : v1,
                saved_by    : v0,
                save_method : 1,
                timestamp   : v2,
            };
            0x2::event::emit<NFTSavedFromCondemnation>(v6);
        };
        let v7 = NFTStaked{
            token_id   : v1,
            owner      : v0,
            stake_time : v2,
        };
        0x2::event::emit<NFTStaked>(v7);
    }

    public entry fun toggle_pvp(arg0: &AdminCap, arg1: &mut CollectionState, arg2: bool, arg3: &0x2::clock::Clock) {
        arg1.pvp_enabled = arg2;
        let v0 = PvPToggled{
            enabled   : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PvPToggled>(v0);
    }

    public fun token_id(arg0: &GBzNFT) : u64 {
        arg0.token_id
    }

    fun transfer_nft_internal(arg0: &mut CollectionState, arg1: GBzNFT, arg2: address, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = &mut arg1;
        clear_condemnation_on_transfer(arg0, v1, v0);
        let v2 = arg1.token_id;
        clear_staking_on_transfer(arg0, v2);
        update_activity(arg0, v2, 6, v0);
        arg1.current_owner = arg2;
        0x2::transfer::transfer<GBzNFT>(arg1, arg2);
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public entry fun unstake_nft(arg0: &mut CollectionState, arg1: &GBzNFT, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = arg1.token_id;
        assert!(v0 == arg1.current_owner, 6);
        assert!(0x2::table::contains<u64, StakeInfo>(&arg0.staked_nfts, v1), 19);
        0x2::table::remove<u64, StakeInfo>(&mut arg0.staked_nfts, v1);
        if (0x2::table::contains<address, vector<u64>>(&arg0.user_staked_nfts, v0)) {
            let v2 = 0x2::table::borrow_mut<address, vector<u64>>(&mut arg0.user_staked_nfts, v0);
            let (v3, v4) = 0x1::vector::index_of<u64>(v2, &v1);
            if (v3) {
                0x1::vector::remove<u64>(v2, v4);
                if (0x1::vector::is_empty<u64>(v2)) {
                    0x1::vector::destroy_empty<u64>(0x2::table::remove<address, vector<u64>>(&mut arg0.user_staked_nfts, v0));
                };
            };
        };
        let v5 = 0x2::clock::timestamp_ms(arg2);
        update_activity(arg0, v1, 3, v5);
        let v6 = NFTUnstaked{
            token_id     : v1,
            owner        : v0,
            unstake_time : v5,
        };
        0x2::event::emit<NFTUnstaked>(v6);
    }

    fun update_activity(arg0: &mut CollectionState, arg1: u64, arg2: u8, arg3: u64) {
        let v0 = ActivityInfo{
            last_activity : arg3,
            activity_type : arg2,
        };
        if (0x2::table::contains<u64, ActivityInfo>(&arg0.activity_tracker, arg1)) {
            *0x2::table::borrow_mut<u64, ActivityInfo>(&mut arg0.activity_tracker, arg1) = v0;
        } else {
            0x2::table::add<u64, ActivityInfo>(&mut arg0.activity_tracker, arg1, v0);
        };
        let v1 = ActivityUpdated{
            token_id      : arg1,
            activity_type : arg2,
            timestamp     : arg3,
        };
        0x2::event::emit<ActivityUpdated>(v1);
    }

    fun update_provenance(arg0: &mut GBzNFT, arg1: address, arg2: u64, arg3: u64) {
        assert!(arg3 <= 1000000000000000, 31);
        let v0 = ProvenanceEntry{
            owner      : arg1,
            timestamp  : arg2,
            sale_price : arg3,
        };
        0x1::vector::push_back<ProvenanceEntry>(&mut arg0.provenance, v0);
        if (0x1::vector::length<ProvenanceEntry>(&arg0.provenance) > 20) {
            0x1::vector::remove<ProvenanceEntry>(&mut arg0.provenance, 0);
        };
    }

    public entry fun withdraw_mint_proceeds(arg0: &AdminCap, arg1: &mut CollectionState, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.mint_proceeds, arg2), arg4), arg3);
    }

    public entry fun withdraw_treasury(arg0: &AdminCap, arg1: &mut CollectionState, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.treasury_balance) >= arg2, 28);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.treasury_balance, arg2), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

