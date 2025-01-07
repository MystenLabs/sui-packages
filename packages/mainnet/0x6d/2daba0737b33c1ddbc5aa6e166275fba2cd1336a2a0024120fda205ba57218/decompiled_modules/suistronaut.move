module 0x6d2daba0737b33c1ddbc5aa6e166275fba2cd1336a2a0024120fda205ba57218::suistronaut {
    struct SUISTRONAUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISTRONAUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISTRONAUT>(arg0, 6, b"Suistronaut", b"Sui Astronaut", b"Sui Astronaut is taking us to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zv_U_Xq0_Xc_AY_9o3_H_b7f89471f3.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISTRONAUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISTRONAUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

