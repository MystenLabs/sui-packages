module 0x592707d12369a0e36ae723ce40ea3a1cb065c0a6e0b7bda0ebb5b952c4b4219::paper {
    struct PAPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAPER>(arg0, 6, b"PAPER", b"Paper On Sui", b"sui on paper , looks good but , it's up to community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiewk6o6kctc3ko2wd6o2t6kqn5h2sbtfkawe46h4hrnavxfkvffdu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PAPER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

