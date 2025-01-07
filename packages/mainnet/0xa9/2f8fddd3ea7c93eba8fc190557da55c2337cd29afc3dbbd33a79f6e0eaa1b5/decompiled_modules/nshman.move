module 0xa92f8fddd3ea7c93eba8fc190557da55c2337cd29afc3dbbd33a79f6e0eaa1b5::nshman {
    struct NSHMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NSHMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NSHMAN>(arg0, 6, b"NSHMAN", b"NISHMAN", b"real memecoin from the best barber brand in the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732114736084.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NSHMAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NSHMAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

