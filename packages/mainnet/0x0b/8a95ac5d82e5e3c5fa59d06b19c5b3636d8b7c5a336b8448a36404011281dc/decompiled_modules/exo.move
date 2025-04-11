module 0xb8a95ac5d82e5e3c5fa59d06b19c5b3636d8b7c5a336b8448a36404011281dc::exo {
    struct EXO has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXO>(arg0, 9, b"Exo", b"Exnihilo", b"The destroyer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5385c04afd6ae4796bb491bdc2072638blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EXO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

