module 0x613402aacc14bd458d054bc425532eb47cb68ac508a4c7e5a3cf19544ce238e3::bobe {
    struct BOBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBE>(arg0, 6, b"BOBE", b"BOBE SUI", b"Bobe belongs to the community, and we are supported by influencer artists and big KOLs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kotak_3c8b7facbf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

