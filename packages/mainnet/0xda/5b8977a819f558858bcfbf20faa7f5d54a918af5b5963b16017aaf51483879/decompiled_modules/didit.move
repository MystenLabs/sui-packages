module 0xda5b8977a819f558858bcfbf20faa7f5d54a918af5b5963b16017aaf51483879::didit {
    struct Bounty has store, key {
        id: 0x2::object::UID,
        offchain_bounty_id: 0x1::string::String,
        title: 0x1::string::String,
        description: 0x1::string::String,
        reward: 0x2::balance::Balance<0x2::sui::SUI>,
        creator: address,
        created_at: u64,
        submissions: 0x2::table::Table<address, BountyProof>,
        no_of_submissions: u64,
        active: bool,
    }

    struct BountyCreated has copy, drop {
        bounty_id: 0x2::object::ID,
        creator: address,
        created_at: u64,
    }

    struct BountyCreator has store, key {
        id: 0x2::object::UID,
        address: address,
        created_at: u64,
        image_url: 0x1::string::String,
    }

    struct BountyProof has store, key {
        id: 0x2::object::UID,
        bounty_id: 0x2::object::ID,
        offchain_bounty_proof_id: 0x1::string::String,
        submitter: address,
        submission_no: u64,
        proof_url: 0x1::string::String,
        submitted_at: u64,
    }

    struct SubmissionReceipt has store, key {
        id: 0x2::object::UID,
        bounty_id: 0x2::object::ID,
        offchain_bounty_proof_id: 0x1::string::String,
        submitter: address,
        submission_no: u64,
        proof_url: 0x1::string::String,
        submitted_at: u64,
    }

    struct BountyProofSubmitted has copy, drop {
        offchain_bounty_id: 0x1::string::String,
        submitter: address,
        submission_no: u64,
        submitted_at: u64,
    }

    struct BountyRegistry has store, key {
        id: 0x2::object::UID,
        no_of_bounties: u64,
        creator: 0x2::vec_set::VecSet<address>,
    }

    public fun create_bounty(arg0: &mut BountyRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : BountyCreator {
        let v0 = Bounty{
            id                 : 0x2::object::new(arg5),
            offchain_bounty_id : arg1,
            title              : arg2,
            description        : arg3,
            reward             : 0x2::coin::into_balance<0x2::sui::SUI>(arg4),
            creator            : 0x2::tx_context::sender(arg5),
            created_at         : 0x2::tx_context::epoch_timestamp_ms(arg5),
            submissions        : 0x2::table::new<address, BountyProof>(arg5),
            no_of_submissions  : 0,
            active             : true,
        };
        let v1 = BountyCreated{
            bounty_id  : 0x2::object::uid_to_inner(&v0.id),
            creator    : 0x2::tx_context::sender(arg5),
            created_at : 0x2::tx_context::epoch_timestamp_ms(arg5),
        };
        0x2::event::emit<BountyCreated>(v1);
        0x2::transfer::share_object<Bounty>(v0);
        let v2 = BountyCreator{
            id         : 0x2::object::new(arg5),
            address    : 0x2::tx_context::sender(arg5),
            created_at : 0x2::tx_context::epoch_timestamp_ms(arg5),
            image_url  : 0x1::string::utf8(b"https://example.com"),
        };
        arg0.no_of_bounties = arg0.no_of_bounties + 1;
        0x2::vec_set::insert<address>(&mut arg0.creator, 0x2::tx_context::sender(arg5));
        v2
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BountyRegistry{
            id             : 0x2::object::new(arg0),
            no_of_bounties : 0,
            creator        : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<BountyRegistry>(v0);
    }

    public fun submit_bounty_proof(arg0: &mut Bounty, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.no_of_submissions + 1;
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v2 = 0x2::object::uid_to_inner(&arg0.id);
        let v3 = 0x2::tx_context::sender(arg3);
        let v4 = BountyProof{
            id                       : 0x2::object::new(arg3),
            bounty_id                : v2,
            offchain_bounty_proof_id : arg1,
            submitter                : v3,
            submission_no            : v0,
            proof_url                : arg2,
            submitted_at             : v1,
        };
        let v5 = SubmissionReceipt{
            id                       : 0x2::object::new(arg3),
            bounty_id                : v2,
            offchain_bounty_proof_id : arg1,
            submitter                : v3,
            submission_no            : v0,
            proof_url                : arg2,
            submitted_at             : v1,
        };
        arg0.no_of_submissions = arg0.no_of_submissions + 1;
        0x2::table::add<address, BountyProof>(&mut arg0.submissions, v3, v4);
        let v6 = BountyProofSubmitted{
            offchain_bounty_id : arg1,
            submitter          : v3,
            submission_no      : v0,
            submitted_at       : v1,
        };
        0x2::event::emit<BountyProofSubmitted>(v6);
        0x2::transfer::transfer<SubmissionReceipt>(v5, v3);
    }

    // decompiled from Move bytecode v6
}

