module 0xbb79a8effe822eb299b9c5b1b2f2eb81024dc9891321cf834f7c9fe05a8abcd6::cult {
    struct CULT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CULT>(arg0, 9, b"CULT", b"Milady Cult Coin", b"Milady world order // Cult coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x0000000000c5dc95539589fbd24be07c6c14eca4.png?size=xl&key=d87f22")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CULT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<CULT>>(0x2::coin::mint<CULT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CULT>>(v2);
    }

    // decompiled from Move bytecode v6
}

