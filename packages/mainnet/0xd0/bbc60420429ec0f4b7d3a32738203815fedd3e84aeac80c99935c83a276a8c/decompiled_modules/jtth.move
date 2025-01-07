module 0xd0bbc60420429ec0f4b7d3a32738203815fedd3e84aeac80c99935c83a276a8c::jtth {
    struct JTTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: JTTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JTTH>(arg0, 6, b"JTTH", b"Journey To The Hell", b"Congratulations on dying! Embark on your Journey to the HELL!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_fc529f05f1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JTTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JTTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

