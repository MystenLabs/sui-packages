module 0x450c7155e8b2f18acc24fe6e3887c592005b5eb02124f2e28954e5f5a69b7fd7::dove {
    struct DOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOVE>(arg0, 6, b"DOVE", b"Dove on Sui", b"The $DOVE of Financial Freedom.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731088953863.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

