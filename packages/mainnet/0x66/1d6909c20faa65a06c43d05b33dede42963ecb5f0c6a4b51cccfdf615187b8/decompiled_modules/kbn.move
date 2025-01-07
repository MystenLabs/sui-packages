module 0x661d6909c20faa65a06c43d05b33dede42963ecb5f0c6a4b51cccfdf615187b8::kbn {
    struct KBN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KBN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KBN>(arg0, 9, b"KBN", b"BNcrew", b"Massive Crypto Updates native token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ad7bd7b9-071a-4326-9c2e-c0a5ed4f76a9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KBN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KBN>>(v1);
    }

    // decompiled from Move bytecode v6
}

