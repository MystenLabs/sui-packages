module 0xc1867432a58d8a0c927138c17d129349bb06d65ee13c376187bd1d90d090a39::abilities_events_params {
    struct Hero has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        medals: vector<Medal>,
    }

    struct HeroRegistry has store, key {
        id: 0x2::object::UID,
        heroes: vector<0x2::object::ID>,
    }

    struct MedalStorage has store, key {
        id: 0x2::object::UID,
        medals: vector<Medal>,
    }

    struct HeroMinted has copy, drop {
        hero: 0x2::object::ID,
        owner: address,
    }

    struct Medal has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    fun award_medal(arg0: &mut Hero, arg1: &mut MedalStorage, arg2: 0x1::string::String) {
        let v0 = get_medal(arg2, arg1);
        assert!(0x1::option::is_some<Medal>(&v0), 111);
        0x1::vector::append<Medal>(&mut arg0.medals, 0x1::option::to_vec<Medal>(v0));
    }

    public fun award_medal_of_cross(arg0: &mut Hero, arg1: &mut MedalStorage) {
        award_medal(arg0, arg1, 0x1::string::utf8(b"Air Force Cross"));
    }

    public fun award_medal_of_honor(arg0: &mut Hero, arg1: &mut MedalStorage) {
        award_medal(arg0, arg1, 0x1::string::utf8(b"Medal of Honor"));
    }

    public fun award_medal_of_merit(arg0: &mut Hero, arg1: &mut MedalStorage) {
        award_medal(arg0, arg1, 0x1::string::utf8(b"Legion of Merit"));
    }

    fun get_medal(arg0: 0x1::string::String, arg1: &mut MedalStorage) : 0x1::option::Option<Medal> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Medal>(&arg1.medals)) {
            if (0x1::vector::borrow<Medal>(&arg1.medals, v0).name == arg0) {
                return 0x1::option::some<Medal>(0x1::vector::remove<Medal>(&mut arg1.medals, v0))
            };
            v0 = v0 + 1;
        };
        0x1::option::none<Medal>()
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HeroRegistry{
            id     : 0x2::object::new(arg0),
            heroes : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<HeroRegistry>(v0);
        let v1 = MedalStorage{
            id     : 0x2::object::new(arg0),
            medals : 0x1::vector::empty<Medal>(),
        };
        let v2 = Medal{
            id   : 0x2::object::new(arg0),
            name : 0x1::string::utf8(b"Medal of Honor"),
        };
        0x1::vector::push_back<Medal>(&mut v1.medals, v2);
        let v3 = Medal{
            id   : 0x2::object::new(arg0),
            name : 0x1::string::utf8(b"Air Force Cross"),
        };
        0x1::vector::push_back<Medal>(&mut v1.medals, v3);
        let v4 = Medal{
            id   : 0x2::object::new(arg0),
            name : 0x1::string::utf8(b"Legion of Merit"),
        };
        0x1::vector::push_back<Medal>(&mut v1.medals, v4);
        0x2::transfer::share_object<MedalStorage>(v1);
    }

    public fun mint_and_keep_hero(arg0: 0x1::string::String, arg1: &mut HeroRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_hero(arg0, arg1, arg2);
        0x2::transfer::transfer<Hero>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun mint_hero(arg0: 0x1::string::String, arg1: &mut HeroRegistry, arg2: &mut 0x2::tx_context::TxContext) : Hero {
        let v0 = Hero{
            id     : 0x2::object::new(arg2),
            name   : arg0,
            medals : 0x1::vector::empty<Medal>(),
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.heroes, 0x2::object::id<Hero>(&v0));
        let v1 = HeroMinted{
            hero  : 0x2::object::id<Hero>(&v0),
            owner : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<HeroMinted>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

