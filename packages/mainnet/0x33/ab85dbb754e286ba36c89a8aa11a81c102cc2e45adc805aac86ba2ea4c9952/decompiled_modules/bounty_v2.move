module 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::bounty_v2 {
    struct Submission has copy, drop, store {
        submission_id: 0x2::object::ID,
        claimer: address,
        walrus_blob_id: 0x2::object::ID,
        pack_id: 0x1::option::Option<0x2::object::ID>,
        submitted_at_ms: u64,
    }

    struct BountyV2 has key {
        id: 0x2::object::UID,
        poster: address,
        wal_escrow: 0x2::balance::Balance<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>,
        deadline_ms: u64,
        description_hash: vector<u8>,
        min_score: u8,
        submissions: vector<Submission>,
        accepted: 0x1::option::Option<0x2::object::ID>,
        completed: bool,
    }

    struct SubmissionMarker has key {
        id: 0x2::object::UID,
    }

    public fun accepted_submission(arg0: &BountyV2) : 0x1::option::Option<0x2::object::ID> {
        arg0.accepted
    }

    public fun cancel_and_refund_v2(arg0: &mut BountyV2, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.completed, 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::err_bounty_completed());
        assert!(0x2::tx_context::sender(arg2) == arg0.poster, 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::err_not_poster());
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.deadline_ms, 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::err_bounty_still_active());
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.accepted), 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::err_no_accepted());
        let v0 = 0x2::balance::value<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(&arg0.wal_escrow);
        let v1 = arg0.poster;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>>(0x2::coin::from_balance<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(0x2::balance::split<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(&mut arg0.wal_escrow, v0), arg2), v1);
        0x2::balance::destroy_zero<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(0x2::balance::withdraw_all<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(&mut arg0.wal_escrow));
        arg0.completed = true;
        0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::events::emit_bounty_cancelled_v2(0x2::object::id<BountyV2>(arg0), v1, v0);
    }

    fun find_claimer(arg0: &BountyV2, arg1: 0x2::object::ID) : address {
        let v0 = find_submission_index(arg0, arg1);
        assert!(0x1::option::is_some<u64>(&v0), 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::err_submission_not_found());
        0x1::vector::borrow<Submission>(&arg0.submissions, *0x1::option::borrow<u64>(&v0)).claimer
    }

    fun find_submission_index(arg0: &BountyV2, arg1: 0x2::object::ID) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Submission>(&arg0.submissions)) {
            if (0x1::vector::borrow<Submission>(&arg0.submissions, v0).submission_id == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun fulfill_bounty_v2(arg0: &mut BountyV2, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.completed, 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::err_bounty_completed());
        assert!(0x2::tx_context::sender(arg1) == arg0.poster, 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::err_not_poster());
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.accepted), 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::err_no_accepted());
        let v0 = find_claimer(arg0, *0x1::option::borrow<0x2::object::ID>(&arg0.accepted));
        let v1 = 0x2::balance::value<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(&arg0.wal_escrow);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>>(0x2::coin::from_balance<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(0x2::balance::split<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(&mut arg0.wal_escrow, v1), arg1), v0);
        0x2::balance::destroy_zero<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(0x2::balance::withdraw_all<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(&mut arg0.wal_escrow));
        arg0.completed = true;
        0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::events::emit_bounty_paid_v2(0x2::object::id<BountyV2>(arg0), v0, v1);
    }

    public fun is_completed(arg0: &BountyV2) : bool {
        arg0.completed
    }

    public fun post_bounty_v2(arg0: &0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::admin::Config, arg1: 0x2::coin::Coin<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>, arg2: u64, arg3: vector<u8>, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::admin::assert_not_paused(arg0);
        assert!(arg2 > 0x2::clock::timestamp_ms(arg5), 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::err_bounty_deadline());
        let v0 = 0x2::coin::value<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(&arg1);
        assert!(v0 > 0, 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::err_bounty_zero());
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = BountyV2{
            id               : 0x2::object::new(arg6),
            poster           : v1,
            wal_escrow       : 0x2::coin::into_balance<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(arg1),
            deadline_ms      : arg2,
            description_hash : arg3,
            min_score        : arg4,
            submissions      : 0x1::vector::empty<Submission>(),
            accepted         : 0x1::option::none<0x2::object::ID>(),
            completed        : false,
        };
        0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::events::emit_bounty_posted_v2(0x2::object::id<BountyV2>(&v2), v1, v0, arg2, arg3, arg4);
        0x2::transfer::share_object<BountyV2>(v2);
    }

    public fun review_submission(arg0: &mut BountyV2, arg1: 0x2::object::ID, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.completed, 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::err_bounty_completed());
        assert!(0x2::tx_context::sender(arg3) == arg0.poster, 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::err_not_poster());
        let v0 = find_submission_index(arg0, arg1);
        assert!(0x1::option::is_some<u64>(&v0), 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::err_submission_not_found());
        if (arg2) {
            arg0.accepted = 0x1::option::some<0x2::object::ID>(arg1);
        } else if (0x1::option::is_some<0x2::object::ID>(&arg0.accepted)) {
            if (*0x1::option::borrow<0x2::object::ID>(&arg0.accepted) == arg1) {
                arg0.accepted = 0x1::option::none<0x2::object::ID>();
            };
        };
        0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::events::emit_fulfillment_reviewed(0x2::object::id<BountyV2>(arg0), arg1, arg2);
    }

    public fun submission_count(arg0: &BountyV2) : u64 {
        0x1::vector::length<Submission>(&arg0.submissions)
    }

    public fun submit_fulfillment_v2(arg0: &0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::admin::Config, arg1: &mut BountyV2, arg2: 0x2::object::ID, arg3: 0x1::option::Option<0x2::object::ID>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::admin::assert_not_paused(arg0);
        assert!(!arg1.completed, 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::err_bounty_completed());
        assert!(0x2::clock::timestamp_ms(arg4) <= arg1.deadline_ms, 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::constants::err_bounty_deadline());
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = SubmissionMarker{id: 0x2::object::new(arg5)};
        let v2 = 0x2::object::id<SubmissionMarker>(&v1);
        let SubmissionMarker { id: v3 } = v1;
        0x2::object::delete(v3);
        let v4 = Submission{
            submission_id   : v2,
            claimer         : v0,
            walrus_blob_id  : arg2,
            pack_id         : arg3,
            submitted_at_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x1::vector::push_back<Submission>(&mut arg1.submissions, v4);
        0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::events::emit_fulfillment_submitted_v2(0x2::object::id<BountyV2>(arg1), v2, v0, arg2);
    }

    // decompiled from Move bytecode v7
}

