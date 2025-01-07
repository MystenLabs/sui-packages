module 0xe21419a0040ac394d353018f2aace08f7de2d5e6f3993ded28d2a426516cffb1::avxnnx {
    struct AVXNNX has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVXNNX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVXNNX>(arg0, 9, b"AVXNNX", x"41686268c491", b"Shsjjs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d1cebbb3-90c7-4ec9-9b61-f98f69d9ae97.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVXNNX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AVXNNX>>(v1);
    }

    // decompiled from Move bytecode v6
}

