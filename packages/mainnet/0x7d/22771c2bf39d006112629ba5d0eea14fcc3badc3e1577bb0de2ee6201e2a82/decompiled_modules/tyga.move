module 0x7d22771c2bf39d006112629ba5d0eea14fcc3badc3e1577bb0de2ee6201e2a82::tyga {
    struct TYGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYGA>(arg0, 9, b"TYGA", b"TYGA ON SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmSt89rm6NJTWt5yd1UQNs5AW85LYfpcDk4uTXsffdCheY")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TYGA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TYGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYGA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

