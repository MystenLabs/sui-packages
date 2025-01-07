module 0xc775e7bae5da5a2b87f113ad12a11df51d062a2649b77da153636215d68b5b54::fluffy {
    struct FLUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUFFY>(arg0, 6, b"FLUFFY", b"Fluffy", x"476f6a6f2066616e732073746179696e67207374726f6e6720666f7220616e20656e74697265207972206f6e6c7920666f722053756b756e6120746f20676976652079616c6c20746865206d6964646c652066696e67657220617420746865206c61737420706167652069732068696c6172696f7573206a6a6b3237310a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fluffy_5348395aba.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUFFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLUFFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

