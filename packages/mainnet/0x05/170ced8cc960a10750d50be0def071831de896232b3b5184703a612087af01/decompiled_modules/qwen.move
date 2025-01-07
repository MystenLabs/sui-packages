module 0x5170ced8cc960a10750d50be0def071831de896232b3b5184703a612087af01::qwen {
    struct QWEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: QWEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QWEN>(arg0, 9, b"Qwen", b"Chinese Truth Terminal", b"Chinese Truth Terminal meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreibpwk5hfh6lbm3a2z3teovbkkfbxxvkkmrmglyhjil3mk5pooblbm.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<QWEN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QWEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QWEN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

