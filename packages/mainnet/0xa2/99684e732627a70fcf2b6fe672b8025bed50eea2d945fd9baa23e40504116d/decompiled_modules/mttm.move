module 0xa299684e732627a70fcf2b6fe672b8025bed50eea2d945fd9baa23e40504116d::mttm {
    struct MTTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTTM>(arg0, 6, b"MTTM", b"MEME TO THE MOON", b"Meme to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2239_6863748d49.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTTM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MTTM>>(v1);
    }

    // decompiled from Move bytecode v6
}

