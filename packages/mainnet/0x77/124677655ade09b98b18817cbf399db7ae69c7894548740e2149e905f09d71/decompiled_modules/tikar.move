module 0x77124677655ade09b98b18817cbf399db7ae69c7894548740e2149e905f09d71::tikar {
    struct TIKAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIKAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIKAR>(arg0, 9, b"TIKAR", b"Gulung", b"Yj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5245278b-4ce8-4006-b82f-de3ff4e77683.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIKAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIKAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

