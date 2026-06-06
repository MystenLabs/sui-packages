module 0xbaaec71439318bcf705fd0ba2e5acda6c908adfa6a55448e1e6aec25abb58e1e::demo {
    struct People has store, key {
        id: 0x2::object::UID,
        age: u64,
        scores: vector<u64>,
        owner: address,
    }

    struct Alive has copy, drop, store {
        dummy_field: bool,
    }

    struct ScoreKey has copy, drop, store {
        subject: u64,
    }

    struct Profile has store {
        height: u64,
        weight: u64,
    }

    struct ProfileKey has copy, drop, store {
        dummy_field: bool,
    }

    public entry fun add_alive(arg0: &mut People) {
        let v0 = Alive{dummy_field: false};
        0x2::dynamic_field::add<Alive, bool>(&mut arg0.id, v0, true);
    }

    public entry fun add_profile(arg0: &mut People, arg1: u64, arg2: u64) {
        let v0 = ProfileKey{dummy_field: false};
        let v1 = Profile{
            height : arg1,
            weight : arg2,
        };
        0x2::dynamic_field::add<ProfileKey, Profile>(&mut arg0.id, v0, v1);
    }

    public entry fun add_score(arg0: &mut People, arg1: u64) {
        0x1::vector::push_back<u64>(&mut arg0.scores, arg1);
    }

    public entry fun add_subject_score(arg0: &mut People, arg1: u64, arg2: u64) {
        let v0 = ScoreKey{subject: arg1};
        0x2::dynamic_field::add<ScoreKey, u64>(&mut arg0.id, v0, arg2);
    }

    public fun age(arg0: &People) : u64 {
        arg0.age
    }

    public entry fun create_people(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = People{
            id     : 0x2::object::new(arg1),
            age    : arg0,
            scores : vector[],
            owner  : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::public_transfer<People>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun get_height(arg0: &People) : u64 {
        let v0 = ProfileKey{dummy_field: false};
        0x2::dynamic_field::borrow<ProfileKey, Profile>(&arg0.id, v0).height
    }

    public fun has_alive(arg0: &People) : bool {
        let v0 = Alive{dummy_field: false};
        0x2::dynamic_field::exists_with_type<Alive, bool>(&arg0.id, v0)
    }

    public entry fun remove_alive(arg0: &mut People) {
        let v0 = Alive{dummy_field: false};
        0x2::dynamic_field::remove<Alive, bool>(&mut arg0.id, v0);
    }

    public entry fun remove_subject_score(arg0: &mut People, arg1: u64) {
        let v0 = ScoreKey{subject: arg1};
        0x2::dynamic_field::remove<ScoreKey, u64>(&mut arg0.id, v0);
    }

    public fun score_at(arg0: &People, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.scores, arg1)
    }

    public fun score_count(arg0: &People) : u64 {
        0x1::vector::length<u64>(&arg0.scores)
    }

    public entry fun set_age(arg0: &mut People, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        arg0.age = arg1;
    }

    public entry fun set_height(arg0: &mut People, arg1: u64, arg2: u64) {
        let v0 = ProfileKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<ProfileKey, Profile>(&mut arg0.id, v0);
        v1.height = arg1;
        v1.weight = arg2;
    }

    public entry fun update_subject_score(arg0: &mut People, arg1: u64, arg2: u64) {
        let v0 = ScoreKey{subject: arg1};
        *0x2::dynamic_field::borrow_mut<ScoreKey, u64>(&mut arg0.id, v0) = arg2;
    }

    // decompiled from Move bytecode v7
}

