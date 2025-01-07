module 0xa464f80b0a7e83ba300a0cfddb778f170a10ea999bf1ed08e96a889793936198::moodong {
    struct MOODONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODONG>(arg0, 6, b"MOODONG", b"moodong", x"4d6f6f64656e67206f6e206574682c6d616e6167656420627920636f6d6d756e697479202c6c70206275726e74616e642030207461780a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1341ad6b7af0de553d3044933f27c74bb96d2b88e3dee8b960f05fa7cc0559e2_0_b6d6cf0d69.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOODONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

