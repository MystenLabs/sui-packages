module 0x5a180d77d9134c0c4fbad2b475fe8ee87f9aa1b52aec9eca08faa7018afd36f8::lshark {
    struct LSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LSHARK>(arg0, 6, b"LSHARK", b"LASER SHARK", b"THE ONLY SUI SHARK WITH LASERS ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5582_dd9601314f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LSHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LSHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

