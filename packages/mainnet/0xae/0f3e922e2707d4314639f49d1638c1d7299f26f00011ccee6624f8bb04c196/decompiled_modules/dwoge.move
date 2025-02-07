module 0xae0f3e922e2707d4314639f49d1638c1d7299f26f00011ccee6624f8bb04c196::dwoge {
    struct DWOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWOGE>(arg0, 9, b"DWOGE", b"DWOGE DAOS", b"Embark on a paw-fectly charming journey into the decentralized realm of woof-nificent joy and lucrative pursuits.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/cb1aaf10-e551-11ef-9eb9-99543e8f5bed")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DWOGE>>(v1);
        0x2::coin::mint_and_transfer<DWOGE>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWOGE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

