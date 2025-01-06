module 0x938099036e0b50bf4e8c6d220736e9767776df46cfb4b20c1e8f94d2551e3d37::jeeter {
    struct JEETER has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEETER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEETER>(arg0, 6, b"Jeeter", b"Derek Jeeter", x"446572656b204a65746572206973206120357820776f726c6420736572696573206368616d70696f6e20616e642031347820616c6c2d737461722e204865277320726963682c20676f6f64206c6f6f6b696e6720616e6420686173206265656e2062616e67696e6720686f742062726f61647320616c6c20686973206c6966652e200a0a0a427574206e6f7720796f752063616e206f75742d4a6565742068696d2c20626563617573652074686572652773206e6f206a656574696e6720616c6c6f77656420686572652e204e6f204149206f722042532c206a7573742070757265204a657465722c206e6f74206a656574696e672e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736201556886.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JEETER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEETER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

