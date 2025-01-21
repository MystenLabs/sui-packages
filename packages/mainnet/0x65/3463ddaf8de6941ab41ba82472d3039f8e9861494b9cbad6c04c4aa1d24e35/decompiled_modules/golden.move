module 0x653463ddaf8de6941ab41ba82472d3039f8e9861494b9cbad6c04c4aa1d24e35::golden {
    struct GOLDEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDEN>(arg0, 9, b"GOLDEN", b"The Golden Age Of America", x"54686520476f6c64656e20416765204f6620416d65726963610d0a0d0a24474f4c44454e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVXbF4VNjsrZVeCWioybijKxphHiY7XwDAFfgeC1sHvuu")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOLDEN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOLDEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDEN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

