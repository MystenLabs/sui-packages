module 0x64b8c05c20219feb4d6e38ce59bb2b8ab89897de48fcfdf681a0b0c59359f031::snelly {
    struct SNELLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNELLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNELLY>(arg0, 6, b"SNELLY", b"SUI NELLY", b"Nelly the Robot Hamster on Sui! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x8cd8a3f5ca27d768cbdd0f41653a77fd6c922ed907aa3298b67072a148f94a74_nelly_nelly_6d066dd06c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNELLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNELLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

