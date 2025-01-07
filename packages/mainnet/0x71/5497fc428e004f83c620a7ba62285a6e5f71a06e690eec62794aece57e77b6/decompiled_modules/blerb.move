module 0x715497fc428e004f83c620a7ba62285a6e5f71a06e690eec62794aece57e77b6::blerb {
    struct BLERB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLERB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLERB>(arg0, 6, b"BLERB", b"BLERBB", b"BLERB ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_23_24_00_819c602e2d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLERB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLERB>>(v1);
    }

    // decompiled from Move bytecode v6
}

