module 0x27698e2b2673737b00374d480f78aea9f66ad79f3c6b68a61e765958fa3338b9::gwghsb {
    struct GWGHSB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GWGHSB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GWGHSB>(arg0, 9, b"GWGHSB", b"zhjsj", b"jsjsn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d59a0f4a-3c6a-469c-9c44-734f1341bb0b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GWGHSB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GWGHSB>>(v1);
    }

    // decompiled from Move bytecode v6
}

