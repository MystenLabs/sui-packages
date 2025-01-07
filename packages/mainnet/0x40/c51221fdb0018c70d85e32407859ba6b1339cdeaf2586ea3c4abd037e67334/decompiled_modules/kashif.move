module 0x40c51221fdb0018c70d85e32407859ba6b1339cdeaf2586ea3c4abd037e67334::kashif {
    struct KASHIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: KASHIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KASHIF>(arg0, 9, b"KASHIF", b"Muhammad ", b"This is a nice coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/25432072-d6ed-40a6-8f52-5db3e64372ab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KASHIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KASHIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

