module 0x1a11b86c4ca0b1c7cc728a0272f3307a605072cfa637af0566ebb9bcb64fde30::jfc {
    struct JFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: JFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JFC>(arg0, 6, b"JFC", b"Jackie Fine Chicken", b"It's Fucking Pumping good!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ewfwfwef_53b12caedf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JFC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

