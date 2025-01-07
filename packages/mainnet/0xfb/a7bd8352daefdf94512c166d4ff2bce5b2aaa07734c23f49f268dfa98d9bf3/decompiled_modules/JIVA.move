module 0xfba7bd8352daefdf94512c166d4ff2bce5b2aaa07734c23f49f268dfa98d9bf3::JIVA {
    struct JIVA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<JIVA>, arg1: 0x2::coin::Coin<JIVA>) {
        0x2::coin::burn<JIVA>(arg0, arg1);
    }

    fun init(arg0: JIVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIVA>(arg0, 9, b"JIVA", b"Jivara", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://coinsult.net/wp-content/uploads/2024/02/Jivara.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JIVA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIVA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JIVA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JIVA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

