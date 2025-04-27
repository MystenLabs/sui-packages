module 0x6223c8daa552aa85928651322c0e0e11c2ac8e962f9a777d5c589aa74ebc7063::koban {
    struct KOBAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOBAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOBAN>(arg0, 9, b"KOBAN", b"Lucky Kat", b"Designed for cross-game use, allowing players to seamlessly use and transfer it between different titles, creating a gaming environment that gives power to players", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7497b5f104a24eb1b30c59186cb4a7a6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOBAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOBAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

