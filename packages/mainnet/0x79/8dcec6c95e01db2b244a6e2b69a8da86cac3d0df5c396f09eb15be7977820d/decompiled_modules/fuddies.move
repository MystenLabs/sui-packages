module 0x798dcec6c95e01db2b244a6e2b69a8da86cac3d0df5c396f09eb15be7977820d::fuddies {
    struct FUDDIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUDDIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUDDIES>(arg0, 6, b"FUDDIES", b"FUDDIES OFFICIAL", x"68747470733a2f2f7375692e626c75656d6f76652e6e65742f636f6c6c656374696f6e2f667564646965730a4578747261207370656369616c206f776c73206d65616e7320616e206578747261207370656369616c20636f6d6d756e6974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fuddies_af77a79c49.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUDDIES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUDDIES>>(v1);
    }

    // decompiled from Move bytecode v6
}

