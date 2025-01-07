module 0xe5a12e53b6bd787b01c10a74dd42522ac8339d6627e4b162ff9aa0a7dab6027::king {
    struct KING has drop {
        dummy_field: bool,
    }

    fun init(arg0: KING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KING>(arg0, 6, b"KING", b"The Last King", b"We only up from here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953374528.PNG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KING>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

