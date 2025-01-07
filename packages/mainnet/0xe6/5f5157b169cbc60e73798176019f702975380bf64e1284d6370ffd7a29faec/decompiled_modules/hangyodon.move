module 0xe65f5157b169cbc60e73798176019f702975380bf64e1284d6370ffd7a29faec::hangyodon {
    struct HANGYODON has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANGYODON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANGYODON>(arg0, 6, b"HANGYODON", b"HANGYODON CTO", b"LETS CTO THIS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HANGYODON_35721170e6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANGYODON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HANGYODON>>(v1);
    }

    // decompiled from Move bytecode v6
}

