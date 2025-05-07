module 0xd37c39e23dd85f37b5825273208ba1bbe3b82ffa324cf7cc5e3438ecf906fa2::sdra {
    struct SDRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDRA>(arg0, 6, b"SDRA", b"Suidra", x"535549445241200a0a426f726e206f662057617465722c204d696e746564206f6e205375692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihvzfmokt5a5fekqa5wwldcbwtdwyf5tlrkmfygiyaw7xmccxqffq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SDRA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

