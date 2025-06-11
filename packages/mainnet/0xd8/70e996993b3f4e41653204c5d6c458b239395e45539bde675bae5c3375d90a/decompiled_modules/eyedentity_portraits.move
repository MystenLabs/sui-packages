module 0xd870e996993b3f4e41653204c5d6c458b239395e45539bde675bae5c3375d90a::eyedentity_portraits {
    struct KlausMueller has drop {
        dummy_field: bool,
    }

    struct HaydenMichael has drop {
        dummy_field: bool,
    }

    struct Zack has drop {
        dummy_field: bool,
    }

    struct Janky has drop {
        dummy_field: bool,
    }

    struct Coolman has drop {
        dummy_field: bool,
    }

    struct Spesh has drop {
        dummy_field: bool,
    }

    struct Portrait<phantom T0> has store, key {
        id: 0x2::object::UID,
        mint_number: u64,
    }

    public fun mint_and_transfer<T0>(arg0: u64, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Portrait<T0>{
            id          : 0x2::object::new(arg2),
            mint_number : arg0,
        };
        0x2::transfer::public_transfer<Portrait<T0>>(v0, arg1);
    }

    public fun mint_number<T0>(arg0: &Portrait<T0>) : u64 {
        arg0.mint_number
    }

    // decompiled from Move bytecode v6
}

