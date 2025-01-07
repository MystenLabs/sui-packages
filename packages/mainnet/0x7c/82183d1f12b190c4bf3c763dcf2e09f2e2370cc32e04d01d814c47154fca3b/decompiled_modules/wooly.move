module 0x7c82183d1f12b190c4bf3c763dcf2e09f2e2370cc32e04d01d814c47154fca3b::wooly {
    struct WOOLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOLY>(arg0, 6, b"WOOLY", b"Pochita's Father", b"Both Wooly and Pochita was abandoned by the same previous owner and were rescued by Lap Shelter.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_21_09_15_bd4e2be477.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOOLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

