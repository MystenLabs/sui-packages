module 0x6f3cebaba54c0f5d6c44eccd0b91a5683a42afc354a762be67aeab1133e68578::sch {
    struct SCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCH>(arg0, 6, b"SCH", b"Sui Chicken Horse", b"the first decentralized coin on SUI, the prestigious Sui Chicken Horse.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/waterchicken_e50982e161.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

