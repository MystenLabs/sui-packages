module 0x76b9fa179d02b1503d8562720a2833457b65ad0bd85b03bc5c83f97def869586::chm2 {
    struct CHM2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHM2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHM2>(arg0, 6, b"CHM2", b"Cheems Cheems", b"cheems cheems", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cheems_meme_e594cadd14.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHM2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHM2>>(v1);
    }

    // decompiled from Move bytecode v6
}

