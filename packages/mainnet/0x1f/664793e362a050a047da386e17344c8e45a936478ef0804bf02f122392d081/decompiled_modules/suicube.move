module 0x1f664793e362a050a047da386e17344c8e45a936478ef0804bf02f122392d081::suicube {
    struct SUICUBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICUBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICUBE>(arg0, 6, b"SUICUBE", b"Ice Sui Cube", b"Cool, sharp, and ready to chill the Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_9_4a57c652e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICUBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICUBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

