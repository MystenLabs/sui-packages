module 0x633b6685db7f75da254cd381385da84411d156936a9b2c2411c4e7ba44e636ab::cfud {
    struct CFUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CFUD>(arg0, 6, b"CFUD", b"Chinese Fuddies", b"CFUD is in Fuddies Gang collection", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_28_T211459_105_b057a520d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CFUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CFUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

