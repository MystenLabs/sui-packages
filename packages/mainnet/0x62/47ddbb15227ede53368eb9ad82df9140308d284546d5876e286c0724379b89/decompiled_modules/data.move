module 0x6247ddbb15227ede53368eb9ad82df9140308d284546d5876e286c0724379b89::data {
    struct DATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DATA>(arg0, 6, b"DATA", b"Bite", x"697473206120646174612e206f7220736f6d65203f3f0a6d61796265203f3f0a6920646f6e2774206b6e6f77", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241017_001751_c17443e739.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DATA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DATA>>(v1);
    }

    // decompiled from Move bytecode v6
}

