module 0x7039b2e494b34fdb9bb8fd0144101e2b83f0d4ed6fe4dd579892abefa58e32fd::random_joke {
    struct RandomJoke has copy, drop {
        index: u64,
        joke: 0x1::string::String,
        creator: address,
    }

    struct Joke has store {
        index: u64,
        text: 0x1::string::String,
        creator: address,
    }

    struct JokeStore has store, key {
        id: 0x2::object::UID,
        jokes: vector<Joke>,
        next_index: u64,
    }

    public entry fun add_joke(arg0: &mut JokeStore, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg1) <= 260, 1000);
        let v0 = Joke{
            index   : arg0.next_index,
            text    : arg1,
            creator : 0x2::tx_context::sender(arg2),
        };
        0x1::vector::push_back<Joke>(&mut arg0.jokes, v0);
        arg0.next_index = arg0.next_index + 1;
    }

    public entry fun generate_random_joke(arg0: &JokeStore, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<Joke>(&arg0.jokes);
        assert!(v0 > 0, 1001);
        let v1 = 0x2::random::new_generator(arg1, arg2);
        let v2 = 0x1::vector::borrow<Joke>(&arg0.jokes, 0x2::random::generate_u64(&mut v1) % v0);
        let v3 = RandomJoke{
            index   : v2.index,
            joke    : v2.text,
            creator : v2.creator,
        };
        0x2::event::emit<RandomJoke>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = JokeStore{
            id         : 0x2::object::new(arg0),
            jokes      : 0x1::vector::empty<Joke>(),
            next_index : 0,
        };
        0x2::transfer::share_object<JokeStore>(v0);
    }

    // decompiled from Move bytecode v6
}

