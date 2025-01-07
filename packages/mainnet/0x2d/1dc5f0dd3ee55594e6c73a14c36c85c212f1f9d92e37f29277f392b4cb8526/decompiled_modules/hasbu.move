module 0x2d1dc5f0dd3ee55594e6c73a14c36c85c212f1f9d92e37f29277f392b4cb8526::hasbu {
    struct HASBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: HASBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HASBU>(arg0, 6, b"HASBU", b"HASBU on SUI", b"Its the iconic Hasbulla", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/W_Rr_g0y_G_400x400_46a2562821.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HASBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HASBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

