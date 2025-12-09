module 0xa72f11db0f24a399309505769466303024342e59daecf2019104ddd59693c897::minority {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Experience has drop {
        points: u64,
    }

    struct Game has store, key {
        id: 0x2::object::UID,
        start_time: u64,
        end_time: u64,
        is_settled: bool,
        winner_pool: u8,
        total_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        votes: 0x2::linked_table::LinkedTable<address, vector<Vote>>,
        key_servers: vector<address>,
        public_keys: vector<vector<u8>>,
        threshold: u8,
        winning_share: u64,
        count_a: u64,
        count_b: u64,
        real_votes_a: u64,
        real_votes_b: u64,
        real_votes_c: u64,
        lastaddress: 0x1::option::Option<address>,
        bomb_used_a: u64,
        bomb_used_b: u64,
    }

    struct Vote has drop, store {
        voter: address,
        encrypted_vote: 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::EncryptedObject,
        amount: u64,
        decrypted_choice: 0x1::option::Option<u8>,
        is_disturbance: bool,
    }

    struct GameCreated has copy, drop {
        game_id: 0x2::object::ID,
        start_time: u64,
    }

    struct VoteCasted has copy, drop {
        game_id: 0x2::object::ID,
        voter: address,
    }

    struct GameSettled has copy, drop {
        game_id: 0x2::object::ID,
        winner_pool: u8,
        total_payout: u64,
        count_red: u64,
        count_blue: u64,
        count_tie: u64,
    }

    struct RewardClaimed has copy, drop {
        game_id: 0x2::object::ID,
        voter: address,
        amount: u64,
    }

    struct SponsorshipAdded has copy, drop {
        game_id: 0x2::object::ID,
        sponsor: address,
        amount: u64,
    }

    public fun id(arg0: &Game) : vector<u8> {
        0x2::object::id_bytes<Game>(arg0)
    }

    public fun admin_withdraw_and_delete(arg0: Game, arg1: &AdminCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let Game {
            id            : v0,
            start_time    : _,
            end_time      : v2,
            is_settled    : _,
            winner_pool   : _,
            total_pool    : v5,
            votes         : v6,
            key_servers   : _,
            public_keys   : _,
            threshold     : _,
            winning_share : _,
            count_a       : _,
            count_b       : _,
            real_votes_a  : _,
            real_votes_b  : _,
            real_votes_c  : _,
            lastaddress   : _,
            bomb_used_a   : _,
            bomb_used_b   : _,
        } = arg0;
        let v19 = v6;
        assert!(0x2::clock::timestamp_ms(arg2) >= v2 + 4320000000, 12);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v5, arg3), 0x2::tx_context::sender(arg3));
        while (!0x2::linked_table::is_empty<address, vector<Vote>>(&v19)) {
            let (_, v21) = 0x2::linked_table::pop_front<address, vector<Vote>>(&mut v19);
            let v22 = v21;
            let v23 = 0x1::vector::length<Vote>(&v22);
            while (v23 > 0) {
                let Vote {
                    voter            : _,
                    encrypted_vote   : _,
                    amount           : _,
                    decrypted_choice : _,
                    is_disturbance   : _,
                } = 0x1::vector::pop_back<Vote>(&mut v22);
                v23 = v23 - 1;
            };
            0x1::vector::destroy_empty<Vote>(v22);
        };
        0x2::linked_table::destroy_empty<address, vector<Vote>>(v19);
        0x2::object::delete(v0);
    }

    entry fun claim(arg0: &mut Game, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        assert!(arg0.is_settled, 6);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = false;
        if (0x2::linked_table::contains<address, vector<Vote>>(&arg0.votes, v1)) {
            let v3 = 0x2::linked_table::borrow_mut<address, vector<Vote>>(&mut arg0.votes, v1);
            let v4 = 0;
            while (v4 < 0x1::vector::length<Vote>(v3)) {
                let v5 = 0x1::vector::borrow_mut<Vote>(v3, v4);
                let v6 = v5.decrypted_choice;
                if (0x1::option::is_some<u8>(&v6)) {
                    if (arg0.winner_pool == 3) {
                        v0 = v0 + v5.amount;
                    } else {
                        let v7 = if (arg0.winner_pool == 0 && 0x1::option::extract<u8>(&mut v6) == 0 || arg0.winner_pool == 1 && 0x1::option::extract<u8>(&mut v6) == 1 || arg0.winner_pool == 2 && 0x1::option::extract<u8>(&mut v6) == 2) {
                            arg0.winning_share
                        } else {
                            0
                        };
                        let v8 = if (v5.is_disturbance) {
                            v5.amount / 2000000000
                        } else {
                            v5.amount / 1000000000
                        };
                        v0 = v0 + v8 * v7;
                    };
                    let Vote {
                        voter            : _,
                        encrypted_vote   : _,
                        amount           : _,
                        decrypted_choice : _,
                        is_disturbance   : _,
                    } = 0x1::vector::remove<Vote>(v3, v4);
                    continue
                };
                v4 = v4 + 1;
            };
            v2 = 0x1::vector::length<Vote>(v3) == 0;
        };
        if (v2) {
            0x1::vector::destroy_empty<Vote>(0x2::linked_table::remove<address, vector<Vote>>(&mut arg0.votes, v1));
        };
        let v14 = v0 - v0 / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.total_pool, v14, arg1), v1);
        let v15 = RewardClaimed{
            game_id : 0x2::object::id<Game>(arg0),
            voter   : v1,
            amount  : v14,
        };
        0x2::event::emit<RewardClaimed>(v15);
    }

    public fun create_game(arg0: &AdminCap, arg1: vector<address>, arg2: vector<vector<u8>>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 <= (0x1::vector::length<address>(&arg1) as u8), 10);
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<vector<u8>>(&arg2), 10);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = Game{
            id            : 0x2::object::new(arg5),
            start_time    : v0,
            end_time      : v0 + 86400000,
            is_settled    : false,
            winner_pool   : 4,
            total_pool    : 0x2::balance::zero<0x2::sui::SUI>(),
            votes         : 0x2::linked_table::new<address, vector<Vote>>(arg5),
            key_servers   : arg1,
            public_keys   : arg2,
            threshold     : arg3,
            winning_share : 0,
            count_a       : 0,
            count_b       : 0,
            real_votes_a  : 0,
            real_votes_b  : 0,
            real_votes_c  : 0,
            lastaddress   : 0x1::option::none<address>(),
            bomb_used_a   : 0,
            bomb_used_b   : 0,
        };
        let v2 = GameCreated{
            game_id    : 0x2::object::id<Game>(&v1),
            start_time : v0,
        };
        0x2::event::emit<GameCreated>(v2);
        0x2::transfer::share_object<Game>(v1);
    }

    public fun exp_points(arg0: &Experience) : u64 {
        arg0.points
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun mint_admin_cap(arg0: &mut 0x2::tx_context::TxContext, arg1: &AdminCap) : AdminCap {
        AdminCap{id: 0x2::object::new(arg0)}
    }

    public fun mint_admin_capv2(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg1)}
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &Game, arg2: &0x2::clock::Clock) {
        assert!(arg0 == id(arg1), 0);
        assert!(arg1.end_time < 0x2::clock::timestamp_ms(arg2), 4);
    }

    entry fun settle(arg0: &mut Game, arg1: vector<vector<u8>>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.end_time, 4);
        assert!(!arg0.is_settled, 5);
        assert!(0x1::vector::length<vector<u8>>(&arg1) == 0x1::vector::length<address>(&arg0.key_servers), 10);
        let v0 = 0x1::vector::empty<0x2::group_ops::Element<0x2::bls12381::G1>>();
        let v1 = 0;
        let v2 = 0x1::vector::length<vector<u8>>(&arg1);
        while (v1 < v2) {
            0x1::vector::push_back<0x2::group_ops::Element<0x2::bls12381::G1>>(&mut v0, 0x2::bls12381::g1_from_bytes(0x1::vector::borrow<vector<u8>>(&arg1, v1)));
            v1 = v1 + 1;
        };
        let v3 = 0x1::vector::empty<0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::PublicKey>();
        v1 = 0;
        while (v1 < v2) {
            0x1::vector::push_back<0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::PublicKey>(&mut v3, 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::new_public_key(0x2::object::id_from_address(*0x1::vector::borrow<address>(&arg0.key_servers, v1)), *0x1::vector::borrow<vector<u8>>(&arg0.public_keys, v1)));
            v1 = v1 + 1;
        };
        let v4 = 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::verify_derived_keys(&v0, @0xa72f11db0f24a399309505769466303024342e59daecf2019104ddd59693c897, 0x2::object::id_bytes<Game>(arg0), &v3);
        let v5 = arg0.count_a;
        let v6 = arg0.count_b;
        let v7 = arg0.real_votes_a;
        let v8 = arg0.real_votes_b;
        let v9 = arg0.real_votes_c;
        let v10 = 0;
        let v11 = 500;
        let v12 = if (0x1::option::is_some<address>(&arg0.lastaddress)) {
            arg0.lastaddress
        } else {
            *0x2::linked_table::front<address, vector<Vote>>(&arg0.votes)
        };
        let v13 = v12;
        while (0x1::option::is_some<address>(&v13) && v10 < v11) {
            let v14 = *0x1::option::borrow<address>(&v13);
            let v15 = 0x2::linked_table::borrow_mut<address, vector<Vote>>(&mut arg0.votes, v14);
            let v16 = 0;
            let v17 = true;
            while (v16 < 0x1::vector::length<Vote>(v15)) {
                if (v10 >= v11) {
                    v17 = false;
                    break
                };
                let v18 = 0x1::vector::borrow_mut<Vote>(v15, v16);
                if (0x1::option::is_some<u8>(&v18.decrypted_choice)) {
                    v16 = v16 + 1;
                    continue
                };
                let v19 = 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::decrypt(&v18.encrypted_vote, &v4, &v3);
                v10 = v10 + 1;
                if (0x1::option::is_some<vector<u8>>(&v19)) {
                    let v20 = 0x1::option::extract<vector<u8>>(&mut v19);
                    if (0x1::vector::length<u8>(&v20) >= 1) {
                        let v21 = *0x1::vector::borrow<u8>(&v20, 0);
                        let v22 = 0x1::vector::length<u8>(&v20) >= 2 && *0x1::vector::borrow<u8>(&v20, 1) == 1;
                        v18.decrypted_choice = 0x1::option::some<u8>(v21);
                        v18.is_disturbance = v22;
                        if (v22) {
                            let v23 = v18.amount / 2000000000;
                            if (v21 == 0) {
                                v5 = v5 + v23;
                                v7 = v7 + v23;
                                v6 = v6 + v23 * 3;
                            } else if (v21 == 1) {
                                v6 = v6 + v23;
                                v8 = v8 + v23;
                                v5 = v5 + v23 * 3;
                            };
                        } else {
                            let v24 = v18.amount / 1000000000;
                            if (v21 == 0) {
                                v5 = v5 + v24;
                                v7 = v7 + v24;
                            } else if (v21 == 1) {
                                v6 = v6 + v24;
                                v8 = v8 + v24;
                            } else {
                                v9 = v9 + v24;
                            };
                        };
                    };
                };
                v16 = v16 + 1;
            };
            if (v17) {
                v13 = *0x2::linked_table::next<address, vector<Vote>>(&arg0.votes, v14);
            };
        };
        arg0.count_a = v5;
        arg0.count_b = v6;
        arg0.real_votes_a = v7;
        arg0.real_votes_b = v8;
        arg0.real_votes_c = v9;
        arg0.lastaddress = v13;
        if (0x1::option::is_none<address>(&v13)) {
            let v25 = if (v5 > arg0.bomb_used_a) {
                v5 - arg0.bomb_used_a
            } else {
                0
            };
            let v26 = if (v6 > arg0.bomb_used_b) {
                v6 - arg0.bomb_used_b
            } else {
                0
            };
            if (v25 < 5 || v26 < 5) {
                arg0.winner_pool = 3;
                arg0.is_settled = true;
                let v27 = GameSettled{
                    game_id      : 0x2::object::id<Game>(arg0),
                    winner_pool  : 3,
                    total_payout : 0x2::balance::value<0x2::sui::SUI>(&arg0.total_pool),
                    count_red    : v25,
                    count_blue   : v26,
                    count_tie    : v9,
                };
                0x2::event::emit<GameSettled>(v27);
                return
            };
            let v28 = if (v25 > v26) {
                v25 - v26
            } else {
                v26 - v25
            };
            let v29 = 0x1::u64::sqrt(v26 + v25) * 46 / 100;
            let v30 = v29;
            if (v29 < 2) {
                v30 = 2;
            };
            let v31 = 0x2::balance::value<0x2::sui::SUI>(&arg0.total_pool);
            let v32 = 4;
            let v33 = 0;
            if (v28 < v30 && v9 > 0) {
                v32 = 2;
                v33 = v9;
            } else if (v25 < v26) {
                v32 = 0;
                v33 = v7;
            } else if (v25 > v26) {
                v32 = 1;
                v33 = v8;
            };
            arg0.winner_pool = v32;
            if (v33 > 0) {
                arg0.winning_share = v31 / v33;
            } else {
                arg0.winning_share = 0;
            };
            arg0.is_settled = true;
            let v34 = GameSettled{
                game_id      : 0x2::object::id<Game>(arg0),
                winner_pool  : v32,
                total_payout : v31,
                count_red    : v25,
                count_blue   : v26,
                count_tie    : v9,
            };
            0x2::event::emit<GameSettled>(v34);
        };
    }

    entry fun sponsor(arg0: &mut Game, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.end_time, 1);
        assert!(!arg0.is_settled, 5);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 1000000000, 3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.total_pool) + v0 <= 2000000000000000, 11);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.total_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = SponsorshipAdded{
            game_id : 0x2::object::id<Game>(arg0),
            sponsor : 0x2::tx_context::sender(arg3),
            amount  : v0,
        };
        0x2::event::emit<SponsorshipAdded>(v1);
    }

    public fun total_bomb_used(arg0: &Game) : u64 {
        arg0.bomb_used_a + arg0.bomb_used_b
    }

    public fun total_pool(arg0: &Game) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.total_pool) / 1000000000
    }

    public(friend) fun use_item_bomb(arg0: &mut Game, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.end_time - 3600000, 1);
        if (arg1 == 0) {
            arg0.bomb_used_a = arg0.bomb_used_a + arg2;
        } else if (arg1 == 1) {
            arg0.bomb_used_b = arg0.bomb_used_b + arg2;
        };
    }

    public fun view_claimable(arg0: &Game, arg1: address) : u64 {
        let v0 = 0;
        assert!(arg0.is_settled, 6);
        if (!0x2::linked_table::contains<address, vector<Vote>>(&arg0.votes, arg1)) {
            return 0
        };
        let v1 = 0x2::linked_table::borrow<address, vector<Vote>>(&arg0.votes, arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<Vote>(v1)) {
            let v3 = 0x1::vector::borrow<Vote>(v1, v2);
            let v4 = &v3.decrypted_choice;
            if (0x1::option::is_some<u8>(v4)) {
                if (arg0.winner_pool == 3) {
                    v0 = v0 + v3.amount;
                };
                let v5 = if (arg0.winner_pool == 0 && *0x1::option::borrow<u8>(v4) == 0 || arg0.winner_pool == 1 && *0x1::option::borrow<u8>(v4) == 1 || arg0.winner_pool == 2 && *0x1::option::borrow<u8>(v4) == 2) {
                    arg0.winning_share
                } else {
                    0
                };
                let v6 = if (v3.is_disturbance) {
                    v3.amount / 2000000000
                } else {
                    v3.amount / 1000000000
                };
                v0 = v0 + v6 * v5;
            };
            v2 = v2 + 1;
        };
        if (v0 == 0) {
            0
        } else {
            v0 - v0 / 10000
        }
    }

    entry fun vote(arg0: &mut Game, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : Experience {
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.end_time, 1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 % 1000000000 == 0, 2);
        assert!(v0 >= 1000000000, 3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.total_pool) + v0 <= 2000000000000000, 11);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.total_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::parse_encrypted_object(arg2);
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = 0x2::bcs::to_bytes<address>(&v2);
        let v4 = 0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::aad(&v1);
        assert!(0x1::option::is_some<vector<u8>>(v4), 2);
        assert!(0x1::option::borrow<vector<u8>>(v4) == &v3, 2);
        assert!(0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::services(&v1) == &arg0.key_servers, 2);
        assert!(0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::threshold(&v1) == arg0.threshold, 2);
        let v5 = @0xa72f11db0f24a399309505769466303024342e59daecf2019104ddd59693c897;
        assert!(0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::package_id(&v1) == &v5, 2);
        let v6 = id(arg0);
        assert!(0x9636e0c761e7476b8579cb13d543838e3732ca482dc0a64f086f57b60c024e23::bf_hmac_encryption::id(&v1) == &v6, 2);
        let v7 = Vote{
            voter            : v2,
            encrypted_vote   : v1,
            amount           : v0,
            decrypted_choice : 0x1::option::none<u8>(),
            is_disturbance   : false,
        };
        if (0x2::linked_table::contains<address, vector<Vote>>(&arg0.votes, v2)) {
            0x1::vector::push_back<Vote>(0x2::linked_table::borrow_mut<address, vector<Vote>>(&mut arg0.votes, v2), v7);
        } else {
            let v8 = 0x1::vector::empty<Vote>();
            0x1::vector::push_back<Vote>(&mut v8, v7);
            0x2::linked_table::push_back<address, vector<Vote>>(&mut arg0.votes, v2, v8);
        };
        let v9 = VoteCasted{
            game_id : 0x2::object::id<Game>(arg0),
            voter   : v2,
        };
        0x2::event::emit<VoteCasted>(v9);
        Experience{points: v0 / 1000000000}
    }

    // decompiled from Move bytecode v6
}

