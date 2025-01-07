module 0xcbdcf2c3dfa40bb0b5be4cf80eea0061015e3c3df951abd992f51d833a28e01::blst {
    struct BLST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLST>(arg0, 9, b"BLST", b"Blessing t", b"Christmas token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9766b0fd-e601-4201-b5fe-28978d75ea2c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLST>>(v1);
    }

    // decompiled from Move bytecode v6
}

