module 0xa2e3bb4f81390f0a8cfe0290a3493f6c00b88eaf3ef3ec67315d0f6666214d42::ete {
    struct ETE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETE>(arg0, 6, b"ETE", b"EYE", b"$eye first real honest token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5085_c6f2eb9dc9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETE>>(v1);
    }

    // decompiled from Move bytecode v6
}

