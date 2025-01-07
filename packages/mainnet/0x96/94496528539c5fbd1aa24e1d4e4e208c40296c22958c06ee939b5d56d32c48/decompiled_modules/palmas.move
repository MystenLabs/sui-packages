module 0x9694496528539c5fbd1aa24e1d4e4e208c40296c22958c06ee939b5d56d32c48::palmas {
    struct PALMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PALMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PALMAS>(arg0, 6, b"PALMAS", b"PALMATOKEN", b"PALMA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/54_d1bf127b9a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PALMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PALMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

