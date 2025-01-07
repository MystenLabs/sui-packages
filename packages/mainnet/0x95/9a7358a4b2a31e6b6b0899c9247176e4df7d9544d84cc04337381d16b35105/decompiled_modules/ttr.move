module 0x959a7358a4b2a31e6b6b0899c9247176e4df7d9544d84cc04337381d16b35105::ttr {
    struct TTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTR>(arg0, 6, b"TTR", b"TTR", b"To the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FPOPPY_BUY_GIF_813c06cc7e.png&w=640&q=75"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTR>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TTR>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTR>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

