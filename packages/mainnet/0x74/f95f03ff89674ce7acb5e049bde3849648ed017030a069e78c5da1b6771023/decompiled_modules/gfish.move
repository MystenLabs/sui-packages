module 0x74f95f03ff89674ce7acb5e049bde3849648ed017030a069e78c5da1b6771023::gfish {
    struct GFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GFISH>(arg0, 6, b"GFISH", b"GORILLA FISH", b"GORILA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_27_03_01_55_6e1f49b164.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

