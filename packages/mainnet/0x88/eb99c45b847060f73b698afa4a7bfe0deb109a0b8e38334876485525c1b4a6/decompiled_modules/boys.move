module 0x88eb99c45b847060f73b698afa4a7bfe0deb109a0b8e38334876485525c1b4a6::boys {
    struct BOYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOYS>(arg0, 9, b"BOYS", b"SIGMA BOYS", x"24424f5953202d20746865207265616c207369676d6120626f79732e20f09f918a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/HsdGjX2yDJm7cfAo5Un7MGdpZkhx44f4cZSAftspump.png?size=xl&key=15b3a3")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOYS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOYS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOYS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

