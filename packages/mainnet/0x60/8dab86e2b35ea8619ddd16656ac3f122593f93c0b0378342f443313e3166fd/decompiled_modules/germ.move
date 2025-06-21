module 0x608dab86e2b35ea8619ddd16656ac3f122593f93c0b0378342f443313e3166fd::germ {
    struct GERM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GERM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GERM>(arg0, 8, b"GERM", b"Germinal", b"GERM  on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/b79be087-49ba-4649-aed7-b9849783f070.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GERM>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GERM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GERM>>(v1);
    }

    // decompiled from Move bytecode v6
}

