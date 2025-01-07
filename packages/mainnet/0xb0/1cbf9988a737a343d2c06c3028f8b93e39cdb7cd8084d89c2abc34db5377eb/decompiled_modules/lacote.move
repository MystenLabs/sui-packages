module 0xb01cbf9988a737a343d2c06c3028f8b93e39cdb7cd8084d89c2abc34db5377eb::lacote {
    struct LACOTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LACOTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LACOTE>(arg0, 6, b"LACOTE", b"LACOTE", b"Shop together with LACOTE. Choose your product and we deliver it to you on-chain. Over 10 million users worldwide. On LACOTE you can purchase products exclusively with Sui or LACOTE coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co/xMh4tzw/lacote.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LACOTE>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LACOTE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LACOTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

