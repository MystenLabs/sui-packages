module 0x9e364e8525bcc491c4c26c26479597fefe4e7ec3d2d7309c2dd03d6a5259931f::mccat {
    struct MCCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCCAT>(arg0, 6, b"McCAT", b"McCat", x"0a5468657265206973206e6f206d656d652c20244d43434154206a75737420747279696e6720746f2067657420776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_23_43_04_a72ccc7c9f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

