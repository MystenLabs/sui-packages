module 0x4b012eff9e38f7a6bd37e7f26cf825f6cd039f862a3a5206656596807863b07f::getYourThing {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Weapon has store, key {
        id: 0x2::object::UID,
        image: 0x1::string::String,
        name: 0x1::string::String,
        rarity: 0x1::string::String,
        reference: 0x1::string::String,
    }

    struct WeaponMap has key {
        id: 0x2::object::UID,
        map: vector<vector<0x1::string::String>>,
        version: u64,
        admin: 0x2::object::ID,
    }

    struct WepaonMinted has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        receiver: address,
    }

    entry fun AddValue(arg0: &mut WeaponMap, arg1: &AdminCap, arg2: vector<vector<0x1::string::String>>) {
        assert!(arg0.admin == 0x2::object::id<AdminCap>(arg1), 0);
        assert!(arg0.version == 1, 0);
        0x1::vector::append<vector<0x1::string::String>>(&mut arg0.map, arg2);
    }

    entry fun getYourWeapon(arg0: &WeaponMap, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg1, arg2);
        let v1 = 0x2::random::generate_u64_in_range(&mut v0, 0, 0x1::vector::length<vector<0x1::string::String>>(&arg0.map) - 1);
        let v2 = Weapon{
            id        : 0x2::object::new(arg2),
            image     : *0x1::vector::borrow<0x1::string::String>(0x1::vector::borrow<vector<0x1::string::String>>(&arg0.map, v1), 1),
            name      : *0x1::vector::borrow<0x1::string::String>(0x1::vector::borrow<vector<0x1::string::String>>(&arg0.map, v1), 0),
            rarity    : *0x1::vector::borrow<0x1::string::String>(0x1::vector::borrow<vector<0x1::string::String>>(&arg0.map, v1), 2),
            reference : *0x1::vector::borrow<0x1::string::String>(0x1::vector::borrow<vector<0x1::string::String>>(&arg0.map, v1), 3),
        };
        let v3 = WepaonMinted{
            id       : 0x2::object::id<Weapon>(&v2),
            name     : v2.name,
            receiver : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<WepaonMinted>(v3);
        0x2::transfer::public_transfer<Weapon>(v2, 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = WeaponMap{
            id      : 0x2::object::new(arg0),
            map     : 0x1::vector::empty<vector<0x1::string::String>>(),
            version : 1,
            admin   : 0x2::object::id<AdminCap>(&v0),
        };
        0x2::transfer::share_object<WeaponMap>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

