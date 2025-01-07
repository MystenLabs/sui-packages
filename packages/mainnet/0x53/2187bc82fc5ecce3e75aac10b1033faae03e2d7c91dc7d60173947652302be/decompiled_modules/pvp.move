module 0x532187bc82fc5ecce3e75aac10b1033faae03e2d7c91dc7d60173947652302be::pvp {
    struct PVP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PVP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PVP>(arg0, 6, b"PVP", b"PvP", b"Everything is player versus player. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736053682862.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PVP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PVP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

