module 0xfbc7f8487f6a826893080ca428cdc5e5255886a5962475440ff6f6d79296a2ca::blum {
    struct BLUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUM>(arg0, 6, b"Blum", b"BM", b"Blum is a decentralized trading platforms :", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5083_1b9137b6d2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

