module 0xb96b83688d3e6396e3c3be55e4c141bf9ca301d3e9db71a91a1045c5af449837::xhr {
    struct XHR has drop {
        dummy_field: bool,
    }

    fun init(arg0: XHR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XHR>(arg0, 9, b"XHR", b"Xahra", b"This meme Coin is just created by Adam Adam in sui Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d6e9d991-be37-403e-bc41-fe8def7e8753.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XHR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XHR>>(v1);
    }

    // decompiled from Move bytecode v6
}

