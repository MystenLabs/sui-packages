module 0xe930eb52b047d3387202a8f245ae7a2125da0b883ae5df9231a07887409ea957::promise {
    struct Promise has key {
        id: 0x2::object::UID,
        maker: address,
        oracle: address,
        promise_id: 0x1::string::String,
        slug: 0x1::string::String,
        terms_hash: 0x1::string::String,
        proof: 0x1::string::String,
        promise_state: u64,
        strength: u64,
        resistance: u64,
        promised_at: u64,
        settled_at: u64,
        origin: 0x1::string::String,
    }

    struct Minted has copy, drop {
        promise: address,
        slug: 0x1::string::String,
        terms_hash: 0x1::string::String,
    }

    struct Settled has copy, drop {
        promise: address,
        kept: bool,
        strength: u64,
        resistance: u64,
    }

    public fun advance(arg0: &mut Promise, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.maker, 10);
        assert!(arg0.promise_state < 3, 7);
        assert!(arg1 > arg0.promise_state && arg1 < 3, 9);
        arg0.promise_state = arg1;
    }

    public fun create_promise(arg0: address, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = Promise{
            id            : 0x2::object::new(arg8),
            maker         : arg0,
            oracle        : arg1,
            promise_id    : arg2,
            slug          : arg3,
            terms_hash    : arg4,
            proof         : arg5,
            promise_state : 0,
            strength      : 0,
            resistance    : 0,
            promised_at   : 0x2::clock::timestamp_ms(arg7),
            settled_at    : 0,
            origin        : arg6,
        };
        let v1 = Minted{
            promise    : 0x2::object::uid_to_address(&v0.id),
            slug       : v0.slug,
            terms_hash : v0.terms_hash,
        };
        0x2::event::emit<Minted>(v1);
        0x2::transfer::share_object<Promise>(v0);
    }

    public fun maker(arg0: &Promise) : address {
        arg0.maker
    }

    public fun oracle(arg0: &Promise) : address {
        arg0.oracle
    }

    public fun origin(arg0: &Promise) : &0x1::string::String {
        &arg0.origin
    }

    public fun promise_id(arg0: &Promise) : &0x1::string::String {
        &arg0.promise_id
    }

    public fun promise_state(arg0: &Promise) : u64 {
        arg0.promise_state
    }

    public fun promised_at(arg0: &Promise) : u64 {
        arg0.promised_at
    }

    public fun proof(arg0: &Promise) : &0x1::string::String {
        &arg0.proof
    }

    public fun resistance(arg0: &Promise) : u64 {
        arg0.resistance
    }

    public fun settle_promise(arg0: &mut Promise, arg1: bool, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.oracle, 8);
        assert!(arg0.promise_state < 3, 7);
        let v0 = if (arg2 > 10000) {
            10000
        } else {
            arg2
        };
        if (arg1) {
            arg0.promise_state = 3;
            arg0.strength = arg0.strength + v0;
        } else {
            arg0.promise_state = 4;
            arg0.resistance = arg0.resistance + v0;
        };
        arg0.settled_at = 0x2::clock::timestamp_ms(arg3);
        let v1 = Settled{
            promise    : 0x2::object::uid_to_address(&arg0.id),
            kept       : arg1,
            strength   : arg0.strength,
            resistance : arg0.resistance,
        };
        0x2::event::emit<Settled>(v1);
    }

    public fun settled_at(arg0: &Promise) : u64 {
        arg0.settled_at
    }

    public fun slug(arg0: &Promise) : &0x1::string::String {
        &arg0.slug
    }

    public fun strength(arg0: &Promise) : u64 {
        arg0.strength
    }

    public fun terms_hash(arg0: &Promise) : &0x1::string::String {
        &arg0.terms_hash
    }

    // decompiled from Move bytecode v7
}

