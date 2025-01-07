module 0xb22c1dccafe679159caa07c675d67a1cbf778a15919dc0ec1277e28affa1905b::mercat {
    struct MERCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MERCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MERCAT>(arg0, 6, b"MERCAT", b"MERCAT SUI", x"0a4973206974206120666973683f2049732069742061206361743f204e6f206974732061206d657263792c204c697665206f6e205355492e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_22_57_32_79ba94289d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MERCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MERCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

