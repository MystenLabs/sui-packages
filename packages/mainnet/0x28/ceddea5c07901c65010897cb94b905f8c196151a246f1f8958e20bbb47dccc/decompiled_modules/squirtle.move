module 0x28ceddea5c07901c65010897cb94b905f8c196151a246f1f8958e20bbb47dccc::squirtle {
    struct SQUIRTLE has drop {
        dummy_field: bool,
    }

    public entry fun decrease_supply(arg0: &mut 0x2::coin::TreasuryCap<SQUIRTLE>, arg1: vector<0x2::coin::Coin<SQUIRTLE>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::decrease_supply<SQUIRTLE>(0x2::coin::supply_mut<SQUIRTLE>(arg0), 0x2::coin::into_balance<SQUIRTLE>(0xba8f8fabcc241c95a90829e3a989edb80bf76e48cfa1eca38972285fd894f98::payment::take_from<SQUIRTLE>(arg1, arg2, arg3)));
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SQUIRTLE>, arg1: vector<0x2::coin::Coin<SQUIRTLE>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<SQUIRTLE>(arg0, 0xba8f8fabcc241c95a90829e3a989edb80bf76e48cfa1eca38972285fd894f98::payment::take_from<SQUIRTLE>(arg1, arg2, arg3));
    }

    public entry fun burn_mint_cap(arg0: 0x2::coin::TreasuryCap<SQUIRTLE>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SQUIRTLE>>(arg0);
    }

    public entry fun increase_supply(arg0: &mut 0x2::coin::TreasuryCap<SQUIRTLE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        minto(arg0, v0, arg1, arg2);
    }

    fun init(arg0: SQUIRTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIRTLE>(arg0, 9, b"SQUIRT", b"SQUIRTLE", b"Squirtle Squad Here !!! @", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.postimg.cc/cHN75GHP/6495ab6ef3d68230e1822f04e708c6f3.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQUIRTLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIRTLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun minto(arg0: &mut 0x2::coin::TreasuryCap<SQUIRTLE>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SQUIRTLE>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

