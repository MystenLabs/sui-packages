module 0x97a3d82f75e72eb7a6f0e50903298d5b2d5b23fe3bf213c560e2be32ccdb5d84::brain {
    struct BRAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRAIN>(arg0, 6, b"BRAIN", b"Brain", x"48692c20496d207468652024425241494e20626568696e64204d797374656e5f4c616273210a20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TS_6g2u_Sr_400x400_8739ef2d84.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

