module 0x44b3e4b2513cf5c8b1fe64d7295dd5f5290cee9afdaab6c826a0757983a04f9b::great {
    struct GREAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREAT>(arg0, 9, b"GREAT", b"Dr ", b"Bull run", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2d6ca76b-6c3c-4863-802e-9b52ce7c23dd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GREAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

