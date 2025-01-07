module 0x92d99cc7df3d08addef8846838d780bc1d7b7165989a2ca90ae46d8ff7822b43::elontrum {
    struct ELONTRUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONTRUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONTRUM>(arg0, 6, b"ElonTrum", b"Sui TRUM", b"Why ElonTrump?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ad969c9c2e45ca84033badd20d26c3d9_83764c7e1e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONTRUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELONTRUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

