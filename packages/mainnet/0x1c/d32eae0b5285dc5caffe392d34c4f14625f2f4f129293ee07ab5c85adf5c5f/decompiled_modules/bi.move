module 0x1cd32eae0b5285dc5caffe392d34c4f14625f2f4f129293ee07ab5c85adf5c5f::bi {
    struct BI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BI>(arg0, 9, b"BI", b"Jay", b"A", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/11a1b2f7-df51-41d0-9a3c-2cf4d6db746d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BI>>(v1);
    }

    // decompiled from Move bytecode v6
}

