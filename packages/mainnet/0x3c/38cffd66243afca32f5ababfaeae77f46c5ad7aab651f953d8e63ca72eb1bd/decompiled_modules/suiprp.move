module 0x3c38cffd66243afca32f5ababfaeae77f46c5ad7aab651f953d8e63ca72eb1bd::suiprp {
    struct SUIPRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPRP>(arg0, 6, b"SUIPRP", b"SUIPERIOR", b"SUIPERIOR ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c436e951_84dd_4ac0_951e_c60cb1f4e876_1c979ee157.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPRP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPRP>>(v1);
    }

    // decompiled from Move bytecode v6
}

