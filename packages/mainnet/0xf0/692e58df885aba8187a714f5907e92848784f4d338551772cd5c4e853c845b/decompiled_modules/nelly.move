module 0xf0692e58df885aba8187a714f5907e92848784f4d338551772cd5c4e853c845b::nelly {
    struct NELLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NELLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NELLY>(arg0, 6, b"NELLY", b"NELLYOnSui", b"An Homage to Discords 404 Page Mascot, Nelly the Robot Hamster on Sui! | ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nely_5691861b78.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NELLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NELLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

