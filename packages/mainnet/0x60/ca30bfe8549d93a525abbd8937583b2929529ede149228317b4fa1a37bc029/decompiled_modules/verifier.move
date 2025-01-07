module 0x60ca30bfe8549d93a525abbd8937583b2929529ede149228317b4fa1a37bc029::verifier {
    struct RewardNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        b36addr: 0x1::string::String,
        level: u64,
        game: address,
    }

    struct WrongAnswerNFT has store, key {
        id: 0x2::object::UID,
    }

    struct RightAnswerNFT has store, key {
        id: 0x2::object::UID,
    }

    struct Answer has drop, store {
        student_a_hash: vector<u8>,
        student_aH_x: vector<u8>,
        student_aH_y: vector<u8>,
        timestamp_answered: u64,
        student_address: address,
        akP_x: vector<u8>,
        akP_y: vector<u8>,
    }

    struct Game has store, key {
        id: 0x2::object::UID,
        professor_address: address,
        questions: vector<address>,
        profiles: 0x2::table::Table<address, UserProfile>,
    }

    struct UserProfile has store, key {
        id: 0x2::object::UID,
        level: u64,
        answered_right: vector<address>,
        wrong_attempts: 0x2::vec_map::VecMap<address, u64>,
    }

    struct Quest has store, key {
        id: 0x2::object::UID,
        points: u64,
        game: address,
        winners: 0x2::table::Table<address, bool>,
        question: 0x1::string::String,
        image_blob: 0x1::string::String,
        professor_address: address,
        professor_k_hash: vector<u8>,
        professor_kP_x: vector<u8>,
        professor_kP_y: vector<u8>,
    }

    struct StudentAnsweredEvent has copy, drop {
        game_id: address,
        question_id: address,
        timestamp_answered: u64,
        student_address: address,
        akP_x: vector<u8>,
        akP_y: vector<u8>,
        student_aH_x: vector<u8>,
        student_aH_y: vector<u8>,
    }

    struct VERIFIER has drop {
        dummy_field: bool,
    }

    fun commit(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) : bool {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, 0x2::hex::decode(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::hex::decode(arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::hex::decode(arg3));
        0x1::vector::append<u8>(&mut v0, arg4);
        0x1::debug::print<vector<u8>>(&v0);
        let v1 = verify(arg0, x"e2f26dbea299f5223b646cb1fb33eadb059d9407559d7441dfd902e3a79a4d2dabb73dc17fbc13021e2471e0c08bd67d8401f52b73d6d07483794cad4778180e0c06f33bbc4c79a9cadef253a68084d382f17788f885c9afd176f7cb2f036789edf692d95cbdde46ddda5ef7d422436779445c5e66006a42761e1f12efde0018c212f3aeb785e49712e7a9353349aaf1255dfb31b7bf60723a480d9293938e19f1555ee802f49f17c1ded7f8e0a35efd4a7caa5c66b14c5de3bc15e7ac579e02350ae505a137c6dd2a84365a88f2771ab96e4e33c0fdaf5b58ca9cf8528045870500000000000000d05232298846333af5b9c786e300fb364e8f91277dfbd9113761976ef811bd8ae05f5921e1ea4e7a81d8e1217b553562139326591186de5ad755c02ca9519e2a2c8cd74dd2ca1759a54bcfd8d6bb03fcc2fc185ea98112e22fd667275112c7202c27f5c74e447fb310add441802dfa1d53bc87297703e7a90d0438166a2ab6a87b2099a5ca41e6c4c88a00eee53d4bd51c95d13cb8d03d19fa68352e59e9d997", v0);
        0x1::debug::print<bool>(&v1);
        v1
    }

    public fun get_blob_from_number(arg0: u64) : 0x1::ascii::String {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::ascii::String>(v1, 0x1::ascii::string(b"0"));
        0x1::vector::push_back<0x1::ascii::String>(v1, 0x1::ascii::string(b"https://arty-arty.github.io/Bronze.svg"));
        0x1::vector::push_back<0x1::ascii::String>(v1, 0x1::ascii::string(b"2"));
        0x1::vector::push_back<0x1::ascii::String>(v1, 0x1::ascii::string(b"https://arty-arty.github.io/Silver.svg"));
        0x1::vector::push_back<0x1::ascii::String>(v1, 0x1::ascii::string(b"4"));
        0x1::vector::push_back<0x1::ascii::String>(v1, 0x1::ascii::string(b"5"));
        0x1::vector::push_back<0x1::ascii::String>(v1, 0x1::ascii::string(b"6"));
        0x1::vector::push_back<0x1::ascii::String>(v1, 0x1::ascii::string(b"https://arty-arty.github.io/Gold.svg"));
        0x1::vector::push_back<0x1::ascii::String>(v1, 0x1::ascii::string(b"8"));
        0x1::vector::push_back<0x1::ascii::String>(v1, 0x1::ascii::string(b"9"));
        0x1::vector::push_back<0x1::ascii::String>(v1, 0x1::ascii::string(b"https://arty-arty.github.io/Diamond.svg"));
        if (arg0 < 0x1::vector::length<0x1::ascii::String>(&v0)) {
            *0x1::vector::borrow<0x1::ascii::String>(&v0, arg0)
        } else {
            0x1::ascii::string(b"Invalid")
        }
    }

    fun init(arg0: VERIFIER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        let v4 = 0x2::package::claim<VERIFIER>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<RewardNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<RewardNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<RewardNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun professor_create_game(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id                : 0x2::object::new(arg0),
            professor_address : 0x2::tx_context::sender(arg0),
            questions         : 0x1::vector::empty<address>(),
            profiles          : 0x2::table::new<address, UserProfile>(arg0),
        };
        0x2::transfer::share_object<Game>(v0);
    }

    public entry fun professor_create_quest(arg0: &mut Game, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(arg0.professor_address == v0, 98331);
        let v1 = 0x2::address::to_bytes(v0);
        *0x1::vector::borrow_mut<u8>(&mut v1, 31) = 0;
        0x1::debug::print<vector<u8>>(&v1);
        assert!(commit(arg4, arg5, arg6, arg7, v1), 0);
        let v2 = Quest{
            id                : 0x2::object::new(arg8),
            points            : arg1,
            game              : 0x2::object::uid_to_address(&arg0.id),
            winners           : 0x2::table::new<address, bool>(arg8),
            question          : 0x1::string::utf8(arg3),
            image_blob        : 0x1::string::utf8(arg2),
            professor_address : v0,
            professor_k_hash  : arg5,
            professor_kP_x    : arg6,
            professor_kP_y    : arg7,
        };
        0x2::dynamic_object_field::add<vector<u8>, 0x2::table::Table<address, Answer>>(&mut v2.id, b"answers", 0x2::table::new<address, Answer>(arg8));
        0x1::vector::push_back<address>(&mut arg0.questions, 0x2::object::uid_to_address(&v2.id));
        0x2::transfer::share_object<Quest>(v2);
    }

    public entry fun professor_score_answer(arg0: &mut Quest, arg1: &mut Game, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = &mut arg0.points;
        let v2 = &mut arg0.game;
        let v3 = &mut arg0.winners;
        let v4 = &mut arg0.professor_k_hash;
        let v5 = &mut arg0.id;
        let v6 = 0x2::object::uid_to_address(v5);
        let v7 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::table::Table<address, Answer>>(v5, b"answers");
        assert!(v0 == arg0.professor_address, 2);
        assert!(*v2 == 0x2::object::uid_to_address(&arg1.id), 8980);
        let v8 = 0x2::address::to_bytes(v0);
        *0x1::vector::borrow_mut<u8>(&mut v8, 31) = 0;
        assert!(0x2::table::contains<address, Answer>(v7, arg2), 3);
        let v9 = 0x2::table::borrow<address, Answer>(v7, arg2);
        assert!(unlock(arg3, arg4, arg5, v8, *v4, v9.student_aH_x, v9.student_aH_y), 4);
        let v10 = arg4 == v9.akP_x && arg5 == v9.akP_y;
        let v11 = &mut arg1.profiles;
        if (!0x2::table::contains<address, UserProfile>(v11, arg2)) {
            let v12 = UserProfile{
                id             : 0x2::object::new(arg6),
                level          : 0,
                answered_right : 0x1::vector::empty<address>(),
                wrong_attempts : 0x2::vec_map::empty<address, u64>(),
            };
            0x2::table::add<address, UserProfile>(v11, arg2, v12);
        };
        let v13 = 0x2::table::borrow_mut<address, UserProfile>(v11, arg2);
        if (v10) {
            0x2::table::add<address, bool>(v3, arg2, true);
            v13.level = v13.level + *v1;
            0x1::vector::push_back<address>(&mut v13.answered_right, v6);
            if (v13.level == 1 || v13.level == 3 || v13.level == 7 || v13.level == 10) {
                let v14 = 0x2::object::new(arg6);
                let v15 = RewardNFT{
                    id          : v14,
                    name        : 0x1::string::utf8(b"zkPrize"),
                    description : 0x1::string::utf8(b"At this level you get a new prize certified by zk. Get to the top level for the VIP prize."),
                    url         : 0x2::url::new_unsafe(get_blob_from_number(v13.level)),
                    b36addr     : to_b36(0x2::object::uid_to_address(&v14)),
                    level       : v13.level,
                    game        : arg0.game,
                };
                0x2::transfer::transfer<RewardNFT>(v15, v9.student_address);
            };
        } else {
            if (!0x2::vec_map::contains<address, u64>(&v13.wrong_attempts, &v6)) {
                0x2::vec_map::insert<address, u64>(&mut v13.wrong_attempts, v6, 0);
            };
            let v16 = 0x2::vec_map::get_mut<address, u64>(&mut v13.wrong_attempts, &v6);
            *v16 = *v16 + 1;
        };
        0x2::table::remove<address, Answer>(v7, arg2);
    }

    public entry fun student_answer_question(arg0: &mut Quest, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = &mut arg0.game;
        let v2 = &mut arg0.professor_address;
        let v3 = &mut arg0.professor_kP_x;
        let v4 = &mut arg0.professor_kP_y;
        assert!(!0x2::table::contains<address, bool>(&mut arg0.winners, v0), 94411);
        let v5 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::table::Table<address, Answer>>(&mut arg0.id, b"answers");
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 1000000000 / 10000000, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, *v2);
        let v6 = !0x2::table::contains<address, Answer>(v5, v0);
        assert!(v6, 3);
        let v7 = 0x2::address::to_bytes(v0);
        *0x1::vector::borrow_mut<u8>(&mut v7, 31) = 0;
        0x1::debug::print<vector<u8>>(&v7);
        assert!(commit(arg2, arg3, arg4, arg5, v7), 8);
        assert!(unlock(arg6, arg7, arg8, v7, arg3, *v3, *v4), 5);
        let v8 = 0x2::clock::timestamp_ms(arg9);
        let v9 = Answer{
            student_a_hash     : arg3,
            student_aH_x       : arg4,
            student_aH_y       : arg5,
            timestamp_answered : v8,
            student_address    : v0,
            akP_x              : arg7,
            akP_y              : arg8,
        };
        if (v6) {
            0x2::table::add<address, Answer>(v5, v0, v9);
        };
        let v10 = StudentAnsweredEvent{
            game_id            : *v1,
            question_id        : 0x2::object::uid_to_address(&arg0.id),
            timestamp_answered : v8,
            student_address    : v0,
            akP_x              : arg7,
            akP_y              : arg8,
            student_aH_x       : arg4,
            student_aH_y       : arg5,
        };
        0x2::event::emit<StudentAnsweredEvent>(v10);
    }

    public fun to_b36(arg0: address) : 0x1::string::String {
        let v0 = 0x2::address::to_bytes(arg0);
        let v1 = 2 * 0x1::vector::length<u8>(&v0);
        let v2 = b"0123456789abcdefghijklmnopqrstuvwxyz";
        let v3 = 0x1::vector::length<u8>(&v2);
        let v4 = 0x1::vector::empty<u8>();
        let v5 = 0;
        while (v5 < v1) {
            0x1::vector::push_back<u8>(&mut v4, 0);
            v5 = v5 + 1;
        };
        let v6 = v1 - 1;
        let v7 = 0;
        while (v7 < 0x1::vector::length<u8>(&v0)) {
            let v8 = (*0x1::vector::borrow<u8>(&v0, v7) as u64);
            let v9 = v1 - 1;
            while (v9 > v6 || v8 != 0) {
                let v10 = v8 + 256 * (*0x1::vector::borrow<u8>(&v4, v9) as u64);
                *0x1::vector::borrow_mut<u8>(&mut v4, v9) = ((v10 % v3) as u8);
                v8 = v10 / v3;
                v9 = v9 - 1;
            };
            v6 = v9;
            v7 = v7 + 1;
        };
        let v11 = b"";
        let v12 = 0;
        let v13 = true;
        while (v12 < 0x1::vector::length<u8>(&v4)) {
            let v14 = (*0x1::vector::borrow<u8>(&v4, v12) as u64);
            if (v14 != 0 && v13) {
                v13 = false;
            };
            if (!v13) {
                0x1::vector::push_back<u8>(&mut v11, *0x1::vector::borrow<u8>(&v2, v14));
            };
            v12 = v12 + 1;
        };
        0x1::string::utf8(v11)
    }

    fun unlock(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>) : bool {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, 0x2::hex::decode(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::hex::decode(arg2));
        0x1::vector::append<u8>(&mut v0, arg3);
        0x1::vector::append<u8>(&mut v0, 0x2::hex::decode(arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::hex::decode(arg5));
        0x1::vector::append<u8>(&mut v0, 0x2::hex::decode(arg6));
        verify(arg0, x"e2f26dbea299f5223b646cb1fb33eadb059d9407559d7441dfd902e3a79a4d2dabb73dc17fbc13021e2471e0c08bd67d8401f52b73d6d07483794cad4778180e0c06f33bbc4c79a9cadef253a68084d382f17788f885c9afd176f7cb2f036789edf692d95cbdde46ddda5ef7d422436779445c5e66006a42761e1f12efde0018c212f3aeb785e49712e7a9353349aaf1255dfb31b7bf60723a480d9293938e19887208fad3f8550e15bf3215798913226934b2d643d5a5f9c34a048aa168172467d50cca4f282065b87d49e7bc3e06b50b3675c66a1c2db2fedd8cbeed76ae2b0700000000000000d05232298846333af5b9c786e300fb364e8f91277dfbd9113761976ef811bd8a87f7c971b71d490782ad5a062ba629c632d23a8c32ccccbd6f90eef0706f4dae0de6bf1b29e90ec277a567aa9582c21e84322e41eb92789b0bec360a94061887494fd99769977a167bced33324f2e2fd654f141dc77844d8375e2d2d6bb55890c863813be5a227e8cc56108364ec7b07228479a299c26da09771ccb3b31a4a074616f0b4ea057686c6fd2d5bffbd4165a352e61744f2b27a971952ace6a9881061021a3b9efae96006b4e0334b7c0a437e941ebf91de9981acba5608b3825a08", v0)
    }

    fun verify(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : bool {
        let v0 = 0x2::groth16::bn254();
        let v1 = 0x2::groth16::prepare_verifying_key(&v0, &arg1);
        0x1::debug::print<0x2::groth16::PreparedVerifyingKey>(&v1);
        let v2 = 0x2::groth16::public_proof_inputs_from_bytes(arg2);
        let v3 = 0x2::groth16::proof_points_from_bytes(0x2::hex::decode(arg0));
        0x2::groth16::verify_groth16_proof(&v0, &v1, &v2, &v3)
    }

    // decompiled from Move bytecode v6
}

