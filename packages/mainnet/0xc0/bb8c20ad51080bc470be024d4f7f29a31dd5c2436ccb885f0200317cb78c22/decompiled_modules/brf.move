module 0xc0bb8c20ad51080bc470be024d4f7f29a31dd5c2436ccb885f0200317cb78c22::brf {
    struct BRF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRF>(arg0, 6, b"BRF", b"Baref", b"Mr. Baref, a rich old man, a furniture maker", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014704_3312b0e3b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRF>>(v1);
    }

    // decompiled from Move bytecode v6
}

