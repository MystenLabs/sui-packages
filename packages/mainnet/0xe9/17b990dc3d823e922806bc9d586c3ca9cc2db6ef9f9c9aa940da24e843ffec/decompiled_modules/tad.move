module 0xe917b990dc3d823e922806bc9d586c3ca9cc2db6ef9f9c9aa940da24e843ffec::tad {
    struct TAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAD>(arg0, 1, b"TAD", b"Test Airdrop", b"TAD", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TAD>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

