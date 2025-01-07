module 0x636091a34a74735dd0ffc5328956414ad008394b3ab061719e2fe22c2e7b874e::krish {
    struct KRISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRISH>(arg0, 9, b"KRISH", b"Krish", b"Doing random airdrop", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KRISH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRISH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

