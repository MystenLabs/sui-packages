module 0xf64edd3bfc210cefbefadd3bf896c72bd1ea7421779675248482be49a66e4622::ginger {
    struct GINGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: GINGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GINGER>(arg0, 9, b"Ginger", x"506564726f526163636f6f6ef09fa69d", x"5769746820746865206f776e6572206f662074686520526163636f6f6e206163746976656c7920737570706f7274696e6720f09fa69d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/AxUx31tmanQ2r8xG3nBvW1L9miHHZNqMfALzc1ygpump.png?size=xl&key=8688b4")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GINGER>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GINGER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GINGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

