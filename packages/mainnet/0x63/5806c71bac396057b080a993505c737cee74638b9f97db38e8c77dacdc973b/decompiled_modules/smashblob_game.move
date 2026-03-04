module 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::smashblob_game {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TreasuryConfig has key {
        id: 0x2::object::UID,
        winner_share_bps: u64,
        voter_share_bps: u64,
        maintenance_share_bps: u64,
        cron_share_bps: u64,
        maintenance_treasury: 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>,
        cron_treasury: 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>,
    }

    struct SmashBlobGame has key {
        id: 0x2::object::UID,
        version: u64,
        current_epoch: CompetitionEpoch,
        last_sui_epoch: u64,
        epoch_data_table: 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::LinkedTable<CompetitionEpoch, 0x2::object::ID>,
        epoch_treasuries: 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::LinkedTable<CompetitionEpoch, 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>,
        minimum_bid_increment: u64,
        max_future_epochs: u64,
        vote_fee: u64,
        cleanup_grace_period_ms: u64,
        competition_start_time_ms: u64,
        min_blob_lifetime_epochs: u32,
    }

    struct EpochStatus has copy, drop, store {
        status: u8,
    }

    struct EpochData has store, key {
        id: 0x2::object::UID,
        epoch_number: u64,
        prompts: 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::RankedPrompts,
        selected_prompt: 0x1::option::Option<u256>,
        prompt_selection_time: 0x1::option::Option<u64>,
        treasury_distributed: 0x1::option::Option<u64>,
        posts: 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::RankedPosts,
        voters: 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::LinkedTable<address, 0x2::vec_set::VecSet<u256>>,
        total_prompts_submitted: u64,
        total_posts_submitted: u64,
        total_votes_cast: u64,
        total_image_size: u64,
        total_text_size: u64,
        total_playable_media_size: u64,
        creation_time_ms: u64,
        winner_address: address,
        epoch_status: EpochStatus,
        highest_bid_amount: u64,
    }

    struct Winners has key {
        id: 0x2::object::UID,
        winners: 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::LinkedTable<CompetitionEpoch, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::Post>,
        winning_prompts: 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::LinkedTable<CompetitionEpoch, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::Prompt>,
        treasury_distributed: 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::LinkedTable<CompetitionEpoch, u64>,
    }

    struct Garbage has key {
        id: 0x2::object::UID,
        garbage: 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::LinkedTable<CompetitionEpoch, EpochRecord>,
    }

    struct EpochRecord has store {
        post_storages: vector<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>,
        voters: 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::LinkedTable<address, 0x2::vec_set::VecSet<u256>>,
        selected_prompt: 0x1::option::Option<u256>,
        remaining_prompts: 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::LinkedTable<u256, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::Prompt>,
        treasury_collected: u64,
        start_time_ms: u64,
        end_time_ms: u64,
        cleanup_deadline_ms: u64,
    }

    struct CompetitionEpoch has copy, drop, store {
        pos0: u64,
    }

    struct StorageEpochKey has copy, drop, store {
        start_epoch: u32,
        end_epoch: u32,
    }

    struct PostSubmitted has copy, drop {
        post_id: u256,
        blob_size: u64,
        blob_object_id: 0x2::object::ID,
        creator: address,
        creator_suins: 0x1::option::Option<0x1::string::String>,
        creator_sui_avatar: 0x1::option::Option<0x1::string::String>,
        parent_prompt: u256,
        epoch: u64,
        submission_time: u64,
        post_type: u64,
    }

    struct VoteCast has copy, drop {
        voter: address,
        post_id: u256,
        new_vote_count: u32,
        epoch: u64,
        timestamp: u64,
    }

    struct VoteRemoved has copy, drop {
        voter: address,
        post_id: u256,
        new_vote_count: u32,
        refund_amount: u64,
        epoch: u64,
        timestamp: u64,
    }

    struct EpochAdvanced has copy, drop {
        old_epoch: u64,
        new_epoch: u64,
        end_time: u64,
        winner: 0x1::option::Option<u256>,
        losers_count: u32,
        treasury_distributed: u64,
        selected_prompt_for_new_epoch: 0x1::option::Option<u256>,
    }

    struct EpochPostsCleaned has copy, drop {
        epoch: u64,
        cleaner: address,
        storage_rebate_earned: u64,
        timestamp: u64,
        storages_processed: u64,
        storages_remaining: u64,
    }

    struct LosingBidsAutoCleaned has copy, drop {
        epoch: u64,
        cleaner: address,
        winner_recipient: address,
        prompts_cleaned: u64,
        prompt_ids: vector<u256>,
        blob_sizes: vector<u64>,
        prompts_remaining: u64,
        timestamp: u64,
    }

    struct PostWon has copy, drop {
        post_id: u256,
        creator: address,
        votes: u32,
        target_epoch: u64,
        parent_prompt_id: u256,
        selection_time: u64,
    }

    struct TreasuryDistributed has copy, drop {
        epoch: u64,
        total_amount: u64,
        winner_amount: u64,
        winner_address: address,
        voter_total: u64,
        voter_count: u64,
        maintenance_amount: u64,
        cron_amount: u64,
        timestamp: u64,
    }

    struct BidWon has copy, drop {
        prompt_id: u256,
        creator: address,
        fee_amount: u64,
        target_epoch: u64,
        selection_time: u64,
    }

    struct EpochDataCreated has copy, drop {
        epoch: u64,
        epoch_data_id: 0x2::object::ID,
        initial_treasury_balance: u64,
        creation_time: u64,
    }

    struct BidSubmitted has copy, drop {
        prompt_id: u256,
        creator: address,
        creator_suins: 0x1::option::Option<0x1::string::String>,
        creator_sui_avatar: 0x1::option::Option<0x1::string::String>,
        blob_size: u64,
        target_epoch: u64,
        blob_id: u256,
        fee_amount: u64,
        submission_time: u64,
    }

    struct BidRaised has copy, drop {
        prompt_id: u256,
        bidder: address,
        raised_amount: u64,
        new_fee_amount: u64,
        epoch: u64,
        raised_time: u64,
    }

    struct BidWithdrawn has copy, drop {
        prompt_id: u256,
        bidder: address,
        target_epoch: u64,
        withdrawn_amount: u64,
        withdrawal_time: u64,
    }

    struct ContractMigrated has copy, drop {
        old_version: u64,
        new_version: u64,
        admin: address,
        timestamp: u64,
    }

    struct BlobExtended has copy, drop {
        epoch: u64,
        blob_id: u256,
        old_end_epoch: u32,
        new_end_epoch: u32,
        epochs_extended: u32,
        cost: u64,
        maintainer: address,
        timestamp: u64,
    }

    public fun get_post_with_info(arg0: &SmashBlobGame, arg1: &EpochData, arg2: u256) : 0x1::option::Option<0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::PostInfoWithoutBlob> {
        let v0 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::get_post_with_info(&arg1.posts, arg2);
        if (0x1::option::is_some<0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::PostInfoWithoutBlob>(&v0)) {
            let v2 = *0x1::option::borrow<0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::PostInfoWithoutBlob>(&v0);
            0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::set_post_info_voters(&mut v2, get_post_voters(arg0, arg1, arg2));
            0x1::option::some<0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::PostInfoWithoutBlob>(v2)
        } else {
            0x1::option::none<0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::PostInfoWithoutBlob>()
        }
    }

    public fun unvote(arg0: &mut SmashBlobGame, arg1: &mut EpochData, arg2: u256, arg3: &mut Winners, arg4: &mut Garbage, arg5: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 100);
        assert!(arg1.epoch_status.status == 1, 21);
        assert!(0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::contains_post(&arg1.posts, arg2), 3);
        assert!(*0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<CompetitionEpoch, 0x2::object::ID>(&arg0.epoch_data_table, arg0.current_epoch) == 0x2::object::id<EpochData>(arg1), 19);
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<address, 0x2::vec_set::VecSet<u256>>(&arg1.voters, v0), 35);
        assert!(0x2::vec_set::contains<u256>(0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<address, 0x2::vec_set::VecSet<u256>>(&arg1.voters, v0), &arg2), 35);
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::unvote(&mut arg1.posts, arg2, arg7);
        let v1 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow_mut<address, 0x2::vec_set::VecSet<u256>>(&mut arg1.voters, v0);
        0x2::vec_set::remove<u256>(v1, &arg2);
        if (0x2::vec_set::is_empty<u256>(v1)) {
            0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::remove<address, 0x2::vec_set::VecSet<u256>>(&mut arg1.voters, v0);
        };
        arg1.total_votes_cast = arg1.total_votes_cast - 1;
        let v2 = VoteRemoved{
            voter          : v0,
            post_id        : arg2,
            new_vote_count : 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::get_post_votes(&arg1.posts, arg2),
            refund_amount  : 0,
            epoch          : arg0.current_epoch.pos0,
            timestamp      : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<VoteRemoved>(v2);
    }

    public fun vote(arg0: &mut SmashBlobGame, arg1: &mut EpochData, arg2: u256, arg3: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg4: &mut Winners, arg5: &mut Garbage, arg6: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 100);
        assert!(arg1.total_votes_cast < 1023, 43);
        assert!(arg1.epoch_status.status == 1, 21);
        assert!(!0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::is_empty(&arg1.posts), 32);
        assert!(0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::contains_post(&arg1.posts, arg2), 3);
        let v0 = arg0.current_epoch;
        assert!(*0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<CompetitionEpoch, 0x2::object::ID>(&arg0.epoch_data_table, v0) == 0x2::object::id<EpochData>(arg1), 19);
        let v1 = 0x2::tx_context::sender(arg8);
        assert!(0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg3) >= arg0.vote_fee, 22);
        if (0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<address, 0x2::vec_set::VecSet<u256>>(&arg1.voters, v1)) {
            let v2 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<address, 0x2::vec_set::VecSet<u256>>(&arg1.voters, v1);
            assert!(0x2::vec_set::length<u256>(v2) < 1024, 1);
            assert!(!0x2::vec_set::contains<u256>(v2, &arg2), 2);
        };
        let v3 = get_or_create_epoch_treasury(arg0, v0);
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v3, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg3));
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::vote(&mut arg1.posts, arg2, arg8);
        if (0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<address, 0x2::vec_set::VecSet<u256>>(&arg1.voters, v1)) {
            0x2::vec_set::insert<u256>(0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow_mut<address, 0x2::vec_set::VecSet<u256>>(&mut arg1.voters, v1), arg2);
        } else {
            0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::push_back<address, 0x2::vec_set::VecSet<u256>>(&mut arg1.voters, v1, 0x2::vec_set::singleton<u256>(arg2));
        };
        arg1.total_votes_cast = arg1.total_votes_cast + 1;
        let v4 = VoteCast{
            voter          : v1,
            post_id        : arg2,
            new_vote_count : 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::get_post_votes(&arg1.posts, arg2),
            epoch          : arg0.current_epoch.pos0,
            timestamp      : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<VoteCast>(v4);
    }

    public fun get_prompt_creator(arg0: &EpochData, arg1: u256) : address {
        assert!(0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::contains(&arg0.prompts, arg1), 18);
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::get_prompt_creator(&arg0.prompts, arg1)
    }

    public fun get_prompt_fee(arg0: &EpochData, arg1: u256) : u64 {
        assert!(0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::contains(&arg0.prompts, arg1), 18);
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::get_prompt_fee(&arg0.prompts, arg1)
    }

    public fun get_prompt_submission_time(arg0: &EpochData, arg1: u256) : u64 {
        assert!(0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::contains(&arg0.prompts, arg1), 18);
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::get_prompt_submission_time(&arg0.prompts, arg1)
    }

    public fun raise_bid(arg0: &mut SmashBlobGame, arg1: &mut EpochData, arg2: u64, arg3: u256, arg4: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg5: &mut Winners, arg6: &mut Garbage, arg7: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg0.version == 1, 100);
        validate_bid_general(arg0, arg1, arg2, arg8, arg9);
        let v0 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg4);
        validate_bid_precision(v0);
        let v1 = CompetitionEpoch{pos0: arg2};
        assert!(v0 > 0, 10);
        let v2 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::get_prompt_fee(&arg1.prompts, arg3) + v0;
        assert!(v2 >= calculate_minimum_bid_to_compete(arg0, arg1, arg2), 22);
        escrow_to_epoch(arg0, v1, arg4);
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::raise_bid(&mut arg1.prompts, arg3, v0, arg9);
        if (v2 > arg1.highest_bid_amount) {
            arg1.highest_bid_amount = v2;
        };
        let v3 = BidRaised{
            prompt_id      : arg3,
            bidder         : 0x2::tx_context::sender(arg9),
            raised_amount  : v0,
            new_fee_amount : v2,
            epoch          : arg2,
            raised_time    : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<BidRaised>(v3);
        v2
    }

    public fun advance_epoch(arg0: &mut SmashBlobGame, arg1: &mut TreasuryConfig, arg2: &mut EpochData, arg3: &mut EpochData, arg4: &mut Winners, arg5: &mut Garbage, arg6: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg7: &0x2::random::Random, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 100);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        let v1 = 0x2::tx_context::epoch(arg9);
        assert!(v1 > arg0.last_sui_epoch, 28);
        assert!(v1 - arg0.last_sui_epoch == 1, 29);
        let v2 = CompetitionEpoch{pos0: arg0.last_sui_epoch};
        assert!(0x2::object::id<EpochData>(arg2) == *0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<CompetitionEpoch, 0x2::object::ID>(&arg0.epoch_data_table, v2), 19);
        assert!(arg2.epoch_status.status == 1, 21);
        arg2.epoch_status.status = 2;
        let v3 = CompetitionEpoch{pos0: v1};
        assert!(0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<CompetitionEpoch, 0x2::object::ID>(&arg0.epoch_data_table, v3), 17);
        assert!(0x2::object::id<EpochData>(arg3) == *0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<CompetitionEpoch, 0x2::object::ID>(&arg0.epoch_data_table, v3), 19);
        assert!(arg3.epoch_status.status == 0, 21);
        arg3.epoch_status.status = 1;
        let v4 = arg0.last_sui_epoch;
        arg0.current_epoch = v3;
        arg0.last_sui_epoch = v1;
        arg0.competition_start_time_ms = 0x2::tx_context::epoch_timestamp_ms(arg9);
        let v5 = get_epoch_treasury_mut(arg0, v2);
        let v6 = 0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v5);
        let v7 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::select_winner(&arg2.posts, arg7, arg9);
        let (v8, v9, v10) = if (0x1::option::is_some<u256>(&v7)) {
            let v11 = *0x1::option::borrow<u256>(&v7);
            let (v12, v13) = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::remove_winner_mut(&mut arg2.posts, v11, arg9);
            let v14 = v13;
            let v15 = v12;
            let (v16, _, v18, _, v20, v21) = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::post_to_summary(&v15);
            let v22 = PostWon{
                post_id          : v16,
                creator          : v18,
                votes            : v20,
                target_epoch     : v4,
                parent_prompt_id : 0x1::option::destroy_with_default<u256>(v21, 0),
                selection_time   : v0,
            };
            0x2::event::emit<PostWon>(v22);
            distribute_prize_pool(arg1, arg2, v5, &v15, v11, v4, v0, arg9);
            let v23 = v6 - 0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v5);
            0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::push_back<CompetitionEpoch, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::Post>(&mut arg4.winners, v2, v15);
            0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::push_back<CompetitionEpoch, u64>(&mut arg4.treasury_distributed, v2, v23);
            arg2.winner_address = v18;
            arg2.treasury_distributed = 0x1::option::some<u64>(v23);
            let v24 = if (!0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::is_empty<u256, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::Post>(&v14)) {
                let v25 = 0x1::vector::empty<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>();
                while (!0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::is_empty<u256, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::Post>(&v14)) {
                    let (_, v27) = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::pop_front<u256, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::Post>(&mut v14);
                    0x1::vector::push_back<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&mut v25, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::delete_blob_and_return_storage(v27, arg6));
                };
                v25
            } else {
                0x1::vector::empty<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>()
            };
            0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::destroy_empty<u256, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::Post>(v14);
            ((0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::length<u256, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::Post>(&v14) as u32), v23, v24)
        } else {
            0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::push_back<CompetitionEpoch, u64>(&mut arg4.treasury_distributed, v2, 0);
            (0, 0, 0x1::vector::empty<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>())
        };
        let v28 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::select_winner(&mut arg3.prompts, arg7, arg9);
        let (v29, v30) = if (0x1::option::is_some<u256>(&v28)) {
            let v31 = *0x1::option::borrow<u256>(&v28);
            let (v32, v33) = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::remove_winner_mut(&mut arg3.prompts, v31, arg9);
            let v34 = v32;
            let v35 = BidWon{
                prompt_id      : 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::get_prompt_id(&v34),
                creator        : 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::get_prompt_creator_from_prompt(&v34),
                fee_amount     : 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::get_prompt_fee_from_prompt(&v34),
                target_epoch   : 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::get_prompt_target_epoch_from_prompt(&v34),
                selection_time : v0,
            };
            0x2::event::emit<BidWon>(v35);
            0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::push_back<CompetitionEpoch, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::Prompt>(&mut arg4.winning_prompts, v3, v34);
            (0x1::option::some<u256>(v31), 0x1::option::some<0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::LinkedTable<u256, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::Prompt>>(v33))
        } else {
            (0x1::option::none<u256>(), 0x1::option::none<0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::LinkedTable<u256, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::Prompt>>())
        };
        let v36 = v30;
        let v37 = v29;
        let v38 = if (0x1::option::is_some<0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::LinkedTable<u256, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::Prompt>>(&v36)) {
            0x1::option::destroy_none<0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::LinkedTable<u256, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::Prompt>>(v36);
            0x1::option::extract<0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::LinkedTable<u256, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::Prompt>>(&mut v36)
        } else {
            0x1::option::destroy_none<0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::LinkedTable<u256, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::Prompt>>(v36);
            0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::new<u256, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::Prompt>(arg9)
        };
        let v39 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::new<address, 0x2::vec_set::VecSet<u256>>(arg9);
        while (!0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::is_empty<address, 0x2::vec_set::VecSet<u256>>(&arg2.voters)) {
            let (v40, v41) = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::pop_front<address, 0x2::vec_set::VecSet<u256>>(&mut arg2.voters);
            0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::push_back<address, 0x2::vec_set::VecSet<u256>>(&mut v39, v40, v41);
        };
        let v42 = EpochRecord{
            post_storages       : v10,
            voters              : v39,
            selected_prompt     : arg2.selected_prompt,
            remaining_prompts   : v38,
            treasury_collected  : v6,
            start_time_ms       : arg2.creation_time_ms,
            end_time_ms         : v0,
            cleanup_deadline_ms : v0 + arg0.cleanup_grace_period_ms,
        };
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::push_back<CompetitionEpoch, EpochRecord>(&mut arg5.garbage, v2, v42);
        arg3.selected_prompt = v37;
        let v43 = if (0x1::option::is_some<u256>(&v37)) {
            0x1::option::some<u64>(v0)
        } else {
            0x1::option::none<u64>()
        };
        arg3.prompt_selection_time = v43;
        let v44 = EpochAdvanced{
            old_epoch                     : v2.pos0,
            new_epoch                     : v3.pos0,
            end_time                      : v0,
            winner                        : v7,
            losers_count                  : v8,
            treasury_distributed          : v9,
            selected_prompt_for_new_epoch : v37,
        };
        0x2::event::emit<EpochAdvanced>(v44);
    }

    fun auto_cleanup_epoch(arg0: &mut SmashBlobGame, arg1: &mut Garbage, arg2: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: CompetitionEpoch, arg4: &0x2::tx_context::TxContext) {
        if (!0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<CompetitionEpoch, EpochRecord>(&arg1.garbage, arg3)) {
            return
        };
        let v0 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::remove<CompetitionEpoch, EpochRecord>(&mut arg1.garbage, arg3);
        if (!0x1::vector::is_empty<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&v0.post_storages)) {
            let v1 = &mut v0.post_storages;
            let (v2, v3) = group_and_fuse_storages_batch(v1, 1000);
            let v4 = v2;
            let v5 = 0;
            while (!0x1::vector::is_empty<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&v4)) {
                let v6 = 0x1::vector::pop_back<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&mut v4);
                v5 = v5 + 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::size(&v6);
                0x2::transfer::public_transfer<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(v6, @0x0);
            };
            0x1::vector::destroy_empty<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(v4);
            let v7 = EpochPostsCleaned{
                epoch                 : arg3.pos0,
                cleaner               : @0x0,
                storage_rebate_earned : v5,
                timestamp             : 0x2::tx_context::epoch_timestamp_ms(arg4),
                storages_processed    : v3,
                storages_remaining    : 0x1::vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&v0.post_storages),
            };
            0x2::event::emit<EpochPostsCleaned>(v7);
        };
        if (0x1::vector::is_empty<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&v0.post_storages) && 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::is_empty<u256, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::Prompt>(&v0.remaining_prompts)) {
            destroy_empty_epoch_record(v0);
            if (0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<CompetitionEpoch, 0x2::object::ID>(&arg0.epoch_data_table, arg3)) {
                0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::remove<CompetitionEpoch, 0x2::object::ID>(&mut arg0.epoch_data_table, arg3);
            };
        } else {
            0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::push_back<CompetitionEpoch, EpochRecord>(&mut arg1.garbage, arg3, v0);
        };
    }

    public fun auto_cleanup_losing_bids(arg0: &mut Garbage, arg1: &Winners, arg2: u64, arg3: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = CompetitionEpoch{pos0: arg2};
        assert!(0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<CompetitionEpoch, EpochRecord>(&arg0.garbage, v0), 7);
        let v1 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow_mut<CompetitionEpoch, EpochRecord>(&mut arg0.garbage, v0);
        if (0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::is_empty<u256, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::Prompt>(&v1.remaining_prompts)) {
            return
        };
        let v2 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::get_prompt_creator_from_prompt(0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<CompetitionEpoch, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::Prompt>(&arg1.winning_prompts, v0));
        let v3 = 0;
        let v4 = 0x1::vector::empty<u256>();
        let v5 = 0x1::vector::empty<u64>();
        while (!0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::is_empty<u256, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::Prompt>(&v1.remaining_prompts) && v3 < 1000) {
            let (v6, v7) = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::pop_front<u256, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::Prompt>(&mut v1.remaining_prompts);
            let v8 = v7;
            0x1::vector::push_back<u256>(&mut v4, v6);
            0x1::vector::push_back<u64>(&mut v5, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::size(0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::get_blob_from_prompt(&v8)));
            0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::delete_blob_from_prompt_and_send_storage(v8, arg3, v2);
            v3 = v3 + 1;
        };
        if (v3 > 0) {
            let v9 = LosingBidsAutoCleaned{
                epoch             : arg2,
                cleaner           : 0x2::tx_context::sender(arg4),
                winner_recipient  : v2,
                prompts_cleaned   : v3,
                prompt_ids        : v4,
                blob_sizes        : v5,
                prompts_remaining : 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::length<u256, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::Prompt>(&v1.remaining_prompts),
                timestamp         : 0x2::tx_context::epoch_timestamp_ms(arg4),
            };
            0x2::event::emit<LosingBidsAutoCleaned>(v9);
        };
    }

    public(friend) fun auto_cleanup_old_garbage_internal(arg0: &mut SmashBlobGame, arg1: &mut Garbage, arg2: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<CompetitionEpoch>();
        let v1 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::front<CompetitionEpoch, EpochRecord>(&arg1.garbage);
        let v2 = 0;
        while (0x1::option::is_some<CompetitionEpoch>(v1) && v2 < 10) {
            let v3 = *0x1::option::borrow<CompetitionEpoch>(v1);
            if (0x2::clock::timestamp_ms(arg3) > 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<CompetitionEpoch, EpochRecord>(&arg1.garbage, v3).cleanup_deadline_ms) {
                0x1::vector::push_back<CompetitionEpoch>(&mut v0, v3);
            };
            v1 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::next<CompetitionEpoch, EpochRecord>(&arg1.garbage, v3);
            v2 = v2 + 1;
        };
        let v4 = 0;
        while (v4 < 0x1::vector::length<CompetitionEpoch>(&v0)) {
            auto_cleanup_epoch(arg0, arg1, arg2, *0x1::vector::borrow<CompetitionEpoch>(&v0, v4), arg4);
            v4 = v4 + 1;
        };
    }

    public fun calculate_minimum_bid_to_compete(arg0: &SmashBlobGame, arg1: &EpochData, arg2: u64) : u64 {
        get_highest_bid_for_epoch(arg0, arg1, arg2) + arg0.minimum_bid_increment
    }

    fun calculate_post_type(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg0 > 0) {
            if (arg1 == 0) {
                arg2 == 0
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            return 1
        };
        let v1 = if (arg1 > 0) {
            if (arg0 == 0) {
                arg2 == 0
            } else {
                false
            }
        } else {
            false
        };
        if (v1) {
            return 2
        };
        let v2 = if (arg2 > 0) {
            if (arg0 == 0) {
                arg1 == 0
            } else {
                false
            }
        } else {
            false
        };
        if (v2) {
            return 3
        };
        let v3 = if (arg0 > 0) {
            if (arg1 > 0) {
                arg2 == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 38);
        4
    }

    public fun cleanup_epoch_posts(arg0: &mut Garbage, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = CompetitionEpoch{pos0: arg1};
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<CompetitionEpoch, EpochRecord>(&arg0.garbage, v0), 7);
        let v3 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow_mut<CompetitionEpoch, EpochRecord>(&mut arg0.garbage, v0);
        assert!(v2 <= v3.cleanup_deadline_ms, 8);
        assert!(!0x1::vector::is_empty<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&v3.post_storages), 16);
        let v4 = &mut v3.post_storages;
        let (v5, v6) = group_and_fuse_storages_batch(v4, 1000);
        let v7 = v5;
        let v8 = 0;
        while (!0x1::vector::is_empty<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&v7)) {
            let v9 = 0x1::vector::pop_back<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&mut v7);
            v8 = v8 + 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::size(&v9);
            0x2::transfer::public_transfer<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(v9, v1);
        };
        0x1::vector::destroy_empty<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(v7);
        let v10 = EpochPostsCleaned{
            epoch                 : arg1,
            cleaner               : v1,
            storage_rebate_earned : v8,
            timestamp             : v2,
            storages_processed    : v6,
            storages_remaining    : 0x1::vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&v3.post_storages),
        };
        0x2::event::emit<EpochPostsCleaned>(v10);
    }

    public fun create_active_epoch_status() : EpochStatus {
        EpochStatus{status: 1}
    }

    public fun create_archived_epoch_status() : EpochStatus {
        EpochStatus{status: 3}
    }

    public fun create_completed_epoch_status() : EpochStatus {
        EpochStatus{status: 2}
    }

    public fun create_future_epoch_status() : EpochStatus {
        EpochStatus{status: 0}
    }

    fun destroy_empty_epoch_record(arg0: EpochRecord) {
        let EpochRecord {
            post_storages       : v0,
            voters              : v1,
            selected_prompt     : v2,
            remaining_prompts   : v3,
            treasury_collected  : _,
            start_time_ms       : _,
            end_time_ms         : _,
            cleanup_deadline_ms : _,
        } = arg0;
        let v8 = v2;
        let v9 = v1;
        0x1::vector::destroy_empty<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(v0);
        while (!0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::is_empty<address, 0x2::vec_set::VecSet<u256>>(&v9)) {
            let (_, _) = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::pop_front<address, 0x2::vec_set::VecSet<u256>>(&mut v9);
        };
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::destroy_empty<address, 0x2::vec_set::VecSet<u256>>(v9);
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::destroy_empty<u256, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::Prompt>(v3);
        if (0x1::option::is_some<u256>(&v8)) {
            0x1::option::destroy_some<u256>(v8);
        } else {
            0x1::option::destroy_none<u256>(v8);
        };
    }

    fun distribute_prize_pool(arg0: &mut TreasuryConfig, arg1: &EpochData, arg2: &mut 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg3: &0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::Post, arg4: u256, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg2);
        if (v0 == 0) {
            return
        };
        let (_, _, v3, _, _, _) = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::post_to_summary(arg3);
        let v7 = safe_mul_div_bps(v0, arg0.winner_share_bps);
        let v8 = safe_mul_div_bps(v0, arg0.voter_share_bps);
        let v9 = safe_mul_div_bps(v0, arg0.maintenance_share_bps);
        let v10 = safe_mul_div_bps(v0, arg0.cron_share_bps);
        let v11 = v9 + v0 - v7 + v8 + v9 + v10;
        let v12 = v11;
        let v13 = get_winning_post_voters(arg1, arg4);
        let v14 = 0x1::vector::length<address>(&v13);
        if (v14 == 0 && v8 > 0) {
            v12 = v11 + v8;
        };
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg2, v7), arg7), v3);
        };
        let v15 = if (v8 > 0 && v14 > 0) {
            let v16 = v8 / (v14 as u64);
            let v17 = 0;
            while (v17 < v14) {
                let v18 = if (v17 == 0) {
                    v16 + v8 - v16 * (v14 as u64)
                } else {
                    v16
                };
                if (v18 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg2, v18), arg7), *0x1::vector::borrow<address>(&v13, v17));
                };
                v17 = v17 + 1;
            };
            v8
        } else {
            0
        };
        if (v12 > 0) {
            0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.maintenance_treasury, 0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg2, v12));
        };
        if (v10 > 0) {
            0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.cron_treasury, 0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg2, v10));
        };
        let v19 = TreasuryDistributed{
            epoch              : arg5,
            total_amount       : v0,
            winner_amount      : v7,
            winner_address     : v3,
            voter_total        : v15,
            voter_count        : (v14 as u64),
            maintenance_amount : v12,
            cron_amount        : v10,
            timestamp          : arg6,
        };
        0x2::event::emit<TreasuryDistributed>(v19);
    }

    fun escrow_to_epoch(arg0: &mut SmashBlobGame, arg1: CompetitionEpoch, arg2: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>) : u64 {
        let v0 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg2);
        let v1 = get_or_create_epoch_treasury(arg0, arg1);
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v1, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg2));
        assert!(0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v1) == 0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v1) + v0, 23);
        v0
    }

    fun extract_optional_metadata(arg0: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::metadata::Metadata) : (0x1::option::Option<0x1::string::String>, 0x1::option::Option<0x1::string::String>) {
        let v0 = 0x1::string::utf8(b"creator_suins");
        let v1 = 0x1::string::utf8(b"creator_sui_avatar");
        let v2 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::metadata::remove_if_exists(arg0, &v0);
        let v3 = if (0x1::option::is_some<0x1::string::String>(&v2)) {
            0x1::option::some<0x1::string::String>(0x1::option::destroy_some<0x1::string::String>(v2))
        } else {
            0x1::option::destroy_none<0x1::string::String>(v2);
            0x1::option::none<0x1::string::String>()
        };
        let v4 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::metadata::remove_if_exists(arg0, &v1);
        let v5 = if (0x1::option::is_some<0x1::string::String>(&v4)) {
            0x1::option::some<0x1::string::String>(0x1::option::destroy_some<0x1::string::String>(v4))
        } else {
            0x1::option::destroy_none<0x1::string::String>(v4);
            0x1::option::none<0x1::string::String>()
        };
        (v3, v5)
    }

    public(friend) fun force_epoch_status_internal(arg0: &mut EpochData, arg1: u8) : (u64, u8) {
        arg0.epoch_status.status = arg1;
        (arg0.epoch_number, arg0.epoch_status.status)
    }

    public fun get_blobs_needing_extension(arg0: &SmashBlobGame, arg1: &Winners, arg2: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System) : u64 {
        let v0 = 0;
        let v1 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::front<CompetitionEpoch, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::Post>(&arg1.winners);
        while (0x1::option::is_some<CompetitionEpoch>(v1)) {
            let v2 = *0x1::option::borrow<CompetitionEpoch>(v1);
            if (0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::get_blob_from_post(0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<CompetitionEpoch, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::Post>(&arg1.winners, v2))) < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg2) + arg0.min_blob_lifetime_epochs) {
                v0 = v0 + 1;
            };
            v1 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::next<CompetitionEpoch, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::Post>(&arg1.winners, v2);
        };
        v0
    }

    public fun get_cron_share_bps(arg0: &TreasuryConfig) : u64 {
        arg0.cron_share_bps
    }

    public fun get_cron_treasury_balance(arg0: &TreasuryConfig) : u64 {
        0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.cron_treasury)
    }

    public(friend) fun get_cron_treasury_mut(arg0: &mut TreasuryConfig) : &mut 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL> {
        &mut arg0.cron_treasury
    }

    public fun get_current_epoch(arg0: &SmashBlobGame) : u64 {
        arg0.current_epoch.pos0
    }

    public fun get_current_epoch_data_id(arg0: &SmashBlobGame) : &0x2::object::ID {
        get_epoch_data_id(arg0, arg0.current_epoch.pos0)
    }

    public fun get_epoch_data_highest_bid(arg0: &EpochData) : u64 {
        arg0.highest_bid_amount
    }

    public fun get_epoch_data_id(arg0: &SmashBlobGame, arg1: u64) : &0x2::object::ID {
        let v0 = CompetitionEpoch{pos0: arg1};
        assert!(0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<CompetitionEpoch, 0x2::object::ID>(&arg0.epoch_data_table, v0), 17);
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<CompetitionEpoch, 0x2::object::ID>(&arg0.epoch_data_table, v0)
    }

    public fun get_epoch_data_number(arg0: &EpochData) : u64 {
        arg0.epoch_number
    }

    public fun get_epoch_data_status(arg0: &EpochData) : u8 {
        arg0.epoch_status.status
    }

    public fun get_epoch_status(arg0: &SmashBlobGame, arg1: u64, arg2: &0x2::tx_context::TxContext) : u8 {
        let v0 = 0x2::tx_context::epoch(arg2);
        if (arg1 > v0) {
            0
        } else if (arg1 == v0) {
            1
        } else {
            2
        }
    }

    public fun get_epoch_status_code(arg0: &EpochStatus) : u8 {
        arg0.status
    }

    public fun get_epoch_storage_rebate(arg0: &Garbage, arg1: u64) : 0x1::option::Option<u64> {
        let v0 = CompetitionEpoch{pos0: arg1};
        if (0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<CompetitionEpoch, EpochRecord>(&arg0.garbage, v0)) {
            let v2 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<CompetitionEpoch, EpochRecord>(&arg0.garbage, v0);
            if (!0x1::vector::is_empty<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&v2.post_storages)) {
                let v3 = 0;
                let v4 = 0;
                while (v4 < 0x1::vector::length<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&v2.post_storages)) {
                    v3 = v3 + 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::size(0x1::vector::borrow<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&v2.post_storages, v4));
                    v4 = v4 + 1;
                };
                0x1::option::some<u64>(v3)
            } else {
                0x1::option::none<u64>()
            }
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun get_epoch_treasury_balance(arg0: &SmashBlobGame, arg1: CompetitionEpoch) : u64 {
        if (0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<CompetitionEpoch, 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(&arg0.epoch_treasuries, arg1)) {
            0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<CompetitionEpoch, 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(&arg0.epoch_treasuries, arg1))
        } else {
            0
        }
    }

    fun get_epoch_treasury_mut(arg0: &mut SmashBlobGame, arg1: CompetitionEpoch) : &mut 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL> {
        assert!(0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<CompetitionEpoch, 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(&arg0.epoch_treasuries, arg1), 24);
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow_mut<CompetitionEpoch, 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(&mut arg0.epoch_treasuries, arg1)
    }

    public fun get_extension_config(arg0: &SmashBlobGame) : u32 {
        arg0.min_blob_lifetime_epochs
    }

    public fun get_future_epochs_info(arg0: &SmashBlobGame) : (u64, u64) {
        let v0 = arg0.current_epoch.pos0;
        let v1 = 0;
        let v2 = v0 + 1;
        while (v2 <= v0 + arg0.max_future_epochs) {
            let v3 = CompetitionEpoch{pos0: v2};
            if (0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<CompetitionEpoch, 0x2::object::ID>(&arg0.epoch_data_table, v3)) {
                v1 = v1 + 1;
            };
            v2 = v2 + 1;
        };
        (v1, v0)
    }

    public fun get_highest_bid_for_epoch(arg0: &SmashBlobGame, arg1: &EpochData, arg2: u64) : u64 {
        let v0 = CompetitionEpoch{pos0: arg2};
        assert!(arg1.epoch_status.status == 0, 21);
        assert!(0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<CompetitionEpoch, 0x2::object::ID>(&arg0.epoch_data_table, v0), 17);
        assert!(0x2::object::id<EpochData>(arg1) == *0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<CompetitionEpoch, 0x2::object::ID>(&arg0.epoch_data_table, v0), 19);
        assert!(arg1.epoch_number == arg2, 19);
        arg1.highest_bid_amount
    }

    public fun get_maintenance_share_bps(arg0: &TreasuryConfig) : u64 {
        arg0.maintenance_share_bps
    }

    public fun get_maintenance_treasury_balance(arg0: &TreasuryConfig) : u64 {
        0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.maintenance_treasury)
    }

    public(friend) fun get_maintenance_treasury_mut(arg0: &mut TreasuryConfig) : &mut 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL> {
        &mut arg0.maintenance_treasury
    }

    fun get_or_create_epoch_treasury(arg0: &mut SmashBlobGame, arg1: CompetitionEpoch) : &mut 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL> {
        if (!0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<CompetitionEpoch, 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(&arg0.epoch_treasuries, arg1)) {
            0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::push_back<CompetitionEpoch, 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(&mut arg0.epoch_treasuries, arg1, 0x2::balance::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>());
        };
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow_mut<CompetitionEpoch, 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(&mut arg0.epoch_treasuries, arg1)
    }

    public fun get_post_voters(arg0: &SmashBlobGame, arg1: &EpochData, arg2: u256) : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::front<address, 0x2::vec_set::VecSet<u256>>(&arg1.voters);
        while (0x1::option::is_some<address>(v1)) {
            let v2 = *0x1::option::borrow<address>(v1);
            if (0x2::vec_set::contains<u256>(0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<address, 0x2::vec_set::VecSet<u256>>(&arg1.voters, v2), &arg2)) {
                0x1::vector::push_back<address>(&mut v0, v2);
            };
            v1 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::next<address, 0x2::vec_set::VecSet<u256>>(&arg1.voters, v2);
        };
        v0
    }

    public fun get_posts_by_selected_prompt(arg0: &SmashBlobGame, arg1: &EpochData) : vector<u256> {
        if (0x1::option::is_some<u256>(&arg1.selected_prompt)) {
            0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::get_posts_by_parent_prompt(&arg1.posts, *0x1::option::borrow<u256>(&arg1.selected_prompt))
        } else {
            0x1::vector::empty<u256>()
        }
    }

    public fun get_treasury_split(arg0: &TreasuryConfig) : (u64, u64, u64, u64) {
        (arg0.winner_share_bps, arg0.voter_share_bps, arg0.maintenance_share_bps, arg0.cron_share_bps)
    }

    public fun get_version(arg0: &SmashBlobGame) : u64 {
        arg0.version
    }

    public fun get_voter_share_bps(arg0: &TreasuryConfig) : u64 {
        arg0.voter_share_bps
    }

    public fun get_winner_share_bps(arg0: &TreasuryConfig) : u64 {
        arg0.winner_share_bps
    }

    fun get_winning_post_voters(arg0: &EpochData, arg1: u256) : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::front<address, 0x2::vec_set::VecSet<u256>>(&arg0.voters);
        while (0x1::option::is_some<address>(v1)) {
            let v2 = *0x1::option::borrow<address>(v1);
            if (0x2::vec_set::contains<u256>(0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<address, 0x2::vec_set::VecSet<u256>>(&arg0.voters, v2), &arg1)) {
                0x1::vector::push_back<address>(&mut v0, v2);
            };
            v1 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::next<address, 0x2::vec_set::VecSet<u256>>(&arg0.voters, v2);
        };
        v0
    }

    fun group_and_fuse_storages_batch(arg0: &mut vector<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>, arg1: u64) : (vector<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>, u64) {
        if (0x1::vector::is_empty<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(arg0)) {
            return (0x1::vector::empty<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(), 0)
        };
        let v0 = 0x2::vec_map::empty<StorageEpochKey, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>();
        let v1 = 0;
        while (!0x1::vector::is_empty<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(arg0) && v1 < arg1) {
            let v2 = 0x1::vector::pop_back<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(arg0);
            let v3 = StorageEpochKey{
                start_epoch : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::start_epoch(&v2),
                end_epoch   : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::end_epoch(&v2),
            };
            if (0x2::vec_map::contains<StorageEpochKey, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&v0, &v3)) {
                0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::fuse_amount(0x2::vec_map::get_mut<StorageEpochKey, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&mut v0, &v3), v2);
            } else {
                0x2::vec_map::insert<StorageEpochKey, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&mut v0, v3, v2);
            };
            v1 = v1 + 1;
        };
        let (_, v5) = 0x2::vec_map::into_keys_values<StorageEpochKey, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(v0);
        (v5, v1)
    }

    public fun has_garbage_for_epoch(arg0: &Garbage, arg1: u64) : bool {
        let v0 = CompetitionEpoch{pos0: arg1};
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<CompetitionEpoch, EpochRecord>(&arg0.garbage, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg0);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg0);
        let v2 = EpochData{
            id                        : 0x2::object::new(arg0),
            epoch_number              : v0,
            prompts                   : 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::new(arg0),
            selected_prompt           : 0x1::option::none<u256>(),
            prompt_selection_time     : 0x1::option::none<u64>(),
            treasury_distributed      : 0x1::option::none<u64>(),
            posts                     : 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::new(arg0),
            voters                    : 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::new<address, 0x2::vec_set::VecSet<u256>>(arg0),
            total_prompts_submitted   : 0,
            total_posts_submitted     : 0,
            total_votes_cast          : 0,
            total_image_size          : 0,
            total_text_size           : 0,
            total_playable_media_size : 0,
            creation_time_ms          : v1,
            winner_address            : @0x0,
            epoch_status              : create_active_epoch_status(),
            highest_bid_amount        : 0,
        };
        let v3 = CompetitionEpoch{pos0: v0};
        let v4 = SmashBlobGame{
            id                        : 0x2::object::new(arg0),
            version                   : 1,
            current_epoch             : v3,
            last_sui_epoch            : v0,
            epoch_data_table          : 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::new<CompetitionEpoch, 0x2::object::ID>(arg0),
            epoch_treasuries          : 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::new<CompetitionEpoch, 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(arg0),
            minimum_bid_increment     : 100000000,
            max_future_epochs         : 10,
            vote_fee                  : 100000000,
            cleanup_grace_period_ms   : 1209600000,
            competition_start_time_ms : v1,
            min_blob_lifetime_epochs  : 10,
        };
        let v5 = CompetitionEpoch{pos0: v0};
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::push_back<CompetitionEpoch, 0x2::object::ID>(&mut v4.epoch_data_table, v5, 0x2::object::id<EpochData>(&v2));
        let v6 = CompetitionEpoch{pos0: v0};
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::push_back<CompetitionEpoch, 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(&mut v4.epoch_treasuries, v6, 0x2::balance::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>());
        0x2::transfer::share_object<SmashBlobGame>(v4);
        let v7 = Winners{
            id                   : 0x2::object::new(arg0),
            winners              : 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::new<CompetitionEpoch, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::Post>(arg0),
            winning_prompts      : 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::new<CompetitionEpoch, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::Prompt>(arg0),
            treasury_distributed : 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::new<CompetitionEpoch, u64>(arg0),
        };
        0x2::transfer::share_object<Winners>(v7);
        let v8 = Garbage{
            id      : 0x2::object::new(arg0),
            garbage : 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::new<CompetitionEpoch, EpochRecord>(arg0),
        };
        0x2::transfer::share_object<Garbage>(v8);
        0x2::transfer::share_object<EpochData>(v2);
        let v9 = TreasuryConfig{
            id                    : 0x2::object::new(arg0),
            winner_share_bps      : 7000,
            voter_share_bps       : 1000,
            maintenance_share_bps : 1500,
            cron_share_bps        : 500,
            maintenance_treasury  : 0x2::balance::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(),
            cron_treasury         : 0x2::balance::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(),
        };
        0x2::transfer::share_object<TreasuryConfig>(v9);
        let v10 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v10, 0x2::tx_context::sender(arg0));
    }

    public fun is_epoch_active(arg0: &EpochStatus) : bool {
        arg0.status == 1
    }

    public fun is_epoch_archived(arg0: &EpochStatus) : bool {
        arg0.status == 3
    }

    public fun is_epoch_completed(arg0: &EpochStatus) : bool {
        arg0.status == 2
    }

    public fun is_epoch_future(arg0: &EpochStatus) : bool {
        arg0.status == 0
    }

    public fun is_epoch_posts_cleaned(arg0: &Garbage, arg1: u64) : bool {
        let v0 = CompetitionEpoch{pos0: arg1};
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<CompetitionEpoch, EpochRecord>(&arg0.garbage, v0) && 0x1::vector::is_empty<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<CompetitionEpoch, EpochRecord>(&arg0.garbage, v0).post_storages) || true
    }

    public fun maintain_hall_of_fame(arg0: &mut SmashBlobGame, arg1: &mut TreasuryConfig, arg2: &mut Winners, arg3: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert!(arg0.version == 1, 100);
        let v0 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg3) + arg0.min_blob_lifetime_epochs;
        let v1 = 0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg1.maintenance_treasury);
        if (v1 == 0) {
            return (0, 0)
        };
        if (0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::is_empty<CompetitionEpoch, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::Post>(&arg2.winners)) {
            return (0, 0)
        };
        let v2 = 0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg1.maintenance_treasury, v1), arg4);
        let v3 = 0;
        let v4 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::front<CompetitionEpoch, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::Post>(&arg2.winners);
        while (0x1::option::is_some<CompetitionEpoch>(v4)) {
            let v5 = *0x1::option::borrow<CompetitionEpoch>(v4);
            let v6 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::get_blob_mut_from_post(0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow_mut<CompetitionEpoch, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::Post>(&mut arg2.winners, v5));
            let v7 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(v6);
            if (v7 < v0) {
                let v8 = v0 - v7;
                let v9 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&v2);
                if (v9 > 0) {
                    0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::extend_blob(arg3, v6, v8, &mut v2);
                    let v10 = v9 - 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&v2);
                    if (v10 > 0) {
                        v3 = v3 + 1;
                        let v11 = BlobExtended{
                            epoch           : v5.pos0,
                            blob_id         : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(v6),
                            old_end_epoch   : v7,
                            new_end_epoch   : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(v6),
                            epochs_extended : v8,
                            cost            : v10,
                            maintainer      : 0x2::tx_context::sender(arg4),
                            timestamp       : 0x2::tx_context::epoch_timestamp_ms(arg4),
                        };
                        0x2::event::emit<BlobExtended>(v11);
                    };
                };
            };
            v4 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::next<CompetitionEpoch, 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::Post>(&arg2.winners, v5);
        };
        if (0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&v2) > 0) {
            0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg1.maintenance_treasury, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v2));
        } else {
            0x2::coin::destroy_zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v2);
        };
        (v3, 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&v2) - 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&v2))
    }

    public fun migrate(arg0: &mut SmashBlobGame, arg1: &0x2::tx_context::TxContext) {
        let v0 = arg0.version;
        assert!(v0 < 1, 102);
        arg0.version = 1;
        let v1 = ContractMigrated{
            old_version : v0,
            new_version : 1,
            admin       : 0x2::tx_context::sender(arg1),
            timestamp   : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<ContractMigrated>(v1);
    }

    public(friend) fun open_new_epoch_admin_internal(arg0: &mut SmashBlobGame, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 100);
        open_new_epoch_internal(arg0, arg1, 0, arg2);
    }

    fun open_new_epoch_internal(arg0: &mut SmashBlobGame, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg3);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg3);
        assert!(arg1 > arg0.current_epoch.pos0, 25);
        assert!(arg1 >= v0, 28);
        let v2 = CompetitionEpoch{pos0: arg1};
        assert!(!0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<CompetitionEpoch, 0x2::object::ID>(&arg0.epoch_data_table, v2), 30);
        let v3 = CompetitionEpoch{pos0: arg1};
        assert!(!0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<CompetitionEpoch, 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(&arg0.epoch_treasuries, v3), 31);
        let (v4, _) = get_future_epochs_info(arg0);
        assert!(v4 + 1 <= arg0.max_future_epochs, 26);
        let v6 = if (arg1 == v0) {
            create_active_epoch_status()
        } else {
            create_future_epoch_status()
        };
        let v7 = EpochData{
            id                        : 0x2::object::new(arg3),
            epoch_number              : arg1,
            prompts                   : 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::new(arg3),
            selected_prompt           : 0x1::option::none<u256>(),
            prompt_selection_time     : 0x1::option::none<u64>(),
            treasury_distributed      : 0x1::option::none<u64>(),
            posts                     : 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::new(arg3),
            voters                    : 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::new<address, 0x2::vec_set::VecSet<u256>>(arg3),
            total_prompts_submitted   : 0,
            total_posts_submitted     : 0,
            total_votes_cast          : 0,
            total_image_size          : 0,
            total_text_size           : 0,
            total_playable_media_size : 0,
            creation_time_ms          : v1,
            winner_address            : @0x0,
            epoch_status              : v6,
            highest_bid_amount        : 0,
        };
        let v8 = 0x2::object::id<EpochData>(&v7);
        let v9 = CompetitionEpoch{pos0: arg1};
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::push_back<CompetitionEpoch, 0x2::object::ID>(&mut arg0.epoch_data_table, v9, v8);
        let v10 = CompetitionEpoch{pos0: arg1};
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::push_back<CompetitionEpoch, 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(&mut arg0.epoch_treasuries, v10, 0x2::balance::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>());
        let v11 = EpochDataCreated{
            epoch                    : arg1,
            epoch_data_id            : v8,
            initial_treasury_balance : arg2,
            creation_time            : v1,
        };
        0x2::event::emit<EpochDataCreated>(v11);
        0x2::transfer::share_object<EpochData>(v7);
    }

    public fun open_new_epoch_with_fee(arg0: &mut SmashBlobGame, arg1: u64, arg2: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 100);
        let v0 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg2);
        assert!(v0 >= 100000000, 22);
        open_new_epoch_internal(arg0, arg1, v0, arg3);
        let v1 = CompetitionEpoch{pos0: arg1};
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(get_or_create_epoch_treasury(arg0, v1), 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg2));
    }

    fun parse_and_update_metadata(arg0: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg1: &mut EpochData) : (u64, 0x1::option::Option<0x1::string::String>, 0x1::option::Option<0x1::string::String>) {
        let v0 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::take_metadata(arg0);
        let v1 = 0x1::string::utf8(b"text");
        let v2 = 0x1::string::utf8(b"image");
        let v3 = 0x1::string::utf8(b"playable_media");
        let v4 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::metadata::remove_if_exists(&mut v0, &v1);
        let v5 = if (0x1::option::is_some<0x1::string::String>(&v4)) {
            let v6 = 0x1::option::destroy_some<0x1::string::String>(v4);
            parse_string_to_u64(&v6)
        } else {
            0x1::option::destroy_none<0x1::string::String>(v4);
            0
        };
        let v7 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::metadata::remove_if_exists(&mut v0, &v2);
        let v8 = if (0x1::option::is_some<0x1::string::String>(&v7)) {
            let v9 = 0x1::option::destroy_some<0x1::string::String>(v7);
            parse_string_to_u64(&v9)
        } else {
            0x1::option::destroy_none<0x1::string::String>(v7);
            0
        };
        let v10 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::metadata::remove_if_exists(&mut v0, &v3);
        let v11 = if (0x1::option::is_some<0x1::string::String>(&v10)) {
            let v12 = 0x1::option::destroy_some<0x1::string::String>(v10);
            parse_string_to_u64(&v12)
        } else {
            0x1::option::destroy_none<0x1::string::String>(v10);
            0
        };
        let v13 = &mut v0;
        let (v14, v15) = extract_optional_metadata(v13);
        arg1.total_text_size = arg1.total_text_size + v5;
        arg1.total_image_size = arg1.total_image_size + v8;
        arg1.total_playable_media_size = arg1.total_playable_media_size + v11;
        (calculate_post_type(v5, v8, v11), v14, v15)
    }

    fun parse_bid_metadata(arg0: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob) : (0x1::option::Option<0x1::string::String>, 0x1::option::Option<0x1::string::String>) {
        let v0 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::take_metadata(arg0);
        let v1 = &mut v0;
        extract_optional_metadata(v1)
    }

    fun parse_string_to_u64(arg0: &0x1::string::String) : u64 {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        if (v1 == 0) {
            return 0
        };
        let v2 = 0;
        let v3 = 0;
        while (v3 < v1) {
            let v4 = *0x1::vector::borrow<u8>(v0, v3);
            if (v4 < 48 || v4 > 57) {
                abort 36
            };
            let v5 = v2 * 10;
            v2 = v5 + ((v4 - 48) as u64);
            v3 = v3 + 1;
        };
        v2
    }

    fun recalculate_highest_bid(arg0: &0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::RankedPrompts) : u64 {
        let v0 = 0;
        let v1 = v0;
        let v2 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::front(arg0);
        while (0x1::option::is_some<u256>(v2)) {
            let v3 = *0x1::option::borrow<u256>(v2);
            let v4 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::get_prompt_fee(arg0, v3);
            if (v4 > v0) {
                v1 = v4;
            };
            v2 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::next(arg0, v3);
        };
        v1
    }

    public(friend) fun refund_epoch_treasury_internal(arg0: &mut SmashBlobGame, arg1: CompetitionEpoch, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg0.version == 1, 100);
        assert!(0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<CompetitionEpoch, 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(&arg0.epoch_treasuries, arg1), 23);
        assert!(arg0.current_epoch.pos0 > arg1.pos0, 39);
        if (arg3) {
            let v0 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::remove<CompetitionEpoch, 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(&mut arg0.epoch_treasuries, arg1);
            let v1 = 0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&v0);
            if (v1 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v0, arg4), arg2);
            } else {
                0x2::balance::destroy_zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v0);
            };
            return v1
        };
        let v2 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow_mut<CompetitionEpoch, 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(&mut arg0.epoch_treasuries, arg1);
        let v3 = 0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v2);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v2, v3), arg4), arg2);
        };
        v3
    }

    fun safe_mul_div_bps(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public(friend) fun set_cleanup_grace_period_internal(arg0: &mut SmashBlobGame, arg1: u64) {
        assert!(arg1 > 0, 10);
        arg0.cleanup_grace_period_ms = arg1;
    }

    public(friend) fun set_extension_epochs_internal(arg0: &mut SmashBlobGame, arg1: u32) {
        assert!(arg1 > 0, 104);
        arg0.min_blob_lifetime_epochs = arg1;
    }

    public(friend) fun set_max_future_epochs_internal(arg0: &mut SmashBlobGame, arg1: u64) {
        assert!(arg1 > 0, 10);
        arg0.max_future_epochs = arg1;
    }

    public(friend) fun set_minimum_bid_increment_internal(arg0: &mut SmashBlobGame, arg1: u64) {
        assert!(arg1 > 0, 10);
        arg0.minimum_bid_increment = arg1;
    }

    public(friend) fun set_treasury_split_internal(arg0: &mut TreasuryConfig, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg1 + arg2 + arg3 + arg4 == 10000, 103);
        arg0.winner_share_bps = arg1;
        arg0.voter_share_bps = arg2;
        arg0.maintenance_share_bps = arg3;
        arg0.cron_share_bps = arg4;
    }

    public(friend) fun set_vote_fee_internal(arg0: &mut SmashBlobGame, arg1: u64) {
        assert!(arg1 > 0, 10);
        arg0.vote_fee = arg1;
    }

    public fun submit_bid(arg0: &mut SmashBlobGame, arg1: &mut EpochData, arg2: u64, arg3: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg4: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg5: &mut Winners, arg6: &mut Garbage, arg7: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u256 {
        assert!(arg0.version == 1, 100);
        validate_bid_general(arg0, arg1, arg2, arg8, arg9);
        let v0 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg4);
        validate_bid_precision(v0);
        assert!(v0 >= calculate_minimum_bid_to_compete(arg0, arg1, arg2), 22);
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::game_utils::validate_blob_for_target_epoch(&arg3, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg7), 0x2::tx_context::epoch(arg9), arg2);
        let v1 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(&arg3);
        let v2 = &mut arg3;
        let (v3, v4) = parse_bid_metadata(v2);
        let v5 = CompetitionEpoch{pos0: arg2};
        escrow_to_epoch(arg0, v5, arg4);
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::add(&mut arg1.prompts, arg3, v0, arg2, arg7, arg8, arg9);
        arg1.total_prompts_submitted = arg1.total_prompts_submitted + 1;
        if (v0 > arg1.highest_bid_amount) {
            arg1.highest_bid_amount = v0;
        };
        let v6 = BidSubmitted{
            prompt_id          : v1,
            creator            : 0x2::tx_context::sender(arg9),
            creator_suins      : v3,
            creator_sui_avatar : v4,
            blob_size          : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::size(&arg3),
            target_epoch       : arg2,
            blob_id            : v1,
            fee_amount         : v0,
            submission_time    : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<BidSubmitted>(v6);
        v1
    }

    public fun submit_post(arg0: &mut SmashBlobGame, arg1: &mut EpochData, arg2: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg3: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg4: &mut Winners, arg5: &mut Garbage, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 100);
        assert!(arg1.total_posts_submitted < 1023, 42);
        assert!(arg1.epoch_status.status == 1, 21);
        assert!(0x1::option::is_some<u256>(&arg1.selected_prompt), 0);
        let v0 = *0x1::option::borrow<u256>(&arg1.selected_prompt);
        assert!(*0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<CompetitionEpoch, 0x2::object::ID>(&arg0.epoch_data_table, arg0.current_epoch) == 0x2::object::id<EpochData>(arg1), 19);
        let v1 = &mut arg2;
        let (v2, v3, v4) = parse_and_update_metadata(v1, arg1);
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::posts::add(&mut arg1.posts, arg2, 0x1::option::some<u256>(v0), arg3, arg6, arg7);
        arg1.total_posts_submitted = arg1.total_posts_submitted + 1;
        let v5 = PostSubmitted{
            post_id            : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(&arg2),
            blob_size          : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::size(&arg2),
            blob_object_id     : 0x2::object::id<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg2),
            creator            : 0x2::tx_context::sender(arg7),
            creator_suins      : v3,
            creator_sui_avatar : v4,
            parent_prompt      : v0,
            epoch              : arg0.current_epoch.pos0,
            submission_time    : 0x2::clock::timestamp_ms(arg6),
            post_type          : v2,
        };
        0x2::event::emit<PostSubmitted>(v5);
    }

    fun validate_bid_general(arg0: &SmashBlobGame, arg1: &EpochData, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x2::clock::timestamp_ms(arg3);
        let v0 = 0x2::tx_context::epoch(arg4);
        let v1 = CompetitionEpoch{pos0: arg2};
        assert!(arg2 > v0, 25);
        assert!(arg2 > arg0.current_epoch.pos0, 28);
        assert!(arg2 <= v0 + arg0.max_future_epochs, 26);
        0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::game_utils::validate_target_epoch(v0, arg2);
        assert!(0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<CompetitionEpoch, 0x2::object::ID>(&arg0.epoch_data_table, v1), 17);
        assert!(0x2::object::id<EpochData>(arg1) == *0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<CompetitionEpoch, 0x2::object::ID>(&arg0.epoch_data_table, v1), 19);
        assert!(arg1.epoch_number == arg2, 19);
        assert!(arg1.epoch_status.status == 0, 21);
    }

    fun validate_bid_precision(arg0: u64) {
        assert!(arg0 % 100000000 == 0, 40);
    }

    public fun withdraw_bid(arg0: &mut SmashBlobGame, arg1: &mut EpochData, arg2: u64, arg3: u256, arg4: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage, 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>) {
        assert!(arg0.version == 1, 100);
        let v0 = CompetitionEpoch{pos0: arg2};
        assert!(arg2 > 0x2::tx_context::epoch(arg6), 25);
        assert!(arg1.epoch_status.status == 0, 21);
        assert!(0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::contains<CompetitionEpoch, 0x2::object::ID>(&arg0.epoch_data_table, v0), 17);
        assert!(0x2::object::id<EpochData>(arg1) == *0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::linked_table::borrow<CompetitionEpoch, 0x2::object::ID>(&arg0.epoch_data_table, v0), 19);
        assert!(arg1.epoch_number == arg2, 19);
        assert!(0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::contains(&arg1.prompts, arg3), 18);
        assert!(0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::get_prompt_creator(&arg1.prompts, arg3) == 0x2::tx_context::sender(arg6), 33);
        let v1 = 0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::get_prompt_fee(&arg1.prompts, arg3);
        assert!(v1 == arg1.highest_bid_amount, 41);
        arg1.total_prompts_submitted = arg1.total_prompts_submitted - 1;
        arg1.highest_bid_amount = recalculate_highest_bid(&arg1.prompts);
        let v2 = BidWithdrawn{
            prompt_id        : arg3,
            bidder           : 0x2::tx_context::sender(arg6),
            target_epoch     : arg2,
            withdrawn_amount : v1,
            withdrawal_time  : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<BidWithdrawn>(v2);
        (0x635806c71bac396057b080a993505c737cee74638b9f97db38e8c77dacdc973b::prompts::cancel_prompt(&mut arg1.prompts, arg3, arg4, arg6), 0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(get_epoch_treasury_mut(arg0, v0), v1), arg6))
    }

    // decompiled from Move bytecode v6
}

