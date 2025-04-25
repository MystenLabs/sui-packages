module 0x3f2ced4e35d889565179fe25f40a9ea304cebcbdb40980f41431b5518df5fdfa::arlong {
    struct ARLONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARLONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARLONG>(arg0, 6, b"ARLONG", b"ARLONG COIN", x"46726f6d2041726c6f6e67205061726b20746f20796f757220666565642e20466973682d4d656e20782048756d616e732073696e6365204561737420426c75652e2020506f7374696e67206d656d657320756e74696c204e616d692070617973206d65206261636b2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_04_26_00_42_17_6f9ada13b3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARLONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARLONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

