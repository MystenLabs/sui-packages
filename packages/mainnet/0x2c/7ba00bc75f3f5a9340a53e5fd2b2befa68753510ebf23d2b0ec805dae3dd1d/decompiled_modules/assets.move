module 0x2c7ba00bc75f3f5a9340a53e5fd2b2befa68753510ebf23d2b0ec805dae3dd1d::assets {
    struct ASSETS has drop {
        dummy_field: bool,
    }

    struct AssetsAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
    }

    struct CharacterDefinition has key {
        id: 0x2::object::UID,
        archetype_id: u64,
        name: 0x1::string::String,
        role: u8,
        manifest_digest: vector<u8>,
        manifest_uri: vector<u8>,
        license_tag: vector<u8>,
    }

    struct CosmeticDefinition has key {
        id: 0x2::object::UID,
        slot_kind: u8,
        name: 0x1::string::String,
        manifest_digest: vector<u8>,
        manifest_uri: vector<u8>,
    }

    struct Character has store, key {
        id: 0x2::object::UID,
        definition_id: 0x2::object::ID,
        archetype_id: u64,
        role: u8,
        name: 0x1::string::String,
        edition_serial: u64,
        mint_timestamp_ms: u64,
    }

    struct Cosmetic has store, key {
        id: 0x2::object::UID,
        definition_id: 0x2::object::ID,
        slot_kind: u8,
        name: 0x1::string::String,
        mint_timestamp_ms: u64,
    }

    struct CharacterDefinitionCreated has copy, drop {
        definition_id: 0x2::object::ID,
        archetype_id: u64,
        name: 0x1::string::String,
        role: u8,
    }

    struct CosmeticDefinitionCreated has copy, drop {
        definition_id: 0x2::object::ID,
        slot_kind: u8,
        name: 0x1::string::String,
    }

    struct CharacterMinted has copy, drop {
        character_id: 0x2::object::ID,
        definition_id: 0x2::object::ID,
        archetype_id: u64,
        edition_serial: u64,
    }

    struct CosmeticMinted has copy, drop {
        cosmetic_id: 0x2::object::ID,
        definition_id: 0x2::object::ID,
    }

    fun assert_bounded(arg0: u64, arg1: u64) {
        assert!(arg0 > 0 && arg0 <= arg1, 13906835660402655242);
    }

    public fun character_archetype_id(arg0: &Character) : u64 {
        arg0.archetype_id
    }

    public fun character_definition_id(arg0: &Character) : 0x2::object::ID {
        arg0.definition_id
    }

    fun character_display_fields() : (vector<0x1::string::String>, vector<0x1::string::String>) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"archetype_id"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"role"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"edition_serial"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name} #{edition_serial}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Blastoff launch character. Every character is an on-chain agent with its own battle record."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://blastoff.local/characters/{archetype_id}.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://blastoff.local"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Blastoff"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{archetype_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{role}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{edition_serial}"));
        (v0, v2)
    }

    public fun character_name(arg0: &Character) : 0x1::string::String {
        arg0.name
    }

    public fun character_role(arg0: &Character) : u8 {
        arg0.role
    }

    public fun character_serial(arg0: &Character) : u64 {
        arg0.edition_serial
    }

    public fun cosmetic_definition_id(arg0: &Cosmetic) : 0x2::object::ID {
        arg0.definition_id
    }

    public fun cosmetic_definition_slot_kind(arg0: &CosmeticDefinition) : u8 {
        arg0.slot_kind
    }

    fun cosmetic_display_fields() : (vector<0x1::string::String>, vector<0x1::string::String>) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"slot_kind"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Blastoff cosmetic."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://blastoff.local/cosmetics/{definition_id}.png"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://blastoff.local"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Blastoff"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{slot_kind}"));
        (v0, v2)
    }

    public fun cosmetic_slot_kind(arg0: &Cosmetic) : u8 {
        arg0.slot_kind
    }

    public fun create_character_definition(arg0: &AssetsAdminCap, arg1: u64, arg2: 0x1::string::String, arg3: u8, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_bounded(0x1::string::length(&arg2), 32);
        assert!(arg3 <= 5, 13906834921668542478);
        assert_bounded(0x1::vector::length<u8>(&arg4), 64);
        assert_bounded(0x1::vector::length<u8>(&arg5), 256);
        assert_bounded(0x1::vector::length<u8>(&arg6), 64);
        let v0 = CharacterDefinition{
            id              : 0x2::object::new(arg7),
            archetype_id    : arg1,
            name            : arg2,
            role            : arg3,
            manifest_digest : arg4,
            manifest_uri    : arg5,
            license_tag     : arg6,
        };
        let v1 = 0x2::object::id<CharacterDefinition>(&v0);
        let v2 = CharacterDefinitionCreated{
            definition_id : v1,
            archetype_id  : arg1,
            name          : arg2,
            role          : arg3,
        };
        0x2::event::emit<CharacterDefinitionCreated>(v2);
        0x2::transfer::freeze_object<CharacterDefinition>(v0);
        v1
    }

    public fun create_cosmetic_definition(arg0: &AssetsAdminCap, arg1: u8, arg2: 0x1::string::String, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg1 <= 2, 13906835063402332172);
        assert_bounded(0x1::string::length(&arg2), 32);
        assert_bounded(0x1::vector::length<u8>(&arg3), 64);
        assert_bounded(0x1::vector::length<u8>(&arg4), 256);
        let v0 = CosmeticDefinition{
            id              : 0x2::object::new(arg5),
            slot_kind       : arg1,
            name            : arg2,
            manifest_digest : arg3,
            manifest_uri    : arg4,
        };
        let v1 = 0x2::object::id<CosmeticDefinition>(&v0);
        let v2 = CosmeticDefinitionCreated{
            definition_id : v1,
            slot_kind     : arg1,
            name          : arg2,
        };
        0x2::event::emit<CosmeticDefinitionCreated>(v2);
        0x2::transfer::freeze_object<CosmeticDefinition>(v0);
        v1
    }

    public fun create_displays(arg0: &mut 0x2::display_registry::DisplayRegistry, arg1: &mut 0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) : (0x2::display_registry::DisplayCap<Character>, 0x2::display_registry::DisplayCap<Cosmetic>) {
        let (v0, v1) = 0x2::display_registry::new_with_publisher<Character>(arg0, arg1, arg2);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = character_display_fields();
        let v6 = v4;
        let v7 = v5;
        0x1::vector::reverse<0x1::string::String>(&mut v7);
        assert!(0x1::vector::length<0x1::string::String>(&v6) == 0x1::vector::length<0x1::string::String>(&v7), 13906835235200303103);
        0x1::vector::reverse<0x1::string::String>(&mut v6);
        let v8 = 0;
        while (v8 < 0x1::vector::length<0x1::string::String>(&v6)) {
            0x2::display_registry::set<Character>(&mut v3, &v2, 0x1::vector::pop_back<0x1::string::String>(&mut v6), 0x1::vector::pop_back<0x1::string::String>(&mut v7));
            v8 = v8 + 1;
        };
        0x1::vector::destroy_empty<0x1::string::String>(v6);
        0x1::vector::destroy_empty<0x1::string::String>(v7);
        0x2::display_registry::share<Character>(v3);
        let (v9, v10) = 0x2::display_registry::new_with_publisher<Cosmetic>(arg0, arg1, arg2);
        let v11 = v10;
        let v12 = v9;
        let (v13, v14) = cosmetic_display_fields();
        let v15 = v13;
        let v16 = v14;
        0x1::vector::reverse<0x1::string::String>(&mut v16);
        assert!(0x1::vector::length<0x1::string::String>(&v15) == 0x1::vector::length<0x1::string::String>(&v16), 13906835273855008767);
        0x1::vector::reverse<0x1::string::String>(&mut v15);
        let v17 = 0;
        while (v17 < 0x1::vector::length<0x1::string::String>(&v15)) {
            0x2::display_registry::set<Cosmetic>(&mut v12, &v11, 0x1::vector::pop_back<0x1::string::String>(&mut v15), 0x1::vector::pop_back<0x1::string::String>(&mut v16));
            v17 = v17 + 1;
        };
        0x1::vector::destroy_empty<0x1::string::String>(v15);
        0x1::vector::destroy_empty<0x1::string::String>(v16);
        0x2::display_registry::share<Cosmetic>(v12);
        (v2, v11)
    }

    public fun definition_archetype_id(arg0: &CharacterDefinition) : u64 {
        arg0.archetype_id
    }

    public fun definition_name(arg0: &CharacterDefinition) : 0x1::string::String {
        arg0.name
    }

    public fun definition_role(arg0: &CharacterDefinition) : u8 {
        arg0.role
    }

    fun init(arg0: ASSETS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<ASSETS>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = AssetsAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AssetsAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun issue_mint_cap(arg0: &AssetsAdminCap, arg1: &mut 0x2::tx_context::TxContext) : MintCap {
        MintCap{id: 0x2::object::new(arg1)}
    }

    public fun mint_character(arg0: &MintCap, arg1: &CharacterDefinition, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : Character {
        assert!(arg2 > 0, 13906835342575468560);
        let v0 = Character{
            id                : 0x2::object::new(arg4),
            definition_id     : 0x2::object::id<CharacterDefinition>(arg1),
            archetype_id      : arg1.archetype_id,
            role              : arg1.role,
            name              : arg1.name,
            edition_serial    : arg2,
            mint_timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        let v1 = CharacterMinted{
            character_id   : 0x2::object::id<Character>(&v0),
            definition_id  : v0.definition_id,
            archetype_id   : v0.archetype_id,
            edition_serial : arg2,
        };
        0x2::event::emit<CharacterMinted>(v1);
        v0
    }

    public fun mint_cosmetic(arg0: &MintCap, arg1: &CosmeticDefinition, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : Cosmetic {
        let v0 = Cosmetic{
            id                : 0x2::object::new(arg3),
            definition_id     : 0x2::object::id<CosmeticDefinition>(arg1),
            slot_kind         : arg1.slot_kind,
            name              : arg1.name,
            mint_timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        let v1 = CosmeticMinted{
            cosmetic_id   : 0x2::object::id<Cosmetic>(&v0),
            definition_id : v0.definition_id,
        };
        0x2::event::emit<CosmeticMinted>(v1);
        v0
    }

    // decompiled from Move bytecode v7
}

