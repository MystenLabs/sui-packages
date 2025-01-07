module 0x8cd8a3f5ca27d768cbdd0f41653a77fd6c922ed907aa3298b67072a148f94a74::nelly {
    struct NELLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NELLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NELLY>(arg0, 6, b"NELLY", b"Discord's 404 Mascot", b"Nelly, the Robot Hamster on SUI! | Discord's 404 Page Mascot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nellypfp_7c698f7a8c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NELLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NELLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

