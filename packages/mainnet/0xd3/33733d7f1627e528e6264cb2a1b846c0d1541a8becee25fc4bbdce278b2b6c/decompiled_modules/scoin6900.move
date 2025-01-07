module 0xd333733d7f1627e528e6264cb2a1b846c0d1541a8becee25fc4bbdce278b2b6c::scoin6900 {
    struct SCOIN6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCOIN6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCOIN6900>(arg0, 6, b"sCOIN6900", b"Coin6900", b"Coin6900 ON SUINET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Desain_tanpa_judul_3a29777f92.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCOIN6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCOIN6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

