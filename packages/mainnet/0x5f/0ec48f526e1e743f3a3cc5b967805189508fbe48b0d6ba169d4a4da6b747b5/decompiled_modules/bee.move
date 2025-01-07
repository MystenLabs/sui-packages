module 0x5f0ec48f526e1e743f3a3cc5b967805189508fbe48b0d6ba169d4a4da6b747b5::bee {
    struct BEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEE>(arg0, 6, b"BEE", b"BEE ON SUI", b"The sweetest token on Sui. Our community is bond together with honey.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_06_23_45_07_2de908e5cc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

