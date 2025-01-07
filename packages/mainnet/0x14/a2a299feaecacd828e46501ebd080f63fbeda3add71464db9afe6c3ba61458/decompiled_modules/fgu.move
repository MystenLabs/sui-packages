module 0x14a2a299feaecacd828e46501ebd080f63fbeda3add71464db9afe6c3ba61458::fgu {
    struct FGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FGU>(arg0, 9, b"FGU", b"Tani", b"Toni", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/52fb6b57-80b5-4a10-8f11-03e761f4b3f7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

