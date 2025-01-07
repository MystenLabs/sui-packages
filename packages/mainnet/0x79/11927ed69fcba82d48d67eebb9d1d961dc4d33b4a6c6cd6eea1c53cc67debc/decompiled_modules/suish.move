module 0x7911927ed69fcba82d48d67eebb9d1d961dc4d33b4a6c6cd6eea1c53cc67debc::suish {
    struct SUISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISH>(arg0, 6, b"SUISH", b"SUISH on SUI", x"53554953482069732061206c6966657374796c65206d656d65206f6e207375692c207769746820616e206574686f73206f6620636f6e666964656e63652c2077696e6e696e6720616e642063656c6562726174696e672e0a4a6f696e207573206e6f77206f6e2074656c656772616d2c20666f6c6c6f77206f6e20582c20616e64206a6f696e207468652063756c74206f662077696e6e6572732e204a7573742050756d702069742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUISH_TOKEN_LOGO_8f257322c8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

