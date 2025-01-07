module 0x9f7eaf01b122204ae99e1f83f646939f660537ebec58fb4509c5180f56ac41fc::water {
    struct WATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATER>(arg0, 6, b"WATER", b"Watersui", x"5761746572204865726f200a0a4c61756e6368696e67206f6e2073756920636861696e0a446f6e74206d6973730a53616665207465616d0a0a5467203a2068747470733a2f2f742e6d652f77617465726865726f737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731440589056.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WATER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

