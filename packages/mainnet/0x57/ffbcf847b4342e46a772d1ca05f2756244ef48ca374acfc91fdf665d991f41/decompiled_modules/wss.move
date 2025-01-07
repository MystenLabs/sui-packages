module 0x57ffbcf847b4342e46a772d1ca05f2756244ef48ca374acfc91fdf665d991f41::wss {
    struct WSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSS>(arg0, 9, b"WSS", b"Wolf coin ", b"coin meme nice", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3d845b17-7e73-4c31-ba11-d8a5e9a9c27c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

