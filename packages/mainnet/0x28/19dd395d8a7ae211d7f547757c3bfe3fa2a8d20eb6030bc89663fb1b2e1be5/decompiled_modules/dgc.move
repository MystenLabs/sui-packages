module 0x2819dd395d8a7ae211d7f547757c3bfe3fa2a8d20eb6030bc89663fb1b2e1be5::dgc {
    struct DGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGC>(arg0, 6, b"DGC", b"DEFI GUNDAM COWBOY", b"YeeHaw YAll", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730983189745.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

