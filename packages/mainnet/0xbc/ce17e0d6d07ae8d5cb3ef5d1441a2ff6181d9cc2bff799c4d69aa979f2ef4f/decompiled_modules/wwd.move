module 0xbcce17e0d6d07ae8d5cb3ef5d1441a2ff6181d9cc2bff799c4d69aa979f2ef4f::wwd {
    struct WWD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWD>(arg0, 9, b"WWD", b"window", x"4f70656e20746f20746865206675747572650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/234c6485-90cf-4119-8c6c-ec93baf4af1d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WWD>>(v1);
    }

    // decompiled from Move bytecode v6
}

