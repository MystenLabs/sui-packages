module 0xd9bb911d57ffd6181a1dad0ae1183ca42d714da6a73c2b2fb33928b4f33a42f5::xbr {
    struct XBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: XBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XBR>(arg0, 9, b"XBR", b"Xbrand", b"XBR for All Dont Fade", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4e7ef635-c03f-4d5c-a11d-3805ec307958.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XBR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XBR>>(v1);
    }

    // decompiled from Move bytecode v6
}

