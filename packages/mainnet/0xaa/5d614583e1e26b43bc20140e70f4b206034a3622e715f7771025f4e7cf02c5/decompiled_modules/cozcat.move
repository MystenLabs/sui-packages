module 0xaa5d614583e1e26b43bc20140e70f4b206034a3622e715f7771025f4e7cf02c5::cozcat {
    struct COZCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: COZCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COZCAT>(arg0, 6, b"Cozcat", b"COZCAT SUI", b"THE FIRST CATFISH ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_cozcat_cf6bb05849.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COZCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COZCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

