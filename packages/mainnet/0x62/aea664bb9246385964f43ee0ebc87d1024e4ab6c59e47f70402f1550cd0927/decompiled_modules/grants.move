module 0x62aea664bb9246385964f43ee0ebc87d1024e4ab6c59e47f70402f1550cd0927::grants {
    struct Milestone has key {
        id: 0x2::object::UID,
        project_id: 0x2::object::ID,
        builder: address,
        funder: address,
        title: 0x1::string::String,
        description: 0x1::string::String,
        reward_mist: u64,
        escrow: 0x2::balance::Balance<0x2::sui::SUI>,
        status: u8,
        proof_blob_id: 0x1::string::String,
        proof_hash: 0x1::string::String,
        created_at_ms: u64,
        funded_at_ms: u64,
        submitted_at_ms: u64,
        released_at_ms: u64,
    }

    struct MilestoneCreated has copy, drop {
        milestone_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        builder: address,
        title: 0x1::string::String,
        reward_mist: u64,
        created_at_ms: u64,
    }

    struct MilestoneFunded has copy, drop {
        milestone_id: 0x2::object::ID,
        funder: address,
        reward_mist: u64,
        funded_at_ms: u64,
    }

    struct ProofSubmitted has copy, drop {
        milestone_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        builder: address,
        proof_blob_id: 0x1::string::String,
        proof_hash: 0x1::string::String,
        submitted_at_ms: u64,
    }

    struct FundsReleased has copy, drop {
        milestone_id: 0x2::object::ID,
        builder: address,
        funder: address,
        reward_mist: u64,
        released_at_ms: u64,
    }

    struct MilestoneCancelled has copy, drop {
        milestone_id: 0x2::object::ID,
        funder: address,
        cancelled_at_ms: u64,
    }

    public entry fun cancel_and_refund(arg0: &mut Milestone, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 3);
        assert!(0x2::tx_context::sender(arg2) == arg0.funder, 2);
        arg0.status = 4;
        let v0 = MilestoneCancelled{
            milestone_id    : 0x2::object::id<Milestone>(arg0),
            funder          : arg0.funder,
            cancelled_at_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<MilestoneCancelled>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.escrow), arg2), arg0.funder);
    }

    public entry fun create_milestone(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = Milestone{
            id              : 0x2::object::new(arg5),
            project_id      : arg0,
            builder         : v0,
            funder          : @0x0,
            title           : arg1,
            description     : arg2,
            reward_mist     : arg3,
            escrow          : 0x2::balance::zero<0x2::sui::SUI>(),
            status          : 0,
            proof_blob_id   : 0x1::string::utf8(b""),
            proof_hash      : 0x1::string::utf8(b""),
            created_at_ms   : v1,
            funded_at_ms    : 0,
            submitted_at_ms : 0,
            released_at_ms  : 0,
        };
        let v3 = MilestoneCreated{
            milestone_id  : 0x2::object::id<Milestone>(&v2),
            project_id    : arg0,
            builder       : v0,
            title         : v2.title,
            reward_mist   : arg3,
            created_at_ms : v1,
        };
        0x2::event::emit<MilestoneCreated>(v3);
        0x2::transfer::share_object<Milestone>(v2);
    }

    public entry fun fund_milestone(arg0: &mut Milestone, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.reward_mist, 4);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        arg0.funder = v0;
        arg0.funded_at_ms = v1;
        arg0.status = 1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.escrow, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v2 = MilestoneFunded{
            milestone_id : 0x2::object::id<Milestone>(arg0),
            funder       : v0,
            reward_mist  : arg0.reward_mist,
            funded_at_ms : v1,
        };
        0x2::event::emit<MilestoneFunded>(v2);
    }

    public entry fun release_funds(arg0: &mut Milestone, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 2, 3);
        assert!(0x2::tx_context::sender(arg2) == arg0.funder, 2);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        arg0.released_at_ms = v0;
        arg0.status = 3;
        let v1 = FundsReleased{
            milestone_id   : 0x2::object::id<Milestone>(arg0),
            builder        : arg0.builder,
            funder         : arg0.funder,
            reward_mist    : arg0.reward_mist,
            released_at_ms : v0,
        };
        0x2::event::emit<FundsReleased>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.escrow), arg2), arg0.builder);
    }

    public entry fun submit_proof(arg0: &mut Milestone, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 3);
        assert!(0x2::tx_context::sender(arg4) == arg0.builder, 1);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg0.proof_blob_id = arg1;
        arg0.proof_hash = arg2;
        arg0.submitted_at_ms = v0;
        arg0.status = 2;
        let v1 = ProofSubmitted{
            milestone_id    : 0x2::object::id<Milestone>(arg0),
            project_id      : arg0.project_id,
            builder         : arg0.builder,
            proof_blob_id   : arg0.proof_blob_id,
            proof_hash      : arg0.proof_hash,
            submitted_at_ms : v0,
        };
        0x2::event::emit<ProofSubmitted>(v1);
    }

    // decompiled from Move bytecode v7
}

