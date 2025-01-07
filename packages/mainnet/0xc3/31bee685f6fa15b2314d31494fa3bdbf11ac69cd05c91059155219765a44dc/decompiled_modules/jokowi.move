module 0xc331bee685f6fa15b2314d31494fa3bdbf11ac69cd05c91059155219765a44dc::jokowi {
    struct JOKOWI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOKOWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOKOWI>(arg0, 9, b"JOKOWI", b"JOKOWI ", b"JOKO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4707fe36-7748-46ea-9442-1f85faa7fd81.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOKOWI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOKOWI>>(v1);
    }

    // decompiled from Move bytecode v6
}

