module 0xc464e3f1f23b98db246dbe28c3ce7c0d34b74df438ce775abe2e2875910b70f1::suiroot {
    struct SUIROOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIROOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIROOT>(arg0, 6, b"SUIROOT", b"Rtardio - Rootlets", x"4375746520637265617475726573206861766520636f6d652066726f6d2074686520537569766572736520746f20636f6c6f6e697a6520456172746821204765742072656164792c206c657473207274210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Rootlets_812a2b6180_ea4cbb428d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIROOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIROOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

