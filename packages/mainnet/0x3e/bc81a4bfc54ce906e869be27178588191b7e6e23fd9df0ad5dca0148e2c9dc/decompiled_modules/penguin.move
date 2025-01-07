module 0x3ebc81a4bfc54ce906e869be27178588191b7e6e23fd9df0ad5dca0148e2c9dc::penguin {
    struct PENGUIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGUIN>(arg0, 6, b"PENGUIN", b"Penguin", b"penguin is cute. cuteness is justice.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmRSkzvZSbpQNNEgDgNhAxAJ947fPFXZNgXEXCY8ruKs7J?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PENGUIN>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGUIN>>(v2, @0xa1d0f260547bd8fe58c21edad5128dcb0a4209b5542a6301f7180c561fd40896);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGUIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

