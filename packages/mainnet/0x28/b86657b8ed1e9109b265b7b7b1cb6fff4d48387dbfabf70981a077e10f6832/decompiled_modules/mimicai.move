module 0x28b86657b8ed1e9109b265b7b7b1cb6fff4d48387dbfabf70981a077e10f6832::mimicai {
    struct MIMICAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIMICAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MIMICAI>(arg0, 6, b"MIMICAI", b"MIMIC by SuiAI", b"MIMIC ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/images_12_d4e8bb83ce.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MIMICAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIMICAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

