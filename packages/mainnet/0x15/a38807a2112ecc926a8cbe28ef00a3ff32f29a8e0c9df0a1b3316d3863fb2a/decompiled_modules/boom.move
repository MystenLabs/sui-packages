module 0x15a38807a2112ecc926a8cbe28ef00a3ff32f29a8e0c9df0a1b3316d3863fb2a::boom {
    struct BOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOM>(arg0, 9, b"BOOM", b"Boombie", b"Boombie token this boom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fe6ee171-c0b5-456d-a9e7-649d9ab5bd7d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

