module 0xecec321ccc58b4cbf7cc37a0e4b64e6a3f7007211541fa5616569df13258bd5b::volcano {
    struct Volcano has store, key {
        id: 0x2::object::UID,
        eruptions: u64,
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : Volcano {
        Volcano{
            id        : 0x2::object::new(arg0),
            eruptions : 0,
        }
    }

    public entry fun decrease_eruption(arg0: &mut Volcano, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.eruptions >= arg2, 1);
        arg0.eruptions = arg0.eruptions - arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, 100000000, arg3), @0xded44d653ef8ec17c3cfca05a270b9234e1e98f4b8cb04ef34d1d1449f64bc6a);
    }

    public fun get_eruptions(arg0: &Volcano) : u64 {
        arg0.eruptions
    }

    public entry fun increase_eruption(arg0: &mut Volcano, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.eruptions = arg0.eruptions + arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, 100000000, arg3), @0xded44d653ef8ec17c3cfca05a270b9234e1e98f4b8cb04ef34d1d1449f64bc6a);
    }

    // decompiled from Move bytecode v6
}

