module 0x612700f602b3f4b952b9d9dfd8ddd5ff0b9bc57315d826352a0d96872c8b1cdf::cc {
    struct CC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CC>(arg0, 9, b"CC", b"Concu", x"e1baa26f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/914dd696-d3a2-4683-bd4f-e8ab7f67482b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CC>>(v1);
    }

    // decompiled from Move bytecode v6
}

