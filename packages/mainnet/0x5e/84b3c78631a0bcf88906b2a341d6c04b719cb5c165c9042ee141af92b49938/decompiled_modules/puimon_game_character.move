module 0x5e84b3c78631a0bcf88906b2a341d6c04b719cb5c165c9042ee141af92b49938::puimon_game_character {
    struct GameAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Character has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        hp: u64,
        max_hp: u64,
        attack: u64,
        level: u16,
        exp: u64,
        items_equipped: u16,
        ap: u64,
        max_ap: u64,
    }

    struct CreateCharacterEvent has copy, drop {
        character_id: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
    }

    public fun ap(arg0: &Character) : u64 {
        arg0.ap
    }

    public fun attack(arg0: &Character) : u64 {
        arg0.attack
    }

    public fun create_character(arg0: &GameAdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : Character {
        let v0 = Character{
            id             : 0x2::object::new(arg3),
            name           : arg1,
            image_url      : arg2,
            hp             : 100,
            max_hp         : 100,
            attack         : 10,
            level          : 1,
            exp            : 0,
            items_equipped : 0,
            ap             : 100,
            max_ap         : 100,
        };
        let v1 = CreateCharacterEvent{
            character_id : 0x2::object::uid_to_inner(&v0.id),
            owner        : 0x2::tx_context::sender(arg3),
            name         : v0.name,
        };
        0x2::event::emit<CreateCharacterEvent>(v1);
        v0
    }

    public fun equipped(arg0: &Character) : u16 {
        arg0.items_equipped
    }

    public fun exp(arg0: &Character) : u64 {
        arg0.exp
    }

    public fun hp(arg0: &Character) : u64 {
        arg0.hp
    }

    public fun image(arg0: &Character) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<GameAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun level(arg0: &Character) : u16 {
        arg0.level
    }

    public fun max_ap(arg0: &Character) : u64 {
        arg0.max_ap
    }

    public fun max_hp(arg0: &Character) : u64 {
        arg0.max_hp
    }

    public fun name(arg0: &Character) : 0x1::string::String {
        arg0.name
    }

    public fun set_ap(arg0: &GameAdminCap, arg1: &mut Character, arg2: u64) {
        arg1.ap = arg2;
    }

    public fun set_attack(arg0: &GameAdminCap, arg1: &mut Character, arg2: u64) {
        arg1.attack = arg2;
    }

    public fun set_equipped(arg0: &GameAdminCap, arg1: &mut Character, arg2: u16) {
        arg1.items_equipped = arg2;
    }

    public fun set_exp(arg0: &GameAdminCap, arg1: &mut Character, arg2: u64) {
        arg1.exp = arg2;
    }

    public fun set_hp(arg0: &GameAdminCap, arg1: &mut Character, arg2: u64) {
        arg1.hp = arg2;
    }

    public fun set_level(arg0: &GameAdminCap, arg1: &mut Character, arg2: u16) {
        arg1.level = arg2;
    }

    public fun set_max_ap(arg0: &GameAdminCap, arg1: &mut Character, arg2: u64) {
        arg1.max_ap = arg2;
    }

    public fun set_max_hp(arg0: &GameAdminCap, arg1: &mut Character, arg2: u64) {
        arg1.max_hp = arg2;
    }

    public fun update_image(arg0: &GameAdminCap, arg1: &mut Character, arg2: 0x1::string::String) {
        arg1.image_url = arg2;
    }

    public fun update_name(arg0: &GameAdminCap, arg1: &mut Character, arg2: 0x1::string::String) {
        arg1.name = arg2;
    }

    // decompiled from Move bytecode v6
}

