module 0x4e8d69a0128c180083ac535be74b6ac835d4e54c05fe156398975ca149db4120::hippo {
    struct HIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"nsudeng";
        0x1::vector::remove<u8>(&mut v0, 0);
        let v1 = b"dhippo sudeng";
        0x1::vector::remove<u8>(&mut v1, 0);
        let (v2, v3) = 0x2::coin::create_currency<HIPPO>(arg0, 6, b"HIPPO", v0, v1, 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suidot.fun/i/Ks6OcXTxF9y241Tt")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIPPO>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

