module 0xa54e24e83332b146a8357bf016466a34f57280ba46f47445b96535957cc97149::tc {
    struct TC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TC>(arg0, 6, b"TC", b"Test Chat", b"This is a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Chat_GPT_Image_Jun_20_2025_02_55_22_AM_be7a6be5dc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TC>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TC>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

