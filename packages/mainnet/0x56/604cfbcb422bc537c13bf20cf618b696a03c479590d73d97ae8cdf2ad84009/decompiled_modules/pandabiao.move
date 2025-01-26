module 0x56604cfbcb422bc537c13bf20cf618b696a03c479590d73d97ae8cdf2ad84009::pandabiao {
    struct PANDABIAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANDABIAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANDABIAO>(arg0, 6, b"Pandabiao", b"Pandabiaocalls", b"OG Pandabiao Calls. Send this to millions!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000043572_21ec13cefa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANDABIAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANDABIAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

