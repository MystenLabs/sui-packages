module 0x1f15745085e603033704b3c2c262f78b95ac27fe2ac3508e04afe881afd2a492::omni {
    struct OMNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OMNI>(arg0, 6, b"OMNI", b"omni AI Agent Model Language", b"Empowering the Web3 revolution | Building decentralized solutions for a connected future  | Blockchain, AI, and Innovation at the core  | Join us on the frontier of technology!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3b0y_EEOY_400x400_1_e6add6b9ab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMNI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OMNI>>(v1);
    }

    // decompiled from Move bytecode v6
}

