module 0xf96ae61491909b4b4ff46a42da55146cdf605d124b535140bba9e33168952619::pppdog {
    struct PPPDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPPDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPPDOG>(arg0, 6, b"PPPDOG", b"Panzerdogs", b"PVP play & earn tank brawler on #sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pdog_a7b6f2da54.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPPDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPPDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

