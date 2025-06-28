module 0xd9a63a9b74e72c2de2728b18a6fdb85047c75ef2f091a98bb0739b502469f6ef::untou {
    struct UNTOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNTOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNTOU>(arg0, 6, b"UNTOU", b"Untouchables", b"But silence sharpned the blade", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeig47fjnwxsjvegp7hp53husg5tsa6lljepm2ukm7phqbjl2p5msjq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNTOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<UNTOU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

