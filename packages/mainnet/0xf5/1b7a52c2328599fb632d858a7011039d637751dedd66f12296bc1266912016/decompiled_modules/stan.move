module 0xf51b7a52c2328599fb632d858a7011039d637751dedd66f12296bc1266912016::stan {
    struct STAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAN>(arg0, 6, b"STAN", b"Sui Stan", x"496e74726f647563696e6720537569205374616e2c20746865205374616e6c657920437570206f6620537569210a0a4e6f74206a75737420616e79206375702c206275742074686520756c74696d6174652064757261626c65206d656d6520636f696e2063757021200a0a4b65657020796f75722063727970746f20636f6f6c6572206c6f6e6765722062792073697070696e67207769746820245354414e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_04_05_23_36_c302cffe8e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

