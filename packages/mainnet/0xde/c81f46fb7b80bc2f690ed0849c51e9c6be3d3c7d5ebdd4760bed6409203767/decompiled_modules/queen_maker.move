module 0xdec81f46fb7b80bc2f690ed0849c51e9c6be3d3c7d5ebdd4760bed6409203767::queen_maker {
    struct QueenMaker has store, key {
        id: 0x2::object::UID,
        hive_kraft_cap: 0x2::coin::TreasuryCap<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::hive::HIVE>,
        hive_to_burn: 0x2::balance::Balance<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::hive::HIVE>,
        config: AuctionConfig,
        are_live: bool,
        queen_custody: 0x2::linked_table::LinkedTable<address, QueenCustody>,
        current_auction: AuctionInfo,
        leading_bees: 0x2::linked_table::LinkedTable<u64, LeadingDragonBee>,
        minimum_leading_bid_amt: u64,
        participating_bees: ParticipatingBees,
        bid_pools: 0x2::linked_table::LinkedTable<u64, BidPool>,
        energy_yield: 0x2::balance::Balance<0x2::sui::SUI>,
        module_version: u64,
    }

    struct LeadingDragonBee has store {
        family_type: u64,
        version: u64,
        bid_amount: u64,
        trainer_addr: address,
        username: 0x1::string::String,
    }

    struct QueenCustody has store {
        family_type: u64,
        mystical_bee: 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::MysticalBee,
        sui_bidded: u64,
        auction_epoch: u64,
    }

    struct BidPool has store {
        sui_available: 0x2::balance::Balance<0x2::sui::SUI>,
        total_sui_bidded: u64,
        energy_yield: u64,
        total_hive_energy: u64,
        total_health: u64,
        bees_participated: u64,
    }

    struct AuctionInfo has store {
        auction_start_epoch: u64,
        auction_status: u8,
        price_to_be_a_queen: u64,
        price_to_be_a_queen_update_epoch: u64,
        auction_phase_2_start_epoch: u64,
        unlimited_deposits_close_ms: u64,
    }

    struct AuctionConfig has store {
        bid_increase_pct: u64,
        bid_decrease_pct: u64,
        unlimited_deposit_window: u64,
        limited_deposit_window: u64,
        cooldown_period: u64,
        max_eggs_per_queen: u64,
        energy_tax: u64,
    }

    struct ParticipatingBees has store {
        user_participation: 0x2::linked_table::LinkedTable<address, ParticipationPosition>,
    }

    struct ParticipationPosition has store {
        family_type: u64,
        mystical_bee: 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::MysticalBee,
        bee_version: u64,
        auction_start_at: u64,
        username: 0x1::string::String,
        trainer_addr: address,
        sui_bidded: u64,
        tax: u64,
        flag: bool,
    }

    struct QueenClaimedByItsOwner has copy, drop {
        trainer_addr: address,
        version: u64,
        sui_bidded: u64,
        auction_epoch: u64,
    }

    struct EnergyAndHealthIncremented has copy, drop {
        auction_epoch: u64,
        total_sui_bidded: u64,
        energy_yield: u64,
        total_hive_energy: u64,
        total_health: u64,
    }

    struct QueenCompetitionOver has copy, drop {
        started_at_epoch: u64,
        next_event_from: u64,
        hive_burnt_amt: u64,
        total_sui_bidded: u64,
        energy_from_queens: u64,
        community_energy: u64,
        becoming_queen_expensive_by: u64,
        price_to_be_a_queen: u64,
    }

    struct NewBeeAddedToCompetition has copy, drop {
        trainer_addr: address,
        username: 0x1::string::String,
        version: u64,
        family_type: u64,
        bid_amt: u64,
        tax_amt: u64,
        auction_start_at: u64,
    }

    struct BidsOpenForExisting has copy, drop {
        auction_start_epoch: u64,
        price_to_be_a_queen: u64,
        cur_epoch: u64,
        deposits_open_till: u64,
    }

    struct BidsClosed has copy, drop {
        auction_start_epoch: u64,
    }

    struct MinBidLimitUpdated has copy, drop {
        auction_start_epoch: u64,
        price_to_be_a_queen: u64,
        cur_epoch: u64,
    }

    struct BidUpdatedByUser has copy, drop {
        trainer_addr: address,
        username: 0x1::string::String,
        bid_amt: u64,
        tax_amt: u64,
        flag: bool,
        auction_start_at: u64,
    }

    struct UserBeeReturned has copy, drop {
        bidder_trainer: address,
        username: 0x1::string::String,
        bee_version: u64,
        bid_amt: u64,
        tax: u64,
        auction_start_at: u64,
    }

    struct LeadingDragonBeeUpdated has copy, drop {
        auction_start_epoch: u64,
        family_type: u64,
        version: u64,
        bid_amount: u64,
        trainer_addr: address,
        username: 0x1::string::String,
    }

    public fun add_to_bid(arg0: &0x2::clock::Clock, arg1: &mut QueenMaker, arg2: &mut 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::DragonTrainer, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 9893);
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = arg1.current_auction.auction_start_epoch;
        let (v2, v3, _) = 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::get_trainer_meta_info(arg2);
        let v5 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        assert!(arg1.current_auction.auction_status == 1 || arg1.current_auction.auction_status == 2, 9861);
        assert!(0x2::linked_table::contains<address, ParticipationPosition>(&arg1.participating_bees.user_participation, v2), 9902);
        let v6 = 0x2::linked_table::borrow_mut<address, ParticipationPosition>(&mut arg1.participating_bees.user_participation, v2);
        assert!(v6.auction_start_at == v1, 9903);
        assert!(!v6.flag, 9904);
        if (arg1.current_auction.auction_status == 2) {
            let (v7, v8) = max_addable_to_bid(arg1.config.limited_deposit_window, arg1.current_auction.unlimited_deposits_close_ms, v0, v6.sui_bidded);
            assert!(arg4 <= v8, 9864);
            v6.flag = v7;
        };
        let v9 = 0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::math::mul_div(arg4, arg1.config.energy_tax, 0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::percent_precision());
        v6.sui_bidded = v6.sui_bidded + arg4;
        v6.tax = v6.tax + v9;
        let v10 = BidUpdatedByUser{
            trainer_addr     : v2,
            username         : v3,
            bid_amt          : v6.sui_bidded,
            tax_amt          : v9,
            flag             : v6.flag,
            auction_start_at : v6.auction_start_at,
        };
        0x2::event::emit<BidUpdatedByUser>(v10);
        let v11 = 0x2::linked_table::borrow_mut<u64, BidPool>(&mut arg1.bid_pools, v1);
        0x2::balance::join<0x2::sui::SUI>(&mut v11.sui_available, 0x2::balance::split<0x2::sui::SUI>(&mut v5, arg4 - v9));
        v11.energy_yield = v11.energy_yield + v9;
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.energy_yield, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v9));
        update_leading_bees(v1, arg1, v3, v2, v6.bee_version, v6.sui_bidded, v6.family_type);
        0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v5, 0x2::tx_context::sender(arg5), arg5);
        limit_deposits_for_existing_bidders(arg1, 0x2::tx_context::epoch(arg5), v0);
    }

    public fun compete_to_be_a_queen(arg0: &0x2::clock::Clock, arg1: &mut QueenMaker, arg2: &mut 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::BeesManager, arg3: &mut 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::DragonTrainer, arg4: u64, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 9893);
        let v0 = arg1.current_auction.auction_start_epoch;
        let (v1, v2, _) = 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::get_trainer_meta_info(arg3);
        let v4 = 0x2::coin::into_balance<0x2::sui::SUI>(arg5);
        assert!(arg1.are_live, 9861);
        assert!(arg1.current_auction.auction_status == 1, 9861);
        assert!(!0x2::linked_table::contains<address, ParticipationPosition>(&arg1.participating_bees.user_participation, v1), 9901);
        let v5 = 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::get_bee_for_queen_competition(&arg1.hive_kraft_cap, arg2, 0x2::object::uid_to_address(&arg1.id), arg3, arg4);
        let v6 = 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::get_bee_family(&v5);
        let v7 = 0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::math::mul_div(arg6, arg1.config.energy_tax, 0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::percent_precision());
        let v8 = create_user_position(v0, v1, v2, v5, v6, arg4, arg6, v7);
        let v9 = NewBeeAddedToCompetition{
            trainer_addr     : v1,
            username         : v2,
            version          : arg4,
            family_type      : v6,
            bid_amt          : arg6,
            tax_amt          : v7,
            auction_start_at : v8.auction_start_at,
        };
        0x2::event::emit<NewBeeAddedToCompetition>(v9);
        if (!0x2::linked_table::contains<u64, BidPool>(&arg1.bid_pools, v0)) {
            let v10 = BidPool{
                sui_available     : 0x2::balance::zero<0x2::sui::SUI>(),
                total_sui_bidded  : 0,
                energy_yield      : 0,
                total_hive_energy : 0,
                total_health      : 0,
                bees_participated : 0,
            };
            0x2::linked_table::push_back<u64, BidPool>(&mut arg1.bid_pools, v0, v10);
        };
        let v11 = 0x2::linked_table::borrow_mut<u64, BidPool>(&mut arg1.bid_pools, v0);
        0x2::balance::join<0x2::sui::SUI>(&mut v11.sui_available, 0x2::balance::split<0x2::sui::SUI>(&mut v4, arg6 - v7));
        v11.energy_yield = v11.energy_yield + v7;
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.energy_yield, 0x2::balance::split<0x2::sui::SUI>(&mut v4, v7));
        v11.bees_participated = v11.bees_participated + 1;
        update_leading_bees(v0, arg1, v2, v1, arg4, arg6, v6);
        0x2::linked_table::push_back<address, ParticipationPosition>(&mut arg1.participating_bees.user_participation, v1, v8);
        0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v4, 0x2::tx_context::sender(arg7), arg7);
        limit_deposits_for_existing_bidders(arg1, 0x2::tx_context::epoch(arg7), 0x2::clock::timestamp_ms(arg0));
    }

    fun create_user_position(arg0: u64, arg1: address, arg2: 0x1::string::String, arg3: 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::MysticalBee, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : ParticipationPosition {
        ParticipationPosition{
            family_type      : arg4,
            mystical_bee     : arg3,
            bee_version      : arg5,
            auction_start_at : arg0,
            username         : arg2,
            trainer_addr     : arg1,
            sui_bidded       : arg6,
            tax              : arg7,
            flag             : false,
        }
    }

    fun destroy_user_position(arg0: ParticipationPosition) : (0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::MysticalBee, u64, u64, 0x1::string::String, address, u64, u64) {
        let ParticipationPosition {
            family_type      : _,
            mystical_bee     : v1,
            bee_version      : v2,
            auction_start_at : v3,
            username         : v4,
            trainer_addr     : v5,
            sui_bidded       : v6,
            tax              : v7,
            flag             : _,
        } = arg0;
        (v1, v3, v2, v4, v5, v6, v7)
    }

    public fun get_bid_pool_info(arg0: &QueenMaker, arg1: u64) : (u64, u64, u64, u64, u64) {
        let v0 = 0x2::linked_table::borrow<u64, BidPool>(&arg0.bid_pools, arg1);
        (0x2::balance::value<0x2::sui::SUI>(&v0.sui_available), v0.total_sui_bidded, v0.energy_yield, v0.total_hive_energy, v0.total_health)
    }

    public fun get_bid_pools_info(arg0: &QueenMaker, arg1: 0x1::option::Option<u64>, arg2: u64) : (vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u64>();
        let v7 = if (0x1::option::is_some<u64>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<u64, BidPool>(&arg0.bid_pools)
        };
        let v8 = v7;
        let v9 = 0;
        while (0x1::option::is_some<u64>(&v8) && v9 < arg2) {
            let v10 = *0x1::option::borrow<u64>(&v8);
            let v11 = 0x2::linked_table::borrow<u64, BidPool>(&arg0.bid_pools, v10);
            0x1::vector::push_back<u64>(&mut v0, v10);
            0x1::vector::push_back<u64>(&mut v1, 0x2::balance::value<0x2::sui::SUI>(&v11.sui_available));
            0x1::vector::push_back<u64>(&mut v2, v11.total_sui_bidded);
            0x1::vector::push_back<u64>(&mut v3, v11.energy_yield);
            0x1::vector::push_back<u64>(&mut v4, v11.total_hive_energy);
            0x1::vector::push_back<u64>(&mut v5, v11.total_health);
            0x1::vector::push_back<u64>(&mut v6, v11.bees_participated);
            v8 = *0x2::linked_table::next<u64, BidPool>(&arg0.bid_pools, v10);
            v9 = v9 + 1;
        };
        (v0, v1, v2, v3, v4, v5, v6, 0x2::linked_table::length<u64, BidPool>(&arg0.bid_pools))
    }

    public fun get_leading_bees_info(arg0: &QueenMaker, arg1: 0x1::option::Option<u64>, arg2: u64) : (vector<u64>, vector<address>, vector<u64>, vector<0x1::string::String>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = if (0x1::option::is_some<u64>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<u64, LeadingDragonBee>(&arg0.leading_bees)
        };
        let v6 = v5;
        let v7 = 0;
        while (0x1::option::is_some<u64>(&v6) && v7 < arg2) {
            let v8 = *0x1::option::borrow<u64>(&v6);
            let v9 = 0x2::linked_table::borrow<u64, LeadingDragonBee>(&arg0.leading_bees, v8);
            0x1::vector::push_back<u64>(&mut v4, v8);
            0x1::vector::push_back<address>(&mut v0, v9.trainer_addr);
            0x1::vector::push_back<0x1::string::String>(&mut v2, v9.username);
            0x1::vector::push_back<u64>(&mut v3, v9.bid_amount);
            0x1::vector::push_back<u64>(&mut v1, v9.version);
            v6 = *0x2::linked_table::next<u64, LeadingDragonBee>(&arg0.leading_bees, v8);
            v7 = v7 + 1;
        };
        (v4, v0, v1, v2, v3, 0x2::linked_table::length<u64, LeadingDragonBee>(&arg0.leading_bees))
    }

    public fun get_positions_for_all_trainers(arg0: &QueenMaker, arg1: 0x1::option::Option<address>, arg2: u64) : (vector<u64>, vector<address>, vector<u64>, vector<u64>, vector<0x1::string::String>, vector<u64>, vector<u64>, vector<bool>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<bool>();
        let v7 = 0x1::vector::empty<u64>();
        let v8 = if (0x1::option::is_some<address>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<address, ParticipationPosition>(&arg0.participating_bees.user_participation)
        };
        let v9 = v8;
        let v10 = 0;
        while (0x1::option::is_some<address>(&v9) && v10 < arg2) {
            let v11 = *0x1::option::borrow<address>(&v9);
            let v12 = 0x2::linked_table::borrow<address, ParticipationPosition>(&arg0.participating_bees.user_participation, v11);
            0x1::vector::push_back<address>(&mut v0, v11);
            0x1::vector::push_back<u64>(&mut v2, v12.auction_start_at);
            0x1::vector::push_back<0x1::string::String>(&mut v3, v12.username);
            0x1::vector::push_back<u64>(&mut v1, v12.bee_version);
            0x1::vector::push_back<u64>(&mut v4, v12.sui_bidded);
            0x1::vector::push_back<u64>(&mut v5, v12.tax);
            0x1::vector::push_back<bool>(&mut v6, v12.flag);
            0x1::vector::push_back<u64>(&mut v7, v12.family_type);
            v9 = *0x2::linked_table::next<address, ParticipationPosition>(&arg0.participating_bees.user_participation, v11);
            v10 = v10 + 1;
        };
        (v7, v0, v1, v2, v3, v4, v5, v6, 0x2::linked_table::length<address, ParticipationPosition>(&arg0.participating_bees.user_participation))
    }

    public fun get_queen_competition_info(arg0: &QueenMaker) : (bool, u64, u8, u64, u64, u64, u64) {
        (arg0.are_live, arg0.current_auction.auction_start_epoch, arg0.current_auction.auction_status, arg0.current_auction.price_to_be_a_queen, arg0.current_auction.price_to_be_a_queen_update_epoch, arg0.current_auction.auction_phase_2_start_epoch, arg0.current_auction.unlimited_deposits_close_ms)
    }

    public fun get_queen_custody_info(arg0: &QueenMaker, arg1: address) : (u64, u64) {
        if (0x2::linked_table::contains<address, QueenCustody>(&arg0.queen_custody, arg1)) {
            let v2 = 0x2::linked_table::borrow<address, QueenCustody>(&arg0.queen_custody, arg1);
            (v2.sui_bidded, v2.auction_epoch)
        } else {
            (0, 0)
        }
    }

    public fun get_user_position_info(arg0: &QueenMaker, arg1: address) : (u64, 0x1::string::String, address, u64, u64, u64, bool, u64) {
        if (0x2::linked_table::contains<address, ParticipationPosition>(&arg0.participating_bees.user_participation, arg1)) {
            let v8 = 0x2::linked_table::borrow<address, ParticipationPosition>(&arg0.participating_bees.user_participation, arg1);
            (v8.auction_start_at, v8.username, v8.trainer_addr, v8.sui_bidded, v8.tax, v8.bee_version, v8.flag, v8.family_type)
        } else {
            (0, 0x1::string::utf8(b""), @0x0, 0, 0, 0, false, 0)
        }
    }

    public fun increment_energy_and_health(arg0: &0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::yield_flow::TwoAmmFlowAccess, arg1: &mut QueenMaker, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = 0x2::linked_table::borrow_mut<u64, BidPool>(&mut arg1.bid_pools, arg2);
        v0.total_hive_energy = arg3;
        v0.total_health = arg4;
        let v1 = EnergyAndHealthIncremented{
            auction_epoch     : arg2,
            total_sui_bidded  : v0.total_sui_bidded,
            energy_yield      : v0.energy_yield,
            total_hive_energy : arg3,
            total_health      : arg4,
        };
        0x2::event::emit<EnergyAndHealthIncremented>(v1);
    }

    public fun increment_queen_maker(arg0: &0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::yield_flow::TwoAmmFlowAccess, arg1: &mut 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::BeesManager, arg2: &mut QueenMaker, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::balance::Balance<0x2::sui::SUI>) {
        assert!(arg2.module_version == 0, 9893);
        let v0 = 0x2::tx_context::epoch(arg3);
        if (!arg2.are_live || v0 < arg2.current_auction.auction_phase_2_start_epoch + arg2.config.limited_deposit_window) {
            return (0, 0, 0x2::balance::zero<0x2::sui::SUI>())
        };
        let v1 = arg2.current_auction.auction_start_epoch;
        let v2 = 0;
        let v3 = *0x2::linked_table::front<u64, LeadingDragonBee>(&arg2.leading_bees);
        while (0x1::option::is_some<u64>(&v3)) {
            let v4 = *0x1::option::borrow<u64>(&v3);
            let v5 = 0x2::linked_table::remove<u64, LeadingDragonBee>(&mut arg2.leading_bees, v4);
            let LeadingDragonBee {
                family_type  : _,
                version      : _,
                bid_amount   : _,
                trainer_addr : _,
                username     : _,
            } = v5;
            let (v11, v12, _, _, v15, v16, v17) = destroy_user_position(0x2::linked_table::remove<address, ParticipationPosition>(&mut arg2.participating_bees.user_participation, v5.trainer_addr));
            let v18 = v11;
            0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::make_bee_queen(&arg2.hive_kraft_cap, arg1, &mut v18, arg2.config.max_eggs_per_queen, v12, arg3);
            let v19 = v2 + v16;
            v2 = v19 - v17;
            let v20 = QueenCustody{
                family_type   : v4,
                mystical_bee  : v18,
                sui_bidded    : v16,
                auction_epoch : v1,
            };
            0x2::linked_table::push_back<address, QueenCustody>(&mut arg2.queen_custody, v15, v20);
            v3 = *0x2::linked_table::next<u64, LeadingDragonBee>(&arg2.leading_bees, v4);
        };
        let v21 = 0x2::balance::withdraw_all<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::hive::HIVE>(&mut arg2.hive_to_burn);
        0x2::coin::burn<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::hive::HIVE>(&mut arg2.hive_kraft_cap, 0x2::coin::from_balance<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::hive::HIVE>(v21, arg3));
        let v22 = 0x2::linked_table::borrow_mut<u64, BidPool>(&mut arg2.bid_pools, v1);
        let v23 = 0x2::balance::value<0x2::sui::SUI>(&v22.sui_available);
        v22.total_sui_bidded = v23;
        let v24 = 0x2::balance::split<0x2::sui::SUI>(&mut v22.sui_available, v2);
        v22.energy_yield = v22.energy_yield + v2;
        let v25 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg2.energy_yield);
        0x2::balance::join<0x2::sui::SUI>(&mut v24, v25);
        arg2.current_auction.auction_start_epoch = v0 + arg2.config.cooldown_period;
        let v26 = (0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::math::mul_div_u256((arg2.current_auction.price_to_be_a_queen as u256), (arg2.config.bid_increase_pct as u256), (0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::percent_precision() as u256)) as u64);
        arg2.current_auction.price_to_be_a_queen = arg2.current_auction.price_to_be_a_queen + v26;
        let v27 = QueenCompetitionOver{
            started_at_epoch            : v1,
            next_event_from             : arg2.current_auction.auction_start_epoch,
            hive_burnt_amt              : 0x2::balance::value<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::hive::HIVE>(&v21),
            total_sui_bidded            : v23,
            energy_from_queens          : v2,
            community_energy            : 0x2::balance::value<0x2::sui::SUI>(&v25),
            becoming_queen_expensive_by : v26,
            price_to_be_a_queen         : arg2.current_auction.price_to_be_a_queen,
        };
        0x2::event::emit<QueenCompetitionOver>(v27);
        (v1, v23, v24)
    }

    public entry fun increment_queen_maker_obj(arg0: &mut QueenMaker, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.module_version < 0, 9892);
        arg0.module_version = 0;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun init_queen_maker(arg0: &0x2::clock::Clock, arg1: 0x2::coin::TreasuryCap<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::hive::HIVE>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = AuctionConfig{
            bid_increase_pct         : 0,
            bid_decrease_pct         : 0,
            unlimited_deposit_window : arg3,
            limited_deposit_window   : arg4,
            cooldown_period          : arg5,
            max_eggs_per_queen       : 0,
            energy_tax               : arg2,
        };
        let v1 = AuctionInfo{
            auction_start_epoch              : 0x2::tx_context::epoch(arg6),
            auction_status                   : 3,
            price_to_be_a_queen              : 0,
            price_to_be_a_queen_update_epoch : 0x2::tx_context::epoch(arg6),
            auction_phase_2_start_epoch      : 0,
            unlimited_deposits_close_ms      : 0x2::clock::timestamp_ms(arg0),
        };
        let v2 = ParticipatingBees{user_participation: 0x2::linked_table::new<address, ParticipationPosition>(arg6)};
        let v3 = QueenMaker{
            id                      : 0x2::object::new(arg6),
            hive_kraft_cap          : arg1,
            hive_to_burn            : 0x2::balance::zero<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::hive::HIVE>(),
            config                  : v0,
            are_live                : false,
            queen_custody           : 0x2::linked_table::new<address, QueenCustody>(arg6),
            current_auction         : v1,
            leading_bees            : 0x2::linked_table::new<u64, LeadingDragonBee>(arg6),
            minimum_leading_bid_amt : 0,
            participating_bees      : v2,
            bid_pools               : 0x2::linked_table::new<u64, BidPool>(arg6),
            energy_yield            : 0x2::balance::zero<0x2::sui::SUI>(),
            module_version          : 0,
        };
        0x2::transfer::share_object<QueenMaker>(v3);
        0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::coin_helper::destroy_or_transfer_balance<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::hive::HIVE>(0x2::coin::into_balance<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::hive::HIVE>(0x2::coin::mint<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::hive::HIVE>(&mut arg1, 0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::total_hive_supply(), arg6)), 0x2::tx_context::sender(arg6), arg6);
    }

    fun limit_deposits_for_existing_bidders(arg0: &mut QueenMaker, arg1: u64, arg2: u64) {
        let v0 = arg0.minimum_leading_bid_amt;
        if (arg1 > arg0.current_auction.auction_start_epoch + arg0.config.unlimited_deposit_window && arg0.current_auction.auction_status == 1) {
            if (v0 < arg0.current_auction.price_to_be_a_queen && arg0.current_auction.price_to_be_a_queen_update_epoch < arg1) {
                let v1 = (0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::math::mul_div_u256((arg0.current_auction.price_to_be_a_queen as u256), (arg0.config.bid_decrease_pct as u256), (0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::percent_precision() as u256)) as u64);
                if (v1 > arg0.current_auction.price_to_be_a_queen) {
                    arg0.current_auction.price_to_be_a_queen = arg0.current_auction.price_to_be_a_queen - v1;
                    arg0.current_auction.price_to_be_a_queen_update_epoch = arg1;
                    let v2 = MinBidLimitUpdated{
                        auction_start_epoch : arg0.current_auction.auction_start_epoch,
                        price_to_be_a_queen : arg0.current_auction.price_to_be_a_queen,
                        cur_epoch           : arg1,
                    };
                    0x2::event::emit<MinBidLimitUpdated>(v2);
                };
            };
            if (v0 >= arg0.current_auction.price_to_be_a_queen) {
                arg0.current_auction.auction_status = 2;
                arg0.current_auction.unlimited_deposits_close_ms = arg2;
                arg0.current_auction.auction_phase_2_start_epoch = arg1;
                let v3 = BidsOpenForExisting{
                    auction_start_epoch : arg0.current_auction.auction_start_epoch,
                    price_to_be_a_queen : arg0.current_auction.price_to_be_a_queen,
                    cur_epoch           : arg1,
                    deposits_open_till  : arg2 + arg0.config.limited_deposit_window * 0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::epoch_duration_ms(),
                };
                0x2::event::emit<BidsOpenForExisting>(v3);
            };
        };
        if (arg0.current_auction.auction_status == 2 && arg1 >= arg0.current_auction.auction_phase_2_start_epoch + arg0.config.limited_deposit_window) {
            arg0.current_auction.auction_status = 3;
            let v4 = BidsClosed{auction_start_epoch: arg0.current_auction.auction_start_epoch};
            0x2::event::emit<BidsClosed>(v4);
        };
    }

    public fun max_addable_to_bid(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (bool, u64) {
        if (arg3 == 0) {
            return (false, 0)
        };
        let v0 = arg0 * 0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::epoch_duration_ms();
        let v1 = arg1 + v0;
        if (v1 > arg2) {
            return (true, (0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::math::mul_div_u256((arg3 as u256), ((v1 - arg2) as u256), (v0 as u256)) as u64))
        };
        (true, 0)
    }

    public fun mint_hive_for_dragon_bees(arg0: &0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::yield_flow::DragonDaoCapability, arg1: &mut QueenMaker, arg2: &mut 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::BeesManager, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::hive::HIVE> {
        let v0 = 0x2::coin::into_balance<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::hive::HIVE>(0x2::coin::mint<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::hive::HIVE>(&mut arg1.hive_kraft_cap, arg3, arg5));
        0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::deposit_hive_with_treasury(arg2, 0x2::balance::split<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::hive::HIVE>(&mut v0, arg3 * arg4 / 0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::percent_precision()));
        v0
    }

    fun update_leading_bees(arg0: u64, arg1: &mut QueenMaker, arg2: 0x1::string::String, arg3: address, arg4: u64, arg5: u64, arg6: u64) {
        if (!0x2::linked_table::contains<u64, LeadingDragonBee>(&arg1.leading_bees, arg6)) {
            let v0 = LeadingDragonBee{
                family_type  : arg6,
                version      : arg4,
                bid_amount   : arg5,
                trainer_addr : arg3,
                username     : arg2,
            };
            0x2::linked_table::push_back<u64, LeadingDragonBee>(&mut arg1.leading_bees, arg6, v0);
            if (arg1.minimum_leading_bid_amt == 0) {
                arg1.minimum_leading_bid_amt = arg5;
            } else if (arg5 < arg1.minimum_leading_bid_amt) {
                arg1.minimum_leading_bid_amt = arg5;
            };
            let v1 = LeadingDragonBeeUpdated{
                auction_start_epoch : arg0,
                family_type         : arg6,
                version             : arg4,
                bid_amount          : arg5,
                trainer_addr        : arg3,
                username            : arg2,
            };
            0x2::event::emit<LeadingDragonBeeUpdated>(v1);
        } else {
            let v2 = 0x2::linked_table::borrow_mut<u64, LeadingDragonBee>(&mut arg1.leading_bees, arg6);
            if (arg5 > v2.bid_amount) {
                v2.bid_amount = arg5;
                v2.trainer_addr = arg3;
                v2.username = arg2;
                v2.version = arg4;
                let v3 = LeadingDragonBeeUpdated{
                    auction_start_epoch : arg0,
                    family_type         : arg6,
                    version             : arg4,
                    bid_amount          : arg5,
                    trainer_addr        : arg3,
                    username            : arg2,
                };
                0x2::event::emit<LeadingDragonBeeUpdated>(v3);
                if (arg5 < arg1.minimum_leading_bid_amt) {
                    arg1.minimum_leading_bid_amt = arg5;
                };
            };
        };
    }

    public fun update_queen_maker(arg0: &0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::yield_flow::DragonDaoCapability, arg1: &mut QueenMaker, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 9893);
        arg1.are_live = arg2;
        if (!arg1.are_live && arg2) {
            arg1.current_auction.auction_start_epoch = 0x2::tx_context::epoch(arg11);
            arg1.current_auction.auction_status = 1;
        };
        if (arg3 > 0) {
            arg1.current_auction.price_to_be_a_queen = arg3;
        };
        if (arg8 > 0) {
            arg1.config.unlimited_deposit_window = arg8;
        };
        if (arg9 > 0) {
            arg1.config.limited_deposit_window = arg9;
        };
        if (arg10 > 0) {
            arg1.config.cooldown_period = arg10;
        };
        if (arg4 > 0) {
            assert!(5 < arg4 && arg4 < 50, 9896);
            arg1.config.bid_increase_pct = arg4;
        };
        if (arg5 > 0) {
            assert!(arg5 < 11, 9897);
            arg1.config.bid_decrease_pct = arg5;
        };
        if (arg7 > 0) {
            assert!(1 < arg7 && arg7 < 15, 9875);
            arg1.config.energy_tax = arg7;
        };
        if (arg6 > 0) {
            assert!(arg6 < 0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::max_queen_eggs_limit(), 9887);
            arg1.config.max_eggs_per_queen = arg6;
        };
    }

    public fun withdraw_bee_after_competition(arg0: &mut QueenMaker, arg1: &mut 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::BeesManager, arg2: &mut 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::DragonTrainer, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 9893);
        let (v0, _, _) = 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::get_trainer_meta_info(arg2);
        if (0x2::linked_table::contains<address, QueenCustody>(&arg0.queen_custody, v0)) {
            let QueenCustody {
                family_type   : _,
                mystical_bee  : v4,
                sui_bidded    : v5,
                auction_epoch : v6,
            } = 0x2::linked_table::remove<address, QueenCustody>(&mut arg0.queen_custody, v0);
            let v7 = v4;
            let v8 = QueenClaimedByItsOwner{
                trainer_addr  : v0,
                version       : 0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::get_bee_version(&v7),
                sui_bidded    : v5,
                auction_epoch : v6,
            };
            0x2::event::emit<QueenClaimedByItsOwner>(v8);
            let v9 = 0x2::linked_table::borrow<u64, BidPool>(&arg0.bid_pools, v6);
            let v10 = 0;
            let v11 = 0;
            if (v9.total_sui_bidded > 0) {
                v10 = (0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::math::mul_div_u256((v9.total_hive_energy as u256), (v5 as u256), (v9.total_sui_bidded as u256)) as u64);
                v11 = (0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::math::mul_div_u256((v9.total_health as u256), (v5 as u256), (v9.total_sui_bidded as u256)) as u64);
            };
            0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::return_bee_from_competition(&arg0.hive_kraft_cap, arg1, arg2, v7, v10, v11);
            return
        };
        assert!(0x2::linked_table::borrow<address, ParticipationPosition>(&arg0.participating_bees.user_participation, v0).auction_start_at < arg0.current_auction.auction_start_epoch, 9903);
        let (v12, v13, v14, v15, v16, v17, v18) = destroy_user_position(0x2::linked_table::remove<address, ParticipationPosition>(&mut arg0.participating_bees.user_participation, v0));
        let v19 = 0x2::linked_table::borrow_mut<u64, BidPool>(&mut arg0.bid_pools, v13);
        let v20 = 0;
        let v21 = 0;
        if (v19.total_sui_bidded > 0) {
            v20 = (0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::math::mul_div_u256((v19.total_hive_energy as u256), (v17 as u256), (v19.total_sui_bidded as u256)) as u64);
            v21 = (0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::math::mul_div_u256((v19.total_health as u256), (v17 as u256), (v19.total_sui_bidded as u256)) as u64);
        };
        0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v19.sui_available, v17 - v18), 0x2::tx_context::sender(arg3), arg3);
        0xa625276074430123d8dec9905f8c7c449601fef74e5ac6e5f0d4f4b5eefb0e0a::dragon_trainer::return_bee_from_competition(&arg0.hive_kraft_cap, arg1, arg2, v12, v20, v21);
        let v22 = UserBeeReturned{
            bidder_trainer   : v16,
            username         : v15,
            bee_version      : v14,
            bid_amt          : v17,
            tax              : v18,
            auction_start_at : v13,
        };
        0x2::event::emit<UserBeeReturned>(v22);
    }

    // decompiled from Move bytecode v6
}

