module 0xbe57f8d71d9dfcee020173e07b1d11b3b7d5cbdb1d061ee21f344b81e201be88::iensb {
    struct IENSB has drop {
        dummy_field: bool,
    }

    fun init(arg0: IENSB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IENSB>(arg0, 9, b"IENSB", b"jsjsn", b"jdnsb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/032acace-ad03-45cc-bc74-26b1876bc566.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IENSB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IENSB>>(v1);
    }

    // decompiled from Move bytecode v6
}

