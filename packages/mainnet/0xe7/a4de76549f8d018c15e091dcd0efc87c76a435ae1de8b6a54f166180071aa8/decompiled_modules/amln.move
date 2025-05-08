module 0xe7a4de76549f8d018c15e091dcd0efc87c76a435ae1de8b6a54f166180071aa8::amln {
    struct AMLN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMLN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMLN>(arg0, 6, b"AMLN", b"A millionaire", b"I wish you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidzlmxogxuxoc3jngujuyfadb4z4asng2hrjrpojvstoqzlqu26wi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMLN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AMLN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

