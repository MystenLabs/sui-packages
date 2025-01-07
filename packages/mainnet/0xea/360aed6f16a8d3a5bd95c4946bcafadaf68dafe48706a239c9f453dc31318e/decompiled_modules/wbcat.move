module 0xea360aed6f16a8d3a5bd95c4946bcafadaf68dafe48706a239c9f453dc31318e::wbcat {
    struct WBCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WBCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WBCAT>(arg0, 6, b"WBCAT", b"WalrusBishCat", b"The freakiest sea creature you'll ever catch on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/walrusbishcatprof_280e160e24.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WBCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WBCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

