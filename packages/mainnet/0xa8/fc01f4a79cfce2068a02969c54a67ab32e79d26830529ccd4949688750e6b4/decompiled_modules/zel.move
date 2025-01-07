module 0xa8fc01f4a79cfce2068a02969c54a67ab32e79d26830529ccd4949688750e6b4::zel {
    struct ZEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEL>(arg0, 9, b"ZEL", b"Zelensky", b"A powerful president speaks powerfully and lies powerfully", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/02897172-8f18-4919-b398-e826b1d57ce7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

