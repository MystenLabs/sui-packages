module 0x95e8edb7b4e5e76e09ae370de3761f1eda590cc9364cb87699ad336f6f63150e::jacg {
    struct JACG has drop {
        dummy_field: bool,
    }

    fun init(arg0: JACG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JACG>(arg0, 6, b"JACG", b"just a chill guy", b"okay man", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/448341794_479900251271013_1412783867946287549_n_ede36d4c2f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JACG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JACG>>(v1);
    }

    // decompiled from Move bytecode v6
}

