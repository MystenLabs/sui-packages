module 0x96b06db392bdfe02d5a13ed2b01f548d6ca8deedf88b005b99d2da971b78c1d4::wss {
    struct WSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSS>(arg0, 9, b"WSS", b"Wolf SS", b"coin meme nice", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/14acdd55-3596-41dd-a806-2c25e858d52f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

