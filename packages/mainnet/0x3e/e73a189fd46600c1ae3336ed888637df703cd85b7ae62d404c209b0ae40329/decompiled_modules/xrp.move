module 0x3ee73a189fd46600c1ae3336ed888637df703cd85b7ae62d404c209b0ae40329::xrp {
    struct XRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: XRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XRP>(arg0, 9, b"XRP", b"THE TICKER IS XRP", b"XRPs going crazy, so we had to drop a memecoin for it! Catch $XRP on Solana and ride the hype!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYL5Ywvc5pRD1gjCi7orzMMbeoF89814m2TTKQgELUkLZ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<XRP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XRP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XRP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

