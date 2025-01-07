module 0x2a00476553d7ff7eb30cc474d236403c23b81443ca73c2eb4008f6d0ecf3ca33::drbb {
    struct DRBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRBB>(arg0, 9, b"DRBB", b"DragonBaby", b"Trump No1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/459e15a9-9000-42ec-aaa8-3af8380787b3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

