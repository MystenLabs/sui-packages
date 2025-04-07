module 0xe316fb8f6c5a423e72522f882541d68979c829f3248ddacf186f95fa7bf04ff5::challenge {
    struct Challenge has key {
        id: 0x2::object::UID,
        owner: address,
        secret_hash: vector<u8>,
        attempts: u64,
        max_attempts: u64,
        last_attempt_time: u64,
        is_solved: bool,
        reward: Reward,
        stage: u64,
        target_score: u64,
        current_score: u64,
        bonus_multiplier: u64,
    }

    struct Reward has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    struct FlagEvent has copy, drop {
        flag: vector<u8>,
    }

    struct ScoreEvent has copy, drop {
        score: u64,
    }

    public entry fun claim_reward(arg0: &mut Challenge, arg1: &mut 0x2::tx_context::TxContext) {
        if (arg0.stage != 3 || !arg0.is_solved) {
            return
        };
        let v0 = Reward{
            id    : 0x2::object::new(arg1),
            value : arg0.reward.value,
        };
        0x2::transfer::transfer<Reward>(v0, 0x2::tx_context::sender(arg1));
        reset_challenge(arg0);
        let v1 = FlagEvent{flag: b"flag{LetsMoveCTF}"};
        0x2::event::emit<FlagEvent>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Reward{
            id    : 0x2::object::new(arg0),
            value : 10000,
        };
        let v1 = Challenge{
            id                : 0x2::object::new(arg0),
            owner             : 0x2::tx_context::sender(arg0),
            secret_hash       : 0x1::hash::sha3_256(b"LetsMoveCTF"),
            attempts          : 0,
            max_attempts      : 50,
            last_attempt_time : 0,
            is_solved         : false,
            reward            : v0,
            stage             : 1,
            target_score      : 100,
            current_score     : 0,
            bonus_multiplier  : 0,
        };
        0x2::transfer::share_object<Challenge>(v1);
    }

    fun reset_challenge(arg0: &mut Challenge) {
        arg0.attempts = 0;
        arg0.last_attempt_time = 0;
        arg0.is_solved = false;
        arg0.stage = 1;
        arg0.current_score = 0;
        arg0.bonus_multiplier = 1;
    }

    public entry fun submit_guess(arg0: &mut Challenge, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg0.stage != 2) {
            return
        };
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (v0 < arg0.last_attempt_time + 5000) {
            return
        };
        arg0.attempts = arg0.attempts + 1;
        if (arg0.attempts > arg0.max_attempts) {
            arg0.stage = 1;
            arg0.current_score = 0;
            arg0.attempts = 0;
            return
        };
        if (0x1::hash::sha3_256(arg1) == arg0.secret_hash) {
            arg0.is_solved = true;
            arg0.stage = 3;
        };
        arg0.last_attempt_time = v0;
    }

    public entry fun submit_score(arg0: &mut Challenge, arg1: u64, arg2: &0x2::clock::Clock) {
        if (arg0.stage != 1) {
            return
        };
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (v0 < arg0.last_attempt_time + 5000) {
            return
        };
        arg0.attempts = arg0.attempts + 1;
        if (arg0.attempts > arg0.max_attempts) {
            arg0.current_score = 0;
            arg0.attempts = 0;
            return
        };
        arg0.current_score = arg0.current_score + arg1 * arg0.bonus_multiplier;
        arg0.last_attempt_time = v0;
        let v1 = ScoreEvent{score: arg0.current_score};
        0x2::event::emit<ScoreEvent>(v1);
        if (arg0.current_score >= arg0.target_score) {
            arg0.stage = 2;
        };
    }

    // decompiled from Move bytecode v6
}

