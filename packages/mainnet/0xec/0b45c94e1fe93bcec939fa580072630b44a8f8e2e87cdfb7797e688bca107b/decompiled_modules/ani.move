module 0xec0b45c94e1fe93bcec939fa580072630b44a8f8e2e87cdfb7797e688bca107b::ani {
    struct ANI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANI>(arg0, 6, b"Ani", b"Ani Grok Companion", x"416e6920697320596f75722041492047726f6b20436f6d70616e696f6e206f6e2053554920426c6f636b636861696e200a54686520667574757265206f662063727970746f2067756964616e63652c20706f776572656420627920696e74656c6c6967656e636520616e6420696e74756974696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihsvrnqrlgr7wlsqdydlceyt7ovm3caqkzv6jlecftax6653vsvbu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ANI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

