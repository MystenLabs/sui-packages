module 0xceb0f5b3b0c91080e42194d2999a7433823b94b4bfe9f1444738273946a4d936::dopi {
    struct DOPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOPI>(arg0, 6, b"DOPI", b"Dopi", b"Dopi is designed to create opportunities within the blockchain ecosystem. Our mission is to build a dynamic community where every member can interact, contribute, and grow together. We prioritize value growth and innovation, aiming to make Dopi a sig", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730969560769.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOPI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOPI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

