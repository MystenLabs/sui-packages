module 0x784c2512e19d0899a4365f6b220f3e0e294774c190f7dd19b6a733163338bc96::suimoon {
    struct SUIMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMOON>(arg0, 9, b"SMOON", b"SUIMOON", b"Lets moon with SUIMOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/yd59D6Zx/suimoon-Asset-2-300x.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMOON>>(v1);
        0x2::coin::mint_and_transfer<SUIMOON>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMOON>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

