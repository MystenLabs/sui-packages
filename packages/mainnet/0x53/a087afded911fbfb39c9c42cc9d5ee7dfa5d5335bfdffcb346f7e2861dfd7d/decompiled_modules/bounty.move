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

    struct BountyTerms has key {
        id: 0x2::object::UID,
        bounty_id: 0x2::object::ID,
        deadline_ms: u64,
        proof_required: bool,
    }

    struct BountyTermsSet has copy, drop {
        bounty_id: 0x2::object::ID,
        deadline_ms: u64,
        proof_required: bool,
    }

    struct BountyExpired has copy, drop {
        bounty_id: 0x2::object::ID,
    }

    struct BountyDispute has key {
        id: 0x2::object::UID,
        bounty_id: 0x2::object::ID,
        opener: address,
        reason: 0x1::string::String,
        resolved: bool,
        payout_bps: u64,
    }

    struct DisputeOpened has copy, drop {
        dispute_id: 0x2::object::ID,
        bounty_id: 0x2::object::ID,
        opener: address,
        reason: 0x1::string::String,
    }

    struct DisputeResolved has copy, drop {
        dispute_id: 0x2::object::ID,
        bounty_id: 0x2::object::ID,
        payout_bps: u64,
        paid: u64,
        refunded: u64,
        fee: u64,
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

    public fun approve_bounty_v2(arg0: &mut Bounty, arg1: &BountyTerms, arg2: &mut 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::playground::Treasury, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.funder == 0x2::tx_context::sender(arg3), 0);
        assert!(arg0.status == 1, 2);
        assert!(arg1.bounty_id == 0x2::object::id<Bounty>(arg0), 14);
        if (arg1.proof_required) {
            assert!(0x1::option::is_some<0x1::string::String>(&arg0.proof), 11);
        };
        let v0 = *0x1::option::borrow<address>(&arg0.claimant);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.escrow);
        let v2 = v1 * 250 / 10000;
        let v3 = v1 - v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.escrow, v3, arg3), v0);
        if (v2 > 0) {
            0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::playground::deposit_fee(arg2, 0x2::coin::take<0x2::sui::SUI>(&mut arg0.escrow, v2, arg3));
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

    fun build_bounty(arg0: &0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::Repository, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
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
        let v2 = 0x2::object::id<Bounty>(&v1);
        let v3 = BountyPosted{
            bounty_id : v2,
            repo_id   : v1.repo_id,
            funder    : v1.funder,
            amount    : v0,
            title     : v1.title,
            min_score : arg3,
        };
        0x2::event::emit<BountyPosted>(v3);
        0x2::transfer::share_object<Bounty>(v1);
        v2
    }

    public fun cancel_bounty(arg0: &mut Bounty, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.funder == 0x2::tx_context::sender(arg1), 0);
        assert!(arg0.status == 0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.escrow, 0x2::balance::value<0x2::sui::SUI>(&arg0.escrow), arg1), arg0.funder);
        arg0.status = 3;
        let v0 = BountyCancelled{bounty_id: 0x2::object::id<Bounty>(arg0)};
        0x2::event::emit<BountyCancelled>(v0);
    }

    public fun cancel_expired(arg0: &mut Bounty, arg1: &BountyTerms, arg2: &0x2::clock::Clock, arg3: &mut 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::reputation::ReliabilityLedger, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.funder == 0x2::tx_context::sender(arg4), 0);
        assert!(arg1.bounty_id == 0x2::object::id<Bounty>(arg0), 14);
        assert!(arg0.status == 1, 2);
        assert!(arg1.deadline_ms > 0, 12);
        assert!(0x2::clock::timestamp_ms(arg2) > arg1.deadline_ms, 13);
        0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::reputation::note_expired(arg3, *0x1::option::borrow<address>(&arg0.claimant));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.escrow, 0x2::balance::value<0x2::sui::SUI>(&arg0.escrow), arg4), arg0.funder);
        arg0.status = 3;
        let v0 = BountyExpired{bounty_id: 0x2::object::id<Bounty>(arg0)};
        0x2::event::emit<BountyExpired>(v0);
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

    public fun dispute_bounty(arg0: &BountyDispute) : 0x2::object::ID {
        arg0.bounty_id
    }

    public fun dispute_opener(arg0: &BountyDispute) : address {
        arg0.opener
    }

    public fun dispute_payout_bps(arg0: &BountyDispute) : u64 {
        arg0.payout_bps
    }

    public fun dispute_resolved(arg0: &BountyDispute) : bool {
        arg0.resolved
    }

    public fun fee_bps() : u64 {
        250
    }

    public fun open_dispute(arg0: &mut Bounty, arg1: 0x1::string::String, arg2: &mut 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::reputation::ReliabilityLedger, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 2);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.funder || 0x1::option::contains<address>(&arg0.claimant, &v0), 7);
        0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::reputation::note_disputed(arg2, *0x1::option::borrow<address>(&arg0.claimant));
        arg0.status = 4;
        let v1 = BountyDispute{
            id         : 0x2::object::new(arg3),
            bounty_id  : 0x2::object::id<Bounty>(arg0),
            opener     : v0,
            reason     : arg1,
            resolved   : false,
            payout_bps : 0,
        };
        let v2 = DisputeOpened{
            dispute_id : 0x2::object::id<BountyDispute>(&v1),
            bounty_id  : 0x2::object::id<Bounty>(arg0),
            opener     : v0,
            reason     : v1.reason,
        };
        0x2::event::emit<DisputeOpened>(v2);
        0x2::transfer::share_object<BountyDispute>(v1);
    }

    public fun post_bounty(arg0: &0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::Repository, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        build_bounty(arg0, arg1, arg2, arg3, arg4);
    }

    public fun post_bounty_v2(arg0: &0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::Repository, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = build_bounty(arg0, arg1, arg2, arg3, arg6);
        let v1 = BountyTerms{
            id             : 0x2::object::new(arg6),
            bounty_id      : v0,
            deadline_ms    : arg4,
            proof_required : arg5,
        };
        let v2 = BountyTermsSet{
            bounty_id      : v0,
            deadline_ms    : arg4,
            proof_required : arg5,
        };
        0x2::event::emit<BountyTermsSet>(v2);
        0x2::transfer::share_object<BountyTerms>(v1);
    }

    public fun resolve_dispute(arg0: &mut Bounty, arg1: &mut BountyDispute, arg2: &0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::Repository, arg3: &0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::RepoOwnerCap, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::assert_owner(arg2, arg3);
        assert!(0x2::object::id<0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::Repository>(arg2) == arg0.repo_id, 10);
        assert!(arg1.bounty_id == 0x2::object::id<Bounty>(arg0), 10);
        assert!(!arg1.resolved, 8);
        assert!(arg0.status == 4, 2);
        assert!(arg4 <= 10000, 9);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.escrow) * arg4 / 10000;
        let v1 = v0 * 250 / 10000;
        let v2 = v0 - v1;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.escrow, v2, arg5), *0x1::option::borrow<address>(&arg0.claimant));
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.escrow, v1, arg5), arg0.funder);
        };
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&arg0.escrow);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.escrow, v3, arg5), arg0.funder);
        };
        arg0.status = 2;
        arg1.resolved = true;
        arg1.payout_bps = arg4;
        let v4 = DisputeResolved{
            dispute_id : 0x2::object::id<BountyDispute>(arg1),
            bounty_id  : 0x2::object::id<Bounty>(arg0),
            payout_bps : arg4,
            paid       : v2,
            refunded   : v3,
            fee        : v1,
        };
        0x2::event::emit<DisputeResolved>(v4);
    }

    public fun resolve_dispute_v2(arg0: &mut Bounty, arg1: &mut BountyDispute, arg2: &0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::Repository, arg3: &0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::RepoOwnerCap, arg4: &mut 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::playground::Treasury, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::assert_owner(arg2, arg3);
        assert!(0x2::object::id<0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::forge::Repository>(arg2) == arg0.repo_id, 10);
        assert!(arg1.bounty_id == 0x2::object::id<Bounty>(arg0), 10);
        assert!(!arg1.resolved, 8);
        assert!(arg0.status == 4, 2);
        assert!(arg5 <= 10000, 9);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.escrow) * arg5 / 10000;
        let v1 = v0 * 250 / 10000;
        let v2 = v0 - v1;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.escrow, v2, arg6), *0x1::option::borrow<address>(&arg0.claimant));
        };
        if (v1 > 0) {
            0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::playground::deposit_fee(arg4, 0x2::coin::take<0x2::sui::SUI>(&mut arg0.escrow, v1, arg6));
        };
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&arg0.escrow);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.escrow, v3, arg6), arg0.funder);
        };
        arg0.status = 2;
        arg1.resolved = true;
        arg1.payout_bps = arg5;
        let v4 = DisputeResolved{
            dispute_id : 0x2::object::id<BountyDispute>(arg1),
            bounty_id  : 0x2::object::id<Bounty>(arg0),
            payout_bps : arg5,
            paid       : v2,
            refunded   : v3,
            fee        : v1,
        };
        0x2::event::emit<DisputeResolved>(v4);
    }

    public fun status_cancelled() : u8 {
        3
    }

    public fun status_claimed() : u8 {
        1
    }

    public fun status_disputed() : u8 {
        4
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

    public fun terms_bounty(arg0: &BountyTerms) : 0x2::object::ID {
        arg0.bounty_id
    }

    public fun terms_deadline_ms(arg0: &BountyTerms) : u64 {
        arg0.deadline_ms
    }

    public fun terms_proof_required(arg0: &BountyTerms) : bool {
        arg0.proof_required
    }

    // decompiled from Move bytecode v7
}

