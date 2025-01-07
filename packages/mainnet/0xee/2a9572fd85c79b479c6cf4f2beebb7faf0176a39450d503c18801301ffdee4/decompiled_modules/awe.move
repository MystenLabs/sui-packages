module 0xee2a9572fd85c79b479c6cf4f2beebb7faf0176a39450d503c18801301ffdee4::awe {
    struct AWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWE>(arg0, 9, b"AWE", b"Adawewe", b"My own", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f0de8b1f-3af6-4345-84f0-dfec426af639.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

