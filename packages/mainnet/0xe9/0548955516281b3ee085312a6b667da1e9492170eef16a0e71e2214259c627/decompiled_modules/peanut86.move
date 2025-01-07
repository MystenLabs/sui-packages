module 0xe90548955516281b3ee085312a6b667da1e9492170eef16a0e71e2214259c627::peanut86 {
    struct PEANUT86 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEANUT86, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEANUT86>(arg0, 9, b"PEANUT86", b"Peanut", b"Leanut is the extremely cute puppy of a young billionaire", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c8ddfc7d-a434-4b11-bf33-f87695ca023a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEANUT86>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEANUT86>>(v1);
    }

    // decompiled from Move bytecode v6
}

