module 0x92f13ea6f07f1139b2c0520ddad277543fa794df615be87e57c33e0947560373::agn {
    struct AGN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGN>(arg0, 6, b"AGN", b"AGN", b"AGN ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.artistfirst.in/uploads/1737713813380-AGN.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGN>>(v1);
        0x2::coin::mint_and_transfer<AGN>(&mut v2, 1000000000 * 1000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AGN>>(v2);
    }

    // decompiled from Move bytecode v6
}

