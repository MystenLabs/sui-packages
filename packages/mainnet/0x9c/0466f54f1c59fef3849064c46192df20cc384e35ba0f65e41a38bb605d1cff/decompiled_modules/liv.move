module 0x9c0466f54f1c59fef3849064c46192df20cc384e35ba0f65e41a38bb605d1cff::liv {
    struct LIV has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIV>(arg0, 9, b"LIV", b"Livedealiv", b"Liv coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/56ea70f1-a89a-404f-877d-d01bc1dc0ccb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIV>>(v1);
    }

    // decompiled from Move bytecode v6
}

