module 0xaaeb1b6a51f0414ec52b333afdcc2c7d794562d471bf1ec65b720ee634d651eb::uniq {
    struct UNIQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNIQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNIQ>(arg0, 9, b"UNIQ", b"Unique", b"Unique meme token for the community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0b052eea-438a-43f7-af8f-d982e2510a96.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNIQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNIQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

