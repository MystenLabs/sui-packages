module 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::covenant {
    struct Commitment has store, key {
        id: 0x2::object::UID,
        committer: address,
        commitment_hash: vector<u8>,
        commitment_type: u8,
        reveal_after: u64,
        reveal_before: u64,
        bond: 0x2::balance::Balance<0x2::sui::SUI>,
        revealed: bool,
        revealed_value: 0x1::option::Option<0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::RevealedValue>,
        executed: bool,
        committed_at: u64,
    }

    struct SealedAuction has store, key {
        id: 0x2::object::UID,
        creator: address,
        item: vector<u8>,
        config: 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::AuctionConfig,
        bids: 0x2::table::Table<address, 0x2::object::ID>,
        total_bids: u64,
        revealed_bids: u64,
        revealed_amounts: 0x2::table::Table<address, u64>,
        winner: 0x1::option::Option<address>,
        winning_bid: 0x1::option::Option<u64>,
        status: u8,
        created_at: u64,
    }

    struct ProtectedBundle has store, key {
        id: 0x2::object::UID,
        submitter: address,
        encrypted_actions: vector<u8>,
        action_count: u64,
        decrypted_actions: 0x1::option::Option<vector<u8>>,
        params: 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::BundleParams,
        bond: 0x2::balance::Balance<0x2::sui::SUI>,
        status: u8,
        submitted_at: u64,
    }

    struct CovenantRegistry has key {
        id: 0x2::object::UID,
        total_commitments: u64,
        total_auctions: u64,
        total_bundles: u64,
        active_auctions: u64,
    }

    public fun auction_status(arg0: &SealedAuction) : u8 {
        arg0.status
    }

    public fun auction_winner(arg0: &SealedAuction) : 0x1::option::Option<address> {
        arg0.winner
    }

    public fun auction_winning_bid(arg0: &SealedAuction) : 0x1::option::Option<u64> {
        arg0.winning_bid
    }

    public fun bundle_status(arg0: &ProtectedBundle) : u8 {
        arg0.status
    }

    public fun create_auction(arg0: &mut CovenantRegistry, arg1: vector<u8>, arg2: 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::AuctionConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : SealedAuction {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::config_commitment_deadline(&arg2) > v0, 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::invalid_timestamp());
        assert!(0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::config_reveal_deadline(&arg2) > 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::config_commitment_deadline(&arg2), 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::invalid_timestamp());
        let v2 = SealedAuction{
            id               : 0x2::object::new(arg4),
            creator          : v1,
            item             : arg1,
            config           : arg2,
            bids             : 0x2::table::new<address, 0x2::object::ID>(arg4),
            total_bids       : 0,
            revealed_bids    : 0,
            revealed_amounts : 0x2::table::new<address, u64>(arg4),
            winner           : 0x1::option::none<address>(),
            winning_bid      : 0x1::option::none<u64>(),
            status           : 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::auction_status_open(),
            created_at       : v0,
        };
        arg0.total_auctions = arg0.total_auctions + 1;
        arg0.active_auctions = arg0.active_auctions + 1;
        0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::events::emit_auction_created(0x2::object::id<SealedAuction>(&v2), v1, arg1, 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::config_min_bid(&arg2), 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::config_commitment_deadline(&arg2), 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::config_reveal_deadline(&arg2), v0);
        v2
    }

    public fun create_bid_hash(arg0: u64, arg1: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 8) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 & 255) as u8));
            arg0 = arg0 >> 8;
            v1 = v1 + 1;
        };
        create_commitment_hash(&v0, arg1)
    }

    public fun create_commitment_hash(arg0: &vector<u8>, arg1: &vector<u8>) : vector<u8> {
        let v0 = *arg0;
        0x1::vector::append<u8>(&mut v0, *arg1);
        0x2::hash::keccak256(&v0)
    }

    public fun execute_bundle(arg0: &mut ProtectedBundle, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(0x2::tx_context::sender(arg2) == arg0.submitter, 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::not_authorized());
        assert!(0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::is_bundle_ready(arg0.status), 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::invalid_status());
        assert!(!0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::is_bundle_params_expired(&arg0.params, v0), 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::bundle_expired());
        arg0.status = 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::bundle_status_executed();
        0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::events::emit_bundle_executed(0x2::object::id<ProtectedBundle>(arg0), arg0.submitter, arg0.action_count, 0, v0);
    }

    public fun execute_commitment(arg0: &mut Commitment, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.committer, 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::not_authorized());
        assert!(arg0.revealed, 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::commitment_not_revealed());
        assert!(!arg0.executed, 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::already_executed());
        arg0.executed = true;
        0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::events::emit_commitment_executed(0x2::object::id<Commitment>(arg0), v0, 0x2::clock::timestamp_ms(arg1));
    }

    public fun expire_bundle(arg0: &mut ProtectedBundle, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::is_bundle_params_expired(&arg0.params, v0), 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::execution_time_not_reached());
        assert!(0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::is_bundle_pending(arg0.status) || 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::is_bundle_ready(arg0.status), 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::invalid_status());
        arg0.status = 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::bundle_status_expired();
        0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::events::emit_bundle_expired(0x2::object::id<ProtectedBundle>(arg0), v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.bond), arg2)
    }

    public fun finalize_auction(arg0: &mut CovenantRegistry, arg1: &mut SealedAuction, arg2: vector<address>, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::config_reveal_deadline(&arg1.config), 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::reveal_deadline_not_reached());
        assert!(!0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::is_auction_complete(arg1.status), 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::auction_already_finalized());
        let v1 = 0;
        let v2 = v1;
        let v3 = 0x1::option::none<address>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<address>(&arg2)) {
            let v5 = *0x1::vector::borrow<address>(&arg2, v4);
            if (0x2::table::contains<address, u64>(&arg1.revealed_amounts, v5)) {
                let v6 = *0x2::table::borrow<address, u64>(&arg1.revealed_amounts, v5);
                if (v6 > v1) {
                    v2 = v6;
                    v3 = 0x1::option::some<address>(v5);
                };
            };
            v4 = v4 + 1;
        };
        arg1.winner = v3;
        let v7 = if (v2 > 0) {
            0x1::option::some<u64>(v2)
        } else {
            0x1::option::none<u64>()
        };
        arg1.winning_bid = v7;
        arg1.status = 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::auction_status_complete();
        arg0.active_auctions = arg0.active_auctions - 1;
        0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::events::emit_auction_finalized(0x2::object::id<SealedAuction>(arg1), arg1.winner, arg1.winning_bid, arg1.total_bids, arg1.revealed_bids, v0);
    }

    public fun forfeit_commitment(arg0: Commitment, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(!arg0.revealed, 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::already_revealed());
        assert!(v0 >= arg0.reveal_before, 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::too_early_to_reveal());
        let Commitment {
            id              : v1,
            committer       : _,
            commitment_hash : _,
            commitment_type : _,
            reveal_after    : _,
            reveal_before   : _,
            bond            : v7,
            revealed        : _,
            revealed_value  : _,
            executed        : _,
            committed_at    : _,
        } = arg0;
        0x2::object::delete(v1);
        0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::events::emit_commitment_bond_forfeited(0x2::object::id<Commitment>(&arg0), arg0.committer, 0x2::balance::value<0x2::sui::SUI>(&arg0.bond), b"Failed to reveal", v0);
        0x2::coin::from_balance<0x2::sui::SUI>(v7, arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CovenantRegistry{
            id                : 0x2::object::new(arg0),
            total_commitments : 0,
            total_auctions    : 0,
            total_bundles     : 0,
            active_auctions   : 0,
        };
        0x2::transfer::share_object<CovenantRegistry>(v0);
    }

    public fun is_commitment_executed(arg0: &Commitment) : bool {
        arg0.executed
    }

    public fun is_commitment_revealed(arg0: &Commitment) : bool {
        arg0.revealed
    }

    public fun make_commitment(arg0: &mut CovenantRegistry, arg1: vector<u8>, arg2: u8, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : Commitment {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0x2::tx_context::sender(arg7);
        assert!(arg3 > v0, 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::invalid_timestamp());
        assert!(arg4 > arg3, 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::invalid_timestamp());
        assert!(0x1::vector::length<u8>(&arg1) == 32, 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::invalid_amount());
        let v2 = Commitment{
            id              : 0x2::object::new(arg7),
            committer       : v1,
            commitment_hash : arg1,
            commitment_type : arg2,
            reveal_after    : arg3,
            reveal_before   : arg4,
            bond            : 0x2::coin::into_balance<0x2::sui::SUI>(arg5),
            revealed        : false,
            revealed_value  : 0x1::option::none<0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::RevealedValue>(),
            executed        : false,
            committed_at    : v0,
        };
        arg0.total_commitments = arg0.total_commitments + 1;
        0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::events::emit_commitment_made(0x2::object::id<Commitment>(&v2), v1, arg2, arg1, arg3, arg4, 0x2::coin::value<0x2::sui::SUI>(&arg5), v0);
        v2
    }

    public fun mark_bundle_decrypted(arg0: &mut ProtectedBundle, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(0x2::tx_context::sender(arg3) == arg0.submitter, 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::not_authorized());
        assert!(0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::is_bundle_pending(arg0.status), 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::invalid_status());
        assert!(v0 >= 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::bundle_execute_at(&arg0.params), 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::execution_time_not_reached());
        arg0.decrypted_actions = 0x1::option::some<vector<u8>>(arg1);
        arg0.status = 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::bundle_status_ready();
        0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::events::emit_bundle_decrypted(0x2::object::id<ProtectedBundle>(arg0), v0);
    }

    public fun registry_active_auctions(arg0: &CovenantRegistry) : u64 {
        arg0.active_auctions
    }

    public fun registry_total_auctions(arg0: &CovenantRegistry) : u64 {
        arg0.total_auctions
    }

    public fun registry_total_commitments(arg0: &CovenantRegistry) : u64 {
        arg0.total_commitments
    }

    public fun return_bond(arg0: Commitment, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.revealed, 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::commitment_not_revealed());
        assert!(arg0.executed, 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::not_found());
        assert!(0x2::tx_context::sender(arg2) == arg0.committer, 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::not_authorized());
        let Commitment {
            id              : v0,
            committer       : _,
            commitment_hash : _,
            commitment_type : _,
            reveal_after    : _,
            reveal_before   : _,
            bond            : v6,
            revealed        : _,
            revealed_value  : _,
            executed        : _,
            committed_at    : _,
        } = arg0;
        0x2::object::delete(v0);
        0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::events::emit_commitment_bond_returned(0x2::object::id<Commitment>(&arg0), arg0.committer, 0x2::balance::value<0x2::sui::SUI>(&arg0.bond), 0x2::clock::timestamp_ms(arg1));
        0x2::coin::from_balance<0x2::sui::SUI>(v6, arg2)
    }

    public fun reveal_bid(arg0: &mut SealedAuction, arg1: &Commitment, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v0 >= 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::config_commitment_deadline(&arg0.config), 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::auction_not_in_reveal_phase());
        assert!(v0 < 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::config_reveal_deadline(&arg0.config), 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::reveal_deadline_passed());
        assert!(0x2::table::contains<address, 0x2::object::ID>(&arg0.bids, v1), 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::no_bid_found());
        assert!(*0x2::table::borrow<address, 0x2::object::ID>(&arg0.bids, v1) == 0x2::object::id<Commitment>(arg1), 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::not_found());
        assert!(arg1.revealed, 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::commitment_not_revealed());
        assert!(arg2 >= 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::config_min_bid(&arg0.config), 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::bid_below_minimum());
        0x2::table::add<address, u64>(&mut arg0.revealed_amounts, v1, arg2);
        arg0.revealed_bids = arg0.revealed_bids + 1;
        if (0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::is_auction_open(arg0.status)) {
            arg0.status = 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::auction_status_reveal();
            0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::events::emit_auction_reveal_phase_started(0x2::object::id<SealedAuction>(arg0), arg0.total_bids, v0);
        };
        0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::events::emit_bid_revealed(0x2::object::id<SealedAuction>(arg0), v1, arg2, v0);
    }

    public fun reveal_commitment(arg0: &mut Commitment, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(v1 == arg0.committer, 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::not_authorized());
        assert!(!arg0.revealed, 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::already_revealed());
        assert!(v0 >= arg0.reveal_after, 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::too_early_to_reveal());
        assert!(v0 < arg0.reveal_before, 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::too_late_to_reveal());
        0x1::vector::append<u8>(&mut arg1, arg2);
        assert!(0x2::hash::keccak256(&arg1) == arg0.commitment_hash, 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::hash_mismatch());
        arg0.revealed = true;
        arg0.revealed_value = 0x1::option::some<0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::RevealedValue>(0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::new_revealed_value(arg1, arg2, v0));
        0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::events::emit_commitment_revealed(0x2::object::id<Commitment>(arg0), v1, 0x2::hash::keccak256(&arg1), v0);
    }

    public fun submit_bid(arg0: &mut SealedAuction, arg1: &Commitment, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::is_auction_open(arg0.status), 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::auction_not_open());
        assert!(v0 < 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::config_commitment_deadline(&arg0.config), 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::bid_deadline_passed());
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.bids, v1), 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::already_bid());
        assert!(arg1.committer == v1, 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::not_authorized());
        assert!(arg1.commitment_type == 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::commitment_type_bid(), 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::invalid_commitment_type());
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.bids, v1, 0x2::object::id<Commitment>(arg1));
        arg0.total_bids = arg0.total_bids + 1;
        0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::events::emit_bid_committed(0x2::object::id<SealedAuction>(arg0), v1, arg1.commitment_hash, 0x2::balance::value<0x2::sui::SUI>(&arg1.bond), v0);
    }

    public fun submit_bundle(arg0: &mut CovenantRegistry, arg1: vector<u8>, arg2: u64, arg3: 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::BundleParams, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : ProtectedBundle {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::tx_context::sender(arg6);
        assert!(0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::bundle_execute_at(&arg3) > v0, 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::invalid_timestamp());
        assert!(0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::bundle_expires_at(&arg3) > 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::bundle_execute_at(&arg3), 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::invalid_timestamp());
        assert!(arg2 > 0, 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::errors::empty_vector());
        let v2 = ProtectedBundle{
            id                : 0x2::object::new(arg6),
            submitter         : v1,
            encrypted_actions : arg1,
            action_count      : arg2,
            decrypted_actions : 0x1::option::none<vector<u8>>(),
            params            : arg3,
            bond              : 0x2::coin::into_balance<0x2::sui::SUI>(arg4),
            status            : 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::bundle_status_pending(),
            submitted_at      : v0,
        };
        arg0.total_bundles = arg0.total_bundles + 1;
        0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::events::emit_bundle_submitted(0x2::object::id<ProtectedBundle>(&v2), v1, arg2, 0xbe7755cfab113d0e8be31802c2a04a0f6b723fb8ee217c9f827e57d338019dab::types::bundle_execute_at(&arg3), 0x2::coin::value<0x2::sui::SUI>(&arg4), v0);
        v2
    }

    // decompiled from Move bytecode v6
}

