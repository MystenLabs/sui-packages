module 0x35ffc75de056021ec1a74177c96451f5099028a381b1b1f0ea1ae24a50597ae4::lioni {
    struct LIONI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIONI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIONI>(arg0, 6, b"LIONI", b"Sui Lioni", b"Welcome to LIONI COIN! Step into the wild world of LIONI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000023594_75ec6e09c6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIONI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIONI>>(v1);
    }

    // decompiled from Move bytecode v6
}

