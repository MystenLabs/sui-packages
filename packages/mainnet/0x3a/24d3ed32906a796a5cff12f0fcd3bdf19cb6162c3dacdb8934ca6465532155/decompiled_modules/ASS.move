module 0x3a24d3ed32906a796a5cff12f0fcd3bdf19cb6162c3dacdb8934ca6465532155::ASS {
    struct ASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASS>(arg0, 6, b"ASS", b"cappuccino assassino", x"4f75722073616d75726169206c6567656e6420f09f998f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmTDwyr3oLyUB57xsmgyRm456Xsy7GeVtstcKs2cqXXQ3J")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

