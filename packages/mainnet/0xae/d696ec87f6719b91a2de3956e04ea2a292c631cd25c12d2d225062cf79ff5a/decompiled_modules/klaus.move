module 0xaed696ec87f6719b91a2de3956e04ea2a292c631cd25c12d2d225062cf79ff5a::klaus {
    struct KLAUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLAUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KLAUS>(arg0, 6, b"KLAUS", b"Klaus", b"$KLAUS - Little Fish, Big Dream. Riding the wave into the next generation of meme.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xb612bfc5ce2fb1337bd29f5af24ca85dbb181ce2_6210981c30.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KLAUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KLAUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

