module 0x80a710472adc37cc6deced075780f2ac44a0e8cad534f4edc1c1e2f994878c7b::suilens_bounty {
    struct Bounty has store, key {
        id: 0x2::object::UID,
        creator: address,
        title: 0x1::string::String,
        description: 0x1::string::String,
        requirements: 0x1::string::String,
        category: 0x1::string::String,
        reward_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        reward_amount: u64,
        deadline: u64,
        status: u8,
        submissions: 0x2::vec_set::VecSet<0x2::object::ID>,
        winner: 0x1::option::Option<address>,
        winner_submission_id: 0x1::option::Option<0x2::object::ID>,
        metadata: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        created_at: u64,
        completed_at: 0x1::option::Option<u64>,
    }

    struct BountySubmission has store, key {
        id: 0x2::object::UID,
        bounty_id: 0x2::object::ID,
        submitter: address,
        submission_url: 0x1::string::String,
        description: 0x1::string::String,
        twitter_link: 0x1::option::Option<0x1::string::String>,
        metadata: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        submitted_at: u64,
        is_winner: bool,
    }

    struct BountyRegistry has key {
        id: 0x2::object::UID,
        bounties: 0x2::table::Table<0x2::object::ID, Bounty>,
        submissions: 0x2::table::Table<0x2::object::ID, BountySubmission>,
        user_bounties: 0x2::table::Table<address, 0x2::vec_set::VecSet<0x2::object::ID>>,
        user_submissions: 0x2::table::Table<address, 0x2::vec_set::VecSet<0x2::object::ID>>,
        active_bounties: 0x2::vec_set::VecSet<0x2::object::ID>,
        total_bounties: u64,
        total_rewards_distributed: u64,
        platform_fee_rate: u64,
        platform_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct BountyCreated has copy, drop {
        bounty_id: 0x2::object::ID,
        creator: address,
        title: 0x1::string::String,
        reward_amount: u64,
        deadline: u64,
    }

    struct BountySubmitted has copy, drop {
        submission_id: 0x2::object::ID,
        bounty_id: 0x2::object::ID,
        submitter: address,
    }

    struct WinnerSelected has copy, drop {
        bounty_id: 0x2::object::ID,
        winner: address,
        submission_id: 0x2::object::ID,
        reward_amount: u64,
    }

    struct BountyCancelled has copy, drop {
        bounty_id: 0x2::object::ID,
        creator: address,
        refund_amount: u64,
    }

    struct RewardClaimed has copy, drop {
        bounty_id: 0x2::object::ID,
        winner: address,
        amount: u64,
    }

    public fun add_bounty_metadata(arg0: &mut BountyRegistry, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, Bounty>(&arg0.bounties, arg1), 1);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Bounty>(&mut arg0.bounties, arg1);
        assert!(v0.creator == 0x2::tx_context::sender(arg4), 0);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0.metadata, arg2, arg3);
    }

    public fun add_submission_metadata(arg0: &mut BountyRegistry, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, BountySubmission>(&arg0.submissions, arg1), 2);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, BountySubmission>(&mut arg0.submissions, arg1);
        assert!(v0.submitter == 0x2::tx_context::sender(arg4), 0);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0.metadata, arg2, arg3);
    }

    public fun cancel_bounty(arg0: &mut BountyRegistry, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<0x2::object::ID, Bounty>(&arg0.bounties, arg1), 1);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, Bounty>(&mut arg0.bounties, arg1);
        assert!(v1.creator == v0, 0);
        assert!(v1.status != 2, 10);
        assert!(0x1::option::is_none<address>(&v1.winner), 10);
        v1.status = 3;
        if (0x2::vec_set::contains<0x2::object::ID>(&arg0.active_bounties, &arg1)) {
            0x2::vec_set::remove<0x2::object::ID>(&mut arg0.active_bounties, &arg1);
        };
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&v1.reward_balance);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v1.reward_balance), arg2), v0);
        };
        let v3 = BountyCancelled{
            bounty_id     : arg1,
            creator       : v0,
            refund_amount : v2,
        };
        0x2::event::emit<BountyCancelled>(v3);
    }

    public fun claim_bounty_reward(arg0: &mut BountyRegistry, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<0x2::object::ID, Bounty>(&arg0.bounties, arg1), 1);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, Bounty>(&mut arg0.bounties, arg1);
        assert!(v1.status == 2, 10);
        assert!(0x1::option::is_some<address>(&v1.winner), 8);
        assert!(*0x1::option::borrow<address>(&v1.winner) == v0, 8);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v1.reward_balance) > 0, 7);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&v1.reward_balance);
        let v3 = v2 * arg0.platform_fee_rate / 10000;
        let v4 = v2 - v3;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.platform_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v1.reward_balance, v3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v1.reward_balance), arg2), v0);
        arg0.total_rewards_distributed = arg0.total_rewards_distributed + v4;
        let v5 = RewardClaimed{
            bounty_id : arg1,
            winner    : v0,
            amount    : v4,
        };
        0x2::event::emit<RewardClaimed>(v5);
    }

    public fun create_bounty(arg0: &mut BountyRegistry, arg1: &0x80a710472adc37cc6deced075780f2ac44a0e8cad534f4edc1c1e2f994878c7b::suilens_core::GlobalRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        assert!(0x80a710472adc37cc6deced075780f2ac44a0e8cad534f4edc1c1e2f994878c7b::suilens_core::has_user_profile(arg1, v0), 9);
        assert!(arg6 > v1, 4);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg7);
        assert!(v2 > 0, 6);
        let v3 = 0x2::object::new(arg9);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = Bounty{
            id                   : v3,
            creator              : v0,
            title                : arg2,
            description          : arg3,
            requirements         : arg4,
            category             : arg5,
            reward_balance       : 0x2::coin::into_balance<0x2::sui::SUI>(arg7),
            reward_amount        : v2,
            deadline             : arg6,
            status               : 0,
            submissions          : 0x2::vec_set::empty<0x2::object::ID>(),
            winner               : 0x1::option::none<address>(),
            winner_submission_id : 0x1::option::none<0x2::object::ID>(),
            metadata             : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            created_at           : v1,
            completed_at         : 0x1::option::none<u64>(),
        };
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.user_bounties, v0)) {
            0x2::table::add<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.user_bounties, v0, 0x2::vec_set::empty<0x2::object::ID>());
        };
        0x2::vec_set::insert<0x2::object::ID>(0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.user_bounties, v0), v4);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.active_bounties, v4);
        let v6 = BountyCreated{
            bounty_id     : v4,
            creator       : v0,
            title         : v5.title,
            reward_amount : v2,
            deadline      : arg6,
        };
        0x2::event::emit<BountyCreated>(v6);
        0x2::table::add<0x2::object::ID, Bounty>(&mut arg0.bounties, v4, v5);
        arg0.total_bounties = arg0.total_bounties + 1;
    }

    public fun get_active_bounties(arg0: &BountyRegistry) : 0x2::vec_set::VecSet<0x2::object::ID> {
        arg0.active_bounties
    }

    public fun get_bounty(arg0: &BountyRegistry, arg1: 0x2::object::ID) : &Bounty {
        0x2::table::borrow<0x2::object::ID, Bounty>(&arg0.bounties, arg1)
    }

    public fun get_platform_stats(arg0: &BountyRegistry) : (u64, u64, u64) {
        (arg0.total_bounties, arg0.total_rewards_distributed, 0x2::balance::value<0x2::sui::SUI>(&arg0.platform_balance))
    }

    public fun get_submission(arg0: &BountyRegistry, arg1: 0x2::object::ID) : &BountySubmission {
        0x2::table::borrow<0x2::object::ID, BountySubmission>(&arg0.submissions, arg1)
    }

    public fun get_submission_count(arg0: &BountyRegistry, arg1: 0x2::object::ID) : u64 {
        0x2::vec_set::size<0x2::object::ID>(&0x2::table::borrow<0x2::object::ID, Bounty>(&arg0.bounties, arg1).submissions)
    }

    public fun get_user_bounties(arg0: &BountyRegistry, arg1: address) : 0x2::vec_set::VecSet<0x2::object::ID> {
        if (0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.user_bounties, arg1)) {
            *0x2::table::borrow<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.user_bounties, arg1)
        } else {
            0x2::vec_set::empty<0x2::object::ID>()
        }
    }

    public fun get_user_submissions(arg0: &BountyRegistry, arg1: address) : 0x2::vec_set::VecSet<0x2::object::ID> {
        if (0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.user_submissions, arg1)) {
            *0x2::table::borrow<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.user_submissions, arg1)
        } else {
            0x2::vec_set::empty<0x2::object::ID>()
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BountyRegistry{
            id                        : 0x2::object::new(arg0),
            bounties                  : 0x2::table::new<0x2::object::ID, Bounty>(arg0),
            submissions               : 0x2::table::new<0x2::object::ID, BountySubmission>(arg0),
            user_bounties             : 0x2::table::new<address, 0x2::vec_set::VecSet<0x2::object::ID>>(arg0),
            user_submissions          : 0x2::table::new<address, 0x2::vec_set::VecSet<0x2::object::ID>>(arg0),
            active_bounties           : 0x2::vec_set::empty<0x2::object::ID>(),
            total_bounties            : 0,
            total_rewards_distributed : 0,
            platform_fee_rate         : 250,
            platform_balance          : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<BountyRegistry>(v0);
    }

    public fun is_bounty_active(arg0: &BountyRegistry, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : bool {
        if (!0x2::table::contains<0x2::object::ID, Bounty>(&arg0.bounties, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<0x2::object::ID, Bounty>(&arg0.bounties, arg1);
        (v0.status == 0 || v0.status == 1) && 0x2::clock::timestamp_ms(arg2) < v0.deadline
    }

    public fun select_winner(arg0: &mut BountyRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, Bounty>(&arg0.bounties, arg1), 1);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Bounty>(&mut arg0.bounties, arg1);
        assert!(v0.creator == 0x2::tx_context::sender(arg4), 0);
        assert!(v0.status == 1, 10);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&v0.submissions, &arg2), 2);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, BountySubmission>(&mut arg0.submissions, arg2);
        v1.is_winner = true;
        v0.winner = 0x1::option::some<address>(v1.submitter);
        v0.winner_submission_id = 0x1::option::some<0x2::object::ID>(arg2);
        v0.status = 2;
        v0.completed_at = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg3));
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.active_bounties, &arg1);
        let v2 = WinnerSelected{
            bounty_id     : arg1,
            winner        : v1.submitter,
            submission_id : arg2,
            reward_amount : v0.reward_amount,
        };
        0x2::event::emit<WinnerSelected>(v2);
    }

    public fun submit_bounty_work(arg0: &mut BountyRegistry, arg1: &0x80a710472adc37cc6deced075780f2ac44a0e8cad534f4edc1c1e2f994878c7b::suilens_core::GlobalRegistry, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::option::Option<0x1::string::String>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        assert!(0x80a710472adc37cc6deced075780f2ac44a0e8cad534f4edc1c1e2f994878c7b::suilens_core::has_user_profile(arg1, v0), 9);
        assert!(0x2::table::contains<0x2::object::ID, Bounty>(&arg0.bounties, arg2), 1);
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, Bounty>(&mut arg0.bounties, arg2);
        assert!(v2.status == 0 || v2.status == 1, 5);
        assert!(v1 < v2.deadline, 4);
        let v3 = 0x2::object::new(arg7);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = BountySubmission{
            id             : v3,
            bounty_id      : arg2,
            submitter      : v0,
            submission_url : arg3,
            description    : arg4,
            twitter_link   : arg5,
            metadata       : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            submitted_at   : v1,
            is_winner      : false,
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut v2.submissions, v4);
        if (v2.status == 0) {
            v2.status = 1;
        };
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.user_submissions, v0)) {
            0x2::table::add<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.user_submissions, v0, 0x2::vec_set::empty<0x2::object::ID>());
        };
        0x2::vec_set::insert<0x2::object::ID>(0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.user_submissions, v0), arg2);
        0x2::table::add<0x2::object::ID, BountySubmission>(&mut arg0.submissions, v4, v5);
        let v6 = BountySubmitted{
            submission_id : v4,
            bounty_id     : arg2,
            submitter     : v0,
        };
        0x2::event::emit<BountySubmitted>(v6);
    }

    // decompiled from Move bytecode v6
}

