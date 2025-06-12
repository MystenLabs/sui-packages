module 0xa6af8a46952187fdee3e7767f48fca77835c8ad564fff7248ea3a83cfe9f8025::suig {
    struct SUIG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIG>, arg1: 0x2::coin::Coin<SUIG>) {
        0x2::coin::burn<SUIG>(arg0, arg1);
    }

    fun init(arg0: SUIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIG>(arg0, 9, b"SUIG", b"Suigarette", b"Buy SUIG, smoke Suigarette", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/mahmhub/suigarette/main/image.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIG>>(0x2::coin::mint<SUIG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

