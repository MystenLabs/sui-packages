module 0x86205e4fb9c637173c9037b46b316a52b57d50580c370f3d66e28300bfcf34c::sunk {
    struct SUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNK>(arg0, 6, b"Sunk", b"SUI HONK", x"486920496d2061202473754e4b20616e6420496d20612066697273740a0a676f6f7365206f6e204d6f766570756d702e0a0a4974277320676f6f73652074696d6521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20241009_104322_Chrome_c1549dc04a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

