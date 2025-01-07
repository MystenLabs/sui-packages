module 0x7ef0e0d0fc927ba745060a022c976fb7c5189edbe4ca63fd1412ad073c8a8f7e::suitard {
    struct SUITARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITARD>(arg0, 6, b"SUITARD", b"SUITARD SUI", b"$SUITARD is a tribute to all these legends! Early adopters of tech they dont know anything about but have the balls to take the plunge and the heart to stick around! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/std_bong_245304aedd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

