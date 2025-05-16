module 0xe6753f4541ab2d30608fe8e2cd311c4ec4965bb7ff1cab71703fbe37c9506131::kila {
    struct KILA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KILA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KILA>(arg0, 6, b"KILA", b"KIlla", b"We all Love Seagulls for Dinner", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifet3bat7s4x4dt5r23gn5cbbidaonkoog3mfyhsbo3ni7w6x76fu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KILA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KILA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

