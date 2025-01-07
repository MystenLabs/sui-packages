module 0x5d5c60685bd24cf581830b2d4dc47944ad0b3f772fb1d2bf6601015444c29134::claw {
    struct CLAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAW>(arg0, 6, b"CLAW", b"Clawverine on SUI", b"Hey, Bub! I'm Clawverine, the fearless feline defender of the SUI universe! My diamond claws shine bright as I prowl through the blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/F0i_RCXB_3_400x400_5c85aa9e57.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

