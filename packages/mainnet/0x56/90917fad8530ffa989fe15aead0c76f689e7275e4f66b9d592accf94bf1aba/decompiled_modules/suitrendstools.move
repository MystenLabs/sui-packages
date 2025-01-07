module 0x5690917fad8530ffa989fe15aead0c76f689e7275e4f66b9d592accf94bf1aba::suitrendstools {
    struct SUITRENDSTOOLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITRENDSTOOLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITRENDSTOOLS>(arg0, 6, b"SuiTrendsTools", b"SuiTrends", x"5375695472656e647320546f6f6c730a0a5375694e65775061697273200a476574206e6f74696669636174696f6e20666f72206e6577205061697273206c61756e63686564206f6e205355490a40205375694e65775061697273426f7420434f4d494e470a0a4020425559424f5420495320434f4d494e470a0a535549205452454e44494e470a5472656e64696e67205061697273206f6e205355490a4d6f726520666561747572657320746f20636f6d650a405375695472656e646c697665207b4c4956457d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5476_3104c9c602.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITRENDSTOOLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITRENDSTOOLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

