module 0xa1f7f9aafed81980a23381b7e51a9383c48053c6f60a97af5fb8df10fa6d2e28::ishi {
    struct ISHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISHI>(arg0, 6, b"ISHI", b"Ishiba", b"$ISHI - The Ancestor of Shiba Inu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nakamigos_83976c2e81_2eb11cf696.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ISHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

