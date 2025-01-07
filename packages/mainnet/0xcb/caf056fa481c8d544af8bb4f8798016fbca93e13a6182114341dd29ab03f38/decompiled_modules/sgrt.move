module 0xcbcaf056fa481c8d544af8bb4f8798016fbca93e13a6182114341dd29ab03f38::sgrt {
    struct SGRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGRT>(arg0, 6, b"SGRT", b"SuiGrant", b"Sui Grant, no tech, just Grant.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000386860_4a8ef59d46.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

