module 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::dragon_egg {
    struct DRAGON_EGG has drop {
        dummy_field: bool,
    }

    struct DragonEggFire has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        power: u64,
    }

    struct DragonEggIce has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        power: u64,
    }

    struct DragonEggGlobal has key {
        id: 0x2::object::UID,
        balance_SHUI: 0x2::balance::Balance<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>,
        creator: address,
        egg_ice_bought_num: u64,
        egg_fire_bought_num: u64,
        bought_list: 0x2::table::Table<address, bool>,
        version: u64,
    }

    public entry fun buy_dragon_egg_fire(arg0: &mut DragonEggGlobal, arg1: vector<0x2::coin::Coin<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 10000;
        let v2 = 0x1::vector::pop_back<0x2::coin::Coin<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>>(&mut arg1);
        assert!(!0x2::table::contains<address, bool>(&arg0.bought_list, v0), 5);
        0x2::pay::join_vec<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>(&mut v2, arg1);
        assert!(0x2::coin::value<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>(&v2) >= v1 * 1000000000, 4);
        0x2::balance::join<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>(&mut arg0.balance_SHUI, 0x2::coin::into_balance<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>(0x2::coin::split<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>(&mut v2, v1 * 1000000000, arg2)));
        if (0x2::coin::value<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>>(v2, v0);
        } else {
            0x2::coin::destroy_zero<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>(v2);
        };
        let v3 = DragonEggFire{
            id    : 0x2::object::new(arg2),
            name  : 0x1::string::utf8(b"Dragon Egg Fire"),
            power : 0,
        };
        arg0.egg_fire_bought_num = arg0.egg_fire_bought_num + 1;
        0x2::table::add<address, bool>(&mut arg0.bought_list, v0, true);
        0x2::transfer::transfer<DragonEggFire>(v3, 0x2::tx_context::sender(arg2));
    }

    public entry fun buy_dragon_egg_ice(arg0: &mut DragonEggGlobal, arg1: vector<0x2::coin::Coin<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 10000;
        let v2 = 0x1::vector::pop_back<0x2::coin::Coin<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>>(&mut arg1);
        assert!(!0x2::table::contains<address, bool>(&arg0.bought_list, v0), 5);
        0x2::pay::join_vec<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>(&mut v2, arg1);
        assert!(0x2::coin::value<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>(&v2) >= v1 * 1000000000, 4);
        0x2::balance::join<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>(&mut arg0.balance_SHUI, 0x2::coin::into_balance<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>(0x2::coin::split<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>(&mut v2, v1 * 1000000000, arg2)));
        if (0x2::coin::value<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>>(v2, v0);
        } else {
            0x2::coin::destroy_zero<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>(v2);
        };
        let v3 = DragonEggIce{
            id    : 0x2::object::new(arg2),
            name  : 0x1::string::utf8(b"Dragon Egg Ice"),
            power : 0,
        };
        arg0.egg_ice_bought_num = arg0.egg_ice_bought_num + 1;
        0x2::table::add<address, bool>(&mut arg0.bought_list, v0, true);
        0x2::transfer::transfer<DragonEggIce>(v3, 0x2::tx_context::sender(arg2));
    }

    public fun change_owner(arg0: &mut DragonEggGlobal, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        arg0.creator = arg1;
    }

    public entry fun get_left_egg_num(arg0: &DragonEggGlobal) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        let v1 = *0x1::string::bytes(&v0);
        0x1::vector::append<u8>(&mut v1, 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::utils::numbers_to_ascii_vector((arg0.egg_fire_bought_num as u16)));
        0x1::vector::push_back<u8>(&mut v1, 0x1::ascii::byte(0x1::ascii::char(44)));
        0x1::vector::append<u8>(&mut v1, 0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::utils::numbers_to_ascii_vector((arg0.egg_ice_bought_num as u16)));
        0x1::string::utf8(v1)
    }

    public fun increment(arg0: &mut DragonEggGlobal, arg1: u64) {
        assert!(arg0.version == 0, 2);
        arg0.version = arg1;
    }

    fun init(arg0: DRAGON_EGG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"metagame dragon egg series"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://shui.game"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://bafybeifgrwsodbehvvahrqvtql3d7ta6ztjovjfmsbk7wslyswsymrnpzi.ipfs.nftstorage.link/dragoneggice.jpg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://shui.game/game/#/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"metaGame"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"metagame dragon egg series"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://shui.game"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://bafybeifgrwsodbehvvahrqvtql3d7ta6ztjovjfmsbk7wslyswsymrnpzi.ipfs.nftstorage.link/dragoneggfire.jpg"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://shui.game/game/#/"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"metaGame"));
        let v6 = 0x2::package::claim<DRAGON_EGG>(arg0, arg1);
        let v7 = 0x2::display::new_with_fields<DragonEggFire>(&v6, v0, v4, arg1);
        let v8 = 0x2::display::new_with_fields<DragonEggIce>(&v6, v0, v2, arg1);
        0x2::display::update_version<DragonEggFire>(&mut v7);
        0x2::transfer::public_transfer<0x2::display::Display<DragonEggFire>>(v7, 0x2::tx_context::sender(arg1));
        0x2::display::update_version<DragonEggIce>(&mut v8);
        0x2::transfer::public_transfer<0x2::display::Display<DragonEggIce>>(v8, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v6, 0x2::tx_context::sender(arg1));
        let v9 = DragonEggGlobal{
            id                  : 0x2::object::new(arg1),
            balance_SHUI        : 0x2::balance::zero<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>(),
            creator             : 0x2::tx_context::sender(arg1),
            egg_ice_bought_num  : 0,
            egg_fire_bought_num : 0,
            bought_list         : 0x2::table::new<address, bool>(arg1),
            version             : 0,
        };
        0x2::transfer::share_object<DragonEggGlobal>(v9);
    }

    public entry fun withdraw_shui(arg0: &mut DragonEggGlobal, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>>(0x2::coin::from_balance<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>(0x2::balance::split<0x610cda7633924ad20329e7c947438baa82466a5efe35bbeb7567500e3771c5d7::shui::SHUI>(&mut arg0.balance_SHUI, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

