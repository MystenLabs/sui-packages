module 0xa0de65167c4588159db01c65d70d16db14d9fdf6552d7996518277b3f5e790ae::degtq {
    struct DEGTQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGTQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGTQ>(arg0, 9, b"DEGTQ", b"kloy", x"c4916667646667", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aa08de35-5be4-43d9-a137-f0eaab5e71c0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGTQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEGTQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

