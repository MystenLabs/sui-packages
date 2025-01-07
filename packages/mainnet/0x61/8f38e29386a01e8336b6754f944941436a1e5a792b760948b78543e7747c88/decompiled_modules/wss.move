module 0x618f38e29386a01e8336b6754f944941436a1e5a792b760948b78543e7747c88::wss {
    struct WSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSS>(arg0, 9, b"WSS", b"Wolf coin ", b"coin meme nice", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/808f9cae-ddef-431c-82c8-f06bc2adb449.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

