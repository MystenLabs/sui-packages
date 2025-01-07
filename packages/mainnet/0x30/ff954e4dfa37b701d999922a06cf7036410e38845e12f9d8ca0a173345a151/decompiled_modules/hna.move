module 0x30ff954e4dfa37b701d999922a06cf7036410e38845e12f9d8ca0a173345a151::hna {
    struct HNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HNA>(arg0, 9, b"HNA", b"HNNA", b"Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ab7bfd2b-38bb-4c30-b1f1-52f619259d6e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

