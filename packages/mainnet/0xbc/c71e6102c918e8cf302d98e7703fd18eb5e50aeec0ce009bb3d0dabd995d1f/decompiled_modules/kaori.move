module 0xbcc71e6102c918e8cf302d98e7703fd18eb5e50aeec0ce009bb3d0dabd995d1f::kaori {
    struct KAORI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAORI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAORI>(arg0, 9, b"KAORI", b" KAORI", b"KA O RI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d7c213b2-25e4-4bdf-93ef-0a4cfca564e9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAORI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAORI>>(v1);
    }

    // decompiled from Move bytecode v6
}

