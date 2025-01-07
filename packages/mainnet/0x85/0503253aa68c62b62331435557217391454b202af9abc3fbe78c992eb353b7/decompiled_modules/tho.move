module 0x850503253aa68c62b62331435557217391454b202af9abc3fbe78c992eb353b7::tho {
    struct THO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<THO>, arg1: 0x2::coin::Coin<THO>) {
        0x2::coin::burn<THO>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<THO>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<THO>>(0x2::coin::mint<THO>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun transfer(arg0: 0x2::coin::TreasuryCap<THO>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THO>>(arg0, arg1);
    }

    fun init(arg0: THO, arg1: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

