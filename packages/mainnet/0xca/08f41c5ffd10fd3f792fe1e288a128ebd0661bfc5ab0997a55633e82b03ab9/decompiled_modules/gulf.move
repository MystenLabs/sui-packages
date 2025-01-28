module 0xca08f41c5ffd10fd3f792fe1e288a128ebd0661bfc5ab0997a55633e82b03ab9::gulf {
    struct GULF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GULF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GULF>(arg0, 6, b"GULF", b"GULF OF AMERICA", b"#BREAKING: Google Maps has announced it will update its platform to reflect changes introduced by President Trump, renaming the Gulf of Mexico as the Gulf of America", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250128_144019_846_be524bf4a2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GULF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GULF>>(v1);
    }

    // decompiled from Move bytecode v6
}

