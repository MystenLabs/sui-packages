module 0xb1b91e97606257e4a19023e97c7cf55f77e4cb6ff31dc0cb060835dbd96e4e3c::xhr {
    struct XHR has drop {
        dummy_field: bool,
    }

    fun init(arg0: XHR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XHR>(arg0, 9, b"XHR", b"Xahra", b"This meme Coin is just created by Adam Adam in sui Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/be89d784-20e2-4d6f-b984-7ffb40fd237a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XHR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XHR>>(v1);
    }

    // decompiled from Move bytecode v6
}

