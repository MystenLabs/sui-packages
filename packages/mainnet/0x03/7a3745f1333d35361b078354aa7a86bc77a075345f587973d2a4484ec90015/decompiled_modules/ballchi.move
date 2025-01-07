module 0x37a3745f1333d35361b078354aa7a86bc77a075345f587973d2a4484ec90015::ballchi {
    struct BALLCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALLCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALLCHI>(arg0, 6, b"BALLCHI", b"Ballchi Cat", b"With large and round eyes also infinite energy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/429206770_1439574496633397_5902276873567660641_n_27ad2775e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALLCHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALLCHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

