module 0x28bae0217055fe470efd268101fca41466f201caa696e6dfdfb27867d32f2f9a::character {
    struct Character has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        position: 0x1::string::String,
        experience: u64,
        classe: 0x1::string::String,
        sex: 0x1::string::String,
    }

    struct CharacterNameRegistry has store, key {
        id: 0x2::object::UID,
        registry: 0x2::table::Table<0x1::string::String, address>,
    }

    struct CHARACTER has drop {
        dummy_field: bool,
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

    public fun create_character(arg0: &mut CharacterNameRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : Character {
        let v0 = to_lower_case(arg1);
        assert!(0x1::string::length(&v0) > 3 && 0x1::string::length(&v0) < 20, 0);
        assert!(!0x2::table::contains<0x1::string::String, address>(&arg0.registry, v0), 1);
        assert!(valid_classe(arg2), 2);
        assert!(valid_sex(arg3), 3);
        let v1 = Update{for: 0x2::tx_context::sender(arg4)};
        0x2::event::emit<Update>(v1);
        0x2::table::add<0x1::string::String, address>(&mut arg0.registry, v0, 0x2::tx_context::sender(arg4));
        Character{
            id         : 0x2::object::new(arg4),
            name       : v0,
            position   : 0x1::string::utf8(b"{\"x\":0,\"y\":0,\"z\":0}"),
            experience : 0,
            classe     : arg2,
            sex        : arg3,
        }
    }

    public fun delete_character(arg0: Character, arg1: &mut CharacterNameRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let Character {
            id         : v0,
            name       : v1,
            position   : _,
            experience : _,
            classe     : _,
            sex        : _,
        } = arg0;
        let v6 = Update{for: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<Update>(v6);
        0x2::table::remove<0x1::string::String, address>(&mut arg1.registry, v1);
        0x2::object::delete(v0);
    }

    fun init(arg0: CHARACTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CharacterNameRegistry{
            id       : 0x2::object::new(arg1),
            registry : 0x2::table::new<0x1::string::String, address>(arg1),
        };
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://app.aresrpg.world/classe/{classe}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://raw.githubusercontent.com/aresrpg/aresrpg-dapp/master/src/assets/classe/{classe}_{sex}.jpg"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Character part of the AresRPG universe."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://aresrpg.world"));
        let v5 = 0x2::package::claim<CHARACTER>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<Character>(&v5, v1, v3, arg1);
        0x2::display::update_version<Character>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Character>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<CharacterNameRegistry>(v0);
    }

    public fun is_name_taken(arg0: &CharacterNameRegistry, arg1: 0x1::string::String) {
        assert!(!0x2::table::contains<0x1::string::String, address>(&arg0.registry, to_lower_case(arg1)), 1);
    }

    fun to_lower_case(arg0: 0x1::string::String) : 0x1::string::String {
        let v0 = 0;
        let v1 = 0x1::ascii::into_bytes(0x1::string::to_ascii(arg0));
        while (v0 < 0x1::vector::length<u8>(&v1)) {
            let v2 = 0x1::vector::borrow_mut<u8>(&mut v1, v0);
            if (*v2 >= 65 && *v2 <= 90) {
                *v2 = *v2 + 32;
            };
            v0 = v0 + 1;
        };
        0x1::string::from_ascii(0x1::ascii::string(v1))
    }

    fun valid_classe(arg0: 0x1::string::String) : bool {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"sram"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"iop"));
        0x1::vector::contains<0x1::string::String>(&v0, &arg0)
    }

    fun valid_sex(arg0: 0x1::string::String) : bool {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"male"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"female"));
        0x1::vector::contains<0x1::string::String>(&v0, &arg0)
    }

    // decompiled from Move bytecode v6
}

