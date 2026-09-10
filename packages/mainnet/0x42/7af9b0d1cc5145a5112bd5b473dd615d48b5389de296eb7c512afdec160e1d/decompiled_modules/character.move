module 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character {
    struct Character has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        classe: 0x1::string::String,
        sex: 0x1::string::String,
        experience: u64,
        level: u16,
        color_1: u32,
        color_2: u32,
        color_3: u32,
        vitality: u16,
        wisdom: u16,
        strength: u16,
        intelligence: u16,
        chance: u16,
        agility: u16,
        available_points: u16,
        available_spell_points: u16,
    }

    struct NameRegistry has key {
        id: 0x2::object::UID,
    }

    struct CHARACTER has drop {
        dummy_field: bool,
    }

    struct CharacterCreated has copy, drop {
        character: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
        classe: 0x1::string::String,
    }

    public(friend) fun add_experience(arg0: &mut Character, arg1: u64) {
        arg0.experience = arg0.experience + arg1;
        let v0 = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::experience::level_from_xp(arg0.experience);
        if (v0 > arg0.level) {
            arg0.available_points = arg0.available_points + (v0 - arg0.level) * 5;
            arg0.available_spell_points = arg0.available_spell_points + v0 - arg0.level;
            arg0.level = v0;
        };
    }

    public fun agility(arg0: &Character) : u16 {
        arg0.agility
    }

    public(friend) fun assert_personal_custody(arg0: &0x2::kiosk::Kiosk) {
        assert!(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::is_personal(arg0), 108);
    }

    fun assert_valid_class(arg0: 0x1::string::String) {
        assert!(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::content_rules::is_classe(&arg0), 103);
    }

    public fun available_points(arg0: &Character) : u16 {
        arg0.available_points
    }

    public fun available_spell_points(arg0: &Character) : u16 {
        arg0.available_spell_points
    }

    public fun chance(arg0: &Character) : u16 {
        arg0.chance
    }

    public fun classe(arg0: &Character) : 0x1::string::String {
        arg0.classe
    }

    public(friend) fun create_character(arg0: &mut NameRegistry, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: bool, arg5: u32, arg6: u32, arg7: u32, arg8: &0x2::tx_context::TxContext) : Character {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == 1000000000, 105);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, @0x37cf46b499f740e653644bd2f7a8ed97f248e8b3c69d5d12c97d7845a54c0cd8);
        assert_valid_class(arg3);
        assert!(arg5 >= 0 && arg5 <= 16777215, 104);
        assert!(arg6 >= 0 && arg6 <= 16777215, 104);
        assert!(arg7 >= 0 && arg7 <= 16777215, 104);
        let v0 = 0x1::string::to_ascii(arg2);
        let v1 = 0x1::string::from_ascii(0x1::ascii::to_lowercase(&v0));
        assert!(0x1::string::length(&v1) > 3 && 0x1::string::length(&v1) < 20, 102);
        assert!(0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::content_rules::is_printable_ascii(&v1), 102);
        let v2 = if (arg4) {
            0x1::string::utf8(b"male")
        } else {
            0x1::string::utf8(b"female")
        };
        let v3 = Character{
            id                     : 0x2::derived_object::claim<0x1::string::String>(&mut arg0.id, v1),
            name                   : v1,
            classe                 : arg3,
            sex                    : v2,
            experience             : 0,
            level                  : 1,
            color_1                : arg5,
            color_2                : arg6,
            color_3                : arg7,
            vitality               : 0,
            wisdom                 : 0,
            strength               : 0,
            intelligence           : 0,
            chance                 : 0,
            agility                : 0,
            available_points       : 0,
            available_spell_points : 0,
        };
        let v4 = CharacterCreated{
            character : 0x2::object::uid_to_inner(&v3.id),
            owner     : 0x2::tx_context::sender(arg8),
            name      : v3.name,
            classe    : v3.classe,
        };
        0x2::event::emit<CharacterCreated>(v4);
        v3
    }

    public(friend) fun destroy(arg0: Character) {
        let Character {
            id                     : v0,
            name                   : _,
            classe                 : _,
            sex                    : _,
            experience             : _,
            level                  : _,
            color_1                : _,
            color_2                : _,
            color_3                : _,
            vitality               : _,
            wisdom                 : _,
            strength               : _,
            intelligence           : _,
            chance                 : _,
            agility                : _,
            available_points       : _,
            available_spell_points : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun id(arg0: &Character) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: CHARACTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = NameRegistry{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<NameRegistry>(v0);
    }

    public fun intelligence(arg0: &Character) : u16 {
        arg0.intelligence
    }

    public(friend) fun level(arg0: &Character) : u16 {
        arg0.level
    }

    public fun name(arg0: &Character) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun raise_stat(arg0: &mut Character, arg1: 0x1::string::String, arg2: u16) {
        assert!(arg2 > 0, 109);
        assert!(arg2 <= arg0.available_points, 106);
        let v0 = if (arg1 == 0x1::string::utf8(b"vitality")) {
            arg0.vitality
        } else if (arg1 == 0x1::string::utf8(b"wisdom")) {
            arg0.wisdom
        } else if (arg1 == 0x1::string::utf8(b"strength")) {
            arg0.strength
        } else if (arg1 == 0x1::string::utf8(b"intelligence")) {
            arg0.intelligence
        } else if (arg1 == 0x1::string::utf8(b"chance")) {
            arg0.chance
        } else {
            assert!(arg1 == 0x1::string::utf8(b"agility"), 107);
            arg0.agility
        };
        let (v1, v2) = 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::characteristic_costs::gain_for_points(&arg0.classe, &arg1, v0, arg2);
        assert!(v1 == (arg2 as u32), 109);
        arg0.available_points = arg0.available_points - arg2;
        if (arg1 == 0x1::string::utf8(b"vitality")) {
            arg0.vitality = arg0.vitality + (v2 as u16);
        } else if (arg1 == 0x1::string::utf8(b"wisdom")) {
            arg0.wisdom = arg0.wisdom + (v2 as u16);
        } else if (arg1 == 0x1::string::utf8(b"strength")) {
            arg0.strength = arg0.strength + (v2 as u16);
        } else if (arg1 == 0x1::string::utf8(b"intelligence")) {
            arg0.intelligence = arg0.intelligence + (v2 as u16);
        } else if (arg1 == 0x1::string::utf8(b"chance")) {
            arg0.chance = arg0.chance + (v2 as u16);
        } else {
            arg0.agility = arg0.agility + (v2 as u16);
        };
    }

    public(friend) fun reset_spell_points(arg0: &mut Character) {
        arg0.available_spell_points = arg0.level - 1;
    }

    public(friend) fun reset_stats(arg0: &mut Character) {
        arg0.available_points = (arg0.level - 1) * 5;
        arg0.vitality = 0;
        arg0.wisdom = 0;
        arg0.strength = 0;
        arg0.intelligence = 0;
        arg0.chance = 0;
        arg0.agility = 0;
    }

    public(friend) fun spend_spell_points(arg0: &mut Character, arg1: u16) {
        arg0.available_spell_points = arg0.available_spell_points - arg1;
    }

    public fun strength(arg0: &Character) : u16 {
        arg0.strength
    }

    public(friend) fun uid(arg0: &Character) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut Character) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun vitality(arg0: &Character) : u16 {
        arg0.vitality
    }

    public fun wisdom(arg0: &Character) : u16 {
        arg0.wisdom
    }

    // decompiled from Move bytecode v7
}

