module 0x58792aa197b7ece3002c960d2a181ee74547c3a6fbfff95b2a7deab6042d10c2::xxxxxx {
    struct XXXXXX has drop {
        dummy_field: bool,
    }

    fun init(arg0: XXXXXX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XXXXXX>(arg0, 9, b"xxxxxx", b"xxxx", b"xxxxxxxx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x83cc526543d9cc2289d6834f44590efda419bd8d.png?size=xl&key=204ae3")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<XXXXXX>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XXXXXX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XXXXXX>>(v1);
    }

    // decompiled from Move bytecode v6
}

