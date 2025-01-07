module 0xe8b06aea149a71b7302bf86409348afee62bac79017b12a88a1b16790825a829::namcat {
    struct NAMCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAMCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAMCAT>(arg0, 6, b"NAMCAT", b"nAM Cat", x"68454c4c4f4f21212069547445594f534849497e7e7e2121210a0a4d79206e616d65206973206e414d20436174206e20696d207468652031737420636174206f6e2074686520696e74726e742121203e2e3c0a6920777320626f726e64206f6e20326368616e2e6e6574206120626f6172642062756c6c6574696e20626f61726420696e207468652079722031393938", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Namcat_PFP_6734135cc2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAMCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAMCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

