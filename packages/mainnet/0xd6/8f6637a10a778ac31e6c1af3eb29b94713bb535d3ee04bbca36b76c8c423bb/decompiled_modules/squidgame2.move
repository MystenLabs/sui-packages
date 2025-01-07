module 0xd68f6637a10a778ac31e6c1af3eb29b94713bb535d3ee04bbca36b76c8c423bb::squidgame2 {
    struct SQUIDGAME2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIDGAME2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIDGAME2>(arg0, 6, b"SquidGame2", b"Squid Game 2.0", x"566972616c204e6574666c697820736572696573206973206261636b0a446f6e74206c6f7374207468652068797065", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241007_114732_0000_abfddd533c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIDGAME2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIDGAME2>>(v1);
    }

    // decompiled from Move bytecode v6
}

