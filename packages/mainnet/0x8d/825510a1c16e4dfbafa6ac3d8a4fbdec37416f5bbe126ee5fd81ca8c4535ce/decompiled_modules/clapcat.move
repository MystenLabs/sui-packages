module 0x8d825510a1c16e4dfbafa6ac3d8a4fbdec37416f5bbe126ee5fd81ca8c4535ce::clapcat {
    struct CLAPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLAPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAPCAT>(arg0, 6, b"CLAPCAT", b"CLAPCATSUI", b"The official Cat sister of Popcat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_17_14_10_7b82c36553.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLAPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

