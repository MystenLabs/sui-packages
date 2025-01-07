module 0x548dd9ba030c4b1275f0bc80415806d8ea16a250800922f9daa1ea30e3a17ae8::pen {
    struct PEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEN>(arg0, 9, b"PEN", b"PENy", b"just a normal pen inside crypto and blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b9357c80-694f-4aeb-8b56-61a6fd44bb1b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

