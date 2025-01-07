module 0x108439dcf7451deb758d077dded5afdbd8a3fff550acc3e8528cd9f107e4846c::johnwt {
    struct JOHNWT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOHNWT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOHNWT>(arg0, 9, b"JOHNWT", b"JOHN", b"John White cat ea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/036fd7fb-3cb3-46a5-b81d-0137329ed3f1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOHNWT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOHNWT>>(v1);
    }

    // decompiled from Move bytecode v6
}

