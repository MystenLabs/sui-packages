module 0xf28b9d17eca8e111589c733e3f5c407ce02f8f525e4cde0225b9f95314aa3ff2::srn {
    struct SRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRN>(arg0, 9, b"SRN", b"Sarina", b"Community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3205a410-79ca-41c7-ac06-9917c3ed949b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SRN>>(v1);
    }

    // decompiled from Move bytecode v6
}

