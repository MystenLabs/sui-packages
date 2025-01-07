module 0xbd9664950abd508dde3c650f206dce4656569da54148f721eae59c0ec54f0f72::win93 {
    struct WIN93 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIN93, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIN93>(arg0, 6, b"WIN93", b"Win93", b"Its buggging..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5283_81fded9e9b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIN93>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIN93>>(v1);
    }

    // decompiled from Move bytecode v6
}

