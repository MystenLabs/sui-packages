module 0xc4033b919f2eb612723abe16abf2d09e7b66718a7750df26b3463cde5cfd2484::rdms {
    struct RDMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RDMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RDMS>(arg0, 9, b"RDMS", b"REDMOUSE", b"this mouse needs money for jamboree", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dc8a9191-4faf-4287-9898-27da93ed8c9e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RDMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RDMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

