module 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::voting {
    struct TemplateVotes has key {
        id: 0x2::object::UID,
        template_id: address,
        upvotes: u64,
        downvotes: u64,
    }

    struct VoteRecord has copy, drop, store {
        value: u8,
    }

    struct TemplateVotesInitialized has copy, drop {
        template_id: address,
        votes_id: address,
    }

    struct VoteCast has copy, drop {
        template_id: address,
        voter: address,
        value: u8,
        upvotes: u64,
        downvotes: u64,
    }

    public fun clear_vote(arg0: &mut TemplateVotes, arg1: &0x2::tx_context::TxContext) {
        set_vote(arg0, 0, arg1);
    }

    public fun downvote(arg0: &mut TemplateVotes, arg1: &0x2::tx_context::TxContext) {
        set_vote(arg0, 2, arg1);
    }

    public fun downvotes(arg0: &TemplateVotes) : u64 {
        arg0.downvotes
    }

    public fun init_template_votes(arg0: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::template::FormTemplate, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::template::creator(arg0) == 0x2::tx_context::sender(arg1), 1);
        let v0 = TemplateVotes{
            id          : 0x2::object::new(arg1),
            template_id : 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::template::id_address(arg0),
            upvotes     : 0,
            downvotes   : 0,
        };
        let v1 = TemplateVotesInitialized{
            template_id : v0.template_id,
            votes_id    : 0x2::object::uid_to_address(&v0.id),
        };
        0x2::event::emit<TemplateVotesInitialized>(v1);
        0x2::transfer::share_object<TemplateVotes>(v0);
    }

    fun remove_existing(arg0: &mut TemplateVotes, arg1: address) : u8 {
        if (!0x2::dynamic_field::exists_<address>(&arg0.id, arg1)) {
            return 0
        };
        let v0 = 0x2::dynamic_field::remove<address, VoteRecord>(&mut arg0.id, arg1);
        if (v0.value == 1) {
            arg0.upvotes = arg0.upvotes - 1;
        } else if (v0.value == 2) {
            arg0.downvotes = arg0.downvotes - 1;
        };
        v0.value
    }

    fun set_vote(arg0: &mut TemplateVotes, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = remove_existing(arg0, v0);
        let v2 = if (arg1 == v1) {
            0
        } else {
            arg1
        };
        if (v2 == 1) {
            let v3 = VoteRecord{value: 1};
            0x2::dynamic_field::add<address, VoteRecord>(&mut arg0.id, v0, v3);
            arg0.upvotes = arg0.upvotes + 1;
        } else if (v2 == 2) {
            let v4 = VoteRecord{value: 2};
            0x2::dynamic_field::add<address, VoteRecord>(&mut arg0.id, v0, v4);
            arg0.downvotes = arg0.downvotes + 1;
        };
        let v5 = VoteCast{
            template_id : arg0.template_id,
            voter       : v0,
            value       : v2,
            upvotes     : arg0.upvotes,
            downvotes   : arg0.downvotes,
        };
        0x2::event::emit<VoteCast>(v5);
    }

    public fun template_id(arg0: &TemplateVotes) : address {
        arg0.template_id
    }

    public fun upvote(arg0: &mut TemplateVotes, arg1: &0x2::tx_context::TxContext) {
        set_vote(arg0, 1, arg1);
    }

    public fun upvotes(arg0: &TemplateVotes) : u64 {
        arg0.upvotes
    }

    public fun vote_down() : u8 {
        2
    }

    public fun vote_none() : u8 {
        0
    }

    public fun vote_of(arg0: &TemplateVotes, arg1: address) : u8 {
        if (!0x2::dynamic_field::exists_<address>(&arg0.id, arg1)) {
            return 0
        };
        0x2::dynamic_field::borrow<address, VoteRecord>(&arg0.id, arg1).value
    }

    public fun vote_up() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

