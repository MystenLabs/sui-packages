module 0x2b0827eb2a58e35a044f974e5d3644b2c55518b33cef3a1ee84dfa3f8981f0::ahhhhhh {
    struct AHHHHHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AHHHHHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AHHHHHH>(arg0, 9, b"AHHHHHH", b"ahhhh", b"SCREAM AHHHH AT THE TOP OF YOUR LUNGS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i1.sndcdn.com/artworks-000219223600-fu6qbn-t500x500.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AHHHHHH>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AHHHHHH>>(v2, @0x941790201a6dbb52a7332434a5042f6964366c424735bebb23451caf327f6316);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AHHHHHH>>(v1);
    }

    // decompiled from Move bytecode v6
}

