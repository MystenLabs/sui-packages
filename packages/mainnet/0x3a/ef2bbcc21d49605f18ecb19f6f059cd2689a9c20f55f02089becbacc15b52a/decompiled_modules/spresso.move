module 0x3aef2bbcc21d49605f18ecb19f6f059cd2689a9c20f55f02089becbacc15b52a::spresso {
    struct SPRESSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPRESSO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPRESSO>(arg0, 6, b"SPRESSO", b"SUI SPRESSO", x"5350524553534f20495320594f55522053554920524f424f20425544445920424152495354412e0a0a412043454c4542524154494f4e204f4620535549204d4f5645204f5045524154494e472053595354454d20414e4420535549204f424a454354532e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SDESG_ca6e8b5073.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPRESSO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPRESSO>>(v1);
    }

    // decompiled from Move bytecode v6
}

