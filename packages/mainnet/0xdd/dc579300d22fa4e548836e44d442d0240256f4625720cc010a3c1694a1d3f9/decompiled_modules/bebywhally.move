module 0xdddc579300d22fa4e548836e44d442d0240256f4625720cc010a3c1694a1d3f9::bebywhally {
    struct BEBYWHALLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEBYWHALLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEBYWHALLY>(arg0, 6, b"BEBYWHALLY", b"BEBYWHALY", b"Memecoin sui whhaly", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000035178_220be607e0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEBYWHALLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEBYWHALLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

