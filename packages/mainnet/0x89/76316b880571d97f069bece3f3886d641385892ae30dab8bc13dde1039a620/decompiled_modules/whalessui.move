module 0x8976316b880571d97f069bece3f3886d641385892ae30dab8bc13dde1039a620::whalessui {
    struct WHALESSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALESSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALESSUI>(arg0, 9, b"WHALES SUI", b"Sui Whale", b"ONLY APE IF UR A WHALE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXeWhH3YbXVYSyVDD6k67VdaUpV7h48Hd6zXCYNekxWJE")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WHALESSUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALESSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALESSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

