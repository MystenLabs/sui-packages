module 0x138aaed2d157871753fefcbe7cf93fb1decd50c83d079f8d5f647b8c1e99d78::potus {
    struct POTUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: POTUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POTUS>(arg0, 6, b"POTUS", b"Chill President", b"Chill Guy's version as President of the United States.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734654711699.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POTUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POTUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

