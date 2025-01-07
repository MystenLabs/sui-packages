module 0xb35879c618bb51ad141d7424ff9d4784d70517b59d6f77718a81fb4d35987604::goubi {
    struct GOUBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOUBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOUBI>(arg0, 6, b"GOUBI", b"Goubi", b"$GOUBI Is  GOAAAAAATTTTTT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000056311_4ce2e0fe80.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOUBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOUBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

