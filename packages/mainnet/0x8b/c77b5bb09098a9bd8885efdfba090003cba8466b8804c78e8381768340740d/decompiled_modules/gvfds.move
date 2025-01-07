module 0x8bc77b5bb09098a9bd8885efdfba090003cba8466b8804c78e8381768340740d::gvfds {
    struct GVFDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GVFDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GVFDS>(arg0, 9, b"GVFDS", b"GF", b"BCX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d0062696-a3b1-476e-ba34-914156970ecb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GVFDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GVFDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

