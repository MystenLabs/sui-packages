module 0xc7abb16fc1c0460940ca9e5daca5fa2b13eb4296393d0538d7a5a23c042eec27::smind {
    struct SMIND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMIND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMIND>(arg0, 6, b"SMIND", b"Sui MEGAMIND", b"Sui MEGAMIND: A genius-level crypto project on the SUI blockchain, blending intelligence, innovation, and community-driven growth!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/w_Ei_sg_W6_400x400_08e9c3d740.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMIND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMIND>>(v1);
    }

    // decompiled from Move bytecode v6
}

