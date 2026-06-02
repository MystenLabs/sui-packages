module 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::bounty {
    struct Bounty has key {
        id: 0x2::object::UID,
        repo_id: 0x2::object::ID,
        funder: address,
        title: 0x1::string::String,
        amount: u64,
        escrow: 0x2::balance::Balance<0x2::sui::SUI>,
        status: u8,
        claimant: 0x1::option::Option<address>,
        proof: 0x1::option::Option<0x1::string::String>,
        min_score: u64,
    }

    struct BountyPosted has copy, drop {
        bounty_id: 0x2::object::ID,
        repo_id: 0x2::object::ID,
        funder: address,
        amount: u64,
        title: 0x1::string::String,
        min_score: u64,
    }

    struct BountyClaimed has copy, drop {
        bounty_id: 0x2::object::ID,
        claimant: address,
    }

    struct BountySubmitted has copy, drop {
        bounty_id: 0x2::object::ID,
        proof: 0x1::string::String,
    }

    struct BountyPaid has copy, drop {
        bounty_id: 0x2::object::ID,
        claimant: address,
        paid: u64,
        fee: u64,
    }

    struct BountyCancelled has copy, drop {
        bounty_id: 0x2::object::ID,
    }

    public fun approve_bounty(arg0: &mut Bounty, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.funder == 0x2::tx_context::sender(arg1), 0);
        assert!(arg0.status == 1, 2);
        let v0 = *0x1::option::borrow<address>(&arg0.claimant);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.escrow);
        let v2 = v1 * 250 / 10000;
        let v3 = v1 - v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.escrow, v3, arg1), v0);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.escrow, v2, arg1), arg0.funder);
        };
        arg0.status = 2;
        let v4 = BountyPaid{
            bounty_id : 0x2::object::id<Bounty>(arg0),
            claimant  : v0,
            paid      : v3,
            fee       : v2,
        };
        0x2::event::emit<BountyPaid>(v4);
    }

    public fun bounty_amount(arg0: &Bounty) : u64 {
        arg0.amount
    }

    public fun bounty_claimant(arg0: &Bounty) : 0x1::option::Option<address> {
        arg0.claimant
    }

    public fun bounty_escrow_value(arg0: &Bounty) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.escrow)
    }

    public fun bounty_funder(arg0: &Bounty) : address {
        arg0.funder
    }

    public fun bounty_min_score(arg0: &Bounty) : u64 {
        arg0.min_score
    }

    public fun bounty_proof(arg0: &Bounty) : 0x1::option::Option<0x1::string::String> {
        arg0.proof
    }

    public fun bounty_repo(arg0: &Bounty) : 0x2::object::ID {
        arg0.repo_id
    }

    public fun bounty_status(arg0: &Bounty) : u8 {
        arg0.status
    }

    public fun cancel_bounty(arg0: &mut Bounty, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.funder == 0x2::tx_context::sender(arg1), 0);
        assert!(arg0.status == 0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.escrow, 0x2::balance::value<0x2::sui::SUI>(&arg0.escrow), arg1), arg0.funder);
        arg0.status = 3;
        let v0 = BountyCancelled{bounty_id: 0x2::object::id<Bounty>(arg0)};
        0x2::event::emit<BountyCancelled>(v0);
    }

    public fun claim_bounty(arg0: &mut Bounty, arg1: &0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::reputation::RepoReputation, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 1);
        assert!(0x1::option::is_none<address>(&arg0.claimant), 4);
        if (arg0.min_score > 0) {
            assert!(0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::reputation::ledger_repo(arg1) == arg0.repo_id, 6);
            assert!(0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::reputation::score_of(arg1, 0x2::tx_context::sender(arg2)) >= arg0.min_score, 6);
        };
        arg0.claimant = 0x1::option::some<address>(0x2::tx_context::sender(arg2));
        arg0.status = 1;
        let v0 = BountyClaimed{
            bounty_id : 0x2::object::id<Bounty>(arg0),
            claimant  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<BountyClaimed>(v0);
    }

    public fun fee_bps() : u64 {
        250
    }

    public fun post_bounty(arg0: &0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::Repository, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 5);
        let v1 = Bounty{
            id        : 0x2::object::new(arg4),
            repo_id   : 0x2::object::id<0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::Repository>(arg0),
            funder    : 0x2::tx_context::sender(arg4),
            title     : arg1,
            amount    : v0,
            escrow    : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
            status    : 0,
            claimant  : 0x1::option::none<address>(),
            proof     : 0x1::option::none<0x1::string::String>(),
            min_score : arg3,
        };
        let v2 = BountyPosted{
            bounty_id : 0x2::object::id<Bounty>(&v1),
            repo_id   : v1.repo_id,
            funder    : v1.funder,
            amount    : v0,
            title     : v1.title,
            min_score : arg3,
        };
        0x2::event::emit<BountyPosted>(v2);
        0x2::transfer::share_object<Bounty>(v1);
    }

    public fun status_cancelled() : u8 {
        3
    }

    public fun status_claimed() : u8 {
        1
    }

    public fun status_open() : u8 {
        0
    }

    public fun status_paid() : u8 {
        2
    }

    public fun submit_bounty(arg0: &mut Bounty, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::option::contains<address>(&arg0.claimant, &v0), 3);
        arg0.proof = 0x1::option::some<0x1::string::String>(arg1);
        let v1 = BountySubmitted{
            bounty_id : 0x2::object::id<Bounty>(arg0),
            proof     : arg1,
        };
        0x2::event::emit<BountySubmitted>(v1);
    }

    // decompiled from Move bytecode v7
}

