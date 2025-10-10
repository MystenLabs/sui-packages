module 0x617c95c234438554e33d4904352e29fd5811813a23ec890794d8b865570b0f0c::hero {
    struct Hero has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        stamina: u64,
        weapon: 0x1::option::Option<Weapon>,
    }

    struct Weapon has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        attack: u64,
    }

    struct HeroRegistry has key {
        id: 0x2::object::UID,
        ids: vector<0x2::object::ID>,
        counter: u64,
    }

    public fun equip_weapon(arg0: &mut Hero, arg1: Weapon) {
        assert!(0x1::option::is_none<Weapon>(&arg0.weapon), 1);
        0x1::option::fill<Weapon>(&mut arg0.weapon, arg1);
    }

    public fun hero_name(arg0: &Hero) : 0x1::string::String {
        arg0.name
    }

    public fun hero_registry_counter(arg0: &HeroRegistry) : u64 {
        arg0.counter
    }

    public fun hero_registry_ids(arg0: &HeroRegistry) : vector<0x2::object::ID> {
        arg0.ids
    }

    public fun hero_stamina(arg0: &Hero) : u64 {
        arg0.stamina
    }

    public fun hero_weapon(arg0: &Hero) : &0x1::option::Option<Weapon> {
        &arg0.weapon
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HeroRegistry{
            id      : 0x2::object::new(arg0),
            ids     : 0x1::vector::empty<0x2::object::ID>(),
            counter : 0,
        };
        0x2::transfer::share_object<HeroRegistry>(v0);
    }

    public fun new_hero(arg0: 0x1::string::String, arg1: u64, arg2: &mut HeroRegistry, arg3: &mut 0x2::tx_context::TxContext) : Hero {
        let v0 = Hero{
            id      : 0x2::object::new(arg3),
            name    : arg0,
            stamina : arg1,
            weapon  : 0x1::option::none<Weapon>(),
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg2.ids, 0x2::object::id<Hero>(&v0));
        arg2.counter = arg2.counter + 1;
        v0
    }

    public fun new_weapon(arg0: 0x1::string::String, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Weapon {
        Weapon{
            id     : 0x2::object::new(arg2),
            name   : arg0,
            attack : arg1,
        }
    }

    public fun unequip_weapon(arg0: &mut Hero) : Weapon {
        assert!(0x1::option::is_some<Weapon>(&arg0.weapon), 2);
        0x1::option::extract<Weapon>(&mut arg0.weapon)
    }

    public fun weapon_attack(arg0: &Weapon) : u64 {
        arg0.attack
    }

    public fun weapon_name(arg0: &Weapon) : 0x1::string::String {
        arg0.name
    }

    // decompiled from Move bytecode v6
}

