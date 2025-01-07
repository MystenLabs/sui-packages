module 0x46cc58fa07d299b0d9432d00ca8750ec51c4fdeee79d3021b4470536b6f47911::fff {
    struct FFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFF>(arg0, 6, b"FFF", b"22525", b"FEWF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0acd23cd_ebea_4803_ae35_7ec09ac1e4ab_65264188ab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

