module 0xb4207ec3fab14561e944fd9fda352b371c160f91cbfc10d83f2e69c1a49a7d88::vslz {
    struct VSLZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: VSLZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VSLZ>(arg0, 6, b"VSLZ", b"visualize", b"visualize it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih2pfvf3pdyjaqhwhifqj74277msoxc6hnrjz4mvf64jc4icze6eu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VSLZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VSLZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

