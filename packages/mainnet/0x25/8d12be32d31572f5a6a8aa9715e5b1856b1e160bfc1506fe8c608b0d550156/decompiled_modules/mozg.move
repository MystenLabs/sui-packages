module 0x258d12be32d31572f5a6a8aa9715e5b1856b1e160bfc1506fe8c608b0d550156::mozg {
    struct MOZG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOZG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOZG>(arg0, 6, b"MOZG", b"$MOZG", b"$MOZG coin official token from real smart human : ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5085_f5a78883c8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOZG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOZG>>(v1);
    }

    // decompiled from Move bytecode v6
}

