module 0x9677ab37c9e1097d11034848aee570c50f5c981a2d12756faccbd07d90d502c2::reputation {
    struct Reputation has key {
        id: 0x2::object::UID,
        holder: address,
        score: u64,
        submission_count: u64,
    }

    struct CreditTicket has key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
        recipient: address,
        score_delta: u64,
    }

    struct ReputationMinted has copy, drop {
        rep_id: 0x2::object::ID,
        holder: address,
    }

    struct CreditIssued has copy, drop {
        ticket_id: 0x2::object::ID,
        form_id: 0x2::object::ID,
        recipient: address,
        score_delta: u64,
    }

    struct CreditClaimed has copy, drop {
        rep_id: 0x2::object::ID,
        holder: address,
        score_delta: u64,
        new_score: u64,
    }

    public fun claim_credit(arg0: CreditTicket, arg1: &mut Reputation) {
        let CreditTicket {
            id          : v0,
            form_id     : _,
            recipient   : v2,
            score_delta : v3,
        } = arg0;
        assert!(arg1.holder == v2, 100);
        arg1.score = arg1.score + v3;
        arg1.submission_count = arg1.submission_count + 1;
        0x2::object::delete(v0);
        let v4 = CreditClaimed{
            rep_id      : 0x2::object::id<Reputation>(arg1),
            holder      : arg1.holder,
            score_delta : v3,
            new_score   : arg1.score,
        };
        0x2::event::emit<CreditClaimed>(v4);
    }

    public fun holder(arg0: &Reputation) : address {
        arg0.holder
    }

    public fun issue_credit(arg0: &0x9677ab37c9e1097d11034848aee570c50f5c981a2d12756faccbd07d90d502c2::form::FormOwnerCap, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = CreditTicket{
            id          : 0x2::object::new(arg3),
            form_id     : 0x9677ab37c9e1097d11034848aee570c50f5c981a2d12756faccbd07d90d502c2::form::cap_form_id(arg0),
            recipient   : arg1,
            score_delta : arg2,
        };
        let v1 = CreditIssued{
            ticket_id   : 0x2::object::id<CreditTicket>(&v0),
            form_id     : v0.form_id,
            recipient   : arg1,
            score_delta : arg2,
        };
        0x2::event::emit<CreditIssued>(v1);
        0x2::transfer::transfer<CreditTicket>(v0, arg1);
    }

    public fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Reputation{
            id               : 0x2::object::new(arg0),
            holder           : 0x2::tx_context::sender(arg0),
            score            : 0,
            submission_count : 0,
        };
        let v1 = ReputationMinted{
            rep_id : 0x2::object::id<Reputation>(&v0),
            holder : v0.holder,
        };
        0x2::event::emit<ReputationMinted>(v1);
        0x2::transfer::transfer<Reputation>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun score(arg0: &Reputation) : u64 {
        arg0.score
    }

    public fun submission_count(arg0: &Reputation) : u64 {
        arg0.submission_count
    }

    public fun ticket_form_id(arg0: &CreditTicket) : 0x2::object::ID {
        arg0.form_id
    }

    public fun ticket_recipient(arg0: &CreditTicket) : address {
        arg0.recipient
    }

    public fun ticket_score_delta(arg0: &CreditTicket) : u64 {
        arg0.score_delta
    }

    // decompiled from Move bytecode v6
}

