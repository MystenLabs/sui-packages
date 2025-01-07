module 0xed1809c5477d9a8e76f6da6dc4efaa5d3d93fb74e805947339a8699b8859ff8f::peca {
    struct PECA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PECA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PECA>(arg0, 6, b"PECA", b"PEPE CARD", b"In the medieval kingdom of SUI there lived a peculiar monarch named Frogking He wasn't your typical rulerno. He was literally a frog. A rich af frog that is. Did he have gold you ask? No lol. He was all in $PECA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_20_25_10_42a4337959.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PECA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PECA>>(v1);
    }

    // decompiled from Move bytecode v6
}

