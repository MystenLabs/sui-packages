module 0x39fac69bbf1b8a5e4a612c118029f06ba775fb698868938db5a247b92ad837ed::aptos {
    struct APTOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: APTOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APTOS>(arg0, 9, b"APT", b"Aptos", b"The second best move chain", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<APTOS>(&mut v2, 1000000000000000000, @0xb0aa870a5dc5f318430a17b3fd26f7bd83b72ce08d86b8e52eba796681e46768, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APTOS>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APTOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

