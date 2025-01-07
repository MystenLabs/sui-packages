module 0x4066dc9731d5214093b2b6996d80dd59f895b3631a2d466e52b70c052cbc11f3::sgc {
    struct SGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGC>(arg0, 6, b"SGC", b"SIGMACat", b"Best  Cats Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20231213_201044_6bd055e279.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGC>>(v1);
    }

    // decompiled from Move bytecode v6
}

