module 0x9463d9713598890004577afb99c7e45eadd1dea54bd9bef67299634528e90b3::pan {
    struct PAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAN>(arg0, 6, b"PAN", b"Pandaton", b"Join our vibrant and fun-loving community centered around the PANDATON memecoin, built on the SUI! Dive into a world of exciting opportunities and engaging experiences.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/coin_5e17681f37.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

