module 0x87c23638a4b6e5d187244a57b4640f5ce95203a9e6872c92fc58390225a01f9::deepo {
    struct DEEPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEPO>(arg0, 6, b"DEEPO", b"DEEPO THE WHALE", x"4d6565742024444545504f20746865205768616c652e205468652054727565206d6173636f74206f6620446565705365656b41492e20446565705365656b41492073686f6f6b2075702074686520414920696e6475737472792c20616e64206e6f7720444545504f206973206865726520746f207368616b652075702053756921200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/deepologonew_373877f781.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEEPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

