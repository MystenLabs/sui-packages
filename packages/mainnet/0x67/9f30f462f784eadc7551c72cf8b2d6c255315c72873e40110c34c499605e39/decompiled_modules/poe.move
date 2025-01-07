module 0x679f30f462f784eadc7551c72cf8b2d6c255315c72873e40110c34c499605e39::poe {
    struct POE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POE>(arg0, 6, b"POE", b"Poe the Potato", b"Just a simple POEtato growing is SUI ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735996297288.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

