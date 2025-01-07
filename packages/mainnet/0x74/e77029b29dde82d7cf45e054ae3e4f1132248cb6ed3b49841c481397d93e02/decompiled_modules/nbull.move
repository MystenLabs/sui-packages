module 0x74e77029b29dde82d7cf45e054ae3e4f1132248cb6ed3b49841c481397d93e02::nbull {
    struct NBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NBULL>(arg0, 9, b"NBULL", b"NOV BULL", b"\"This is just a meme in November.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b2788140-aa05-4818-94e6-402f773104b8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

