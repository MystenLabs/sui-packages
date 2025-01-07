module 0x87b660f4cb631f16e102345c7eaba45f6fdb8514875e7e6903479fdd2f67c2f4::dfake {
    struct DFAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFAKE>(arg0, 6, b"DFake", b"DEEPFAKE", b"Waiting for Deepbook is not as good as having Deepfake", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qa_H_TJY_400x400_1fa6895c1e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DFAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

