module 0xbe111ffa7a01d9f59d88d2039afdefc7beadd48d17e92553afbdf8bc955b35a0::random_joke {
    struct RandomJoke has copy, drop {
        index: u64,
        joke: 0x1::string::String,
    }

    struct JokeStore has store, key {
        id: 0x2::object::UID,
        jokes: vector<0x1::string::String>,
    }

    public entry fun add_joke(arg0: &mut JokeStore, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg1) <= 260, 1000);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.jokes, arg1);
    }

    public entry fun generate_random_joke(arg0: &JokeStore, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg0.jokes);
        assert!(v0 > 0, 1001);
        let v1 = 0x2::random::new_generator(arg1, arg2);
        let v2 = 0x2::random::generate_u64(&mut v1) % v0;
        let v3 = RandomJoke{
            index : v2,
            joke  : *0x1::vector::borrow<0x1::string::String>(&arg0.jokes, v2),
        };
        0x2::event::emit<RandomJoke>(v3);
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

