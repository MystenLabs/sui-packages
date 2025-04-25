module 0x452facb3dbb642d9d47187156a2152d4ea743b3628434a1a094aa4321a59a6f::shop {
    struct SHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOP>(arg0, 6, b"SHOP", b"Seico.shop", x"43726561746520416374696f6e7320616e64204e465473207468727520537461746520436f6d7072657373696f6e2e20317374204d756c7469636861696e2073686f70204e46542043616d706169676e204d616e6167656d656e7420616e64204d61726b6574706c61636520506c6174666f726d2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_04_25_22_36_44_7c635b08f1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

