module 0xc810e0f3a5b1d58efafaf1baa0e0b984a19aeb5d67077a0a3f5ba081addc4e0c::peeno {
    struct PEENO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEENO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEENO>(arg0, 6, b"PEENO", b"Peeno on SUI", b"Welcome to $PEENO - the sexiest most alpha male on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_XB_1_M9_Iq_400x400_9a4fe3c67d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEENO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEENO>>(v1);
    }

    // decompiled from Move bytecode v6
}

