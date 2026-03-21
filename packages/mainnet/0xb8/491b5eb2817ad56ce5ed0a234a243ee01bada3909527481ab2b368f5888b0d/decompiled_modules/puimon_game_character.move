module 0xb8491b5eb2817ad56ce5ed0a234a243ee01bada3909527481ab2b368f5888b0d::puimon_game_character {
    struct GameAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CharacterPass has store, key {
        id: 0x2::object::UID,
        stats_id: 0x2::object::ID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct CharacterStats has key {
        id: 0x2::object::UID,
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
        pass_id: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
    }

    public fun ap(arg0: &CharacterStats) : u64 {
        arg0.ap
    }

    public fun attack(arg0: &CharacterStats) : u64 {
        arg0.attack
    }

    public fun equipped(arg0: &CharacterStats) : u16 {
        arg0.items_equipped
    }

    public fun exp(arg0: &CharacterStats) : u64 {
        arg0.exp
    }

    public fun hp(arg0: &CharacterStats) : u64 {
        arg0.hp
    }

    public fun image(arg0: &CharacterPass) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<GameAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun internal_mint_and_register(arg0: &GameAdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: u16, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : CharacterPass {
        let v0 = 0x2::object::new(arg9);
        let v1 = CharacterStats{
            id             : 0x2::object::new(arg9),
            hp             : arg3,
            max_hp         : arg4,
            attack         : arg5,
            level          : arg6,
            exp            : 0,
            items_equipped : 0,
            ap             : arg7,
            max_ap         : arg8,
        };
        let v2 = CharacterPass{
            id        : v0,
            stats_id  : 0x2::object::id<CharacterStats>(&v1),
            name      : arg1,
            image_url : arg2,
        };
        0x2::transfer::share_object<CharacterStats>(v1);
        let v3 = CreateCharacterEvent{
            pass_id : 0x2::object::uid_to_inner(&v0),
            owner   : 0x2::tx_context::sender(arg9),
            name    : v2.name,
        };
        0x2::event::emit<CreateCharacterEvent>(v3);
        v2
    }

    public fun level(arg0: &CharacterStats) : u16 {
        arg0.level
    }

    public fun max_ap(arg0: &CharacterStats) : u64 {
        arg0.max_ap
    }

    public fun max_hp(arg0: &CharacterStats) : u64 {
        arg0.max_hp
    }

    public fun name(arg0: &CharacterPass) : 0x1::string::String {
        arg0.name
    }

    public fun set_ap(arg0: &GameAdminCap, arg1: &mut CharacterStats, arg2: u64) {
        arg1.ap = arg2;
    }

    public fun set_attack(arg0: &GameAdminCap, arg1: &mut CharacterStats, arg2: u64) {
        arg1.attack = arg2;
    }

    public fun set_equipped(arg0: &GameAdminCap, arg1: &mut CharacterStats, arg2: u16) {
        arg1.items_equipped = arg2;
    }

    public fun set_exp(arg0: &GameAdminCap, arg1: &mut CharacterStats, arg2: u64) {
        arg1.exp = arg2;
    }

    public fun set_hp(arg0: &GameAdminCap, arg1: &mut CharacterStats, arg2: u64) {
        arg1.hp = arg2;
    }

    public fun set_level(arg0: &GameAdminCap, arg1: &mut CharacterStats, arg2: u16) {
        arg1.level = arg2;
    }

    public fun set_max_ap(arg0: &GameAdminCap, arg1: &mut CharacterStats, arg2: u64) {
        arg1.max_ap = arg2;
    }

    public fun set_max_hp(arg0: &GameAdminCap, arg1: &mut CharacterStats, arg2: u64) {
        arg1.max_hp = arg2;
    }

    public fun stats_id(arg0: &CharacterPass) : 0x2::object::ID {
        arg0.stats_id
    }

    public fun update_image(arg0: &GameAdminCap, arg1: &mut CharacterPass, arg2: 0x1::string::String) {
        arg1.image_url = arg2;
    }

    public fun update_name(arg0: &GameAdminCap, arg1: &mut CharacterPass, arg2: 0x1::string::String) {
        arg1.name = arg2;
    }

    // decompiled from Move bytecode v6
}

