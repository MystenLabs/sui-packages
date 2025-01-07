module 0x8ea4fc4ca8b3fa2c744e1647a05dfb294e21473cd13a646b7d4cd03d00679584::aiko {
    struct AIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIKO>(arg0, 6, b"AIKO", b"Aiko sui", b"Aiko is a cute and curious creature who loves moving around and exploring new places. Always ready for an adventure, Aiko loves to walk in the wild, running from one fun place to another.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001083_2cf2a4871c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

