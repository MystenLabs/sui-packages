module 0xc627a3212562ec4953a0158e572cdf6a94bc6af1f5163f87ff0f800589dd5c1a::testairdrop {
    struct TESTAIRDROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTAIRDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTAIRDROP>(arg0, 9, b"TESTAIRDROP", b"airdroptester", b"sad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESTAIRDROP>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTAIRDROP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTAIRDROP>>(v1);
    }

    // decompiled from Move bytecode v6
}

