module 0x2b214a946d6378720a5a8cccec7e892328d539cb4eff16aa2d4cd3ee23c2e722::pudgy {
    struct PUDGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUDGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUDGY>(arg0, 9, b"PUDGY", b"Pudgy", b"HODL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x98ac47203bbbf86623ab1bd020458154fd2fb84a.png?size=xl&key=bde898")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUDGY>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUDGY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUDGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

