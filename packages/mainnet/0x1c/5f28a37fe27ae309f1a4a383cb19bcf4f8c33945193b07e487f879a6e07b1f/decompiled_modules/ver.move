module 0x1c5f28a37fe27ae309f1a4a383cb19bcf4f8c33945193b07e487f879a6e07b1f::ver {
    struct VER has drop {
        dummy_field: bool,
    }

    fun init(arg0: VER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VER>(arg0, 9, b"VER", b"VerifyToken", b"A token for verifying transactions", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VER>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VER>>(v1);
    }

    // decompiled from Move bytecode v6
}

