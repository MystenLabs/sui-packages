module 0x5788b3fb4700b21191aa671cba522989c8387a25a0e22c787ac73d48a04c5892::presid47 {
    struct PRESID47 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRESID47, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRESID47>(arg0, 9, b"PRESID47", b"Pre47", b"Meme about 47th", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ada9b60b-26d2-41b2-beec-8aaf7d6d4997.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRESID47>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRESID47>>(v1);
    }

    // decompiled from Move bytecode v6
}

