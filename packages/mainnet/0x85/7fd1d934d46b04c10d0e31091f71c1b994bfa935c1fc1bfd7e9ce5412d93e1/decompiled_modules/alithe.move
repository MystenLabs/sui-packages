module 0x857fd1d934d46b04c10d0e31091f71c1b994bfa935c1fc1bfd7e9ce5412d93e1::alithe {
    struct ALITHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALITHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALITHE>(arg0, 6, b"ALITHE", b"Alithea Genomics", b"Alithea Genomics altered SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihllosq6aeduz5duvf3fu5vs434gfocxi3xk7kkjrifbpnwyjifue")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALITHE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ALITHE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

