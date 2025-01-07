module 0xfe997e2128c14e30a91e240ff69d19079138e4fd6e68bbf091d7d02edce9ee79::batman {
    struct BATMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BATMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BATMAN>(arg0, 6, b"BATMAN", b"Batman", b" Fly with  me at the DARK to the new heights!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BAT_213ba1281a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BATMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BATMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

