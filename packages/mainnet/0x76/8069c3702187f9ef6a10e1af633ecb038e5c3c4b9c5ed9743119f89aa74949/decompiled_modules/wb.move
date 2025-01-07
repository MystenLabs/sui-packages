module 0x768069c3702187f9ef6a10e1af633ecb038e5c3c4b9c5ed9743119f89aa74949::wb {
    struct WB has drop {
        dummy_field: bool,
    }

    fun init(arg0: WB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WB>(arg0, 9, b"WB", b"Wave beats", b"Watch the pump om wewe ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/af1fbad3-35cf-44da-a502-ed4d7e6d7a01.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WB>>(v1);
    }

    // decompiled from Move bytecode v6
}

