module 0xa0a11f183a97a56920376c5894f12529bb7f614cec2f168883ef9fd204b682e2::imgnai {
    struct IMGNAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: IMGNAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IMGNAI>(arg0, 6, b"imgnAI", b"imgnAI Token", x"4d6f72652046726565646f6d2e0a4d6f72652046756e2e0a204c6574732047656e657261746521200a496d676e4149206973206275696c64696e672074686520667574757265206f662067656e657261746976652041492e0a43726561746520616d617a696e6720617274207669612073696d706c65207465787420636f6d6d616e642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMGNAI_2b92c62b21.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IMGNAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IMGNAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

