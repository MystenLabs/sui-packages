module 0xb7cf03d7394685fa79f651b4339d64ecb42a0cc21c69628caefe64dc60f6f9e8::sdgv {
    struct SDGV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDGV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDGV>(arg0, 9, b"SDGV", b"FRH", b"VZVX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d293b512-3d6a-4237-ac52-d27bc48e0bfb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDGV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDGV>>(v1);
    }

    // decompiled from Move bytecode v6
}

