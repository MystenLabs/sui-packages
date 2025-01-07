module 0xec0112aff476fbd14e19daf09683be0d15357e14b21ef0e4b87871637c7b8e51::binu {
    struct BINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BINU>(arg0, 6, b"BINU", b"Blub inu", b"I'm Blub inu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e_e_1_removebg_preview_4_b9d5b130b6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

