module 0xb5555c2b279d375c32426b3f970dbec9a1b69e13e2364a8223bbfbd35843f14b::molecoin {
    struct MOLECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOLECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOLECOIN>(arg0, 6, b"Molecoin", b"Sui", b"Mol is a young, orphaned two-toed sloth currently living in a wildlife rescue facility in Costa Rica.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_1_4b2999a213.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOLECOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOLECOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

