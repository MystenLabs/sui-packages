module 0x3e4f27b473eb5f6f83045a8ce3aee07d82440071992af7d2f2e631e3c3655f73::klaus {
    struct KLAUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLAUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KLAUS>(arg0, 9, b"KLAUS", b"Klaus", b"$KLAUS - Little Fish, Big Dream. Riding the wave into the next generation of meme tokens.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0xb612bfc5ce2fb1337bd29f5af24ca85dbb181ce2.png?size=xl&key=b93958")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KLAUS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KLAUS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KLAUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

