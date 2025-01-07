module 0x2d0095fe4e7ded8ee1c03b2a7367a63348c2f5ea66b309b98c20df50c7d0187e::character {
    struct Character has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        experience: u64,
    }

    struct CharacterNameRegistry has store, key {
        id: 0x2::object::UID,
        registry: 0x2::vec_set::VecSet<0x1::string::String>,
    }

    struct Update has copy, drop {
        for: address,
    }

    public(friend) fun add_experience(arg0: &mut Character, arg1: u64) {
        arg0.experience = arg0.experience + arg1;
    }

    public fun character_experience(arg0: &Character) : &u64 {
        &arg0.experience
    }

    public fun character_name(arg0: &Character) : &0x1::string::String {
        &arg0.name
    }

    public fun create_character(arg0: 0x1::string::String, arg1: &mut CharacterNameRegistry, arg2: &mut 0x2::tx_context::TxContext) : Character {
        assert!(0x1::string::length(&arg0) > 3 && 0x1::string::length(&arg0) < 20, 0);
        assert!(!0x2::vec_set::contains<0x1::string::String>(&arg1.registry, &arg0), 1);
        let v0 = Update{for: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<Update>(v0);
        0x2::vec_set::insert<0x1::string::String>(&mut arg1.registry, arg0);
        Character{
            id         : 0x2::object::new(arg2),
            name       : arg0,
            experience : 0,
        }
    }

    public fun delete_character(arg0: Character, arg1: &mut CharacterNameRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let Character {
            id         : v0,
            name       : v1,
            experience : _,
        } = arg0;
        let v3 = v1;
        let v4 = Update{for: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<Update>(v4);
        0x2::vec_set::remove<0x1::string::String>(&mut arg1.registry, &v3);
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CharacterNameRegistry{
            id       : 0x2::object::new(arg0),
            registry : 0x2::vec_set::empty<0x1::string::String>(),
        };
        0x2::transfer::share_object<CharacterNameRegistry>(v0);
    }

    // decompiled from Move bytecode v6
}

