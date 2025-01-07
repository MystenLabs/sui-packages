module 0x2d1f04ada7145b158cc394f951a5af0ac536922df401afd2813e8335b21ddd17::chillmas {
    struct CHILLMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLMAS>(arg0, 6, b"ChillMas", b"ChillXmas", b"Safe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733073806555.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLMAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLMAS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

