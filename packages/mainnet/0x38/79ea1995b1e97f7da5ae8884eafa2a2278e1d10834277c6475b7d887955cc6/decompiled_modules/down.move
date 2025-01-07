module 0x3879ea1995b1e97f7da5ae8884eafa2a2278e1d10834277c6475b7d887955cc6::down {
    struct DOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOWN>(arg0, 6, b"DOWN", b"Down SUIndrome", b"MOST RETARDED COIN FOR RETARDED PEOPLE WITH RETARDED DEV . DOWN IS THE WAY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_23_43_03_82d8a4dddd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

