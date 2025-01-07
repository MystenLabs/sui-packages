module 0xcf61e5ce9932656807059f42bd6480fd5eba252ca56358a5ca20c466fff6cf9e::hype {
    struct HYPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYPE>(arg0, 9, b"HYPE", b"HYPE", b"HYPE OF DAY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://onfido.com/wp-content/uploads/2024/03/Hype-Featured-Image-Customer-Case-Study-1200x628-1.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HYPE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYPE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HYPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

