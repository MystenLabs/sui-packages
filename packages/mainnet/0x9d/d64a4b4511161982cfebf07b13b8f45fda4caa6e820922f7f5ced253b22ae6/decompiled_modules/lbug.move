module 0x9dd64a4b4511161982cfebf07b13b8f45fda4caa6e820922f7f5ced253b22ae6::lbug {
    struct LBUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LBUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LBUG>(arg0, 9, b"LBUG", b"LANOMEME", b"joining community of gem to create wealth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dd05a72a-e511-4ff8-a581-45d1bbfe82e0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LBUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LBUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

