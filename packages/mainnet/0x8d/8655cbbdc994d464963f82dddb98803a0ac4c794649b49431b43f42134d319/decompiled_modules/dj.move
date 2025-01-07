module 0x8d8655cbbdc994d464963f82dddb98803a0ac4c794649b49431b43f42134d319::dj {
    struct DJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJ>(arg0, 9, b"DJ", b"Difficult ", b"Do I have a ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a5a6a895-6cae-4977-a141-ba59f14a47d8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

