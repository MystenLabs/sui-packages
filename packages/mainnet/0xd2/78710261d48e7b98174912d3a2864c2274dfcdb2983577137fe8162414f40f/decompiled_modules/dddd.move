module 0xd278710261d48e7b98174912d3a2864c2274dfcdb2983577137fe8162414f40f::dddd {
    struct DDDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDDD>(arg0, 6, b"DDDD", b"SDSS", b"DASDASDASDD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_sui_logo_d9e334118f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DDDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

