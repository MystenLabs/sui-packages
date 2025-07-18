module 0x2efbe02081fbe55bb0dee6b1a9f1712f0e380e08b85140f26667c3a53243e163::random_joke {
    struct RandomJoke has copy, drop {
        index: u64,
        joke: 0x1::string::String,
    }

    struct JokeStore has store, key {
        id: 0x2::object::UID,
        jokes: vector<0x1::string::String>,
    }

    public entry fun add_joke(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg0) <= 260, 1000);
        let v0 = get_joke_store(arg1);
        0x1::vector::push_back<0x1::string::String>(&mut v0.jokes, arg0);
        0x2::transfer::share_object<JokeStore>(v0);
    }

    public entry fun generate_random_joke(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = get_joke_store(arg1);
        let v1 = 0x1::vector::length<0x1::string::String>(&v0.jokes);
        assert!(v1 > 0, 1001);
        let v2 = 0x2::random::new_generator(arg0, arg1);
        let v3 = 0x2::random::generate_u64(&mut v2) % v1;
        let v4 = RandomJoke{
            index : v3,
            joke  : *0x1::vector::borrow<0x1::string::String>(&v0.jokes, v3),
        };
        0x2::event::emit<RandomJoke>(v4);
        0x2::transfer::share_object<JokeStore>(v0);
    }

    fun get_joke_store(arg0: &mut 0x2::tx_context::TxContext) : JokeStore {
        abort 1002
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = JokeStore{
            id    : 0x2::object::new(arg0),
            jokes : 0x1::vector::empty<0x1::string::String>(),
        };
        0x2::transfer::share_object<JokeStore>(v0);
    }

    // decompiled from Move bytecode v6
}

