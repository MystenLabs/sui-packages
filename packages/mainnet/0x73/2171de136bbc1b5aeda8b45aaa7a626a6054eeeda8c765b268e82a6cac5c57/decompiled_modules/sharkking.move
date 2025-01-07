module 0x732171de136bbc1b5aeda8b45aaa7a626a6054eeeda8c765b268e82a6cac5c57::sharkking {
    struct SHARKKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKKING>(arg0, 6, b"Sharkking", b"$Sharkking", b"I am Sharkking, the shark king who rules the deep sea! My crown symbolizes the boundless power of the ocean, and the trident in my hand allows me to control the tides and currents.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c6702704_6c5a_49f3_840b_c9b8ac54033a_c1478a54fb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKKING>>(v1);
    }

    // decompiled from Move bytecode v6
}

