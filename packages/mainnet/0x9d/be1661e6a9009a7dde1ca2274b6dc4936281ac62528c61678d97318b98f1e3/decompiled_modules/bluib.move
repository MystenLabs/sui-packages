module 0x9dbe1661e6a9009a7dde1ca2274b6dc4936281ac62528c61678d97318b98f1e3::bluib {
    struct BLUIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUIB>(arg0, 6, b"BLUIB", b"Bluib The Blob", b"The Only Blob You Need On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_09_at_12_34_10_AM_ee8fefb0d1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

