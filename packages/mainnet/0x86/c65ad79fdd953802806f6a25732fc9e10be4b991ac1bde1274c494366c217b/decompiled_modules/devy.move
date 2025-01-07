module 0x86c65ad79fdd953802806f6a25732fc9e10be4b991ac1bde1274c494366c217b::devy {
    struct DEVY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEVY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEVY>(arg0, 6, b"DEVY", b"Devy on sui", x"4a6f696e2024444556590a41206d656d6520636f696e206f6e206120736572696f7573206d697373696f6e20696e2074686520556e69746564205374617465732e20244445565920697320612066756e2c20636f6d6d756e6974792d64726976656e206d656d6520636f696e207769746820612067726f7570206f6620646576656c6f70657273206f6e2061206d697373696f6e20746f2064656d6f63726174697a652061636365737320746f20626c6f636b636861696e20646576656c6f706d656e7420696e2074686520556e6974656420537461746573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000051967_c2b8284620.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEVY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEVY>>(v1);
    }

    // decompiled from Move bytecode v6
}

