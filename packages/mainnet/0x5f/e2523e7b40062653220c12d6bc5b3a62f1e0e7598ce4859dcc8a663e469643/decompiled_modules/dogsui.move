module 0x5fe2523e7b40062653220c12d6bc5b3a62f1e0e7598ce4859dcc8a663e469643::dogsui {
    struct DOGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGSUI>(arg0, 6, b"DOGSUI", b"Dog Sui", b"Dog Sui, the biggest dog meme on Sui, every chain needs its dog, every dog has its day.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241002_220007_c8175274fb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

