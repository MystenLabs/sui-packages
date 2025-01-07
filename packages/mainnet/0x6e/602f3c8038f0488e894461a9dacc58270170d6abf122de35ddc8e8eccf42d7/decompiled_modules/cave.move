module 0x6e602f3c8038f0488e894461a9dacc58270170d6abf122de35ddc8e8eccf42d7::cave {
    struct CAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAVE>(arg0, 9, b"CAVE", b"Cave", b"meme cave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/31e82717-6db4-4954-8268-d4c027ed753a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

