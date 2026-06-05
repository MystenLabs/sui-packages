module 0x45a0a84ed12b8d98dad793894b583dd3d8be11786a6930c55699adda6de34db4::demo {
    struct People has store, key {
        id: 0x2::object::UID,
        age: u64,
        scores: vector<u64>,
    }

    struct Alive has copy, drop, store {
        dummy_field: bool,
    }

    public entry fun add_alive(arg0: &mut People) {
        let v0 = Alive{dummy_field: false};
        0x2::dynamic_field::add<Alive, bool>(&mut arg0.id, v0, true);
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

    public fun has_alive(arg0: &People) : bool {
        let v0 = Alive{dummy_field: false};
        0x2::dynamic_field::exists_with_type<Alive, bool>(&arg0.id, v0)
    }

    public entry fun remove_alive(arg0: &mut People) {
        let v0 = Alive{dummy_field: false};
        0x2::dynamic_field::remove<Alive, bool>(&mut arg0.id, v0);
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

