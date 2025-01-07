module 0xbaa678740f03605a1a2d22b8336aaf0325274a057ae5e5ad775201726366e63d::badr {
    struct BADR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BADR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BADR>(arg0, 6, b"Badr", b"Badrtherugpullfaggot", b"The best farming dev deserves his own token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241016_070433_c5ea599610.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BADR>>(v1);
    }

    // decompiled from Move bytecode v6
}

