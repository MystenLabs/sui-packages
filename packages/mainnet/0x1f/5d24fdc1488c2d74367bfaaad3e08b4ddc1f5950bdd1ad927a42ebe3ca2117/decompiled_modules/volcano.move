module 0x1f5d24fdc1488c2d74367bfaaad3e08b4ddc1f5950bdd1ad927a42ebe3ca2117::volcano {
    struct Volcano has store, key {
        id: 0x2::object::UID,
        eruptions: u64,
        current_eruption_level: u64,
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : Volcano {
        Volcano{
            id                     : 0x2::object::new(arg0),
            eruptions              : 0,
            current_eruption_level : 0,
        }
    }

    public entry fun create_shared(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0xded44d653ef8ec17c3cfca05a270b9234e1e98f4b8cb04ef34d1d1449f64bc6a, 100);
        let v0 = Volcano{
            id                     : 0x2::object::new(arg0),
            eruptions              : 0,
            current_eruption_level : 0,
        };
        0x2::transfer::share_object<Volcano>(v0);
    }

    public entry fun decrease_eruption(arg0: &mut Volcano, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.eruptions >= 1, 1);
        assert!(arg0.current_eruption_level >= 100000000, 2);
        arg0.eruptions = arg0.eruptions - 1;
        arg0.current_eruption_level = arg0.current_eruption_level - 100000000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, 100000000, arg2), @0xded44d653ef8ec17c3cfca05a270b9234e1e98f4b8cb04ef34d1d1449f64bc6a);
    }

    public fun get_current_eruption_level(arg0: &Volcano) : u64 {
        arg0.current_eruption_level
    }

    public fun get_eruptions(arg0: &Volcano) : u64 {
        arg0.eruptions
    }

    public fun get_target_eruption_level() : u64 {
        1000000000000000
    }

    public entry fun increase_eruption(arg0: &mut Volcano, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.eruptions = arg0.eruptions + 1;
        arg0.current_eruption_level = arg0.current_eruption_level + 100000000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, 100000000, arg2), @0xded44d653ef8ec17c3cfca05a270b9234e1e98f4b8cb04ef34d1d1449f64bc6a);
    }

    // decompiled from Move bytecode v6
}

