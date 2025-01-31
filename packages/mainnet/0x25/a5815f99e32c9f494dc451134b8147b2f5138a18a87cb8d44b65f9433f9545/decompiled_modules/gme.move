module 0x25a5815f99e32c9f494dc451134b8147b2f5138a18a87cb8d44b65f9433f9545::gme {
    struct GME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GME>(arg0, 6, b"GME", b"GameStop", x"474d452069732074686520706c61636520666f7220616e796f6e652077686f27732065766572206265656e2077726f6e67656420696e20746869732073706163652e200a417320666f722075732c207765206c696b652074686520636f696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000017077_1bed6b7065.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GME>>(v1);
    }

    // decompiled from Move bytecode v6
}

