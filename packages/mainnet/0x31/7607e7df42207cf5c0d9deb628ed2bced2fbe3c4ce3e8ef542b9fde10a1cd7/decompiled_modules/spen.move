module 0x317607e7df42207cf5c0d9deb628ed2bced2fbe3c4ce3e8ef542b9fde10a1cd7::spen {
    struct SPEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEN>(arg0, 6, b"SPEN", b"SUIPEN", x"546865206375746573742070656e6775696e20696e205375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ik_D1_HWE_400x400_c6ac648d33.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

