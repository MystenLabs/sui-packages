module 0xf4e7ca622323615ad9094ce9d7c122cec79c887a51cd12010d3c55a751e6db61::tupacc {
    struct TUPACC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUPACC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUPACC>(arg0, 9, b"TUPACC", b"Tupac", b"Meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1af93d4f-a38a-4f13-997f-58fd47ed02a2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUPACC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUPACC>>(v1);
    }

    // decompiled from Move bytecode v6
}

