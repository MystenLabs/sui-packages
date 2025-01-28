module 0x8c74d55f2536577a38b84bcbc0d40a25f741f8bab60db36a7f7a2c50810d4b2f::flepe {
    struct FLEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLEPE>(arg0, 6, b"Flepe", b"flepe", b"Matt furies official $flepe a dolphin based character surfing the waves on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738091717625.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

