module 0xe7b559afcf86ea90ebb8f58c745a1609050c615a8ea88332de1d62d63109f5fd::coco {
    struct COCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCO>(arg0, 6, b"COCO", b"Coco the Monkey", x"4f6e636520612063697263757320737461722c206e6f772061206d656d652073656e736174696f6e21200a4e6f20646576202f20436f636f20697320746865206465762e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/thumbnail_6_C881_C4_D_41_C3_4945_BCB_5_942_E0298_A528_673b3b3e4d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

