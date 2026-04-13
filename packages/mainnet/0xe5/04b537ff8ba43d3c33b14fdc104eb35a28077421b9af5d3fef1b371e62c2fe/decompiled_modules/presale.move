module 0xe504b537ff8ba43d3c33b14fdc104eb35a28077421b9af5d3fef1b371e62c2fe::presale {
    struct Presale<phantom T0> has store, key {
        id: 0x2::object::UID,
        raised: u64,
        presale_tokens: 0x2::coin::Coin<T0>,
        sui_raised: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun create<T0: drop + store + key>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Presale<T0>{
            id             : 0x2::object::new(arg3),
            raised         : 0,
            presale_tokens : 0x2::coin::mint<T0>(arg0, arg1, arg3),
            sui_raised     : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::transfer<Presale<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

