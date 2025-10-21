module 0x3d1fad171494628234aeef1a30edf009102f12b42578151c871be57e9ce523ea::contest {
    struct CONTEST has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Contest has key {
        id: 0x2::object::UID,
        nft_mint_order: u64,
        nft_num_mints: u64,
        admin_pub_key: vector<u8>,
        admin_address: address,
        start_time: u64,
        end_time: u64,
        denied_address_tab: 0x2::table::Table<address, u8>,
        hidden_nfts_tab: 0x2::table::Table<0x2::object::ID, u8>,
        voting_keys_tab: 0x2::table::Table<0x3d1fad171494628234aeef1a30edf009102f12b42578151c871be57e9ce523ea::voting_key::VotingKey, u8>,
        num_votes_tab: 0x2::table::Table<0x2::object::ID, u64>,
        num_nfts_per_addr_tab: 0x2::table::Table<address, u8>,
        num_votes_per_addr_tab: 0x2::table::Table<address, u8>,
        nft_limit_per_address: u8,
        vote_limit_per_address: u8,
    }

    struct NFTVotedEvent has copy, drop {
        vote_proof_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        contest_id: 0x2::object::ID,
        voter: address,
        current_votes: u64,
        voted_at: u64,
    }

    struct ContestCreatedEvent has copy, drop {
        id: 0x2::object::ID,
        nft_mint_order: u64,
        nft_num_mints: u64,
        admin_pub_key: vector<u8>,
        admin_address: address,
        start_time: u64,
        end_time: u64,
        nft_limit_per_address: u8,
        vote_limit_per_address: u8,
    }

    struct AddressDeniedEvent has copy, drop {
        contest_id: 0x2::object::ID,
        denied_address: address,
        denied_by: address,
        denied_at: u64,
    }

    struct NFTHiddenEvent has copy, drop {
        contest_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        hidden_by: address,
        hidden_at: u64,
    }

    struct NFTLimitUpdatedEvent has copy, drop {
        contest_id: 0x2::object::ID,
        old_limit: u8,
        new_limit: u8,
        updated_at: u64,
    }

    struct VoteLimitUpdatedEvent has copy, drop {
        contest_id: 0x2::object::ID,
        old_limit: u8,
        new_limit: u8,
        updated_at: u64,
    }

    public fun admin_address(arg0: &Contest) : address {
        arg0.admin_address
    }

    public fun admin_pub_key(arg0: &Contest) : vector<u8> {
        arg0.admin_pub_key
    }

    public(friend) fun check_double_voting_for_nft_internal(arg0: &mut Contest, arg1: 0x2::object::ID, arg2: address) {
        let v0 = 0x3d1fad171494628234aeef1a30edf009102f12b42578151c871be57e9ce523ea::voting_key::create_voting_key(arg1, arg2);
        assert!(!0x2::table::contains<0x3d1fad171494628234aeef1a30edf009102f12b42578151c871be57e9ce523ea::voting_key::VotingKey, u8>(&arg0.voting_keys_tab, v0), 4);
        0x2::table::add<0x3d1fad171494628234aeef1a30edf009102f12b42578151c871be57e9ce523ea::voting_key::VotingKey, u8>(&mut arg0.voting_keys_tab, v0, 1);
    }

    public(friend) fun check_nft_limit_internal(arg0: &mut Contest, arg1: address) {
        if (0x2::table::contains<address, u8>(&arg0.num_nfts_per_addr_tab, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u8>(&mut arg0.num_nfts_per_addr_tab, arg1);
            assert!(*v0 + 1 <= arg0.nft_limit_per_address, 5);
            *v0 = *v0 + 1;
        } else {
            0x2::table::add<address, u8>(&mut arg0.num_nfts_per_addr_tab, arg1, 1);
        };
    }

    public(friend) fun check_vote_limit_internal(arg0: &mut Contest, arg1: address) {
        if (0x2::table::contains<address, u8>(&arg0.num_votes_per_addr_tab, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u8>(&mut arg0.num_votes_per_addr_tab, arg1);
            assert!(*v0 + 1 <= arg0.vote_limit_per_address, 6);
            *v0 = *v0 + 1;
        } else {
            0x2::table::add<address, u8>(&mut arg0.num_votes_per_addr_tab, arg1, 1);
        };
    }

    public(friend) fun create_contest(arg0: vector<u8>, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext, arg6: u8, arg7: u8) : Contest {
        assert!(0x2::clock::timestamp_ms(arg4) <= arg2, 1);
        assert!(0x2::clock::timestamp_ms(arg4) < arg3, 1);
        assert!(arg2 < arg3, 2);
        let v0 = 0x2::object::new(arg5);
        let v1 = Contest{
            id                     : v0,
            nft_mint_order         : 0,
            nft_num_mints          : 0,
            admin_pub_key          : arg0,
            admin_address          : arg1,
            start_time             : arg2,
            end_time               : arg3,
            denied_address_tab     : 0x2::table::new<address, u8>(arg5),
            hidden_nfts_tab        : 0x2::table::new<0x2::object::ID, u8>(arg5),
            voting_keys_tab        : 0x2::table::new<0x3d1fad171494628234aeef1a30edf009102f12b42578151c871be57e9ce523ea::voting_key::VotingKey, u8>(arg5),
            num_votes_tab          : 0x2::table::new<0x2::object::ID, u64>(arg5),
            num_nfts_per_addr_tab  : 0x2::table::new<address, u8>(arg5),
            num_votes_per_addr_tab : 0x2::table::new<address, u8>(arg5),
            nft_limit_per_address  : arg6,
            vote_limit_per_address : arg7,
        };
        let v2 = ContestCreatedEvent{
            id                     : 0x2::object::uid_to_inner(&v0),
            nft_mint_order         : 0,
            nft_num_mints          : 0,
            admin_pub_key          : arg0,
            admin_address          : arg1,
            start_time             : arg2,
            end_time               : arg3,
            nft_limit_per_address  : arg6,
            vote_limit_per_address : arg7,
        };
        0x2::event::emit<ContestCreatedEvent>(v2);
        v1
    }

    public(friend) fun create_msg(arg0: address, arg1: 0x2::object::ID) : vector<u8> {
        let v0 = 0x2::address::to_string(arg0);
        0x1::string::append(&mut v0, 0x2::address::to_string(0x2::object::id_to_address(&arg1)));
        0x2::bcs::to_bytes<0x1::string::String>(&v0)
    }

    public fun deny_address(arg0: &AdminCap, arg1: &mut Contest, arg2: address, arg3: &0x2::clock::Clock) {
        deny_address_internal(arg1, arg2, arg3);
    }

    public(friend) fun deny_address_internal(arg0: &mut Contest, arg1: address, arg2: &0x2::clock::Clock) {
        assert!(!is_denied_address(arg0, arg1), 8);
        let v0 = AddressDeniedEvent{
            contest_id     : 0x2::object::uid_to_inner(&arg0.id),
            denied_address : arg1,
            denied_by      : arg0.admin_address,
            denied_at      : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<AddressDeniedEvent>(v0);
        0x2::table::add<address, u8>(&mut arg0.denied_address_tab, arg1, 1);
    }

    public fun do_delete(arg0: &mut Contest, arg1: vector<u8>, arg2: 0x3d1fad171494628234aeef1a30edf009102f12b42578151c871be57e9ce523ea::meme::MemeNFT, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = create_msg(0x2::tx_context::sender(arg4), 0x3d1fad171494628234aeef1a30edf009102f12b42578151c871be57e9ce523ea::meme::id(&arg2));
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg1, &arg0.admin_pub_key, &v0), 11);
        update_contest_on_nft_removal_internal(arg0, 0x3d1fad171494628234aeef1a30edf009102f12b42578151c871be57e9ce523ea::meme::id(&arg2));
        0x3d1fad171494628234aeef1a30edf009102f12b42578151c871be57e9ce523ea::meme::burn_meme(arg2, arg3);
    }

    public fun do_mint(arg0: &mut Contest, arg1: 0x1::string::String, arg2: address, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(is_contest_on(arg0, arg4), 0);
        assert!(arg0.admin_address == 0x2::tx_context::sender(arg8), 12);
        do_mint_internal(arg0, arg2);
        let v0 = 0x3d1fad171494628234aeef1a30edf009102f12b42578151c871be57e9ce523ea::meme::mint_meme(0x2::object::uid_to_inner(&arg0.id), arg1, arg2, arg3, arg0.nft_mint_order, arg4, arg5, arg6, arg7, arg8);
        let v1 = 0x3d1fad171494628234aeef1a30edf009102f12b42578151c871be57e9ce523ea::meme::id(&v0);
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.num_votes_tab, v1, 0);
        0x2::transfer::public_transfer<0x3d1fad171494628234aeef1a30edf009102f12b42578151c871be57e9ce523ea::meme::MemeNFT>(v0, arg2);
        v1
    }

    public(friend) fun do_mint_internal(arg0: &mut Contest, arg1: address) {
        assert!(!is_denied_address(arg0, arg1), 7);
        check_nft_limit_internal(arg0, arg1);
        arg0.nft_num_mints = arg0.nft_num_mints + 1;
        arg0.nft_mint_order = arg0.nft_mint_order + 1;
    }

    public fun do_vote(arg0: &mut Contest, arg1: vector<u8>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_contest_on(arg0, arg3), 0);
        let v0 = create_msg(0x2::tx_context::sender(arg4), arg2);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg1, &arg0.admin_pub_key, &v0), 11);
        let v1 = do_vote_internal(arg0, arg2, arg3, arg4);
        let v2 = NFTVotedEvent{
            vote_proof_id : 0x3d1fad171494628234aeef1a30edf009102f12b42578151c871be57e9ce523ea::vote_proof::create_vote_proof_and_transfer(arg2, arg4),
            nft_id        : arg2,
            contest_id    : 0x2::object::uid_to_inner(&arg0.id),
            voter         : 0x2::tx_context::sender(arg4),
            current_votes : v1,
            voted_at      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<NFTVotedEvent>(v2);
    }

    public(friend) fun do_vote_internal(arg0: &mut Contest, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : u64 {
        assert!(!is_denied_address(arg0, 0x2::tx_context::sender(arg3)), 7);
        assert!(!is_hidden_nft(arg0, arg1), 3);
        check_vote_limit_internal(arg0, 0x2::tx_context::sender(arg3));
        check_double_voting_for_nft_internal(arg0, arg1, 0x2::tx_context::sender(arg3));
        assert!(0x2::table::contains<0x2::object::ID, u64>(&arg0.num_votes_tab, arg1), 10);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.num_votes_tab, arg1);
        *v0 = *v0 + 1;
        *v0
    }

    public fun end_contest(arg0: &AdminCap, arg1: &mut Contest, arg2: &0x2::clock::Clock) {
        assert!(is_contest_on(arg1, arg2), 0);
        arg1.end_time = 0x2::clock::timestamp_ms(arg2);
    }

    public fun end_time(arg0: &Contest) : u64 {
        arg0.end_time
    }

    public fun get_id(arg0: &Contest) : &0x2::object::UID {
        &arg0.id
    }

    public fun get_votes(arg0: &Contest, arg1: 0x2::object::ID) : u64 {
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.num_votes_tab, arg1)) {
            *0x2::table::borrow<0x2::object::ID, u64>(&arg0.num_votes_tab, arg1)
        } else {
            0
        }
    }

    public fun hide_nft(arg0: &AdminCap, arg1: &mut Contest, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        hide_nft_internal(arg1, arg2, arg3);
    }

    public(friend) fun hide_nft_internal(arg0: &mut Contest, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        assert!(!is_hidden_nft(arg0, arg1), 9);
        let v0 = NFTHiddenEvent{
            contest_id : 0x2::object::uid_to_inner(&arg0.id),
            nft_id     : arg1,
            hidden_by  : arg0.admin_address,
            hidden_at  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<NFTHiddenEvent>(v0);
        0x2::table::add<0x2::object::ID, u8>(&mut arg0.hidden_nfts_tab, arg1, 1);
        update_contest_on_nft_removal_internal(arg0, arg1);
    }

    fun init(arg0: CONTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CONTEST>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"animation_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{title}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{animation_url}"));
        let v5 = 0x2::display::new_with_fields<0x3d1fad171494628234aeef1a30edf009102f12b42578151c871be57e9ce523ea::meme::MemeNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<0x3d1fad171494628234aeef1a30edf009102f12b42578151c871be57e9ce523ea::meme::MemeNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<0x3d1fad171494628234aeef1a30edf009102f12b42578151c871be57e9ce523ea::meme::MemeNFT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun is_contest_on(arg0: &Contest, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.start_time && 0x2::clock::timestamp_ms(arg1) < arg0.end_time
    }

    public fun is_denied_address(arg0: &Contest, arg1: address) : bool {
        0x2::table::contains<address, u8>(&arg0.denied_address_tab, arg1)
    }

    public fun is_hidden_nft(arg0: &Contest, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, u8>(&arg0.hidden_nfts_tab, arg1)
    }

    public fun new_admin_cap(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        assert!(0x2::package::from_package<AdminCap>(arg0), 13);
        AdminCap{id: 0x2::object::new(arg1)}
    }

    public fun nft_limit_per_address(arg0: &Contest) : u8 {
        arg0.nft_limit_per_address
    }

    public fun nft_mint_order(arg0: &Contest) : u64 {
        arg0.nft_mint_order
    }

    public fun nft_num_mints(arg0: &Contest) : u64 {
        arg0.nft_num_mints
    }

    public fun set_nft_limit_per_address(arg0: &AdminCap, arg1: &mut Contest, arg2: u8) {
        arg1.nft_limit_per_address = arg2;
        let v0 = NFTLimitUpdatedEvent{
            contest_id : 0x2::object::uid_to_inner(&arg1.id),
            old_limit  : arg1.nft_limit_per_address,
            new_limit  : arg2,
            updated_at : 0,
        };
        0x2::event::emit<NFTLimitUpdatedEvent>(v0);
    }

    public fun set_vote_limit_per_address(arg0: &AdminCap, arg1: &mut Contest, arg2: u8) {
        arg1.vote_limit_per_address = arg2;
        let v0 = VoteLimitUpdatedEvent{
            contest_id : 0x2::object::uid_to_inner(&arg1.id),
            old_limit  : arg1.vote_limit_per_address,
            new_limit  : arg2,
            updated_at : 0,
        };
        0x2::event::emit<VoteLimitUpdatedEvent>(v0);
    }

    public fun start_contest(arg0: &AdminCap, arg1: vector<u8>, arg2: address, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: u8, arg7: u8, arg8: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Contest>(create_contest(arg1, arg2, arg3, arg4, arg5, arg8, arg6, arg7));
    }

    public fun update_admin_pub_key_and_address(arg0: &0x2::package::Publisher, arg1: &mut Contest, arg2: vector<u8>, arg3: address) {
        assert!(0x2::package::from_package<AdminCap>(arg0), 13);
        arg1.admin_pub_key = arg2;
        arg1.admin_address = arg3;
    }

    public fun update_contest(arg0: &AdminCap, arg1: &mut Contest, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(is_contest_on(arg1, arg3), 0);
        assert!(0x2::clock::timestamp_ms(arg3) < arg2, 1);
        arg1.end_time = arg2;
    }

    public(friend) fun update_contest_on_nft_removal_internal(arg0: &mut Contest, arg1: 0x2::object::ID) {
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.num_votes_tab, arg1)) {
            0x2::table::remove<0x2::object::ID, u64>(&mut arg0.num_votes_tab, arg1);
            if (arg0.nft_num_mints >= 1) {
                arg0.nft_num_mints = arg0.nft_num_mints - 1;
            };
        };
    }

    public fun vote_limit_per_address(arg0: &Contest) : u8 {
        arg0.vote_limit_per_address
    }

    // decompiled from Move bytecode v6
}

