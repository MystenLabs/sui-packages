module 0x6bfab3c496fe369b5905867a58909679947c8890c296dce3437b0f329132aa4e::gonzo {
    struct GONZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GONZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GONZO>(arg0, 6, b"Gonzo", b"Gonzocoin", b"Pure Gonzo journalism", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiexc7fa3dgz67zhuhwt7tmghcg2grkfltqn7vwi6vppajvb6xilea")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GONZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GONZO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

