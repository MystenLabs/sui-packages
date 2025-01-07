module 0xd7a878e96acde67eb3c546f3665228c9ec5f5479ac8d529e92bbe446ba1bde8f::trumpforce {
    struct TRUMPFORCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPFORCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPFORCE>(arg0, 6, b"TRUMPFORCE", b"TRUMP FORCE", x"4d616b6520416d657269636120477265617420416761696e20616e64204d616b652042756c6c72756e20676967616e74696320616761696e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gakrr_Z_a_UA_Ah_Pk_J_72a4688c68.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPFORCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPFORCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

