module 0x6d0cf81a214839cb1e0c4d2f52d20b371c2e722a17846a919e743174ce6bbcf5::hero {
    struct Hero has store, key {
        id: 0x2::object::UID,
        hp: u64,
        experience: u64,
        sword: 0x1::option::Option<Sword>,
        game_id: 0x2::object::ID,
    }

    struct Sword has store, key {
        id: 0x2::object::UID,
        magic: u64,
        strength: u64,
        game_id: 0x2::object::ID,
    }

    struct Potion has store, key {
        id: 0x2::object::UID,
        potency: u64,
        game_id: 0x2::object::ID,
    }

    struct Boar has key {
        id: 0x2::object::UID,
        hp: u64,
        strength: u64,
        game_id: 0x2::object::ID,
    }

    struct GameInfo has key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct GameAdmin has key {
        id: 0x2::object::UID,
        boars_created: u64,
        potions_created: u64,
        game_id: 0x2::object::ID,
    }

    struct BoarSlainEvent has copy, drop {
        slayer_address: address,
        hero: 0x2::object::ID,
        boar: 0x2::object::ID,
        game_id: 0x2::object::ID,
    }

    public fun id(arg0: &GameInfo) : 0x2::object::ID {
        0x2::object::id<GameInfo>(arg0)
    }

    public entry fun acquire_hero(arg0: &GameInfo, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = create_sword(arg0, arg1, arg2);
        let v1 = create_hero(arg0, v0, arg2);
        0x2::transfer::public_transfer<Hero>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun assert_hero_strength(arg0: &Hero, arg1: u64) {
        assert!(hero_strength(arg0) == arg1, 5);
    }

    public fun check_id(arg0: &GameInfo, arg1: 0x2::object::ID) {
        assert!(id(arg0) == arg1, 403);
    }

    fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::object::new(arg0);
        let v2 = GameInfo{
            id    : v1,
            admin : v0,
        };
        0x2::transfer::freeze_object<GameInfo>(v2);
        let v3 = GameAdmin{
            id              : 0x2::object::new(arg0),
            boars_created   : 0,
            potions_created : 0,
            game_id         : 0x2::object::uid_to_inner(&v1),
        };
        0x2::transfer::transfer<GameAdmin>(v3, v0);
    }

    public fun create_hero(arg0: &GameInfo, arg1: Sword, arg2: &mut 0x2::tx_context::TxContext) : Hero {
        check_id(arg0, arg1.game_id);
        Hero{
            id         : 0x2::object::new(arg2),
            hp         : 100,
            experience : 0,
            sword      : 0x1::option::some<Sword>(arg1),
            game_id    : id(arg0),
        }
    }

    public fun create_sword(arg0: &GameInfo, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : Sword {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= 100, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.admin);
        Sword{
            id       : 0x2::object::new(arg2),
            magic    : 0x2::math::min((v0 - 100) / 100, 10),
            strength : 1,
            game_id  : id(arg0),
        }
    }

    public fun equip_sword(arg0: &mut Hero, arg1: Sword) : 0x1::option::Option<Sword> {
        0x1::option::swap_or_fill<Sword>(&mut arg0.sword, arg1)
    }

    public fun heal(arg0: &mut Hero, arg1: Potion) {
        assert!(arg0.game_id == arg1.game_id, 403);
        let Potion {
            id      : v0,
            potency : v1,
            game_id : _,
        } = arg1;
        0x2::object::delete(v0);
        arg0.hp = 0x2::math::min(arg0.hp + v1, 1000);
    }

    public fun hero_strength(arg0: &Hero) : u64 {
        if (arg0.hp == 0) {
            return 0
        };
        let v0 = if (0x1::option::is_some<Sword>(&arg0.sword)) {
            sword_strength(0x1::option::borrow<Sword>(&arg0.sword))
        } else {
            0
        };
        arg0.experience * arg0.hp + v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        create(arg0);
    }

    fun level_up_sword(arg0: &mut Sword, arg1: u64) {
        arg0.strength = arg0.strength + arg1;
    }

    public entry fun new_game(arg0: &mut 0x2::tx_context::TxContext) {
        create(arg0);
    }

    public fun remove_sword(arg0: &mut Hero) : Sword {
        assert!(0x1::option::is_some<Sword>(&arg0.sword), 4);
        0x1::option::extract<Sword>(&mut arg0.sword)
    }

    public entry fun send_boar(arg0: &GameInfo, arg1: &mut GameAdmin, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        check_id(arg0, arg1.game_id);
        arg1.boars_created = arg1.boars_created + 1;
        let v0 = Boar{
            id       : 0x2::object::new(arg5),
            hp       : arg2,
            strength : arg3,
            game_id  : id(arg0),
        };
        0x2::transfer::transfer<Boar>(v0, arg4);
    }

    public entry fun send_potion(arg0: &GameInfo, arg1: u64, arg2: address, arg3: &mut GameAdmin, arg4: &mut 0x2::tx_context::TxContext) {
        check_id(arg0, arg3.game_id);
        arg3.potions_created = arg3.potions_created + 1;
        let v0 = Potion{
            id      : 0x2::object::new(arg4),
            potency : arg1,
            game_id : id(arg0),
        };
        0x2::transfer::public_transfer<Potion>(v0, arg2);
    }

    public entry fun slay(arg0: &GameInfo, arg1: &mut Hero, arg2: Boar, arg3: &0x2::tx_context::TxContext) {
        check_id(arg0, arg1.game_id);
        check_id(arg0, arg2.game_id);
        let Boar {
            id       : v0,
            hp       : v1,
            strength : v2,
            game_id  : _,
        } = arg2;
        let v4 = v0;
        let v5 = hero_strength(arg1);
        let v6 = v1;
        let v7 = arg1.hp;
        while (v6 > v5) {
            v6 = v6 - v5;
            assert!(v7 >= v2, 0);
            v7 = v7 - v2;
        };
        arg1.hp = v7;
        arg1.experience = arg1.experience + v1;
        if (0x1::option::is_some<Sword>(&arg1.sword)) {
            let v8 = 0x1::option::borrow_mut<Sword>(&mut arg1.sword);
            level_up_sword(v8, 1);
        };
        let v9 = BoarSlainEvent{
            slayer_address : 0x2::tx_context::sender(arg3),
            hero           : 0x2::object::uid_to_inner(&arg1.id),
            boar           : 0x2::object::uid_to_inner(&v4),
            game_id        : id(arg0),
        };
        0x2::event::emit<BoarSlainEvent>(v9);
        0x2::object::delete(v4);
    }

    public fun sword_strength(arg0: &Sword) : u64 {
        arg0.magic + arg0.strength
    }

    // decompiled from Move bytecode v6
}

