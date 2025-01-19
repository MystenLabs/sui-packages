module 0x278a60de7c586a173982de9843169eaacd1b77681f088318cc4b9a3afad04059::chiefs {
    struct CHIEFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIEFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIEFS>(arg0, 6, b"Chiefs", b"Red Kingdom", b"Three Peat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737262505664.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHIEFS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIEFS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

