module 0x33e5b649c0b4b44d5cd144e5b4f9696f35bf92603cb9554aeeafe70d881c3ffa::tigerr {
    struct TIGERR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIGERR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIGERR>(arg0, 9, b"TIGERR", b"Tiger", b"Crying Tiger", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/16a0979c-fdee-45cb-aebe-f826a66c577e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIGERR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIGERR>>(v1);
    }

    // decompiled from Move bytecode v6
}

