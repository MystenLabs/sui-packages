module 0x8fa2b81139c9c8b1efc389c9e84a1338a794ac68c75f14feaeeb2d98b02b9e6e::work {
    struct WORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WORK>(arg0, 6, b"Work", b"im really tired", x"5468697320746f6b656e0a4f6e6c7920666f722070656f706c652077686f20776f726b20666f72203130687220696e206120646179", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5843_66bed9ef05.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

