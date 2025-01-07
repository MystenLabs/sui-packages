module 0x1ac9478c7f85e629fe817730d03da6d83816a8b1ca21f67abe8da49a245138d4::vhs {
    struct VHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: VHS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VHS>(arg0, 6, b"VHS", b"Blockbuster Video", b"Blockbuster Video is a former American multimedia brand. The business was founded as a single home video rental shop and later became a public store chain featuring video game rentals, DVD-by-mail, streaming, video on demand, and cinema theater. The company expanded internationally throughout the 1990s.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/H2_Pyz_V5_Ok_Sg_N95_Pq_4aab82c2a3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VHS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VHS>>(v1);
    }

    // decompiled from Move bytecode v6
}

