module 0x65e11adff7e472701ea883b0c5c28ac984efd41b72af7aeac51d252268a85e67::sotr {
    struct SOTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOTR>(arg0, 6, b"SOTR", b"SASSY OTTER", b"Splashing into the meme scene with sass and style. Sassy Otter is making waves!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_042400274_e8598ac488.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

