module 0x80863ae3cd3e6e850eac404b1e449ee2daba8ebb234076b2191fc28ddaff80a7::splo {
    struct SPLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLO>(arg0, 6, b"SPLO", b"Splo SPLASH", b"All in, all splash, that's SPLO. Solid SPLOMUNITY coin. www.splosplashsui.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_11_202639_96f5c0d95c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

