module 0x530f73cc661a05b786c8464689616cc0f830a9abe0ece72f62240c6a53558909::xex {
    struct XEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: XEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XEX>(arg0, 9, b"XEX", b"Rex", b"Esd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9ab3c414-9fed-4b2c-8b37-686e561898fa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

