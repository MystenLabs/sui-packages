module 0x4085558dad9dc8f29989a684dbda2690b667f3aaae3cb20112997f8e45366fa6::gav {
    struct GAV has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAV>(arg0, 9, b"GAV", b"GavGav", b"Gav Gav auuuuu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d8c0d5b4-4b95-4b0f-b734-a3858e4a537f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAV>>(v1);
    }

    // decompiled from Move bytecode v6
}

