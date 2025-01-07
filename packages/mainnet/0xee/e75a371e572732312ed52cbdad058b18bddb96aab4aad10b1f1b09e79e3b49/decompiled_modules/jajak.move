module 0xeee75a371e572732312ed52cbdad058b18bddb96aab4aad10b1f1b09e79e3b49::jajak {
    struct JAJAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAJAK>(arg0, 6, b"Jajak", b"Jajak on Sui", b"Jajak pays a visit to Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jajak_fcfbce5d26.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAJAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAJAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

