module 0x70f723c6b6cffd1f0e78a138e53842c943d4510d7f3e41d4f5530c18aa827e5e::maltese {
    struct MALTESE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MALTESE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MALTESE>(arg0, 6, b"MALTESE", b"MALTESE DOG FRIENDS", x"41424f55540a476f7420612070726f626c656d3f204e6f2070726f626c656d212054686579206c6f766520736f6c76696e67206f6e652070726f626c656d20616674657220616e6f746865722e20546f2061204d616c746573652c2065766572797468696e6720697320706f737369626c6521205468657920686176652074686520706f77657220746f207475726e20626164207468696e677320696e746f20676f6f64207468696e67732c20616e642074686579206861766520746865206162696c69747920746f2073617665207468652064617920616c6c206279207468656d73656c7665732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3571_a5460932e9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MALTESE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MALTESE>>(v1);
    }

    // decompiled from Move bytecode v6
}

