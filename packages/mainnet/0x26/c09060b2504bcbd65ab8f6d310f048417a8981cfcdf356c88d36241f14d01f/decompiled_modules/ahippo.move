module 0x26c09060b2504bcbd65ab8f6d310f048417a8981cfcdf356c88d36241f14d01f::ahippo {
    struct AHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AHIPPO>(arg0, 6, b"AHIPPO", b"AAAHIPPO", b"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHIPPO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4c284aab08ebfeb263c49df56ed783d9_e98a1d517f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AHIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AHIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

