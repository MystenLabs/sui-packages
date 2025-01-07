module 0x73c68827779a0ce9bb9d5d1725d1919b120a552c3f27a12b41d98a088b0be625::comp {
    struct COMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMP>(arg0, 9, b"COMP", b"Company", b"Como justin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f62b0e48-0360-4090-8620-ea4546726644.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

