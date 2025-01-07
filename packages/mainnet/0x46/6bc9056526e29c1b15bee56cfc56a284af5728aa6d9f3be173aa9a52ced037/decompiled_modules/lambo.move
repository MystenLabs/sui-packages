module 0x466bc9056526e29c1b15bee56cfc56a284af5728aa6d9f3be173aa9a52ced037::lambo {
    struct LAMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMBO>(arg0, 6, b"Lambo", b"LAMBO", b"It is Lambo Time!!!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2239_8986cf90e9.JPEG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAMBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

