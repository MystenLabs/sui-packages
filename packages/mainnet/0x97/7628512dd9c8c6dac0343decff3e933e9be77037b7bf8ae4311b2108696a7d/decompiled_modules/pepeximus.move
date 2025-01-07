module 0x977628512dd9c8c6dac0343decff3e933e9be77037b7bf8ae4311b2108696a7d::pepeximus {
    struct PEPEXIMUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEXIMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEXIMUS>(arg0, 6, b"PEPEXIMUS", b"Pepeximus on sui", x"536f6f6e20636f6d696e67207375692067616d626c65206c61756e63682c206e696365206272616e64696e6720616e64207469636b65722c20646567656e2064796f722e205065706578696d7573206675656c65642062792070757265206d656d65746963206e6974726f2e20536f205065706578696d75732077696c6c2077696e207468652072616365206f6620426967204d454d45732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241216_151450_861_688b0f298b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEXIMUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEXIMUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

