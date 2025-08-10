module 0x3108c59cd85aac6754f58358401ab3d7e1ced09dd57f13908c3db3dda3a0a2da::suissy {
    struct SUISSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISSY>(arg0, 6, b"SUISSY", b"Suissy Sui", b"Easy lies that head that wears the crown", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiebjc54egvjhnmhs2pbnd6nulxalblvw2ruc3jqrcr43dndaakui4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUISSY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

