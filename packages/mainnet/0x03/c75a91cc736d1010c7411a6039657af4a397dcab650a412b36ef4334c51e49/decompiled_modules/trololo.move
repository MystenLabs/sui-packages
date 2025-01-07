module 0x3c75a91cc736d1010c7411a6039657af4a397dcab650a412b36ef4334c51e49::trololo {
    struct TROLOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROLOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLOLO>(arg0, 9, b"TROLOLO", b"Trololo", b"Mr. Trololo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f347d04d-9fbd-42b1-bc0c-2fcb69109754.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLOLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TROLOLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

