module 0x849193484978928e093a53f2182e16613cac99bdd8360a0c2500a6cc3f7077ed::mew {
    struct MEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEW>(arg0, 6, b"MEW", b"Mewo Woof", b"Look no further, the MEW Pack is here! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/S30m1_RHD_400x400_261c82ec87.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

