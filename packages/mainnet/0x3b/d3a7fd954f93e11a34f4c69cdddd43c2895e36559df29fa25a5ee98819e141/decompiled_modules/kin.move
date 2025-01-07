module 0x3bd3a7fd954f93e11a34f4c69cdddd43c2895e36559df29fa25a5ee98819e141::kin {
    struct KIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIN>(arg0, 6, b"Kin", b"Mr.Pumpkin", x"49206861766520657870657269656e6365206f6e20576562332c486f706520796f75207472757374206d652062726f2e0a492077696c6c20776f726b20666f7220796f752e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022184_8ae181fcd7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

