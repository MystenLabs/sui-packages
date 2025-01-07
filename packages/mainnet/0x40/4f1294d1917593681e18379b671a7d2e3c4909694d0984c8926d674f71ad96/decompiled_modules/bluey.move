module 0x404f1294d1917593681e18379b671a7d2e3c4909694d0984c8926d674f71ad96::bluey {
    struct BLUEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEY>(arg0, 6, b"BLUEY", b"SUI BLUEY", b"Memecoin on SUI! Not related to Disney + or BBC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x03a58fbc6d8301a69545bf2f0b711785b18e100a_0f3f9a9e82.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

