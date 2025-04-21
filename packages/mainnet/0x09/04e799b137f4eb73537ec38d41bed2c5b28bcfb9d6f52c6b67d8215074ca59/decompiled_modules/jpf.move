module 0x904e799b137f4eb73537ec38d41bed2c5b28bcfb9d6f52c6b67d8215074ca59::jpf {
    struct JPF has drop {
        dummy_field: bool,
    }

    fun init(arg0: JPF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JPF>(arg0, 6, b"JPF", b"JProof", x"4655545552452041490a4241434b45442042555920535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_04_21_16_42_32_e22e4bc2ca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JPF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JPF>>(v1);
    }

    // decompiled from Move bytecode v6
}

