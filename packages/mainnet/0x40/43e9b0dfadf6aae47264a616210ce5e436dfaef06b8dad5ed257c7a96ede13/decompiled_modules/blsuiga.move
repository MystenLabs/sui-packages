module 0x4043e9b0dfadf6aae47264a616210ce5e436dfaef06b8dad5ed257c7a96ede13::blsuiga {
    struct BLSUIGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLSUIGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLSUIGA>(arg0, 6, b"BLSUIGA", b"Blsuiga The Whale", b"Blusuiga THE BLUE WHALE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_10_14_034619253_bf4300da62.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLSUIGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLSUIGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

