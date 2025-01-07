module 0x849b5b56313c930a4510caa46da5853ea9348aacfd54639521d8b6c9cfb82b4b::ttvn {
    struct TTVN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTVN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTVN>(arg0, 9, b"TTVN", b"TemTrieuVN", x"54656d5472696575564e206cc3a02061646d696e206368616e6e656c20426c6f636b636861696e732041697244726f7020564e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3cc7795e-475d-4d68-8118-b6fdd1d879dc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTVN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTVN>>(v1);
    }

    // decompiled from Move bytecode v6
}

