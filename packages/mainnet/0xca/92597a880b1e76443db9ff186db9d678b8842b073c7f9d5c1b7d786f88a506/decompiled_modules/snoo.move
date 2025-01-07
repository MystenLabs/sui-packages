module 0xca92597a880b1e76443db9ff186db9d678b8842b073c7f9d5c1b7d786f88a506::snoo {
    struct SNOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOO>(arg0, 6, b"SNOO", b"SNOO SUI", b"$Snoo, a brave little alien from a galaxy far away, comes to the Sui blockchain to bring good luck & happiness", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SNOO_1_640d813473.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

