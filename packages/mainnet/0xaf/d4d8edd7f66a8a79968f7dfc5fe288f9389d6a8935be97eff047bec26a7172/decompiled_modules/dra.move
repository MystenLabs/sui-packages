module 0xafd4d8edd7f66a8a79968f7dfc5fe288f9389d6a8935be97eff047bec26a7172::dra {
    struct DRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRA>(arg0, 9, b"DRA", b"Dragon", b"This is dragon. No more", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f8906de9-30ea-4114-9ab1-e4aae57f311a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

