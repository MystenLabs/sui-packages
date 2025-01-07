module 0xf8d8a2faf65d47ea487ce9ed2709b4e98b3f2c92a089c039b9a5fc0dc4ce5548::verifier {
    struct RewardNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct WrongAnswerNFT has store, key {
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

    struct Quest has store, key {
        id: 0x2::object::UID,
        question: 0x1::string::String,
        professor_address: address,
        professor_k_hash: vector<u8>,
        professor_kP_x: vector<u8>,
        professor_kP_y: vector<u8>,
    }

    struct StudentAnsweredEvent has copy, drop {
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

    public entry fun professor_create_quest(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::address::to_bytes(v0);
        *0x1::vector::borrow_mut<u8>(&mut v1, 31) = 0;
        0x1::debug::print<vector<u8>>(&v1);
        assert!(commit(arg1, arg2, arg3, arg4, v1), 0);
        let v2 = Quest{
            id                : 0x2::object::new(arg5),
            question          : 0x1::string::utf8(arg0),
            professor_address : v0,
            professor_k_hash  : arg2,
            professor_kP_x    : arg3,
            professor_kP_y    : arg4,
        };
        0x2::dynamic_object_field::add<vector<u8>, 0x2::table::Table<address, Answer>>(&mut v2.id, b"answers", 0x2::table::new<address, Answer>(arg5));
        0x2::transfer::share_object<Quest>(v2);
    }

    public entry fun professor_score_answer(arg0: &mut Quest, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = &mut arg0.professor_k_hash;
        let v2 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::table::Table<address, Answer>>(&mut arg0.id, b"answers");
        assert!(v0 == arg0.professor_address, 2);
        let v3 = 0x2::address::to_bytes(v0);
        *0x1::vector::borrow_mut<u8>(&mut v3, 31) = 0;
        assert!(0x2::table::contains<address, Answer>(v2, arg1), 3);
        let v4 = 0x2::table::borrow<address, Answer>(v2, arg1);
        assert!(unlock(arg2, arg3, arg4, v3, *v1, v4.student_aH_x, v4.student_aH_y), 4);
        if (arg3 == v4.akP_x && arg4 == v4.akP_y) {
            let v5 = RewardNFT{
                id          : 0x2::object::new(arg5),
                name        : 0x1::string::utf8(b"zkPrize"),
                description : 0x1::string::utf8(b"Unleash your brilliance silently and seize the zkPrize - Your winning answers, a mystery to all but winners!"),
                url         : 0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieo6hprbh3pjghihriasgjrg3fw6j2urmy6ti2k276qrl4k3uax2u"),
            };
            0x2::transfer::transfer<RewardNFT>(v5, v4.student_address);
        } else {
            let v6 = WrongAnswerNFT{id: 0x2::object::new(arg5)};
            0x2::transfer::transfer<WrongAnswerNFT>(v6, v4.student_address);
        };
        0x2::table::remove<address, Answer>(v2, arg1);
    }

    public entry fun student_answer_question(arg0: &mut Quest, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = &mut arg0.professor_address;
        let v2 = &mut arg0.professor_kP_x;
        let v3 = &mut arg0.professor_kP_y;
        let v4 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::table::Table<address, Answer>>(&mut arg0.id, b"answers");
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 1000000000 / 10000000, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, *v1);
        let v5 = !0x2::table::contains<address, Answer>(v4, v0);
        assert!(v5, 3);
        let v6 = 0x2::address::to_bytes(v0);
        *0x1::vector::borrow_mut<u8>(&mut v6, 31) = 0;
        0x1::debug::print<vector<u8>>(&v6);
        assert!(commit(arg2, arg3, arg4, arg5, v6), 8);
        assert!(unlock(arg6, arg7, arg8, v6, arg3, *v2, *v3), 5);
        let v7 = 0x2::clock::timestamp_ms(arg9);
        let v8 = Answer{
            student_a_hash     : arg3,
            student_aH_x       : arg4,
            student_aH_y       : arg5,
            timestamp_answered : v7,
            student_address    : v0,
            akP_x              : arg7,
            akP_y              : arg8,
        };
        if (v5) {
            0x2::table::add<address, Answer>(v4, v0, v8);
        };
        let v9 = StudentAnsweredEvent{
            timestamp_answered : v7,
            student_address    : v0,
            akP_x              : arg7,
            akP_y              : arg8,
            student_aH_x       : arg4,
            student_aH_y       : arg5,
        };
        0x2::event::emit<StudentAnsweredEvent>(v9);
    }

    public entry fun student_get_timeout_reward(arg0: &mut Quest, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, 0x2::table::Table<address, Answer>>(&mut arg0.id, b"answers");
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, Answer>(v0, v1), 3);
        if (0x2::clock::timestamp_ms(arg1) - 0x2::table::borrow_mut<address, Answer>(v0, v1).timestamp_answered > 120000) {
            0x2::table::remove<address, Answer>(v0, v1);
            let v2 = RewardNFT{
                id          : 0x2::object::new(arg2),
                name        : 0x1::string::utf8(b"zkPrize"),
                description : 0x1::string::utf8(b"Unleash your brilliance silently and seize the zkPrize - Your winning answers, a mystery to all but winners!"),
                url         : 0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieo6hprbh3pjghihriasgjrg3fw6j2urmy6ti2k276qrl4k3uax2u"),
            };
            0x2::transfer::transfer<RewardNFT>(v2, v1);
        };
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

