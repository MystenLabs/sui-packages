module 0x12aeacedc83e71818a532a21b14938fa09b290dc8d20d885452f0e5b46d08011::mimom {
    struct MIMOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIMOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIMOM>(arg0, 8, b"MIMOM", b"Millionaires Mom", b"Let's make our mother a millionaire and empower all mothers to be self-employed and successful. https://t.me/millimoom https://x.com/millimoom https://www.instagram.com/millimoom https://discord.gg/Dp2TntZ4Dg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MIMOM>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIMOM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIMOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

