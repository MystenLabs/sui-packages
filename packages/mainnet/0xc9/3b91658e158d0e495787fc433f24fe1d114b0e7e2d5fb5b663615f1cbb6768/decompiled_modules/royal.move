module 0xc93b91658e158d0e495787fc433f24fe1d114b0e7e2d5fb5b663615f1cbb6768::royal {
    struct ROYAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROYAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROYAL>(arg0, 9, b"ROYAL", b"KING", b"KING is a meme inspired by the spirit of glory and power.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/07189df1-8869-409f-b8b4-986c7af6d4db.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROYAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROYAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

