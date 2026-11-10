module 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::collaboration {
    struct Story has key {
        id: 0x2::object::UID,
        model_id: 0x2::object::ID,
        creator: address,
        opening: 0x1::string::String,
        text: 0x1::string::String,
        revision: u64,
        words: u64,
        transactions: u64,
        last_contributor: address,
        session: 0x1::option::Option<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::inference::Session>,
        generating: bool,
        generations: u64,
        closed: bool,
        context_start: u64,
    }

    struct StoryCreated has copy, drop {
        story_id: 0x2::object::ID,
        creator: address,
    }

    struct WordAdded has copy, drop {
        story_id: 0x2::object::ID,
        author: address,
        word: 0x1::string::String,
        revision: u64,
    }

    public fun advance(arg0: &mut Story, arg1: &0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::Model, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.generating && !arg0.closed, 3);
        assert!(arg0.revision == arg4, 4);
        0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::inference::advance(0x1::option::borrow_mut<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::inference::Session>(&mut arg0.session), arg1, arg2, arg3, arg5);
    }

    public fun cancel_turn(arg0: &mut Story, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.revision == arg1, 4);
        assert!(arg0.generating, 3);
        assert!(0x2::tx_context::sender(arg2) == arg0.creator || 0x2::tx_context::sender(arg2) == arg0.last_contributor, 2);
        let v0 = 0x1::option::extract<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::inference::Session>(&mut arg0.session);
        arg0.transactions = arg0.transactions + 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::inference::transaction_count(&v0);
        0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::inference::discard(v0);
        arg0.generating = false;
        arg0.revision = arg0.revision + 1;
    }

    public fun close(arg0: &mut Story, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.revision == arg1, 4);
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 2);
        assert!(!arg0.generating && !arg0.closed, 3);
        if (0x1::option::is_some<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::inference::Session>(&arg0.session)) {
            0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::inference::discard(0x1::option::extract<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::inference::Session>(&mut arg0.session));
        };
        arg0.closed = true;
        arg0.transactions = arg0.transactions + 1;
    }

    fun context(arg0: &mut Story) : 0x1::string::String {
        let v0 = 0x1::string::length(&arg0.text);
        if (v0 - arg0.context_start > 122) {
            let v1 = v0 - 64;
            while (*0x1::vector::borrow<u8>(0x1::string::as_bytes(&arg0.text), v1) & 192 == 128) {
                v1 = v1 + 1;
            };
            arg0.context_start = v1;
        };
        0x1::string::substring(&arg0.text, arg0.context_start, v0)
    }

    public fun contribute(arg0: &mut Story, arg1: &0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::Model, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.closed && !arg0.generating, 3);
        assert!(0x2::object::id<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::Model>(arg1) == arg0.model_id, 5);
        assert!(arg0.revision == arg3, 4);
        assert!(0x1::string::length(&arg2) > 0 && 0x1::string::length(&arg2) <= 32, 0);
        let v0 = 0x1::string::as_bytes(&arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(v0)) {
            let v2 = 0x1::vector::borrow<u8>(v0, v1);
            assert!(*v2 > 32 && *v2 < 127, 0);
            v1 = v1 + 1;
        };
        assert!(0x1::string::length(&arg0.text) + 1 + 0x1::string::length(&arg2) + 256 <= 4096, 1);
        0x1::string::append(&mut arg0.text, 0x1::string::utf8(b" "));
        0x1::string::append(&mut arg0.text, arg2);
        arg0.revision = arg0.revision + 1;
        arg0.words = arg0.words + 1;
        arg0.transactions = arg0.transactions + 1;
        arg0.last_contributor = 0x2::tx_context::sender(arg4);
        let v3 = context(arg0);
        if (0x1::option::is_none<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::inference::Session>(&arg0.session)) {
            0x1::option::fill<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::inference::Session>(&mut arg0.session, 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::inference::start_word(arg1, v3, 42, arg4));
        } else {
            0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::inference::resume(0x1::option::borrow_mut<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::inference::Session>(&mut arg0.session), arg1, v3, 4, arg4);
        };
        arg0.generating = true;
        let v4 = WordAdded{
            story_id : 0x2::object::id<Story>(arg0),
            author   : 0x2::tx_context::sender(arg4),
            word     : arg2,
            revision : arg0.revision,
        };
        0x2::event::emit<WordAdded>(v4);
    }

    public fun create(arg0: &0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::Model, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::is_sealed(arg0), 5);
        assert!(0x1::string::length(&arg1) > 0 && 0x1::string::length(&arg1) <= 160, 1);
        let v0 = Story{
            id               : 0x2::object::new(arg2),
            model_id         : 0x2::object::id<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_model::Model>(arg0),
            creator          : 0x2::tx_context::sender(arg2),
            opening          : arg1,
            text             : arg1,
            revision         : 0,
            words            : 0,
            transactions     : 1,
            last_contributor : 0x2::tx_context::sender(arg2),
            session          : 0x1::option::none<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::inference::Session>(),
            generating       : false,
            generations      : 0,
            closed           : false,
            context_start    : 0,
        };
        let v1 = StoryCreated{
            story_id : 0x2::object::id<Story>(&v0),
            creator  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<StoryCreated>(v1);
        0x2::transfer::share_object<Story>(v0);
    }

    public fun finish_turn(arg0: &mut Story, arg1: u64) {
        assert!(arg0.generating, 3);
        assert!(arg0.revision == arg1, 4);
        let v0 = 0x1::option::borrow_mut<0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::inference::Session>(&mut arg0.session);
        assert!(0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::inference::is_complete(v0), 3);
        let v1 = 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::inference::answer_bytes(v0);
        assert!(0x1::string::length(&arg0.text) + 0x1::vector::length<u8>(&v1) <= 4096, 1);
        let v2 = 0x1::string::try_utf8(v1);
        let v3 = false;
        while (0x1::option::is_none<0x1::string::String>(&v2)) {
            0x1::vector::pop_back<u8>(&mut v1);
            v3 = true;
            v2 = 0x1::string::try_utf8(v1);
        };
        let v4 = 0x1::string::into_bytes(0x1::option::destroy_some<0x1::string::String>(v2));
        if (v3) {
            0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::story_words::trim_partial_word(&mut v4);
        };
        0x1::string::append(&mut arg0.text, 0x1::string::utf8(v4));
        arg0.transactions = arg0.transactions + 0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::inference::transaction_count(v0);
        0xc5d13d65be352fbc778d4cdcceba3c7ebb12050f042b0abf15b755b24447d244::inference::pause(v0);
        arg0.generating = false;
        arg0.generations = arg0.generations + 1;
        arg0.revision = arg0.revision + 1;
    }

    public fun has_generation(arg0: &Story) : bool {
        arg0.generating
    }

    public fun is_closed(arg0: &Story) : bool {
        arg0.closed
    }

    public fun revision(arg0: &Story) : u64 {
        arg0.revision
    }

    public fun text(arg0: &Story) : 0x1::string::String {
        arg0.text
    }

    // decompiled from Move bytecode v7
}

