module 0x75b7f5d2926f333d8849726655904111420d4f86acb2578274b31338bcf8142c::reputation {
    struct Reputation has key {
        id: 0x2::object::UID,
        subject: address,
        critic: address,
        total: u64,
        score_sum: u64,
    }

    struct ReputationCreated has copy, drop {
        reputation_id: 0x2::object::ID,
        subject: address,
        critic: address,
    }

    struct CriticRating has copy, drop {
        reputation_id: 0x2::object::ID,
        subject: address,
        critic: address,
        score: u8,
        verdict: 0x1::string::String,
        ref_tx: 0x1::string::String,
        avg_x100: u64,
    }

    public fun average_x100(arg0: &Reputation) : u64 {
        if (arg0.total == 0) {
            0
        } else {
            arg0.score_sum * 100 / arg0.total
        }
    }

    public fun create_reputation(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = Reputation{
            id        : 0x2::object::new(arg1),
            subject   : arg0,
            critic    : 0x2::tx_context::sender(arg1),
            total     : 0,
            score_sum : 0,
        };
        let v1 = 0x2::object::id<Reputation>(&v0);
        let v2 = ReputationCreated{
            reputation_id : v1,
            subject       : arg0,
            critic        : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<ReputationCreated>(v2);
        0x2::transfer::share_object<Reputation>(v0);
        v1
    }

    entry fun create_reputation_entry(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        create_reputation(arg0, arg1);
    }

    public fun critic(arg0: &Reputation) : address {
        arg0.critic
    }

    public fun subject(arg0: &Reputation) : address {
        arg0.subject
    }

    public fun submit_rating(arg0: &mut Reputation, arg1: u8, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.critic, 2);
        assert!(arg1 <= 100, 1);
        arg0.total = arg0.total + 1;
        arg0.score_sum = arg0.score_sum + (arg1 as u64);
        let v0 = CriticRating{
            reputation_id : 0x2::object::id<Reputation>(arg0),
            subject       : arg0.subject,
            critic        : arg0.critic,
            score         : arg1,
            verdict       : arg2,
            ref_tx        : arg3,
            avg_x100      : arg0.score_sum * 100 / arg0.total,
        };
        0x2::event::emit<CriticRating>(v0);
    }

    public fun total(arg0: &Reputation) : u64 {
        arg0.total
    }

    // decompiled from Move bytecode v6
}

