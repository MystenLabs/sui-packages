module 0x970fc7e5236a443ad87b3d9f0d23220a4ce5deb16c48887669c793c341a974a1::demo {
    struct People has store, key {
        id: 0x2::object::UID,
        age: u64,
        scores: vector<u64>,
    }

    public entry fun add_score(arg0: &mut People, arg1: u64) {
        0x1::vector::push_back<u64>(&mut arg0.scores, arg1);
    }

    public fun age(arg0: &People) : u64 {
        arg0.age
    }

    public entry fun create_people(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = People{
            id     : 0x2::object::new(arg1),
            age    : arg0,
            scores : vector[],
        };
        0x2::transfer::public_transfer<People>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun score_at(arg0: &People, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.scores, arg1)
    }

    public fun score_count(arg0: &People) : u64 {
        0x1::vector::length<u64>(&arg0.scores)
    }

    public entry fun set_age(arg0: &mut People, arg1: u64) {
        arg0.age = arg1;
    }

    // decompiled from Move bytecode v7
}

