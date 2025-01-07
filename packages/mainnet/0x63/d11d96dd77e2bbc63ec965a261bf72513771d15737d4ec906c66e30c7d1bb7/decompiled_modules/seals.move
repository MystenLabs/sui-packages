module 0x63d11d96dd77e2bbc63ec965a261bf72513771d15737d4ec906c66e30c7d1bb7::seals {
    struct SEALS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEALS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEALS>(arg0, 6, b"SEALS", b"Seals On Sui", b"Cute, fluffy little creatures", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sealprof_bebe011d3d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEALS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEALS>>(v1);
    }

    // decompiled from Move bytecode v6
}

