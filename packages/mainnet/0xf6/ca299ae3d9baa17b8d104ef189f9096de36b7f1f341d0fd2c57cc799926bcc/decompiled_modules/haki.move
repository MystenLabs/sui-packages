module 0xf6ca299ae3d9baa17b8d104ef189f9096de36b7f1f341d0fd2c57cc799926bcc::haki {
    struct HAKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAKI>(arg0, 9, b"HAKI", b"Hakimim", b"Hakimim is haki meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ba410db3-9367-4289-8a5c-bd2960602c87.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

