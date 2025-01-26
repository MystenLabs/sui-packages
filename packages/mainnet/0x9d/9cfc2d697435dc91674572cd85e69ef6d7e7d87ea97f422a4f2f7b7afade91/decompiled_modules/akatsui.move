module 0x9d9cfc2d697435dc91674572cd85e69ef6d7e7d87ea97f422a4f2f7b7afade91::akatsui {
    struct AKATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKATSUI>(arg0, 6, b"Akatsui", b"AkatSui", b"This is where the spirit of Akatsuki meets the power of the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737882106022.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AKATSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKATSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

