module 0xad4c1e25b9c2ef65bf8e0844074aee46480902e2419e7d59554eb9eea2424d7b::sr {
    struct SR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SR>(arg0, 6, b"SR", b"SuiRrari", b"Experience the thrill of exclusivity with SuiRrari, a token that embodies the luxury and prestige of a Ferrari.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_27_00_28_02_ad0c4eeb4f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SR>>(v1);
    }

    // decompiled from Move bytecode v6
}

