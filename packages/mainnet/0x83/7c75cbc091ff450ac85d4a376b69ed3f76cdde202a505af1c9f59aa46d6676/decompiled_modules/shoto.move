module 0x837c75cbc091ff450ac85d4a376b69ed3f76cdde202a505af1c9f59aa46d6676::shoto {
    struct SHOTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOTO>(arg0, 6, b"Shoto", b"Shoto ", b"Building with friends TURBOS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956629648.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHOTO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOTO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

