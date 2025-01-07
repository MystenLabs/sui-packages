module 0x44ba1091c43491ef875215a270075da7e30572dd452af0f7739d6b27fd7d5d4e::shiba {
    struct SHIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBA>(arg0, 6, b"SHIBA", b"American Shib", b"Welcome to the American Shiba campaign  a movement that seeks to revolutionize the future of the United States of America. Rumors have been circulating, speculating that American Shiba is the new candidate to challenge the current political landscape and bring about positive change for the nation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c10f6606_fce3_4a21_93b4_b992dc3ba80f_4885efcbdf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

