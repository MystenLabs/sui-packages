module 0xbf814003c4c569cb002ab8274fc0cb8ff97a7b4bcf463c75e6b75d7d1603b7fb::xcx {
    struct XCX has drop {
        dummy_field: bool,
    }

    fun init(arg0: XCX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XCX>(arg0, 9, b"XCX", b"XC", b"XCXZ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/93dda7d0-c750-4392-ae1a-4b07bbb1d44a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XCX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XCX>>(v1);
    }

    // decompiled from Move bytecode v6
}

