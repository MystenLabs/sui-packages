module 0x62743a8a53a07f482e77b479babfb07784dad2979e90a2b6aaa7c754d9525b46::fight {
    struct FIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIGHT>(arg0, 6, b"FIGHT", b"FIGHT FOR SUI", x"2153554920464f522057494e2c2046494748542046494748542046494748542c2047524f57494e4720434f4d4d554e4954592c204a4f494e20544f444159210a53484f5720534f4c4f4e412054484520504f574552204f46205355492e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dada_bc995ae90b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIGHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIGHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

