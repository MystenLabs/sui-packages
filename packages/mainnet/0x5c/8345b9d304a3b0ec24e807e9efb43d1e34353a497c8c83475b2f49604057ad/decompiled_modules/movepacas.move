module 0x5c8345b9d304a3b0ec24e807e9efb43d1e34353a497c8c83475b2f49604057ad::movepacas {
    struct MOVEPACAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVEPACAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEPACAS>(arg0, 6, b"MOVEPACAS", b"MOVE ALPACAS", x"416c70616361733a2054686520426974636f696e202842544329204d6173636f7420746861742048656c706564204272696e67205265636f676e6974696f6e20746f2043727970746f63757272656e63792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3776_017ef1e9ca.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEPACAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVEPACAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

