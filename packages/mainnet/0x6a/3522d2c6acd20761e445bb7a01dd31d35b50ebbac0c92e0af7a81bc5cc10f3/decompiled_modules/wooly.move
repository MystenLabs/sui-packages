module 0x6a3522d2c6acd20761e445bb7a01dd31d35b50ebbac0c92e0af7a81bc5cc10f3::wooly {
    struct WOOLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOLY>(arg0, 6, b"WOOLY", b"Pochita's Father", b"Both Wooly and Pochita was abandoned by the same previous owner and were rescued by Lap Shelter.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_21_09_15_9c47a6487e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOOLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

