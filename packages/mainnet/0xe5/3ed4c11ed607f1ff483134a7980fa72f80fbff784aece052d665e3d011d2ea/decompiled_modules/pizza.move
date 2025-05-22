module 0xe53ed4c11ed607f1ff483134a7980fa72f80fbff784aece052d665e3d011d2ea::pizza {
    struct PIZZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIZZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIZZA>(arg0, 6, b"PIZZA", b"Sui Pizza", b"The most expensive pizza token on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih6o7tm2lwlmrcjqm4yn5e5m2ng456kk63sah3kr3mtsa5li6gove")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIZZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PIZZA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

