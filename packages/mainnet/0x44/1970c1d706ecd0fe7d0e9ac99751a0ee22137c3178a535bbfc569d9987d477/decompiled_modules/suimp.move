module 0x441970c1d706ecd0fe7d0e9ac99751a0ee22137c3178a535bbfc569d9987d477::suimp {
    struct SUIMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMP>(arg0, 6, b"SUIMP", b"SUImp", b"Suimp occur in all SUIin shallow and deep waterand in fresh lakes, streams and marketplace.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_18_55_51_506984b0b0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

