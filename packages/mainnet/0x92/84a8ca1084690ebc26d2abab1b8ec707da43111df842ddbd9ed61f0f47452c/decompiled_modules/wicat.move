module 0x9284a8ca1084690ebc26d2abab1b8ec707da43111df842ddbd9ed61f0f47452c::wicat {
    struct WICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WICAT>(arg0, 9, b"WICAT", b"RIKASS", b"meme ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b9618f7c-19ca-44f7-a714-b2ef6acf5fb5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

