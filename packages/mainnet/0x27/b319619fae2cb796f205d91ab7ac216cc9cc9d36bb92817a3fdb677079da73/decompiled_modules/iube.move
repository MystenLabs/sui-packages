module 0x27b319619fae2cb796f205d91ab7ac216cc9cc9d36bb92817a3fdb677079da73::iube {
    struct IUBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: IUBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IUBE>(arg0, 9, b"IUBE", b"jdje", b"jdndn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/372db5d8-9282-4fbd-917f-1f86d89f07a1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IUBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IUBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

