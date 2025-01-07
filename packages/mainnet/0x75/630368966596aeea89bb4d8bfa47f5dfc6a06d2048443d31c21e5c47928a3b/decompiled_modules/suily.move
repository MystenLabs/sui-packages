module 0x75630368966596aeea89bb4d8bfa47f5dfc6a06d2048443d31c21e5c47928a3b::suily {
    struct SUILY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILY>(arg0, 6, b"Suily", b"Free Suily", b"Free suily is inspired by the hit movie free Willy starring a Orca whale who has been separated from his family. Sensing kinship young Jesse form a bond and, with the help of whale trainer Rae, develop a routine of tricks.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_c4459c72_7cd2_4a4a_ba9d_11fc451d93f8_fb70af72dc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILY>>(v1);
    }

    // decompiled from Move bytecode v6
}

