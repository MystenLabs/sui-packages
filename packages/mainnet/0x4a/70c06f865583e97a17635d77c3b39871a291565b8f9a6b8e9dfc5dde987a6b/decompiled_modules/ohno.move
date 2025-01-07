module 0x4a70c06f865583e97a17635d77c3b39871a291565b8f9a6b8e9dfc5dde987a6b::ohno {
    struct OHNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OHNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OHNO>(arg0, 6, b"OHNO", b"Oh no", b"I promise I won't rugpull", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_16_12_11_14_bfb08b5465.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OHNO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OHNO>>(v1);
    }

    // decompiled from Move bytecode v6
}

