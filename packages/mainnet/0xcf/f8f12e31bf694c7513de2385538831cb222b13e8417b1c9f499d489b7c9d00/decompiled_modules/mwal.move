module 0xcff8f12e31bf694c7513de2385538831cb222b13e8417b1c9f499d489b7c9d00::mwal {
    struct MWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MWAL>(arg0, 9, b"Mwal", b"walmeme", b"BELIVE TO WAL ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d5bc65d6905097030d24104212e9fce5blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MWAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MWAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

