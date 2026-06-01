module 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::bounty {
    struct Bounty has key {
        id: 0x2::object::UID,
        poster: address,
        wal_escrow: 0x2::balance::Balance<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>,
        deadline_ms: u64,
        description_hash: vector<u8>,
        fulfillment_blob_id: 0x1::option::Option<0x2::object::ID>,
        claimer: 0x1::option::Option<address>,
        completed: bool,
    }

    struct BountyPosted has copy, drop {
        bounty_id: 0x2::object::ID,
        poster: address,
        amount_mist: u64,
        deadline_ms: u64,
        description_hash: vector<u8>,
    }

    struct FulfillmentSubmitted has copy, drop {
        bounty_id: 0x2::object::ID,
        claimer: address,
        walrus_blob_id: 0x2::object::ID,
    }

    struct BountyPaid has copy, drop {
        bounty_id: 0x2::object::ID,
        claimer: address,
        amount_mist: u64,
    }

    struct BountyCancelled has copy, drop {
        bounty_id: 0x2::object::ID,
        poster: address,
        refund_mist: u64,
    }

    public fun approve_fulfillment(arg0: &mut Bounty, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.completed, 6);
        assert!(0x2::tx_context::sender(arg1) == arg0.poster, 3);
        assert!(0x1::option::is_some<address>(&arg0.claimer), 4);
        let v0 = *0x1::option::borrow<address>(&arg0.claimer);
        let v1 = 0x2::balance::value<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(&arg0.wal_escrow);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>>(0x2::coin::from_balance<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(0x2::balance::split<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(&mut arg0.wal_escrow, v1), arg1), v0);
        0x2::balance::destroy_zero<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(0x2::balance::withdraw_all<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(&mut arg0.wal_escrow));
        arg0.completed = true;
        let v2 = BountyPaid{
            bounty_id   : 0x2::object::id<Bounty>(arg0),
            claimer     : v0,
            amount_mist : v1,
        };
        0x2::event::emit<BountyPaid>(v2);
    }

    public fun cancel_and_refund(arg0: &mut Bounty, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.completed, 6);
        assert!(0x2::tx_context::sender(arg2) == arg0.poster, 3);
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.deadline_ms, 7);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.fulfillment_blob_id), 4);
        let v0 = 0x2::balance::value<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(&arg0.wal_escrow);
        let v1 = arg0.poster;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>>(0x2::coin::from_balance<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(0x2::balance::split<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(&mut arg0.wal_escrow, v0), arg2), v1);
        0x2::balance::destroy_zero<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(0x2::balance::withdraw_all<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(&mut arg0.wal_escrow));
        arg0.completed = true;
        let v2 = BountyCancelled{
            bounty_id   : 0x2::object::id<Bounty>(arg0),
            poster      : v1,
            refund_mist : v0,
        };
        0x2::event::emit<BountyCancelled>(v2);
    }

    public fun post_bounty(arg0: 0x2::coin::Coin<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>, arg1: u64, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0x2::clock::timestamp_ms(arg3), 1);
        let v0 = 0x2::coin::value<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = Bounty{
            id                  : 0x2::object::new(arg4),
            poster              : v1,
            wal_escrow          : 0x2::coin::into_balance<0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::wal::WAL>(arg0),
            deadline_ms         : arg1,
            description_hash    : arg2,
            fulfillment_blob_id : 0x1::option::none<0x2::object::ID>(),
            claimer             : 0x1::option::none<address>(),
            completed           : false,
        };
        let v3 = BountyPosted{
            bounty_id        : 0x2::object::id<Bounty>(&v2),
            poster           : v1,
            amount_mist      : v0,
            deadline_ms      : arg1,
            description_hash : arg2,
        };
        0x2::event::emit<BountyPosted>(v3);
        0x2::transfer::share_object<Bounty>(v2);
    }

    public fun submit_fulfillment(arg0: &mut Bounty, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.completed, 6);
        assert!(0x2::clock::timestamp_ms(arg2) <= arg0.deadline_ms, 1);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.fulfillment_blob_id), 5);
        let v0 = 0x2::tx_context::sender(arg3);
        arg0.fulfillment_blob_id = 0x1::option::some<0x2::object::ID>(arg1);
        arg0.claimer = 0x1::option::some<address>(v0);
        let v1 = FulfillmentSubmitted{
            bounty_id      : 0x2::object::id<Bounty>(arg0),
            claimer        : v0,
            walrus_blob_id : arg1,
        };
        0x2::event::emit<FulfillmentSubmitted>(v1);
    }

    // decompiled from Move bytecode v7
}

