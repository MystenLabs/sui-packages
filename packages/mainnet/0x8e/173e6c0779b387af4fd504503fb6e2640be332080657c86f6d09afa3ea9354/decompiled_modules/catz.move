module 0x8e173e6c0779b387af4fd504503fb6e2640be332080657c86f6d09afa3ea9354::catz {
    struct CATZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATZ>(arg0, 9, b"CATZ", b"CAT", b"M,MOE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0c15ccb3-6c4d-4b10-b8d6-ded6e9e1159c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

