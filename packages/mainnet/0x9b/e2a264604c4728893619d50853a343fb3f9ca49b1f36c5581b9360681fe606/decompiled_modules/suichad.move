module 0x9be2a264604c4728893619d50853a343fb3f9ca49b1f36c5581b9360681fe606::suichad {
    struct SUICHAD has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUICHAD>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUICHAD>>(0x2::coin::mint<SUICHAD>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: SUICHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHAD>(arg0, 9, b"SUICHAD", b"SUICHAD", b"Infomous wojak becomes SUICHAD becoming a mascot of the Sui Chads.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1857455336527114240/zTFY7I_q_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUICHAD>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICHAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHAD>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

