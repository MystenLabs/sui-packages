module 0x53999d748c82e34349f098c887be443e409ee12f9f125d01af0a524ba81ef437::sasuike {
    struct SASUIKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASUIKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASUIKE>(arg0, 6, b"SASUIKE", b"Sasuke feels bad", b"Sasuke feels bad today", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731075930372.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SASUIKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASUIKE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

