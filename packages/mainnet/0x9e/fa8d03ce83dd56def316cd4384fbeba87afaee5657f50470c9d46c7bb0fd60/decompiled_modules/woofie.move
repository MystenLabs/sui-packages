module 0x9efa8d03ce83dd56def316cd4384fbeba87afaee5657f50470c9d46c7bb0fd60::woofie {
    struct WOOFIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOFIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOFIE>(arg0, 6, b"WOOFIE", b"Woofie", x"4d65657420576f6f66792120546865206e6578742063757465207075707079206f6620535549210a0a526561647920746f206261726b206f6e20796f75722073747265737320616e64206c69636b206177617920796f757220736f72726f77732e0a0a57696c6c20796f752070657420746869732061646f7261626c6520646f67676f3f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_27_03_32_52_985c436204.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOFIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOOFIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

