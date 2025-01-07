module 0x706955ec473e5b440276961f60ce693b18c710f373f7299e0410f03bdba69dde::xhr {
    struct XHR has drop {
        dummy_field: bool,
    }

    fun init(arg0: XHR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XHR>(arg0, 9, b"XHR", b"Xahra", b"This meme Coin is just created by Adam Adam in sui Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b2696aa5-f29a-4f06-a108-06856952329d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XHR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XHR>>(v1);
    }

    // decompiled from Move bytecode v6
}

