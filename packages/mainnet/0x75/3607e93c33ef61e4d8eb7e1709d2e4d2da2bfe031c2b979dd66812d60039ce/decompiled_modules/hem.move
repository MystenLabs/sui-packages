module 0x753607e93c33ef61e4d8eb7e1709d2e4d2da2bfe031c2b979dd66812d60039ce::hem {
    struct HEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEM>(arg0, 9, b"HEM", b"Hempatel", x"f09f8e8120446f6ee2809974206d69737320796f7572206368616e636520746f206561726e206d6f72652024574557452120f09f8e810a0a4d6f7265207461736b732068617665206265656e2061646465642e204c6574e2809973206561726e206d6f726520245745574521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d4a1c1ac-cad5-4de5-abcf-3a152b646904.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

