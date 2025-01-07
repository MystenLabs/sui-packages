module 0x550025a7221a50cbc2ad608862f6ed34a9de48327c960d8c540a6bb13e80614a::ogidog {
    struct OGIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGIDOG>(arg0, 9, b"OGIDOG", b"Ogi", b"An authentic meme coin derived from the animation Ogi With a reliable and strong community, the possibility of it multiplying, buy it at a low price, don't stay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bb914477-9232-4440-9de9-406f16b3d598.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGIDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OGIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

