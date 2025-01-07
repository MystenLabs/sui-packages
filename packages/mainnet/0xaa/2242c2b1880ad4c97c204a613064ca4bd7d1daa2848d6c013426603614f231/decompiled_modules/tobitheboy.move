module 0xaa2242c2b1880ad4c97c204a613064ca4bd7d1daa2848d6c013426603614f231::tobitheboy {
    struct TOBITHEBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOBITHEBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOBITHEBOY>(arg0, 9, b"TOBITHEBOY", b"Tobi", b"Token created in acknowledgment of the black beautiful children around use.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6b03a32c-1c41-45d9-960f-e38238b7418a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOBITHEBOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOBITHEBOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

