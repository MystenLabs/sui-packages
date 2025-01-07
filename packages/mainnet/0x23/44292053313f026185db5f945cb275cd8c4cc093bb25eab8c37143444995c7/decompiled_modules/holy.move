module 0x2344292053313f026185db5f945cb275cd8c4cc093bb25eab8c37143444995c7::holy {
    struct HOLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLY>(arg0, 6, b"HOLY", b"Raptor Jesus", x"416c6c206861696c2074687920736176696f72200a0a446563656e7472616c697a6564206d656d65202d20776520776f726b20666f72206f7572206261677320616e6420666f72206f7572206c6f72642061726f756e64206865726520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/raptor_jesus_510d112b1a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

