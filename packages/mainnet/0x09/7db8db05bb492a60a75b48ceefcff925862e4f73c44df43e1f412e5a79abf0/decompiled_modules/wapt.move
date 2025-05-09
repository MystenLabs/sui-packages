module 0x97db8db05bb492a60a75b48ceefcff925862e4f73c44df43e1f412e5a79abf0::wapt {
    struct WAPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAPT>(arg0, 9, b"WAPT", b"Wrapped APT", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAPT>>(v1);
        0x2::coin::mint_and_transfer<WAPT>(&mut v2, 1000000000000000000, @0xb289d1bd5a39d618373f68cedbf06a594484d33f84e57360d8b1c7f2cc4e596e, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAPT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

