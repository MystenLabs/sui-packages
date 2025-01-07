module 0x8319f0ce808b0a89d05c0bd99af041bbc2d8d3113da858095a2840b916bea2de::bear {
    struct BEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAR>(arg0, 6, b"BEAR", b"SuiBear", b"Suibear sui network best coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000197247_23c7ce38e0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

