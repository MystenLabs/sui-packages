module 0xfa84e2d0d3d69109c5c53b6a47678cc13c87e378f13de81a7bf1b84d9f136a84::aeaeae {
    struct AEAEAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AEAEAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AEAEAE>(arg0, 6, b"AEaeae", b"aeae", b"Aaea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ADA_6_992b30e869.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AEAEAE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AEAEAE>>(v1);
    }

    // decompiled from Move bytecode v6
}

