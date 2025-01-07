module 0x67a7d93e6a0d6c281e1c54735c594cd8ea70435fcfa877b2b0087292ba62fa55::suionmeme {
    struct SUIONMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIONMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIONMEME>(arg0, 6, b"SUIONMEME", b"SUIMEH", b"The embodiment of apathy in the meme coin universe, the ultimate crypto degen, emotionless in the face of chaos.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730986617725.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIONMEME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIONMEME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

