module 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::inference {
    struct CacheKey has copy, drop, store {
        pos0: u64,
    }

    struct Cache has drop, store {
        keys: vector<vector<u64>>,
        values: vector<vector<u64>>,
    }

    struct Session has store, key {
        id: 0x2::object::UID,
        model_id: 0x2::object::ID,
        requester: address,
        prompt: 0x1::string::String,
        original_seed: u64,
        last_contributor: address,
        transactions: u64,
        finalized: bool,
        prompt_hash: vector<u8>,
        prompt_count: u64,
        tokens: vector<u64>,
        generated: vector<u64>,
        answer: vector<u8>,
        max_tokens: u64,
        seed: u64,
        sampling: u8,
        trace_logits: bool,
        position: u64,
        layer: u64,
        phase: u8,
        cursor: u64,
        work_done: u64,
        complete: bool,
        eos: bool,
        x: vector<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>,
        normalized: vector<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>,
        query: vector<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>,
        key: vector<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>,
        attended: vector<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>,
        up: vector<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>,
        gate: vector<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>,
        buffer: vector<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>,
    }

    struct StoryOpened has copy, drop {
        session_id: 0x2::object::ID,
        model_id: 0x2::object::ID,
        prompt_tokens: vector<u64>,
        max_tokens: u64,
        seed: u64,
        creative: bool,
    }

    struct StoryAdvanced has copy, drop {
        session_id: 0x2::object::ID,
        generated_tokens: vector<u64>,
        answer_bytes: vector<u8>,
        position: u64,
        layer: u64,
        phase: u8,
        work_done: u64,
        complete: bool,
    }

    struct StoryCompleted has copy, drop {
        session_id: 0x2::object::ID,
        model_id: 0x2::object::ID,
        requester: address,
        prompt_hash: vector<u8>,
        generated_tokens: vector<u64>,
        answer_bytes: vector<u8>,
        text: 0x1::option::Option<0x1::string::String>,
        eos: bool,
    }

    struct LogitsCalculated has copy, drop {
        session_id: 0x2::object::ID,
        position: u64,
        logits: vector<u64>,
    }

    public fun advance(arg0: &mut Session, arg1: &0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::Model, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.model_id == 0x2::object::id<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::Model>(arg1), 0);
        assert!(!arg0.complete, 2);
        assert!(arg2 > 0 && arg2 <= 128, 1);
        assert!(arg0.work_done == arg3, 7);
        arg0.last_contributor = 0x2::tx_context::sender(arg4);
        arg0.transactions = arg0.transactions + 1;
        let v0 = 0;
        while (v0 < arg2 && !arg0.complete) {
            one_work(arg0, arg1);
            arg0.work_done = arg0.work_done + 1;
            v0 = v0 + 1;
        };
        let v1 = StoryAdvanced{
            session_id       : 0x2::object::id<Session>(arg0),
            generated_tokens : arg0.generated,
            answer_bytes     : arg0.answer,
            position         : arg0.position,
            layer            : arg0.layer,
            phase            : arg0.phase,
            work_done        : arg0.work_done,
            complete         : arg0.complete,
        };
        0x2::event::emit<StoryAdvanced>(v1);
    }

    public fun answer_bytes(arg0: &Session) : vector<u8> {
        arg0.answer
    }

    public fun cached_positions(arg0: &Session) : u64 {
        arg0.position + 1
    }

    public fun cancel(arg0: Session, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.requester, 5);
        assert!(!arg0.finalized, 6);
        let v0 = &mut arg0;
        remove_caches(v0);
        let Session {
            id               : v1,
            model_id         : _,
            requester        : _,
            prompt           : _,
            original_seed    : _,
            last_contributor : _,
            transactions     : _,
            finalized        : _,
            prompt_hash      : _,
            prompt_count     : _,
            tokens           : _,
            generated        : _,
            answer           : _,
            max_tokens       : _,
            seed             : _,
            sampling         : _,
            trace_logits     : _,
            position         : _,
            layer            : _,
            phase            : _,
            cursor           : _,
            work_done        : _,
            complete         : _,
            eos              : _,
            x                : _,
            normalized       : _,
            query            : _,
            key              : _,
            attended         : _,
            up               : _,
            gate             : _,
            buffer           : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    public(friend) fun discard(arg0: Session) {
        assert!(!arg0.finalized, 6);
        let v0 = &mut arg0;
        remove_caches(v0);
        let Session {
            id               : v1,
            model_id         : _,
            requester        : _,
            prompt           : _,
            original_seed    : _,
            last_contributor : _,
            transactions     : _,
            finalized        : _,
            prompt_hash      : _,
            prompt_count     : _,
            tokens           : _,
            generated        : _,
            answer           : _,
            max_tokens       : _,
            seed             : _,
            sampling         : _,
            trace_logits     : _,
            position         : _,
            layer            : _,
            phase            : _,
            cursor           : _,
            work_done        : _,
            complete         : _,
            eos              : _,
            x                : _,
            normalized       : _,
            query            : _,
            key              : _,
            attended         : _,
            up               : _,
            gate             : _,
            buffer           : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    public fun finish(arg0: &mut Session) {
        assert!(arg0.complete, 2);
        assert!(!arg0.finalized, 6);
        let v0 = StoryCompleted{
            session_id       : 0x2::object::id<Session>(arg0),
            model_id         : arg0.model_id,
            requester        : arg0.requester,
            prompt_hash      : arg0.prompt_hash,
            generated_tokens : arg0.generated,
            answer_bytes     : arg0.answer,
            text             : 0x1::string::try_utf8(arg0.answer),
            eos              : arg0.eos,
        };
        0x2::event::emit<StoryCompleted>(v0);
        remove_caches(arg0);
        arg0.finalized = true;
        arg0.transactions = arg0.transactions + 1;
        arg0.x = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
        arg0.normalized = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
        arg0.query = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
        arg0.key = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
        arg0.attended = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
        arg0.up = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
        arg0.gate = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
        arg0.buffer = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
    }

    public fun generated(arg0: &Session) : vector<u64> {
        arg0.generated
    }

    public fun is_complete(arg0: &Session) : bool {
        arg0.complete
    }

    public fun is_finalized(arg0: &Session) : bool {
        arg0.finalized
    }

    public fun last_contributor(arg0: &Session) : address {
        arg0.last_contributor
    }

    fun next_prompt(arg0: &mut Session, arg1: &0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::Model) {
        arg0.position = arg0.position + 1;
        let v0 = *0x1::vector::borrow<u64>(&arg0.tokens, arg0.position);
        reset_token(arg0, arg1, v0);
    }

    fun one_work(arg0: &mut Session, arg1: &0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::Model) {
        let v0 = 1 + arg0.layer * 7;
        let v1 = arg0.phase;
        let v2 = &v1;
        if (*v2 == 0) {
            arg0.normalized = 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_math::rms(&arg0.x, 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::gain(arg1, arg0.layer * 2));
            let v3 = if (arg0.layer == 4 && arg0.position + 1 < arg0.prompt_count) {
                2
            } else {
                1
            };
            arg0.phase = v3;
        } else if (*v2 == 1) {
            projection_work(arg0, arg1, v0);
        } else if (*v2 == 2) {
            projection_work(arg0, arg1, v0);
        } else if (*v2 == 3) {
            projection_work(arg0, arg1, v0);
        } else if (*v2 == 4) {
            let v4 = CacheKey{pos0: arg0.layer};
            let v5 = 0x2::dynamic_field::borrow<CacheKey, Cache>(&arg0.id, v4);
            0x1::vector::append<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(&mut arg0.attended, 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_math::attention_head(&arg0.query, &v5.keys, &v5.values, 0x1::vector::length<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(&arg0.attended) / 8));
            if (0x1::vector::length<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(&arg0.attended) == 64) {
                arg0.phase = 5;
            };
        } else if (*v2 == 5) {
            projection_work(arg0, arg1, v0);
        } else if (*v2 == 6) {
            arg0.normalized = 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_math::rms(&arg0.x, 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::gain(arg1, arg0.layer * 2 + 1));
            arg0.phase = 7;
        } else if (*v2 == 7) {
            projection_work(arg0, arg1, v0);
        } else if (*v2 == 8) {
            projection_work(arg0, arg1, v0);
        } else if (*v2 == 9) {
            arg0.up = 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_math::swiglu(&arg0.up, &arg0.gate);
            arg0.gate = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
            arg0.phase = 10;
        } else if (*v2 == 10) {
            projection_work(arg0, arg1, v0);
        } else if (*v2 == 11) {
            arg0.normalized = 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_math::rms(&arg0.x, 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::gain(arg1, 10));
            arg0.phase = 12;
        } else {
            assert!(*v2 == 12, 4);
            projection_work(arg0, arg1, v0);
        };
    }

    public fun open(arg0: &0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::Model, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<Session>(start(arg0, arg1, arg2, arg3, arg4, false, arg5));
    }

    public fun open_verified(arg0: &0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::Model, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<Session>(start(arg0, arg1, arg2, arg3, arg4, true, arg5));
    }

    public(friend) fun pause(arg0: &mut Session) {
        assert!(arg0.complete && !arg0.finalized, 2);
        arg0.x = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
        arg0.normalized = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
        arg0.query = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
        arg0.key = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
        arg0.attended = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
        arg0.up = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
        arg0.gate = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
        arg0.buffer = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
    }

    fun projection_work(arg0: &mut Session, arg1: &0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::Model, arg2: u64) {
        let v0 = arg0.phase;
        let v1 = &v0;
        let (v2, v3) = if (*v1 == 1) {
            (arg2, 64)
        } else if (*v1 == 2) {
            (arg2 + 1, 32)
        } else if (*v1 == 3) {
            (arg2 + 2, 32)
        } else if (*v1 == 5) {
            (arg2 + 3, 64)
        } else {
            let (v4, v5) = if (*v1 == 7) {
                (172, arg2 + 4)
            } else {
                let (v6, v7) = if (*v1 == 8) {
                    (arg2 + 6, 172)
                } else if (*v1 == 10) {
                    (arg2 + 5, 64)
                } else {
                    assert!(*v1 == 12, 4);
                    (0, 512)
                };
                (v7, v6)
            };
            (v5, v4)
        };
        let v8 = 0x1::u64::min(64, v3 - arg0.cursor);
        let v9 = if (arg0.phase == 5) {
            &arg0.attended
        } else if (arg0.phase == 10) {
            &arg0.up
        } else {
            &arg0.normalized
        };
        0x1::vector::append<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(&mut arg0.buffer, 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::project(arg1, v9, v2, arg0.cursor, v8));
        arg0.cursor = arg0.cursor + v8;
        if (arg0.cursor < v3) {
            return
        };
        arg0.cursor = 0;
        let v10 = arg0.phase;
        let v11 = &v10;
        if (*v11 == 1) {
            arg0.query = 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_math::rotate(&arg0.buffer, 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::rope(arg1), arg0.position);
            arg0.phase = 2;
        } else if (*v11 == 2) {
            arg0.key = 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_math::rotate(&arg0.buffer, 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::rope(arg1), arg0.position);
            arg0.phase = 3;
        } else if (*v11 == 3) {
            let v12 = CacheKey{pos0: arg0.layer};
            let v13 = 0x2::dynamic_field::borrow_mut<CacheKey, Cache>(&mut arg0.id, v12);
            assert!(0x1::vector::length<vector<u64>>(&v13.keys) == arg0.position && 0x1::vector::length<vector<u64>>(&v13.values) == arg0.position, 4);
            let v14 = &mut v13.keys;
            let v15 = &arg0.key;
            let v16 = vector[];
            let v17 = 0;
            while (v17 < 0x1::vector::length<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(v15)) {
                0x1::vector::push_back<u64>(&mut v16, 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::pack(*0x1::vector::borrow<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(v15, v17)));
                v17 = v17 + 1;
            };
            0x1::vector::push_back<vector<u64>>(v14, v16);
            let v18 = &arg0.buffer;
            let v19 = vector[];
            let v20 = 0;
            while (v20 < 0x1::vector::length<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(v18)) {
                0x1::vector::push_back<u64>(&mut v19, 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::pack(*0x1::vector::borrow<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(v18, v20)));
                v20 = v20 + 1;
            };
            0x1::vector::push_back<vector<u64>>(&mut v13.values, v19);
            if (arg0.layer == 4 && arg0.position + 1 < arg0.prompt_count) {
                next_prompt(arg0, arg1);
            } else {
                arg0.phase = 4;
            };
        } else if (*v11 == 5) {
            arg0.x = 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::tensor::add(&arg0.x, &arg0.buffer);
            arg0.phase = 6;
        } else if (*v11 == 7) {
            arg0.up = arg0.buffer;
            arg0.phase = 8;
        } else if (*v11 == 8) {
            arg0.gate = arg0.buffer;
            arg0.phase = 9;
        } else if (*v11 == 10) {
            arg0.x = 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::tensor::add(&arg0.x, &arg0.buffer);
            arg0.query = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
            arg0.key = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
            arg0.attended = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
            arg0.up = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
            if (arg0.layer == 4) {
                arg0.phase = 11;
            } else {
                arg0.layer = arg0.layer + 1;
                arg0.phase = 0;
            };
        } else {
            assert!(*v11 == 12, 4);
            if (arg0.trace_logits) {
                let v21 = &arg0.buffer;
                let v22 = vector[];
                let v23 = 0;
                while (v23 < 0x1::vector::length<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(v21)) {
                    0x1::vector::push_back<u64>(&mut v22, 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::pack(*0x1::vector::borrow<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(v21, v23)));
                    v23 = v23 + 1;
                };
                let v24 = LogitsCalculated{
                    session_id : 0x2::object::id<Session>(arg0),
                    position   : arg0.position,
                    logits     : v22,
                };
                0x2::event::emit<LogitsCalculated>(v24);
            };
            let (v25, v26) = 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_math::choose(&arg0.buffer, &arg0.tokens, arg0.seed, arg0.sampling & 1 != 0);
            arg0.seed = v26;
            let v27 = arg0.sampling & 2 != 0 && 0x1::vector::length<u64>(&arg0.generated) >= 4;
            0x1::vector::push_back<u64>(&mut arg0.generated, v25);
            let v28 = v25 == 1 || v25 == 2;
            arg0.eos = v28;
            let v29 = false;
            if (!arg0.eos) {
                if (v27) {
                    v29 = 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_words::continue_word(&mut arg0.answer, 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::piece(arg1, v25));
                } else {
                    0x1::vector::append<u8>(&mut arg0.answer, 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::piece(arg1, v25));
                    v29 = 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_words::ends_at_boundary(&arg0.answer);
                };
                0x1::vector::push_back<u64>(&mut arg0.tokens, v25);
            };
            let v30 = if (arg0.eos) {
                true
            } else if (0x1::vector::length<u64>(&arg0.generated) >= arg0.max_tokens) {
                true
            } else if (arg0.sampling & 2 != 0) {
                if (0x1::vector::length<u64>(&arg0.generated) >= 4) {
                    v29
                } else {
                    false
                }
            } else {
                false
            };
            arg0.complete = v30;
            if (arg0.sampling & 2 != 0 && arg0.complete) {
                if (!arg0.eos && !v29) {
                    0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_words::trim_partial_word(&mut arg0.answer);
                } else {
                    0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_words::trim_spaces(&mut arg0.answer);
                };
            };
            if (!arg0.complete) {
                arg0.position = arg0.position + 1;
                reset_token(arg0, arg1, v25);
            };
        };
        arg0.buffer = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
    }

    fun remove_caches(arg0: &mut Session) {
        let v0 = 0;
        while (v0 < 5) {
            let v1 = CacheKey{pos0: v0};
            0x2::dynamic_field::remove<CacheKey, Cache>(&mut arg0.id, v1);
            v0 = v0 + 1;
        };
    }

    fun reset_token(arg0: &mut Session, arg1: &0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::Model, arg2: u64) {
        assert!(arg0.position < 128, 3);
        arg0.x = 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::embedding(arg1, arg2);
        arg0.layer = 0;
        arg0.phase = 0;
        arg0.cursor = 0;
        arg0.normalized = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
        arg0.query = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
        arg0.key = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
        arg0.attended = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
        arg0.up = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
        arg0.gate = 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>();
    }

    public(friend) fun resume(arg0: &mut Session, arg1: &0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::Model, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.complete && !arg0.finalized, 2);
        assert!(arg0.model_id == 0x2::object::id<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::Model>(arg1), 0);
        let v0 = 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::tokenize(arg1, &arg2);
        let v1 = if (arg3 > 0) {
            if (arg3 <= 24) {
                0x1::vector::length<u64>(&v0) + arg3 <= 128
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 3);
        let v2 = 0;
        let v3 = CacheKey{pos0: 0};
        while (v2 < 0x1::u64::min(0x1::vector::length<vector<u64>>(&0x2::dynamic_field::borrow<CacheKey, Cache>(&arg0.id, v3).keys), 0x1::vector::length<u64>(&v0) - 1) && *0x1::vector::borrow<u64>(&arg0.tokens, v2) == *0x1::vector::borrow<u64>(&v0, v2)) {
            v2 = v2 + 1;
        };
        let v4 = 0;
        while (v4 < 5) {
            let v5 = CacheKey{pos0: v4};
            let v6 = 0x2::dynamic_field::borrow_mut<CacheKey, Cache>(&mut arg0.id, v5);
            while (0x1::vector::length<vector<u64>>(&v6.keys) > v2) {
                0x1::vector::pop_back<vector<u64>>(&mut v6.keys);
                0x1::vector::pop_back<vector<u64>>(&mut v6.values);
            };
            v4 = v4 + 1;
        };
        arg0.prompt = arg2;
        arg0.prompt_hash = 0x2::hash::blake2b256(0x1::string::as_bytes(&arg2));
        arg0.prompt_count = 0x1::vector::length<u64>(&v0);
        arg0.tokens = v0;
        arg0.generated = vector[];
        arg0.answer = b"";
        let v7 = if (arg0.sampling & 2 != 0) {
            0x1::u64::min(8, 128 - 0x1::vector::length<u64>(&v0))
        } else {
            arg3
        };
        arg0.max_tokens = v7;
        arg0.requester = 0x2::tx_context::sender(arg4);
        arg0.last_contributor = 0x2::tx_context::sender(arg4);
        arg0.original_seed = arg0.seed;
        arg0.transactions = 1;
        arg0.work_done = 0;
        arg0.complete = false;
        arg0.eos = false;
        arg0.position = v2;
        let v8 = *0x1::vector::borrow<u64>(&arg0.tokens, v2);
        reset_token(arg0, arg1, v8);
    }

    public(friend) fun start(arg0: &0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::Model, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : Session {
        start_impl(arg0, arg1, arg2, arg3, arg4, arg5, false, arg6)
    }

    fun start_impl(arg0: &0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::Model, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : Session {
        assert!(0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::is_sealed(arg0), 0);
        let v0 = if (arg2 > 0) {
            if (arg2 <= 96) {
                if (arg3 > 0) {
                    arg3 <= 4294967295
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        let v1 = 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::tokenize(arg0, &arg1);
        let v2 = if (arg6) {
            assert!(0x1::vector::length<u64>(&v1) + 4 <= 128, 3);
            0x1::u64::min(arg2, 128 - 0x1::vector::length<u64>(&v1))
        } else {
            arg2
        };
        assert!(0x1::vector::length<u64>(&v1) + v2 <= 128, 3);
        let v3 = if (arg4) {
            1
        } else {
            0
        };
        let v4 = if (arg6) {
            2
        } else {
            0
        };
        let v5 = Session{
            id               : 0x2::object::new(arg7),
            model_id         : 0x2::object::id<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::Model>(arg0),
            requester        : 0x2::tx_context::sender(arg7),
            prompt           : arg1,
            original_seed    : arg3,
            last_contributor : 0x2::tx_context::sender(arg7),
            transactions     : 1,
            finalized        : false,
            prompt_hash      : 0x2::hash::blake2b256(0x1::string::as_bytes(&arg1)),
            prompt_count     : 0x1::vector::length<u64>(&v1),
            tokens           : v1,
            generated        : vector[],
            answer           : b"",
            max_tokens       : v2,
            seed             : arg3,
            sampling         : v3 | v4,
            trace_logits     : arg5,
            position         : 0,
            layer            : 0,
            phase            : 0,
            cursor           : 0,
            work_done        : 0,
            complete         : false,
            eos              : false,
            x                : 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::embedding(arg0, 1),
            normalized       : 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(),
            query            : 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(),
            key              : 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(),
            attended         : 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(),
            up               : 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(),
            gate             : 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(),
            buffer           : 0x1::vector::empty<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::fixed::Fixed>(),
        };
        let v6 = 0;
        while (v6 < 5) {
            let v7 = CacheKey{pos0: v6};
            let v8 = Cache{
                keys   : vector[],
                values : vector[],
            };
            0x2::dynamic_field::add<CacheKey, Cache>(&mut v5.id, v7, v8);
            v6 = v6 + 1;
        };
        let v9 = StoryOpened{
            session_id    : 0x2::object::id<Session>(&v5),
            model_id      : 0x2::object::id<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::Model>(arg0),
            prompt_tokens : v5.tokens,
            max_tokens    : v2,
            seed          : arg3,
            creative      : arg4,
        };
        0x2::event::emit<StoryOpened>(v9);
        v5
    }

    public(friend) fun start_word(arg0: &0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::Model, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Session {
        start_impl(arg0, arg1, 8, arg2, true, false, true, arg3)
    }

    public fun transaction_count(arg0: &Session) : u64 {
        arg0.transactions
    }

    // decompiled from Move bytecode v7
}

