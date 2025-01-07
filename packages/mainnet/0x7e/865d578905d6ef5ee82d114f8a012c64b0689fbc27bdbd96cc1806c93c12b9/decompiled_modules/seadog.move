module 0x7e865d578905d6ef5ee82d114f8a012c64b0689fbc27bdbd96cc1806c93c12b9::seadog {
    struct SEADOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEADOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEADOG>(arg0, 6, b"SEADOG", b"SEADOG CAPTAIN", b"EVERY CHAIN NEED DOG, SEADOG IS CAPTAIN ON SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CBB_2_B146_DCD_7_455_C_BEE_6_C884_FD_93_FB_9_C_b008530c1f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEADOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEADOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

