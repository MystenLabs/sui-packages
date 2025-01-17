module 0x88f602aa3bfecfd01723a4bc4053a9777a7d9f9c93e33838c82b3ef829a95789::suibrett {
    struct SUIBRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBRETT>(arg0, 6, b"SUIBRETT", b"Sui Giga Brett", b"First Combination of Sui Giga Brett", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Final_Logo_1e1f0cd097.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

