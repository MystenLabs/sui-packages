module 0x3b6e8496ce4b2f9b08655a6f46e8a4fec7cf209cc1bce5d1fea24479bfa7d3a0::ozz {
    struct OZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: OZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OZZ>(arg0, 9, b"OZZ", b"Ozzy", b"Token is powerfull", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7092aea0-0aea-4ec1-95c7-cb6dd88da486.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OZZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OZZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

