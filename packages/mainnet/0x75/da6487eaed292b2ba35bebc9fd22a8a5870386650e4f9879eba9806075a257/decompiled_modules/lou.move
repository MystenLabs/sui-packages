module 0x75da6487eaed292b2ba35bebc9fd22a8a5870386650e4f9879eba9806075a257::lou {
    struct LOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOU>(arg0, 6, b"LOU", b"Lou", b"I LOU YOU - On a mission give street dogs a better life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000021145_72cac12652.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

