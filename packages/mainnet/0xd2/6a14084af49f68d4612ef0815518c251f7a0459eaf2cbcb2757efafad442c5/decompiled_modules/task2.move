module 0xd26a14084af49f68d4612ef0815518c251f7a0459eaf2cbcb2757efafad442c5::task2 {
    struct Challenge has key {
        id: 0x2::object::UID,
        owner: address,
        secret_hash: vector<u8>,
        attempts: u64,
        max_attempts: u64,
        last_attempt_time: u64,
        is_solved: bool,
        stage: u64,
        target_score: u64,
        current_score: u64,
        bonus_multiplier: u64,
        guess_round: u64,
        round_hash: vector<u8>,
        seed: u64,
    }

    struct FlagEvent has copy, drop {
        flag: vector<u8>,
        github_id: 0x1::string::String,
    }

    struct ScoreEvent has copy, drop {
        score: u64,
    }

    fun compare_hash_prefix(arg0: &vector<u8>, arg1: &vector<u8>, arg2: u64) : bool {
        if (0x1::vector::length<u8>(arg0) < arg2 || 0x1::vector::length<u8>(arg1) < arg2) {
            return false
        };
        let v0 = 0;
        while (v0 < arg2) {
            if (*0x1::vector::borrow<u8>(arg0, v0) != *0x1::vector::borrow<u8>(arg1, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public entry fun get_flag(arg0: &mut Challenge, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.stage == 3 && arg0.is_solved, 1);
        reset_challenge(arg0);
        let v0 = FlagEvent{
            flag      : b"flag{LetsMoveCTF_chapter_2}",
            github_id : arg1,
        };
        0x2::event::emit<FlagEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::hash::sha3_256(b"LetsMoveCTF");
        let v1 = Challenge{
            id                : 0x2::object::new(arg0),
            owner             : 0x2::tx_context::sender(arg0),
            secret_hash       : v0,
            attempts          : 0,
            max_attempts      : 50,
            last_attempt_time : 0,
            is_solved         : false,
            stage             : 1,
            target_score      : 100,
            current_score     : 0,
            bonus_multiplier  : 0,
            guess_round       : 1,
            round_hash        : v0,
            seed              : 0,
        };
        0x2::transfer::share_object<Challenge>(v1);
    }

    public fun reset_challenge(arg0: &mut Challenge) {
        arg0.attempts = 0;
        arg0.last_attempt_time = 0;
        arg0.is_solved = false;
        arg0.stage = 1;
        arg0.current_score = 0;
        arg0.bonus_multiplier = 1;
        arg0.guess_round = 1;
        arg0.round_hash = arg0.secret_hash;
    }

    public entry fun submit_guess(arg0: &mut Challenge, arg1: &0x2::random::Random, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.stage == 2, 1);
        let v0 = 0x2::random::new_generator(arg1, arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 >= arg0.last_attempt_time + 5000, 2);
        assert!(arg0.attempts < arg0.max_attempts, 3);
        arg0.attempts = arg0.attempts + 1;
        0x1::vector::append<u8>(&mut arg2, to_bytes(arg0.last_attempt_time));
        0x1::vector::append<u8>(&mut arg2, to_bytes(arg0.attempts));
        let v2 = 0x1::hash::sha3_256(arg2);
        if (compare_hash_prefix(&v2, &arg0.round_hash, arg0.guess_round * 2)) {
            arg0.guess_round = arg0.guess_round + 1;
            0x1::vector::append<u8>(&mut v2, to_bytes(arg0.seed + arg0.guess_round));
            arg0.round_hash = 0x1::hash::sha3_256(v2);
            arg0.seed = 0x2::random::generate_u64(&mut v0);
            if (arg0.guess_round > 3) {
                arg0.is_solved = true;
                arg0.stage = 3;
                arg0.guess_round = 1;
                arg0.attempts = 0;
            };
        };
        arg0.last_attempt_time = v1;
    }

    public entry fun submit_score(arg0: &mut Challenge, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg0.stage == 1, 1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.last_attempt_time + 5000, 2);
        arg0.attempts = arg0.attempts + 1;
        assert!(arg0.attempts < arg0.max_attempts, 3);
        let v1 = arg0.attempts * 2;
        let v2 = if (arg1 > v1) {
            arg1 - v1
        } else {
            0
        };
        arg0.current_score = arg0.current_score + v2 * arg0.bonus_multiplier + (v0 - arg0.last_attempt_time) / 1000;
        arg0.last_attempt_time = v0;
        let v3 = ScoreEvent{score: arg0.current_score};
        0x2::event::emit<ScoreEvent>(v3);
        if (arg0.current_score >= arg0.target_score) {
            arg0.stage = 2;
            arg0.attempts = 0;
        };
    }

    fun to_bytes(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 8) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 >> v1 * 8 & 255) as u8));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

