module 0x97306e9ba90fec00ea9efbd000df2c4df74b4d73c17d60e5013474d751191f71::missor {
    struct MISSOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MISSOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MISSOR>(arg0, 9, b"MISSOR", b"Don't Be A Missor", x"4c696b6520696e206120636f75706c65206f662066756b6b696e6720646179732c20746865206d61726b6574206a75737420646965642e2e2e2e2e200d0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWAPeUWjnViqPqnRycdPXbmgNokNxaVEjT8WErvgqa8c8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MISSOR>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MISSOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MISSOR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

