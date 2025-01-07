module 0x9a0ef1f810d2fbe358766307c57f8069c2907c955004a2efc23ef17f722e329::zz000 {
    struct ZZ000 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZZ000, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZZ000>(arg0, 6, b"Z0SUI", b"ZZ000", b"We fly with SUI to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/x03tHMl.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZZ000>>(v1);
        0x2::coin::mint_and_transfer<ZZ000>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZZ000>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun reounceownership(arg0: 0x2::coin::TreasuryCap<ZZ000>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZZ000>>(arg0, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v6
}

