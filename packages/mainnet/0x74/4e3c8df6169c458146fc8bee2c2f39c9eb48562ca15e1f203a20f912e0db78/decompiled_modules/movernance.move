module 0x744e3c8df6169c458146fc8bee2c2f39c9eb48562ca15e1f203a20f912e0db78::movernance {
    struct SpaceStore has store, key {
        id: 0x2::object::UID,
        spaces: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
    }

    struct GovSpace has store, key {
        id: 0x2::object::UID,
        gov_type: u8,
        proposal_type: 0x1::ascii::String,
        voting_type: 0x1::ascii::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
        metadata: 0x1::string::String,
        admin: address,
        propose_threshold: u64,
        proposals: vector<0x2::object::ID>,
    }

    struct GovProposal has store, key {
        id: 0x2::object::UID,
        space_id: 0x2::object::ID,
        gov_type: u8,
        proposal_type: 0x1::ascii::String,
        voting_type: 0x1::ascii::String,
        title: 0x1::string::String,
        body: 0x1::string::String,
        creator: address,
        start_time: u64,
        end_time: u64,
        min_vote_threshold: u64,
        yes_votes: u64,
        no_votes: u64,
        yes_voters: 0x2::table::Table<address, u64>,
        no_voters: 0x2::table::Table<address, u64>,
        rewards: vector<0x2::object::ID>,
    }

    struct VoteEvent has copy, drop {
        proposal_id: 0x2::object::ID,
        voter: address,
        choice: bool,
        amount: u64,
    }

    struct TokenVote<phantom T0> has store, key {
        id: 0x2::object::UID,
        voter: address,
        choice: bool,
        proposal_id: 0x2::object::ID,
        token: 0x2::balance::Balance<T0>,
    }

    struct NftVote<T0> has store, key {
        id: 0x2::object::UID,
        voter: address,
        choice: bool,
        proposal_id: 0x2::object::ID,
        nfts: vector<T0>,
    }

    struct MoveScriptionVote has store, key {
        id: 0x2::object::UID,
        voter: address,
        choice: bool,
        proposal_id: 0x2::object::ID,
        movescription: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription,
    }

    struct Reward<phantom T0> has store, key {
        id: 0x2::object::UID,
        proposal_id: 0x2::object::ID,
        choice: bool,
        balance: 0x2::balance::Balance<T0>,
        sponsers: 0x2::table::Table<address, u64>,
        claimed_addresses: 0x2::table::Table<address, bool>,
    }

    public entry fun add_reward<T0>(arg0: &GovProposal, arg1: &mut Reward<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!is_voting_period_over(arg0, arg3), 3);
        assert!(arg1.proposal_id == 0x2::object::uid_to_inner(&arg0.id), 5);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 9);
        let v1 = 0x2::tx_context::sender(arg4);
        if (0x2::table::contains<address, u64>(&arg1.sponsers, v1)) {
            let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg1.sponsers, v1);
            *v2 = *v2 + v0;
        } else {
            0x2::table::add<address, u64>(&mut arg1.sponsers, v1, v0);
        };
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg2));
    }

    fun add_vote_in_map(arg0: &mut 0x2::table::Table<address, u64>, arg1: address, arg2: u64) {
        if (0x2::table::contains<address, u64>(arg0, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(arg0, arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::table::add<address, u64>(arg0, arg1, arg2);
        };
    }

    public entry fun claim_reward<T0>(arg0: &GovProposal, arg1: &mut Reward<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_voting_period_over(arg0, arg2), 4);
        assert!(arg1.proposal_id == 0x2::object::uid_to_inner(&arg0.id), 5);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<address, bool>(&arg1.claimed_addresses, v0), 8);
        let v1 = get_proposal_status(arg0, arg2);
        let v2 = if (v1 == 1) {
            get_with_default(&arg1.sponsers, v0, 0)
        } else if (v1 == 2 && arg1.choice) {
            get_with_default(&arg0.yes_voters, v0, 0) * 0x2::balance::value<T0>(&arg1.balance) / arg0.yes_votes
        } else {
            assert!(v1 == 3 && !arg1.choice, 6);
            get_with_default(&arg0.no_voters, v0, 0) * 0x2::balance::value<T0>(&arg1.balance) / arg0.no_votes
        };
        assert!(v2 > 0, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v2), arg3), v0);
        0x2::table::add<address, bool>(&mut arg1.claimed_addresses, v0, true);
    }

    public entry fun create_movescription_gov_proposal(arg0: &mut GovSpace, arg1: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.gov_type == 2, 15);
        assert!(arg0.proposal_type == 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick(&arg1), 18);
        assert!(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(&arg1) >= arg0.propose_threshold, 17);
        0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(arg1, 0x2::tx_context::sender(arg8));
        inner_create_proposal(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun create_nft_gov_proposal<T0: store + key>(arg0: &mut GovSpace, arg1: vector<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.gov_type == 1, 15);
        assert!(arg0.proposal_type == 0x1::type_name::into_string(0x1::type_name::get<T0>()), 18);
        assert!(0x1::vector::length<T0>(&arg1) >= arg0.propose_threshold, 16);
        transfer_nfts<T0>(arg1, 0x2::tx_context::sender(arg8));
        inner_create_proposal(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun create_reward<T0>(arg0: &mut GovProposal, arg1: 0x2::coin::Coin<T0>, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!is_voting_period_over(arg0, arg3), 3);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 9);
        let v1 = 0x2::table::new<address, u64>(arg4);
        0x2::table::add<address, u64>(&mut v1, 0x2::tx_context::sender(arg4), v0);
        let v2 = Reward<T0>{
            id                : 0x2::object::new(arg4),
            proposal_id       : 0x2::object::uid_to_inner(&arg0.id),
            choice            : arg2,
            balance           : 0x2::coin::into_balance<T0>(arg1),
            sponsers          : v1,
            claimed_addresses : 0x2::table::new<address, bool>(arg4),
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.rewards, 0x2::object::uid_to_inner(&v2.id));
        0x2::transfer::share_object<Reward<T0>>(v2);
    }

    public entry fun create_space(arg0: &mut SpaceStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u8, arg7: vector<u8>, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg1);
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.spaces, v0), 11);
        assert!(arg6 == 0 || arg6 == 1 || arg6 == 2, 15);
        let v1 = GovSpace{
            id                : 0x2::object::new(arg9),
            gov_type          : arg6,
            proposal_type     : 0x1::ascii::string(arg7),
            voting_type       : 0x1::ascii::string(arg8),
            name              : v0,
            description       : 0x1::string::utf8(arg2),
            url               : 0x1::string::utf8(arg3),
            metadata          : 0x1::string::utf8(arg4),
            admin             : 0x2::tx_context::sender(arg9),
            propose_threshold : arg5,
            proposals         : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.spaces, v1.name, 0x2::object::uid_to_inner(&v1.id));
        0x2::transfer::share_object<GovSpace>(v1);
    }

    fun create_space_store(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SpaceStore{
            id     : 0x2::object::new(arg0),
            spaces : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<SpaceStore>(v0);
    }

    public entry fun create_space_with_type<T0, T1>(arg0: &mut SpaceStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        create_space(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())), 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())), arg7);
    }

    public entry fun create_token_gov_proposal<T0>(arg0: &mut GovSpace, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.gov_type == 0, 15);
        assert!(arg0.proposal_type == 0x1::type_name::into_string(0x1::type_name::get<T0>()), 18);
        assert!(0x2::coin::value<T0>(&arg1) >= arg0.propose_threshold, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg8));
        inner_create_proposal(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun edit_gov_space_meta(arg0: &mut GovSpace, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.admin, 14);
        arg0.name = 0x1::string::utf8(arg1);
        arg0.description = 0x1::string::utf8(arg2);
        arg0.url = 0x1::string::utf8(arg3);
        arg0.metadata = 0x1::string::utf8(arg4);
        arg0.propose_threshold = arg5;
    }

    public fun get_proposal_status(arg0: &GovProposal, arg1: &0x2::clock::Clock) : u8 {
        if (0x2::clock::timestamp_ms(arg1) < arg0.start_time) {
            return 4
        };
        if (!is_voting_period_over(arg0, arg1)) {
            return 0
        };
        if (arg0.yes_votes + arg0.no_votes < arg0.min_vote_threshold) {
            return 1
        };
        if (arg0.yes_votes > arg0.no_votes) {
            2
        } else {
            3
        }
    }

    public fun get_spaces(arg0: &SpaceStore) : &0x2::table::Table<0x1::string::String, 0x2::object::ID> {
        &arg0.spaces
    }

    fun get_with_default(arg0: &0x2::table::Table<address, u64>, arg1: address, arg2: u64) : u64 {
        if (0x2::table::contains<address, u64>(arg0, arg1)) {
            *0x2::table::borrow<address, u64>(arg0, arg1)
        } else {
            arg2
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        create_space_store(arg0);
    }

    fun inner_create_proposal(arg0: &mut GovSpace, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg6) < arg4, 1);
        assert!(arg3 < arg4, 12);
        let v0 = GovProposal{
            id                 : 0x2::object::new(arg7),
            space_id           : 0x2::object::uid_to_inner(&arg0.id),
            gov_type           : arg0.gov_type,
            proposal_type      : arg0.proposal_type,
            voting_type        : arg0.voting_type,
            title              : 0x1::string::utf8(arg1),
            body               : 0x1::string::utf8(arg2),
            creator            : 0x2::tx_context::sender(arg7),
            start_time         : arg3,
            end_time           : arg4,
            min_vote_threshold : arg5,
            yes_votes          : 0,
            no_votes           : 0,
            yes_voters         : 0x2::table::new<address, u64>(arg7),
            no_voters          : 0x2::table::new<address, u64>(arg7),
            rewards            : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.proposals, 0x2::object::uid_to_inner(&v0.id));
        0x2::transfer::share_object<GovProposal>(v0);
    }

    fun is_voting_period_over(arg0: &GovProposal, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) > arg0.end_time
    }

    public fun transfer_nfts<T0: store + key>(arg0: vector<T0>, arg1: address) : u64 {
        let v0 = 0x1::vector::length<T0>(&arg0);
        let v1 = 0;
        while (v1 < v0) {
            0x2::transfer::public_transfer<T0>(0x1::vector::pop_back<T0>(&mut arg0), arg1);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<T0>(arg0);
        v0
    }

    public entry fun vote_with_movescription(arg0: &mut GovProposal, arg1: 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::tick(&arg1) == arg0.voting_type, 19);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.start_time, 13);
        assert!(!is_voting_period_over(arg0, arg3), 3);
        let v0 = 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::amount(&arg1);
        assert!(v0 > 0, 9);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = MoveScriptionVote{
            id            : 0x2::object::new(arg4),
            voter         : v1,
            choice        : arg2,
            proposal_id   : 0x2::object::uid_to_inner(&arg0.id),
            movescription : arg1,
        };
        if (arg2) {
            arg0.yes_votes = arg0.yes_votes + v0;
            let v3 = &mut arg0.yes_voters;
            add_vote_in_map(v3, v1, v0);
        } else {
            arg0.no_votes = arg0.no_votes + v0;
            let v4 = &mut arg0.no_voters;
            add_vote_in_map(v4, v1, v0);
        };
        0x2::transfer::transfer<MoveScriptionVote>(v2, v1);
        let v5 = VoteEvent{
            proposal_id : 0x2::object::uid_to_inner(&arg0.id),
            voter       : 0x2::tx_context::sender(arg4),
            choice      : true,
            amount      : v0,
        };
        0x2::event::emit<VoteEvent>(v5);
    }

    public entry fun vote_with_nfts<T0: store + key>(arg0: &mut GovProposal, arg1: vector<T0>, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == arg0.voting_type, 19);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.start_time, 13);
        assert!(!is_voting_period_over(arg0, arg3), 3);
        let v0 = 0x1::vector::length<T0>(&arg1);
        assert!(v0 > 0, 9);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = NftVote<T0>{
            id          : 0x2::object::new(arg4),
            voter       : v1,
            choice      : arg2,
            proposal_id : 0x2::object::uid_to_inner(&arg0.id),
            nfts        : arg1,
        };
        if (arg2) {
            arg0.yes_votes = arg0.yes_votes + v0;
            let v3 = &mut arg0.yes_voters;
            add_vote_in_map(v3, v1, v0);
        } else {
            arg0.no_votes = arg0.no_votes + v0;
            let v4 = &mut arg0.no_voters;
            add_vote_in_map(v4, v1, v0);
        };
        0x2::transfer::transfer<NftVote<T0>>(v2, v1);
        let v5 = VoteEvent{
            proposal_id : 0x2::object::uid_to_inner(&arg0.id),
            voter       : 0x2::tx_context::sender(arg4),
            choice      : true,
            amount      : v0,
        };
        0x2::event::emit<VoteEvent>(v5);
    }

    public entry fun vote_with_token<T0>(arg0: &mut GovProposal, arg1: 0x2::coin::Coin<T0>, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) == arg0.voting_type, 19);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.start_time, 13);
        assert!(!is_voting_period_over(arg0, arg3), 3);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 9);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = TokenVote<T0>{
            id          : 0x2::object::new(arg4),
            voter       : v1,
            choice      : arg2,
            proposal_id : 0x2::object::uid_to_inner(&arg0.id),
            token       : 0x2::coin::into_balance<T0>(arg1),
        };
        if (arg2) {
            arg0.yes_votes = arg0.yes_votes + v0;
            let v3 = &mut arg0.yes_voters;
            add_vote_in_map(v3, v1, v0);
        } else {
            arg0.no_votes = arg0.no_votes + v0;
            let v4 = &mut arg0.no_voters;
            add_vote_in_map(v4, v1, v0);
        };
        0x2::transfer::transfer<TokenVote<T0>>(v2, v1);
        let v5 = VoteEvent{
            proposal_id : 0x2::object::uid_to_inner(&arg0.id),
            voter       : 0x2::tx_context::sender(arg4),
            choice      : true,
            amount      : v0,
        };
        0x2::event::emit<VoteEvent>(v5);
    }

    public entry fun withdraw_vote_movescription(arg0: &GovProposal, arg1: MoveScriptionVote, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_voting_period_over(arg0, arg2), 4);
        let MoveScriptionVote {
            id            : v0,
            voter         : v1,
            choice        : _,
            proposal_id   : _,
            movescription : v4,
        } = arg1;
        0x2::transfer::public_transfer<0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::movescription::Movescription>(v4, v1);
        0x2::object::delete(v0);
    }

    public entry fun withdraw_vote_nfts<T0: store + key>(arg0: &GovProposal, arg1: NftVote<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_voting_period_over(arg0, arg2), 4);
        let NftVote {
            id          : v0,
            voter       : v1,
            choice      : _,
            proposal_id : _,
            nfts        : v4,
        } = arg1;
        transfer_nfts<T0>(v4, v1);
        0x2::object::delete(v0);
    }

    public entry fun withdraw_vote_token<T0>(arg0: &GovProposal, arg1: TokenVote<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_voting_period_over(arg0, arg2), 4);
        let TokenVote {
            id          : v0,
            voter       : v1,
            choice      : _,
            proposal_id : _,
            token       : v4,
        } = arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg3), v1);
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

