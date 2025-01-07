module 0x453d808cd8cdde0a75b503aa0798231022b56c839ab610ecaaf4105fde0c1198::murad {
    struct MURAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MURAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MURAD>(arg0, 6, b"MURAD", b"Sui Murad", b"$MURAD is cooking", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000366_18ae598014.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MURAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MURAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

