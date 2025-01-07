module 0x1d34e7e5fa4293aa703214b7190699f8a6461356b969fe30f02758d0057ee535::wmm {
    struct WMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WMM>(arg0, 6, b"WMM", b"Winner Money Monkey", x"574d4d0a57652061726520686f6c64696e6720697420756e74696c206576657279206f6e652077696e20696e2074686973206379636c6520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000046557_5d98fa5940.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

