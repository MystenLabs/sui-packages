module 0x38a9c88a76e866b13945a24bcaf1fe89338ba1552056b723a53076f9618c741::gdog {
    struct GDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GDOG>(arg0, 0, b"GDOG", b"HUGDOG", b"just for test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.coingecko.com/coins/images/11939/standard/shiba.png?1696511800")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GDOG>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GDOG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

