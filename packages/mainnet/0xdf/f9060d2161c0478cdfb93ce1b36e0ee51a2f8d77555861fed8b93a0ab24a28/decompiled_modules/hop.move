module 0xdff9060d2161c0478cdfb93ce1b36e0ee51a2f8d77555861fed8b93a0ab24a28::hop {
    struct HOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOP>(arg0, 6, b"HOP", x"68c4b16f6f70", b"ASD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730990826920.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

