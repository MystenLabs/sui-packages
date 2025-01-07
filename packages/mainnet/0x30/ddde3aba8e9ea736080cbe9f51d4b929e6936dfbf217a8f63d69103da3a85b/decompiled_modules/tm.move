module 0x30ddde3aba8e9ea736080cbe9f51d4b929e6936dfbf217a8f63d69103da3a85b::tm {
    struct TM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TM>(arg0, 6, b"TM", b"To the Mood", b"We all want it. This token is made for all the people that want to experience their first 1000X to retire. Buy and hold we are in it together!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Chart_Up_957deb6d75.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TM>>(v1);
    }

    // decompiled from Move bytecode v6
}

