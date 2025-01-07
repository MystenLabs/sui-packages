module 0x5eb8cd1f96bd17487ac27b32fdd309992f830d30fe8c02e84af7d6814d46a48f::moo {
    struct MOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOO>(arg0, 6, b"MOO", b"CRASH COW", x"546865206e657874204d6f6f6f206d657461206f6e205355490a0a496e7370697265642062792043727970746f73206361736820636f772043726173680a0a5468652077617272656e20627566666574206f66204d656d6520636f696e73", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/at_A92c_MY_400x400_e45ecce1c1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

