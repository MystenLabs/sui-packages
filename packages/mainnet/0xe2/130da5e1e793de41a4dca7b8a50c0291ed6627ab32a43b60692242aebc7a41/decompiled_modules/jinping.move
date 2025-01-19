module 0xe2130da5e1e793de41a4dca7b8a50c0291ed6627ab32a43b60692242aebc7a41::jinping {
    struct JINPING has drop {
        dummy_field: bool,
    }

    fun init(arg0: JINPING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JINPING>(arg0, 9, b"JINPING", b"OFFICIAL XI JINPING", x"4a6f696e204a696e70696e6720636f6d6d756e697479210d0a0d0a4368696e6120616e6420416d65726963612061726520667269656e64732e0d0a0d0a546f676574686572207765206d616b6520686973746f7279210d0a0d0a68747470733a2f2f7777772e726575746572732e636f6d2f776f726c642f75732f7472756d702d77616e74732d76697369742d6368696e612d707265736964656e742d77736a2d7265706f7274732d323032352d30312d31382f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXYeETyPXH5h8rCMLejzuutq8riypmU8q4zrLqTjTmTcN")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JINPING>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JINPING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JINPING>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

