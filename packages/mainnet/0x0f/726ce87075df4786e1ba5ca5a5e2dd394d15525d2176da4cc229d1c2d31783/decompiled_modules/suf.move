module 0xf726ce87075df4786e1ba5ca5a5e2dd394d15525d2176da4cc229d1c2d31783::suf {
    struct SUF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUF>(arg0, 9, b"SUF", b"SMURF", b"Shinobi Gaming Guild", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/303db26e-7393-48cc-8e00-5de7bae681f3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUF>>(v1);
    }

    // decompiled from Move bytecode v6
}

