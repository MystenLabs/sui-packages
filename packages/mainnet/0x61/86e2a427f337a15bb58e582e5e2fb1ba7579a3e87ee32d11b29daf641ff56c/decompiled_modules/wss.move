module 0x6186e2a427f337a15bb58e582e5e2fb1ba7579a3e87ee32d11b29daf641ff56c::wss {
    struct WSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSS>(arg0, 9, b"WSS", b"Wolf coin ", b"coin meme nice", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e8dd80ee-8229-4869-95ea-08b8936bbdf8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

