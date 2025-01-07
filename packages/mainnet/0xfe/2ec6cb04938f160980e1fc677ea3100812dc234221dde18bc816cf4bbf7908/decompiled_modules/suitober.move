module 0xfe2ec6cb04938f160980e1fc677ea3100812dc234221dde18bc816cf4bbf7908::suitober {
    struct SUITOBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOBER>(arg0, 6, b"SUITOBER", b"SUI TOBER", b"October is the month for SUI to explode.Website: https://www.suitober.lol/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_227271cc5d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITOBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

