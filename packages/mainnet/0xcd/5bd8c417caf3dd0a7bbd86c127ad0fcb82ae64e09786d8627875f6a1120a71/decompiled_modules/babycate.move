module 0xcd5bd8c417caf3dd0a7bbd86c127ad0fcb82ae64e09786d8627875f6a1120a71::babycate {
    struct BABYCATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYCATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYCATE>(arg0, 6, b"babyCate", b"BABYcate", b"GOD'S  BabyCate", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Image_1729430105563_cde8284a2b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYCATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYCATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

