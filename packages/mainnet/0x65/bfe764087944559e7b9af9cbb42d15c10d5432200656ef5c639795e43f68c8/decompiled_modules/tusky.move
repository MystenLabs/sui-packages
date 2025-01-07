module 0x65bfe764087944559e7b9af9cbb42d15c10d5432200656ef5c639795e43f68c8::tusky {
    struct TUSKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUSKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUSKY>(arg0, 6, b"Tusky", b"TuskyTools", b"Own your data. Decentralized storage on Walrus, end-to-end encryption, and a killer UX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Z5_Xi_GH_01_400x400_575500b08d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUSKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUSKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

