module 0x1e4e1f8de07ec297e15b7c5df779c11e3b6a4b6bae730f08e518779652d07745::babyaxol {
    struct BABYAXOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYAXOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYAXOL>(arg0, 6, b"BabyAxol", b"BabyAXOL", b" Meet $BABYAXOL, the adorable little swimmer on #SUI ! dive deep and make waves together! Axol is my Dad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/33099630265425511111_ezgif_com_optimize_1_5452e82c60.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYAXOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYAXOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

