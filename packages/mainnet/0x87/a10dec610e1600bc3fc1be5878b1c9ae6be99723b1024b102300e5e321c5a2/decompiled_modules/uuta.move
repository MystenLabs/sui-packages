module 0x87a10dec610e1600bc3fc1be5878b1c9ae6be99723b1024b102300e5e321c5a2::uuta {
    struct UUTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: UUTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UUTA>(arg0, 9, b"UUTA", b"UTA", b"Moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4510386f-4458-4b71-8b07-6f8beb64efe7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UUTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UUTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

