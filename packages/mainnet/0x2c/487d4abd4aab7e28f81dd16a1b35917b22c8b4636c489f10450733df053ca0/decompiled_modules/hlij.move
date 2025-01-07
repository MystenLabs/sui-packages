module 0x2c487d4abd4aab7e28f81dd16a1b35917b22c8b4636c489f10450733df053ca0::hlij {
    struct HLIJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: HLIJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HLIJ>(arg0, 9, b"HLIJ", b"hah", b"df", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/604435b4-ced6-40bc-96c2-567c1151bf5a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HLIJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HLIJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

