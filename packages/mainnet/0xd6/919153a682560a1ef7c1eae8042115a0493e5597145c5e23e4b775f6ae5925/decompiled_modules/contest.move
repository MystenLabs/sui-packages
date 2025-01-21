module 0xd6919153a682560a1ef7c1eae8042115a0493e5597145c5e23e4b775f6ae5925::contest {
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
        voting_keys_tab: 0x2::table::Table<0xd6919153a682560a1ef7c1eae8042115a0493e5597145c5e23e4b775f6ae5925::voting_key::VotingKey, u8>,
        num_votes_tab: 0x2::table::Table<0x2::object::ID, u64>,
        num_nfts_per_addr_tab: 0x2::table::Table<address, u8>,
        num_votes_per_addr_tab: 0x2::table::Table<address, u8>,
    }

    public fun admin_address(arg0: &Contest) : address {
        arg0.admin_address
    }

    public fun admin_pub_key(arg0: &Contest) : vector<u8> {
        arg0.admin_pub_key
    }

    public(friend) fun check_double_voting_for_nft_internal(arg0: &mut Contest, arg1: 0x2::object::ID, arg2: address) {
        let v0 = 0xd6919153a682560a1ef7c1eae8042115a0493e5597145c5e23e4b775f6ae5925::voting_key::create_voting_key(arg1, arg2);
        assert!(!0x2::table::contains<0xd6919153a682560a1ef7c1eae8042115a0493e5597145c5e23e4b775f6ae5925::voting_key::VotingKey, u8>(&arg0.voting_keys_tab, v0), 4);
        0x2::table::add<0xd6919153a682560a1ef7c1eae8042115a0493e5597145c5e23e4b775f6ae5925::voting_key::VotingKey, u8>(&mut arg0.voting_keys_tab, v0, 1);
    }

    public(friend) fun check_nft_limit_internal(arg0: &mut Contest, arg1: address) {
        if (0x2::table::contains<address, u8>(&arg0.num_nfts_per_addr_tab, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u8>(&mut arg0.num_nfts_per_addr_tab, arg1);
            assert!(*v0 + 1 <= 1, 5);
            *v0 = *v0 + 1;
        } else {
            0x2::table::add<address, u8>(&mut arg0.num_nfts_per_addr_tab, arg1, 1);
        };
    }

    public(friend) fun check_vote_limit_internal(arg0: &mut Contest, arg1: address) {
        if (0x2::table::contains<address, u8>(&arg0.num_votes_per_addr_tab, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u8>(&mut arg0.num_votes_per_addr_tab, arg1);
            assert!(*v0 + 1 <= 3, 6);
            *v0 = *v0 + 1;
        } else {
            0x2::table::add<address, u8>(&mut arg0.num_votes_per_addr_tab, arg1, 1);
        };
    }

    public(friend) fun create_contest(arg0: vector<u8>, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Contest {
        assert!(0x2::clock::timestamp_ms(arg4) <= arg2, 1);
        assert!(0x2::clock::timestamp_ms(arg4) < arg3, 1);
        assert!(arg2 < arg3, 2);
        Contest{
            id                     : 0x2::object::new(arg5),
            nft_mint_order         : 0,
            nft_num_mints          : 0,
            admin_pub_key          : arg0,
            admin_address          : arg1,
            start_time             : arg2,
            end_time               : arg3,
            denied_address_tab     : 0x2::table::new<address, u8>(arg5),
            hidden_nfts_tab        : 0x2::table::new<0x2::object::ID, u8>(arg5),
            voting_keys_tab        : 0x2::table::new<0xd6919153a682560a1ef7c1eae8042115a0493e5597145c5e23e4b775f6ae5925::voting_key::VotingKey, u8>(arg5),
            num_votes_tab          : 0x2::table::new<0x2::object::ID, u64>(arg5),
            num_nfts_per_addr_tab  : 0x2::table::new<address, u8>(arg5),
            num_votes_per_addr_tab : 0x2::table::new<address, u8>(arg5),
        }
    }

    public(friend) fun create_msg(arg0: address, arg1: 0x2::object::ID) : vector<u8> {
        let v0 = 0x2::address::to_string(arg0);
        0x1::string::append(&mut v0, 0x2::address::to_string(0x2::object::id_to_address(&arg1)));
        0x2::bcs::to_bytes<0x1::string::String>(&v0)
    }

    public fun deny_address(arg0: &AdminCap, arg1: &mut Contest, arg2: address) {
        deny_address_internal(arg1, arg2);
    }

    public(friend) fun deny_address_internal(arg0: &mut Contest, arg1: address) {
        assert!(!is_denied_address(arg0, arg1), 8);
        0x2::table::add<address, u8>(&mut arg0.denied_address_tab, arg1, 1);
    }

    public fun do_delete(arg0: &mut Contest, arg1: vector<u8>, arg2: 0xd6919153a682560a1ef7c1eae8042115a0493e5597145c5e23e4b775f6ae5925::meme::MemeNFT, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = create_msg(0x2::tx_context::sender(arg3), 0xd6919153a682560a1ef7c1eae8042115a0493e5597145c5e23e4b775f6ae5925::meme::id(&arg2));
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg1, &arg0.admin_pub_key, &v0), 11);
        update_contest_on_nft_removal_internal(arg0, 0xd6919153a682560a1ef7c1eae8042115a0493e5597145c5e23e4b775f6ae5925::meme::id(&arg2));
        0xd6919153a682560a1ef7c1eae8042115a0493e5597145c5e23e4b775f6ae5925::meme::burn_meme(arg2);
    }

    public fun do_mint(arg0: &mut Contest, arg1: 0x1::string::String, arg2: address, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(is_contest_on(arg0, arg4), 0);
        assert!(arg0.admin_address == 0x2::tx_context::sender(arg5), 12);
        do_mint_internal(arg0, arg2);
        let v0 = 0xd6919153a682560a1ef7c1eae8042115a0493e5597145c5e23e4b775f6ae5925::meme::mint_meme(0x2::object::uid_to_inner(&arg0.id), arg1, arg2, arg3, arg0.nft_mint_order, arg4, arg5);
        let v1 = 0xd6919153a682560a1ef7c1eae8042115a0493e5597145c5e23e4b775f6ae5925::meme::id(&v0);
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.num_votes_tab, v1, 0);
        0x2::transfer::public_transfer<0xd6919153a682560a1ef7c1eae8042115a0493e5597145c5e23e4b775f6ae5925::meme::MemeNFT>(v0, arg2);
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
        do_vote_internal(arg0, arg2, arg4);
        0xd6919153a682560a1ef7c1eae8042115a0493e5597145c5e23e4b775f6ae5925::vote_proof::create_vote_proof_and_transfer(arg2, arg4);
    }

    public(friend) fun do_vote_internal(arg0: &mut Contest, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert!(!is_denied_address(arg0, 0x2::tx_context::sender(arg2)), 7);
        assert!(!is_hidden_nft(arg0, arg1), 3);
        check_vote_limit_internal(arg0, 0x2::tx_context::sender(arg2));
        check_double_voting_for_nft_internal(arg0, arg1, 0x2::tx_context::sender(arg2));
        assert!(0x2::table::contains<0x2::object::ID, u64>(&arg0.num_votes_tab, arg1), 10);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.num_votes_tab, arg1);
        *v0 = *v0 + 1;
    }

    public fun end_contest(arg0: &AdminCap, arg1: &mut Contest, arg2: &0x2::clock::Clock) {
        assert!(is_contest_on(arg1, arg2), 0);
        arg1.end_time = 0x2::clock::timestamp_ms(arg2);
    }

    public fun end_time(arg0: &Contest) : u64 {
        arg0.end_time
    }

    public fun hide_nft(arg0: &AdminCap, arg1: &mut Contest, arg2: 0x2::object::ID) {
        hide_nft_internal(arg1, arg2);
    }

    public(friend) fun hide_nft_internal(arg0: &mut Contest, arg1: 0x2::object::ID) {
        assert!(!is_hidden_nft(arg0, arg1), 9);
        0x2::table::add<0x2::object::ID, u8>(&mut arg0.hidden_nfts_tab, arg1, 1);
        update_contest_on_nft_removal_internal(arg0, arg1);
    }

    fun init(arg0: CONTEST, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<CONTEST>(arg0, arg1);
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
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

    public fun nft_mint_order(arg0: &Contest) : u64 {
        arg0.nft_mint_order
    }

    public fun nft_num_mints(arg0: &Contest) : u64 {
        arg0.nft_num_mints
    }

    public fun start_contest(arg0: &AdminCap, arg1: vector<u8>, arg2: address, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Contest>(create_contest(arg1, arg2, arg3, arg4, arg5, arg6));
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

    // decompiled from Move bytecode v6
}

