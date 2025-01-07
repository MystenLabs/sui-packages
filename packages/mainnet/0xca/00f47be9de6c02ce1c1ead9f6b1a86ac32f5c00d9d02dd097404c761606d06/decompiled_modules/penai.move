module 0xca00f47be9de6c02ce1c1ead9f6b1a86ac32f5c00d9d02dd097404c761606d06::penai {
    struct PENAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENAI>(arg0, 6, b"PENAI", b"Penguin AI", x"41205355492050726f6a656374206261736564206f6e2070656e6775696e2041492c2077697468206120626f7420696e20646576656c6f706d656e740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2dnqt0d9_400x400_81fb21e3c8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

